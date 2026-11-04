.class public Lorg/codehaus/stax2/ri/evt/DTDEventImpl;
.super Lorg/codehaus/stax2/ri/evt/BaseEventImpl;
.source "DTDEventImpl.java"

# interfaces
.implements Lorg/codehaus/stax2/evt/DTD2;


# instance fields
.field protected final mDTD:Ljava/lang/Object;

.field protected mFullText:Ljava/lang/String;

.field protected final mInternalSubset:Ljava/lang/String;

.field protected final mPublicId:Ljava/lang/String;

.field protected final mRootName:Ljava/lang/String;

.field protected final mSystemId:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljavax/xml/stream/Location;Ljava/lang/String;)V
    .locals 7
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "fullText"    # Ljava/lang/String;

    .line 80
    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    invoke-direct/range {v0 .. v6}, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    .line 81
    iput-object p2, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mFullText:Ljava/lang/String;

    .line 82
    return-void
.end method

.method public constructor <init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;)V
    .locals 7
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "rootName"    # Ljava/lang/String;
    .param p3, "intSubset"    # Ljava/lang/String;

    .line 75
    const/4 v4, 0x0

    const/4 v6, 0x0

    const/4 v3, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v5, p3

    invoke-direct/range {v0 .. v6}, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    .line 76
    return-void
.end method

.method public constructor <init>(Ljavax/xml/stream/Location;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "rootName"    # Ljava/lang/String;
    .param p3, "sysId"    # Ljava/lang/String;
    .param p4, "pubId"    # Ljava/lang/String;
    .param p5, "intSubset"    # Ljava/lang/String;
    .param p6, "dtd"    # Ljava/lang/Object;

    .line 61
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/evt/BaseEventImpl;-><init>(Ljavax/xml/stream/Location;)V

    .line 49
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mFullText:Ljava/lang/String;

    .line 62
    iput-object p2, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mRootName:Ljava/lang/String;

    .line 63
    iput-object p3, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mSystemId:Ljava/lang/String;

    .line 64
    iput-object p4, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mPublicId:Ljava/lang/String;

    .line 65
    iput-object p5, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mInternalSubset:Ljava/lang/String;

    .line 66
    iput-object v0, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mFullText:Ljava/lang/String;

    .line 67
    iput-object p6, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mDTD:Ljava/lang/Object;

    .line 68
    return-void
.end method


# virtual methods
.method protected doGetDocumentTypeDeclaration()Ljava/lang/String;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 256
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mFullText:Ljava/lang/String;

    if-nez v0, :cond_1

    .line 257
    const/16 v0, 0x3c

    .line 258
    .local v0, "len":I
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mInternalSubset:Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 259
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mInternalSubset:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, 0x4

    add-int/2addr v0, v1

    .line 261
    :cond_0
    new-instance v1, Ljava/io/StringWriter;

    invoke-direct {v1, v0}, Ljava/io/StringWriter;-><init>(I)V

    .line 262
    .local v1, "sw":Ljava/io/StringWriter;
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->writeAsEncodedUnicode(Ljava/io/Writer;)V

    .line 263
    invoke-virtual {v1}, Ljava/io/StringWriter;->toString()Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mFullText:Ljava/lang/String;

    .line 265
    .end local v0    # "len":I
    .end local v1    # "sw":Ljava/io/StringWriter;
    :cond_1
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mFullText:Ljava/lang/String;

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 3
    .param p1, "o"    # Ljava/lang/Object;

    .line 218
    if-ne p1, p0, :cond_0

    const/4 v0, 0x1

    return v0

    .line 219
    :cond_0
    const/4 v0, 0x0

    if-nez p1, :cond_1

    return v0

    .line 220
    :cond_1
    instance-of v1, p1, Ljavax/xml/stream/events/DTD;

    if-nez v1, :cond_2

    return v0

    .line 222
    :cond_2
    move-object v0, p1

    check-cast v0, Ljavax/xml/stream/events/DTD;

    .line 228
    .local v0, "other":Ljavax/xml/stream/events/DTD;
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->getDocumentTypeDeclaration()Ljava/lang/String;

    move-result-object v1

    .line 229
    invoke-interface {v0}, Ljavax/xml/stream/events/DTD;->getDocumentTypeDeclaration()Ljava/lang/String;

    move-result-object v2

    .line 228
    invoke-static {v1, v2}, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->stringsWithNullsEqual(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    return v1
.end method

.method public getDocumentTypeDeclaration()Ljava/lang/String;
    .locals 4

    .line 94
    :try_start_0
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->doGetDocumentTypeDeclaration()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljavax/xml/stream/XMLStreamException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 95
    :catch_0
    move-exception v0

    .line 96
    .local v0, "sex":Ljavax/xml/stream/XMLStreamException;
    new-instance v1, Ljava/lang/RuntimeException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Internal error: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public getEntities()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljavax/xml/stream/events/EntityDeclaration;",
            ">;"
        }
    .end annotation

    .line 104
    const/4 v0, 0x0

    return-object v0
.end method

.method public getEventType()I
    .locals 1

    .line 128
    const/16 v0, 0xb

    return v0
.end method

.method public getInternalSubset()Ljava/lang/String;
    .locals 1

    .line 206
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mInternalSubset:Ljava/lang/String;

    return-object v0
.end method

.method public getNotations()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljavax/xml/stream/events/NotationDeclaration;",
            ">;"
        }
    .end annotation

    .line 111
    const/4 v0, 0x0

    return-object v0
.end method

.method public getProcessedDTD()Ljava/lang/Object;
    .locals 1

    .line 117
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mDTD:Ljava/lang/Object;

    return-object v0
.end method

.method public getPublicId()Ljava/lang/String;
    .locals 1

    .line 201
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mPublicId:Ljava/lang/String;

    return-object v0
.end method

.method public getRootName()Ljava/lang/String;
    .locals 1

    .line 191
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mRootName:Ljava/lang/String;

    return-object v0
.end method

.method public getSystemId()Ljava/lang/String;
    .locals 1

    .line 196
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mSystemId:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 2

    .line 235
    const/4 v0, 0x0

    .line 236
    .local v0, "hash":I
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mRootName:Ljava/lang/String;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mRootName:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    xor-int/2addr v0, v1

    .line 237
    :cond_0
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mSystemId:Ljava/lang/String;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mSystemId:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    xor-int/2addr v0, v1

    .line 238
    :cond_1
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mPublicId:Ljava/lang/String;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mPublicId:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    xor-int/2addr v0, v1

    .line 239
    :cond_2
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mInternalSubset:Ljava/lang/String;

    if-eqz v1, :cond_3

    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mInternalSubset:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    xor-int/2addr v0, v1

    .line 240
    :cond_3
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mDTD:Ljava/lang/Object;

    if-eqz v1, :cond_4

    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mDTD:Ljava/lang/Object;

    invoke-virtual {v1}, Ljava/lang/Object;->hashCode()I

    move-result v1

    xor-int/2addr v0, v1

    .line 241
    :cond_4
    if-nez v0, :cond_5

    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mFullText:Ljava/lang/String;

    if-eqz v1, :cond_5

    .line 242
    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mFullText:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    xor-int/2addr v0, v1

    .line 244
    :cond_5
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

    .line 137
    :try_start_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mFullText:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 138
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mFullText:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 139
    return-void

    .line 142
    :cond_0
    const-string v0, "<!DOCTYPE"

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 143
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mRootName:Ljava/lang/String;

    if-eqz v0, :cond_1

    .line 145
    const/16 v0, 0x20

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(I)V

    .line 146
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mRootName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 148
    :cond_1
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mSystemId:Ljava/lang/String;

    if-eqz v0, :cond_3

    .line 149
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mPublicId:Ljava/lang/String;

    const/16 v1, 0x22

    if-eqz v0, :cond_2

    .line 150
    const-string v0, " PUBLIC \""

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 151
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mPublicId:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 152
    invoke-virtual {p1, v1}, Ljava/io/Writer;->write(I)V

    goto :goto_0

    .line 154
    :cond_2
    const-string v0, " SYSTEM"

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 156
    :goto_0
    const-string v0, " \""

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 157
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mSystemId:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 158
    invoke-virtual {p1, v1}, Ljava/io/Writer;->write(I)V

    .line 160
    :cond_3
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mInternalSubset:Ljava/lang/String;

    if-eqz v0, :cond_4

    .line 161
    const-string v0, " ["

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 162
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mInternalSubset:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 163
    const/16 v0, 0x5d

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(I)V

    .line 165
    :cond_4
    const-string v0, ">"

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 168
    goto :goto_1

    .line 166
    :catch_0
    move-exception v0

    .line 167
    .local v0, "ie":Ljava/io/IOException;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->throwFromIOE(Ljava/io/IOException;)V

    .line 169
    .end local v0    # "ie":Ljava/io/IOException;
    :goto_1
    return-void
.end method

.method public writeUsing(Lorg/codehaus/stax2/XMLStreamWriter2;)V
    .locals 4
    .param p1, "w"    # Lorg/codehaus/stax2/XMLStreamWriter2;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 174
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mRootName:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 175
    iget-object v0, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mRootName:Ljava/lang/String;

    iget-object v1, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mSystemId:Ljava/lang/String;

    iget-object v2, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mPublicId:Ljava/lang/String;

    iget-object v3, p0, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->mInternalSubset:Ljava/lang/String;

    invoke-interface {p1, v0, v1, v2, v3}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeDTD(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 176
    return-void

    .line 180
    :cond_0
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/evt/DTDEventImpl;->doGetDocumentTypeDeclaration()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v0}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeDTD(Ljava/lang/String;)V

    .line 181
    return-void
.end method
