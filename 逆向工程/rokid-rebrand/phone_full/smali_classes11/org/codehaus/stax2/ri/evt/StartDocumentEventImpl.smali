.class public Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;
.super Lorg/codehaus/stax2/ri/evt/BaseEventImpl;
.source "StartDocumentEventImpl.java"

# interfaces
.implements Ljavax/xml/stream/events/StartDocument;


# instance fields
.field private final mEncodingScheme:Ljava/lang/String;

.field private final mEncodingSet:Z

.field private final mIsStandalone:Z

.field private final mStandaloneSet:Z

.field private final mSystemId:Ljava/lang/String;

.field private final mVersion:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljavax/xml/stream/Location;)V
    .locals 2
    .param p1, "loc"    # Ljavax/xml/stream/Location;

    .line 50
    const/4 v0, 0x0

    move-object v1, v0

    check-cast v1, Ljava/lang/String;

    invoke-direct {p0, p1, v0}, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;)V

    .line 51
    return-void
.end method

.method public constructor <init>(Ljavax/xml/stream/Location;Ljava/lang/String;)V
    .locals 1
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "encoding"    # Ljava/lang/String;

    .line 55
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;)V

    .line 56
    return-void
.end method

.method public constructor <init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;)V
    .locals 6
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "encoding"    # Ljava/lang/String;
    .param p3, "version"    # Ljava/lang/String;

    .line 60
    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    invoke-direct/range {v0 .. v5}, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;ZZ)V

    .line 61
    return-void
.end method

.method public constructor <init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;ZZ)V
    .locals 1
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "encoding"    # Ljava/lang/String;
    .param p3, "version"    # Ljava/lang/String;
    .param p4, "standaloneSet"    # Z
    .param p5, "isStandalone"    # Z

    .line 66
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/evt/BaseEventImpl;-><init>(Ljavax/xml/stream/Location;)V

    .line 67
    iput-object p2, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mEncodingScheme:Ljava/lang/String;

    .line 68
    if-eqz p2, :cond_0

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iput-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mEncodingSet:Z

    .line 69
    iput-object p3, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mVersion:Ljava/lang/String;

    .line 70
    iput-boolean p4, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mStandaloneSet:Z

    .line 71
    iput-boolean p5, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mIsStandalone:Z

    .line 72
    const-string v0, ""

    iput-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mSystemId:Ljava/lang/String;

    .line 73
    return-void
.end method

.method public constructor <init>(Ljavax/xml/stream/Location;Ljavax/xml/stream/XMLStreamReader;)V
    .locals 2
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "r"    # Ljavax/xml/stream/XMLStreamReader;

    .line 24
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/evt/BaseEventImpl;-><init>(Ljavax/xml/stream/Location;)V

    .line 25
    invoke-interface {p2}, Ljavax/xml/stream/XMLStreamReader;->standaloneSet()Z

    move-result v0

    iput-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mStandaloneSet:Z

    .line 26
    invoke-interface {p2}, Ljavax/xml/stream/XMLStreamReader;->isStandalone()Z

    move-result v0

    iput-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mIsStandalone:Z

    .line 33
    invoke-interface {p2}, Ljavax/xml/stream/XMLStreamReader;->getVersion()Ljava/lang/String;

    move-result-object v0

    .line 34
    .local v0, "version":Ljava/lang/String;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    .line 35
    :cond_0
    const-string v0, "1.0"

    .line 37
    :cond_1
    iput-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mVersion:Ljava/lang/String;

    .line 39
    .end local v0    # "version":Ljava/lang/String;
    invoke-interface {p2}, Ljavax/xml/stream/XMLStreamReader;->getCharacterEncodingScheme()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mEncodingScheme:Ljava/lang/String;

    .line 40
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mEncodingScheme:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mEncodingScheme:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_2

    const/4 v0, 0x1

    goto :goto_0

    :cond_2
    const/4 v0, 0x0

    :goto_0
    iput-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mEncodingSet:Z

    .line 41
    if-eqz p1, :cond_3

    invoke-interface {p1}, Ljavax/xml/stream/Location;->getSystemId()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_3
    const-string v0, ""

    :goto_1
    iput-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mSystemId:Ljava/lang/String;

    .line 42
    return-void
.end method


# virtual methods
.method public encodingSet()Z
    .locals 1

    .line 77
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mEncodingSet:Z

    return v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 167
    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    return v0

    .line 168
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    return v1

    .line 169
    :cond_1
    instance-of v2, p1, Ljavax/xml/stream/events/StartDocument;

    if-nez v2, :cond_2

    return v1

    .line 171
    :cond_2
    move-object v2, p1

    check-cast v2, Ljavax/xml/stream/events/StartDocument;

    .line 173
    .local v2, "other":Ljavax/xml/stream/events/StartDocument;
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->encodingSet()Z

    move-result v3

    invoke-interface {v2}, Ljavax/xml/stream/events/StartDocument;->encodingSet()Z

    move-result v4

    if-ne v3, v4, :cond_3

    .line 174
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->isStandalone()Z

    move-result v3

    invoke-interface {v2}, Ljavax/xml/stream/events/StartDocument;->isStandalone()Z

    move-result v4

    if-ne v3, v4, :cond_3

    .line 175
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->standaloneSet()Z

    move-result v3

    invoke-interface {v2}, Ljavax/xml/stream/events/StartDocument;->standaloneSet()Z

    move-result v4

    if-ne v3, v4, :cond_3

    .line 176
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->getCharacterEncodingScheme()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2}, Ljavax/xml/stream/events/StartDocument;->getCharacterEncodingScheme()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->stringsWithNullsEqual(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 177
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->getSystemId()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2}, Ljavax/xml/stream/events/StartDocument;->getSystemId()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->stringsWithNullsEqual(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 178
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->getVersion()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2}, Ljavax/xml/stream/events/StartDocument;->getVersion()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->stringsWithNullsEqual(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    goto :goto_0

    :cond_3
    move v0, v1

    .line 173
    :goto_0
    return v0
.end method

.method public getCharacterEncodingScheme()Ljava/lang/String;
    .locals 1

    .line 82
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mEncodingScheme:Ljava/lang/String;

    return-object v0
.end method

.method public getEventType()I
    .locals 1

    .line 113
    const/4 v0, 0x7

    return v0
.end method

.method public getSystemId()Ljava/lang/String;
    .locals 1

    .line 87
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mSystemId:Ljava/lang/String;

    return-object v0
.end method

.method public getVersion()Ljava/lang/String;
    .locals 1

    .line 92
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mVersion:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 2

    .line 185
    const/4 v0, 0x0

    .line 187
    .local v0, "hash":I
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->encodingSet()Z

    move-result v1

    if-eqz v1, :cond_0

    add-int/lit8 v0, v0, 0x1

    .line 188
    :cond_0
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->isStandalone()Z

    move-result v1

    if-eqz v1, :cond_1

    add-int/lit8 v0, v0, -0x1

    .line 189
    :cond_1
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->standaloneSet()Z

    move-result v1

    if-eqz v1, :cond_2

    xor-int/lit8 v0, v0, 0x1

    .line 190
    :cond_2
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mVersion:Ljava/lang/String;

    if-eqz v1, :cond_3

    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mVersion:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    xor-int/2addr v0, v1

    .line 191
    :cond_3
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mEncodingScheme:Ljava/lang/String;

    if-eqz v1, :cond_4

    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mEncodingScheme:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    xor-int/2addr v0, v1

    .line 192
    :cond_4
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mSystemId:Ljava/lang/String;

    if-eqz v1, :cond_5

    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mSystemId:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    xor-int/2addr v0, v1

    .line 193
    :cond_5
    return v0
.end method

.method public isStandalone()Z
    .locals 1

    .line 97
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mIsStandalone:Z

    return v0
.end method

.method public isStartDocument()Z
    .locals 1

    .line 118
    const/4 v0, 0x1

    return v0
.end method

.method public standaloneSet()Z
    .locals 1

    .line 102
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mStandaloneSet:Z

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

    .line 127
    :try_start_0
    const-string v0, "<?xml version=\""

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 128
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mVersion:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mVersion:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 131
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mVersion:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    goto :goto_1

    .line 129
    :cond_1
    :goto_0
    const-string v0, "1.0"

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 133
    :goto_1
    const/16 v0, 0x22

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(I)V

    .line 134
    iget-boolean v1, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mEncodingSet:Z

    if-eqz v1, :cond_2

    .line 135
    const-string v1, " encoding=\""

    invoke-virtual {p1, v1}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 136
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mEncodingScheme:Ljava/lang/String;

    invoke-virtual {p1, v1}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 137
    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(I)V

    .line 139
    :cond_2
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mStandaloneSet:Z

    if-eqz v0, :cond_4

    .line 140
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->mIsStandalone:Z

    if-eqz v0, :cond_3

    .line 141
    const-string v0, " standalone=\"yes\""

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    goto :goto_2

    .line 143
    :cond_3
    const-string v0, " standalone=\"no\""

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 146
    :cond_4
    :goto_2
    const-string v0, " ?>"

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 149
    goto :goto_3

    .line 147
    :catch_0
    move-exception v0

    .line 148
    .local v0, "ie":Ljava/io/IOException;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/evt/StartDocumentEventImpl;->throwFromIOE(Ljava/io/IOException;)V

    .line 150
    .end local v0    # "ie":Ljava/io/IOException;
    :goto_3
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

    .line 155
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeStartDocument()V

    .line 156
    return-void
.end method
