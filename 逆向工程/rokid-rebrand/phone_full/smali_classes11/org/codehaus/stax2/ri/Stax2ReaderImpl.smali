.class public abstract Lorg/codehaus/stax2/ri/Stax2ReaderImpl;
.super Ljava/lang/Object;
.source "Stax2ReaderImpl.java"

# interfaces
.implements Lorg/codehaus/stax2/XMLStreamReader2;
.implements Lorg/codehaus/stax2/AttributeInfo;
.implements Lorg/codehaus/stax2/DTDInfo;
.implements Lorg/codehaus/stax2/LocationInfo;


# instance fields
.field protected _decoderFactory:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 58
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 59
    return-void
.end method


# virtual methods
.method protected _constructTypeException(Ljava/lang/IllegalArgumentException;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;
    .locals 3
    .param p1, "iae"    # Ljava/lang/IllegalArgumentException;
    .param p2, "lexicalValue"    # Ljava/lang/String;

    .line 668
    new-instance v0, Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    invoke-virtual {p1}, Ljava/lang/IllegalArgumentException;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getStartLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v2

    invoke-direct {v0, p2, v1, v2, p1}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/stream/Location;Ljava/lang/IllegalArgumentException;)V

    return-object v0
.end method

.method protected _decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;
    .locals 1

    .line 660
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    if-nez v0, :cond_0

    .line 661
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;-><init>()V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    .line 663
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    return-object v0
.end method

.method public closeCompletely()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 221
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->close()V

    .line 222
    return-void
.end method

.method public findAttributeIndex(Ljava/lang/String;Ljava/lang/String;)I
    .locals 1
    .param p1, "nsURI"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 237
    const/4 v0, -0x1

    return v0
.end method

.method public getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V
    .locals 3
    .param p1, "index"    # I
    .param p2, "tvd"    # Lorg/codehaus/stax2/typed/TypedValueDecoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 596
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getAttributeValue(I)Ljava/lang/String;

    move-result-object v0

    .line 598
    .local v0, "value":Ljava/lang/String;
    :try_start_0
    invoke-virtual {p2, v0}, Lorg/codehaus/stax2/typed/TypedValueDecoder;->decode(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 601
    nop

    .line 602
    return-void

    .line 599
    :catch_0
    move-exception v1

    .line 600
    .local v1, "iae":Ljava/lang/IllegalArgumentException;
    invoke-virtual {p0, v1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_constructTypeException(Ljava/lang/IllegalArgumentException;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    move-result-object v2

    throw v2
.end method

.method public abstract getAttributeAsArray(ILorg/codehaus/stax2/typed/TypedArrayDecoder;)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public getAttributeAsBinary(I)[B
    .locals 1
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 647
    invoke-static {}, Lorg/codehaus/stax2/typed/Base64Variants;->getDefaultVariant()Lorg/codehaus/stax2/typed/Base64Variant;

    move-result-object v0

    invoke-virtual {p0, v0, p1}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getAttributeAsBinary(Lorg/codehaus/stax2/typed/Base64Variant;I)[B

    move-result-object v0

    return-object v0
.end method

.method public abstract getAttributeAsBinary(Lorg/codehaus/stax2/typed/Base64Variant;I)[B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public getAttributeAsBoolean(I)Z
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 531
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getBooleanDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;

    move-result-object v0

    .line 532
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 533
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;->getValue()Z

    move-result v1

    return v1
.end method

.method public getAttributeAsDecimal(I)Ljava/math/BigDecimal;
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 579
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDecimalDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;

    move-result-object v0

    .line 580
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 581
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;->getValue()Ljava/math/BigDecimal;

    move-result-object v1

    return-object v1
.end method

.method public getAttributeAsDouble(I)D
    .locals 3
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 563
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDoubleDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    move-result-object v0

    .line 564
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 565
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;->getValue()D

    move-result-wide v1

    return-wide v1
.end method

.method public getAttributeAsDoubleArray(I)[D
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 631
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDoubleArrayDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;

    move-result-object v0

    .line 632
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getAttributeAsArray(ILorg/codehaus/stax2/typed/TypedArrayDecoder;)I

    .line 633
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->getValues()[D

    move-result-object v1

    return-object v1
.end method

.method public getAttributeAsFloat(I)F
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 555
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getFloatDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    move-result-object v0

    .line 556
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 557
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;->getValue()F

    move-result v1

    return v1
.end method

.method public getAttributeAsFloatArray(I)[F
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 623
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getFloatArrayDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;

    move-result-object v0

    .line 624
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getAttributeAsArray(ILorg/codehaus/stax2/typed/TypedArrayDecoder;)I

    .line 625
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->getValues()[F

    move-result-object v1

    return-object v1
.end method

.method public getAttributeAsInt(I)I
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 539
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    move-result-object v0

    .line 540
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 541
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->getValue()I

    move-result v1

    return v1
.end method

.method public getAttributeAsIntArray(I)[I
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 607
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntArrayDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;

    move-result-object v0

    .line 608
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getAttributeAsArray(ILorg/codehaus/stax2/typed/TypedArrayDecoder;)I

    .line 609
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->getValues()[I

    move-result-object v1

    return-object v1
.end method

.method public getAttributeAsInteger(I)Ljava/math/BigInteger;
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 571
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntegerDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;

    move-result-object v0

    .line 572
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 573
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;->getValue()Ljava/math/BigInteger;

    move-result-object v1

    return-object v1
.end method

.method public getAttributeAsLong(I)J
    .locals 3
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 547
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getLongDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    move-result-object v0

    .line 548
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 549
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->getValue()J

    move-result-wide v1

    return-wide v1
.end method

.method public getAttributeAsLongArray(I)[J
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 615
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getLongArrayDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;

    move-result-object v0

    .line 616
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getAttributeAsArray(ILorg/codehaus/stax2/typed/TypedArrayDecoder;)I

    .line 617
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->getValues()[J

    move-result-object v1

    return-object v1
.end method

.method public getAttributeAsQName(I)Ljavax/xml/namespace/QName;
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 587
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getNamespaceContext()Ljavax/xml/namespace/NamespaceContext;

    move-result-object v1

    invoke-virtual {v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getQNameDecoder(Ljavax/xml/namespace/NamespaceContext;)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;

    move-result-object v0

    .line 588
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 590
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->getValue()Ljavax/xml/namespace/QName;

    move-result-object v1

    return-object v1
.end method

.method public abstract getAttributeIndex(Ljava/lang/String;Ljava/lang/String;)I
.end method

.method public getAttributeInfo()Lorg/codehaus/stax2/AttributeInfo;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 128
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getEventType()I

    move-result v0

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    .line 129
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->throwNotStartElem()V

    .line 131
    :cond_0
    return-object p0
.end method

.method public abstract getCurrentLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
.end method

.method public getDTDInfo()Lorg/codehaus/stax2/DTDInfo;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 139
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getEventType()I

    move-result v0

    const/16 v1, 0xb

    if-eq v0, v1, :cond_0

    .line 140
    const/4 v0, 0x0

    return-object v0

    .line 142
    :cond_0
    return-object p0
.end method

.method public getDTDInternalSubset()Ljava/lang/String;
    .locals 1

    .line 286
    const/4 v0, 0x0

    return-object v0
.end method

.method public getDTDPublicId()Ljava/lang/String;
    .locals 1

    .line 272
    const/4 v0, 0x0

    return-object v0
.end method

.method public getDTDRootName()Ljava/lang/String;
    .locals 1

    .line 267
    const/4 v0, 0x0

    return-object v0
.end method

.method public getDTDSystemId()Ljava/lang/String;
    .locals 1

    .line 277
    const/4 v0, 0x0

    return-object v0
.end method

.method public abstract getDepth()I
.end method

.method public getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V
    .locals 3
    .param p1, "tvd"    # Lorg/codehaus/stax2/typed/TypedValueDecoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 455
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getElementText()Ljava/lang/String;

    move-result-object v0

    .line 457
    .local v0, "value":Ljava/lang/String;
    :try_start_0
    invoke-virtual {p1, v0}, Lorg/codehaus/stax2/typed/TypedValueDecoder;->decode(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 460
    nop

    .line 461
    return-void

    .line 458
    :catch_0
    move-exception v1

    .line 459
    .local v1, "iae":Ljava/lang/IllegalArgumentException;
    invoke-virtual {p0, v1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_constructTypeException(Ljava/lang/IllegalArgumentException;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    move-result-object v2

    throw v2
.end method

.method public getElementAsBinary()[B
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 445
    invoke-static {}, Lorg/codehaus/stax2/typed/Base64Variants;->getDefaultVariant()Lorg/codehaus/stax2/typed/Base64Variant;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getElementAsBinary(Lorg/codehaus/stax2/typed/Base64Variant;)[B

    move-result-object v0

    return-object v0
.end method

.method public abstract getElementAsBinary(Lorg/codehaus/stax2/typed/Base64Variant;)[B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public getElementAsBoolean()Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 380
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getBooleanDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;

    move-result-object v0

    .line 381
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 382
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;->getValue()Z

    move-result v1

    return v1
.end method

.method public getElementAsDecimal()Ljava/math/BigDecimal;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 428
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDecimalDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;

    move-result-object v0

    .line 429
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 430
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;->getValue()Ljava/math/BigDecimal;

    move-result-object v1

    return-object v1
.end method

.method public getElementAsDouble()D
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 412
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDoubleDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    move-result-object v0

    .line 413
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 414
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;->getValue()D

    move-result-wide v1

    return-wide v1
.end method

.method public getElementAsFloat()F
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 404
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getFloatDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    move-result-object v0

    .line 405
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 406
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;->getValue()F

    move-result v1

    return v1
.end method

.method public getElementAsInt()I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 388
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    move-result-object v0

    .line 389
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 390
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->getValue()I

    move-result v1

    return v1
.end method

.method public getElementAsInteger()Ljava/math/BigInteger;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 420
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntegerDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;

    move-result-object v0

    .line 421
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 422
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;->getValue()Ljava/math/BigInteger;

    move-result-object v1

    return-object v1
.end method

.method public getElementAsLong()J
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 396
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getLongDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    move-result-object v0

    .line 397
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 398
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->getValue()J

    move-result-wide v1

    return-wide v1
.end method

.method public getElementAsQName()Ljavax/xml/namespace/QName;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 436
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getNamespaceContext()Ljavax/xml/namespace/NamespaceContext;

    move-result-object v1

    invoke-virtual {v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getQNameDecoder(Ljavax/xml/namespace/NamespaceContext;)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;

    move-result-object v0

    .line 437
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 439
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->getValue()Ljavax/xml/namespace/QName;

    move-result-object v1

    return-object v1
.end method

.method public abstract getEndLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public getEndingByteOffset()J
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 317
    const-wide/16 v0, -0x1

    return-wide v0
.end method

.method public getEndingCharOffset()J
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 323
    const-wide/16 v0, -0x1

    return-wide v0
.end method

.method public getFeature(Ljava/lang/String;)Ljava/lang/Object;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 74
    const/4 v0, 0x0

    return-object v0
.end method

.method public getIdAttributeIndex()I
    .locals 1

    .line 244
    const/4 v0, -0x1

    return v0
.end method

.method public final getLocationInfo()Lorg/codehaus/stax2/LocationInfo;
    .locals 0

    .line 152
    return-object p0
.end method

.method public abstract getNonTransientNamespaceContext()Ljavax/xml/namespace/NamespaceContext;
.end method

.method public getNotationAttributeIndex()I
    .locals 1

    .line 251
    const/4 v0, -0x1

    return v0
.end method

.method public getPrefixedName()Ljava/lang/String;
    .locals 5

    .line 189
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getEventType()I

    move-result v0

    sparse-switch v0, :sswitch_data_0

    .line 213
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Current state not START_ELEMENT, END_ELEMENT, ENTITY_REFERENCE, PROCESSING_INSTRUCTION or DTD"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 210
    :sswitch_0
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getDTDRootName()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 206
    :sswitch_1
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getLocalName()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 208
    :sswitch_2
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getPITarget()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 193
    :sswitch_3
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getPrefix()Ljava/lang/String;

    move-result-object v0

    .line 194
    .local v0, "prefix":Ljava/lang/String;
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getLocalName()Ljava/lang/String;

    move-result-object v1

    .line 196
    .local v1, "ln":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 197
    return-object v1

    .line 199
    :cond_0
    new-instance v2, Ljava/lang/StringBuffer;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v3

    add-int/lit8 v3, v3, 0x1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v4

    add-int/2addr v3, v4

    invoke-direct {v2, v3}, Ljava/lang/StringBuffer;-><init>(I)V

    .line 200
    .local v2, "sb":Ljava/lang/StringBuffer;
    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 201
    const/16 v3, 0x3a

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 202
    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 203
    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3

    nop

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_3
        0x2 -> :sswitch_3
        0x3 -> :sswitch_2
        0x9 -> :sswitch_1
        0xb -> :sswitch_0
    .end sparse-switch
.end method

.method public getProcessedDTD()Ljava/lang/Object;
    .locals 1

    .line 262
    const/4 v0, 0x0

    return-object v0
.end method

.method public getProcessedDTDSchema()Lorg/codehaus/stax2/validation/DTDValidationSchema;
    .locals 1

    .line 293
    const/4 v0, 0x0

    return-object v0
.end method

.method public abstract getStartLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
.end method

.method public getStartingByteOffset()J
    .locals 2

    .line 306
    const-wide/16 v0, -0x1

    return-wide v0
.end method

.method public getStartingCharOffset()J
    .locals 2

    .line 311
    const-wide/16 v0, 0x0

    return-wide v0
.end method

.method public getText(Ljava/io/Writer;Z)I
    .locals 3
    .param p1, "w"    # Ljava/io/Writer;
    .param p2, "preserveContents"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 161
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getTextCharacters()[C

    move-result-object v0

    .line 162
    .local v0, "cbuf":[C
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getTextStart()I

    move-result v1

    .line 163
    .local v1, "start":I
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getTextLength()I

    move-result v2

    .line 165
    .local v2, "len":I
    if-lez v2, :cond_0

    .line 166
    invoke-virtual {p1, v0, v1, v2}, Ljava/io/Writer;->write([CII)V

    .line 168
    :cond_0
    return v2
.end method

.method public abstract isEmptyElement()Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public isPropertySupported(Ljava/lang/String;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 92
    const/4 v0, 0x0

    return v0
.end method

.method public abstract readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract readElementAsBinary(Lorg/codehaus/stax2/typed/Base64Variant;[BII)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
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

    .line 513
    invoke-static {}, Lorg/codehaus/stax2/typed/Base64Variants;->getDefaultVariant()Lorg/codehaus/stax2/typed/Base64Variant;

    move-result-object v0

    invoke-virtual {p0, v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->readElementAsBinary(Lorg/codehaus/stax2/typed/Base64Variant;[BII)I

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

    .line 490
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDoubleArrayDecoder([DII)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I

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

    .line 484
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getFloatArrayDecoder([FII)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I

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

    .line 472
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntArrayDecoder([III)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I

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

    .line 478
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getLongArrayDecoder([JII)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I

    move-result v0

    return v0
.end method

.method public setFeature(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 0
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 82
    return-void
.end method

.method public setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 98
    const/4 v0, 0x0

    return v0
.end method

.method public abstract setValidationProblemHandler(Lorg/codehaus/stax2/validation/ValidationProblemHandler;)Lorg/codehaus/stax2/validation/ValidationProblemHandler;
.end method

.method public skipElement()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 106
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->getEventType()I

    move-result v0

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    .line 107
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->throwNotStartElem()V

    .line 109
    :cond_0
    const/4 v0, 0x1

    .line 112
    .local v0, "nesting":I
    :goto_0
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->next()I

    move-result v2

    .line 113
    .local v2, "type":I
    if-ne v2, v1, :cond_1

    .line 114
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 115
    :cond_1
    const/4 v3, 0x2

    if-ne v2, v3, :cond_2

    .line 116
    add-int/lit8 v0, v0, -0x1

    if-nez v0, :cond_2

    .line 117
    nop

    .line 121
    .end local v2    # "type":I
    return-void

    .line 120
    :cond_2
    :goto_1
    goto :goto_0
.end method

.method public stopValidatingAgainst(Lorg/codehaus/stax2/validation/XMLValidationSchema;)Lorg/codehaus/stax2/validation/XMLValidator;
    .locals 1
    .param p1, "schema"    # Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 356
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->throwUnsupported()V

    .line 357
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

    .line 364
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->throwUnsupported()V

    .line 365
    const/4 v0, 0x0

    return-object v0
.end method

.method protected throwNotStartElem()V
    .locals 2

    .line 685
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Current state not START_ELEMENT"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected throwUnsupported()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 680
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    const-string v1, "Unsupported method"

    invoke-direct {v0, v1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public validateAgainst(Lorg/codehaus/stax2/validation/XMLValidationSchema;)Lorg/codehaus/stax2/validation/XMLValidator;
    .locals 1
    .param p1, "schema"    # Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 348
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderImpl;->throwUnsupported()V

    .line 349
    const/4 v0, 0x0

    return-object v0
.end method
