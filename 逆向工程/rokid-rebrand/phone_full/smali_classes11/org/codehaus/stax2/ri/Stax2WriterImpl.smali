.class public abstract Lorg/codehaus/stax2/ri/Stax2WriterImpl;
.super Ljava/lang/Object;
.source "Stax2WriterImpl.java"

# interfaces
.implements Lorg/codehaus/stax2/XMLStreamWriter2;
.implements Ljavax/xml/stream/XMLStreamConstants;


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public copyEventFromReader(Lorg/codehaus/stax2/XMLStreamReader2;Z)V
    .locals 5
    .param p1, "sr"    # Lorg/codehaus/stax2/XMLStreamReader2;
    .param p2, "preserveEventData"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 161
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getEventType()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 245
    :pswitch_0
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unrecognized event type ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 246
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getEventType()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "); not sure how to copy"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 206
    :pswitch_1
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getTextCharacters()[C

    move-result-object v0

    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getTextStart()I

    move-result v1

    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getTextLength()I

    move-result v2

    invoke-virtual {p0, v0, v1, v2}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeCData([CII)V

    .line 207
    return-void

    .line 223
    :pswitch_2
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getDTDInfo()Lorg/codehaus/stax2/DTDInfo;

    move-result-object v0

    .line 224
    .local v0, "info":Lorg/codehaus/stax2/DTDInfo;
    if-eqz v0, :cond_0

    .line 230
    invoke-interface {v0}, Lorg/codehaus/stax2/DTDInfo;->getDTDRootName()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0}, Lorg/codehaus/stax2/DTDInfo;->getDTDSystemId()Ljava/lang/String;

    move-result-object v2

    .line 231
    invoke-interface {v0}, Lorg/codehaus/stax2/DTDInfo;->getDTDPublicId()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0}, Lorg/codehaus/stax2/DTDInfo;->getDTDInternalSubset()Ljava/lang/String;

    move-result-object v4

    .line 230
    invoke-virtual {p0, v1, v2, v3, v4}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeDTD(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 233
    .end local v0    # "info":Lorg/codehaus/stax2/DTDInfo;
    return-void

    .line 228
    .restart local v0    # "info":Lorg/codehaus/stax2/DTDInfo;
    :cond_0
    new-instance v1, Ljavax/xml/stream/XMLStreamException;

    const-string v2, "Current state DOCTYPE, but not DTDInfo Object returned -- reader doesn\'t support DTDs?"

    invoke-direct {v1, v2}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 236
    .end local v0    # "info":Lorg/codehaus/stax2/DTDInfo;
    :pswitch_3
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getLocalName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeEntityRef(Ljava/lang/String;)V

    .line 237
    return-void

    .line 185
    :pswitch_4
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeEndDocument()V

    .line 186
    return-void

    .line 164
    :pswitch_5
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getVersion()Ljava/lang/String;

    move-result-object v0

    .line 169
    .local v0, "version":Ljava/lang/String;
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    goto :goto_0

    .line 172
    :cond_1
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->standaloneSet()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 173
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getVersion()Ljava/lang/String;

    move-result-object v1

    .line 174
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getCharacterEncodingScheme()Ljava/lang/String;

    move-result-object v2

    .line 175
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->isStandalone()Z

    move-result v3

    .line 173
    invoke-virtual {p0, v1, v2, v3}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeStartDocument(Ljava/lang/String;Ljava/lang/String;Z)V

    goto :goto_0

    .line 177
    :cond_2
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getCharacterEncodingScheme()Ljava/lang/String;

    move-result-object v1

    .line 178
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getVersion()Ljava/lang/String;

    move-result-object v2

    .line 177
    invoke-virtual {p0, v1, v2}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeStartDocument(Ljava/lang/String;Ljava/lang/String;)V

    .line 182
    .end local v0    # "version":Ljava/lang/String;
    :cond_3
    :goto_0
    return-void

    .line 202
    :pswitch_6
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getTextCharacters()[C

    move-result-object v0

    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getTextStart()I

    move-result v1

    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getTextLength()I

    move-result v2

    invoke-virtual {p0, v0, v1, v2}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeSpace([CII)V

    .line 203
    return-void

    .line 214
    :pswitch_7
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getText()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeComment(Ljava/lang/String;)V

    .line 215
    return-void

    .line 210
    :pswitch_8
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getTextCharacters()[C

    move-result-object v0

    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getTextStart()I

    move-result v1

    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getTextLength()I

    move-result v2

    invoke-virtual {p0, v0, v1, v2}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeCharacters([CII)V

    .line 211
    return-void

    .line 218
    :pswitch_9
    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getPITarget()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getPIData()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeProcessingInstruction(Ljava/lang/String;Ljava/lang/String;)V

    .line 219
    return-void

    .line 198
    :pswitch_a
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeEndElement()V

    .line 199
    return-void

    .line 194
    :pswitch_b
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->copyStartElement(Ljavax/xml/stream/XMLStreamReader;)V

    .line 195
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_0
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method protected copyStartElement(Ljavax/xml/stream/XMLStreamReader;)V
    .locals 7
    .param p1, "sr"    # Ljavax/xml/stream/XMLStreamReader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 300
    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getNamespaceCount()I

    move-result v0

    .line 301
    .local v0, "nsCount":I
    if-lez v0, :cond_2

    .line 306
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v0, :cond_2

    .line 307
    invoke-interface {p1, v1}, Ljavax/xml/stream/XMLStreamReader;->getNamespacePrefix(I)Ljava/lang/String;

    move-result-object v2

    .line 308
    .local v2, "prefix":Ljava/lang/String;
    invoke-interface {p1, v1}, Ljavax/xml/stream/XMLStreamReader;->getNamespaceURI(I)Ljava/lang/String;

    move-result-object v3

    .line 309
    .local v3, "uri":Ljava/lang/String;
    if-eqz v2, :cond_1

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v4

    if-nez v4, :cond_0

    goto :goto_1

    .line 312
    :cond_0
    invoke-virtual {p0, v2, v3}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->setPrefix(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    .line 310
    :cond_1
    :goto_1
    invoke-virtual {p0, v3}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->setDefaultNamespace(Ljava/lang/String;)V

    .line 306
    .end local v2    # "prefix":Ljava/lang/String;
    .end local v3    # "uri":Ljava/lang/String;
    :goto_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 316
    .end local v1    # "i":I
    :cond_2
    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getPrefix()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getLocalName()Ljava/lang/String;

    move-result-object v2

    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getNamespaceURI()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v1, v2, v3}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeStartElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 318
    if-lez v0, :cond_5

    .line 320
    const/4 v1, 0x0

    .restart local v1    # "i":I
    :goto_3
    if-ge v1, v0, :cond_5

    .line 321
    invoke-interface {p1, v1}, Ljavax/xml/stream/XMLStreamReader;->getNamespacePrefix(I)Ljava/lang/String;

    move-result-object v2

    .line 322
    .restart local v2    # "prefix":Ljava/lang/String;
    invoke-interface {p1, v1}, Ljavax/xml/stream/XMLStreamReader;->getNamespaceURI(I)Ljava/lang/String;

    move-result-object v3

    .line 324
    .restart local v3    # "uri":Ljava/lang/String;
    if-eqz v2, :cond_4

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v4

    if-nez v4, :cond_3

    goto :goto_4

    .line 327
    :cond_3
    invoke-virtual {p0, v2, v3}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeNamespace(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_5

    .line 325
    :cond_4
    :goto_4
    invoke-virtual {p0, v3}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeDefaultNamespace(Ljava/lang/String;)V

    .line 320
    .end local v2    # "prefix":Ljava/lang/String;
    .end local v3    # "uri":Ljava/lang/String;
    :goto_5
    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    .line 335
    .end local v1    # "i":I
    :cond_5
    invoke-interface {p1}, Ljavax/xml/stream/XMLStreamReader;->getAttributeCount()I

    move-result v1

    .line 336
    .local v1, "attrCount":I
    if-lez v1, :cond_6

    .line 337
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_6
    if-ge v2, v1, :cond_6

    .line 338
    invoke-interface {p1, v2}, Ljavax/xml/stream/XMLStreamReader;->getAttributePrefix(I)Ljava/lang/String;

    move-result-object v3

    .line 339
    invoke-interface {p1, v2}, Ljavax/xml/stream/XMLStreamReader;->getAttributeNamespace(I)Ljava/lang/String;

    move-result-object v4

    .line 340
    invoke-interface {p1, v2}, Ljavax/xml/stream/XMLStreamReader;->getAttributeLocalName(I)Ljava/lang/String;

    move-result-object v5

    .line 341
    invoke-interface {p1, v2}, Ljavax/xml/stream/XMLStreamReader;->getAttributeValue(I)Ljava/lang/String;

    move-result-object v6

    .line 338
    invoke-virtual {p0, v3, v4, v5, v6}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 337
    add-int/lit8 v2, v2, 0x1

    goto :goto_6

    .line 344
    .end local v2    # "i":I
    :cond_6
    return-void
.end method

.method public abstract getEncoding()Ljava/lang/String;
.end method

.method public abstract getLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
.end method

.method public isPropertySupported(Ljava/lang/String;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 50
    const/4 v0, 0x0

    return v0
.end method

.method public setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
    .locals 3
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 56
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "No settable property \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setValidationProblemHandler(Lorg/codehaus/stax2/validation/ValidationProblemHandler;)Lorg/codehaus/stax2/validation/ValidationProblemHandler;
    .locals 1
    .param p1, "h"    # Lorg/codehaus/stax2/validation/ValidationProblemHandler;

    .line 282
    const/4 v0, 0x0

    return-object v0
.end method

.method public stopValidatingAgainst(Lorg/codehaus/stax2/validation/XMLValidationSchema;)Lorg/codehaus/stax2/validation/XMLValidator;
    .locals 1
    .param p1, "schema"    # Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 266
    const/4 v0, 0x0

    return-object v0
.end method

.method public stopValidatingAgainst(Lorg/codehaus/stax2/validation/XMLValidator;)Lorg/codehaus/stax2/validation/XMLValidator;
    .locals 1
    .param p1, "validator"    # Lorg/codehaus/stax2/validation/XMLValidator;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 273
    const/4 v0, 0x0

    return-object v0
.end method

.method public validateAgainst(Lorg/codehaus/stax2/validation/XMLValidationSchema;)Lorg/codehaus/stax2/validation/XMLValidator;
    .locals 2
    .param p1, "schema"    # Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 259
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "Not yet implemented"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public writeCData([CII)V
    .locals 1
    .param p1, "text"    # [C
    .param p2, "start"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 69
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p1, p2, p3}, Ljava/lang/String;-><init>([CII)V

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeCData(Ljava/lang/String;)V

    .line 70
    return-void
.end method

.method public writeDTD(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "rootName"    # Ljava/lang/String;
    .param p2, "systemId"    # Ljava/lang/String;
    .param p3, "publicId"    # Ljava/lang/String;
    .param p4, "internalSubset"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 80
    new-instance v0, Ljava/lang/StringBuffer;

    invoke-direct {v0}, Ljava/lang/StringBuffer;-><init>()V

    .line 81
    .local v0, "sb":Ljava/lang/StringBuffer;
    const-string v1, "<!DOCTYPE"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 82
    invoke-virtual {v0, p1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 83
    if-eqz p2, :cond_1

    .line 84
    if-eqz p3, :cond_0

    .line 85
    const-string v1, " PUBLIC \""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 86
    invoke-virtual {v0, p3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 87
    const-string v1, "\" \""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    goto :goto_0

    .line 89
    :cond_0
    const-string v1, " SYSTEM \""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 91
    :goto_0
    invoke-virtual {v0, p2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 92
    const/16 v1, 0x22

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 95
    :cond_1
    if-eqz p4, :cond_2

    invoke-virtual {p4}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_2

    .line 96
    const-string v1, " ["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 97
    invoke-virtual {v0, p4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 98
    const/16 v1, 0x5d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 100
    :cond_2
    const/16 v1, 0x3e

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 101
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeDTD(Ljava/lang/String;)V

    .line 102
    return-void
.end method

.method public writeFullEndElement()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 111
    const-string v0, ""

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeCharacters(Ljava/lang/String;)V

    .line 112
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeEndElement()V

    .line 113
    return-void
.end method

.method public writeRaw(Ljava/lang/String;)V
    .locals 2
    .param p1, "text"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 148
    const/4 v0, 0x0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {p0, p1, v0, v1}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeRaw(Ljava/lang/String;II)V

    .line 149
    return-void
.end method

.method public abstract writeRaw(Ljava/lang/String;II)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeRaw([CII)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public writeSpace(Ljava/lang/String;)V
    .locals 0
    .param p1, "text"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 123
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeRaw(Ljava/lang/String;)V

    .line 124
    return-void
.end method

.method public writeSpace([CII)V
    .locals 0
    .param p1, "text"    # [C
    .param p2, "offset"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 131
    invoke-virtual {p0, p1, p2, p3}, Lorg/codehaus/stax2/ri/Stax2WriterImpl;->writeRaw([CII)V

    .line 132
    return-void
.end method

.method public abstract writeStartDocument(Ljava/lang/String;Ljava/lang/String;Z)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method
