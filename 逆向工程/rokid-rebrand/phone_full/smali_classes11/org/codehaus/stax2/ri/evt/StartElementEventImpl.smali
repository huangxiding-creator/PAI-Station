.class public Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;
.super Lorg/codehaus/stax2/ri/evt/BaseEventImpl;
.source "StartElementEventImpl.java"

# interfaces
.implements Ljavax/xml/stream/events/StartElement;


# instance fields
.field _actualNsCtxt:Ljavax/xml/namespace/NamespaceContext;

.field protected final _attrs:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljavax/xml/stream/events/Attribute;",
            ">;"
        }
    .end annotation
.end field

.field protected final _name:Ljavax/xml/namespace/QName;

.field protected final _nsDecls:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljavax/xml/stream/events/Namespace;",
            ">;"
        }
    .end annotation
.end field

.field protected _parentNsCtxt:Ljavax/xml/namespace/NamespaceContext;


# direct methods
.method protected constructor <init>(Ljavax/xml/stream/Location;Ljavax/xml/namespace/QName;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljavax/xml/namespace/NamespaceContext;)V
    .locals 1
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "name"    # Ljavax/xml/namespace/QName;
    .param p5, "parentNsCtxt"    # Ljavax/xml/namespace/NamespaceContext;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljavax/xml/stream/Location;",
            "Ljavax/xml/namespace/QName;",
            "Ljava/util/ArrayList<",
            "Ljavax/xml/stream/events/Attribute;",
            ">;",
            "Ljava/util/ArrayList<",
            "Ljavax/xml/stream/events/Namespace;",
            ">;",
            "Ljavax/xml/namespace/NamespaceContext;",
            ")V"
        }
    .end annotation

    .line 54
    .local p3, "attrs":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljavax/xml/stream/events/Attribute;>;"
    .local p4, "nsDecls":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljavax/xml/stream/events/Namespace;>;"
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/evt/BaseEventImpl;-><init>(Ljavax/xml/stream/Location;)V

    .line 42
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_actualNsCtxt:Ljavax/xml/namespace/NamespaceContext;

    .line 55
    iput-object p2, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_name:Ljavax/xml/namespace/QName;

    .line 56
    iput-object p3, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_attrs:Ljava/util/ArrayList;

    .line 57
    iput-object p4, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_nsDecls:Ljava/util/ArrayList;

    .line 58
    if-nez p5, :cond_0

    .line 59
    invoke-static {}, Lorg/codehaus/stax2/ri/EmptyNamespaceContext;->getInstance()Lorg/codehaus/stax2/ri/EmptyNamespaceContext;

    move-result-object v0

    goto :goto_0

    :cond_0
    move-object v0, p5

    :goto_0
    iput-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_parentNsCtxt:Ljavax/xml/namespace/NamespaceContext;

    .line 60
    return-void
.end method

.method public static construct(Ljavax/xml/stream/Location;Ljavax/xml/namespace/QName;Ljava/util/Iterator;Ljava/util/Iterator;Ljavax/xml/namespace/NamespaceContext;)Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;
    .locals 9
    .param p0, "loc"    # Ljavax/xml/stream/Location;
    .param p1, "name"    # Ljavax/xml/namespace/QName;
    .param p4, "nsCtxt"    # Ljavax/xml/namespace/NamespaceContext;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljavax/xml/stream/Location;",
            "Ljavax/xml/namespace/QName;",
            "Ljava/util/Iterator<",
            "*>;",
            "Ljava/util/Iterator<",
            "*>;",
            "Ljavax/xml/namespace/NamespaceContext;",
            ")",
            "Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;"
        }
    .end annotation

    .line 67
    .local p2, "attrIt":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    .local p3, "nsDeclIt":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    if-eqz p2, :cond_2

    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 70
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 73
    .local v0, "attrs":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljavax/xml/stream/events/Attribute;>;"
    :cond_1
    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljavax/xml/stream/events/Attribute;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 74
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_1

    .line 68
    .end local v0    # "attrs":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljavax/xml/stream/events/Attribute;>;"
    :cond_2
    :goto_0
    const/4 v0, 0x0

    .line 78
    .restart local v0    # "attrs":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljavax/xml/stream/events/Attribute;>;"
    :goto_1
    if-eqz p3, :cond_5

    invoke-interface {p3}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-nez v1, :cond_3

    goto :goto_2

    .line 81
    :cond_3
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 83
    .local v1, "nsDecls":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljavax/xml/stream/events/Namespace;>;"
    :cond_4
    invoke-interface {p3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljavax/xml/stream/events/Namespace;

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 84
    invoke-interface {p3}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_4

    move-object v7, v1

    goto :goto_3

    .line 79
    .end local v1    # "nsDecls":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljavax/xml/stream/events/Namespace;>;"
    :cond_5
    :goto_2
    const/4 v1, 0x0

    move-object v7, v1

    .line 86
    .local v7, "nsDecls":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljavax/xml/stream/events/Namespace;>;"
    :goto_3
    new-instance v8, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;

    move-object v1, v8

    move-object v2, p0

    move-object v3, p1

    move-object v4, v0

    move-object v5, v7

    move-object v6, p4

    invoke-direct/range {v1 .. v6}, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;-><init>(Ljavax/xml/stream/Location;Ljavax/xml/namespace/QName;Ljava/util/ArrayList;Ljava/util/ArrayList;Ljavax/xml/namespace/NamespaceContext;)V

    return-object v8
.end method


# virtual methods
.method public asStartElement()Ljavax/xml/stream/events/StartElement;
    .locals 0

    .line 97
    return-object p0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 4
    .param p1, "o"    # Ljava/lang/Object;

    .line 287
    if-ne p1, p0, :cond_0

    const/4 v0, 0x1

    return v0

    .line 288
    :cond_0
    const/4 v0, 0x0

    if-nez p1, :cond_1

    return v0

    .line 290
    :cond_1
    instance-of v1, p1, Ljavax/xml/stream/events/StartElement;

    if-nez v1, :cond_2

    return v0

    .line 292
    :cond_2
    move-object v1, p1

    check-cast v1, Ljavax/xml/stream/events/StartElement;

    .line 295
    .local v1, "other":Ljavax/xml/stream/events/StartElement;
    iget-object v2, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_name:Ljavax/xml/namespace/QName;

    invoke-interface {v1}, Ljavax/xml/stream/events/StartElement;->getName()Ljavax/xml/namespace/QName;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljavax/xml/namespace/QName;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 302
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->getNamespaces()Ljava/util/Iterator;

    move-result-object v2

    invoke-interface {v1}, Ljavax/xml/stream/events/StartElement;->getNamespaces()Ljava/util/Iterator;

    move-result-object v3

    invoke-static {v2, v3}, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->iteratedEquals(Ljava/util/Iterator;Ljava/util/Iterator;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 303
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->getAttributes()Ljava/util/Iterator;

    move-result-object v0

    invoke-interface {v1}, Ljavax/xml/stream/events/StartElement;->getAttributes()Ljava/util/Iterator;

    move-result-object v2

    invoke-static {v0, v2}, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->iteratedEquals(Ljava/util/Iterator;Ljava/util/Iterator;)Z

    move-result v0

    return v0

    .line 306
    :cond_3
    return v0
.end method

.method public getAttributeByName(Ljavax/xml/namespace/QName;)Ljavax/xml/stream/events/Attribute;
    .locals 10
    .param p1, "nameIn"    # Ljavax/xml/namespace/QName;

    .line 241
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_attrs:Ljava/util/ArrayList;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 242
    return-object v1

    .line 245
    :cond_0
    invoke-virtual {p1}, Ljavax/xml/namespace/QName;->getLocalPart()Ljava/lang/String;

    move-result-object v0

    .line 246
    .local v0, "ln":Ljava/lang/String;
    invoke-virtual {p1}, Ljavax/xml/namespace/QName;->getNamespaceURI()Ljava/lang/String;

    move-result-object v2

    .line 247
    .local v2, "uri":Ljava/lang/String;
    iget-object v3, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_attrs:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    .line 249
    .local v3, "len":I
    if-eqz v2, :cond_2

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v4

    if-nez v4, :cond_1

    goto :goto_0

    :cond_1
    const/4 v4, 0x0

    goto :goto_1

    :cond_2
    :goto_0
    const/4 v4, 0x1

    .line 250
    .local v4, "notInNs":Z
    :goto_1
    const/4 v5, 0x0

    .local v5, "i":I
    :goto_2
    if-ge v5, v3, :cond_6

    .line 251
    iget-object v6, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_attrs:Ljava/util/ArrayList;

    invoke-virtual {v6, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljavax/xml/stream/events/Attribute;

    .line 252
    .local v6, "attr":Ljavax/xml/stream/events/Attribute;
    invoke-interface {v6}, Ljavax/xml/stream/events/Attribute;->getName()Ljavax/xml/namespace/QName;

    move-result-object v7

    .line 253
    .local v7, "name":Ljavax/xml/namespace/QName;
    invoke-virtual {v7}, Ljavax/xml/namespace/QName;->getLocalPart()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_5

    .line 254
    invoke-virtual {v7}, Ljavax/xml/namespace/QName;->getNamespaceURI()Ljava/lang/String;

    move-result-object v8

    .line 255
    .local v8, "thisUri":Ljava/lang/String;
    if-eqz v4, :cond_4

    .line 256
    if-eqz v8, :cond_3

    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v9

    if-nez v9, :cond_5

    .line 257
    :cond_3
    return-object v6

    .line 260
    :cond_4
    invoke-virtual {v2, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_5

    .line 261
    return-object v6

    .line 250
    .end local v6    # "attr":Ljavax/xml/stream/events/Attribute;
    .end local v7    # "name":Ljavax/xml/namespace/QName;
    .end local v8    # "thisUri":Ljava/lang/String;
    :cond_5
    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    .line 266
    .end local v5    # "i":I
    :cond_6
    return-object v1
.end method

.method public getAttributes()Ljava/util/Iterator;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Iterator<",
            "Ljavax/xml/stream/events/Attribute;",
            ">;"
        }
    .end annotation

    .line 272
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_attrs:Ljava/util/ArrayList;

    if-nez v0, :cond_0

    .line 273
    invoke-static {}, Lorg/codehaus/stax2/ri/EmptyIterator;->getInstance()Ljava/util/Iterator;

    move-result-object v0

    return-object v0

    .line 275
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_attrs:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    return-object v0
.end method

.method public getEventType()I
    .locals 1

    .line 102
    const/4 v0, 0x1

    return v0
.end method

.method public final getName()Ljavax/xml/namespace/QName;
    .locals 1

    .line 191
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_name:Ljavax/xml/namespace/QName;

    return-object v0
.end method

.method public getNamespaceContext()Ljavax/xml/namespace/NamespaceContext;
    .locals 2

    .line 206
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_actualNsCtxt:Ljavax/xml/namespace/NamespaceContext;

    if-nez v0, :cond_1

    .line 207
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_nsDecls:Ljava/util/ArrayList;

    if-nez v0, :cond_0

    .line 208
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_parentNsCtxt:Ljavax/xml/namespace/NamespaceContext;

    iput-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_actualNsCtxt:Ljavax/xml/namespace/NamespaceContext;

    goto :goto_0

    .line 210
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_parentNsCtxt:Ljavax/xml/namespace/NamespaceContext;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_nsDecls:Ljava/util/ArrayList;

    invoke-static {v0, v1}, Lorg/codehaus/stax2/ri/evt/MergedNsContext;->construct(Ljavax/xml/namespace/NamespaceContext;Ljava/util/List;)Lorg/codehaus/stax2/ri/evt/MergedNsContext;

    move-result-object v0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_actualNsCtxt:Ljavax/xml/namespace/NamespaceContext;

    .line 213
    :cond_1
    :goto_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_actualNsCtxt:Ljavax/xml/namespace/NamespaceContext;

    return-object v0
.end method

.method public getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p1, "prefix"    # Ljava/lang/String;

    .line 219
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_nsDecls:Ljava/util/ArrayList;

    if-eqz v0, :cond_3

    .line 220
    if-nez p1, :cond_0

    .line 221
    const-string p1, ""

    .line 223
    :cond_0
    const/4 v0, 0x0

    .local v0, "i":I
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_nsDecls:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    .local v1, "len":I
    :goto_0
    if-ge v0, v1, :cond_3

    .line 224
    iget-object v2, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_nsDecls:Ljava/util/ArrayList;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljavax/xml/stream/events/Namespace;

    .line 225
    .local v2, "ns":Ljavax/xml/stream/events/Namespace;
    invoke-interface {v2}, Ljavax/xml/stream/events/Namespace;->getPrefix()Ljava/lang/String;

    move-result-object v3

    .line 226
    .local v3, "thisPrefix":Ljava/lang/String;
    if-nez v3, :cond_1

    .line 227
    const-string v3, ""

    .line 229
    :cond_1
    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 230
    invoke-interface {v2}, Ljavax/xml/stream/events/Namespace;->getNamespaceURI()Ljava/lang/String;

    move-result-object v4

    return-object v4

    .line 223
    .end local v2    # "ns":Ljavax/xml/stream/events/Namespace;
    .end local v3    # "thisPrefix":Ljava/lang/String;
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 235
    .end local v0    # "i":I
    .end local v1    # "len":I
    :cond_3
    const/4 v0, 0x0

    return-object v0
.end method

.method public getNamespaces()Ljava/util/Iterator;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Iterator<",
            "Ljavax/xml/stream/events/Namespace;",
            ">;"
        }
    .end annotation

    .line 197
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_nsDecls:Ljava/util/ArrayList;

    if-nez v0, :cond_0

    .line 198
    invoke-static {}, Lorg/codehaus/stax2/ri/EmptyIterator;->getInstance()Ljava/util/Iterator;

    move-result-object v0

    return-object v0

    .line 200
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_nsDecls:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    return-object v0
.end method

.method public hashCode()I
    .locals 2

    .line 312
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_name:Ljavax/xml/namespace/QName;

    invoke-virtual {v0}, Ljavax/xml/namespace/QName;->hashCode()I

    move-result v0

    .line 313
    .local v0, "hash":I
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->getNamespaces()Ljava/util/Iterator;

    move-result-object v1

    invoke-static {v1, v0}, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->addHash(Ljava/util/Iterator;I)I

    move-result v0

    .line 314
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->getAttributes()Ljava/util/Iterator;

    move-result-object v1

    invoke-static {v1, v0}, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->addHash(Ljava/util/Iterator;I)I

    move-result v0

    .line 315
    return v0
.end method

.method public isStartElement()Z
    .locals 1

    .line 107
    const/4 v0, 0x1

    return v0
.end method

.method public writeAsEncodedUnicode(Ljava/io/Writer;)V
    .locals 6
    .param p1, "w"    # Ljava/io/Writer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 115
    const/16 v0, 0x3c

    :try_start_0
    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(I)V

    .line 116
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_name:Ljavax/xml/namespace/QName;

    invoke-virtual {v0}, Ljavax/xml/namespace/QName;->getPrefix()Ljava/lang/String;

    move-result-object v0

    .line 117
    .local v0, "prefix":Ljava/lang/String;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    .line 118
    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 119
    const/16 v1, 0x3a

    invoke-virtual {p1, v1}, Ljava/io/Writer;->write(I)V

    .line 121
    :cond_0
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_name:Ljavax/xml/namespace/QName;

    invoke-virtual {v1}, Ljavax/xml/namespace/QName;->getLocalPart()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 124
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_nsDecls:Ljava/util/ArrayList;

    const/16 v2, 0x20

    if-eqz v1, :cond_1

    .line 125
    const/4 v1, 0x0

    .local v1, "i":I
    iget-object v3, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_nsDecls:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    .local v3, "len":I
    :goto_0
    if-ge v1, v3, :cond_1

    .line 126
    invoke-virtual {p1, v2}, Ljava/io/Writer;->write(I)V

    .line 127
    iget-object v4, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_nsDecls:Ljava/util/ArrayList;

    invoke-virtual {v4, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljavax/xml/stream/events/Namespace;

    invoke-interface {v4, p1}, Ljavax/xml/stream/events/Namespace;->writeAsEncodedUnicode(Ljava/io/Writer;)V

    .line 125
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 132
    .end local v1    # "i":I
    .end local v3    # "len":I
    :cond_1
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_attrs:Ljava/util/ArrayList;

    if-eqz v1, :cond_3

    .line 133
    const/4 v1, 0x0

    .restart local v1    # "i":I
    iget-object v3, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_attrs:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    .restart local v3    # "len":I
    :goto_1
    if-ge v1, v3, :cond_3

    .line 134
    iget-object v4, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_attrs:Ljava/util/ArrayList;

    invoke-virtual {v4, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljavax/xml/stream/events/Attribute;

    .line 136
    .local v4, "attr":Ljavax/xml/stream/events/Attribute;
    invoke-interface {v4}, Ljavax/xml/stream/events/Attribute;->isSpecified()Z

    move-result v5

    if-eqz v5, :cond_2

    .line 137
    invoke-virtual {p1, v2}, Ljava/io/Writer;->write(I)V

    .line 138
    invoke-interface {v4, p1}, Ljavax/xml/stream/events/Attribute;->writeAsEncodedUnicode(Ljava/io/Writer;)V

    .line 133
    .end local v4    # "attr":Ljavax/xml/stream/events/Attribute;
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 143
    .end local v1    # "i":I
    .end local v3    # "len":I
    :cond_3
    const/16 v1, 0x3e

    invoke-virtual {p1, v1}, Ljava/io/Writer;->write(I)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 146
    .end local v0    # "prefix":Ljava/lang/String;
    nop

    .line 147
    return-void

    .line 144
    :catch_0
    move-exception v0

    .line 145
    .local v0, "ie":Ljava/io/IOException;
    new-instance v1, Ljavax/xml/stream/XMLStreamException;

    invoke-direct {v1, v0}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public writeUsing(Lorg/codehaus/stax2/XMLStreamWriter2;)V
    .locals 9
    .param p1, "sw"    # Lorg/codehaus/stax2/XMLStreamWriter2;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 152
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_name:Ljavax/xml/namespace/QName;

    .line 153
    .local v0, "n":Ljavax/xml/namespace/QName;
    invoke-virtual {v0}, Ljavax/xml/namespace/QName;->getPrefix()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0}, Ljavax/xml/namespace/QName;->getLocalPart()Ljava/lang/String;

    move-result-object v2

    .line 154
    invoke-virtual {v0}, Ljavax/xml/namespace/QName;->getNamespaceURI()Ljava/lang/String;

    move-result-object v3

    .line 153
    invoke-interface {p1, v1, v2, v3}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeStartElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 157
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_nsDecls:Ljava/util/ArrayList;

    if-eqz v1, :cond_2

    .line 158
    const/4 v1, 0x0

    .local v1, "i":I
    iget-object v2, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_nsDecls:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    .local v2, "len":I
    :goto_0
    if-ge v1, v2, :cond_2

    .line 159
    iget-object v3, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_nsDecls:Ljava/util/ArrayList;

    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljavax/xml/stream/events/Namespace;

    .line 160
    .local v3, "ns":Ljavax/xml/stream/events/Namespace;
    invoke-interface {v3}, Ljavax/xml/stream/events/Namespace;->getPrefix()Ljava/lang/String;

    move-result-object v4

    .line 161
    .local v4, "prefix":Ljava/lang/String;
    invoke-interface {v3}, Ljavax/xml/stream/events/Namespace;->getNamespaceURI()Ljava/lang/String;

    move-result-object v5

    .line 162
    .local v5, "uri":Ljava/lang/String;
    if-eqz v4, :cond_1

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v6

    if-nez v6, :cond_0

    goto :goto_1

    .line 165
    :cond_0
    invoke-interface {p1, v4, v5}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeNamespace(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    .line 163
    :cond_1
    :goto_1
    invoke-interface {p1, v5}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeDefaultNamespace(Ljava/lang/String;)V

    .line 158
    .end local v3    # "ns":Ljavax/xml/stream/events/Namespace;
    .end local v4    # "prefix":Ljava/lang/String;
    .end local v5    # "uri":Ljava/lang/String;
    :goto_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 171
    .end local v1    # "i":I
    .end local v2    # "len":I
    :cond_2
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_attrs:Ljava/util/ArrayList;

    if-eqz v1, :cond_4

    .line 172
    const/4 v1, 0x0

    .restart local v1    # "i":I
    iget-object v2, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_attrs:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    .restart local v2    # "len":I
    :goto_3
    if-ge v1, v2, :cond_4

    .line 173
    iget-object v3, p0, Lorg/codehaus/stax2/ri/evt/StartElementEventImpl;->_attrs:Ljava/util/ArrayList;

    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljavax/xml/stream/events/Attribute;

    .line 175
    .local v3, "attr":Ljavax/xml/stream/events/Attribute;
    invoke-interface {v3}, Ljavax/xml/stream/events/Attribute;->isSpecified()Z

    move-result v4

    if-eqz v4, :cond_3

    .line 176
    invoke-interface {v3}, Ljavax/xml/stream/events/Attribute;->getName()Ljavax/xml/namespace/QName;

    move-result-object v4

    .line 177
    .local v4, "name":Ljavax/xml/namespace/QName;
    invoke-virtual {v4}, Ljavax/xml/namespace/QName;->getPrefix()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4}, Ljavax/xml/namespace/QName;->getNamespaceURI()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4}, Ljavax/xml/namespace/QName;->getLocalPart()Ljava/lang/String;

    move-result-object v7

    invoke-interface {v3}, Ljavax/xml/stream/events/Attribute;->getValue()Ljava/lang/String;

    move-result-object v8

    invoke-interface {p1, v5, v6, v7, v8}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 172
    .end local v3    # "attr":Ljavax/xml/stream/events/Attribute;
    .end local v4    # "name":Ljavax/xml/namespace/QName;
    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    .line 181
    .end local v1    # "i":I
    .end local v2    # "len":I
    :cond_4
    return-void
.end method
