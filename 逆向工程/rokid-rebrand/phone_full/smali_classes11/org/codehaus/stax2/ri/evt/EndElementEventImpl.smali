.class public Lorg/codehaus/stax2/ri/evt/EndElementEventImpl;
.super Lorg/codehaus/stax2/ri/evt/BaseEventImpl;
.source "EndElementEventImpl.java"

# interfaces
.implements Ljavax/xml/stream/events/EndElement;


# instance fields
.field protected final mName:Ljavax/xml/namespace/QName;

.field protected final mNamespaces:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljavax/xml/stream/events/Namespace;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljavax/xml/stream/Location;Ljavax/xml/namespace/QName;Ljava/util/Iterator;)V
    .locals 2
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "name"    # Ljavax/xml/namespace/QName;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljavax/xml/stream/Location;",
            "Ljavax/xml/namespace/QName;",
            "Ljava/util/Iterator<",
            "Ljavax/xml/stream/events/Namespace;",
            ">;)V"
        }
    .end annotation

    .line 53
    .local p3, "namespaces":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljavax/xml/stream/events/Namespace;>;"
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/evt/BaseEventImpl;-><init>(Ljavax/xml/stream/Location;)V

    .line 54
    iput-object p2, p0, Lorg/codehaus/stax2/ri/evt/EndElementEventImpl;->mName:Ljavax/xml/namespace/QName;

    .line 55
    if-eqz p3, :cond_2

    invoke-interface {p3}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_1

    .line 58
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 59
    .local v0, "l":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljavax/xml/stream/events/Namespace;>;"
    :goto_0
    invoke-interface {p3}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 64
    invoke-interface {p3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljavax/xml/stream/events/Namespace;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 66
    :cond_1
    iput-object v0, p0, Lorg/codehaus/stax2/ri/evt/EndElementEventImpl;->mNamespaces:Ljava/util/ArrayList;

    goto :goto_2

    .line 56
    .end local v0    # "l":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljavax/xml/stream/events/Namespace;>;"
    :cond_2
    :goto_1
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/evt/EndElementEventImpl;->mNamespaces:Ljava/util/ArrayList;

    .line 68
    :goto_2
    return-void
.end method

.method public constructor <init>(Ljavax/xml/stream/Location;Ljavax/xml/stream/XMLStreamReader;)V
    .locals 5
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "r"    # Ljavax/xml/stream/XMLStreamReader;

    .line 31
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/evt/BaseEventImpl;-><init>(Ljavax/xml/stream/Location;)V

    .line 32
    invoke-interface {p2}, Ljavax/xml/stream/XMLStreamReader;->getName()Ljavax/xml/namespace/QName;

    move-result-object v0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/evt/EndElementEventImpl;->mName:Ljavax/xml/namespace/QName;

    .line 35
    invoke-interface {p2}, Ljavax/xml/stream/XMLStreamReader;->getNamespaceCount()I

    move-result v0

    .line 36
    .local v0, "nsCount":I
    if-nez v0, :cond_0

    .line 37
    const/4 v1, 0x0

    iput-object v1, p0, Lorg/codehaus/stax2/ri/evt/EndElementEventImpl;->mNamespaces:Ljava/util/ArrayList;

    goto :goto_1

    .line 39
    :cond_0
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, v0}, Ljava/util/ArrayList;-><init>(I)V

    .line 40
    .local v1, "l":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljavax/xml/stream/events/Namespace;>;"
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, v0, :cond_1

    .line 41
    nop

    .line 42
    invoke-interface {p2, v2}, Ljavax/xml/stream/XMLStreamReader;->getNamespacePrefix(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {p2, v2}, Ljavax/xml/stream/XMLStreamReader;->getNamespaceURI(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {p1, v3, v4}, Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;->constructNamespace(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;)Lorg/codehaus/stax2/ri/evt/NamespaceEventImpl;

    move-result-object v3

    .line 41
    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 40
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 44
    .end local v2    # "i":I
    :cond_1
    iput-object v1, p0, Lorg/codehaus/stax2/ri/evt/EndElementEventImpl;->mNamespaces:Ljava/util/ArrayList;

    .line 46
    .end local v1    # "l":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljavax/xml/stream/events/Namespace;>;"
    :goto_1
    return-void
.end method


# virtual methods
.method public asEndElement()Ljavax/xml/stream/events/EndElement;
    .locals 0

    .line 98
    return-object p0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 143
    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    return v0

    .line 144
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    return v1

    .line 146
    :cond_1
    instance-of v2, p1, Ljavax/xml/stream/events/EndElement;

    if-nez v2, :cond_2

    return v1

    .line 148
    :cond_2
    move-object v2, p1

    check-cast v2, Ljavax/xml/stream/events/EndElement;

    .line 150
    .local v2, "other":Ljavax/xml/stream/events/EndElement;
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/EndElementEventImpl;->getName()Ljavax/xml/namespace/QName;

    move-result-object v3

    invoke-interface {v2}, Ljavax/xml/stream/events/EndElement;->getName()Ljavax/xml/namespace/QName;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljavax/xml/namespace/QName;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 156
    return v0

    .line 158
    :cond_3
    return v1
.end method

.method public getEventType()I
    .locals 1

    .line 103
    const/4 v0, 0x2

    return v0
.end method

.method public getName()Ljavax/xml/namespace/QName;
    .locals 1

    .line 78
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/EndElementEventImpl;->mName:Ljavax/xml/namespace/QName;

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

    .line 84
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/EndElementEventImpl;->mNamespaces:Ljava/util/ArrayList;

    if-nez v0, :cond_0

    .line 85
    invoke-static {}, Lorg/codehaus/stax2/ri/EmptyIterator;->getInstance()Ljava/util/Iterator;

    move-result-object v0

    return-object v0

    .line 87
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/EndElementEventImpl;->mNamespaces:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    return-object v0
.end method

.method public hashCode()I
    .locals 1

    .line 164
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/EndElementEventImpl;->getName()Ljavax/xml/namespace/QName;

    move-result-object v0

    invoke-virtual {v0}, Ljavax/xml/namespace/QName;->hashCode()I

    move-result v0

    return v0
.end method

.method public isEndElement()Z
    .locals 1

    .line 108
    const/4 v0, 0x1

    return v0
.end method

.method public writeAsEncodedUnicode(Ljava/io/Writer;)V
    .locals 2
    .param p1, "w"    # Ljava/io/Writer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 116
    :try_start_0
    const-string v0, "</"

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 117
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/EndElementEventImpl;->mName:Ljavax/xml/namespace/QName;

    invoke-virtual {v0}, Ljavax/xml/namespace/QName;->getPrefix()Ljava/lang/String;

    move-result-object v0

    .line 118
    .local v0, "prefix":Ljava/lang/String;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    .line 119
    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 120
    const/16 v1, 0x3a

    invoke-virtual {p1, v1}, Ljava/io/Writer;->write(I)V

    .line 122
    :cond_0
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/EndElementEventImpl;->mName:Ljavax/xml/namespace/QName;

    invoke-virtual {v1}, Ljavax/xml/namespace/QName;->getLocalPart()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 123
    const/16 v1, 0x3e

    invoke-virtual {p1, v1}, Ljava/io/Writer;->write(I)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 126
    .end local v0    # "prefix":Ljava/lang/String;
    goto :goto_0

    .line 124
    :catch_0
    move-exception v0

    .line 125
    .local v0, "ie":Ljava/io/IOException;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/evt/EndElementEventImpl;->throwFromIOE(Ljava/io/IOException;)V

    .line 127
    .end local v0    # "ie":Ljava/io/IOException;
    :goto_0
    return-void
.end method

.method public writeUsing(Lorg/codehaus/stax2/XMLStreamWriter2;)V
    .locals 0
    .param p1, "w"    # Lorg/codehaus/stax2/XMLStreamWriter2;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 131
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeEndElement()V

    .line 132
    return-void
.end method
