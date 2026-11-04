.class public abstract Lcom/fasterxml/aalto/in/PName;
.super Ljava/lang/Object;
.source "PName.java"


# instance fields
.field protected final _localName:Ljava/lang/String;

.field protected _namespaceBinding:Lcom/fasterxml/aalto/in/NsBinding;

.field protected final _prefix:Ljava/lang/String;

.field protected final _prefixedName:Ljava/lang/String;


# direct methods
.method protected constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "pname"    # Ljava/lang/String;
    .param p2, "prefix"    # Ljava/lang/String;
    .param p3, "ln"    # Ljava/lang/String;

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/PName;->_namespaceBinding:Lcom/fasterxml/aalto/in/NsBinding;

    .line 46
    iput-object p1, p0, Lcom/fasterxml/aalto/in/PName;->_prefixedName:Ljava/lang/String;

    .line 47
    iput-object p2, p0, Lcom/fasterxml/aalto/in/PName;->_prefix:Ljava/lang/String;

    .line 48
    iput-object p3, p0, Lcom/fasterxml/aalto/in/PName;->_localName:Ljava/lang/String;

    .line 49
    return-void
.end method

.method public static boundHashCode(Ljava/lang/String;Ljava/lang/String;)I
    .locals 1
    .param p0, "nsURI"    # Ljava/lang/String;
    .param p1, "localName"    # Ljava/lang/String;

    .line 191
    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v0

    return v0
.end method


# virtual methods
.method public final boundEquals(Lcom/fasterxml/aalto/in/PName;)Z
    .locals 3
    .param p1, "other"    # Lcom/fasterxml/aalto/in/PName;

    .line 152
    const/4 v0, 0x0

    if-eqz p1, :cond_2

    iget-object v1, p1, Lcom/fasterxml/aalto/in/PName;->_localName:Ljava/lang/String;

    iget-object v2, p0, Lcom/fasterxml/aalto/in/PName;->_localName:Ljava/lang/String;

    if-eq v1, v2, :cond_0

    goto :goto_0

    .line 156
    :cond_0
    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/PName;->getNsUri()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/PName;->getNsUri()Ljava/lang/String;

    move-result-object v2

    if-ne v1, v2, :cond_1

    const/4 v0, 0x1

    :cond_1
    return v0

    .line 153
    :cond_2
    :goto_0
    return v0
.end method

.method public final boundEquals(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 3
    .param p1, "nsUri"    # Ljava/lang/String;
    .param p2, "ln"    # Ljava/lang/String;

    .line 166
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PName;->_localName:Ljava/lang/String;

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 167
    return v1

    .line 169
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/PName;->getNsUri()Ljava/lang/String;

    move-result-object v0

    .line 170
    .local v0, "thisUri":Ljava/lang/String;
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_1

    goto :goto_0

    .line 173
    :cond_1
    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    return v1

    .line 171
    :cond_2
    :goto_0
    if-nez v0, :cond_3

    const/4 v1, 0x1

    :cond_3
    return v1
.end method

.method public final boundHashCode()I
    .locals 1

    .line 186
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PName;->_localName:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    return v0
.end method

.method public final constructQName()Ljavax/xml/namespace/QName;
    .locals 6

    .line 89
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PName;->_prefix:Ljava/lang/String;

    .line 90
    .local v0, "pr":Ljava/lang/String;
    iget-object v1, p0, Lcom/fasterxml/aalto/in/PName;->_namespaceBinding:Lcom/fasterxml/aalto/in/NsBinding;

    if-nez v1, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/in/PName;->_namespaceBinding:Lcom/fasterxml/aalto/in/NsBinding;

    iget-object v1, v1, Lcom/fasterxml/aalto/in/NsBinding;->mURI:Ljava/lang/String;

    .line 92
    .local v1, "uri":Ljava/lang/String;
    :goto_0
    new-instance v2, Ljavax/xml/namespace/QName;

    const-string v3, ""

    if-nez v1, :cond_1

    move-object v4, v3

    goto :goto_1

    :cond_1
    move-object v4, v1

    :goto_1
    iget-object v5, p0, Lcom/fasterxml/aalto/in/PName;->_localName:Ljava/lang/String;

    if-nez v0, :cond_2

    goto :goto_2

    :cond_2
    move-object v3, v0

    :goto_2
    invoke-direct {v2, v4, v5, v3}, Ljavax/xml/namespace/QName;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-object v2
.end method

.method public final constructQName(Lcom/fasterxml/aalto/in/NsBinding;)Ljavax/xml/namespace/QName;
    .locals 5
    .param p1, "defaultNs"    # Lcom/fasterxml/aalto/in/NsBinding;

    .line 105
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PName;->_prefix:Ljava/lang/String;

    .line 106
    .local v0, "pr":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 107
    const-string v0, ""

    .line 110
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/in/PName;->_namespaceBinding:Lcom/fasterxml/aalto/in/NsBinding;

    if-eqz v1, :cond_1

    .line 111
    iget-object v1, p0, Lcom/fasterxml/aalto/in/PName;->_namespaceBinding:Lcom/fasterxml/aalto/in/NsBinding;

    iget-object v1, v1, Lcom/fasterxml/aalto/in/NsBinding;->mURI:Ljava/lang/String;

    .line 112
    .local v1, "uri":Ljava/lang/String;
    if-eqz v1, :cond_1

    .line 113
    new-instance v2, Ljavax/xml/namespace/QName;

    iget-object v3, p0, Lcom/fasterxml/aalto/in/PName;->_localName:Ljava/lang/String;

    invoke-direct {v2, v1, v3, v0}, Ljavax/xml/namespace/QName;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-object v2

    .line 117
    .end local v1    # "uri":Ljava/lang/String;
    :cond_1
    iget-object v1, p1, Lcom/fasterxml/aalto/in/NsBinding;->mURI:Ljava/lang/String;

    .line 118
    .restart local v1    # "uri":Ljava/lang/String;
    new-instance v2, Ljavax/xml/namespace/QName;

    if-nez v1, :cond_2

    const-string v3, ""

    goto :goto_0

    :cond_2
    move-object v3, v1

    :goto_0
    iget-object v4, p0, Lcom/fasterxml/aalto/in/PName;->_localName:Ljava/lang/String;

    invoke-direct {v2, v3, v4, v0}, Ljavax/xml/namespace/QName;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-object v2
.end method

.method public abstract createBoundName(Lcom/fasterxml/aalto/in/NsBinding;)Lcom/fasterxml/aalto/in/PName;
.end method

.method public final equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 211
    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    .line 212
    return v0

    .line 214
    :cond_0
    instance-of v1, p1, Lcom/fasterxml/aalto/in/PName;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    .line 215
    return v2

    .line 217
    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/fasterxml/aalto/in/PName;

    .line 222
    .local v1, "other":Lcom/fasterxml/aalto/in/PName;
    iget-object v3, v1, Lcom/fasterxml/aalto/in/PName;->_prefix:Ljava/lang/String;

    iget-object v4, p0, Lcom/fasterxml/aalto/in/PName;->_prefix:Ljava/lang/String;

    if-ne v3, v4, :cond_2

    iget-object v3, v1, Lcom/fasterxml/aalto/in/PName;->_localName:Ljava/lang/String;

    iget-object v4, p0, Lcom/fasterxml/aalto/in/PName;->_localName:Ljava/lang/String;

    if-ne v3, v4, :cond_2

    goto :goto_0

    :cond_2
    move v0, v2

    :goto_0
    return v0
.end method

.method public abstract getFirstQuad()I
.end method

.method public abstract getLastQuad()I
.end method

.method public final getLocalName()Ljava/lang/String;
    .locals 1

    .line 76
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PName;->_localName:Ljava/lang/String;

    return-object v0
.end method

.method public final getNsBinding()Lcom/fasterxml/aalto/in/NsBinding;
    .locals 1

    .line 81
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PName;->_namespaceBinding:Lcom/fasterxml/aalto/in/NsBinding;

    return-object v0
.end method

.method public final getNsUri()Ljava/lang/String;
    .locals 1

    .line 84
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PName;->_namespaceBinding:Lcom/fasterxml/aalto/in/NsBinding;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PName;->_namespaceBinding:Lcom/fasterxml/aalto/in/NsBinding;

    iget-object v0, v0, Lcom/fasterxml/aalto/in/NsBinding;->mURI:Ljava/lang/String;

    :goto_0
    return-object v0
.end method

.method public final getPrefix()Ljava/lang/String;
    .locals 1

    .line 75
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PName;->_prefix:Ljava/lang/String;

    return-object v0
.end method

.method public final getPrefixedName()Ljava/lang/String;
    .locals 1

    .line 70
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PName;->_prefixedName:Ljava/lang/String;

    return-object v0
.end method

.method public abstract getQuad(I)I
.end method

.method public hasPrefix()Z
    .locals 1

    .line 78
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PName;->_prefix:Ljava/lang/String;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public hasPrefixedName(Ljava/lang/String;)Z
    .locals 1
    .param p1, "n"    # Ljava/lang/String;

    .line 79
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PName;->_prefixedName:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public hashCode()I
    .locals 1

    .line 205
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PName;->_prefixedName:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    return v0
.end method

.method public final isBound()Z
    .locals 1

    .line 143
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PName;->_namespaceBinding:Lcom/fasterxml/aalto/in/NsBinding;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/fasterxml/aalto/in/PName;->_namespaceBinding:Lcom/fasterxml/aalto/in/NsBinding;

    iget-object v0, v0, Lcom/fasterxml/aalto/in/NsBinding;->mURI:Ljava/lang/String;

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    return v0
.end method

.method public final needsBinding()Z
    .locals 1

    .line 132
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PName;->_prefix:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/fasterxml/aalto/in/PName;->_namespaceBinding:Lcom/fasterxml/aalto/in/NsBinding;

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public abstract sizeInQuads()I
.end method

.method public final toString()Ljava/lang/String;
    .locals 1

    .line 201
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PName;->_prefixedName:Ljava/lang/String;

    return-object v0
.end method

.method public final unboundEquals(Lcom/fasterxml/aalto/in/PName;)Z
    .locals 2
    .param p1, "other"    # Lcom/fasterxml/aalto/in/PName;

    .line 161
    iget-object v0, p1, Lcom/fasterxml/aalto/in/PName;->_prefixedName:Ljava/lang/String;

    iget-object v1, p0, Lcom/fasterxml/aalto/in/PName;->_prefixedName:Ljava/lang/String;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public final unboundHashCode()I
    .locals 1

    .line 178
    iget-object v0, p0, Lcom/fasterxml/aalto/in/PName;->_prefixedName:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    return v0
.end method
