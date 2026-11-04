.class public Lorg/codehaus/stax2/util/StreamReader2Delegate;
.super Ljavax/xml/stream/util/StreamReaderDelegate;
.source "StreamReader2Delegate.java"

# interfaces
.implements Lorg/codehaus/stax2/XMLStreamReader2;


# instance fields
.field protected _delegate2:Lorg/codehaus/stax2/XMLStreamReader2;


# direct methods
.method public constructor <init>(Lorg/codehaus/stax2/XMLStreamReader2;)V
    .locals 0
    .param p1, "sr"    # Lorg/codehaus/stax2/XMLStreamReader2;

    .line 39
    invoke-direct {p0, p1}, Ljavax/xml/stream/util/StreamReaderDelegate;-><init>(Ljavax/xml/stream/XMLStreamReader;)V

    .line 40
    iput-object p1, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    .line 41
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

    .line 58
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->closeCompletely()V

    .line 59
    return-void
.end method

.method public getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V
    .locals 1
    .param p1, "index"    # I
    .param p2, "tvd"    # Lorg/codehaus/stax2/typed/TypedValueDecoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 298
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1, p2}, Lorg/codehaus/stax2/XMLStreamReader2;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 299
    return-void
.end method

.method public getAttributeAsArray(ILorg/codehaus/stax2/typed/TypedArrayDecoder;)I
    .locals 1
    .param p1, "index"    # I
    .param p2, "tad"    # Lorg/codehaus/stax2/typed/TypedArrayDecoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 305
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1, p2}, Lorg/codehaus/stax2/XMLStreamReader2;->getAttributeAsArray(ILorg/codehaus/stax2/typed/TypedArrayDecoder;)I

    move-result v0

    return v0
.end method

.method public getAttributeAsBinary(I)[B
    .locals 1
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 311
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getAttributeAsBinary(I)[B

    move-result-object v0

    return-object v0
.end method

.method public getAttributeAsBinary(ILorg/codehaus/stax2/typed/Base64Variant;)[B
    .locals 1
    .param p1, "index"    # I
    .param p2, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 317
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1, p2}, Lorg/codehaus/stax2/XMLStreamReader2;->getAttributeAsBinary(ILorg/codehaus/stax2/typed/Base64Variant;)[B

    move-result-object v0

    return-object v0
.end method

.method public getAttributeAsBoolean(I)Z
    .locals 1
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 177
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getAttributeAsBoolean(I)Z

    move-result v0

    return v0
.end method

.method public getAttributeAsDecimal(I)Ljava/math/BigDecimal;
    .locals 1
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 184
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getAttributeAsDecimal(I)Ljava/math/BigDecimal;

    move-result-object v0

    return-object v0
.end method

.method public getAttributeAsDouble(I)D
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 189
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getAttributeAsDouble(I)D

    move-result-wide v0

    return-wide v0
.end method

.method public getAttributeAsDoubleArray(I)[D
    .locals 1
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 236
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getAttributeAsDoubleArray(I)[D

    move-result-object v0

    return-object v0
.end method

.method public getAttributeAsFloat(I)F
    .locals 1
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 194
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getAttributeAsFloat(I)F

    move-result v0

    return v0
.end method

.method public getAttributeAsFloatArray(I)[F
    .locals 1
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 231
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getAttributeAsFloatArray(I)[F

    move-result-object v0

    return-object v0
.end method

.method public getAttributeAsInt(I)I
    .locals 1
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 199
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getAttributeAsInt(I)I

    move-result v0

    return v0
.end method

.method public getAttributeAsIntArray(I)[I
    .locals 1
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 221
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getAttributeAsIntArray(I)[I

    move-result-object v0

    return-object v0
.end method

.method public getAttributeAsInteger(I)Ljava/math/BigInteger;
    .locals 1
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 206
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getAttributeAsInteger(I)Ljava/math/BigInteger;

    move-result-object v0

    return-object v0
.end method

.method public getAttributeAsLong(I)J
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 211
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getAttributeAsLong(I)J

    move-result-wide v0

    return-wide v0
.end method

.method public getAttributeAsLongArray(I)[J
    .locals 1
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 226
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getAttributeAsLongArray(I)[J

    move-result-object v0

    return-object v0
.end method

.method public getAttributeAsQName(I)Ljavax/xml/namespace/QName;
    .locals 1
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 216
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getAttributeAsQName(I)Ljavax/xml/namespace/QName;

    move-result-object v0

    return-object v0
.end method

.method public getAttributeIndex(Ljava/lang/String;Ljava/lang/String;)I
    .locals 1
    .param p1, "namespaceURI"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 171
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1, p2}, Lorg/codehaus/stax2/XMLStreamReader2;->getAttributeIndex(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public getAttributeInfo()Lorg/codehaus/stax2/AttributeInfo;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 63
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->getAttributeInfo()Lorg/codehaus/stax2/AttributeInfo;

    move-result-object v0

    return-object v0
.end method

.method public getDTDInfo()Lorg/codehaus/stax2/DTDInfo;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 68
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->getDTDInfo()Lorg/codehaus/stax2/DTDInfo;

    move-result-object v0

    return-object v0
.end method

.method public getDepth()I
    .locals 1

    .line 73
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->getDepth()I

    move-result v0

    return v0
.end method

.method public getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V
    .locals 1
    .param p1, "tvd"    # Lorg/codehaus/stax2/typed/TypedValueDecoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 241
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 242
    return-void
.end method

.method public getElementAsBinary()[B
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 286
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->getElementAsBinary()[B

    move-result-object v0

    return-object v0
.end method

.method public getElementAsBinary(Lorg/codehaus/stax2/typed/Base64Variant;)[B
    .locals 1
    .param p1, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 291
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getElementAsBinary(Lorg/codehaus/stax2/typed/Base64Variant;)[B

    move-result-object v0

    return-object v0
.end method

.method public getElementAsBoolean()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 246
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->getElementAsBoolean()Z

    move-result v0

    return v0
.end method

.method public getElementAsDecimal()Ljava/math/BigDecimal;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 251
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->getElementAsDecimal()Ljava/math/BigDecimal;

    move-result-object v0

    return-object v0
.end method

.method public getElementAsDouble()D
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 256
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->getElementAsDouble()D

    move-result-wide v0

    return-wide v0
.end method

.method public getElementAsFloat()F
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 261
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->getElementAsFloat()F

    move-result v0

    return v0
.end method

.method public getElementAsInt()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 266
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->getElementAsInt()I

    move-result v0

    return v0
.end method

.method public getElementAsInteger()Ljava/math/BigInteger;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 271
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->getElementAsInteger()Ljava/math/BigInteger;

    move-result-object v0

    return-object v0
.end method

.method public getElementAsLong()J
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 276
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->getElementAsLong()J

    move-result-wide v0

    return-wide v0
.end method

.method public getElementAsQName()Ljavax/xml/namespace/QName;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 281
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->getElementAsQName()Ljavax/xml/namespace/QName;

    move-result-object v0

    return-object v0
.end method

.method public getFeature(Ljava/lang/String;)Ljava/lang/Object;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 79
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->getFeature(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public getLocationInfo()Lorg/codehaus/stax2/LocationInfo;
    .locals 1

    .line 84
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->getLocationInfo()Lorg/codehaus/stax2/LocationInfo;

    move-result-object v0

    return-object v0
.end method

.method public getNonTransientNamespaceContext()Ljavax/xml/namespace/NamespaceContext;
    .locals 1

    .line 89
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->getNonTransientNamespaceContext()Ljavax/xml/namespace/NamespaceContext;

    move-result-object v0

    return-object v0
.end method

.method public getPrefixedName()Ljava/lang/String;
    .locals 1

    .line 94
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->getPrefixedName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getText(Ljava/io/Writer;Z)I
    .locals 1
    .param p1, "w"    # Ljava/io/Writer;
    .param p2, "preserveContents"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 101
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1, p2}, Lorg/codehaus/stax2/XMLStreamReader2;->getText(Ljava/io/Writer;Z)I

    move-result v0

    return v0
.end method

.method public isEmptyElement()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 107
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->isEmptyElement()Z

    move-result v0

    return v0
.end method

.method public isPropertySupported(Ljava/lang/String;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 112
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->isPropertySupported(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I
    .locals 1
    .param p1, "tad"    # Lorg/codehaus/stax2/typed/TypedArrayDecoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 351
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I

    move-result v0

    return v0
.end method

.method public readElementAsBinary([BII)I
    .locals 1
    .param p1, "resultBuffer"    # [B
    .param p2, "offset"    # I
    .param p3, "maxLength"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 358
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1, p2, p3}, Lorg/codehaus/stax2/XMLStreamReader2;->readElementAsBinary([BII)I

    move-result v0

    return v0
.end method

.method public readElementAsBinary([BIILorg/codehaus/stax2/typed/Base64Variant;)I
    .locals 1
    .param p1, "resultBuffer"    # [B
    .param p2, "offset"    # I
    .param p3, "maxLength"    # I
    .param p4, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 366
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1, p2, p3, p4}, Lorg/codehaus/stax2/XMLStreamReader2;->readElementAsBinary([BIILorg/codehaus/stax2/typed/Base64Variant;)I

    move-result v0

    return v0
.end method

.method public readElementAsDoubleArray([DII)I
    .locals 1
    .param p1, "value"    # [D
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 324
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1, p2, p3}, Lorg/codehaus/stax2/XMLStreamReader2;->readElementAsDoubleArray([DII)I

    move-result v0

    return v0
.end method

.method public readElementAsFloatArray([FII)I
    .locals 1
    .param p1, "value"    # [F
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 331
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1, p2, p3}, Lorg/codehaus/stax2/XMLStreamReader2;->readElementAsFloatArray([FII)I

    move-result v0

    return v0
.end method

.method public readElementAsIntArray([III)I
    .locals 1
    .param p1, "value"    # [I
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 337
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1, p2, p3}, Lorg/codehaus/stax2/XMLStreamReader2;->readElementAsIntArray([III)I

    move-result v0

    return v0
.end method

.method public readElementAsLongArray([JII)I
    .locals 1
    .param p1, "value"    # [J
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 344
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1, p2, p3}, Lorg/codehaus/stax2/XMLStreamReader2;->readElementAsLongArray([JII)I

    move-result v0

    return v0
.end method

.method public setFeature(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 118
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1, p2}, Lorg/codehaus/stax2/XMLStreamReader2;->setFeature(Ljava/lang/String;Ljava/lang/Object;)V

    .line 119
    return-void
.end method

.method public setParent(Ljavax/xml/stream/XMLStreamReader;)V
    .locals 1
    .param p1, "pr"    # Ljavax/xml/stream/XMLStreamReader;

    .line 46
    invoke-super {p0, p1}, Ljavax/xml/stream/util/StreamReaderDelegate;->setParent(Ljavax/xml/stream/XMLStreamReader;)V

    .line 47
    move-object v0, p1

    check-cast v0, Lorg/codehaus/stax2/XMLStreamReader2;

    iput-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    .line 48
    return-void
.end method

.method public setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 123
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1, p2}, Lorg/codehaus/stax2/XMLStreamReader2;->setProperty(Ljava/lang/String;Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public setValidationProblemHandler(Lorg/codehaus/stax2/validation/ValidationProblemHandler;)Lorg/codehaus/stax2/validation/ValidationProblemHandler;
    .locals 1
    .param p1, "h"    # Lorg/codehaus/stax2/validation/ValidationProblemHandler;

    .line 139
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->setValidationProblemHandler(Lorg/codehaus/stax2/validation/ValidationProblemHandler;)Lorg/codehaus/stax2/validation/ValidationProblemHandler;

    move-result-object v0

    return-object v0
.end method

.method public skipElement()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 128
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0}, Lorg/codehaus/stax2/XMLStreamReader2;->skipElement()V

    .line 129
    return-void
.end method

.method public stopValidatingAgainst(Lorg/codehaus/stax2/validation/XMLValidationSchema;)Lorg/codehaus/stax2/validation/XMLValidator;
    .locals 1
    .param p1, "schema"    # Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 146
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->stopValidatingAgainst(Lorg/codehaus/stax2/validation/XMLValidationSchema;)Lorg/codehaus/stax2/validation/XMLValidator;

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

    .line 153
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->stopValidatingAgainst(Lorg/codehaus/stax2/validation/XMLValidator;)Lorg/codehaus/stax2/validation/XMLValidator;

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

    .line 160
    iget-object v0, p0, Lorg/codehaus/stax2/util/StreamReader2Delegate;->_delegate2:Lorg/codehaus/stax2/XMLStreamReader2;

    invoke-interface {v0, p1}, Lorg/codehaus/stax2/XMLStreamReader2;->validateAgainst(Lorg/codehaus/stax2/validation/XMLValidationSchema;)Lorg/codehaus/stax2/validation/XMLValidator;

    move-result-object v0

    return-object v0
.end method
