.class public Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;
.super Lorg/codehaus/stax2/ri/evt/BaseEventImpl;
.source "EntityDeclarationEventImpl.java"

# interfaces
.implements Ljavax/xml/stream/events/EntityDeclaration;


# instance fields
.field protected final mName:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljavax/xml/stream/Location;Ljava/lang/String;)V
    .locals 0
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "name"    # Ljava/lang/String;

    .line 24
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/evt/BaseEventImpl;-><init>(Ljavax/xml/stream/Location;)V

    .line 25
    iput-object p2, p0, Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;->mName:Ljava/lang/String;

    .line 26
    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 118
    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    return v0

    .line 119
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    return v1

    .line 121
    :cond_1
    instance-of v2, p1, Ljavax/xml/stream/events/EntityDeclaration;

    if-nez v2, :cond_2

    return v1

    .line 123
    :cond_2
    move-object v2, p1

    check-cast v2, Ljavax/xml/stream/events/EntityDeclaration;

    .line 124
    .local v2, "other":Ljavax/xml/stream/events/EntityDeclaration;
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2}, Ljavax/xml/stream/events/EntityDeclaration;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;->stringsWithNullsEqual(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 125
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;->getBaseURI()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2}, Ljavax/xml/stream/events/EntityDeclaration;->getBaseURI()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;->stringsWithNullsEqual(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 126
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;->getNotationName()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2}, Ljavax/xml/stream/events/EntityDeclaration;->getNotationName()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;->stringsWithNullsEqual(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 127
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;->getPublicId()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2}, Ljavax/xml/stream/events/EntityDeclaration;->getPublicId()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;->stringsWithNullsEqual(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 128
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;->getReplacementText()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2}, Ljavax/xml/stream/events/EntityDeclaration;->getReplacementText()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;->stringsWithNullsEqual(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 129
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;->getSystemId()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2}, Ljavax/xml/stream/events/EntityDeclaration;->getSystemId()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;->stringsWithNullsEqual(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    goto :goto_0

    :cond_3
    move v0, v1

    .line 124
    :goto_0
    return v0
.end method

.method public getBaseURI()Ljava/lang/String;
    .locals 1

    .line 37
    const-string v0, ""

    return-object v0
.end method

.method public getEventType()I
    .locals 1

    .line 78
    const/16 v0, 0xf

    return v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    .line 43
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;->mName:Ljava/lang/String;

    return-object v0
.end method

.method public getNotationName()Ljava/lang/String;
    .locals 1

    .line 49
    const/4 v0, 0x0

    return-object v0
.end method

.method public getPublicId()Ljava/lang/String;
    .locals 1

    .line 55
    const/4 v0, 0x0

    return-object v0
.end method

.method public getReplacementText()Ljava/lang/String;
    .locals 1

    .line 61
    const/4 v0, 0x0

    return-object v0
.end method

.method public getSystemId()Ljava/lang/String;
    .locals 1

    .line 67
    const/4 v0, 0x0

    return-object v0
.end method

.method public hashCode()I
    .locals 1

    .line 137
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;->mName:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

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

    .line 86
    :try_start_0
    const-string v0, "<!ENTITY "

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 87
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 88
    const-string v0, " \""

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 90
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;->getReplacementText()Ljava/lang/String;

    move-result-object v0

    .line 91
    .local v0, "content":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 92
    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 94
    :cond_0
    const-string v1, "\">"

    invoke-virtual {p1, v1}, Ljava/io/Writer;->write(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 97
    .end local v0    # "content":Ljava/lang/String;
    goto :goto_0

    .line 95
    :catch_0
    move-exception v0

    .line 96
    .local v0, "ie":Ljava/io/IOException;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;->throwFromIOE(Ljava/io/IOException;)V

    .line 98
    .end local v0    # "ie":Ljava/io/IOException;
    :goto_0
    return-void
.end method

.method public writeUsing(Lorg/codehaus/stax2/XMLStreamWriter2;)V
    .locals 2
    .param p1, "w"    # Lorg/codehaus/stax2/XMLStreamWriter2;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 104
    new-instance v0, Ljava/io/StringWriter;

    invoke-direct {v0}, Ljava/io/StringWriter;-><init>()V

    .line 105
    .local v0, "strw":Ljava/io/StringWriter;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;->writeAsEncodedUnicode(Ljava/io/Writer;)V

    .line 106
    invoke-virtual {v0}, Ljava/io/StringWriter;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1, v1}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeRaw(Ljava/lang/String;)V

    .line 107
    return-void
.end method
