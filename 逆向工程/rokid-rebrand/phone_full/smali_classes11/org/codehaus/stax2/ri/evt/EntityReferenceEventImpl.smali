.class public Lorg/codehaus/stax2/ri/evt/EntityReferenceEventImpl;
.super Lorg/codehaus/stax2/ri/evt/BaseEventImpl;
.source "EntityReferenceEventImpl.java"

# interfaces
.implements Ljavax/xml/stream/events/EntityReference;


# instance fields
.field protected final mDecl:Ljavax/xml/stream/events/EntityDeclaration;


# direct methods
.method public constructor <init>(Ljavax/xml/stream/Location;Ljava/lang/String;)V
    .locals 1
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "name"    # Ljava/lang/String;

    .line 26
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/evt/BaseEventImpl;-><init>(Ljavax/xml/stream/Location;)V

    .line 28
    new-instance v0, Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;

    invoke-direct {v0, p1, p2}, Lorg/codehaus/stax2/ri/evt/EntityDeclarationEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;)V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/evt/EntityReferenceEventImpl;->mDecl:Ljavax/xml/stream/events/EntityDeclaration;

    .line 29
    return-void
.end method

.method public constructor <init>(Ljavax/xml/stream/Location;Ljavax/xml/stream/events/EntityDeclaration;)V
    .locals 0
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "decl"    # Ljavax/xml/stream/events/EntityDeclaration;

    .line 20
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/evt/BaseEventImpl;-><init>(Ljavax/xml/stream/Location;)V

    .line 21
    iput-object p2, p0, Lorg/codehaus/stax2/ri/evt/EntityReferenceEventImpl;->mDecl:Ljavax/xml/stream/events/EntityDeclaration;

    .line 22
    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 3
    .param p1, "o"    # Ljava/lang/Object;

    .line 87
    if-ne p1, p0, :cond_0

    const/4 v0, 0x1

    return v0

    .line 88
    :cond_0
    const/4 v0, 0x0

    if-nez p1, :cond_1

    return v0

    .line 90
    :cond_1
    instance-of v1, p1, Ljavax/xml/stream/events/EntityReference;

    if-nez v1, :cond_2

    return v0

    .line 92
    :cond_2
    move-object v0, p1

    check-cast v0, Ljavax/xml/stream/events/EntityReference;

    .line 93
    .local v0, "other":Ljavax/xml/stream/events/EntityReference;
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/EntityReferenceEventImpl;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0}, Ljavax/xml/stream/events/EntityReference;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method public getDeclaration()Ljavax/xml/stream/events/EntityDeclaration;
    .locals 1

    .line 34
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/EntityReferenceEventImpl;->mDecl:Ljavax/xml/stream/events/EntityDeclaration;

    return-object v0
.end method

.method public getEventType()I
    .locals 1

    .line 51
    const/16 v0, 0x9

    return v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    .line 40
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/EntityReferenceEventImpl;->mDecl:Ljavax/xml/stream/events/EntityDeclaration;

    invoke-interface {v0}, Ljavax/xml/stream/events/EntityDeclaration;->getName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public hashCode()I
    .locals 1

    .line 99
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/EntityReferenceEventImpl;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    return v0
.end method

.method public isEntityReference()Z
    .locals 1

    .line 56
    const/4 v0, 0x1

    return v0
.end method

.method public writeAsEncodedUnicode(Ljava/io/Writer;)V
    .locals 1
    .param p1, "w"    # Ljava/io/Writer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 64
    const/16 v0, 0x26

    :try_start_0
    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(I)V

    .line 65
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/EntityReferenceEventImpl;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 66
    const/16 v0, 0x3b

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(I)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 69
    goto :goto_0

    .line 67
    :catch_0
    move-exception v0

    .line 68
    .local v0, "ie":Ljava/io/IOException;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/evt/EntityReferenceEventImpl;->throwFromIOE(Ljava/io/IOException;)V

    .line 70
    .end local v0    # "ie":Ljava/io/IOException;
    :goto_0
    return-void
.end method

.method public writeUsing(Lorg/codehaus/stax2/XMLStreamWriter2;)V
    .locals 1
    .param p1, "w"    # Lorg/codehaus/stax2/XMLStreamWriter2;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 75
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/EntityReferenceEventImpl;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v0}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeEntityRef(Ljava/lang/String;)V

    .line 76
    return-void
.end method
