.class public Lcom/fasterxml/aalto/stax/StreamReaderImpl;
.super Ljava/lang/Object;
.source "StreamReaderImpl.java"

# interfaces
.implements Lorg/codehaus/stax2/XMLStreamReader2;
.implements Lorg/codehaus/stax2/AttributeInfo;
.implements Lorg/codehaus/stax2/DTDInfo;
.implements Lorg/codehaus/stax2/LocationInfo;


# static fields
.field private static final MASK_GET_ELEMENT_TEXT:I = 0x1250

.field private static final MASK_GET_TEXT:I = 0x1a70

.field private static final MASK_GET_TEXT_WITH_WRITER:I = 0x1a78

.field private static final MASK_GET_TEXT_XXX:I = 0x1070

.field private static final MASK_TYPED_ACCESS_ARRAY:I = 0x1056

.field private static final MASK_TYPED_ACCESS_BINARY:I = 0x1052

.field static final STATE_CLOSED:I = 0x3

.field static final STATE_EPILOG:I = 0x2

.field static final STATE_PROLOG:I = 0x0

.field static final STATE_TREE:I = 0x1


# instance fields
.field protected _attrCount:I

.field protected _base64Decoder:Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;

.field protected final _cfgCoalesceText:Z

.field protected final _cfgReportTextAsChars:Z

.field protected _currName:Lcom/fasterxml/aalto/in/PName;

.field protected _currToken:I

.field protected _decoderFactory:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

.field protected _dtdRootName:Lcom/fasterxml/aalto/in/PName;

.field protected _parseState:I

.field protected final _scanner:Lcom/fasterxml/aalto/in/XmlScanner;


# direct methods
.method public constructor <init>(Lcom/fasterxml/aalto/in/XmlScanner;)V
    .locals 2
    .param p1, "scanner"    # Lcom/fasterxml/aalto/in/XmlScanner;

    .line 154
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 125
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_base64Decoder:Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;

    .line 155
    iput-object p1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    .line 156
    const/4 v0, 0x7

    iput v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    .line 157
    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/XmlScanner;->getConfig()Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    .line 158
    .local v0, "cfg":Lcom/fasterxml/aalto/in/ReaderConfig;
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->willCoalesceText()Z

    move-result v1

    iput-boolean v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_cfgCoalesceText:Z

    .line 159
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->willReportCData()Z

    move-result v1

    xor-int/lit8 v1, v1, 0x1

    iput-boolean v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_cfgReportTextAsChars:Z

    .line 160
    return-void
.end method

.method private _constructTypeException(Ljava/lang/IllegalArgumentException;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;
    .locals 3
    .param p1, "iae"    # Ljava/lang/IllegalArgumentException;
    .param p2, "lexicalValue"    # Ljava/lang/String;

    .line 1817
    new-instance v0, Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    invoke-virtual {p1}, Ljava/lang/IllegalArgumentException;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getStartLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v2

    invoke-direct {v0, p2, v1, v2, p1}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/stream/Location;Ljava/lang/IllegalArgumentException;)V

    return-object v0
.end method

.method private _constructTypeException(Ljava/lang/String;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;
    .locals 2
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "lexicalValue"    # Ljava/lang/String;

    .line 1822
    new-instance v0, Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getStartLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v1

    invoke-direct {v0, p2, p1, v1}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/stream/Location;)V

    return-object v0
.end method

.method private _handleEmptyValue(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V
    .locals 2
    .param p1, "dec"    # Lorg/codehaus/stax2/typed/TypedValueDecoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1889
    :try_start_0
    invoke-virtual {p1}, Lorg/codehaus/stax2/typed/TypedValueDecoder;->handleEmptyValue()V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1892
    nop

    .line 1893
    return-void

    .line 1890
    :catch_0
    move-exception v0

    .line 1891
    .local v0, "iae":Ljava/lang/IllegalArgumentException;
    const-string v1, ""

    invoke-direct {p0, v0, v1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_constructTypeException(Ljava/lang/IllegalArgumentException;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    move-result-object v1

    throw v1
.end method

.method public static construct(Lcom/fasterxml/aalto/in/InputBootstrapper;)Lcom/fasterxml/aalto/stax/StreamReaderImpl;
    .locals 2
    .param p0, "bs"    # Lcom/fasterxml/aalto/in/InputBootstrapper;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 165
    new-instance v0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;

    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/InputBootstrapper;->bootstrap()Lcom/fasterxml/aalto/in/XmlScanner;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;-><init>(Lcom/fasterxml/aalto/in/XmlScanner;)V

    return-object v0
.end method

.method private throwNotTextXxx(I)V
    .locals 3
    .param p1, "type"    # I

    .line 1786
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getTextXxx() methods can not be called on "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    .line 1787
    invoke-static {v2}, Lcom/fasterxml/aalto/impl/ErrorConsts;->tokenTypeDesc(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private throwNotTextual(I)V
    .locals 3
    .param p1, "type"    # I

    .line 1781
    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Not a textual event ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    .line 1782
    invoke-static {v2}, Lcom/fasterxml/aalto/impl/ErrorConsts;->tokenTypeDesc(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method protected _base64Decoder()Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;
    .locals 1

    .line 1873
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_base64Decoder:Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;

    if-nez v0, :cond_0

    .line 1874
    new-instance v0, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;-><init>()V

    iput-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_base64Decoder:Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;

    .line 1876
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_base64Decoder:Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;

    return-object v0
.end method

.method protected _closeScanner(Z)V
    .locals 2
    .param p1, "forceStreamClose"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1848
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_parseState:I

    const/4 v1, 0x3

    if-eq v0, v1, :cond_0

    .line 1849
    iput v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_parseState:I

    .line 1850
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/16 v1, 0x8

    if-eq v0, v1, :cond_0

    .line 1851
    iput v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    .line 1854
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;->close(Z)V

    .line 1855
    return-void
.end method

.method protected _constructUnexpectedInTyped(I)Ljavax/xml/stream/XMLStreamException;
    .locals 3
    .param p1, "nextToken"    # I

    .line 1801
    const/4 v0, 0x1

    const/4 v1, 0x0

    if-ne p1, v0, :cond_0

    .line 1802
    const-string v0, "Element content can not contain child START_ELEMENT when using Typed Access methods"

    invoke-direct {p0, v0, v1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_constructTypeException(Ljava/lang/String;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    move-result-object v0

    return-object v0

    .line 1804
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Expected a text token, got "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Lcom/fasterxml/aalto/impl/ErrorConsts;->tokenTypeDesc(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_constructTypeException(Ljava/lang/String;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    move-result-object v0

    return-object v0
.end method

.method protected final _decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;
    .locals 1

    .line 1865
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    if-nez v0, :cond_0

    .line 1866
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;-><init>()V

    iput-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    .line 1868
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    return-object v0
.end method

.method protected _reportNonTextEvent(I)V
    .locals 2
    .param p1, "type"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1739
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Expected a text token, got "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Lcom/fasterxml/aalto/impl/ErrorConsts;->tokenTypeDesc(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->throwWfe(Ljava/lang/String;)V

    .line 1740
    return-void
.end method

.method public final close()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 852
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_closeScanner(Z)V

    .line 853
    return-void
.end method

.method public final closeCompletely()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1553
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_closeScanner(Z)V

    .line 1554
    return-void
.end method

.method public final findAttributeIndex(Ljava/lang/String;Ljava/lang/String;)I
    .locals 1
    .param p1, "nsURI"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 1674
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/in/XmlScanner;->findAttrIndex(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method public final getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V
    .locals 2
    .param p1, "index"    # I
    .param p2, "tvd"    # Lorg/codehaus/stax2/typed/TypedValueDecoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1273
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 1277
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/in/XmlScanner;->decodeAttrValue(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1280
    nop

    .line 1281
    return-void

    .line 1278
    :catch_0
    move-exception v0

    .line 1279
    .local v0, "iae":Ljava/lang/IllegalArgumentException;
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getAttributeValue(I)Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v0, v1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_constructTypeException(Ljava/lang/IllegalArgumentException;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    move-result-object v1

    throw v1

    .line 1274
    .end local v0    # "iae":Ljava/lang/IllegalArgumentException;
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_STELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final getAttributeAsArray(ILorg/codehaus/stax2/typed/TypedArrayDecoder;)I
    .locals 2
    .param p1, "index"    # I
    .param p2, "tad"    # Lorg/codehaus/stax2/typed/TypedArrayDecoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1324
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 1327
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/in/XmlScanner;->decodeAttrValues(ILorg/codehaus/stax2/typed/TypedArrayDecoder;)I

    move-result v0

    return v0

    .line 1325
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_STELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final getAttributeAsBinary(I)[B
    .locals 1
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1333
    invoke-static {}, Lorg/codehaus/stax2/typed/Base64Variants;->getDefaultVariant()Lorg/codehaus/stax2/typed/Base64Variant;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getAttributeAsBinary(ILorg/codehaus/stax2/typed/Base64Variant;)[B

    move-result-object v0

    return-object v0
.end method

.method public final getAttributeAsBinary(ILorg/codehaus/stax2/typed/Base64Variant;)[B
    .locals 2
    .param p1, "index"    # I
    .param p2, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1339
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 1342
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_base64Decoder()Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;

    move-result-object v1

    invoke-virtual {v0, p1, p2, v1}, Lcom/fasterxml/aalto/in/XmlScanner;->decodeAttrBinaryValue(ILorg/codehaus/stax2/typed/Base64Variant;Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;)[B

    move-result-object v0

    return-object v0

    .line 1340
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_STELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final getAttributeAsBoolean(I)Z
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1208
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getBooleanDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;

    move-result-object v0

    .line 1209
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;
    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1210
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;->getValue()Z

    move-result v1

    return v1
.end method

.method public final getAttributeAsDecimal(I)Ljava/math/BigDecimal;
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1256
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDecimalDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;

    move-result-object v0

    .line 1257
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;
    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1258
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;->getValue()Ljava/math/BigDecimal;

    move-result-object v1

    return-object v1
.end method

.method public final getAttributeAsDouble(I)D
    .locals 3
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1240
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDoubleDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    move-result-object v0

    .line 1241
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;
    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1242
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;->getValue()D

    move-result-wide v1

    return-wide v1
.end method

.method public final getAttributeAsDoubleArray(I)[D
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1310
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDoubleArrayDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;

    move-result-object v0

    .line 1311
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;
    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getAttributeAsArray(ILorg/codehaus/stax2/typed/TypedArrayDecoder;)I

    .line 1312
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->getValues()[D

    move-result-object v1

    return-object v1
.end method

.method public final getAttributeAsFloat(I)F
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1232
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getFloatDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    move-result-object v0

    .line 1233
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;
    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1234
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;->getValue()F

    move-result v1

    return v1
.end method

.method public final getAttributeAsFloatArray(I)[F
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1302
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getFloatArrayDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;

    move-result-object v0

    .line 1303
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;
    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getAttributeAsArray(ILorg/codehaus/stax2/typed/TypedArrayDecoder;)I

    .line 1304
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->getValues()[F

    move-result-object v1

    return-object v1
.end method

.method public final getAttributeAsInt(I)I
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1216
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    move-result-object v0

    .line 1217
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;
    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1218
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->getValue()I

    move-result v1

    return v1
.end method

.method public final getAttributeAsIntArray(I)[I
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1286
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntArrayDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;

    move-result-object v0

    .line 1287
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;
    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getAttributeAsArray(ILorg/codehaus/stax2/typed/TypedArrayDecoder;)I

    .line 1288
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->getValues()[I

    move-result-object v1

    return-object v1
.end method

.method public final getAttributeAsInteger(I)Ljava/math/BigInteger;
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1248
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntegerDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;

    move-result-object v0

    .line 1249
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;
    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1250
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;->getValue()Ljava/math/BigInteger;

    move-result-object v1

    return-object v1
.end method

.method public final getAttributeAsLong(I)J
    .locals 3
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1224
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getLongDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    move-result-object v0

    .line 1225
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;
    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1226
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->getValue()J

    move-result-wide v1

    return-wide v1
.end method

.method public final getAttributeAsLongArray(I)[J
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1294
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getLongArrayDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;

    move-result-object v0

    .line 1295
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;
    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getAttributeAsArray(ILorg/codehaus/stax2/typed/TypedArrayDecoder;)I

    .line 1296
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->getValues()[J

    move-result-object v1

    return-object v1
.end method

.method public final getAttributeAsQName(I)Ljavax/xml/namespace/QName;
    .locals 2
    .param p1, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1264
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getNamespaceContext()Ljavax/xml/namespace/NamespaceContext;

    move-result-object v1

    invoke-virtual {v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getQNameDecoder(Ljavax/xml/namespace/NamespaceContext;)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;

    move-result-object v0

    .line 1265
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;
    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getAttributeAs(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 1266
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->getValue()Ljavax/xml/namespace/QName;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->verifyQName(Ljavax/xml/namespace/QName;)Ljavax/xml/namespace/QName;

    move-result-object v1

    return-object v1
.end method

.method public final getAttributeCount()I
    .locals 2

    .line 302
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 305
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_attrCount:I

    return v0

    .line 303
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_STELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final getAttributeIndex(Ljava/lang/String;Ljava/lang/String;)I
    .locals 2
    .param p1, "namespaceURI"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 1198
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 1202
    invoke-virtual {p0, p1, p2}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->findAttributeIndex(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0

    .line 1199
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_STELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final getAttributeInfo()Lorg/codehaus/stax2/AttributeInfo;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1431
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 1434
    return-object p0

    .line 1432
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_STELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final getAttributeLocalName(I)Ljava/lang/String;
    .locals 2
    .param p1, "index"    # I

    .line 311
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_2

    .line 314
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_attrCount:I

    if-ge p1, v0, :cond_0

    if-gez p1, :cond_1

    .line 315
    :cond_0
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->reportInvalidAttrIndex(I)V

    .line 317
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;->getAttrLocalName(I)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 312
    :cond_2
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_STELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final getAttributeName(I)Ljavax/xml/namespace/QName;
    .locals 2
    .param p1, "index"    # I

    .line 323
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_2

    .line 326
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_attrCount:I

    if-ge p1, v0, :cond_0

    if-gez p1, :cond_1

    .line 327
    :cond_0
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->reportInvalidAttrIndex(I)V

    .line 329
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;->getAttrQName(I)Ljavax/xml/namespace/QName;

    move-result-object v0

    return-object v0

    .line 324
    :cond_2
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_STELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final getAttributeNamespace(I)Ljava/lang/String;
    .locals 2
    .param p1, "index"    # I

    .line 335
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_3

    .line 338
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_attrCount:I

    if-ge p1, v0, :cond_0

    if-gez p1, :cond_1

    .line 339
    :cond_0
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->reportInvalidAttrIndex(I)V

    .line 341
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;->getAttrNsURI(I)Ljava/lang/String;

    move-result-object v0

    .line 342
    .local v0, "p":Ljava/lang/String;
    if-nez v0, :cond_2

    const-string v1, ""

    goto :goto_0

    :cond_2
    move-object v1, v0

    :goto_0
    return-object v1

    .line 336
    .end local v0    # "p":Ljava/lang/String;
    :cond_3
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_STELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final getAttributePrefix(I)Ljava/lang/String;
    .locals 2
    .param p1, "index"    # I

    .line 348
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_3

    .line 351
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_attrCount:I

    if-ge p1, v0, :cond_0

    if-gez p1, :cond_1

    .line 352
    :cond_0
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->reportInvalidAttrIndex(I)V

    .line 354
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;->getAttrPrefix(I)Ljava/lang/String;

    move-result-object v0

    .line 355
    .local v0, "p":Ljava/lang/String;
    if-nez v0, :cond_2

    const-string v1, ""

    goto :goto_0

    :cond_2
    move-object v1, v0

    :goto_0
    return-object v1

    .line 349
    .end local v0    # "p":Ljava/lang/String;
    :cond_3
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_STELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final getAttributeType(I)Ljava/lang/String;
    .locals 2
    .param p1, "index"    # I

    .line 361
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_2

    .line 364
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_attrCount:I

    if-ge p1, v0, :cond_0

    if-gez p1, :cond_1

    .line 365
    :cond_0
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->reportInvalidAttrIndex(I)V

    .line 367
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;->getAttrType(I)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 362
    :cond_2
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_STELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final getAttributeValue(I)Ljava/lang/String;
    .locals 2
    .param p1, "index"    # I

    .line 373
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_2

    .line 376
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_attrCount:I

    if-ge p1, v0, :cond_0

    if-gez p1, :cond_1

    .line 377
    :cond_0
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->reportInvalidAttrIndex(I)V

    .line 379
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;->getAttrValue(I)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 374
    :cond_2
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_STELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "nsURI"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 385
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 388
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/in/XmlScanner;->getAttrValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 386
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_STELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final getCharacterEncodingScheme()Ljava/lang/String;
    .locals 1

    .line 237
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getConfig()Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getXmlDeclEncoding()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getConfig()Lcom/fasterxml/aalto/in/ReaderConfig;
    .locals 1

    .line 288
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getConfig()Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    return-object v0
.end method

.method public final getCurrentLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
    .locals 1

    .line 1661
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getCurrentLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v0

    return-object v0
.end method

.method public final getDTDInfo()Lorg/codehaus/stax2/DTDInfo;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1449
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/16 v1, 0xb

    if-eq v0, v1, :cond_0

    .line 1450
    const/4 v0, 0x0

    return-object v0

    .line 1452
    :cond_0
    return-object p0
.end method

.method public final getDTDInternalSubset()Ljava/lang/String;
    .locals 2

    .line 1598
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/16 v1, 0xb

    if-eq v0, v1, :cond_0

    .line 1599
    const/4 v0, 0x0

    return-object v0

    .line 1602
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getText()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljavax/xml/stream/XMLStreamException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 1603
    :catch_0
    move-exception v0

    .line 1604
    .local v0, "sex":Ljavax/xml/stream/XMLStreamException;
    invoke-static {v0}, Lcom/fasterxml/aalto/UncheckedStreamException;->createFrom(Ljavax/xml/stream/XMLStreamException;)Lcom/fasterxml/aalto/UncheckedStreamException;

    move-result-object v1

    throw v1
.end method

.method public final getDTDPublicId()Ljava/lang/String;
    .locals 1

    .line 1583
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getDTDPublicId()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final getDTDRootName()Ljava/lang/String;
    .locals 3

    .line 1574
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/16 v1, 0xb

    const/4 v2, 0x0

    if-eq v0, v1, :cond_0

    .line 1575
    return-object v2

    .line 1577
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currName:Lcom/fasterxml/aalto/in/PName;

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v2

    :goto_0
    return-object v2
.end method

.method public final getDTDSystemId()Ljava/lang/String;
    .locals 1

    .line 1588
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getDTDSystemId()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final getDepth()I
    .locals 3

    .line 1511
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getDepth()I

    move-result v0

    .line 1512
    .local v0, "d":I
    iget v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v2, 0x2

    if-ne v1, v2, :cond_0

    .line 1513
    add-int/lit8 v0, v0, 0x1

    .line 1515
    :cond_0
    return v0
.end method

.method public final getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V
    .locals 3
    .param p1, "tvd"    # Lorg/codehaus/stax2/typed/TypedValueDecoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 940
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getElementText()Ljava/lang/String;

    move-result-object v0

    .line 941
    .local v0, "value":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 942
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_0

    .line 943
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_handleEmptyValue(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 944
    return-void

    .line 947
    :cond_0
    :try_start_0
    invoke-virtual {p1, v0}, Lorg/codehaus/stax2/typed/TypedValueDecoder;->decode(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 950
    nop

    .line 951
    return-void

    .line 948
    :catch_0
    move-exception v1

    .line 949
    .local v1, "iae":Ljava/lang/IllegalArgumentException;
    invoke-direct {p0, v1, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_constructTypeException(Ljava/lang/IllegalArgumentException;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    move-result-object v2

    throw v2
.end method

.method public final getElementAsBinary()[B
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 933
    invoke-static {}, Lorg/codehaus/stax2/typed/Base64Variants;->getDefaultVariant()Lorg/codehaus/stax2/typed/Base64Variant;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getElementAsBinary(Lorg/codehaus/stax2/typed/Base64Variant;)[B

    move-result-object v0

    return-object v0
.end method

.method public final getElementAsBinary(Lorg/codehaus/stax2/typed/Base64Variant;)[B
    .locals 6
    .param p1, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 957
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_base64Decoder()Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->getByteAggregator()Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;

    move-result-object v0

    .line 958
    .local v0, "aggr":Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->startAggregation()[B

    move-result-object v1

    .line 960
    .local v1, "buffer":[B
    :goto_0
    const/4 v2, 0x0

    .line 961
    .local v2, "offset":I
    array-length v3, v1

    .line 964
    .local v3, "len":I
    :cond_0
    invoke-virtual {p0, v1, v2, v3, p1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->readElementAsBinary([BIILorg/codehaus/stax2/typed/Base64Variant;)I

    move-result v4

    .line 965
    .local v4, "readCount":I
    const/4 v5, 0x1

    if-ge v4, v5, :cond_1

    .line 966
    invoke-virtual {v0, v1, v2}, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->aggregateAll([BI)[B

    move-result-object v5

    return-object v5

    .line 968
    :cond_1
    add-int/2addr v2, v4

    .line 969
    sub-int/2addr v3, v4

    .line 970
    .end local v4    # "readCount":I
    if-gtz v3, :cond_0

    .line 971
    invoke-virtual {v0, v1}, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->addFullBlock([B)[B

    move-result-object v1

    .line 972
    .end local v2    # "offset":I
    .end local v3    # "len":I
    goto :goto_0
.end method

.method public final getElementAsBoolean()Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 869
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getBooleanDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;

    move-result-object v0

    .line 870
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 871
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;->getValue()Z

    move-result v1

    return v1
.end method

.method public final getElementAsDecimal()Ljava/math/BigDecimal;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 917
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDecimalDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;

    move-result-object v0

    .line 918
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 919
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;->getValue()Ljava/math/BigDecimal;

    move-result-object v1

    return-object v1
.end method

.method public final getElementAsDouble()D
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 901
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDoubleDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    move-result-object v0

    .line 902
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 903
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;->getValue()D

    move-result-wide v1

    return-wide v1
.end method

.method public final getElementAsFloat()F
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 893
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getFloatDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    move-result-object v0

    .line 894
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 895
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;->getValue()F

    move-result v1

    return v1
.end method

.method public final getElementAsInt()I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 877
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    move-result-object v0

    .line 878
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 879
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->getValue()I

    move-result v1

    return v1
.end method

.method public final getElementAsInteger()Ljava/math/BigInteger;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 909
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntegerDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;

    move-result-object v0

    .line 910
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 911
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;->getValue()Ljava/math/BigInteger;

    move-result-object v1

    return-object v1
.end method

.method public final getElementAsLong()J
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 885
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getLongDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    move-result-object v0

    .line 886
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 887
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->getValue()J

    move-result-wide v1

    return-wide v1
.end method

.method public final getElementAsQName()Ljavax/xml/namespace/QName;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 925
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getNamespaceContext()Ljavax/xml/namespace/NamespaceContext;

    move-result-object v1

    invoke-virtual {v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getQNameDecoder(Ljavax/xml/namespace/NamespaceContext;)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;

    move-result-object v0

    .line 926
    .local v0, "dec":Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getElementAs(Lorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 927
    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;->getValue()Ljavax/xml/namespace/QName;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->verifyQName(Ljavax/xml/namespace/QName;)Ljavax/xml/namespace/QName;

    move-result-object v1

    return-object v1
.end method

.method public final getElementText()Ljava/lang/String;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 405
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    .line 406
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_STELEM:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->throwWfe(Ljava/lang/String;)V

    .line 410
    :cond_0
    :goto_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->next()I

    move-result v0

    .line 411
    .local v0, "type":I
    const/4 v2, 0x2

    if-ne v0, v2, :cond_1

    .line 412
    const-string v1, ""

    return-object v1

    .line 414
    :cond_1
    const/4 v3, 0x5

    if-eq v0, v3, :cond_0

    const/4 v4, 0x3

    if-ne v0, v4, :cond_2

    .line 415
    goto :goto_0

    .line 417
    :cond_2
    shl-int v5, v1, v0

    and-int/lit16 v5, v5, 0x1250

    if-nez v5, :cond_3

    .line 418
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_reportNonTextEvent(I)V

    .line 422
    .end local v0    # "type":I
    :cond_3
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getText()Ljava/lang/String;

    move-result-object v0

    .line 424
    .local v0, "text":Ljava/lang/String;
    const/4 v5, 0x0

    .line 427
    .local v5, "acc":Lcom/fasterxml/aalto/util/TextAccumulator;
    :cond_4
    :goto_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->next()I

    move-result v6

    move v7, v6

    .local v7, "type":I
    if-eq v6, v2, :cond_7

    .line 428
    shl-int v6, v1, v7

    and-int/lit16 v6, v6, 0x1250

    if-eqz v6, :cond_6

    .line 429
    if-nez v5, :cond_5

    .line 430
    new-instance v6, Lcom/fasterxml/aalto/util/TextAccumulator;

    invoke-direct {v6}, Lcom/fasterxml/aalto/util/TextAccumulator;-><init>()V

    move-object v5, v6

    .line 431
    invoke-virtual {v5, v0}, Lcom/fasterxml/aalto/util/TextAccumulator;->addText(Ljava/lang/String;)V

    .line 433
    :cond_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getText()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/fasterxml/aalto/util/TextAccumulator;->addText(Ljava/lang/String;)V

    .line 434
    goto :goto_1

    .line 436
    :cond_6
    if-eq v7, v3, :cond_4

    if-eq v7, v4, :cond_4

    .line 437
    invoke-virtual {p0, v7}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_reportNonTextEvent(I)V

    goto :goto_1

    .line 440
    :cond_7
    if-nez v5, :cond_8

    move-object v1, v0

    goto :goto_2

    :cond_8
    invoke-virtual {v5}, Lcom/fasterxml/aalto/util/TextAccumulator;->getAndClear()Ljava/lang/String;

    move-result-object v1

    :goto_2
    return-object v1
.end method

.method public final getEncoding()Ljava/lang/String;
    .locals 1

    .line 248
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getConfig()Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getActualEncoding()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final getEndLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1656
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getEndLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v0

    return-object v0
.end method

.method public final getEndingByteOffset()J
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1639
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getEndingByteOffset()J

    move-result-wide v0

    return-wide v0
.end method

.method public final getEndingCharOffset()J
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1644
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getEndingCharOffset()J

    move-result-wide v0

    return-wide v0
.end method

.method public final getEventType()I
    .locals 2

    .line 453
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/16 v1, 0xc

    if-ne v0, v1, :cond_1

    .line 454
    iget-boolean v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_cfgCoalesceText:Z

    if-nez v0, :cond_0

    iget-boolean v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_cfgReportTextAsChars:Z

    if-eqz v0, :cond_1

    .line 455
    :cond_0
    const/4 v0, 0x4

    return v0

    .line 458
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    return v0
.end method

.method public final getFeature(Ljava/lang/String;)Ljava/lang/Object;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 1371
    const/4 v0, 0x0

    return-object v0
.end method

.method public final getIdAttributeIndex()I
    .locals 1

    .line 1680
    const/4 v0, -0x1

    return v0
.end method

.method protected getLastCharLocation()Ljavax/xml/stream/Location;
    .locals 1

    .line 1745
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getCurrentLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v0

    return-object v0
.end method

.method public final getLocalName()Ljava/lang/String;
    .locals 2

    .line 465
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x2

    if-eq v0, v1, :cond_1

    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/16 v1, 0x9

    if-ne v0, v1, :cond_0

    goto :goto_0

    .line 469
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Current state not START_ELEMENT, END_ELEMENT or ENTITY_REFERENCE"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 467
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getLocalName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final getLocation()Ljavax/xml/stream/Location;
    .locals 1

    .line 857
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getStartLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v0

    return-object v0
.end method

.method public final getLocationInfo()Lorg/codehaus/stax2/LocationInfo;
    .locals 0

    .line 1462
    return-object p0
.end method

.method public final getName()Ljavax/xml/namespace/QName;
    .locals 2

    .line 477
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    goto :goto_0

    .line 478
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_ELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 480
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getQName()Ljavax/xml/namespace/QName;

    move-result-object v0

    return-object v0
.end method

.method public final getNamespaceContext()Ljavax/xml/namespace/NamespaceContext;
    .locals 1

    .line 494
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    return-object v0
.end method

.method public final getNamespaceCount()I
    .locals 2

    .line 499
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    goto :goto_0

    .line 500
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_ELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 502
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getNsCount()I

    move-result v0

    return v0
.end method

.method public final getNamespacePrefix(I)Ljava/lang/String;
    .locals 2
    .param p1, "index"    # I

    .line 507
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    goto :goto_0

    .line 508
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_ELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 510
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;->getNamespacePrefix(I)Ljava/lang/String;

    move-result-object v0

    .line 511
    .local v0, "p":Ljava/lang/String;
    if-nez v0, :cond_2

    const-string v1, ""

    goto :goto_1

    :cond_2
    move-object v1, v0

    :goto_1
    return-object v1
.end method

.method public final getNamespaceURI()Ljava/lang/String;
    .locals 2

    .line 516
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    goto :goto_0

    .line 517
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_ELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 519
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getNamespaceURI()Ljava/lang/String;

    move-result-object v0

    .line 520
    .local v0, "uri":Ljava/lang/String;
    if-nez v0, :cond_2

    const-string v1, ""

    goto :goto_1

    :cond_2
    move-object v1, v0

    :goto_1
    return-object v1
.end method

.method public final getNamespaceURI(I)Ljava/lang/String;
    .locals 2
    .param p1, "index"    # I

    .line 525
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    goto :goto_0

    .line 526
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_ELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 528
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;->getNamespaceURI(I)Ljava/lang/String;

    move-result-object v0

    .line 529
    .local v0, "uri":Ljava/lang/String;
    if-nez v0, :cond_2

    const-string v1, ""

    goto :goto_1

    :cond_2
    move-object v1, v0

    :goto_1
    return-object v1
.end method

.method public final getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;

    .line 535
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    goto :goto_0

    .line 536
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_ELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 541
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;->getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final getNonTransientNamespaceContext()Ljavax/xml/namespace/NamespaceContext;
    .locals 1

    .line 1530
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getNonTransientNamespaceContext()Ljavax/xml/namespace/NamespaceContext;

    move-result-object v0

    return-object v0
.end method

.method public final getNotationAttributeIndex()I
    .locals 1

    .line 1687
    const/4 v0, -0x1

    return v0
.end method

.method public final getPIData()Ljava/lang/String;
    .locals 2

    .line 547
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    .line 551
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getText()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljavax/xml/stream/XMLStreamException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 552
    :catch_0
    move-exception v0

    .line 553
    .local v0, "sex":Ljavax/xml/stream/XMLStreamException;
    invoke-static {v0}, Lcom/fasterxml/aalto/UncheckedStreamException;->createFrom(Ljavax/xml/stream/XMLStreamException;)Lcom/fasterxml/aalto/UncheckedStreamException;

    move-result-object v1

    throw v1

    .line 548
    .end local v0    # "sex":Ljavax/xml/stream/XMLStreamException;
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_PI:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final getPITarget()Ljava/lang/String;
    .locals 2

    .line 559
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    .line 562
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getLocalName()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 560
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_PI:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final getPrefix()Ljava/lang/String;
    .locals 2

    .line 567
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    goto :goto_0

    .line 568
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_ELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 571
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getPrefix()Ljava/lang/String;

    move-result-object v0

    .line 572
    .local v0, "p":Ljava/lang/String;
    if-nez v0, :cond_2

    const-string v1, ""

    goto :goto_1

    :cond_2
    move-object v1, v0

    :goto_1
    return-object v1
.end method

.method public final getPrefixedName()Ljava/lang/String;
    .locals 2

    .line 1536
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    sparse-switch v0, :sswitch_data_0

    .line 1548
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Current state not START_ELEMENT, END_ELEMENT, ENTITY_REFERENCE, PROCESSING_INSTRUCTION or DTD"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1545
    :sswitch_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getDTDRootName()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 1541
    :sswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getLocalName()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 1543
    :sswitch_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getPITarget()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 1539
    :sswitch_3
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v0

    return-object v0

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

.method public final getProcessedDTD()Ljava/lang/Object;
    .locals 1

    .line 1569
    const/4 v0, 0x0

    return-object v0
.end method

.method public final getProcessedDTDSchema()Lorg/codehaus/stax2/validation/DTDValidationSchema;
    .locals 1

    .line 1616
    const/4 v0, 0x0

    return-object v0
.end method

.method public getProperty(Ljava/lang/String;)Ljava/lang/Object;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 275
    const-string v0, "javax.xml.stream.entities"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 277
    sget-object v0, Ljava/util/Collections;->EMPTY_LIST:Ljava/util/List;

    return-object v0

    .line 279
    :cond_0
    const-string v0, "javax.xml.stream.notations"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 281
    sget-object v0, Ljava/util/Collections;->EMPTY_LIST:Ljava/util/List;

    return-object v0

    .line 284
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getConfig()Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->getProperty(Ljava/lang/String;Z)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public getScanner()Lcom/fasterxml/aalto/in/XmlScanner;
    .locals 1

    .line 173
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    return-object v0
.end method

.method public final getStartLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
    .locals 1

    .line 1651
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getStartLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v0

    return-object v0
.end method

.method public final getStartingByteOffset()J
    .locals 2

    .line 1629
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getStartingByteOffset()J

    move-result-wide v0

    return-wide v0
.end method

.method public final getStartingCharOffset()J
    .locals 2

    .line 1634
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getStartingCharOffset()J

    move-result-wide v0

    return-wide v0
.end method

.method public final getText(Ljava/io/Writer;Z)I
    .locals 2
    .param p1, "w"    # Ljava/io/Writer;
    .param p2, "preserveContents"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1493
    const/4 v0, 0x1

    iget v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    shl-int/2addr v0, v1

    and-int/lit16 v0, v0, 0x1a78

    if-nez v0, :cond_0

    .line 1494
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->throwNotTextual(I)V

    .line 1496
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/in/XmlScanner;->getText(Ljava/io/Writer;Z)I

    move-result v0

    return v0
.end method

.method public final getText()Ljava/lang/String;
    .locals 2

    .line 578
    const/4 v0, 0x1

    iget v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    shl-int/2addr v0, v1

    and-int/lit16 v0, v0, 0x1a70

    if-nez v0, :cond_0

    .line 579
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->throwNotTextual(I)V

    .line 582
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getText()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljavax/xml/stream/XMLStreamException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 583
    :catch_0
    move-exception v0

    .line 584
    .local v0, "sex":Ljavax/xml/stream/XMLStreamException;
    invoke-static {v0}, Lcom/fasterxml/aalto/UncheckedStreamException;->createFrom(Ljavax/xml/stream/XMLStreamException;)Lcom/fasterxml/aalto/UncheckedStreamException;

    move-result-object v1

    throw v1
.end method

.method public final getTextCharacters(I[CII)I
    .locals 2
    .param p1, "srcStart"    # I
    .param p2, "target"    # [C
    .param p3, "targetStart"    # I
    .param p4, "len"    # I

    .line 604
    const/4 v0, 0x1

    iget v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    shl-int/2addr v0, v1

    and-int/lit16 v0, v0, 0x1070

    if-nez v0, :cond_0

    .line 605
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->throwNotTextXxx(I)V

    .line 608
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/fasterxml/aalto/in/XmlScanner;->getTextCharacters(I[CII)I

    move-result v0
    :try_end_0
    .catch Ljavax/xml/stream/XMLStreamException; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    .line 609
    :catch_0
    move-exception v0

    .line 610
    .local v0, "sex":Ljavax/xml/stream/XMLStreamException;
    invoke-static {v0}, Lcom/fasterxml/aalto/UncheckedStreamException;->createFrom(Ljavax/xml/stream/XMLStreamException;)Lcom/fasterxml/aalto/UncheckedStreamException;

    move-result-object v1

    throw v1
.end method

.method public final getTextCharacters()[C
    .locals 2

    .line 591
    const/4 v0, 0x1

    iget v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    shl-int/2addr v0, v1

    and-int/lit16 v0, v0, 0x1070

    if-nez v0, :cond_0

    .line 592
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->throwNotTextXxx(I)V

    .line 595
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getTextCharacters()[C

    move-result-object v0
    :try_end_0
    .catch Ljavax/xml/stream/XMLStreamException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 596
    :catch_0
    move-exception v0

    .line 597
    .local v0, "sex":Ljavax/xml/stream/XMLStreamException;
    invoke-static {v0}, Lcom/fasterxml/aalto/UncheckedStreamException;->createFrom(Ljavax/xml/stream/XMLStreamException;)Lcom/fasterxml/aalto/UncheckedStreamException;

    move-result-object v1

    throw v1
.end method

.method public final getTextLength()I
    .locals 2

    .line 617
    const/4 v0, 0x1

    iget v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    shl-int/2addr v0, v1

    and-int/lit16 v0, v0, 0x1070

    if-nez v0, :cond_0

    .line 618
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->throwNotTextXxx(I)V

    .line 621
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getTextLength()I

    move-result v0
    :try_end_0
    .catch Ljavax/xml/stream/XMLStreamException; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    .line 622
    :catch_0
    move-exception v0

    .line 623
    .local v0, "sex":Ljavax/xml/stream/XMLStreamException;
    invoke-static {v0}, Lcom/fasterxml/aalto/UncheckedStreamException;->createFrom(Ljavax/xml/stream/XMLStreamException;)Lcom/fasterxml/aalto/UncheckedStreamException;

    move-result-object v1

    throw v1
.end method

.method public final getTextStart()I
    .locals 2

    .line 630
    const/4 v0, 0x1

    iget v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    shl-int/2addr v0, v1

    and-int/lit16 v0, v0, 0x1070

    if-nez v0, :cond_0

    .line 631
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->throwNotTextXxx(I)V

    .line 636
    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public getVersion()Ljava/lang/String;
    .locals 1

    .line 253
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getConfig()Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getXmlDeclVersion()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected handlePrologEoi(Z)I
    .locals 1
    .param p1, "isProlog"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1752
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->close()V

    .line 1755
    if-eqz p1, :cond_0

    .line 1756
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->SUFFIX_IN_PROLOG:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->throwUnexpectedEOI(Ljava/lang/String;)V

    .line 1758
    :cond_0
    const/16 v0, 0x8

    return v0
.end method

.method protected handleTreeEoi()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1767
    const/16 v0, 0x8

    iput v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    .line 1769
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->SUFFIX_IN_TREE:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->throwUnexpectedEOI(Ljava/lang/String;)V

    .line 1770
    return-void
.end method

.method public final hasName()Z
    .locals 3

    .line 641
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v2, 0x2

    if-ne v0, v2, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :cond_1
    :goto_0
    return v1
.end method

.method public final hasNext()Z
    .locals 2

    .line 646
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/16 v1, 0x8

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public final hasText()Z
    .locals 2

    .line 651
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    shl-int v0, v1, v0

    and-int/lit16 v0, v0, 0x1a70

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method public final isAttributeSpecified(I)Z
    .locals 2
    .param p1, "index"    # I

    .line 658
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 661
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;->isAttrSpecified(I)Z

    move-result v0

    return v0

    .line 659
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_STELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final isCharacters()Z
    .locals 2

    .line 666
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getEventType()I

    move-result v0

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public final isEmptyElement()Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1525
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->isEmptyTag()Z

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public final isEndElement()Z
    .locals 2

    .line 671
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public final isPropertySupported(Ljava/lang/String;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 1385
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getConfig()Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/ReaderConfig;->isPropertySupported(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public final isStandalone()Z
    .locals 2

    .line 258
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getConfig()Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getXmlDeclStandalone()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method public final isStartElement()Z
    .locals 2

    .line 676
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method public final isWhiteSpace()Z
    .locals 2

    .line 682
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x4

    if-eq v0, v1, :cond_2

    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/16 v1, 0xc

    if-ne v0, v1, :cond_0

    goto :goto_1

    .line 689
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x6

    if-ne v0, v1, :cond_1

    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    :goto_0
    return v0

    .line 684
    :cond_2
    :goto_1
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->isTextWhitespace()Z

    move-result v0
    :try_end_0
    .catch Ljavax/xml/stream/XMLStreamException; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    .line 685
    :catch_0
    move-exception v0

    .line 686
    .local v0, "sex":Ljavax/xml/stream/XMLStreamException;
    invoke-static {v0}, Lcom/fasterxml/aalto/UncheckedStreamException;->createFrom(Ljavax/xml/stream/XMLStreamException;)Lcom/fasterxml/aalto/UncheckedStreamException;

    move-result-object v1

    throw v1
.end method

.method public final next()I
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 759
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_parseState:I

    const/4 v1, 0x2

    const/4 v2, 0x1

    if-ne v0, v2, :cond_5

    .line 760
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->nextFromTree()I

    move-result v0

    .line 761
    .local v0, "type":I
    const/4 v3, -0x1

    if-ne v0, v3, :cond_0

    .line 762
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->handleTreeEoi()V

    .line 764
    :cond_0
    iput v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    .line 770
    const/16 v3, 0xc

    if-ne v0, v3, :cond_2

    .line 771
    iget-boolean v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_cfgCoalesceText:Z

    if-nez v1, :cond_1

    iget-boolean v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_cfgReportTextAsChars:Z

    if-eqz v1, :cond_4

    .line 772
    :cond_1
    const/4 v1, 0x4

    return v1

    .line 775
    :cond_2
    iget-object v3, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/XmlScanner;->getName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v3

    iput-object v3, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currName:Lcom/fasterxml/aalto/in/PName;

    .line 776
    if-ne v0, v1, :cond_3

    .line 777
    iget-object v2, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/in/XmlScanner;->hasEmptyStack()Z

    move-result v2

    if-eqz v2, :cond_4

    .line 778
    iput v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_parseState:I

    goto :goto_0

    .line 780
    :cond_3
    if-ne v0, v2, :cond_4

    .line 781
    iget-object v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/XmlScanner;->getAttrCount()I

    move-result v1

    iput v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_attrCount:I

    .line 784
    :cond_4
    :goto_0
    return v0

    .line 789
    .end local v0    # "type":I
    :cond_5
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_parseState:I

    const/4 v3, 0x0

    if-nez v0, :cond_8

    .line 790
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0, v2}, Lcom/fasterxml/aalto/in/XmlScanner;->nextFromProlog(Z)I

    move-result v0

    .line 792
    .restart local v0    # "type":I
    if-ne v0, v2, :cond_6

    .line 793
    iput v2, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_parseState:I

    .line 794
    iget-object v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/XmlScanner;->getAttrCount()I

    move-result v1

    iput v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_attrCount:I

    goto :goto_1

    .line 795
    :cond_6
    const/16 v1, 0xb

    if-ne v0, v1, :cond_9

    .line 796
    iget-object v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_dtdRootName:Lcom/fasterxml/aalto/in/PName;

    if-eqz v1, :cond_7

    .line 797
    const-string v1, "Duplicate DOCTYPE declaration"

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->throwWfe(Ljava/lang/String;)V

    .line 799
    :cond_7
    iget-object v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/XmlScanner;->getName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_dtdRootName:Lcom/fasterxml/aalto/in/PName;

    goto :goto_1

    .line 801
    .end local v0    # "type":I
    :cond_8
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_parseState:I

    if-ne v0, v1, :cond_c

    .line 802
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0, v3}, Lcom/fasterxml/aalto/in/XmlScanner;->nextFromProlog(Z)I

    move-result v0

    .line 808
    .restart local v0    # "type":I
    :cond_9
    :goto_1
    if-gez v0, :cond_b

    .line 810
    iget v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_parseState:I

    if-nez v1, :cond_a

    goto :goto_2

    :cond_a
    move v2, v3

    :goto_2
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->handlePrologEoi(Z)I

    move-result v1

    return v1

    .line 812
    :cond_b
    iget-object v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/XmlScanner;->getName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currName:Lcom/fasterxml/aalto/in/PName;

    .line 813
    iput v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    return v0

    .line 806
    .end local v0    # "type":I
    :cond_c
    new-instance v0, Ljava/util/NoSuchElementException;

    invoke-direct {v0}, Ljava/util/NoSuchElementException;-><init>()V

    throw v0
.end method

.method public final nextTag()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 820
    nop

    :goto_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->next()I

    move-result v0

    .line 822
    .local v0, "next":I
    packed-switch v0, :pswitch_data_0

    :pswitch_0
    goto :goto_1

    .line 829
    :pswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->isWhiteSpace()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 830
    goto :goto_0

    .line 832
    :cond_0
    const-string v1, "Received non-all-whitespace CHARACTERS or CDATA event in nextTag()."

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->throwWfe(Ljava/lang/String;)V

    .line 833
    goto :goto_1

    .line 826
    :pswitch_2
    goto :goto_0

    .line 836
    :pswitch_3
    return v0

    .line 838
    :goto_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Received event "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {v0}, Lcom/fasterxml/aalto/impl/ErrorConsts;->tokenTypeDesc(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", instead of START_ELEMENT or END_ELEMENT."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->throwWfe(Ljava/lang/String;)V

    .line 840
    .end local v0    # "next":I
    goto :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_3
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_2
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public final readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I
    .locals 10
    .param p1, "dec"    # Lorg/codehaus/stax2/typed/TypedArrayDecoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1009
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    .line 1011
    .local v0, "type":I
    const/4 v1, 0x1

    shl-int v2, v1, v0

    and-int/lit16 v2, v2, 0x1056

    if-eqz v2, :cond_c

    .line 1019
    const/16 v2, 0xc

    const/4 v3, 0x3

    const/4 v4, 0x4

    const/4 v5, 0x5

    const/4 v6, 0x2

    const/4 v7, -0x1

    if-ne v0, v1, :cond_5

    .line 1021
    iget-object v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/XmlScanner;->isEmptyTag()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1023
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->next()I

    .line 1024
    return v7

    .line 1028
    :cond_0
    :goto_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->next()I

    move-result v0

    .line 1029
    if-ne v0, v6, :cond_1

    .line 1030
    return v7

    .line 1032
    :cond_1
    if-eq v0, v5, :cond_0

    if-ne v0, v3, :cond_2

    .line 1033
    goto :goto_0

    .line 1035
    :cond_2
    if-eq v0, v4, :cond_4

    if-ne v0, v2, :cond_3

    .line 1036
    goto :goto_1

    .line 1039
    :cond_3
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_constructUnexpectedInTyped(I)Ljavax/xml/stream/XMLStreamException;

    move-result-object v1

    throw v1

    .line 1041
    :cond_4
    :goto_1
    const/4 v1, 0x1

    .local v1, "reset":Z
    goto :goto_2

    .line 1043
    .end local v1    # "reset":Z
    :cond_5
    const/4 v1, 0x0

    .line 1046
    .restart local v1    # "reset":Z
    :goto_2
    const/4 v8, 0x0

    .line 1047
    .local v8, "count":I
    :goto_3
    if-eq v0, v6, :cond_a

    .line 1051
    if-eq v0, v4, :cond_8

    if-eq v0, v2, :cond_8

    const/4 v9, 0x6

    if-ne v0, v9, :cond_6

    goto :goto_4

    .line 1056
    :cond_6
    if-eq v0, v5, :cond_9

    if-ne v0, v3, :cond_7

    goto :goto_5

    .line 1059
    :cond_7
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_constructUnexpectedInTyped(I)Ljavax/xml/stream/XMLStreamException;

    move-result-object v2

    throw v2

    .line 1052
    :cond_8
    :goto_4
    iget-object v9, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v9, p1, v1}, Lcom/fasterxml/aalto/in/XmlScanner;->decodeElements(Lorg/codehaus/stax2/typed/TypedArrayDecoder;Z)I

    move-result v9

    add-int/2addr v8, v9

    .line 1053
    invoke-virtual {p1}, Lorg/codehaus/stax2/typed/TypedArrayDecoder;->hasRoom()Z

    move-result v9

    if-nez v9, :cond_9

    .line 1054
    goto :goto_6

    .line 1061
    :cond_9
    :goto_5
    const/4 v1, 0x1

    .line 1062
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->next()I

    move-result v0

    goto :goto_3

    .line 1066
    :cond_a
    :goto_6
    if-lez v8, :cond_b

    move v7, v8

    :cond_b
    return v7

    .line 1012
    .end local v1    # "reset":Z
    .end local v8    # "count":I
    :cond_c
    new-instance v1, Ljava/lang/IllegalStateException;

    sget-object v2, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_STELEM_OR_TEXT:Ljava/lang/String;

    invoke-direct {v1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public final readElementAsBinary([BII)I
    .locals 1
    .param p1, "resultBuffer"    # [B
    .param p2, "offset"    # I
    .param p3, "maxLength"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1079
    invoke-static {}, Lorg/codehaus/stax2/typed/Base64Variants;->getDefaultVariant()Lorg/codehaus/stax2/typed/Base64Variant;

    move-result-object v0

    invoke-virtual {p0, p1, p2, p3, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->readElementAsBinary([BIILorg/codehaus/stax2/typed/Base64Variant;)I

    move-result v0

    return v0
.end method

.method public final readElementAsBinary([BIILorg/codehaus/stax2/typed/Base64Variant;)I
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

    .line 1086
    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move/from16 v0, p2

    move/from16 v3, p3

    move-object/from16 v4, p4

    const-string v5, ""

    if-eqz v2, :cond_12

    .line 1089
    if-ltz v0, :cond_11

    .line 1092
    const/4 v6, 0x0

    const/4 v7, 0x1

    if-lt v3, v7, :cond_f

    add-int v8, v0, v3

    array-length v9, v2

    if-le v8, v9, :cond_0

    goto/16 :goto_6

    .line 1099
    :cond_0
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_base64Decoder()Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;

    move-result-object v8

    .line 1100
    .local v8, "dec":Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;
    iget v9, v1, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    .line 1102
    .local v9, "type":I
    shl-int v10, v7, v9

    and-int/lit16 v10, v10, 0x1052

    const/4 v11, 0x3

    const/4 v12, 0x5

    const/4 v13, -0x1

    const/4 v14, 0x2

    if-nez v10, :cond_2

    .line 1103
    if-ne v9, v14, :cond_1

    .line 1105
    invoke-virtual {v8}, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->hasData()Z

    move-result v10

    if-nez v10, :cond_8

    .line 1106
    return v13

    .line 1109
    :cond_1
    new-instance v5, Ljava/lang/IllegalStateException;

    sget-object v6, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_STELEM_OR_TEXT:Ljava/lang/String;

    invoke-direct {v5, v6}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 1111
    :cond_2
    if-ne v9, v7, :cond_8

    .line 1112
    iget-object v10, v1, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v10}, Lcom/fasterxml/aalto/in/XmlScanner;->isEmptyTag()Z

    move-result v10

    if-eqz v10, :cond_3

    .line 1114
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->next()I

    .line 1115
    return v13

    .line 1119
    :cond_3
    :goto_0
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->next()I

    move-result v9

    .line 1120
    if-ne v9, v14, :cond_4

    .line 1121
    return v13

    .line 1123
    :cond_4
    if-eq v9, v12, :cond_3

    if-ne v9, v11, :cond_5

    .line 1124
    goto :goto_0

    .line 1126
    :cond_5
    const/4 v10, 0x4

    if-eq v9, v10, :cond_7

    const/16 v10, 0xc

    if-ne v9, v10, :cond_6

    .line 1127
    goto :goto_1

    .line 1130
    :cond_6
    invoke-virtual {v1, v9}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_constructUnexpectedInTyped(I)Ljavax/xml/stream/XMLStreamException;

    move-result-object v5

    throw v5

    .line 1132
    :cond_7
    :goto_1
    iget-object v10, v1, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v10, v4, v8, v7}, Lcom/fasterxml/aalto/in/XmlScanner;->resetForDecoding(Lorg/codehaus/stax2/typed/Base64Variant;Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;Z)V

    .line 1135
    :cond_8
    const/4 v10, 0x0

    move v15, v10

    move v10, v9

    move v9, v3

    move v3, v0

    .line 1142
    .end local p2    # "offset":I
    .end local p3    # "maxLength":I
    .local v3, "offset":I
    .local v9, "maxLength":I
    .local v10, "type":I
    .local v15, "totalCount":I
    :goto_2
    :try_start_0
    invoke-virtual {v8, v2, v3, v9}, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->decode([BII)I

    move-result v0
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1146
    .local v0, "count":I
    nop

    .line 1147
    add-int/2addr v3, v0

    .line 1148
    add-int/2addr v15, v0

    .line 1149
    sub-int/2addr v9, v0

    .line 1154
    if-lt v9, v7, :cond_d

    iget v7, v1, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    if-ne v7, v14, :cond_9

    .line 1155
    goto :goto_5

    .line 1159
    :cond_9
    :goto_3
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->next()I

    move-result v10

    .line 1160
    if-eq v10, v12, :cond_9

    if-eq v10, v11, :cond_9

    const/4 v7, 0x6

    if-ne v10, v7, :cond_a

    .line 1162
    goto :goto_3

    .line 1164
    :cond_a
    if-ne v10, v14, :cond_c

    .line 1171
    invoke-virtual {v8}, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->endOfContent()I

    move-result v7

    .line 1172
    .local v7, "left":I
    if-ltz v7, :cond_b

    .line 1174
    if-lez v7, :cond_d

    .line 1175
    goto :goto_4

    .line 1173
    :cond_b
    const-string v6, "Incomplete base64 triplet at the end of decoded content"

    invoke-direct {v1, v6, v5}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_constructTypeException(Ljava/lang/String;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    move-result-object v5

    throw v5

    .line 1180
    .end local v7    # "left":I
    :cond_c
    iget-object v7, v1, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v7, v4, v8, v6}, Lcom/fasterxml/aalto/in/XmlScanner;->resetForDecoding(Lorg/codehaus/stax2/typed/Base64Variant;Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;Z)V

    .line 1181
    nop

    .line 1183
    .end local v0    # "count":I
    nop

    .line 1142
    :goto_4
    const/4 v7, 0x1

    goto :goto_2

    .line 1186
    :cond_d
    :goto_5
    if-lez v15, :cond_e

    move v13, v15

    :cond_e
    return v13

    .line 1143
    :catch_0
    move-exception v0

    move-object v6, v0

    move-object v0, v6

    .line 1145
    .local v0, "iae":Ljava/lang/IllegalArgumentException;
    invoke-virtual {v0}, Ljava/lang/IllegalArgumentException;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v1, v6, v5}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_constructTypeException(Ljava/lang/String;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    move-result-object v5

    throw v5

    .line 1093
    .end local v0    # "iae":Ljava/lang/IllegalArgumentException;
    .end local v3    # "offset":I
    .end local v8    # "dec":Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;
    .end local v9    # "maxLength":I
    .end local v10    # "type":I
    .end local v15    # "totalCount":I
    .restart local p2    # "offset":I
    .restart local p3    # "maxLength":I
    :cond_f
    :goto_6
    if-nez v3, :cond_10

    .line 1094
    return v6

    .line 1096
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

    .line 1090
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

    .line 1087
    :cond_12
    new-instance v5, Ljava/lang/IllegalArgumentException;

    const-string v6, "resultBuffer is null"

    invoke-direct {v5, v6}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v5
.end method

.method public final readElementAsDoubleArray([DII)I
    .locals 1
    .param p1, "value"    # [D
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1002
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDoubleArrayDecoder([DII)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I

    move-result v0

    return v0
.end method

.method public final readElementAsFloatArray([FII)I
    .locals 1
    .param p1, "value"    # [F
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 996
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getFloatArrayDecoder([FII)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I

    move-result v0

    return v0
.end method

.method public final readElementAsIntArray([III)I
    .locals 1
    .param p1, "value"    # [I
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 984
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntArrayDecoder([III)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I

    move-result v0

    return v0
.end method

.method public final readElementAsLongArray([JII)I
    .locals 1
    .param p1, "value"    # [J
    .param p2, "from"    # I
    .param p3, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 990
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_decoderFactory()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getLongArrayDecoder([JII)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->readElementAsArray(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)I

    move-result v0

    return v0
.end method

.method protected reportInvalidAttrIndex(I)V
    .locals 3
    .param p1, "index"    # I

    .line 1832
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Illegal attribute index, "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", current START_ELEMENT has "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_attrCount:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " attributes"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final require(ILjava/lang/String;Ljava/lang/String;)V
    .locals 8
    .param p1, "type"    # I
    .param p2, "nsUri"    # Ljava/lang/String;
    .param p3, "localName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 696
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    .line 702
    .local v0, "curr":I
    if-eq v0, p1, :cond_2

    .line 703
    const/16 v1, 0xc

    if-ne v0, v1, :cond_1

    .line 704
    iget-boolean v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_cfgCoalesceText:Z

    if-nez v1, :cond_0

    iget-boolean v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_cfgReportTextAsChars:Z

    if-eqz v1, :cond_2

    .line 705
    :cond_0
    const/4 v0, 0x4

    goto :goto_0

    .line 707
    :cond_1
    nop

    .line 714
    :cond_2
    :goto_0
    if-eq p1, v0, :cond_3

    .line 715
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Expected type "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p1}, Lcom/fasterxml/aalto/impl/ErrorConsts;->tokenTypeDesc(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", current type "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 717
    invoke-static {v0}, Lcom/fasterxml/aalto/impl/ErrorConsts;->tokenTypeDesc(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 715
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->throwWfe(Ljava/lang/String;)V

    .line 720
    :cond_3
    const-string v1, ")"

    const/4 v2, 0x2

    const/4 v3, 0x1

    const-string v4, "\'."

    if-eqz p3, :cond_5

    .line 721
    if-eq v0, v3, :cond_4

    if-eq v0, v2, :cond_4

    const/16 v5, 0x9

    if-eq v0, v5, :cond_4

    .line 723
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Expected non-null local name, but current token not a START_ELEMENT, END_ELEMENT or ENTITY_REFERENCE (was "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget v6, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    invoke-static {v6}, Lcom/fasterxml/aalto/impl/ErrorConsts;->tokenTypeDesc(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->throwWfe(Ljava/lang/String;)V

    .line 725
    :cond_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getLocalName()Ljava/lang/String;

    move-result-object v5

    .line 726
    .local v5, "n":Ljava/lang/String;
    if-eq v5, p3, :cond_5

    invoke-virtual {v5, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_5

    .line 727
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Expected local name \'"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "\'; current local name \'"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->throwWfe(Ljava/lang/String;)V

    .line 730
    .end local v5    # "n":Ljava/lang/String;
    :cond_5
    if-eqz p2, :cond_8

    .line 731
    if-eq v0, v3, :cond_6

    if-eq v0, v2, :cond_6

    .line 732
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Expected non-null NS URI, but current token not a START_ELEMENT or END_ELEMENT (was "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {v0}, Lcom/fasterxml/aalto/impl/ErrorConsts;->tokenTypeDesc(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->throwWfe(Ljava/lang/String;)V

    .line 734
    :cond_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getNamespaceURI()Ljava/lang/String;

    move-result-object v1

    .line 736
    .local v1, "uri":Ljava/lang/String;
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_7

    .line 737
    if-eqz v1, :cond_8

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_8

    .line 738
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Expected empty namespace, instead have \'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->throwWfe(Ljava/lang/String;)V

    goto :goto_1

    .line 741
    :cond_7
    if-eq p2, v1, :cond_8

    invoke-virtual {p2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_8

    .line 742
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Expected namespace \'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\'; have \'"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->throwWfe(Ljava/lang/String;)V

    .line 748
    .end local v1    # "uri":Ljava/lang/String;
    :cond_8
    :goto_1
    return-void
.end method

.method public final setFeature(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 0
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 1378
    return-void
.end method

.method public final setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 1401
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getConfig()Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/in/ReaderConfig;->setProperty(Ljava/lang/String;Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public final setValidationProblemHandler(Lorg/codehaus/stax2/validation/ValidationProblemHandler;)Lorg/codehaus/stax2/validation/ValidationProblemHandler;
    .locals 1
    .param p1, "h"    # Lorg/codehaus/stax2/validation/ValidationProblemHandler;

    .line 1724
    const/4 v0, 0x0

    return-object v0
.end method

.method public final skipElement()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1409
    iget v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_currToken:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_2

    .line 1412
    const/4 v0, 0x1

    .line 1415
    .local v0, "nesting":I
    :goto_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->next()I

    move-result v2

    .line 1416
    .local v2, "type":I
    if-ne v2, v1, :cond_0

    .line 1417
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 1418
    :cond_0
    const/4 v3, 0x2

    if-ne v2, v3, :cond_1

    .line 1419
    add-int/lit8 v0, v0, -0x1

    if-nez v0, :cond_1

    .line 1420
    nop

    .line 1424
    .end local v2    # "type":I
    return-void

    .line 1423
    :cond_1
    :goto_1
    goto :goto_0

    .line 1410
    .end local v0    # "nesting":I
    :cond_2
    new-instance v0, Ljava/lang/IllegalStateException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_STELEM:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final standaloneSet()Z
    .locals 1

    .line 263
    iget-object v0, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/XmlScanner;->getConfig()Lcom/fasterxml/aalto/in/ReaderConfig;

    move-result-object v0

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getXmlDeclStandalone()I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public final stopValidatingAgainst(Lorg/codehaus/stax2/validation/XMLValidationSchema;)Lorg/codehaus/stax2/validation/XMLValidator;
    .locals 1
    .param p1, "schema"    # Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1709
    const/4 v0, 0x0

    return-object v0
.end method

.method public final stopValidatingAgainst(Lorg/codehaus/stax2/validation/XMLValidator;)Lorg/codehaus/stax2/validation/XMLValidator;
    .locals 1
    .param p1, "validator"    # Lorg/codehaus/stax2/validation/XMLValidator;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1717
    const/4 v0, 0x0

    return-object v0
.end method

.method protected throwFromIOE(Ljava/io/IOException;)V
    .locals 1
    .param p1, "ioe"    # Ljava/io/IOException;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1791
    new-instance v0, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v0, p1}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v0
.end method

.method protected throwUnexpectedEOI(Ljava/lang/String;)V
    .locals 2
    .param p1, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1796
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Unexpected End-of-input"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->throwWfe(Ljava/lang/String;)V

    .line 1797
    return-void
.end method

.method protected throwWfe(Ljava/lang/String;)V
    .locals 2
    .param p1, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1777
    new-instance v0, Lcom/fasterxml/aalto/WFCException;

    invoke-virtual {p0}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->getLastCharLocation()Ljavax/xml/stream/Location;

    move-result-object v1

    invoke-direct {v0, p1, v1}, Lcom/fasterxml/aalto/WFCException;-><init>(Ljava/lang/String;Ljavax/xml/stream/Location;)V

    throw v0
.end method

.method public final toString()Ljava/lang/String;
    .locals 2

    .line 1904
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[Aalto stream reader, scanner: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_scanner:Lcom/fasterxml/aalto/in/XmlScanner;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final validateAgainst(Lorg/codehaus/stax2/validation/XMLValidationSchema;)Lorg/codehaus/stax2/validation/XMLValidator;
    .locals 1
    .param p1, "schema"    # Lorg/codehaus/stax2/validation/XMLValidationSchema;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1701
    const/4 v0, 0x0

    return-object v0
.end method

.method protected verifyQName(Ljavax/xml/namespace/QName;)Ljavax/xml/namespace/QName;
    .locals 6
    .param p1, "n"    # Ljavax/xml/namespace/QName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/codehaus/stax2/typed/TypedXMLStreamException;
        }
    .end annotation

    .line 1348
    invoke-virtual {p1}, Ljavax/xml/namespace/QName;->getLocalPart()Ljava/lang/String;

    move-result-object v0

    .line 1349
    .local v0, "ln":Ljava/lang/String;
    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/fasterxml/aalto/util/XmlNames;->findIllegalNameChar(Ljava/lang/String;Z)I

    move-result v1

    .line 1350
    .local v1, "ix":I
    if-ltz v1, :cond_1

    .line 1351
    invoke-virtual {p1}, Ljavax/xml/namespace/QName;->getPrefix()Ljava/lang/String;

    move-result-object v2

    .line 1352
    .local v2, "prefix":Ljava/lang/String;
    if-eqz v2, :cond_0

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    if-lez v3, :cond_0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ":"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    goto :goto_0

    :cond_0
    move-object v3, v0

    .line 1354
    .local v3, "pname":Ljava/lang/String;
    :goto_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Invalid local name \""

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "\" (character at #"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " is invalid)"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4, v3}, Lcom/fasterxml/aalto/stax/StreamReaderImpl;->_constructTypeException(Ljava/lang/String;Ljava/lang/String;)Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    move-result-object v4

    throw v4

    .line 1356
    .end local v2    # "prefix":Ljava/lang/String;
    .end local v3    # "pname":Ljava/lang/String;
    :cond_1
    return-object p1
.end method
