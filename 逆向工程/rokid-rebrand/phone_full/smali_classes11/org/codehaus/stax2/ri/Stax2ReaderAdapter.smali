.class public Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;
.super Ljavax/xml/stream/util/StreamReaderDelegate;
.source "Stax2ReaderAdapter.java"

# interfaces
.implements Lorg/codehaus/stax2/XMLStreamReader2;
.implements Lorg/codehaus/stax2/AttributeInfo;
.implements Lorg/codehaus/stax2/DTDInfo;
.implements Lorg/codehaus/stax2/LocationInfo;


# static fields
.field static final INT_SPACE:I = 0x20

.field private static final MASK_GET_ELEMENT_TEXT:I = 0x1250

.field protected static final MASK_TYPED_ACCESS_BINARY:I = 0x1052


# instance fields
.field protected _base64Decoder:Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;

.field protected _decoderFactory:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

.field protected _depth:I

.field protected _typedContent:Ljava/lang/String;


# direct methods
.method protected constructor <init>(Ljavax/xml/stream/XMLStreamReader;)V
    .locals 1
    .param p1, "sr"    # Ljavax/xml/stream/XMLStreamReader;

    .line 94
    invoke-direct {p0, p1}, Ljavax/xml/stream/util/StreamReaderDelegate;-><init>(Ljavax/xml/stream/XMLStreamReader;)V

    .line 72
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_base64Decoder:Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;

    .line 77
    const/4 v0, 0x0

    iput v0, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_depth:I

    .line 95
    return-void
.end method

.method private final checkExpand(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)Z
    .locals 1
    .param p1, "tad"    # Lorg/codehaus/stax2/typed/TypedArrayDecoder;

    .line 654
    instance-of v0, p1, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;

    if-eqz v0, :cond_0

    .line 655
    move-object v0, p1

    check-cast v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;->expand()V

    .line 656
    const/4 v0, 0x1

    return v0

    .line 658
    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public static wrapIfNecessary(Ljavax/xml/stream/XMLStreamReader;)Lorg/codehaus/stax2/XMLStreamReader2;
    .locals 1
    .param p0, "sr"    # Ljavax/xml/stream/XMLStreamReader;

    .line 106
    instance-of v0, p0, Lorg/codehaus/stax2/XMLStreamReader2;

    if-eqz v0, :cond_0

    .line 107
    move-object v0, p0

    check-cast v0, Lorg/codehaus/stax2/XMLStreamReader2;

    return-object v0

    .line 109
    :cond_0
    new-instance v0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;

    invoke-direct {v0, p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;-><init>(Ljavax/xml/stream/XMLStreamReader;)V

    return-object v0
.end method


# virtual methods
.method protected _base64Decoder()Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;
    .locals 1

    .line 1081
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_base64Decoder:Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;

    if-nez v0, :cond_0

    .line 1082
    new-instance v0, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;-><init>()V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_base64Decoder:Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;

    .line 1084
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_base64Decoder:Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;

    return-object v0
.end method

.method protected _constructTypeException(Ljava/lang/IllegalArgumentException;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;
    .locals 3
    .param p1, "iae"    # Ljava/lang/IllegalArgumentException;
    .param p2, "lexicalValue"    # Ljava/lang/String;

    .line 1113
    invoke-virtual {p1}, Ljava/lang/IllegalArgumentException;->getMessage()Ljava/lang/String;

    move-result-object v0

    .line 1114
    .local v0, "msg":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 1115
    const-string v0, ""

    .line 1117
    :cond_0
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getStartLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v1

    .line 1118
    .local v1, "loc":Ljavax/xml/stream/Location;
    if-nez v1, :cond_1

    .line 1119
    new-instance v2, Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    invoke-direct {v2, p2, v0, p1}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/IllegalArgumentException;)V

    return-object v2

    .line 1121
    :cond_1
    new-instance v2, Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    invoke-direct {v2, p2, v0, v1, p1}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/stream/Location;Ljava/lang/IllegalArgumentException;)V

    return-object v2
.end method

.method protected _constructTypeException(Ljava/lang/String;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;
    .locals 2
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "lexicalValue"    # Ljava/lang/String;

    .line 1126
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getStartLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v0

    .line 1127
    .local v0, "loc":Ljavax/xml/stream/Location;
    if-nez v0, :cond_0

    .line 1128
    new-instance v1, Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    invoke-direct {v1, p2, p1}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    return-object v1

    .line 1130
    :cond_0
    new-instance v1, Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    invoke-direct {v1, p2, p1, v0}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/stream/Location;)V

    return-object v1
.end method

.method protected _decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;
    .locals 1

    .line 1073
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    if-nez v0, :cond_0

    .line 1074
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;-><init>()V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    .line 1076
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    return-object v0
.end method

.method protected _getAttributeAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;Ljava/lang/String;)I
    .locals 9
    .param p1, "tad"    # Lorg/codehaus/stax2/typed/TypedArrayDecoder;
    .param p2, "attrValue"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 606
    const/4 v0, 0x0

    .line 607
    .local v0, "ptr":I
    const/4 v1, 0x0

    .line 608
    .local v1, "start":I
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v2

    .line 609
    .local v2, "end":I
    const/4 v3, 0x0

    .line 610
    .local v3, "lexical":Ljava/lang/String;
    const/4 v4, 0x0

    .line 614
    .local v4, "count":I
    :goto_0
    if-ge v0, v2, :cond_4

    .line 616
    :cond_0
    :try_start_0
    invoke-virtual {p2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v5

    const/16 v6, 0x20

    if-gt v5, v6, :cond_1

    .line 617
    add-int/lit8 v0, v0, 0x1

    if-lt v0, v2, :cond_0

    .line 618
    goto :goto_2

    .line 622
    :cond_1
    move v1, v0

    .line 623
    add-int/lit8 v0, v0, 0x1

    .line 624
    :goto_1
    if-ge v0, v2, :cond_2

    invoke-virtual {p2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v5

    if-le v5, v6, :cond_2

    .line 625
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 627
    :cond_2
    move v5, v0

    .line 628
    .local v5, "tokenEnd":I
    add-int/lit8 v0, v0, 0x1

    .line 630
    invoke-virtual {p2, v1, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    move-object v3, v6

    .line 631
    add-int/lit8 v4, v4, 0x1

    .line 632
    invoke-virtual {p1, v3}, Lorg/codehaus/stax2/typed/TypedArrayDecoder;->decodeValue(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 633
    invoke-direct {p0, p1}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->checkExpand(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)Z

    move-result v6
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    if-nez v6, :cond_3

    .line 634
    goto :goto_2

    .line 637
    .end local v5    # "tokenEnd":I
    :cond_3
    goto :goto_0

    .line 638
    :catch_0
    move-exception v5

    .line 640
    .local v5, "iae":Ljava/lang/IllegalArgumentException;
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getLocation()Ljavax/xml/stream/Location;

    move-result-object v6

    .line 641
    .local v6, "loc":Ljavax/xml/stream/Location;
    new-instance v7, Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    invoke-virtual {v5}, Ljava/lang/IllegalArgumentException;->getMessage()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v3, v8, v6, v5}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/stream/Location;Ljava/lang/IllegalArgumentException;)V

    throw v7

    .line 642
    .end local v5    # "iae":Ljava/lang/IllegalArgumentException;
    .end local v6    # "loc":Ljavax/xml/stream/Location;
    :cond_4
    :goto_2
    nop

    .line 643
    return v4
.end method

.method public closeCompletely()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 862
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->close()V

    .line 863
    return-void
.end method

.method public findAttributeIndex(Ljava/lang/String;Ljava/lang/String;)I
    .locals 4
    .param p1, "nsURI"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 877
    const-string v0, ""

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 878
    const/4 p1, 0x0

    .line 880
    :cond_0
    const/4 v0, 0x0

    .local v0, "i":I
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeCount()I

    move-result v1

    .local v1, "len":I
    :goto_0
    if-ge v0, v1, :cond_4

    .line 881
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeLocalName(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 882
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeNamespace(I)Ljava/lang/String;

    move-result-object v2

    .line 883
    .local v2, "otherUri":Ljava/lang/String;
    if-nez p1, :cond_2

    .line 884
    if-eqz v2, :cond_1

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    if-nez v3, :cond_3

    .line 885
    :cond_1
    return v0

    .line 888
    :cond_2
    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 889
    return v0

    .line 880
    .end local v2    # "otherUri":Ljava/lang/String;
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 894
    .end local v0    # "i":I
    .end local v1    # "len":I
    :cond_4
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

    .line 553
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeValue(I)Ljava/lang/String;

    move-result-object v0

    .line 554
    .local v0, "value":Ljava/lang/String;
    invoke-static {v0}, Lorg/codehaus/stax2/ri/Stax2Util;->trimSpaces(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 556
    if-nez v0, :cond_0

    .line 557
    :try_start_0
    invoke-virtual {p2}, Lorg/codehaus/stax2/typed/TypedValueDecoder;->handleEmptyValue()V

    goto :goto_0

    .line 559
    :cond_0
    invoke-virtual {p2, v0}, Lorg/codehaus/stax2/typed/TypedValueDecoder;->decode(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 563
    :goto_0
    nop

    .line 564
    return-void

    .line 561
    :catch_0
    move-exception v1

    .line 562
    .local v1, "iae":Ljava/lang/IllegalArgumentException;
    invoke-virtual {p0, v1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_constructTypeException(Ljava/lang/IllegalArgumentException;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    move-result-object v2

    throw v2
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

    .line 601
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeValue(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, p2, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_getAttributeAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;Ljava/lang/String;)I

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

    .line 664
    invoke-static {}, Lorg/codehaus/stax2/typed/Base64Variants;->getDefaultVariant()Lorg/codehaus/stax2/typed/Base64Variant;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeAsBinary(ILorg/codehaus/stax2/typed/Base64Variant;)[B

    move-result-object v0

    return-object v0
.end method

.method public getAttributeAsBinary(ILorg/codehaus/stax2/typed/Base64Variant;)[B
    .locals 6
    .param p1, "index"    # I
    .param p2, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 670
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeValue(I)Ljava/lang/String;

    move-result-object v0

    .line 671
    .local v0, "lexical":Ljava/lang/String;
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_base64Decoder()Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;

    move-result-object v1

    .line 672
    .local v1, "dec":Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;
    const/4 v2, 0x1

    invoke-virtual {v1, p2, v2, v0}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->init(Lorg/codehaus/stax2/typed/Base64Variant;ZLjava/lang/String;)V

    .line 674
    :try_start_0
    invoke-virtual {v1}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->decodeCompletely()[B

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    .line 675
    :catch_0
    move-exception v2

    .line 676
    .local v2, "iae":Ljava/lang/IllegalArgumentException;
    new-instance v3, Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    invoke-virtual {v2}, Ljava/lang/IllegalArgumentException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getLocation()Ljavax/xml/stream/Location;

    move-result-object v5

    invoke-direct {v3, v0, v4, v5, v2}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/stream/Location;Ljava/lang/IllegalArgumentException;)V

    throw v3
.end method

.method public getAttributeAsBoolean(I)Z
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 489
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getBooleanDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;

    move-result-object v0

    .line 490
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 491
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

    .line 537
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDecimalDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;

    move-result-object v0

    .line 538
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 539
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

    .line 521
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDoubleDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    move-result-object v0

    .line 522
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 523
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

    .line 593
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDoubleArrayDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;

    move-result-object v0

    .line 594
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeValue(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_getAttributeAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;Ljava/lang/String;)I

    .line 595
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

    .line 513
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getFloatDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    move-result-object v0

    .line 514
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 515
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

    .line 585
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getFloatArrayDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;

    move-result-object v0

    .line 586
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeValue(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_getAttributeAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;Ljava/lang/String;)I

    .line 587
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

    .line 497
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    move-result-object v0

    .line 498
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 499
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

    .line 569
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntArrayDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;

    move-result-object v0

    .line 570
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeValue(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_getAttributeAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;Ljava/lang/String;)I

    .line 571
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

    .line 529
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntegerDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;

    move-result-object v0

    .line 530
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 531
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

    .line 505
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getLongDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    move-result-object v0

    .line 506
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 507
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

    .line 577
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getLongArrayDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;

    move-result-object v0

    .line 578
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeValue(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_getAttributeAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;Ljava/lang/String;)I

    .line 579
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

    .line 545
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getNamespaceContext()Ljavax/xml/namespace/NamespaceContext;

    move-result-object v1

    invoke-virtual {v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getQNameDecoder(Ljavax/xml/namespace/NamespaceContext;)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;

    move-result-object v0

    .line 546
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;
    invoke-virtual {p0, p1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 547
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->getValue()Ljavax/xml/namespace/QName;

    move-result-object v1

    return-object v1
.end method

.method public getAttributeIndex(Ljava/lang/String;Ljava/lang/String;)I
    .locals 1
    .param p1, "namespaceURI"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 483
    invoke-virtual {p0, p1, p2}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->findAttributeIndex(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public getAttributeInfo()Lorg/codehaus/stax2/AttributeInfo;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 747
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getEventType()I

    move-result v0

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    .line 748
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getEventType()I

    move-result v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->throwNotStartElem(I)V

    .line 750
    :cond_0
    return-object p0
.end method

.method public getCurrentLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
    .locals 2

    .line 1015
    new-instance v0, Lorg/codehaus/stax2/ri/Stax2LocationAdapter;

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getLocation()Ljavax/xml/stream/Location;

    move-result-object v1

    invoke-direct {v0, v1}, Lorg/codehaus/stax2/ri/Stax2LocationAdapter;-><init>(Ljavax/xml/stream/Location;)V

    return-object v0
.end method

.method public getDTDInfo()Lorg/codehaus/stax2/DTDInfo;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 758
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getEventType()I

    move-result v0

    const/16 v1, 0xb

    if-eq v0, v1, :cond_0

    .line 759
    const/4 v0, 0x0

    return-object v0

    .line 761
    :cond_0
    return-object p0
.end method

.method public getDTDInternalSubset()Ljava/lang/String;
    .locals 2

    .line 956
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getEventType()I

    move-result v0

    const/16 v1, 0xb

    if-ne v0, v1, :cond_0

    .line 957
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getText()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 959
    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public getDTDPublicId()Ljava/lang/String;
    .locals 1

    .line 937
    const/4 v0, 0x0

    return-object v0
.end method

.method public getDTDRootName()Ljava/lang/String;
    .locals 1

    .line 932
    const/4 v0, 0x0

    return-object v0
.end method

.method public getDTDSystemId()Ljava/lang/String;
    .locals 1

    .line 942
    const/4 v0, 0x0

    return-object v0
.end method

.method public getDepth()I
    .locals 2

    .line 801
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getEventType()I

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    .line 802
    iget v0, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_depth:I

    add-int/lit8 v0, v0, 0x1

    return v0

    .line 804
    :cond_0
    iget v0, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_depth:I

    return v0
.end method

.method public getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V
    .locals 3
    .param p1, "tvd"    # Lorg/codehaus/stax2/typed/TypedValueDecoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 252
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getElementText()Ljava/lang/String;

    move-result-object v0

    .line 253
    .local v0, "value":Ljava/lang/String;
    invoke-static {v0}, Lorg/codehaus/stax2/ri/Stax2Util;->trimSpaces(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 255
    if-nez v0, :cond_0

    .line 256
    :try_start_0
    invoke-virtual {p1}, Lorg/codehaus/stax2/typed/TypedValueDecoder;->handleEmptyValue()V

    goto :goto_0

    .line 258
    :cond_0
    invoke-virtual {p1, v0}, Lorg/codehaus/stax2/typed/TypedValueDecoder;->decode(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 262
    :goto_0
    nop

    .line 263
    return-void

    .line 260
    :catch_0
    move-exception v1

    .line 261
    .local v1, "iae":Ljava/lang/IllegalArgumentException;
    invoke-virtual {p0, v1, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_constructTypeException(Ljava/lang/IllegalArgumentException;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;

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

    .line 225
    invoke-static {}, Lorg/codehaus/stax2/typed/Base64Variants;->getDefaultVariant()Lorg/codehaus/stax2/typed/Base64Variant;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getElementAsBinary(Lorg/codehaus/stax2/typed/Base64Variant;)[B

    move-result-object v0

    return-object v0
.end method

.method public getElementAsBinary(Lorg/codehaus/stax2/typed/Base64Variant;)[B
    .locals 6
    .param p1, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 232
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_base64Decoder()Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->getByteAggregator()Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;

    move-result-object v0

    .line 233
    .local v0, "aggr":Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->startAggregation()[B

    move-result-object v1

    .line 235
    .local v1, "buffer":[B
    :goto_0
    const/4 v2, 0x0

    .line 236
    .local v2, "offset":I
    array-length v3, v1

    .line 238
    .local v3, "len":I
    :cond_0
    invoke-virtual {p0, v1, v2, v3, p1}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->readElementAsBinary([BIILorg/codehaus/stax2/typed/Base64Variant;)I

    move-result v4

    .line 239
    .local v4, "readCount":I
    const/4 v5, 0x1

    if-ge v4, v5, :cond_1

    .line 240
    invoke-virtual {v0, v1, v2}, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->aggregateAll([BI)[B

    move-result-object v5

    return-object v5

    .line 242
    :cond_1
    add-int/2addr v2, v4

    .line 243
    sub-int/2addr v3, v4

    .line 244
    .end local v4    # "readCount":I
    if-gtz v3, :cond_0

    .line 245
    invoke-virtual {v0, v1}, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->addFullBlock([B)[B

    move-result-object v1

    .line 246
    .end local v2    # "offset":I
    .end local v3    # "len":I
    goto :goto_0
.end method

.method public getElementAsBoolean()Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 161
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getBooleanDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;

    move-result-object v0

    .line 162
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 163
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

    .line 209
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDecimalDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;

    move-result-object v0

    .line 210
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 211
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

    .line 193
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDoubleDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    move-result-object v0

    .line 194
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 195
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

    .line 185
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getFloatDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    move-result-object v0

    .line 186
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 187
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

    .line 169
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    move-result-object v0

    .line 170
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 171
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

    .line 201
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntegerDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;

    move-result-object v0

    .line 202
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 203
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

    .line 177
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getLongDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    move-result-object v0

    .line 178
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 179
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

    .line 217
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getNamespaceContext()Ljavax/xml/namespace/NamespaceContext;

    move-result-object v1

    invoke-virtual {v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getQNameDecoder(Ljavax/xml/namespace/NamespaceContext;)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;

    move-result-object v0

    .line 218
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 219
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->getValue()Ljavax/xml/namespace/QName;

    move-result-object v1

    return-object v1
.end method

.method public getElementText()Ljava/lang/String;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 144
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getEventType()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 145
    .local v0, "hadStart":Z
    :goto_0
    invoke-super {p0}, Ljavax/xml/stream/util/StreamReaderDelegate;->getElementText()Ljava/lang/String;

    move-result-object v2

    .line 146
    .local v2, "text":Ljava/lang/String;
    if-eqz v0, :cond_1

    .line 147
    iget v3, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_depth:I

    sub-int/2addr v3, v1

    iput v3, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_depth:I

    .line 149
    :cond_1
    return-object v2
.end method

.method public final getEndLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1026
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getCurrentLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v0

    return-object v0
.end method

.method public getEndingByteOffset()J
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 990
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

    .line 996
    const-wide/16 v0, -0x1

    return-wide v0
.end method

.method public getFeature(Ljava/lang/String;)Ljava/lang/Object;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 693
    const/4 v0, 0x0

    return-object v0
.end method

.method public getIdAttributeIndex()I
    .locals 4

    .line 900
    const/4 v0, 0x0

    .local v0, "i":I
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeCount()I

    move-result v1

    .local v1, "len":I
    :goto_0
    if-ge v0, v1, :cond_1

    .line 901
    const-string v2, "ID"

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeType(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 902
    return v0

    .line 900
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 905
    .end local v0    # "i":I
    .end local v1    # "len":I
    :cond_1
    const/4 v0, -0x1

    return v0
.end method

.method public final getLocationInfo()Lorg/codehaus/stax2/LocationInfo;
    .locals 0

    .line 771
    return-object p0
.end method

.method public getNonTransientNamespaceContext()Ljavax/xml/namespace/NamespaceContext;
    .locals 1

    .line 824
    const/4 v0, 0x0

    return-object v0
.end method

.method public getNotationAttributeIndex()I
    .locals 4

    .line 911
    const/4 v0, 0x0

    .local v0, "i":I
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeCount()I

    move-result v1

    .local v1, "len":I
    :goto_0
    if-ge v0, v1, :cond_1

    .line 912
    const-string v2, "NOTATION"

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getAttributeType(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 913
    return v0

    .line 911
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 916
    .end local v0    # "i":I
    .end local v1    # "len":I
    :cond_1
    const/4 v0, -0x1

    return v0
.end method

.method public getPrefixedName()Ljava/lang/String;
    .locals 5

    .line 830
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getEventType()I

    move-result v0

    sparse-switch v0, :sswitch_data_0

    .line 854
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Current state not START_ELEMENT, END_ELEMENT, ENTITY_REFERENCE, PROCESSING_INSTRUCTION or DTD"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 851
    :sswitch_0
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getDTDRootName()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 847
    :sswitch_1
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getLocalName()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 849
    :sswitch_2
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getPITarget()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 834
    :sswitch_3
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getPrefix()Ljava/lang/String;

    move-result-object v0

    .line 835
    .local v0, "prefix":Ljava/lang/String;
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getLocalName()Ljava/lang/String;

    move-result-object v1

    .line 837
    .local v1, "ln":Ljava/lang/String;
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_0

    goto :goto_0

    .line 840
    :cond_0
    new-instance v2, Ljava/lang/StringBuffer;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v3

    add-int/lit8 v3, v3, 0x1

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v4

    add-int/2addr v3, v4

    invoke-direct {v2, v3}, Ljava/lang/StringBuffer;-><init>(I)V

    .line 841
    .local v2, "sb":Ljava/lang/StringBuffer;
    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 842
    const/16 v3, 0x3a

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 843
    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 844
    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3

    .line 838
    .end local v2    # "sb":Ljava/lang/StringBuffer;
    :cond_1
    :goto_0
    return-object v1

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

    .line 927
    const/4 v0, 0x0

    return-object v0
.end method

.method public getProcessedDTDSchema()Lorg/codehaus/stax2/validation/DTDValidationSchema;
    .locals 1

    .line 966
    const/4 v0, 0x0

    return-object v0
.end method

.method public getStartLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
    .locals 1

    .line 1008
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getCurrentLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v0

    return-object v0
.end method

.method public getStartingByteOffset()J
    .locals 2

    .line 979
    const-wide/16 v0, -0x1

    return-wide v0
.end method

.method public getStartingCharOffset()J
    .locals 2

    .line 984
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

    .line 780
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getTextCharacters()[C

    move-result-object v0

    .line 781
    .local v0, "cbuf":[C
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getTextStart()I

    move-result v1

    .line 782
    .local v1, "start":I
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getTextLength()I

    move-result v2

    .line 784
    .local v2, "len":I
    if-lez v2, :cond_0

    .line 785
    invoke-virtual {p1, v0, v1, v2}, Ljava/io/Writer;->write([CII)V

    .line 787
    :cond_0
    return v2
.end method

.method public isEmptyElement()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 814
    const/4 v0, 0x0

    return v0
.end method

.method public isPropertySupported(Ljava/lang/String;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 711
    const/4 v0, 0x0

    return v0
.end method

.method public next()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 124
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_typedContent:Ljava/lang/String;

    const/4 v1, 0x2

    if-eqz v0, :cond_0

    .line 125
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_typedContent:Ljava/lang/String;

    .line 126
    return v1

    .line 129
    :cond_0
    invoke-super {p0}, Ljavax/xml/stream/util/StreamReaderDelegate;->next()I

    move-result v0

    .line 130
    .local v0, "type":I
    const/4 v2, 0x1

    if-ne v0, v2, :cond_1

    .line 131
    iget v1, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_depth:I

    add-int/2addr v1, v2

    iput v1, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_depth:I

    goto :goto_0

    .line 132
    :cond_1
    if-ne v0, v1, :cond_2

    .line 133
    iget v1, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_depth:I

    sub-int/2addr v1, v2

    iput v1, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_depth:I

    .line 135
    :cond_2
    :goto_0
    return v0
.end method

.method public readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I
    .locals 11
    .param p1, "tad"    # Lorg/codehaus/stax2/typed/TypedArrayDecoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 293
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_typedContent:Ljava/lang/String;

    const/4 v1, -0x1

    const/4 v2, 0x1

    if-nez v0, :cond_2

    .line 294
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getEventType()I

    move-result v0

    .line 295
    .local v0, "type":I
    const/4 v3, 0x2

    if-ne v0, v3, :cond_0

    .line 296
    return v1

    .line 298
    :cond_0
    if-ne v0, v2, :cond_1

    .line 301
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getElementText()Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_typedContent:Ljava/lang/String;

    goto :goto_0

    .line 299
    :cond_1
    new-instance v1, Ljava/lang/IllegalStateException;

    const-string v2, "First call to readElementAsArray() must be for a START_ELEMENT"

    invoke-direct {v1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 308
    .end local v0    # "type":I
    :cond_2
    :goto_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_typedContent:Ljava/lang/String;

    .line 309
    .local v0, "input":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    .line 310
    .local v3, "end":I
    const/4 v4, 0x0

    .line 311
    .local v4, "ptr":I
    const/4 v5, 0x0

    .line 312
    .local v5, "count":I
    const/4 v6, 0x0

    .line 316
    .local v6, "value":Ljava/lang/String;
    :goto_1
    const/4 v7, 0x0

    if-ge v4, v3, :cond_8

    .line 318
    :cond_3
    :try_start_0
    invoke-virtual {v0, v4}, Ljava/lang/String;->charAt(I)C

    move-result v8

    const/16 v9, 0x20

    if-gt v8, v9, :cond_4

    .line 319
    add-int/lit8 v4, v4, 0x1

    if-lt v4, v3, :cond_3

    .line 320
    goto :goto_5

    .line 324
    :cond_4
    move v8, v4

    .line 325
    .local v8, "start":I
    add-int/lit8 v4, v4, 0x1

    .line 326
    :goto_2
    if-ge v4, v3, :cond_5

    invoke-virtual {v0, v4}, Ljava/lang/String;->charAt(I)C

    move-result v10

    if-le v10, v9, :cond_5

    .line 327
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 329
    :cond_5
    add-int/lit8 v5, v5, 0x1

    .line 331
    invoke-virtual {v0, v8, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    move-object v6, v9

    .line 333
    add-int/lit8 v4, v4, 0x1

    .line 334
    invoke-virtual {p1, v6}, Lorg/codehaus/stax2/typed/TypedArrayDecoder;->decodeValue(Ljava/lang/String;)Z

    move-result v9
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v9, :cond_6

    .line 335
    goto :goto_5

    .line 337
    .end local v8    # "start":I
    :cond_6
    goto :goto_1

    .line 346
    :catchall_0
    move-exception v1

    goto :goto_3

    .line 338
    :catch_0
    move-exception v1

    .line 343
    .local v1, "iae":Ljava/lang/IllegalArgumentException;
    :try_start_1
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getLocation()Ljavax/xml/stream/Location;

    move-result-object v8

    .line 344
    .local v8, "loc":Ljavax/xml/stream/Location;
    new-instance v9, Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    invoke-virtual {v1}, Ljava/lang/IllegalArgumentException;->getMessage()Ljava/lang/String;

    move-result-object v10

    invoke-direct {v9, v6, v10, v8, v1}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/stream/Location;Ljava/lang/IllegalArgumentException;)V

    .end local v0    # "input":Ljava/lang/String;
    .end local v3    # "end":I
    .end local v4    # "ptr":I
    .end local v5    # "count":I
    .end local v6    # "value":Ljava/lang/String;
    .end local p1    # "tad":Lorg/codehaus/stax2/typed/TypedArrayDecoder;
    throw v9
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 346
    .end local v1    # "iae":Ljava/lang/IllegalArgumentException;
    .end local v8    # "loc":Ljavax/xml/stream/Location;
    .restart local v0    # "input":Ljava/lang/String;
    .restart local v3    # "end":I
    .restart local v4    # "ptr":I
    .restart local v5    # "count":I
    .restart local v6    # "value":Ljava/lang/String;
    .restart local p1    # "tad":Lorg/codehaus/stax2/typed/TypedArrayDecoder;
    :goto_3
    sub-int v8, v3, v4

    .line 348
    .local v8, "len":I
    if-ge v8, v2, :cond_7

    goto :goto_4

    :cond_7
    invoke-virtual {v0, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v7

    :goto_4
    iput-object v7, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_typedContent:Ljava/lang/String;

    .line 349
    .end local v8    # "len":I
    throw v1

    .line 346
    :cond_8
    :goto_5
    sub-int v8, v3, v4

    .line 348
    .restart local v8    # "len":I
    if-ge v8, v2, :cond_9

    goto :goto_6

    :cond_9
    invoke-virtual {v0, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v7

    :goto_6
    iput-object v7, p0, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_typedContent:Ljava/lang/String;

    .line 349
    .end local v8    # "len":I
    nop

    .line 350
    if-ge v5, v2, :cond_a

    goto :goto_7

    :cond_a
    move v1, v5

    :goto_7
    return v1
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

    .line 363
    invoke-static {}, Lorg/codehaus/stax2/typed/Base64Variants;->getDefaultVariant()Lorg/codehaus/stax2/typed/Base64Variant;

    move-result-object v0

    invoke-virtual {p0, p1, p2, p3, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->readElementAsBinary([BIILorg/codehaus/stax2/typed/Base64Variant;)I

    move-result v0

    return v0
.end method

.method public readElementAsBinary([BIILorg/codehaus/stax2/typed/Base64Variant;)I
    .locals 16
    .param p1, "resultBuffer"    # [B
    .param p2, "offset"    # I
    .param p3, "maxLength"    # I
    .param p4, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 371
    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move/from16 v0, p2

    move/from16 v3, p3

    move-object/from16 v4, p4

    const-string v5, ""

    if-eqz v2, :cond_12

    .line 374
    if-ltz v0, :cond_11

    .line 377
    const/4 v6, 0x0

    const/4 v7, 0x1

    if-lt v3, v7, :cond_f

    add-int v8, v0, v3

    array-length v9, v2

    if-le v8, v9, :cond_0

    goto/16 :goto_6

    .line 384
    :cond_0
    invoke-virtual/range {p0 .. p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_base64Decoder()Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;

    move-result-object v8

    .line 385
    .local v8, "dec":Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;
    invoke-virtual/range {p0 .. p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getEventType()I

    move-result v9

    .line 387
    .local v9, "type":I
    shl-int v10, v7, v9

    and-int/lit16 v10, v10, 0x1052

    const/4 v11, -0x1

    const/4 v12, 0x2

    if-nez v10, :cond_2

    .line 388
    if-ne v9, v12, :cond_1

    .line 390
    invoke-virtual {v8}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->hasData()Z

    move-result v10

    if-nez v10, :cond_2

    .line 391
    return v11

    .line 394
    :cond_1
    invoke-virtual {v1, v9}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->throwNotStartElemOrTextual(I)V

    .line 399
    :cond_2
    const/4 v10, 0x3

    const/4 v13, 0x5

    if-ne v9, v7, :cond_7

    .line 402
    :cond_3
    :goto_0
    invoke-virtual/range {p0 .. p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->next()I

    move-result v9

    .line 403
    if-ne v9, v12, :cond_4

    .line 405
    return v11

    .line 407
    :cond_4
    if-eq v9, v13, :cond_3

    if-ne v9, v10, :cond_5

    .line 408
    goto :goto_0

    .line 410
    :cond_5
    shl-int v14, v7, v9

    and-int/lit16 v14, v14, 0x1250

    if-nez v14, :cond_6

    .line 411
    invoke-virtual {v1, v9}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->throwNotStartElemOrTextual(I)V

    .line 413
    :cond_6
    invoke-virtual/range {p0 .. p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getText()Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v8, v4, v7, v14}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->init(Lorg/codehaus/stax2/typed/Base64Variant;ZLjava/lang/String;)V

    .line 414
    nop

    .line 418
    :cond_7
    const/4 v14, 0x0

    move v15, v14

    move v14, v9

    move v9, v3

    move v3, v0

    .line 425
    .end local p2    # "offset":I
    .end local p3    # "maxLength":I
    .local v3, "offset":I
    .local v9, "maxLength":I
    .local v14, "type":I
    .local v15, "totalCount":I
    :goto_1
    :try_start_0
    invoke-virtual {v8, v2, v3, v9}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->decode([BII)I

    move-result v0
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 428
    .local v0, "count":I
    nop

    .line 429
    add-int/2addr v3, v0

    .line 430
    add-int/2addr v15, v0

    .line 431
    sub-int/2addr v9, v0

    .line 436
    if-lt v9, v7, :cond_d

    invoke-virtual/range {p0 .. p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getEventType()I

    move-result v11

    if-ne v11, v12, :cond_8

    .line 437
    goto :goto_4

    .line 441
    :cond_8
    :goto_2
    invoke-virtual/range {p0 .. p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->next()I

    move-result v14

    .line 442
    if-eq v14, v13, :cond_8

    if-eq v14, v10, :cond_8

    const/4 v11, 0x6

    if-ne v14, v11, :cond_9

    .line 444
    goto :goto_2

    .line 446
    :cond_9
    if-ne v14, v12, :cond_b

    .line 453
    invoke-virtual {v8}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->endOfContent()I

    move-result v11

    .line 454
    .local v11, "left":I
    if-ltz v11, :cond_a

    .line 456
    if-lez v11, :cond_d

    .line 457
    goto :goto_3

    .line 455
    :cond_a
    const-string v6, "Incomplete base64 triplet at the end of decoded content"

    invoke-virtual {v1, v6, v5}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_constructTypeException(Ljava/lang/String;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    move-result-object v5

    throw v5

    .line 462
    .end local v11    # "left":I
    :cond_b
    shl-int v11, v7, v14

    and-int/lit16 v11, v11, 0x1250

    if-nez v11, :cond_c

    .line 463
    invoke-virtual {v1, v14}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->throwNotStartElemOrTextual(I)V

    .line 465
    :cond_c
    invoke-virtual/range {p0 .. p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getText()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v8, v4, v6, v11}, Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;->init(Lorg/codehaus/stax2/typed/Base64Variant;ZLjava/lang/String;)V

    .line 466
    nop

    .line 468
    .end local v0    # "count":I
    nop

    .line 425
    :goto_3
    const/4 v11, -0x1

    goto :goto_1

    .line 471
    :cond_d
    :goto_4
    if-lez v15, :cond_e

    move v11, v15

    goto :goto_5

    :cond_e
    const/4 v11, -0x1

    :goto_5
    return v11

    .line 426
    :catch_0
    move-exception v0

    move-object v6, v0

    move-object v0, v6

    .line 427
    .local v0, "iae":Ljava/lang/IllegalArgumentException;
    invoke-virtual {v1, v0, v5}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_constructTypeException(Ljava/lang/IllegalArgumentException;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    move-result-object v5

    throw v5

    .line 378
    .end local v0    # "iae":Ljava/lang/IllegalArgumentException;
    .end local v3    # "offset":I
    .end local v8    # "dec":Lorg/codehaus/stax2/ri/typed/StringBase64Decoder;
    .end local v9    # "maxLength":I
    .end local v14    # "type":I
    .end local v15    # "totalCount":I
    .restart local p2    # "offset":I
    .restart local p3    # "maxLength":I
    :cond_f
    :goto_6
    if-nez v3, :cond_10

    .line 379
    return v6

    .line 381
    :cond_10
    new-instance v5, Ljava/lang/IllegalArgumentException;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Illegal maxLength ("

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "), has to be positive number, and offset+maxLength can not exceed"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    array-length v7, v2

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 375
    :cond_11
    new-instance v5, Ljava/lang/IllegalArgumentException;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Illegal offset ("

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "), must be [0, "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    array-length v7, v2

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 372
    :cond_12
    new-instance v5, Ljava/lang/IllegalArgumentException;

    const-string v6, "resultBuffer is null"

    invoke-direct {v5, v6}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v5
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

    .line 286
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDoubleArrayDecoder([DII)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I

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

    .line 280
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getFloatArrayDecoder([FII)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I

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

    .line 268
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntArrayDecoder([III)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I

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

    .line 274
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getLongArrayDecoder([JII)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I

    move-result v0

    return v0
.end method

.method public setFeature(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 0
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 701
    return-void
.end method

.method public setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 717
    const/4 v0, 0x0

    return v0
.end method

.method public setValidationProblemHandler(Lorg/codehaus/stax2/validation/ValidationProblemHandler;)Lorg/codehaus/stax2/validation/ValidationProblemHandler;
    .locals 1
    .param p1, "h"    # Lorg/codehaus/stax2/validation/ValidationProblemHandler;

    .line 1062
    const/4 v0, 0x0

    return-object v0
.end method

.method public skipElement()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 725
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getEventType()I

    move-result v0

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    .line 726
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->getEventType()I

    move-result v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->throwNotStartElem(I)V

    .line 728
    :cond_0
    const/4 v0, 0x1

    .line 731
    .local v0, "nesting":I
    :goto_0
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->next()I

    move-result v2

    .line 732
    .local v2, "type":I
    if-ne v2, v1, :cond_1

    .line 733
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 734
    :cond_1
    const/4 v3, 0x2

    if-ne v2, v3, :cond_2

    .line 735
    add-int/lit8 v0, v0, -0x1

    if-nez v0, :cond_2

    .line 736
    nop

    .line 740
    .end local v2    # "type":I
    return-void

    .line 739
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

    .line 1047
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->throwUnsupported()V

    .line 1048
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

    .line 1055
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->throwUnsupported()V

    .line 1056
    const/4 v0, 0x0

    return-object v0
.end method

.method protected throwNotStartElem(I)V
    .locals 3
    .param p1, "type"    # I

    .line 1095
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Current event ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p1}, Lorg/codehaus/stax2/ri/Stax2Util;->eventTypeDesc(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") not START_ELEMENT"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected throwNotStartElemOrTextual(I)V
    .locals 3
    .param p1, "type"    # I

    .line 1100
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Current event ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p1}, Lorg/codehaus/stax2/ri/Stax2Util;->eventTypeDesc(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") not START_ELEMENT, END_ELEMENT, CHARACTERS or CDATA"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

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

    .line 1090
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

    .line 1039
    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/Stax2ReaderAdapter;->throwUnsupported()V

    .line 1040
    const/4 v0, 0x0

    return-object v0
.end method
