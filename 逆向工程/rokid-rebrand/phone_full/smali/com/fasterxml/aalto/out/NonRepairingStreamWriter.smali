.class public final Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;
.super Lcom/fasterxml/aalto/out/StreamWriterBase;
.source "NonRepairingStreamWriter.java"


# direct methods
.method public constructor <init>(Lcom/fasterxml/aalto/out/WriterConfig;Lcom/fasterxml/aalto/out/XmlWriter;Lcom/fasterxml/aalto/out/WNameTable;)V
    .locals 0
    .param p1, "cfg"    # Lcom/fasterxml/aalto/out/WriterConfig;
    .param p2, "writer"    # Lcom/fasterxml/aalto/out/XmlWriter;
    .param p3, "symbols"    # Lcom/fasterxml/aalto/out/WNameTable;

    .line 41
    invoke-direct {p0, p1, p2, p3}, Lcom/fasterxml/aalto/out/StreamWriterBase;-><init>(Lcom/fasterxml/aalto/out/WriterConfig;Lcom/fasterxml/aalto/out/XmlWriter;Lcom/fasterxml/aalto/out/WNameTable;)V

    .line 42
    return-void
.end method


# virtual methods
.method protected _serializeQName(Ljavax/xml/namespace/QName;)Ljava/lang/String;
    .locals 4
    .param p1, "name"    # Ljavax/xml/namespace/QName;

    .line 226
    invoke-virtual {p1}, Ljavax/xml/namespace/QName;->getPrefix()Ljava/lang/String;

    move-result-object v0

    .line 227
    .local v0, "prefix":Ljava/lang/String;
    invoke-virtual {p1}, Ljavax/xml/namespace/QName;->getLocalPart()Ljava/lang/String;

    move-result-object v1

    .line 228
    .local v1, "local":Ljava/lang/String;
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_0

    goto :goto_0

    .line 232
    :cond_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ":"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 229
    :cond_1
    :goto_0
    return-object v1
.end method

.method public _setPrefix(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "uri"    # Ljava/lang/String;

    .line 60
    iget-object v0, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/out/OutputElement;->addPrefix(Ljava/lang/String;Ljava/lang/String;)V

    .line 61
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

    .line 54
    iget-object v0, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/OutputElement;->setDefaultNsURI(Ljava/lang/String;)V

    .line 55
    return-void
.end method

.method public writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "nsURI"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .param p3, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 69
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_stateStartElementOpen:Z

    if-nez v0, :cond_0

    .line 70
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_ATTR_NO_ELEM:Ljava/lang/String;

    invoke-static {v0}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->throwOutputError(Ljava/lang/String;)V

    .line 73
    :cond_0
    if-eqz p1, :cond_3

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    .line 76
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    iget-object v1, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    invoke-virtual {v0, p1, v1}, Lcom/fasterxml/aalto/out/OutputElement;->getExplicitPrefix(Ljava/lang/String;Ljavax/xml/namespace/NamespaceContext;)Ljava/lang/String;

    move-result-object v0

    .line 77
    .local v0, "prefix":Ljava/lang/String;
    if-nez v0, :cond_2

    .line 78
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unbound namespace URI \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->throwOutputError(Ljava/lang/String;)V

    .line 80
    :cond_2
    iget-object v1, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v1, v0, p2}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v1

    .local v1, "name":Lcom/fasterxml/aalto/out/WName;
    goto :goto_1

    .line 74
    .end local v0    # "prefix":Ljava/lang/String;
    .end local v1    # "name":Lcom/fasterxml/aalto/out/WName;
    :cond_3
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v0, p2}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v1

    .line 82
    .restart local v1    # "name":Lcom/fasterxml/aalto/out/WName;
    :goto_1
    invoke-virtual {p0, v1, p3}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_writeAttribute(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)V

    .line 83
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

    .line 90
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_stateStartElementOpen:Z

    if-nez v0, :cond_0

    .line 91
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_ATTR_NO_ELEM:Ljava/lang/String;

    invoke-static {v0}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->throwOutputError(Ljava/lang/String;)V

    .line 93
    :cond_0
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    .line 94
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    .line 95
    invoke-virtual {v0, p1, p3}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    goto :goto_1

    .line 93
    :cond_2
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    .line 94
    invoke-virtual {v0, p3}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    .line 95
    :goto_1
    nop

    .line 96
    .local v0, "name":Lcom/fasterxml/aalto/out/WName;
    invoke-virtual {p0, v0, p4}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_writeAttribute(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)V

    .line 97
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

    .line 103
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_stateStartElementOpen:Z

    if-nez v0, :cond_0

    .line 104
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_NS_NO_ELEM:Ljava/lang/String;

    invoke-static {v0}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->throwOutputError(Ljava/lang/String;)V

    .line 106
    :cond_0
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_writeDefaultNamespace(Ljava/lang/String;)V

    .line 110
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->setDefaultNamespace(Ljava/lang/String;)V

    .line 111
    return-void
.end method

.method public writeEmptyElement(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "nsURI"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 121
    iget-object v0, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/OutputElement;->getPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 122
    .local v0, "prefix":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 123
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unbound namespace URI \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->throwOutputError(Ljava/lang/String;)V

    .line 126
    :cond_0
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    .line 127
    iget-object v1, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v1, p2}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v1

    .line 128
    .local v1, "name":Lcom/fasterxml/aalto/out/WName;
    const/4 v0, 0x0

    goto :goto_0

    .line 130
    .end local v1    # "name":Lcom/fasterxml/aalto/out/WName;
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v1, v0, p2}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v1

    .line 132
    .restart local v1    # "name":Lcom/fasterxml/aalto/out/WName;
    :goto_0
    invoke-virtual {p0, v0, p2}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_verifyStartElement(Ljava/lang/String;Ljava/lang/String;)V

    .line 133
    const/4 v2, 0x1

    invoke-virtual {p0, v1, v2, p1}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_writeStartTag(Lcom/fasterxml/aalto/out/WName;ZLjava/lang/String;)V

    .line 134
    return-void
.end method

.method public writeEmptyElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .param p3, "nsURI"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 140
    invoke-virtual {p0, p1, p2}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_verifyStartElement(Ljava/lang/String;Ljava/lang/String;)V

    .line 142
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 145
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    .local v0, "name":Lcom/fasterxml/aalto/out/WName;
    goto :goto_1

    .line 143
    .end local v0    # "name":Lcom/fasterxml/aalto/out/WName;
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v0, p2}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    .line 147
    .restart local v0    # "name":Lcom/fasterxml/aalto/out/WName;
    :goto_1
    const/4 v1, 0x1

    invoke-virtual {p0, v0, v1, p3}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_writeStartTag(Lcom/fasterxml/aalto/out/WName;ZLjava/lang/String;)V

    .line 148
    return-void
.end method

.method public writeNamespace(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 154
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 158
    :cond_0
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_stateStartElementOpen:Z

    if-nez v0, :cond_1

    .line 159
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_NS_NO_ELEM:Ljava/lang/String;

    invoke-static {v0}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->throwOutputError(Ljava/lang/String;)V

    .line 161
    :cond_1
    invoke-virtual {p0, p1, p2}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_writeNamespace(Ljava/lang/String;Ljava/lang/String;)V

    .line 164
    invoke-virtual {p0, p1, p2}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->setPrefix(Ljava/lang/String;Ljava/lang/String;)V

    .line 165
    return-void

    .line 155
    :cond_2
    :goto_0
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->writeDefaultNamespace(Ljava/lang/String;)V

    .line 156
    return-void
.end method

.method public writeStartElement(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "nsURI"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 173
    iget-object v0, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_currElem:Lcom/fasterxml/aalto/out/OutputElement;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/OutputElement;->getPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 174
    .local v0, "prefix":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 175
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unbound namespace URI \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->throwOutputError(Ljava/lang/String;)V

    .line 178
    :cond_0
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    .line 179
    iget-object v1, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v1, p2}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v1

    .line 180
    .local v1, "name":Lcom/fasterxml/aalto/out/WName;
    const/4 v0, 0x0

    goto :goto_0

    .line 182
    .end local v1    # "name":Lcom/fasterxml/aalto/out/WName;
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v1, v0, p2}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v1

    .line 184
    .restart local v1    # "name":Lcom/fasterxml/aalto/out/WName;
    :goto_0
    invoke-virtual {p0, v0, p2}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_verifyStartElement(Ljava/lang/String;Ljava/lang/String;)V

    .line 185
    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_writeStartTag(Lcom/fasterxml/aalto/out/WName;Z)V

    .line 186
    return-void
.end method

.method public writeStartElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .param p3, "nsURI"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 193
    invoke-virtual {p0, p1, p2}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_verifyStartElement(Ljava/lang/String;Ljava/lang/String;)V

    .line 195
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 198
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    .local v0, "name":Lcom/fasterxml/aalto/out/WName;
    goto :goto_1

    .line 196
    .end local v0    # "name":Lcom/fasterxml/aalto/out/WName;
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v0, p2}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    .line 200
    .restart local v0    # "name":Lcom/fasterxml/aalto/out/WName;
    :goto_1
    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1, p3}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_writeStartTag(Lcom/fasterxml/aalto/out/WName;ZLjava/lang/String;)V

    .line 201
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

    .line 214
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_stateStartElementOpen:Z

    if-nez v0, :cond_0

    .line 215
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_ATTR_NO_ELEM:Ljava/lang/String;

    invoke-static {v0}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->throwOutputError(Ljava/lang/String;)V

    .line 217
    :cond_0
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    .line 218
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    .line 219
    invoke-virtual {v0, p1, p3}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    goto :goto_1

    .line 217
    :cond_2
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_symbols:Lcom/fasterxml/aalto/out/WNameTable;

    .line 218
    invoke-virtual {v0, p3}, Lcom/fasterxml/aalto/out/WNameTable;->findSymbol(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    .line 219
    :goto_1
    nop

    .line 220
    .local v0, "name":Lcom/fasterxml/aalto/out/WName;
    invoke-virtual {p0, v0, p4}, Lcom/fasterxml/aalto/out/NonRepairingStreamWriter;->_writeAttribute(Lcom/fasterxml/aalto/out/WName;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 221
    return-void
.end method
