.class public Lcom/fasterxml/aalto/dom/DOMOutputElement;
.super Lcom/fasterxml/aalto/dom/OutputElementBase;
.source "DOMOutputElement.java"


# instance fields
.field private _defaultNsSet:Z

.field private _element:Lorg/w3c/dom/Element;

.field private _parent:Lcom/fasterxml/aalto/dom/DOMOutputElement;


# direct methods
.method private constructor <init>()V
    .locals 3

    .line 37
    invoke-direct {p0}, Lcom/fasterxml/aalto/dom/OutputElementBase;-><init>()V

    .line 38
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_parent:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    .line 39
    iput-object v0, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_element:Lorg/w3c/dom/Element;

    .line 40
    iput-object v0, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    .line 41
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_nsMapShared:Z

    .line 42
    const-string v2, ""

    iput-object v2, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_defaultNsURI:Ljava/lang/String;

    .line 43
    iput-object v0, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    .line 44
    iput-boolean v1, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_defaultNsSet:Z

    .line 45
    return-void
.end method

.method private constructor <init>(Lcom/fasterxml/aalto/dom/DOMOutputElement;Lorg/w3c/dom/Element;Lcom/fasterxml/aalto/dom/BijectiveNsMap;)V
    .locals 2
    .param p1, "parent"    # Lcom/fasterxml/aalto/dom/DOMOutputElement;
    .param p2, "element"    # Lorg/w3c/dom/Element;
    .param p3, "ns"    # Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    .line 51
    invoke-direct {p0, p1, p3}, Lcom/fasterxml/aalto/dom/OutputElementBase;-><init>(Lcom/fasterxml/aalto/dom/OutputElementBase;Lcom/fasterxml/aalto/dom/BijectiveNsMap;)V

    .line 52
    iput-object p1, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_parent:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    .line 53
    iput-object p2, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_element:Lorg/w3c/dom/Element;

    .line 54
    iput-object p3, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    .line 55
    const/4 v0, 0x0

    if-eqz p3, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    move v1, v0

    :goto_0
    iput-boolean v1, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_nsMapShared:Z

    .line 56
    iget-object v1, p1, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_defaultNsURI:Ljava/lang/String;

    iput-object v1, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_defaultNsURI:Ljava/lang/String;

    .line 57
    iget-object v1, p1, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    iput-object v1, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    .line 58
    iput-boolean v0, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_defaultNsSet:Z

    .line 59
    return-void
.end method

.method public static createRoot()Lcom/fasterxml/aalto/dom/DOMOutputElement;
    .locals 1

    .line 75
    new-instance v0, Lcom/fasterxml/aalto/dom/DOMOutputElement;

    invoke-direct {v0}, Lcom/fasterxml/aalto/dom/DOMOutputElement;-><init>()V

    return-object v0
.end method

.method private relink(Lcom/fasterxml/aalto/dom/DOMOutputElement;Lorg/w3c/dom/Element;)V
    .locals 1
    .param p1, "parent"    # Lcom/fasterxml/aalto/dom/DOMOutputElement;
    .param p2, "element"    # Lorg/w3c/dom/Element;

    .line 66
    invoke-super {p0, p1}, Lcom/fasterxml/aalto/dom/OutputElementBase;->relink(Lcom/fasterxml/aalto/dom/OutputElementBase;)V

    .line 67
    iput-object p1, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_parent:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    .line 68
    iput-object p2, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_element:Lorg/w3c/dom/Element;

    .line 69
    invoke-virtual {p1, p2}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->appendNode(Lorg/w3c/dom/Node;)V

    .line 70
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_defaultNsSet:Z

    .line 71
    return-void
.end method


# virtual methods
.method protected addAttribute(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "pname"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .line 193
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_element:Lorg/w3c/dom/Element;

    invoke-interface {v0, p1, p2}, Lorg/w3c/dom/Element;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    .line 194
    return-void
.end method

.method protected addAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "uri"    # Ljava/lang/String;
    .param p2, "qname"    # Ljava/lang/String;
    .param p3, "value"    # Ljava/lang/String;

    .line 198
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_element:Lorg/w3c/dom/Element;

    invoke-interface {v0, p1, p2, p3}, Lorg/w3c/dom/Element;->setAttributeNS(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 199
    return-void
.end method

.method protected addToPool(Lcom/fasterxml/aalto/dom/DOMOutputElement;)V
    .locals 0
    .param p1, "poolHead"    # Lcom/fasterxml/aalto/dom/DOMOutputElement;

    .line 117
    iput-object p1, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_parent:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    .line 118
    return-void
.end method

.method public appendChild(Lorg/w3c/dom/Node;)V
    .locals 1
    .param p1, "n"    # Lorg/w3c/dom/Node;

    .line 202
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_element:Lorg/w3c/dom/Element;

    invoke-interface {v0, p1}, Lorg/w3c/dom/Element;->appendChild(Lorg/w3c/dom/Node;)Lorg/w3c/dom/Node;

    .line 203
    return-void
.end method

.method protected appendNode(Lorg/w3c/dom/Node;)V
    .locals 1
    .param p1, "n"    # Lorg/w3c/dom/Node;

    .line 184
    invoke-virtual {p0}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->isRoot()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 185
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_element:Lorg/w3c/dom/Element;

    invoke-interface {v0}, Lorg/w3c/dom/Element;->getOwnerDocument()Lorg/w3c/dom/Document;

    move-result-object v0

    invoke-interface {v0, p1}, Lorg/w3c/dom/Document;->appendChild(Lorg/w3c/dom/Node;)Lorg/w3c/dom/Node;

    goto :goto_0

    .line 187
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_element:Lorg/w3c/dom/Element;

    invoke-interface {v0, p1}, Lorg/w3c/dom/Element;->appendChild(Lorg/w3c/dom/Node;)Lorg/w3c/dom/Node;

    .line 189
    :goto_0
    return-void
.end method

.method protected createAndAttachChild(Lorg/w3c/dom/Element;)Lcom/fasterxml/aalto/dom/DOMOutputElement;
    .locals 1
    .param p1, "element"    # Lorg/w3c/dom/Element;

    .line 87
    invoke-virtual {p0}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->isRoot()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 88
    invoke-interface {p1}, Lorg/w3c/dom/Element;->getOwnerDocument()Lorg/w3c/dom/Document;

    move-result-object v0

    invoke-interface {v0, p1}, Lorg/w3c/dom/Document;->appendChild(Lorg/w3c/dom/Node;)Lorg/w3c/dom/Node;

    goto :goto_0

    .line 90
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_element:Lorg/w3c/dom/Element;

    invoke-interface {v0, p1}, Lorg/w3c/dom/Element;->appendChild(Lorg/w3c/dom/Node;)Lorg/w3c/dom/Node;

    .line 92
    :goto_0
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->createChild(Lorg/w3c/dom/Element;)Lcom/fasterxml/aalto/dom/DOMOutputElement;

    move-result-object v0

    return-object v0
.end method

.method protected createChild(Lorg/w3c/dom/Element;)Lcom/fasterxml/aalto/dom/DOMOutputElement;
    .locals 2
    .param p1, "element"    # Lorg/w3c/dom/Element;

    .line 97
    new-instance v0, Lcom/fasterxml/aalto/dom/DOMOutputElement;

    iget-object v1, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_nsMapping:Lcom/fasterxml/aalto/dom/BijectiveNsMap;

    invoke-direct {v0, p0, p1, v1}, Lcom/fasterxml/aalto/dom/DOMOutputElement;-><init>(Lcom/fasterxml/aalto/dom/DOMOutputElement;Lorg/w3c/dom/Element;Lcom/fasterxml/aalto/dom/BijectiveNsMap;)V

    return-object v0
.end method

.method public getNameDesc()Ljava/lang/String;
    .locals 1

    .line 143
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_element:Lorg/w3c/dom/Element;

    if-eqz v0, :cond_0

    .line 144
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_element:Lorg/w3c/dom/Element;

    invoke-interface {v0}, Lorg/w3c/dom/Element;->getLocalName()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 146
    :cond_0
    const-string v0, "#error"

    return-object v0
.end method

.method public getParent()Lcom/fasterxml/aalto/dom/DOMOutputElement;
    .locals 1

    .line 127
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_parent:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    return-object v0
.end method

.method public isRoot()Z
    .locals 1

    .line 133
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_parent:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method protected reuseAsChild(Lcom/fasterxml/aalto/dom/DOMOutputElement;Lorg/w3c/dom/Element;)Lcom/fasterxml/aalto/dom/DOMOutputElement;
    .locals 1
    .param p1, "parent"    # Lcom/fasterxml/aalto/dom/DOMOutputElement;
    .param p2, "element"    # Lorg/w3c/dom/Element;

    .line 106
    iget-object v0, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_parent:Lcom/fasterxml/aalto/dom/DOMOutputElement;

    .line 107
    .local v0, "poolHead":Lcom/fasterxml/aalto/dom/DOMOutputElement;
    invoke-direct {p0, p1, p2}, Lcom/fasterxml/aalto/dom/DOMOutputElement;->relink(Lcom/fasterxml/aalto/dom/DOMOutputElement;Lorg/w3c/dom/Element;)V

    .line 108
    return-object v0
.end method

.method public setDefaultNsUri(Ljava/lang/String;)V
    .locals 1
    .param p1, "uri"    # Ljava/lang/String;

    .line 157
    iput-object p1, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_defaultNsURI:Ljava/lang/String;

    .line 158
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_defaultNsSet:Z

    .line 159
    return-void
.end method

.method protected setRootNsContext(Ljavax/xml/namespace/NamespaceContext;)V
    .locals 2
    .param p1, "ctxt"    # Ljavax/xml/namespace/NamespaceContext;

    .line 164
    iput-object p1, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_rootNsContext:Ljavax/xml/namespace/NamespaceContext;

    .line 168
    iget-boolean v0, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_defaultNsSet:Z

    if-nez v0, :cond_0

    .line 169
    const-string v0, ""

    invoke-interface {p1, v0}, Ljavax/xml/namespace/NamespaceContext;->getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 170
    .local v0, "defURI":Ljava/lang/String;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    .line 171
    iput-object v0, p0, Lcom/fasterxml/aalto/dom/DOMOutputElement;->_defaultNsURI:Ljava/lang/String;

    .line 174
    .end local v0    # "defURI":Ljava/lang/String;
    :cond_0
    return-void
.end method
