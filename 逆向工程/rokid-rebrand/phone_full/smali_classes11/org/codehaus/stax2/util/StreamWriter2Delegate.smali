.class public Lorg/codehaus/stax2/util/StreamWriter2Delegate;
.super Lorg/codehaus/stax2/util/StreamWriterDelegate;
.source "StreamWriter2Delegate.java"

# interfaces
.implements Lorg/codehaus/stax2/XMLStreamWriter2;


# instance fields
.field protected mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;


# direct methods
.method public constructor <init>(Lorg/codehaus/stax2/XMLStreamWriter2;)V
    .locals 0
    .param p1, "parent"    # Lorg/codehaus/stax2/XMLStreamWriter2;

    .line 32
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/util/StreamWriterDelegate;-><init>(Ljavax/xml/stream/XMLStreamWriter;)V

    .line 33
    return-void
.end method


# virtual methods
.method public closeCompletely()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 51
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamWriter2;->closeCompletely()V

    .line 52
    return-void
.end method

.method public copyEventFromReader(Lorg/codehaus/stax2/XMLStreamReader2;Z)V
    .locals 1
    .param p1, "r"    # Lorg/codehaus/stax2/XMLStreamReader2;
    .param p2, "preserveEventData"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 58
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2}, Lorg/codehaus/stax2/XMLStreamWriter2;->copyEventFromReader(Lorg/codehaus/stax2/XMLStreamReader2;Z)V

    .line 59
    return-void
.end method

.method public getEncoding()Ljava/lang/String;
    .locals 1

    .line 63
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamWriter2;->getEncoding()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
    .locals 1

    .line 68
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamWriter2;->getLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v0

    return-object v0
.end method

.method public isPropertySupported(Ljava/lang/String;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 73
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamWriter2;->isPropertySupported(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public setParent(Ljavax/xml/stream/XMLStreamWriter;)V
    .locals 1
    .param p1, "w"    # Ljavax/xml/stream/XMLStreamWriter;

    .line 38
    invoke-super {p0, p1}, Lorg/codehaus/stax2/util/StreamWriterDelegate;->setParent(Ljavax/xml/stream/XMLStreamWriter;)V

    .line 39
    move-object v0, p1

    check-cast v0, Lorg/codehaus/stax2/XMLStreamWriter2;

    iput-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    .line 40
    return-void
.end method

.method public setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 78
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2}, Lorg/codehaus/stax2/XMLStreamWriter2;->setProperty(Ljava/lang/String;Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public setValidationProblemHandler(Lorg/codehaus/stax2/validation/ValidationProblemHandler;)Lorg/codehaus/stax2/validation/ValidationProblemHandler;
    .locals 1
    .param p1, "h"    # Lorg/codehaus/stax2/validation/ValidationProblemHandler;

    .line 299
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamWriter2;->setValidationProblemHandler(Lorg/codehaus/stax2/validation/ValidationProblemHandler;)Lorg/codehaus/stax2/validation/ValidationProblemHandler;

    move-result-object v0

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

    .line 306
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamWriter2;->stopValidatingAgainst(Lorg/codehaus/stax2/validation/XMLValidationSchema;)Lorg/codehaus/stax2/validation/XMLValidator;

    move-result-object v0

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

    .line 313
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamWriter2;->stopValidatingAgainst(Lorg/codehaus/stax2/validation/XMLValidator;)Lorg/codehaus/stax2/validation/XMLValidator;

    move-result-object v0

    return-object v0
.end method

.method public validateAgainst(Lorg/codehaus/stax2/validation/XMLValidationSchema;)Lorg/codehaus/stax2/validation/XMLValidator;
    .locals 1
    .param p1, "schema"    # Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 320
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamWriter2;->validateAgainst(Lorg/codehaus/stax2/validation/XMLValidationSchema;)Lorg/codehaus/stax2/validation/XMLValidator;

    move-result-object v0

    return-object v0
.end method

.method public writeBinary(Lorg/codehaus/stax2/typed/Base64Variant;[BII)V
    .locals 1
    .param p1, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .param p2, "value"    # [B
    .param p3, "from"    # I
    .param p4, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 144
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3, p4}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeBinary(Lorg/codehaus/stax2/typed/Base64Variant;[BII)V

    .line 145
    return-void
.end method

.method public writeBinary([BII)V
    .locals 1
    .param p1, "value"    # [B
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 137
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeBinary([BII)V

    .line 138
    return-void
.end method

.method public writeBinaryAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "namespaceURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 150
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3, p4}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeBinaryAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V

    .line 151
    return-void
.end method

.method public writeBinaryAttribute(Lorg/codehaus/stax2/typed/Base64Variant;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V
    .locals 6
    .param p1, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .param p2, "prefix"    # Ljava/lang/String;
    .param p3, "namespaceURI"    # Ljava/lang/String;
    .param p4, "localName"    # Ljava/lang/String;
    .param p5, "value"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 156
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    invoke-interface/range {v0 .. v5}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeBinaryAttribute(Lorg/codehaus/stax2/typed/Base64Variant;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V

    .line 157
    return-void
.end method

.method public writeBoolean(Z)V
    .locals 1
    .param p1, "value"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 161
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeBoolean(Z)V

    .line 162
    return-void
.end method

.method public writeBooleanAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "namespaceURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 167
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3, p4}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeBooleanAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)V

    .line 168
    return-void
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

    .line 83
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeCData([CII)V

    .line 84
    return-void
.end method

.method public writeDTD(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "rootName"    # Ljava/lang/String;
    .param p2, "systemId"    # Ljava/lang/String;
    .param p3, "publicId"    # Ljava/lang/String;
    .param p4, "internalSubset"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 89
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3, p4}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeDTD(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 90
    return-void
.end method

.method public writeDecimal(Ljava/math/BigDecimal;)V
    .locals 1
    .param p1, "value"    # Ljava/math/BigDecimal;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 172
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeDecimal(Ljava/math/BigDecimal;)V

    .line 173
    return-void
.end method

.method public writeDecimalAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/math/BigDecimal;)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "namespaceURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # Ljava/math/BigDecimal;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 178
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3, p4}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeDecimalAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/math/BigDecimal;)V

    .line 179
    return-void
.end method

.method public writeDouble(D)V
    .locals 1
    .param p1, "value"    # D
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 183
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeDouble(D)V

    .line 184
    return-void
.end method

.method public writeDoubleArray([DII)V
    .locals 1
    .param p1, "value"    # [D
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 189
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeDoubleArray([DII)V

    .line 190
    return-void
.end method

.method public writeDoubleArrayAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[D)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "namespaceURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # [D
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 195
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3, p4}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeDoubleArrayAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[D)V

    .line 196
    return-void
.end method

.method public writeDoubleAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;D)V
    .locals 6
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "namespaceURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # D
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 201
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-wide v4, p4

    invoke-interface/range {v0 .. v5}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeDoubleAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;D)V

    .line 202
    return-void
.end method

.method public writeFloat(F)V
    .locals 1
    .param p1, "value"    # F
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 206
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeFloat(F)V

    .line 207
    return-void
.end method

.method public writeFloatArray([FII)V
    .locals 1
    .param p1, "value"    # [F
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 213
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeFloatArray([FII)V

    .line 214
    return-void
.end method

.method public writeFloatArrayAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[F)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "namespaceURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # [F
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 219
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3, p4}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeFloatArrayAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[F)V

    .line 220
    return-void
.end method

.method public writeFloatAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "namespaceURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # F
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 225
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3, p4}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeFloatAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    .line 226
    return-void
.end method

.method public writeFullEndElement()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 94
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeFullEndElement()V

    .line 95
    return-void
.end method

.method public writeInt(I)V
    .locals 1
    .param p1, "value"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 230
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeInt(I)V

    .line 231
    return-void
.end method

.method public writeIntArray([III)V
    .locals 1
    .param p1, "value"    # [I
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 236
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeIntArray([III)V

    .line 237
    return-void
.end method

.method public writeIntArrayAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[I)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "namespaceURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # [I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 242
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3, p4}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeIntArrayAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[I)V

    .line 243
    return-void
.end method

.method public writeIntAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "namespaceURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 248
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3, p4}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeIntAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    .line 249
    return-void
.end method

.method public writeInteger(Ljava/math/BigInteger;)V
    .locals 1
    .param p1, "value"    # Ljava/math/BigInteger;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 253
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeInteger(Ljava/math/BigInteger;)V

    .line 254
    return-void
.end method

.method public writeIntegerAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/math/BigInteger;)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "namespaceURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # Ljava/math/BigInteger;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 259
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3, p4}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeIntegerAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/math/BigInteger;)V

    .line 260
    return-void
.end method

.method public writeLong(J)V
    .locals 1
    .param p1, "value"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 264
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeLong(J)V

    .line 265
    return-void
.end method

.method public writeLongArray([JII)V
    .locals 1
    .param p1, "value"    # [J
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 270
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeLongArray([JII)V

    .line 271
    return-void
.end method

.method public writeLongArrayAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[J)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "namespaceURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # [J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 276
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3, p4}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeLongArrayAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[J)V

    .line 277
    return-void
.end method

.method public writeLongAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V
    .locals 6
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "namespaceURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 282
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-wide v4, p4

    invoke-interface/range {v0 .. v5}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeLongAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    .line 283
    return-void
.end method

.method public writeQName(Ljavax/xml/namespace/QName;)V
    .locals 1
    .param p1, "value"    # Ljavax/xml/namespace/QName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 287
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeQName(Ljavax/xml/namespace/QName;)V

    .line 288
    return-void
.end method

.method public writeQNameAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljavax/xml/namespace/QName;)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "namespaceURI"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .param p4, "value"    # Ljavax/xml/namespace/QName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 294
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3, p4}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeQNameAttribute(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljavax/xml/namespace/QName;)V

    .line 295
    return-void
.end method

.method public writeRaw(Ljava/lang/String;)V
    .locals 1
    .param p1, "text"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 99
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeRaw(Ljava/lang/String;)V

    .line 100
    return-void
.end method

.method public writeRaw(Ljava/lang/String;II)V
    .locals 1
    .param p1, "text"    # Ljava/lang/String;
    .param p2, "offset"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 106
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeRaw(Ljava/lang/String;II)V

    .line 107
    return-void
.end method

.method public writeRaw([CII)V
    .locals 1
    .param p1, "text"    # [C
    .param p2, "offset"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 112
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeRaw([CII)V

    .line 113
    return-void
.end method

.method public writeSpace(Ljava/lang/String;)V
    .locals 1
    .param p1, "text"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 117
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeSpace(Ljava/lang/String;)V

    .line 118
    return-void
.end method

.method public writeSpace([CII)V
    .locals 1
    .param p1, "text"    # [C
    .param p2, "offset"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 124
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeSpace([CII)V

    .line 125
    return-void
.end method

.method public writeStartDocument(Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 1
    .param p1, "version"    # Ljava/lang/String;
    .param p2, "encoding"    # Ljava/lang/String;
    .param p3, "standAlone"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 130
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamWriter2Delegate;->mDelegate2:Lorg/codehaus/stax2/XMLStreamWriter2;

    invoke-interface {v0, p1, p2, p3}, Lorg/codehaus/stax2/XMLStreamWriter2;->writeStartDocument(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 131
    return-void
.end method
