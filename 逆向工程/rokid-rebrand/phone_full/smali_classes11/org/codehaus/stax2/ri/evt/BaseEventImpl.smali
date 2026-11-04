.class public abstract Lorg/codehaus/stax2/ri/evt/BaseEventImpl;
.super Ljava/lang/Object;
.source "BaseEventImpl.java"

# interfaces
.implements Lorg/codehaus/stax2/evt/XMLEvent2;


# instance fields
.field protected final mLocation:Ljavax/xml/stream/Location;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field


# direct methods
.method protected constructor <init>(Ljavax/xml/stream/Location;)V
    .locals 0
    .param p1, "loc"    # Ljavax/xml/stream/Location;

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    iput-object p1, p0, Lorg/codehaus/stax2/ri/evt/BaseEventImpl;->mLocation:Ljavax/xml/stream/Location;

    .line 37
    return-void
.end method

.method protected static addHash(Ljava/util/Iterator;I)I
    .locals 2
    .param p1, "baseHash"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Iterator<",
            "*>;I)I"
        }
    .end annotation

    .line 210
    .local p0, "it":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    move v0, p1

    .line 211
    .local v0, "hash":I
    if-eqz p0, :cond_0

    .line 212
    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 213
    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->hashCode()I

    move-result v1

    xor-int/2addr v0, v1

    goto :goto_0

    .line 216
    :cond_0
    return v0
.end method

.method protected static iteratedEquals(Ljava/util/Iterator;Ljava/util/Iterator;)Z
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Iterator<",
            "*>;",
            "Ljava/util/Iterator<",
            "*>;)Z"
        }
    .end annotation

    .line 190
    .local p0, "it1":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    .local p1, "it2":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    const/4 v0, 0x1

    const/4 v1, 0x0

    if-eqz p0, :cond_4

    if-nez p1, :cond_0

    goto :goto_1

    .line 194
    :cond_0
    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 195
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-nez v2, :cond_1

    .line 196
    return v1

    .line 198
    :cond_1
    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    .line 199
    .local v2, "o1":Ljava/lang/Object;
    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .line 201
    .local v3, "o2":Ljava/lang/Object;
    invoke-virtual {v2, v3}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_2

    .line 202
    return v1

    .line 204
    .end local v2    # "o1":Ljava/lang/Object;
    .end local v3    # "o2":Ljava/lang/Object;
    :cond_2
    goto :goto_0

    .line 205
    :cond_3
    return v0

    .line 191
    :cond_4
    :goto_1
    if-ne p0, p1, :cond_5

    goto :goto_2

    :cond_5
    move v0, v1

    :goto_2
    return v0
.end method

.method protected static stringsWithNullsEqual(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 3
    .param p0, "s1"    # Ljava/lang/String;
    .param p1, "s2"    # Ljava/lang/String;

    .line 182
    const/4 v0, 0x0

    const/4 v1, 0x1

    if-eqz p0, :cond_2

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_0

    goto :goto_0

    .line 185
    :cond_0
    if-eqz p1, :cond_1

    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    move v0, v1

    :cond_1
    return v0

    .line 183
    :cond_2
    :goto_0
    if-eqz p1, :cond_3

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_4

    :cond_3
    move v0, v1

    :cond_4
    return v0
.end method


# virtual methods
.method public asCharacters()Ljavax/xml/stream/events/Characters;
    .locals 1

    .line 47
    move-object v0, p0

    check-cast v0, Ljavax/xml/stream/events/Characters;

    return-object v0
.end method

.method public asEndElement()Ljavax/xml/stream/events/EndElement;
    .locals 1

    .line 52
    move-object v0, p0

    check-cast v0, Ljavax/xml/stream/events/EndElement;

    return-object v0
.end method

.method public asStartElement()Ljavax/xml/stream/events/StartElement;
    .locals 1

    .line 57
    move-object v0, p0

    check-cast v0, Ljavax/xml/stream/events/StartElement;

    return-object v0
.end method

.method public abstract equals(Ljava/lang/Object;)Z
.end method

.method public abstract getEventType()I
.end method

.method public getLocation()Ljavax/xml/stream/Location;
    .locals 1

    .line 65
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/BaseEventImpl;->mLocation:Ljavax/xml/stream/Location;

    return-object v0
.end method

.method public getSchemaType()Ljavax/xml/namespace/QName;
    .locals 1

    .line 70
    const/4 v0, 0x0

    return-object v0
.end method

.method public abstract hashCode()I
.end method

.method public isAttribute()Z
    .locals 1

    .line 76
    const/4 v0, 0x0

    return v0
.end method

.method public isCharacters()Z
    .locals 1

    .line 82
    const/4 v0, 0x0

    return v0
.end method

.method public isEndDocument()Z
    .locals 1

    .line 88
    const/4 v0, 0x0

    return v0
.end method

.method public isEndElement()Z
    .locals 1

    .line 94
    const/4 v0, 0x0

    return v0
.end method

.method public isEntityReference()Z
    .locals 1

    .line 100
    const/4 v0, 0x0

    return v0
.end method

.method public isNamespace()Z
    .locals 1

    .line 106
    const/4 v0, 0x0

    return v0
.end method

.method public isProcessingInstruction()Z
    .locals 1

    .line 112
    const/4 v0, 0x0

    return v0
.end method

.method public isStartDocument()Z
    .locals 1

    .line 118
    const/4 v0, 0x0

    return v0
.end method

.method public isStartElement()Z
    .locals 1

    .line 124
    const/4 v0, 0x0

    return v0
.end method

.method protected throwFromIOE(Ljava/io/IOException;)V
    .locals 2
    .param p1, "ioe"    # Ljava/io/IOException;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 172
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    invoke-virtual {p1}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1, p1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 160
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[Stax Event #"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/BaseEventImpl;->getEventType()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public abstract writeAsEncodedUnicode(Ljava/io/Writer;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeUsing(Lorg/codehaus/stax2/XMLStreamWriter2;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method
