.class public Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;
.super Lorg/codehaus/stax2/ri/evt/BaseEventImpl;
.source "NotationDeclarationEventImpl.java"

# interfaces
.implements Lorg/codehaus/stax2/evt/NotationDeclaration2;


# instance fields
.field final mName:Ljava/lang/String;

.field final mPublicId:Ljava/lang/String;

.field final mSystemId:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "name"    # Ljava/lang/String;
    .param p3, "pubId"    # Ljava/lang/String;
    .param p4, "sysId"    # Ljava/lang/String;

    .line 27
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/evt/BaseEventImpl;-><init>(Ljavax/xml/stream/Location;)V

    .line 28
    iput-object p2, p0, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->mName:Ljava/lang/String;

    .line 29
    iput-object p3, p0, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->mPublicId:Ljava/lang/String;

    .line 30
    iput-object p4, p0, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->mSystemId:Ljava/lang/String;

    .line 31
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
    instance-of v2, p1, Lorg/codehaus/stax2/evt/NotationDeclaration2;

    if-nez v2, :cond_2

    return v1

    .line 123
    :cond_2
    move-object v2, p1

    check-cast v2, Lorg/codehaus/stax2/evt/NotationDeclaration2;

    .line 125
    .local v2, "other":Lorg/codehaus/stax2/evt/NotationDeclaration2;
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2}, Lorg/codehaus/stax2/evt/NotationDeclaration2;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->stringsWithNullsEqual(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 126
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->getPublicId()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2}, Lorg/codehaus/stax2/evt/NotationDeclaration2;->getPublicId()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->stringsWithNullsEqual(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 127
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->getSystemId()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2}, Lorg/codehaus/stax2/evt/NotationDeclaration2;->getSystemId()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->stringsWithNullsEqual(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 128
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->getBaseURI()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2}, Lorg/codehaus/stax2/evt/NotationDeclaration2;->getBaseURI()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->stringsWithNullsEqual(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    goto :goto_0

    :cond_3
    move v0, v1

    .line 125
    :goto_0
    return v0
.end method

.method public getBaseURI()Ljava/lang/String;
    .locals 1

    .line 54
    const-string v0, ""

    return-object v0
.end method

.method public getEventType()I
    .locals 1

    .line 65
    const/16 v0, 0xe

    return v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    .line 35
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->mName:Ljava/lang/String;

    return-object v0
.end method

.method public getPublicId()Ljava/lang/String;
    .locals 1

    .line 40
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->mPublicId:Ljava/lang/String;

    return-object v0
.end method

.method public getSystemId()Ljava/lang/String;
    .locals 1

    .line 45
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->mSystemId:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 2

    .line 135
    const/4 v0, 0x0

    .line 136
    .local v0, "hash":I
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->mName:Ljava/lang/String;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->mName:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    xor-int/2addr v0, v1

    .line 137
    :cond_0
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->mPublicId:Ljava/lang/String;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->mPublicId:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    xor-int/2addr v0, v1

    .line 138
    :cond_1
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->mSystemId:Ljava/lang/String;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->mSystemId:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    xor-int/2addr v0, v1

    .line 139
    :cond_2
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

    .line 73
    :try_start_0
    const-string v0, "<!NOTATION "

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 74
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->mName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 75
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->mPublicId:Ljava/lang/String;

    const/16 v1, 0x22

    if-eqz v0, :cond_0

    .line 76
    const-string v0, "PUBLIC \""

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 77
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->mPublicId:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 78
    invoke-virtual {p1, v1}, Ljava/io/Writer;->write(I)V

    goto :goto_0

    .line 80
    :cond_0
    const-string v0, "SYSTEM"

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 82
    :goto_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->mSystemId:Ljava/lang/String;

    if-eqz v0, :cond_1

    .line 83
    const-string v0, " \""

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 84
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->mSystemId:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 85
    invoke-virtual {p1, v1}, Ljava/io/Writer;->write(I)V

    .line 87
    :cond_1
    const/16 v0, 0x3e

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(I)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 90
    goto :goto_1

    .line 88
    :catch_0
    move-exception v0

    .line 89
    .local v0, "ie":Ljava/io/IOException;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/evt/NotationDeclarationEventImpl;->throwFromIOE(Ljava/io/IOException;)V

    .line 91
    .end local v0    # "ie":Ljava/io/IOException;
    :goto_1
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

    .line 106
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    const-string v1, "Can not write notation declarations using an XMLStreamWriter"

    invoke-direct {v0, v1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
