.class public Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;
.super Ljava/lang/Object;
.source "Stax2EventWriterImpl.java"

# interfaces
.implements Ljavax/xml/stream/XMLEventWriter;
.implements Ljavax/xml/stream/XMLStreamConstants;


# instance fields
.field protected final _writer:Lorg/codehaus/stax2/XMLStreamWriter2;


# direct methods
.method public constructor <init>(Lorg/codehaus/stax2/XMLStreamWriter2;)V
    .locals 0
    .param p1, "sw"    # Lorg/codehaus/stax2/XMLStreamWriter2;

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    iput-object p1, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    .line 31
    return-void
.end method


# virtual methods
.method public add(Ljavax/xml/stream/XMLEventReader;)V
    .locals 1
    .param p1, "reader"    # Ljavax/xml/stream/XMLEventReader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 172
    nop

    :goto_0
    invoke-interface {p1}, Ljavax/xml/stream/XMLEventReader;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 173
    invoke-interface {p1}, Ljavax/xml/stream/XMLEventReader;->nextEvent()Ljavax/xml/stream/events/XMLEvent;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->add(Ljavax/xml/stream/events/XMLEvent;)V

    goto :goto_0

    .line 175
    :cond_0
    return-void
.end method

.method public add(Ljavax/xml/stream/events/XMLEvent;)V
    .locals 7
    .param p1, "event"    # Ljavax/xml/stream/events/XMLEvent;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 52
    invoke-interface {p1}, Ljavax/xml/stream/events/XMLEvent;->getEventType()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 159
    :pswitch_0
    instance-of v0, p1, Lorg/codehaus/stax2/evt/XMLEvent2;

    if-eqz v0, :cond_4

    .line 160
    move-object v0, p1

    check-cast v0, Lorg/codehaus/stax2/evt/XMLEvent2;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, v1}, Lorg/codehaus/stax2/evt/XMLEvent2;->writeUsing(Lorg/codehaus/stax2/XMLStreamWriter2;)V

    goto/16 :goto_4

    .line 76
    :pswitch_1
    move-object v0, p1

    check-cast v0, Ljavax/xml/stream/events/Namespace;

    .line 77
    .local v0, "ns":Ljavax/xml/stream/events/Namespace;
    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0}, Ljavax/xml/stream/events/Namespace;->getPrefix()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0}, Ljavax/xml/stream/events/Namespace;->getNamespaceURI()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeNamespace(Ljava/lang/String;Ljava/lang/String;)V

    .line 79
    .end local v0    # "ns":Ljavax/xml/stream/events/Namespace;
    goto/16 :goto_4

    .line 131
    :pswitch_2
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {p1}, Ljavax/xml/stream/events/XMLEvent;->asCharacters()Ljavax/xml/stream/events/Characters;

    move-result-object v1

    invoke-interface {v1}, Ljavax/xml/stream/events/Characters;->getData()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeCData(Ljava/lang/String;)V

    .line 132
    goto/16 :goto_4

    .line 139
    :pswitch_3
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    move-object v1, p1

    check-cast v1, Ljavax/xml/stream/events/DTD;

    invoke-interface {v1}, Ljavax/xml/stream/events/DTD;->getDocumentTypeDeclaration()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeDTD(Ljava/lang/String;)V

    .line 140
    goto/16 :goto_4

    .line 59
    :pswitch_4
    move-object v0, p1

    check-cast v0, Ljavax/xml/stream/events/Attribute;

    .line 60
    .local v0, "attr":Ljavax/xml/stream/events/Attribute;
    invoke-interface {v0}, Ljavax/xml/stream/events/Attribute;->getName()Ljavax/xml/namespace/QName;

    move-result-object v1

    .line 61
    .local v1, "name":Ljavax/xml/namespace/QName;
    iget-object v2, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-virtual {v1}, Ljavax/xml/namespace/QName;->getPrefix()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1}, Ljavax/xml/namespace/QName;->getNamespaceURI()Ljava/lang/String;

    move-result-object v4

    .line 62
    invoke-virtual {v1}, Ljavax/xml/namespace/QName;->getLocalPart()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v0}, Ljavax/xml/stream/events/Attribute;->getValue()Ljava/lang/String;

    move-result-object v6

    .line 61
    invoke-interface {v2, v3, v4, v5, v6}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 64
    .end local v0    # "attr":Ljavax/xml/stream/events/Attribute;
    .end local v1    # "name":Ljavax/xml/namespace/QName;
    goto/16 :goto_4

    .line 143
    :pswitch_5
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    move-object v1, p1

    check-cast v1, Ljavax/xml/stream/events/EntityReference;

    invoke-interface {v1}, Ljavax/xml/stream/events/EntityReference;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeEntityRef(Ljava/lang/String;)V

    .line 144
    goto/16 :goto_4

    .line 67
    :pswitch_6
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeEndDocument()V

    .line 68
    goto/16 :goto_4

    .line 83
    :pswitch_7
    move-object v0, p1

    check-cast v0, Ljavax/xml/stream/events/StartDocument;

    .line 84
    .local v0, "sd":Ljavax/xml/stream/events/StartDocument;
    invoke-interface {v0}, Ljavax/xml/stream/events/StartDocument;->encodingSet()Z

    move-result v1

    if-nez v1, :cond_0

    .line 85
    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0}, Ljavax/xml/stream/events/StartDocument;->getVersion()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeStartDocument(Ljava/lang/String;)V

    goto :goto_0

    .line 87
    :cond_0
    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0}, Ljavax/xml/stream/events/StartDocument;->getCharacterEncodingScheme()Ljava/lang/String;

    move-result-object v2

    .line 88
    invoke-interface {v0}, Ljavax/xml/stream/events/StartDocument;->getVersion()Ljava/lang/String;

    move-result-object v3

    .line 87
    invoke-interface {v1, v2, v3}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeStartDocument(Ljava/lang/String;Ljava/lang/String;)V

    .line 91
    .end local v0    # "sd":Ljavax/xml/stream/events/StartDocument;
    :goto_0
    goto/16 :goto_4

    .line 135
    :pswitch_8
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    move-object v1, p1

    check-cast v1, Ljavax/xml/stream/events/Comment;

    invoke-interface {v1}, Ljavax/xml/stream/events/Comment;->getText()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeComment(Ljava/lang/String;)V

    .line 136
    goto/16 :goto_4

    .line 120
    :pswitch_9
    invoke-interface {p1}, Ljavax/xml/stream/events/XMLEvent;->asCharacters()Ljavax/xml/stream/events/Characters;

    move-result-object v0

    .line 121
    .local v0, "ch":Ljavax/xml/stream/events/Characters;
    invoke-interface {v0}, Ljavax/xml/stream/events/Characters;->getData()Ljava/lang/String;

    move-result-object v1

    .line 122
    .local v1, "text":Ljava/lang/String;
    invoke-interface {v0}, Ljavax/xml/stream/events/Characters;->isCData()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 123
    iget-object v2, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v2, v1}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeCData(Ljava/lang/String;)V

    goto :goto_1

    .line 125
    :cond_1
    iget-object v2, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v2, v1}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeCharacters(Ljava/lang/String;)V

    .line 128
    .end local v0    # "ch":Ljavax/xml/stream/events/Characters;
    .end local v1    # "text":Ljava/lang/String;
    :goto_1
    goto :goto_4

    .line 148
    :pswitch_a
    move-object v0, p1

    check-cast v0, Ljavax/xml/stream/events/ProcessingInstruction;

    .line 149
    .local v0, "pi":Ljavax/xml/stream/events/ProcessingInstruction;
    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0}, Ljavax/xml/stream/events/ProcessingInstruction;->getTarget()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0}, Ljavax/xml/stream/events/ProcessingInstruction;->getData()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeProcessingInstruction(Ljava/lang/String;Ljava/lang/String;)V

    .line 151
    .end local v0    # "pi":Ljavax/xml/stream/events/ProcessingInstruction;
    goto :goto_4

    .line 71
    :pswitch_b
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeEndElement()V

    .line 72
    goto :goto_4

    .line 96
    :pswitch_c
    invoke-interface {p1}, Ljavax/xml/stream/events/XMLEvent;->asStartElement()Ljavax/xml/stream/events/StartElement;

    move-result-object v0

    .line 97
    .local v0, "se":Ljavax/xml/stream/events/StartElement;
    invoke-interface {v0}, Ljavax/xml/stream/events/StartElement;->getName()Ljavax/xml/namespace/QName;

    move-result-object v1

    .line 98
    .local v1, "n":Ljavax/xml/namespace/QName;
    iget-object v2, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-virtual {v1}, Ljavax/xml/namespace/QName;->getPrefix()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1}, Ljavax/xml/namespace/QName;->getLocalPart()Ljava/lang/String;

    move-result-object v4

    .line 99
    invoke-virtual {v1}, Ljavax/xml/namespace/QName;->getNamespaceURI()Ljava/lang/String;

    move-result-object v5

    .line 98
    invoke-interface {v2, v3, v4, v5}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeStartElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 100
    invoke-interface {v0}, Ljavax/xml/stream/events/StartElement;->getNamespaces()Ljava/util/Iterator;

    move-result-object v2

    .line 101
    .local v2, "it":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    :goto_2
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    .line 102
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljavax/xml/stream/events/Namespace;

    .line 103
    .local v3, "ns":Ljavax/xml/stream/events/Namespace;
    invoke-virtual {p0, v3}, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->add(Ljavax/xml/stream/events/XMLEvent;)V

    .line 104
    .end local v3    # "ns":Ljavax/xml/stream/events/Namespace;
    goto :goto_2

    .line 105
    :cond_2
    invoke-interface {v0}, Ljavax/xml/stream/events/StartElement;->getAttributes()Ljava/util/Iterator;

    move-result-object v2

    .line 106
    :goto_3
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    .line 107
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljavax/xml/stream/events/Attribute;

    .line 108
    .local v3, "attr":Ljavax/xml/stream/events/Attribute;
    invoke-virtual {p0, v3}, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->add(Ljavax/xml/stream/events/XMLEvent;)V

    .line 109
    .end local v3    # "attr":Ljavax/xml/stream/events/Attribute;
    goto :goto_3

    .line 111
    .end local v0    # "se":Ljavax/xml/stream/events/StartElement;
    .end local v1    # "n":Ljavax/xml/namespace/QName;
    .end local v2    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    :cond_3
    nop

    .line 166
    :goto_4
    return-void

    .line 163
    :cond_4
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Don\'t know how to output event "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_0
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method public close()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 181
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamWriter2;->close()V

    .line 182
    return-void
.end method

.method public flush()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 188
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamWriter2;->flush()V

    .line 189
    return-void
.end method

.method public getNamespaceContext()Ljavax/xml/namespace/NamespaceContext;
    .locals 1

    .line 193
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamWriter2;->getNamespaceContext()Ljavax/xml/namespace/NamespaceContext;

    move-result-object v0

    return-object v0
.end method

.method public getPrefix(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "uri"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 200
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamWriter2;->getPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public setDefaultNamespace(Ljava/lang/String;)V
    .locals 1
    .param p1, "uri"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 207
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamWriter2;->setDefaultNamespace(Ljava/lang/String;)V

    .line 208
    return-void
.end method

.method public setNamespaceContext(Ljavax/xml/namespace/NamespaceContext;)V
    .locals 1
    .param p1, "ctxt"    # Ljavax/xml/namespace/NamespaceContext;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 214
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamWriter2;->setNamespaceContext(Ljavax/xml/namespace/NamespaceContext;)V

    .line 215
    return-void
.end method

.method public setPrefix(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "uri"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 221
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2EventWriterImpl;->_writer:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2}, Lorg/codehaus/stax2/XMLStreamWriter2;->setPrefix(Ljava/lang/String;Ljava/lang/String;)V

    .line 222
    return-void
.end method
