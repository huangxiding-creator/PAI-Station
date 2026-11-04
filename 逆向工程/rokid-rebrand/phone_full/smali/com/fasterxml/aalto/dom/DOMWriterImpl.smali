.class public final Lcom/fasterxml/aalto/dom/DOMWriterImpl;
.super Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;
.source "DOMWriterImpl.java"


# instance fields
.field protected _autoNsSeq:[I

.field protected _automaticNsPrefix:Ljava/lang/String;

.field protected final _config:Lcom/fasterxml/aalto/out/WriterConfig;

.field protected _currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

.field protected _openElement:Lcom/fasterxml/aalto/dom/DOMOutputElement;

.field protected _suggestedDefNs:Ljava/lang/String;

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
.method private constructor <init>(Lcom/fasterxml/aalto/out/WriterConfig;Lorg/w3c/dom/Node;)V
    .locals 3
    .param p1, "cfg"    # Lcom/fasterxml/aalto/out/WriterConfig;
    .param p2, "treeRoot"    # Lorg/w3c/dom/Node;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 102
    const/4 v0, 0x1

    invoke-virtual {p1}, Lcom/fasterxml/aalto/out/WriterConfig;->willRepairNamespaces()Z

    move-result v1

    invoke-direct {p0, p2, v0, v1}, Lorg/codehaus/stax2/ri/dom/DOMWrappingWriter;-><init>(Lorg/w3c/dom/Node;ZZ)V

    .line 81
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_suggestedDefNs:Ljava/lang/String;

    .line 91
    iput-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_suggestedPrefixes:Ljava/util/HashMap;

    .line 103
    iput-object p1, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    .line 104
    iput-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_autoNsSeq:[I

    .line 105
    invoke-virtual {p1}, Lcom/fasterxml/aalto/out/WriterConfig;->getAutomaticNsPrefix()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_automaticNsPrefix:Ljava/lang/String;

    .line 110
    invoke-interface {p2}, Lorg/w3c/dom/Node;->getNodeType()S

    move-result v1

    sparse-switch v1, :sswitch_data_0

    .line 128
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Can not create an XMLStreamWriter for a DOM node of type "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 114
    :sswitch_0
    invoke-static {}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->createRoot()Lcom/fasterxml/aalto/dom/DOMOutputElement;

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    .line 115
    iput-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_openElement:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    .line 116
    goto :goto_0

    .line 121
    :sswitch_1
    invoke-static {}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->createRoot()Lcom/fasterxml/aalto/dom/DOMOutputElement;

    move-result-object v0

    .line 122
    .local v0, "root":Lcom/fasterxml/aalto/dom/DOMOutputElement;
    move-object v1, p2

    check-cast v1, Lorg/w3c/dom/Element;

    .line 123
    .local v1, "elem":Lorg/w3c/dom/Element;
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->createChild(Lorg/w3c/dom/Element;)Lcom/fasterxml/aalto/dom/DOMOutputElement;

    move-result-object v2

    iput-object v2, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    iput-object v2, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_openElement:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    .line 125
    .end local v0    # "root":Lcom/fasterxml/aalto/dom/DOMOutputElement;
    .end local v1    # "elem":Lorg/w3c/dom/Element;
    nop

    .line 130
    :goto_0
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_1
        0x9 -> :sswitch_0
        0xb -> :sswitch_0
    .end sparse-switch
.end method

.method public static createFrom(Lcom/fasterxml/aalto/out/WriterConfig;Ljavax/xml/transform/dom/DOMResult;)Lcom/fasterxml/aalto/dom/DOMWriterImpl;
    .locals 2
    .param p0, "cfg"    # Lcom/fasterxml/aalto/out/WriterConfig;
    .param p1, "dst"    # Ljavax/xml/transform/dom/DOMResult;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 135
    invoke-virtual {p1}, Ljavax/xml/transform/dom/DOMResult;->getNode()Lorg/w3c/dom/Node;

    move-result-object v0

    .line 136
    .local v0, "rootNode":Lorg/w3c/dom/Node;
    new-instance v1, Lcom/fasterxml/aalto/dom/DOMWriterImpl;

    invoke-direct {v1, p0, v0}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;-><init>(Lcom/fasterxml/aalto/out/WriterConfig;Lorg/w3c/dom/Node;)V

    return-object v1
.end method

.method private final validateElemPrefix(Ljava/lang/String;Ljava/lang/String;Lcom/fasterxml/aalto/dom/DOMOutputElement;)Ljava/lang/String;
    .locals 3
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "elem"    # Lcom/fasterxml/aalto/dom/DOMOutputElement;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 549
    const/4 v0, 0x0

    if-eqz p2, :cond_2

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_0

    goto :goto_0

    .line 559
    :cond_0
    const/4 v1, 0x1

    invoke-virtual {p3, p1, p2, v1}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->isPrefixValid(Ljava/lang/String;Ljava/lang/String;Z)I

    move-result v2

    .line 560
    .local v2, "status":I
    if-ne v2, v1, :cond_1

    .line 561
    return-object p1

    .line 563
    :cond_1
    return-object v0

    .line 550
    .end local v2    # "status":I
    :cond_2
    :goto_0
    invoke-virtual {p3}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->getDefaultNsUri()Ljava/lang/String;

    move-result-object v1

    .line 551
    .local v1, "currURL":Ljava/lang/String;
    if-eqz v1, :cond_4

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_3

    goto :goto_1

    .line 556
    :cond_3
    return-object v0

    .line 553
    :cond_4
    :goto_1
    const-string v0, ""

    return-object v0
.end method


# virtual methods
.method protected appendLeaf(Lorg/w3c/dom/Node;)V
    .locals 1
    .param p1, "n"    # Lorg/w3c/dom/Node;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .line 424
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->appendNode(Lorg/w3c/dom/Node;)V

    .line 425
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_openElement:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    .line 426
    return-void
.end method

.method protected createStartElem(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 5
    .param p1, "nsURI"    # Ljava/lang/String;
    .param p2, "prefix"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "isEmpty"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 448
    iget-boolean v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->mNsAware:Z

    if-nez v0, :cond_1

    .line 449
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    .line 450
    const-string v0, "Can not specify non-empty uri/prefix in non-namespace mode"

    invoke-static {v0}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->throwOutputError(Ljava/lang/String;)V

    .line 452
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    iget-object v1, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->mDocument:Lorg/w3c/dom/Document;

    invoke-interface {v1, p3}, Lorg/w3c/dom/Document;->createElement(Ljava/lang/String;)Lorg/w3c/dom/Element;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->createAndAttachChild(Lorg/w3c/dom/Element;)Lcom/fasterxml/aalto/dom/DOMOutputElement;

    move-result-object v0

    .local v0, "elem":Lcom/fasterxml/aalto/dom/DOMOutputElement;
    goto/16 :goto_4

    .line 454
    .end local v0    # "elem":Lcom/fasterxml/aalto/dom/DOMOutputElement;
    :cond_1
    iget-boolean v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->mNsRepairing:Z

    const-string v1, ":"

    if-eqz v0, :cond_8

    .line 455
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    invoke-direct {p0, p2, p1, v0}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->validateElemPrefix(Ljava/lang/String;Ljava/lang/String;Lcom/fasterxml/aalto/dom/DOMOutputElement;)Ljava/lang/String;

    move-result-object v0

    .line 456
    .local v0, "actPrefix":Ljava/lang/String;
    if-eqz v0, :cond_3

    .line 457
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_2

    .line 458
    iget-object v2, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    iget-object v3, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->mDocument:Lorg/w3c/dom/Document;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v3, p1, v1}, Lorg/w3c/dom/Document;->createElementNS(Ljava/lang/String;Ljava/lang/String;)Lorg/w3c/dom/Element;

    move-result-object v1

    invoke-virtual {v2, v1}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->createAndAttachChild(Lorg/w3c/dom/Element;)Lcom/fasterxml/aalto/dom/DOMOutputElement;

    move-result-object v1

    move-object v0, v1

    .local v1, "elem":Lcom/fasterxml/aalto/dom/DOMOutputElement;
    goto :goto_2

    .line 460
    .end local v1    # "elem":Lcom/fasterxml/aalto/dom/DOMOutputElement;
    :cond_2
    iget-object v1, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    iget-object v2, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->mDocument:Lorg/w3c/dom/Document;

    invoke-interface {v2, p1, p3}, Lorg/w3c/dom/Document;->createElementNS(Ljava/lang/String;Ljava/lang/String;)Lorg/w3c/dom/Element;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->createAndAttachChild(Lorg/w3c/dom/Element;)Lcom/fasterxml/aalto/dom/DOMOutputElement;

    move-result-object v1

    move-object v0, v1

    .restart local v1    # "elem":Lcom/fasterxml/aalto/dom/DOMOutputElement;
    goto :goto_2

    .line 467
    .end local v1    # "elem":Lcom/fasterxml/aalto/dom/DOMOutputElement;
    :cond_3
    if-nez p2, :cond_4

    .line 468
    const-string p2, ""

    .line 470
    :cond_4
    iget-object v2, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    invoke-virtual {p0, p2, p1, v2}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->generateElemPrefix(Ljava/lang/String;Ljava/lang/String;Lcom/fasterxml/aalto/dom/DOMOutputElement;)Ljava/lang/String;

    move-result-object v0

    .line 471
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-eqz v2, :cond_5

    const/4 v2, 0x1

    goto :goto_0

    :cond_5
    const/4 v2, 0x0

    .line 472
    .local v2, "hasPrefix":Z
    :goto_0
    if-eqz v2, :cond_6

    .line 473
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    .line 475
    :cond_6
    iget-object v1, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    iget-object v3, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->mDocument:Lorg/w3c/dom/Document;

    invoke-interface {v3, p1, p3}, Lorg/w3c/dom/Document;->createElementNS(Ljava/lang/String;Ljava/lang/String;)Lorg/w3c/dom/Element;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->createAndAttachChild(Lorg/w3c/dom/Element;)Lcom/fasterxml/aalto/dom/DOMOutputElement;

    move-result-object v1

    .line 482
    .restart local v1    # "elem":Lcom/fasterxml/aalto/dom/DOMOutputElement;
    iput-object v1, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_openElement:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    .line 484
    if-eqz v2, :cond_7

    .line 485
    invoke-virtual {p0, v0, p1}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->writeNamespace(Ljava/lang/String;Ljava/lang/String;)V

    .line 486
    invoke-virtual {v1, v0, p1}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->addPrefix(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 488
    :cond_7
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->writeDefaultNamespace(Ljava/lang/String;)V

    .line 489
    invoke-virtual {v1, p1}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->setDefaultNsUri(Ljava/lang/String;)V

    .line 492
    .end local v0    # "actPrefix":Ljava/lang/String;
    .end local v2    # "hasPrefix":Z
    :goto_1
    move-object v0, v1

    .end local v1    # "elem":Lcom/fasterxml/aalto/dom/DOMOutputElement;
    .local v0, "elem":Lcom/fasterxml/aalto/dom/DOMOutputElement;
    :goto_2
    goto :goto_4

    .line 497
    .end local v0    # "elem":Lcom/fasterxml/aalto/dom/DOMOutputElement;
    :cond_8
    if-nez p2, :cond_a

    if-eqz p1, :cond_a

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_a

    .line 498
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_suggestedPrefixes:Ljava/util/HashMap;

    if-nez v0, :cond_9

    const/4 v0, 0x0

    goto :goto_3

    :cond_9
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_suggestedPrefixes:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    :goto_3
    move-object p2, v0

    .line 499
    if-nez p2, :cond_a

    .line 500
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Can not find prefix for namespace \""

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "\""

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->throwOutputError(Ljava/lang/String;)V

    .line 503
    :cond_a
    if-eqz p2, :cond_b

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_b

    .line 504
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    .line 506
    :cond_b
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    iget-object v1, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->mDocument:Lorg/w3c/dom/Document;

    invoke-interface {v1, p1, p3}, Lorg/w3c/dom/Document;->createElementNS(Ljava/lang/String;Ljava/lang/String;)Lorg/w3c/dom/Element;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->createAndAttachChild(Lorg/w3c/dom/Element;)Lcom/fasterxml/aalto/dom/DOMOutputElement;

    move-result-object v0

    .line 512
    .restart local v0    # "elem":Lcom/fasterxml/aalto/dom/DOMOutputElement;
    :goto_4
    iput-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_openElement:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    .line 513
    if-nez p4, :cond_c

    .line 514
    iput-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    .line 516
    :cond_c
    return-void
.end method

.method protected final findElemPrefix(Ljava/lang/String;Lcom/fasterxml/aalto/dom/DOMOutputElement;)Ljava/lang/String;
    .locals 2
    .param p1, "nsURI"    # Ljava/lang/String;
    .param p2, "elem"    # Lcom/fasterxml/aalto/dom/DOMOutputElement;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 585
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 593
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->getPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 586
    :cond_1
    :goto_0
    invoke-virtual {p2}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->getDefaultNsUri()Ljava/lang/String;

    move-result-object v0

    .line 587
    .local v0, "currDefNsURI":Ljava/lang/String;
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_2

    .line 589
    const/4 v1, 0x0

    return-object v1

    .line 591
    :cond_2
    const-string v1, ""

    return-object v1
.end method

.method protected final findOrCreateAttrPrefix(Ljava/lang/String;Ljava/lang/String;Lcom/fasterxml/aalto/dom/DOMOutputElement;)Ljava/lang/String;
    .locals 4
    .param p1, "suggPrefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "elem"    # Lcom/fasterxml/aalto/dom/DOMOutputElement;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 663
    if-eqz p2, :cond_a

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_1

    .line 671
    :cond_0
    const/4 v0, 0x0

    const/4 v1, 0x1

    if-eqz p1, :cond_2

    .line 672
    invoke-virtual {p3, p1, p2, v0}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->isPrefixValid(Ljava/lang/String;Ljava/lang/String;Z)I

    move-result v2

    .line 673
    .local v2, "status":I
    if-ne v2, v1, :cond_1

    .line 674
    return-object p1

    .line 683
    :cond_1
    if-nez v2, :cond_2

    .line 684
    invoke-virtual {p3, p1, p2}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->addPrefix(Ljava/lang/String;Ljava/lang/String;)V

    .line 685
    invoke-virtual {p0, p1, p2}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->writeNamespace(Ljava/lang/String;Ljava/lang/String;)V

    .line 686
    return-object p1

    .line 691
    .end local v2    # "status":I
    :cond_2
    invoke-virtual {p3, p2}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->getExplicitPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 692
    .local v2, "prefix":Ljava/lang/String;
    if-eqz v2, :cond_3

    .line 693
    return-object v2

    .line 699
    :cond_3
    if-eqz p1, :cond_4

    .line 700
    move-object v2, p1

    goto :goto_0

    .line 701
    :cond_4
    iget-object v3, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_suggestedPrefixes:Ljava/util/HashMap;

    if-eqz v3, :cond_5

    .line 702
    iget-object v3, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_suggestedPrefixes:Ljava/util/HashMap;

    invoke-virtual {v3, p2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    move-object v2, v3

    check-cast v2, Ljava/lang/String;

    .line 706
    :cond_5
    :goto_0
    if-eqz v2, :cond_7

    .line 713
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    if-eqz v3, :cond_6

    .line 714
    invoke-virtual {p3, v2}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_7

    .line 715
    :cond_6
    const/4 v2, 0x0

    .line 719
    :cond_7
    if-nez v2, :cond_9

    .line 720
    iget-object v3, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_autoNsSeq:[I

    if-nez v3, :cond_8

    .line 721
    new-array v3, v1, [I

    iput-object v3, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_autoNsSeq:[I

    .line 722
    iget-object v3, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_autoNsSeq:[I

    aput v1, v3, v0

    .line 724
    :cond_8
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    iget-object v1, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_automaticNsPrefix:Ljava/lang/String;

    iget-object v3, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_autoNsSeq:[I

    invoke-virtual {v0, v1, p2, v3}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->generateMapping(Ljava/lang/String;Ljava/lang/String;[I)Ljava/lang/String;

    move-result-object v2

    .line 729
    :cond_9
    invoke-virtual {p3, v2, p2}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->addPrefix(Ljava/lang/String;Ljava/lang/String;)V

    .line 730
    invoke-virtual {p0, v2, p2}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->writeNamespace(Ljava/lang/String;Ljava/lang/String;)V

    .line 731
    return-object v2

    .line 668
    .end local v2    # "prefix":Ljava/lang/String;
    :cond_a
    :goto_1
    const/4 v0, 0x0

    return-object v0
.end method

.method protected final generateElemPrefix(Ljava/lang/String;Ljava/lang/String;Lcom/fasterxml/aalto/dom/DOMOutputElement;)Ljava/lang/String;
    .locals 3
    .param p1, "suggPrefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "elem"    # Lcom/fasterxml/aalto/dom/DOMOutputElement;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 611
    if-eqz p2, :cond_5

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_2

    .line 618
    :cond_0
    if-nez p1, :cond_4

    .line 620
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_suggestedDefNs:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_suggestedDefNs:Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 621
    const-string p1, ""

    goto :goto_1

    .line 623
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_suggestedPrefixes:Ljava/util/HashMap;

    if-nez v0, :cond_2

    const/4 v0, 0x0

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_suggestedPrefixes:Ljava/util/HashMap;

    .line 624
    invoke-virtual {v0, p2}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    :goto_0
    move-object p1, v0

    .line 625
    if-nez p1, :cond_4

    .line 631
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_autoNsSeq:[I

    if-nez v0, :cond_3

    .line 632
    const/4 v0, 0x1

    new-array v1, v0, [I

    iput-object v1, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_autoNsSeq:[I

    .line 633
    iget-object v1, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_autoNsSeq:[I

    const/4 v2, 0x0

    aput v0, v1, v2

    .line 635
    :cond_3
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_automaticNsPrefix:Ljava/lang/String;

    iget-object v1, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_autoNsSeq:[I

    invoke-virtual {p3, v0, p2, v1}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->generateMapping(Ljava/lang/String;Ljava/lang/String;[I)Ljava/lang/String;

    move-result-object p1

    .line 642
    :cond_4
    :goto_1
    return-object p1

    .line 612
    :cond_5
    :goto_2
    const-string v0, ""

    return-object v0
.end method

.method public getNamespaceContext()Ljavax/xml/namespace/NamespaceContext;
    .locals 1

    .line 151
    iget-boolean v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->mNsAware:Z

    if-nez v0, :cond_0

    .line 152
    invoke-static {}, Lorg/codehaus/stax2/ri/EmptyNamespaceContext;->getInstance()Lorg/codehaus/stax2/ri/EmptyNamespaceContext;

    move-result-object v0

    return-object v0

    .line 154
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    return-object v0
.end method

.method public getPrefix(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "uri"    # Ljava/lang/String;

    .line 160
    iget-boolean v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->mNsAware:Z

    if-nez v0, :cond_0

    .line 161
    const/4 v0, 0x0

    return-object v0

    .line 163
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->mNsContext:Ljavax/xml/namespace/NamespaceContext;

    if-eqz v0, :cond_1

    .line 164
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->mNsContext:Ljavax/xml/namespace/NamespaceContext;

    invoke-interface {v0, p1}, Ljavax/xml/namespace/NamespaceContext;->getPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 165
    .local v0, "prefix":Ljava/lang/String;
    if-eqz v0, :cond_1

    .line 166
    return-object v0

    .line 169
    .end local v0    # "prefix":Ljava/lang/String;
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->getPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getProperty(Ljava/lang/String;)Ljava/lang/Object;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 177
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Lcom/fasterxml/aalto/out/WriterConfig;->getProperty(Ljava/lang/String;Z)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public isPropertySupported(Ljava/lang/String;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 371
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/WriterConfig;->isPropertySupported(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method protected outputAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "nsURI"    # Ljava/lang/String;
    .param p2, "prefix"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 521
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_openElement:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    if-eqz v0, :cond_4

    .line 525
    iget-boolean v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->mNsAware:Z

    const-string v1, ":"

    if-eqz v0, :cond_2

    .line 526
    iget-boolean v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->mNsRepairing:Z

    if-eqz v0, :cond_0

    .line 527
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_openElement:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    invoke-virtual {p0, p2, p1, v0}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->findOrCreateAttrPrefix(Ljava/lang/String;Ljava/lang/String;Lcom/fasterxml/aalto/dom/DOMOutputElement;)Ljava/lang/String;

    move-result-object p2

    .line 529
    :cond_0
    if-eqz p2, :cond_1

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_1

    .line 530
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    .line 532
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_openElement:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    invoke-virtual {v0, p1, p3, p4}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->addAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 534
    :cond_2
    if-eqz p2, :cond_3

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_3

    .line 535
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    .line 537
    :cond_3
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_openElement:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    invoke-virtual {v0, p3, p4}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->addAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 539
    :goto_0
    return-void

    .line 522
    :cond_4
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "No currently open START_ELEMENT, cannot write attribute"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setDefaultNamespace(Ljava/lang/String;)V
    .locals 1
    .param p1, "uri"    # Ljava/lang/String;

    .line 182
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
    iput-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_suggestedDefNs:Ljava/lang/String;

    .line 183
    return-void
.end method

.method public setPrefix(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "uri"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 191
    if-eqz p1, :cond_8

    .line 195
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    .line 196
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->setDefaultNamespace(Ljava/lang/String;)V

    .line 197
    return-void

    .line 199
    :cond_0
    if-eqz p2, :cond_7

    .line 207
    const-string/jumbo v0, "xml"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const-string v1, "http://www.w3.org/XML/1998/namespace"

    if-eqz v0, :cond_1

    .line 208
    invoke-virtual {p2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    .line 209
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Trying to redeclare prefix \'xml\' from its default URI \'http://www.w3.org/XML/1998/namespace\' to \""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->throwOutputError(Ljava/lang/String;)V

    goto :goto_0

    .line 211
    :cond_1
    const-string/jumbo v0, "xmlns"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const-string v2, "http://www.w3.org/2000/xmlns/"

    if-eqz v0, :cond_3

    .line 212
    invoke-virtual {p2, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 213
    const-string v0, "Trying to declare prefix \'xmlns\' (illegal as per NS 1.1 #4)"

    invoke-static {v0}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->throwOutputError(Ljava/lang/String;)V

    .line 216
    :cond_2
    return-void

    .line 219
    :cond_3
    invoke-virtual {p2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 220
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Trying to bind URI \'http://www.w3.org/XML/1998/namespace to prefix \""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\" (can only bind to \'xml\')"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->throwOutputError(Ljava/lang/String;)V

    goto :goto_0

    .line 222
    :cond_4
    invoke-virtual {p2, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 223
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Trying to bind URI \'http://www.w3.org/2000/xmlns/ to prefix \""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\" (can not be explicitly bound)"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->throwOutputError(Ljava/lang/String;)V

    .line 229
    :cond_5
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_suggestedPrefixes:Ljava/util/HashMap;

    if-nez v0, :cond_6

    .line 230
    new-instance v0, Ljava/util/HashMap;

    const/16 v1, 0x10

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    iput-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_suggestedPrefixes:Ljava/util/HashMap;

    .line 232
    :cond_6
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_suggestedPrefixes:Ljava/util/HashMap;

    invoke-virtual {v0, p2, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 234
    return-void

    .line 200
    :cond_7
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "Can not pass null \'uri\' value"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 192
    :cond_8
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "Can not pass null \'prefix\' value"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 380
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/out/WriterConfig;->setProperty(Ljava/lang/String;Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public writeAttribute(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "localName"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 240
    const/4 v0, 0x0

    invoke-virtual {p0, v0, v0, p1, p2}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->outputAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 241
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

    .line 247
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0, p2, p3}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->outputAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 248
    return-void
.end method

.method public writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "nsURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 254
    invoke-virtual {p0, p2, p1, p3, p4}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->outputAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 255
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

    .line 400
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    if-nez v0, :cond_0

    .line 403
    const-string/jumbo v0, "writeDTD()"

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->reportUnsupported(Ljava/lang/String;)V

    .line 404
    return-void

    .line 401
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Operation only allowed to the document before adding root element"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public writeDefaultNamespace(Ljava/lang/String;)V
    .locals 3
    .param p1, "nsURI"    # Ljava/lang/String;

    .line 265
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_openElement:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    if-eqz v0, :cond_0

    .line 268
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->setDefaultNamespace(Ljava/lang/String;)V

    .line 269
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_openElement:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    const-string v1, "http://www.w3.org/2000/xmlns/"

    const-string/jumbo v2, "xmlns"

    invoke-virtual {v0, v1, v2, p1}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->addAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 270
    return-void

    .line 266
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "No currently open START_ELEMENT, cannot write attribute"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public writeEmptyElement(Ljava/lang/String;)V
    .locals 1
    .param p1, "localName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 278
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p1}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->writeEmptyElement(Ljava/lang/String;Ljava/lang/String;)V

    .line 279
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

    .line 290
    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-virtual {p0, p1, v0, p2, v1}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->createStartElem(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    .line 291
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

    .line 297
    if-nez p1, :cond_0

    .line 298
    const-string p1, ""

    .line 300
    :cond_0
    const/4 v0, 0x1

    invoke-virtual {p0, p3, p1, p2, v0}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->createStartElem(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    .line 301
    return-void
.end method

.method public writeEndDocument()V
    .locals 1

    .line 306
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_openElement:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    iput-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    .line 307
    return-void
.end method

.method public writeEndElement()V
    .locals 2

    .line 313
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->isRoot()Z

    move-result v0

    if-nez v0, :cond_0

    .line 316
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_openElement:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    .line 317
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->getParent()Lcom/fasterxml/aalto/dom/DOMOutputElement;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    .line 318
    return-void

    .line 314
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "No open start element to close"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
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

    .line 323
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 327
    :cond_0
    iget-boolean v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->mNsAware:Z

    if-nez v0, :cond_1

    .line 328
    const-string v0, "Can not write namespaces with non-namespace writer."

    invoke-static {v0}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->throwOutputError(Ljava/lang/String;)V

    .line 330
    :cond_1
    const-string v0, "http://www.w3.org/2000/xmlns/"

    const-string/jumbo v1, "xmlns"

    invoke-virtual {p0, v0, v1, p1, p2}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->outputAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 331
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->_currElem:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->addPrefix(Ljava/lang/String;Ljava/lang/String;)V

    .line 332
    return-void

    .line 324
    :cond_2
    :goto_0
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->writeDefaultNamespace(Ljava/lang/String;)V

    .line 325
    return-void
.end method

.method public writeStartElement(Ljava/lang/String;)V
    .locals 1
    .param p1, "localName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 345
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p1}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->writeStartElement(Ljava/lang/String;Ljava/lang/String;)V

    .line 346
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

    .line 352
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v0, p2, v1}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->createStartElem(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    .line 353
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

    .line 359
    const/4 v0, 0x0

    invoke-virtual {p0, p3, p1, p2, v0}, Lcom/fasterxml/aalto/dom/DOMWriterImpl;->createStartElem(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    .line 360
    return-void
.end method
