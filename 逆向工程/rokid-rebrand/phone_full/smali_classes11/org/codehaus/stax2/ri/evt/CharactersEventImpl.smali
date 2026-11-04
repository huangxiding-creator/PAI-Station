.class public Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;
.super Lorg/codehaus/stax2/ri/evt/BaseEventImpl;
.source "CharactersEventImpl.java"

# interfaces
.implements Ljavax/xml/stream/events/Characters;


# instance fields
.field final mContent:Ljava/lang/String;

.field final mIgnorableWS:Z

.field final mIsCData:Z

.field mIsWhitespace:Z

.field mWhitespaceChecked:Z


# direct methods
.method public constructor <init>(Ljavax/xml/stream/Location;Ljava/lang/String;Z)V
    .locals 1
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "content"    # Ljava/lang/String;
    .param p3, "cdata"    # Z

    .line 30
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/evt/BaseEventImpl;-><init>(Ljavax/xml/stream/Location;)V

    .line 20
    const/4 v0, 0x0

    iput-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mWhitespaceChecked:Z

    .line 21
    iput-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mIsWhitespace:Z

    .line 31
    iput-object p2, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mContent:Ljava/lang/String;

    .line 32
    iput-boolean p3, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mIsCData:Z

    .line 33
    iput-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mIgnorableWS:Z

    .line 34
    return-void
.end method

.method private constructor <init>(Ljavax/xml/stream/Location;Ljava/lang/String;ZZZ)V
    .locals 1
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "content"    # Ljava/lang/String;
    .param p3, "cdata"    # Z
    .param p4, "allWS"    # Z
    .param p5, "ignorableWS"    # Z

    .line 42
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/evt/BaseEventImpl;-><init>(Ljavax/xml/stream/Location;)V

    .line 20
    const/4 v0, 0x0

    iput-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mWhitespaceChecked:Z

    .line 21
    iput-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mIsWhitespace:Z

    .line 43
    iput-object p2, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mContent:Ljava/lang/String;

    .line 44
    iput-boolean p3, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mIsCData:Z

    .line 45
    iput-boolean p4, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mIsWhitespace:Z

    .line 46
    if-eqz p4, :cond_0

    .line 47
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mWhitespaceChecked:Z

    .line 48
    iput-boolean p5, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mIgnorableWS:Z

    goto :goto_0

    .line 50
    :cond_0
    iput-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mWhitespaceChecked:Z

    .line 51
    iput-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mIgnorableWS:Z

    .line 53
    :goto_0
    return-void
.end method

.method public static final createIgnorableWS(Ljavax/xml/stream/Location;Ljava/lang/String;)Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;
    .locals 7
    .param p0, "loc"    # Ljavax/xml/stream/Location;
    .param p1, "content"    # Ljava/lang/String;

    .line 56
    new-instance v6, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;

    const/4 v4, 0x1

    const/4 v5, 0x1

    const/4 v3, 0x0

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    invoke-direct/range {v0 .. v5}, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;ZZZ)V

    return-object v6
.end method

.method public static final createNonIgnorableWS(Ljavax/xml/stream/Location;Ljava/lang/String;)Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;
    .locals 7
    .param p0, "loc"    # Ljavax/xml/stream/Location;
    .param p1, "content"    # Ljava/lang/String;

    .line 60
    new-instance v6, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;

    const/4 v4, 0x1

    const/4 v5, 0x0

    const/4 v3, 0x0

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    invoke-direct/range {v0 .. v5}, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;ZZZ)V

    return-object v6
.end method

.method protected static writeEscapedXMLText(Ljava/io/Writer;Ljava/lang/String;)V
    .locals 9
    .param p0, "w"    # Ljava/io/Writer;
    .param p1, "text"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 196
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 198
    .local v0, "len":I
    const/4 v1, 0x0

    .line 199
    .local v1, "i":I
    :goto_0
    if-ge v1, v0, :cond_7

    .line 200
    move v2, v1

    .line 201
    .local v2, "start":I
    const/4 v3, 0x0

    .line 203
    .local v3, "c":C
    :goto_1
    const/16 v4, 0x3e

    const/16 v5, 0x26

    const/16 v6, 0x3c

    if-ge v1, v0, :cond_2

    .line 204
    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 205
    if-eq v3, v6, :cond_2

    if-ne v3, v5, :cond_0

    .line 206
    goto :goto_2

    .line 208
    :cond_0
    if-ne v3, v4, :cond_1

    const/4 v7, 0x2

    if-lt v1, v7, :cond_1

    add-int/lit8 v7, v1, -0x1

    invoke-virtual {p1, v7}, Ljava/lang/String;->charAt(I)C

    move-result v7

    const/16 v8, 0x5d

    if-ne v7, v8, :cond_1

    add-int/lit8 v7, v1, -0x2

    .line 209
    invoke-virtual {p1, v7}, Ljava/lang/String;->charAt(I)C

    move-result v7

    if-ne v7, v8, :cond_1

    .line 210
    goto :goto_2

    .line 212
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 214
    :cond_2
    :goto_2
    sub-int v7, v1, v2

    .line 215
    .local v7, "outLen":I
    if-lez v7, :cond_3

    .line 216
    invoke-virtual {p0, p1, v2, v7}, Ljava/io/Writer;->write(Ljava/lang/String;II)V

    .line 218
    :cond_3
    if-ge v1, v0, :cond_6

    .line 219
    if-ne v3, v6, :cond_4

    .line 220
    const-string v4, "&lt;"

    invoke-virtual {p0, v4}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    goto :goto_3

    .line 221
    :cond_4
    if-ne v3, v5, :cond_5

    .line 222
    const-string v4, "&amp;"

    invoke-virtual {p0, v4}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    goto :goto_3

    .line 223
    :cond_5
    if-ne v3, v4, :cond_6

    .line 224
    const-string v4, "&gt;"

    invoke-virtual {p0, v4}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 227
    :cond_6
    :goto_3
    nop

    .end local v2    # "start":I
    .end local v3    # "c":C
    .end local v7    # "outLen":I
    add-int/lit8 v1, v1, 0x1

    .line 228
    goto :goto_0

    .line 229
    :cond_7
    return-void
.end method


# virtual methods
.method public asCharacters()Ljavax/xml/stream/events/Characters;
    .locals 0

    .line 71
    return-object p0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 168
    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    return v0

    .line 169
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    return v1

    .line 170
    :cond_1
    instance-of v2, p1, Ljavax/xml/stream/events/Characters;

    if-nez v2, :cond_2

    return v1

    .line 172
    :cond_2
    move-object v2, p1

    check-cast v2, Ljavax/xml/stream/events/Characters;

    .line 174
    .local v2, "other":Ljavax/xml/stream/events/Characters;
    iget-object v3, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mContent:Ljava/lang/String;

    invoke-interface {v2}, Ljavax/xml/stream/events/Characters;->getData()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 177
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->isCData()Z

    move-result v3

    invoke-interface {v2}, Ljavax/xml/stream/events/Characters;->isCData()Z

    move-result v4

    if-ne v3, v4, :cond_3

    goto :goto_0

    :cond_3
    move v0, v1

    :goto_0
    return v0

    .line 179
    :cond_4
    return v1
.end method

.method public getData()Ljava/lang/String;
    .locals 1

    .line 116
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mContent:Ljava/lang/String;

    return-object v0
.end method

.method public getEventType()I
    .locals 1

    .line 76
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mIsCData:Z

    if-eqz v0, :cond_0

    const/16 v0, 0xc

    goto :goto_0

    :cond_0
    const/4 v0, 0x4

    :goto_0
    return v0
.end method

.method public hashCode()I
    .locals 1

    .line 184
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mContent:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    return v0
.end method

.method public isCData()Z
    .locals 1

    .line 121
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mIsCData:Z

    return v0
.end method

.method public isCharacters()Z
    .locals 1

    .line 80
    const/4 v0, 0x1

    return v0
.end method

.method public isIgnorableWhiteSpace()Z
    .locals 1

    .line 126
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mIgnorableWS:Z

    return v0
.end method

.method public isWhiteSpace()Z
    .locals 6

    .line 132
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mWhitespaceChecked:Z

    if-nez v0, :cond_3

    .line 133
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mWhitespaceChecked:Z

    .line 134
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mContent:Ljava/lang/String;

    .line 135
    .local v1, "str":Ljava/lang/String;
    const/4 v2, 0x0

    .line 136
    .local v2, "i":I
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v3

    .line 137
    .local v3, "len":I
    :goto_0
    if-ge v2, v3, :cond_1

    .line 138
    invoke-virtual {v1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v4

    const/16 v5, 0x20

    if-le v4, v5, :cond_0

    .line 139
    goto :goto_1

    .line 137
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 142
    :cond_1
    :goto_1
    if-ne v2, v3, :cond_2

    goto :goto_2

    :cond_2
    const/4 v0, 0x0

    :goto_2
    iput-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mIsWhitespace:Z

    .line 144
    .end local v1    # "str":Ljava/lang/String;
    .end local v2    # "i":I
    .end local v3    # "len":I
    :cond_3
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mIsWhitespace:Z

    return v0
.end method

.method public setWhitespaceStatus(Z)V
    .locals 1
    .param p1, "status"    # Z

    .line 155
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mWhitespaceChecked:Z

    .line 156
    iput-boolean p1, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mIsWhitespace:Z

    .line 157
    return-void
.end method

.method public writeAsEncodedUnicode(Ljava/io/Writer;)V
    .locals 1
    .param p1, "w"    # Ljava/io/Writer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 86
    :try_start_0
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mIsCData:Z

    if-eqz v0, :cond_0

    .line 87
    const-string v0, "<![CDATA["

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 88
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mContent:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 89
    const-string v0, "]]>"

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    goto :goto_0

    .line 91
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mContent:Ljava/lang/String;

    invoke-static {p1, v0}, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->writeEscapedXMLText(Ljava/io/Writer;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 95
    :goto_0
    goto :goto_1

    .line 93
    :catch_0
    move-exception v0

    .line 94
    .local v0, "ie":Ljava/io/IOException;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->throwFromIOE(Ljava/io/IOException;)V

    .line 96
    .end local v0    # "ie":Ljava/io/IOException;
    :goto_1
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

    .line 101
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mIsCData:Z

    if-eqz v0, :cond_0

    .line 102
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mContent:Ljava/lang/String;

    invoke-interface {p1, v0}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeCData(Ljava/lang/String;)V

    goto :goto_0

    .line 104
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/CharactersEventImpl;->mContent:Ljava/lang/String;

    invoke-interface {p1, v0}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeCharacters(Ljava/lang/String;)V

    .line 106
    :goto_0
    return-void
.end method
