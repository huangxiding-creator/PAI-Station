.class public abstract Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;
.super Ljava/lang/Object;
.source "DOMWrappingWriter.java"

# interfaces
.implements Lorg/codehaus/stax2/XMLStreamWriter2;


# static fields
.field static final DEFAULT_OUTPUT_ENCODING:Ljava/lang/String; = "UTF-8"

.field static final DEFAULT_XML_VERSION:Ljava/lang/String; = "1.0"


# instance fields
.field protected final mDocument:Lorg/w3c/dom/Document;

.field protected mEncoding:Ljava/lang/String;

.field protected final mNsAware:Z

.field protected mNsContext:Ljavax/xml/namespace/NamespaceContext;

.field protected final mNsRepairing:Z

.field protected mValueEncoder:Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;


# direct methods
.method protected constructor <init>(Lorg/w3c/dom/Node;ZZ)V
    .locals 3
    .param p1, "treeRoot"    # Lorg/w3c/dom/Node;
    .param p2, "nsAware"    # Z
    .param p3, "nsRepairing"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 119
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 79
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->mEncoding:Ljava/lang/String;

    .line 120
    if-eqz p1, :cond_1

    .line 123
    iput-boolean p2, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->mNsAware:Z

    .line 124
    iput-boolean p3, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->mNsRepairing:Z

    .line 129
    invoke-interface {p1}, Lorg/w3c/dom/Node;->getNodeType()S

    move-result v0

    sparse-switch v0, :sswitch_data_0

    .line 148
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Can not create an XMLStreamWriter for a DOM node of type "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 143
    :sswitch_0
    invoke-interface {p1}, Lorg/w3c/dom/Node;->getOwnerDocument()Lorg/w3c/dom/Document;

    move-result-object v0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->mDocument:Lorg/w3c/dom/Document;

    .line 145
    goto :goto_0

    .line 131
    :sswitch_1
    move-object v0, p1

    check-cast v0, Lorg/w3c/dom/Document;

    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->mDocument:Lorg/w3c/dom/Document;

    .line 136
    goto :goto_0

    .line 139
    :sswitch_2
    invoke-interface {p1}, Lorg/w3c/dom/Node;->getOwnerDocument()Lorg/w3c/dom/Document;

    move-result-object v0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->mDocument:Lorg/w3c/dom/Document;

    .line 140
    nop

    .line 150
    :goto_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->mDocument:Lorg/w3c/dom/Document;

    if-eqz v0, :cond_0

    .line 153
    return-void

    .line 151
    :cond_0
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Can not create an XMLStreamWriter for given node (of type "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "): did not have owner document"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 121
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Can not pass null Node for constructing a DOM-based XMLStreamWriter"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_2
        0x9 -> :sswitch_1
        0xb -> :sswitch_0
    .end sparse-switch
.end method

.method protected static throwOutputError(Ljava/lang/String;)V
    .locals 1
    .param p0, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 727
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    invoke-direct {v0, p0}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected static throwOutputError(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1
    .param p0, "format"    # Ljava/lang/String;
    .param p1, "arg"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 733
    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {p0, v0}, Ljava/text/MessageFormat;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 734
    .local v0, "msg":Ljava/lang/String;
    invoke-static {v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->throwOutputError(Ljava/lang/String;)V

    .line 735
    return-void
.end method


# virtual methods
.method protected abstract appendLeaf(Lorg/w3c/dom/Node;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method

.method public close()V
    .locals 0

    .line 164
    return-void
.end method

.method public closeCompletely()V
    .locals 0

    .line 448
    return-void
.end method

.method public copyEventFromReader(Lorg/codehaus/stax2/XMLStreamReader2;Z)V
    .locals 0
    .param p1, "r"    # Lorg/codehaus/stax2/XMLStreamReader2;
    .param p2, "preserveEventData"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 436
    return-void
.end method

.method public flush()V
    .locals 0

    .line 169
    return-void
.end method

.method public getEncoding()Ljava/lang/String;
    .locals 1

    .line 307
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->mEncoding:Ljava/lang/String;

    return-object v0
.end method

.method public getLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
    .locals 1

    .line 302
    const/4 v0, 0x0

    return-object v0
.end method

.method public abstract getNamespaceContext()Ljavax/xml/namespace/NamespaceContext;
.end method

.method public abstract getPrefix(Ljava/lang/String;)Ljava/lang/String;
.end method

.method public abstract getProperty(Ljava/lang/String;)Ljava/lang/Object;
.end method

.method protected getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;
    .locals 1

    .line 712
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->mValueEncoder:Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    if-nez v0, :cond_0

    .line 713
    new-instance v0, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;-><init>()V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->mValueEncoder:Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    .line 715
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->mValueEncoder:Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    return-object v0
.end method

.method public abstract isPropertySupported(Ljava/lang/String;)Z
.end method

.method protected reportUnsupported(Ljava/lang/String;)V
    .locals 3
    .param p1, "operName"    # Ljava/lang/String;

    .line 739
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " can not be used with DOM-backed writer"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected serializeQNameValue(Ljavax/xml/namespace/QName;)Ljava/lang/String;
    .locals 5
    .param p1, "name"    # Ljavax/xml/namespace/QName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 678
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->mNsRepairing:Z

    if-eqz v0, :cond_4

    .line 679
    invoke-virtual {p1}, Ljavax/xml/namespace/QName;->getNamespaceURI()Ljava/lang/String;

    move-result-object v0

    .line 681
    .local v0, "uri":Ljava/lang/String;
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->getNamespaceContext()Ljavax/xml/namespace/NamespaceContext;

    move-result-object v1

    .line 682
    .local v1, "ctxt":Ljavax/xml/namespace/NamespaceContext;
    if-nez v1, :cond_0

    const/4 v2, 0x0

    goto :goto_0

    :cond_0
    invoke-interface {v1, v0}, Ljavax/xml/namespace/NamespaceContext;->getPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 683
    .local v2, "prefix":Ljava/lang/String;
    :goto_0
    if-nez v2, :cond_3

    .line 685
    invoke-virtual {p1}, Ljavax/xml/namespace/QName;->getPrefix()Ljava/lang/String;

    move-result-object v3

    .line 686
    .local v3, "origPrefix":Ljava/lang/String;
    if-eqz v3, :cond_2

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-nez v4, :cond_1

    goto :goto_1

    .line 694
    :cond_1
    move-object v2, v3

    .line 695
    invoke-virtual {p0, v2, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeNamespace(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    .line 687
    :cond_2
    :goto_1
    const-string v2, ""

    .line 692
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeDefaultNamespace(Ljava/lang/String;)V

    .line 698
    .end local v0    # "uri":Ljava/lang/String;
    .end local v1    # "ctxt":Ljavax/xml/namespace/NamespaceContext;
    .end local v3    # "origPrefix":Ljava/lang/String;
    :cond_3
    :goto_2
    goto :goto_3

    .line 699
    .end local v2    # "prefix":Ljava/lang/String;
    :cond_4
    invoke-virtual {p1}, Ljavax/xml/namespace/QName;->getPrefix()Ljava/lang/String;

    move-result-object v2

    .line 701
    .restart local v2    # "prefix":Ljava/lang/String;
    :goto_3
    invoke-virtual {p1}, Ljavax/xml/namespace/QName;->getLocalPart()Ljava/lang/String;

    move-result-object v0

    .line 702
    .local v0, "local":Ljava/lang/String;
    if-eqz v2, :cond_6

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_5

    goto :goto_4

    .line 707
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

    .line 703
    :cond_6
    :goto_4
    return-object v0
.end method

.method public abstract setDefaultNamespace(Ljava/lang/String;)V
.end method

.method public setNamespaceContext(Ljavax/xml/namespace/NamespaceContext;)V
    .locals 0
    .param p1, "context"    # Ljavax/xml/namespace/NamespaceContext;

    .line 182
    iput-object p1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->mNsContext:Ljavax/xml/namespace/NamespaceContext;

    .line 183
    return-void
.end method

.method public abstract setPrefix(Ljava/lang/String;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
.end method

.method public setValidationProblemHandler(Lorg/codehaus/stax2/validation/ValidationProblemHandler;)Lorg/codehaus/stax2/validation/ValidationProblemHandler;
    .locals 1
    .param p1, "h"    # Lorg/codehaus/stax2/validation/ValidationProblemHandler;

    .line 402
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

    .line 387
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

    .line 395
    const/4 v0, 0x0

    return-object v0
.end method

.method public validateAgainst(Lorg/codehaus/stax2/validation/XMLValidationSchema;)Lorg/codehaus/stax2/validation/XMLValidator;
    .locals 1
    .param p1, "schema"    # Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 379
    const/4 v0, 0x0

    return-object v0
.end method

.method public abstract writeAttribute(Ljava/lang/String;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public writeBinary(Lorg/codehaus/stax2/typed/Base64Variant;[BII)V
    .locals 1
    .param p1, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .param p2, "value"    # [B
    .param p3, "from"    # I
    .param p4, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 550
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3, p4}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encodeAsString(Lorg/codehaus/stax2/typed/Base64Variant;[BII)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeCharacters(Ljava/lang/String;)V

    .line 551
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

    .line 543
    invoke-static {}, Lorg/codehaus/stax2/typed/Base64Variants;->getDefaultVariant()Lorg/codehaus/stax2/typed/Base64Variant;

    move-result-object v0

    invoke-virtual {p0, v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeBinary(Lorg/codehaus/stax2/typed/Base64Variant;[BII)V

    .line 544
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

    .line 643
    invoke-static {}, Lorg/codehaus/stax2/typed/Base64Variants;->getDefaultVariant()Lorg/codehaus/stax2/typed/Base64Variant;

    move-result-object v1

    move-object v0, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-virtual/range {v0 .. v5}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeBinaryAttribute(Lorg/codehaus/stax2/typed/Base64Variant;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V

    .line 644
    return-void
.end method

.method public writeBinaryAttribute(Lorg/codehaus/stax2/typed/Base64Variant;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V
    .locals 3
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

    .line 649
    nop

    .line 650
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    move-result-object v0

    const/4 v1, 0x0

    array-length v2, p5

    invoke-virtual {v0, p1, p5, v1, v2}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encodeAsString(Lorg/codehaus/stax2/typed/Base64Variant;[BII)Ljava/lang/String;

    move-result-object v0

    .line 649
    invoke-virtual {p0, p2, p3, p4, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 651
    return-void
.end method

.method public writeBoolean(Z)V
    .locals 1
    .param p1, "value"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 461
    if-eqz p1, :cond_0

    const-string v0, "true"

    goto :goto_0

    :cond_0
    const-string v0, "false"

    :goto_0
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeCharacters(Ljava/lang/String;)V

    .line 462
    return-void
.end method

.method public writeBooleanAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 559
    if-eqz p4, :cond_0

    const-string v0, "true"

    goto :goto_0

    :cond_0
    const-string v0, "false"

    :goto_0
    invoke-virtual {p0, p1, p2, p3, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 560
    return-void
.end method

.method public writeCData(Ljava/lang/String;)V
    .locals 1
    .param p1, "data"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 202
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->mDocument:Lorg/w3c/dom/Document;

    invoke-interface {v0, p1}, Lorg/w3c/dom/Document;->createCDATASection(Ljava/lang/String;)Lorg/w3c/dom/CDATASection;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->appendLeaf(Lorg/w3c/dom/Node;)V

    .line 203
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

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeCData(Ljava/lang/String;)V

    .line 326
    return-void
.end method

.method public writeCharacters(Ljava/lang/String;)V
    .locals 1
    .param p1, "text"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 215
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->mDocument:Lorg/w3c/dom/Document;

    invoke-interface {v0, p1}, Lorg/w3c/dom/Document;->createTextNode(Ljava/lang/String;)Lorg/w3c/dom/Text;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->appendLeaf(Lorg/w3c/dom/Node;)V

    .line 216
    return-void
.end method

.method public writeCharacters([CII)V
    .locals 1
    .param p1, "text"    # [C
    .param p2, "start"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 209
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p1, p2, p3}, Ljava/lang/String;-><init>([CII)V

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeCharacters(Ljava/lang/String;)V

    .line 210
    return-void
.end method

.method public writeComment(Ljava/lang/String;)V
    .locals 1
    .param p1, "data"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 221
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->mDocument:Lorg/w3c/dom/Document;

    invoke-interface {v0, p1}, Lorg/w3c/dom/Document;->createComment(Ljava/lang/String;)Lorg/w3c/dom/Comment;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->appendLeaf(Lorg/w3c/dom/Node;)V

    .line 222
    return-void
.end method

.method public writeDTD(Ljava/lang/String;)V
    .locals 1
    .param p1, "dtd"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 234
    const-string v0, "writeDTD()"

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->reportUnsupported(Ljava/lang/String;)V

    .line 235
    return-void
.end method

.method public abstract writeDTD(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public writeDecimal(Ljava/math/BigDecimal;)V
    .locals 1
    .param p1, "value"    # Ljava/math/BigDecimal;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 497
    invoke-virtual {p1}, Ljava/math/BigDecimal;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeCharacters(Ljava/lang/String;)V

    .line 498
    return-void
.end method

.method public writeDecimalAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/math/BigDecimal;)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # Ljava/math/BigDecimal;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 601
    invoke-virtual {p4}, Ljava/math/BigDecimal;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, p1, p2, p3, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 602
    return-void
.end method

.method public abstract writeDefaultNamespace(Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public writeDouble(D)V
    .locals 1
    .param p1, "value"    # D
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 485
    invoke-static {p1, p2}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeCharacters(Ljava/lang/String;)V

    .line 486
    return-void
.end method

.method public writeDoubleArray([DII)V
    .locals 1
    .param p1, "value"    # [D
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 536
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encodeAsString([DII)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeCharacters(Ljava/lang/String;)V

    .line 537
    return-void
.end method

.method public writeDoubleArrayAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[D)V
    .locals 3
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # [D
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 636
    nop

    .line 637
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    move-result-object v0

    const/4 v1, 0x0

    array-length v2, p4

    invoke-virtual {v0, p4, v1, v2}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encodeAsString([DII)Ljava/lang/String;

    move-result-object v0

    .line 636
    invoke-virtual {p0, p1, p2, p3, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 638
    return-void
.end method

.method public writeDoubleAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;D)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # D
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 587
    invoke-static {p4, p5}, Ljava/lang/String;->valueOf(D)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, p1, p2, p3, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 588
    return-void
.end method

.method public abstract writeEmptyElement(Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeEmptyElement(Ljava/lang/String;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeEmptyElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeEndDocument()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public writeEntityRef(Ljava/lang/String;)V
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 253
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->mDocument:Lorg/w3c/dom/Document;

    invoke-interface {v0, p1}, Lorg/w3c/dom/Document;->createEntityReference(Ljava/lang/String;)Lorg/w3c/dom/EntityReference;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->appendLeaf(Lorg/w3c/dom/Node;)V

    .line 254
    return-void
.end method

.method public writeFloat(F)V
    .locals 1
    .param p1, "value"    # F
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 479
    invoke-static {p1}, Ljava/lang/String;->valueOf(F)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeCharacters(Ljava/lang/String;)V

    .line 480
    return-void
.end method

.method public writeFloatArray([FII)V
    .locals 1
    .param p1, "value"    # [F
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 528
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encodeAsString([FII)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeCharacters(Ljava/lang/String;)V

    .line 529
    return-void
.end method

.method public writeFloatArrayAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[F)V
    .locals 3
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # [F
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 629
    nop

    .line 630
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    move-result-object v0

    const/4 v1, 0x0

    array-length v2, p4

    invoke-virtual {v0, p4, v1, v2}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encodeAsString([FII)Ljava/lang/String;

    move-result-object v0

    .line 629
    invoke-virtual {p0, p1, p2, p3, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 631
    return-void
.end method

.method public writeFloatAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # F
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 580
    invoke-static {p4}, Ljava/lang/String;->valueOf(F)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, p1, p2, p3, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 581
    return-void
.end method

.method public writeFullEndElement()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 339
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeEndElement()V

    .line 340
    return-void
.end method

.method public writeInt(I)V
    .locals 1
    .param p1, "value"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 467
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeCharacters(Ljava/lang/String;)V

    .line 468
    return-void
.end method

.method public writeIntArray([III)V
    .locals 1
    .param p1, "value"    # [I
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 512
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encodeAsString([III)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeCharacters(Ljava/lang/String;)V

    .line 513
    return-void
.end method

.method public writeIntArrayAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[I)V
    .locals 3
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # [I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 615
    nop

    .line 616
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    move-result-object v0

    const/4 v1, 0x0

    array-length v2, p4

    invoke-virtual {v0, p4, v1, v2}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encodeAsString([III)Ljava/lang/String;

    move-result-object v0

    .line 615
    invoke-virtual {p0, p1, p2, p3, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 617
    return-void
.end method

.method public writeIntAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 566
    invoke-static {p4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, p1, p2, p3, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 567
    return-void
.end method

.method public writeInteger(Ljava/math/BigInteger;)V
    .locals 1
    .param p1, "value"    # Ljava/math/BigInteger;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 491
    invoke-virtual {p1}, Ljava/math/BigInteger;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeCharacters(Ljava/lang/String;)V

    .line 492
    return-void
.end method

.method public writeIntegerAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/math/BigInteger;)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # Ljava/math/BigInteger;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 594
    invoke-virtual {p4}, Ljava/math/BigInteger;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, p1, p2, p3, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 595
    return-void
.end method

.method public writeLong(J)V
    .locals 1
    .param p1, "value"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 473
    invoke-static {p1, p2}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeCharacters(Ljava/lang/String;)V

    .line 474
    return-void
.end method

.method public writeLongArray([JII)V
    .locals 1
    .param p1, "value"    # [J
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 520
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encodeAsString([JII)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeCharacters(Ljava/lang/String;)V

    .line 521
    return-void
.end method

.method public writeLongArrayAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[J)V
    .locals 3
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # [J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 622
    nop

    .line 623
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->getValueEncoder()Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;

    move-result-object v0

    const/4 v1, 0x0

    array-length v2, p4

    invoke-virtual {v0, p4, v1, v2}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encodeAsString([JII)Ljava/lang/String;

    move-result-object v0

    .line 622
    invoke-virtual {p0, p1, p2, p3, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 624
    return-void
.end method

.method public writeLongAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 573
    invoke-static {p4, p5}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, p1, p2, p3, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 574
    return-void
.end method

.method public writeProcessingInstruction(Ljava/lang/String;)V
    .locals 1
    .param p1, "target"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 260
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeProcessingInstruction(Ljava/lang/String;Ljava/lang/String;)V

    .line 261
    return-void
.end method

.method public writeProcessingInstruction(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "target"    # Ljava/lang/String;
    .param p2, "data"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 267
    iget-object v0, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->mDocument:Lorg/w3c/dom/Document;

    invoke-interface {v0, p1, p2}, Lorg/w3c/dom/Document;->createProcessingInstruction(Ljava/lang/String;Ljava/lang/String;)Lorg/w3c/dom/ProcessingInstruction;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->appendLeaf(Lorg/w3c/dom/Node;)V

    .line 268
    return-void
.end method

.method public writeQName(Ljavax/xml/namespace/QName;)V
    .locals 1
    .param p1, "name"    # Ljavax/xml/namespace/QName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 503
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->serializeQNameValue(Ljavax/xml/namespace/QName;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeCharacters(Ljava/lang/String;)V

    .line 504
    return-void
.end method

.method public writeQNameAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljavax/xml/namespace/QName;)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "name"    # Ljavax/xml/namespace/QName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 608
    invoke-virtual {p0, p4}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->serializeQNameValue(Ljavax/xml/namespace/QName;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, p1, p2, p3, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 609
    return-void
.end method

.method public writeRaw(Ljava/lang/String;)V
    .locals 1
    .param p1, "text"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 414
    const-string v0, "writeRaw()"

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->reportUnsupported(Ljava/lang/String;)V

    .line 415
    return-void
.end method

.method public writeRaw(Ljava/lang/String;II)V
    .locals 1
    .param p1, "text"    # Ljava/lang/String;
    .param p2, "start"    # I
    .param p3, "offset"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 421
    const-string v0, "writeRaw()"

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->reportUnsupported(Ljava/lang/String;)V

    .line 422
    return-void
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

    .line 428
    const-string v0, "writeRaw()"

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->reportUnsupported(Ljava/lang/String;)V

    .line 429
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

    .line 358
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeCharacters(Ljava/lang/String;)V

    .line 359
    return-void
.end method

.method public writeSpace([CII)V
    .locals 1
    .param p1, "text"    # [C
    .param p2, "start"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 346
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p1, p2, p3}, Ljava/lang/String;-><init>([CII)V

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeSpace(Ljava/lang/String;)V

    .line 347
    return-void
.end method

.method public writeStartDocument()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 275
    const-string v0, "UTF-8"

    const-string v1, "1.0"

    invoke-virtual {p0, v0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeStartDocument(Ljava/lang/String;Ljava/lang/String;)V

    .line 276
    return-void
.end method

.method public writeStartDocument(Ljava/lang/String;)V
    .locals 1
    .param p1, "version"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 281
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeStartDocument(Ljava/lang/String;Ljava/lang/String;)V

    .line 282
    return-void
.end method

.method public writeStartDocument(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "encoding"    # Ljava/lang/String;
    .param p2, "version"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 289
    iput-object p1, p0, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->mEncoding:Ljava/lang/String;

    .line 290
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

    .line 365
    invoke-virtual {p0, p2, p1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;->writeStartDocument(Ljava/lang/String;Ljava/lang/String;)V

    .line 366
    return-void
.end method
