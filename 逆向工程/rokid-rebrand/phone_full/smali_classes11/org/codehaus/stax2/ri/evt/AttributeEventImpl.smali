.class public Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;
.super Lorg/codehaus/stax2/ri/evt/BaseEventImpl;
.source "AttributeEventImpl.java"

# interfaces
.implements Ljavax/xml/stream/events/Attribute;


# instance fields
.field final mName:Ljavax/xml/namespace/QName;

.field final mValue:Ljava/lang/String;

.field final mWasSpecified:Z


# direct methods
.method public constructor <init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 1
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "localName"    # Ljava/lang/String;
    .param p3, "uri"    # Ljava/lang/String;
    .param p4, "prefix"    # Ljava/lang/String;
    .param p5, "value"    # Ljava/lang/String;
    .param p6, "wasSpecified"    # Z

    .line 23
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/evt/BaseEventImpl;-><init>(Ljavax/xml/stream/Location;)V

    .line 24
    iput-object p5, p0, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->mValue:Ljava/lang/String;

    .line 25
    if-nez p4, :cond_1

    .line 26
    if-nez p3, :cond_0

    .line 27
    new-instance v0, Ljavax/xml/namespace/QName;

    invoke-direct {v0, p2}, Ljavax/xml/namespace/QName;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->mName:Ljavax/xml/namespace/QName;

    goto :goto_0

    .line 29
    :cond_0
    new-instance v0, Ljavax/xml/namespace/QName;

    invoke-direct {v0, p3, p2}, Ljavax/xml/namespace/QName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->mName:Ljavax/xml/namespace/QName;

    goto :goto_0

    .line 32
    :cond_1
    if-nez p3, :cond_2

    .line 33
    const-string p3, ""

    .line 35
    :cond_2
    new-instance v0, Ljavax/xml/namespace/QName;

    invoke-direct {v0, p3, p2, p4}, Ljavax/xml/namespace/QName;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->mName:Ljavax/xml/namespace/QName;

    .line 37
    :goto_0
    iput-boolean p6, p0, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->mWasSpecified:Z

    .line 38
    return-void
.end method

.method public constructor <init>(Ljavax/xml/stream/Location;Ljavax/xml/namespace/QName;Ljava/lang/String;Z)V
    .locals 0
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "name"    # Ljavax/xml/namespace/QName;
    .param p3, "value"    # Ljava/lang/String;
    .param p4, "wasSpecified"    # Z

    .line 42
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/evt/BaseEventImpl;-><init>(Ljavax/xml/stream/Location;)V

    .line 43
    iput-object p2, p0, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->mName:Ljavax/xml/namespace/QName;

    .line 44
    iput-object p3, p0, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->mValue:Ljava/lang/String;

    .line 45
    iput-boolean p4, p0, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->mWasSpecified:Z

    .line 46
    return-void
.end method

.method protected static writeEscapedAttrValue(Ljava/io/Writer;Ljava/lang/String;)V
    .locals 8
    .param p0, "w"    # Ljava/io/Writer;
    .param p1, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 173
    const/4 v0, 0x0

    .line 174
    .local v0, "i":I
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    .line 176
    .local v1, "len":I
    :cond_0
    move v2, v0

    .line 177
    .local v2, "start":I
    const/4 v3, 0x0

    .line 179
    .local v3, "c":C
    :goto_0
    const/16 v4, 0x22

    const/16 v5, 0x26

    const/16 v6, 0x3c

    if-ge v0, v1, :cond_2

    .line 180
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 181
    if-eq v3, v6, :cond_2

    if-eq v3, v5, :cond_2

    if-ne v3, v4, :cond_1

    .line 182
    goto :goto_1

    .line 179
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 185
    :cond_2
    :goto_1
    sub-int v7, v0, v2

    .line 186
    .local v7, "outLen":I
    if-lez v7, :cond_3

    .line 187
    invoke-virtual {p0, p1, v2, v7}, Ljava/io/Writer;->write(Ljava/lang/String;II)V

    .line 189
    :cond_3
    if-ge v0, v1, :cond_6

    .line 190
    if-ne v3, v6, :cond_4

    .line 191
    const-string v4, "&lt;"

    invoke-virtual {p0, v4}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    goto :goto_2

    .line 192
    :cond_4
    if-ne v3, v5, :cond_5

    .line 193
    const-string v4, "&amp;"

    invoke-virtual {p0, v4}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    goto :goto_2

    .line 194
    :cond_5
    if-ne v3, v4, :cond_6

    .line 195
    const-string v4, "&quot;"

    invoke-virtual {p0, v4}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 199
    .end local v2    # "start":I
    .end local v3    # "c":C
    .end local v7    # "outLen":I
    :cond_6
    :goto_2
    add-int/lit8 v0, v0, 0x1

    if-lt v0, v1, :cond_0

    .line 200
    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 4
    .param p1, "o"    # Ljava/lang/Object;

    .line 134
    if-ne p1, p0, :cond_0

    const/4 v0, 0x1

    return v0

    .line 135
    :cond_0
    const/4 v0, 0x0

    if-nez p1, :cond_1

    return v0

    .line 136
    :cond_1
    instance-of v1, p1, Ljavax/xml/stream/events/Attribute;

    if-nez v1, :cond_2

    return v0

    .line 138
    :cond_2
    move-object v1, p1

    check-cast v1, Ljavax/xml/stream/events/Attribute;

    .line 139
    .local v1, "other":Ljavax/xml/stream/events/Attribute;
    iget-object v2, p0, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->mName:Ljavax/xml/namespace/QName;

    invoke-interface {v1}, Ljavax/xml/stream/events/Attribute;->getName()Ljavax/xml/namespace/QName;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljavax/xml/namespace/QName;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    iget-object v2, p0, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->mValue:Ljava/lang/String;

    .line 140
    invoke-interface {v1}, Ljavax/xml/stream/events/Attribute;->getValue()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 146
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->isSpecified()Z

    move-result v2

    invoke-interface {v1}, Ljavax/xml/stream/events/Attribute;->isSpecified()Z

    move-result v3

    if-ne v2, v3, :cond_3

    .line 147
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->getDTDType()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v1}, Ljavax/xml/stream/events/Attribute;->getDTDType()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v2}, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->stringsWithNullsEqual(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    return v0

    .line 150
    :cond_3
    return v0
.end method

.method public getDTDType()Ljava/lang/String;
    .locals 1

    .line 104
    const-string v0, "CDATA"

    return-object v0
.end method

.method public getEventType()I
    .locals 1

    .line 56
    const/16 v0, 0xa

    return v0
.end method

.method public getName()Ljavax/xml/namespace/QName;
    .locals 1

    .line 110
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->mName:Ljavax/xml/namespace/QName;

    return-object v0
.end method

.method public getValue()Ljava/lang/String;
    .locals 1

    .line 116
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->mValue:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 2

    .line 161
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->mName:Ljavax/xml/namespace/QName;

    invoke-virtual {v0}, Ljavax/xml/namespace/QName;->hashCode()I

    move-result v0

    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->mValue:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    xor-int/2addr v0, v1

    return v0
.end method

.method public isAttribute()Z
    .locals 1

    .line 60
    const/4 v0, 0x1

    return v0
.end method

.method public isSpecified()Z
    .locals 1

    .line 122
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->mWasSpecified:Z

    return v0
.end method

.method public writeAsEncodedUnicode(Ljava/io/Writer;)V
    .locals 3
    .param p1, "w"    # Ljava/io/Writer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 69
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->mName:Ljavax/xml/namespace/QName;

    invoke-virtual {v0}, Ljavax/xml/namespace/QName;->getPrefix()Ljava/lang/String;

    move-result-object v0

    .line 71
    .local v0, "prefix":Ljava/lang/String;
    if-eqz v0, :cond_0

    :try_start_0
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    .line 72
    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 73
    const/16 v1, 0x3a

    invoke-virtual {p1, v1}, Ljava/io/Writer;->write(I)V

    .line 75
    :cond_0
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->mName:Ljavax/xml/namespace/QName;

    invoke-virtual {v1}, Ljavax/xml/namespace/QName;->getLocalPart()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 76
    const/16 v1, 0x3d

    invoke-virtual {p1, v1}, Ljava/io/Writer;->write(I)V

    .line 77
    const/16 v1, 0x22

    invoke-virtual {p1, v1}, Ljava/io/Writer;->write(I)V

    .line 78
    iget-object v2, p0, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->mValue:Ljava/lang/String;

    invoke-static {p1, v2}, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->writeEscapedAttrValue(Ljava/io/Writer;Ljava/lang/String;)V

    .line 79
    invoke-virtual {p1, v1}, Ljava/io/Writer;->write(I)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 82
    goto :goto_0

    .line 80
    :catch_0
    move-exception v1

    .line 81
    .local v1, "ie":Ljava/io/IOException;
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->throwFromIOE(Ljava/io/IOException;)V

    .line 83
    .end local v1    # "ie":Ljava/io/IOException;
    :goto_0
    return-void
.end method

.method public writeUsing(Lorg/codehaus/stax2/XMLStreamWriter2;)V
    .locals 5
    .param p1, "w"    # Lorg/codehaus/stax2/XMLStreamWriter2;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 88
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->mName:Ljavax/xml/namespace/QName;

    .line 89
    .local v0, "n":Ljavax/xml/namespace/QName;
    invoke-virtual {v0}, Ljavax/xml/namespace/QName;->getPrefix()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0}, Ljavax/xml/namespace/QName;->getLocalPart()Ljava/lang/String;

    move-result-object v2

    .line 90
    invoke-virtual {v0}, Ljavax/xml/namespace/QName;->getNamespaceURI()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lorg/codehaus/stax2/ri/evt/AttributeEventImpl;->mValue:Ljava/lang/String;

    .line 89
    invoke-interface {p1, v1, v2, v3, v4}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 91
    return-void
.end method
