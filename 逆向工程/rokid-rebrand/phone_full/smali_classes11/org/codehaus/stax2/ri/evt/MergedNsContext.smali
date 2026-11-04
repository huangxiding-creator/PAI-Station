.class public Lorg/codehaus/stax2/ri/evt/MergedNsContext;
.super Ljava/lang/Object;
.source "MergedNsContext.java"

# interfaces
.implements Ljavax/xml/namespace/NamespaceContext;


# instance fields
.field final _namespaces:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljavax/xml/stream/events/Namespace;",
            ">;"
        }
    .end annotation
.end field

.field final _parentCtxt:Ljavax/xml/namespace/NamespaceContext;


# direct methods
.method protected constructor <init>(Ljavax/xml/namespace/NamespaceContext;Ljava/util/List;)V
    .locals 1
    .param p1, "parentCtxt"    # Ljavax/xml/namespace/NamespaceContext;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljavax/xml/namespace/NamespaceContext;",
            "Ljava/util/List<",
            "Ljavax/xml/stream/events/Namespace;",
            ">;)V"
        }
    .end annotation

    .line 25
    .local p2, "localNs":Ljava/util/List;, "Ljava/util/List<Ljavax/xml/stream/events/Namespace;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 26
    iput-object p1, p0, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->_parentCtxt:Ljavax/xml/namespace/NamespaceContext;

    .line 27
    if-nez p2, :cond_0

    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    goto :goto_0

    :cond_0
    move-object v0, p2

    :goto_0
    iput-object v0, p0, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->_namespaces:Ljava/util/List;

    .line 28
    return-void
.end method

.method public static construct(Ljavax/xml/namespace/NamespaceContext;Ljava/util/List;)Lorg/codehaus/stax2/ri/evt/MergedNsContext;
    .locals 1
    .param p0, "parentCtxt"    # Ljavax/xml/namespace/NamespaceContext;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljavax/xml/namespace/NamespaceContext;",
            "Ljava/util/List<",
            "Ljavax/xml/stream/events/Namespace;",
            ">;)",
            "Lorg/codehaus/stax2/ri/evt/MergedNsContext;"
        }
    .end annotation

    .line 32
    .local p1, "localNs":Ljava/util/List;, "Ljava/util/List<Ljavax/xml/stream/events/Namespace;>;"
    new-instance v0, Lorg/codehaus/stax2/ri/evt/MergedNsContext;

    invoke-direct {v0, p0, p1}, Lorg/codehaus/stax2/ri/evt/MergedNsContext;-><init>(Ljavax/xml/namespace/NamespaceContext;Ljava/util/List;)V

    return-object v0
.end method


# virtual methods
.method protected addToList(Ljava/util/ArrayList;Ljava/lang/Object;)Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/util/ArrayList<",
            "TT;>;TT;)",
            "Ljava/util/ArrayList<",
            "TT;>;"
        }
    .end annotation

    .line 172
    .local p1, "l":Ljava/util/ArrayList;, "Ljava/util/ArrayList<TT;>;"
    .local p2, "value":Ljava/lang/Object;, "TT;"
    if-nez p1, :cond_0

    .line 173
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    move-object p1, v0

    .line 175
    :cond_0
    invoke-virtual {p1, p2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 176
    return-object p1
.end method

.method public getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "prefix"    # Ljava/lang/String;

    .line 44
    if-eqz p1, :cond_5

    .line 47
    const/4 v0, 0x0

    .local v0, "i":I
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->_namespaces:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    .local v1, "len":I
    :goto_0
    if-ge v0, v1, :cond_1

    .line 48
    iget-object v2, p0, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->_namespaces:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljavax/xml/stream/events/Namespace;

    .line 49
    .local v2, "ns":Ljavax/xml/stream/events/Namespace;
    invoke-interface {v2}, Ljavax/xml/stream/events/Namespace;->getPrefix()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 50
    invoke-interface {v2}, Ljavax/xml/stream/events/Namespace;->getNamespaceURI()Ljava/lang/String;

    move-result-object v3

    return-object v3

    .line 47
    .end local v2    # "ns":Ljavax/xml/stream/events/Namespace;
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 54
    .end local v0    # "i":I
    .end local v1    # "len":I
    :cond_1
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->_parentCtxt:Ljavax/xml/namespace/NamespaceContext;

    if-eqz v0, :cond_2

    .line 55
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->_parentCtxt:Ljavax/xml/namespace/NamespaceContext;

    invoke-interface {v0, p1}, Ljavax/xml/namespace/NamespaceContext;->getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 56
    .local v0, "uri":Ljava/lang/String;
    if-eqz v0, :cond_2

    .line 57
    return-object v0

    .line 60
    .end local v0    # "uri":Ljava/lang/String;
    :cond_2
    const-string v0, "xml"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 61
    const-string v0, "http://www.w3.org/XML/1998/namespace"

    return-object v0

    .line 63
    :cond_3
    const-string v0, "xmlns"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 64
    const-string v0, "http://www.w3.org/2000/xmlns/"

    return-object v0

    .line 66
    :cond_4
    const/4 v0, 0x0

    return-object v0

    .line 45
    :cond_5
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Illegal to pass null prefix"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public getPrefix(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p1, "nsURI"    # Ljava/lang/String;

    .line 72
    if-eqz p1, :cond_7

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_7

    .line 78
    const/4 v0, 0x0

    .local v0, "i":I
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->_namespaces:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    .local v1, "len":I
    :goto_0
    if-ge v0, v1, :cond_1

    .line 79
    iget-object v2, p0, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->_namespaces:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljavax/xml/stream/events/Namespace;

    .line 80
    .local v2, "ns":Ljavax/xml/stream/events/Namespace;
    invoke-interface {v2}, Ljavax/xml/stream/events/Namespace;->getNamespaceURI()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 81
    invoke-interface {v2}, Ljavax/xml/stream/events/Namespace;->getPrefix()Ljava/lang/String;

    move-result-object v3

    return-object v3

    .line 78
    .end local v2    # "ns":Ljavax/xml/stream/events/Namespace;
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 85
    .end local v0    # "i":I
    .end local v1    # "len":I
    :cond_1
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->_parentCtxt:Ljavax/xml/namespace/NamespaceContext;

    if-eqz v0, :cond_4

    .line 86
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->_parentCtxt:Ljavax/xml/namespace/NamespaceContext;

    invoke-interface {v0, p1}, Ljavax/xml/namespace/NamespaceContext;->getPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 87
    .local v0, "prefix":Ljava/lang/String;
    if-eqz v0, :cond_2

    .line 89
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 90
    .local v1, "uri2":Ljava/lang/String;
    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 92
    return-object v0

    .line 97
    .end local v1    # "uri2":Ljava/lang/String;
    :cond_2
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->_parentCtxt:Ljavax/xml/namespace/NamespaceContext;

    invoke-interface {v1, p1}, Ljavax/xml/namespace/NamespaceContext;->getPrefixes(Ljava/lang/String;)Ljava/util/Iterator;

    move-result-object v1

    .line 98
    .local v1, "it":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_4

    .line 99
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 100
    .local v2, "p2":Ljava/lang/String;
    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    .line 102
    invoke-virtual {p0, v2}, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 103
    .local v3, "uri2":Ljava/lang/String;
    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 105
    return-object v2

    .line 108
    .end local v2    # "p2":Ljava/lang/String;
    .end local v3    # "uri2":Ljava/lang/String;
    :cond_3
    goto :goto_1

    .line 112
    .end local v0    # "prefix":Ljava/lang/String;
    .end local v1    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    :cond_4
    const-string v0, "http://www.w3.org/XML/1998/namespace"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 113
    const-string v0, "xml"

    return-object v0

    .line 115
    :cond_5
    const-string v0, "http://www.w3.org/2000/xmlns/"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 116
    const-string v0, "xmlns"

    return-object v0

    .line 120
    :cond_6
    const/4 v0, 0x0

    return-object v0

    .line 73
    :cond_7
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Illegal to pass null/empty prefix as argument."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public getPrefixes(Ljava/lang/String;)Ljava/util/Iterator;
    .locals 5
    .param p1, "nsURI"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Iterator<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 126
    if-eqz p1, :cond_6

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_6

    .line 131
    const/4 v0, 0x0

    .line 132
    .local v0, "l":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    const/4 v1, 0x0

    .local v1, "i":I
    iget-object v2, p0, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->_namespaces:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    .local v2, "len":I
    :goto_0
    if-ge v1, v2, :cond_1

    .line 133
    iget-object v3, p0, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->_namespaces:Ljava/util/List;

    invoke-interface {v3, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljavax/xml/stream/events/Namespace;

    .line 134
    .local v3, "ns":Ljavax/xml/stream/events/Namespace;
    invoke-interface {v3}, Ljavax/xml/stream/events/Namespace;->getNamespaceURI()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 135
    invoke-interface {v3}, Ljavax/xml/stream/events/Namespace;->getPrefix()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v0, v4}, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->addToList(Ljava/util/ArrayList;Ljava/lang/Object;)Ljava/util/ArrayList;

    move-result-object v0

    .line 132
    .end local v3    # "ns":Ljavax/xml/stream/events/Namespace;
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 140
    .end local v1    # "i":I
    .end local v2    # "len":I
    :cond_1
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->_parentCtxt:Ljavax/xml/namespace/NamespaceContext;

    if-eqz v1, :cond_3

    .line 141
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->_parentCtxt:Ljavax/xml/namespace/NamespaceContext;

    invoke-interface {v1, p1}, Ljavax/xml/namespace/NamespaceContext;->getPrefixes(Ljava/lang/String;)Ljava/util/Iterator;

    move-result-object v1

    .line 142
    .local v1, "it":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 143
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 145
    .local v2, "p2":Ljava/lang/String;
    invoke-virtual {p0, v2}, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 146
    .local v3, "uri2":Ljava/lang/String;
    invoke-virtual {v3, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 148
    invoke-virtual {p0, v0, v2}, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->addToList(Ljava/util/ArrayList;Ljava/lang/Object;)Ljava/util/ArrayList;

    move-result-object v0

    .line 150
    .end local v2    # "p2":Ljava/lang/String;
    .end local v3    # "uri2":Ljava/lang/String;
    :cond_2
    goto :goto_1

    .line 154
    .end local v1    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    :cond_3
    const-string v1, "http://www.w3.org/XML/1998/namespace"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 155
    const-string v1, "xml"

    invoke-virtual {p0, v0, v1}, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->addToList(Ljava/util/ArrayList;Ljava/lang/Object;)Ljava/util/ArrayList;

    move-result-object v0

    .line 157
    :cond_4
    const-string v1, "http://www.w3.org/2000/xmlns/"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 158
    const-string v1, "xmlns"

    invoke-virtual {p0, v0, v1}, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->addToList(Ljava/util/ArrayList;Ljava/lang/Object;)Ljava/util/ArrayList;

    move-result-object v0

    .line 161
    :cond_5
    const/4 v1, 0x0

    return-object v1

    .line 127
    .end local v0    # "l":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :cond_6
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Illegal to pass null/empty prefix as argument."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
