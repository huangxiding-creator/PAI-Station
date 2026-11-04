.class public final Lcom/fasterxml/aalto/in/AttributeCollector;
.super Ljava/lang/Object;
.source "AttributeCollector.java"


# static fields
.field private static final DEFAULT_BUFFER_LENGTH:I = 0x78

.field private static final DEFAULT_ENTRY_COUNT:I = 0xc

.field private static final INT_SPACE:I = 0x20


# instance fields
.field private _allAttrValues:Ljava/lang/String;

.field private _attrCount:I

.field protected _attrMap:[I

.field final _config:Lcom/fasterxml/aalto/in/ReaderConfig;

.field private _errorMsg:Ljava/lang/String;

.field protected _hashAreaSize:I

.field private _names:[Lcom/fasterxml/aalto/in/PName;

.field private _needToResetValues:Z

.field protected _spillAreaEnd:I

.field private _valueBuffer:[C

.field private _valueOffsets:[I


# direct methods
.method protected constructor <init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V
    .locals 2
    .param p1, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;

    .line 149
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 70
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_names:[Lcom/fasterxml/aalto/in/PName;

    .line 76
    iput-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueBuffer:[C

    .line 95
    iput-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrMap:[I

    .line 117
    iput-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueOffsets:[I

    .line 124
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_needToResetValues:Z

    .line 130
    iput-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_errorMsg:Ljava/lang/String;

    .line 140
    iput-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_allAttrValues:Ljava/lang/String;

    .line 150
    iput-object p1, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    .line 151
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrCount:I

    .line 152
    return-void
.end method

.method private final checkExpand(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)Z
    .locals 1
    .param p1, "tad"    # Lorg/codehaus/stax2/typed/TypedArrayDecoder;

    .line 584
    instance-of v0, p1, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;

    if-eqz v0, :cond_0

    .line 585
    move-object v0, p1

    check-cast v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;

    invoke-virtual {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;->expand()V

    .line 586
    const/4 v0, 0x1

    return v0

    .line 588
    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method private final decodeValues(Lorg/codehaus/stax2/typed/TypedArrayDecoder;[CIILcom/fasterxml/aalto/in/XmlScanner;)I
    .locals 7
    .param p1, "dec"    # Lorg/codehaus/stax2/typed/TypedArrayDecoder;
    .param p2, "buf"    # [C
    .param p3, "ptr"    # I
    .param p4, "end"    # I
    .param p5, "scanner"    # Lcom/fasterxml/aalto/in/XmlScanner;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 508
    move v0, p3

    .line 509
    .local v0, "start":I
    const/4 v1, 0x0

    .line 513
    .local v1, "count":I
    :goto_0
    if-ge p3, p4, :cond_4

    .line 515
    :cond_0
    :try_start_0
    aget-char v2, p2, p3

    const/16 v3, 0x20

    if-gt v2, v3, :cond_1

    .line 516
    add-int/lit8 p3, p3, 0x1

    if-lt p3, p4, :cond_0

    .line 517
    goto :goto_2

    .line 521
    :cond_1
    move v0, p3

    .line 522
    add-int/lit8 p3, p3, 0x1

    .line 523
    :goto_1
    if-ge p3, p4, :cond_2

    aget-char v2, p2, p3

    if-le v2, v3, :cond_2

    .line 524
    add-int/lit8 p3, p3, 0x1

    goto :goto_1

    .line 526
    :cond_2
    move v2, p3

    .line 527
    .local v2, "tokenEnd":I
    add-int/lit8 p3, p3, 0x1

    .line 529
    add-int/lit8 v1, v1, 0x1

    .line 530
    invoke-virtual {p1, p2, v0, v2}, Lorg/codehaus/stax2/typed/TypedArrayDecoder;->decodeValue([CII)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 531
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/in/AttributeCollector;->checkExpand(Lorg/codehaus/stax2/typed/TypedArrayDecoder;)Z

    move-result v3
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    if-nez v3, :cond_3

    .line 532
    goto :goto_2

    .line 535
    .end local v2    # "tokenEnd":I
    :cond_3
    goto :goto_0

    .line 536
    :catch_0
    move-exception v2

    .line 538
    .local v2, "iae":Ljava/lang/IllegalArgumentException;
    invoke-virtual {p5}, Lcom/fasterxml/aalto/in/XmlScanner;->getCurrentLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v3

    .line 539
    .local v3, "loc":Ljavax/xml/stream/Location;
    new-instance v4, Ljava/lang/String;

    sub-int v5, p3, v0

    invoke-direct {v4, p2, v0, v5}, Ljava/lang/String;-><init>([CII)V

    .line 540
    .local v4, "lexical":Ljava/lang/String;
    new-instance v5, Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    invoke-virtual {v2}, Ljava/lang/IllegalArgumentException;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v4, v6, v3, v2}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/stream/Location;Ljava/lang/IllegalArgumentException;)V

    throw v5

    .line 541
    .end local v2    # "iae":Ljava/lang/IllegalArgumentException;
    .end local v3    # "loc":Ljavax/xml/stream/Location;
    .end local v4    # "lexical":Ljava/lang/String;
    :cond_4
    :goto_2
    nop

    .line 542
    return v1
.end method

.method private static final isSpace(C)Z
    .locals 1
    .param p0, "c"    # C

    .line 573
    const/16 v0, 0x20

    if-gt p0, v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private noteDupAttr(II)V
    .locals 5
    .param p1, "ix1"    # I
    .param p2, "ix2"    # I

    .line 599
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_WF_DUP_ATTRS:Ljava/lang/String;

    iget-object v1, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_names:[Lcom/fasterxml/aalto/in/PName;

    aget-object v1, v1, p1

    .line 600
    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/PName;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    iget-object v3, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_names:[Lcom/fasterxml/aalto/in/PName;

    aget-object v3, v3, p2

    .line 601
    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/PName;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    filled-new-array {v1, v2, v3, v4}, [Ljava/lang/Object;

    move-result-object v1

    .line 599
    invoke-static {v0, v1}, Ljava/text/MessageFormat;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_errorMsg:Ljava/lang/String;

    .line 604
    return-void
.end method


# virtual methods
.method public continueValue()[C
    .locals 1

    .line 200
    iget-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueBuffer:[C

    return-object v0
.end method

.method public decodeBinaryValue(ILorg/codehaus/stax2/typed/Base64Variant;Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;Lcom/fasterxml/aalto/in/XmlScanner;)[B
    .locals 10
    .param p1, "index"    # I
    .param p2, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .param p3, "dec"    # Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;
    .param p4, "scanner"    # Lcom/fasterxml/aalto/in/XmlScanner;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 548
    if-ltz p1, :cond_1

    iget v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrCount:I

    if-ge p1, v0, :cond_1

    .line 553
    if-nez p1, :cond_0

    .line 554
    const/4 v0, 0x0

    .line 555
    .local v0, "start":I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueOffsets:[I

    const/4 v2, 0x0

    aget v1, v1, v2

    .local v1, "end":I
    goto :goto_0

    .line 557
    .end local v0    # "start":I
    .end local v1    # "end":I
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueOffsets:[I

    add-int/lit8 v1, p1, -0x1

    aget v0, v0, v1

    .line 558
    .restart local v0    # "start":I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueOffsets:[I

    aget v1, v1, p1

    .line 560
    .restart local v1    # "end":I
    :goto_0
    sub-int v9, v1, v0

    .line 561
    .local v9, "len":I
    iget-object v5, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueBuffer:[C

    const/4 v8, 0x0

    const/4 v4, 0x1

    move-object v2, p3

    move-object v3, p2

    move v6, v0

    move v7, v1

    invoke-virtual/range {v2 .. v8}, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->init(Lorg/codehaus/stax2/typed/Base64Variant;Z[CIILjava/util/List;)V

    .line 563
    :try_start_0
    invoke-virtual {p3}, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->decodeCompletely()[B

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    .line 564
    :catch_0
    move-exception v2

    .line 566
    .local v2, "iae":Ljava/lang/IllegalArgumentException;
    new-instance v3, Ljava/lang/String;

    iget-object v4, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueBuffer:[C

    invoke-direct {v3, v4, v0, v9}, Ljava/lang/String;-><init>([CII)V

    .line 567
    .local v3, "lexical":Ljava/lang/String;
    new-instance v4, Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    invoke-virtual {v2}, Ljava/lang/IllegalArgumentException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p4}, Lcom/fasterxml/aalto/in/XmlScanner;->getCurrentLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v6

    invoke-direct {v4, v3, v5, v6, v2}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/stream/Location;Ljava/lang/IllegalArgumentException;)V

    throw v4

    .line 549
    .end local v0    # "start":I
    .end local v1    # "end":I
    .end local v2    # "iae":Ljava/lang/IllegalArgumentException;
    .end local v3    # "lexical":Ljava/lang/String;
    .end local v9    # "len":I
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid index "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "; current element has only "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrCount:I

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

.method public final decodeValue(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V
    .locals 4
    .param p1, "index"    # I
    .param p2, "dec"    # Lorg/codehaus/stax2/typed/TypedValueDecoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 455
    if-ltz p1, :cond_4

    iget v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrCount:I

    if-ge p1, v0, :cond_4

    .line 461
    if-nez p1, :cond_0

    .line 462
    const/4 v0, 0x0

    .line 463
    .local v0, "start":I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueOffsets:[I

    const/4 v2, 0x0

    aget v1, v1, v2

    .local v1, "end":I
    goto :goto_0

    .line 465
    .end local v0    # "start":I
    .end local v1    # "end":I
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueOffsets:[I

    add-int/lit8 v1, p1, -0x1

    aget v0, v0, v1

    .line 466
    .restart local v0    # "start":I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueOffsets:[I

    aget v1, v1, p1

    .line 469
    .restart local v1    # "end":I
    :goto_0
    iget-object v2, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueBuffer:[C

    .line 471
    .local v2, "buf":[C
    :goto_1
    if-lt v0, v1, :cond_1

    .line 472
    invoke-virtual {p2}, Lorg/codehaus/stax2/typed/TypedValueDecoder;->handleEmptyValue()V

    .line 473
    return-void

    .line 475
    :cond_1
    aget-char v3, v2, v0

    invoke-static {v3}, Lcom/fasterxml/aalto/in/AttributeCollector;->isSpace(C)Z

    move-result v3

    if-nez v3, :cond_3

    .line 476
    nop

    .line 481
    :goto_2
    add-int/lit8 v1, v1, -0x1

    if-le v1, v0, :cond_2

    aget-char v3, v2, v1

    invoke-static {v3}, Lcom/fasterxml/aalto/in/AttributeCollector;->isSpace(C)Z

    move-result v3

    if-eqz v3, :cond_2

    goto :goto_2

    .line 482
    :cond_2
    add-int/lit8 v3, v1, 0x1

    invoke-virtual {p2, v2, v0, v3}, Lorg/codehaus/stax2/typed/TypedValueDecoder;->decode([CII)V

    .line 483
    return-void

    .line 478
    :cond_3
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 456
    .end local v0    # "start":I
    .end local v1    # "end":I
    .end local v2    # "buf":[C
    :cond_4
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid index "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "; current element has only "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrCount:I

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

.method public final decodeValues(ILorg/codehaus/stax2/typed/TypedArrayDecoder;Lcom/fasterxml/aalto/in/XmlScanner;)I
    .locals 8
    .param p1, "index"    # I
    .param p2, "dec"    # Lorg/codehaus/stax2/typed/TypedArrayDecoder;
    .param p3, "scanner"    # Lcom/fasterxml/aalto/in/XmlScanner;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 488
    if-ltz p1, :cond_1

    iget v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrCount:I

    if-ge p1, v0, :cond_1

    .line 493
    if-nez p1, :cond_0

    .line 494
    const/4 v0, 0x0

    .line 495
    .local v0, "start":I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueOffsets:[I

    const/4 v2, 0x0

    aget v1, v1, v2

    .local v1, "end":I
    goto :goto_0

    .line 497
    .end local v0    # "start":I
    .end local v1    # "end":I
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueOffsets:[I

    add-int/lit8 v1, p1, -0x1

    aget v0, v0, v1

    .line 498
    .restart local v0    # "start":I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueOffsets:[I

    aget v1, v1, p1

    .line 500
    .restart local v1    # "end":I
    :goto_0
    iget-object v4, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueBuffer:[C

    move-object v2, p0

    move-object v3, p2

    move v5, v0

    move v6, v1

    move-object v7, p3

    invoke-direct/range {v2 .. v7}, Lcom/fasterxml/aalto/in/AttributeCollector;->decodeValues(Lorg/codehaus/stax2/typed/TypedArrayDecoder;[CIILcom/fasterxml/aalto/in/XmlScanner;)I

    move-result v2

    return v2

    .line 489
    .end local v0    # "start":I
    .end local v1    # "end":I
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid index "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "; current element has only "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrCount:I

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

.method public findIndex(Ljava/lang/String;Ljava/lang/String;)I
    .locals 8
    .param p1, "nsUri"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 401
    iget v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_hashAreaSize:I

    .line 404
    .local v0, "hashSize":I
    const/4 v1, 0x1

    const/4 v2, -0x1

    if-ge v0, v1, :cond_2

    .line 405
    const/4 v1, 0x0

    .local v1, "i":I
    iget v3, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrCount:I

    .local v3, "len":I
    :goto_0
    if-ge v1, v3, :cond_1

    .line 406
    iget-object v4, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_names:[Lcom/fasterxml/aalto/in/PName;

    aget-object v4, v4, v1

    .line 407
    .local v4, "curr":Lcom/fasterxml/aalto/in/PName;
    invoke-virtual {v4, p1, p2}, Lcom/fasterxml/aalto/in/PName;->boundEquals(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 408
    return v1

    .line 405
    .end local v4    # "curr":Lcom/fasterxml/aalto/in/PName;
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 411
    .end local v1    # "i":I
    .end local v3    # "len":I
    :cond_1
    return v2

    .line 415
    :cond_2
    invoke-static {p1, p2}, Lcom/fasterxml/aalto/in/PName;->boundHashCode(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 416
    .local v1, "hash":I
    iget-object v3, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrMap:[I

    add-int/lit8 v4, v0, -0x1

    and-int/2addr v4, v1

    aget v3, v3, v4

    .line 418
    .local v3, "ix":I
    if-lez v3, :cond_6

    .line 419
    add-int/lit8 v3, v3, -0x1

    .line 421
    iget-object v4, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_names:[Lcom/fasterxml/aalto/in/PName;

    aget-object v4, v4, v3

    invoke-virtual {v4, p1, p2}, Lcom/fasterxml/aalto/in/PName;->boundEquals(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 422
    return v3

    .line 427
    :cond_3
    move v4, v0

    .local v4, "i":I
    iget v5, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_spillAreaEnd:I

    .local v5, "len":I
    :goto_1
    if-ge v4, v5, :cond_6

    .line 428
    iget-object v6, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrMap:[I

    aget v6, v6, v4

    if-eq v6, v1, :cond_4

    .line 429
    goto :goto_2

    .line 434
    :cond_4
    iget-object v6, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrMap:[I

    add-int/lit8 v7, v4, 0x1

    aget v3, v6, v7

    .line 435
    iget-object v6, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_names:[Lcom/fasterxml/aalto/in/PName;

    aget-object v6, v6, v3

    invoke-virtual {v6, p1, p2}, Lcom/fasterxml/aalto/in/PName;->boundEquals(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_5

    .line 436
    return v3

    .line 427
    :cond_5
    :goto_2
    add-int/lit8 v4, v4, 0x2

    goto :goto_1

    .line 441
    .end local v4    # "i":I
    .end local v5    # "len":I
    :cond_6
    return v2
.end method

.method public final finishLastValue(I)I
    .locals 6
    .param p1, "endingOffset"    # I

    .line 212
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_needToResetValues:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 213
    return v1

    .line 215
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_needToResetValues:Z

    .line 218
    iget v2, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrCount:I

    .line 219
    .local v2, "count":I
    iget-object v3, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueOffsets:[I

    add-int/lit8 v4, v2, -0x1

    aput p1, v3, v4

    .line 227
    const/4 v3, 0x3

    if-ge v2, v3, :cond_2

    .line 228
    iput v1, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_hashAreaSize:I

    .line 229
    const/4 v3, 0x2

    if-ne v2, v3, :cond_1

    .line 230
    iget-object v3, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_names:[Lcom/fasterxml/aalto/in/PName;

    .line 231
    .local v3, "names":[Lcom/fasterxml/aalto/in/PName;
    aget-object v4, v3, v1

    aget-object v5, v3, v0

    invoke-virtual {v4, v5}, Lcom/fasterxml/aalto/in/PName;->boundEquals(Lcom/fasterxml/aalto/in/PName;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 232
    invoke-direct {p0, v1, v0}, Lcom/fasterxml/aalto/in/AttributeCollector;->noteDupAttr(II)V

    .line 233
    const/4 v0, -0x1

    return v0

    .line 236
    .end local v3    # "names":[Lcom/fasterxml/aalto/in/PName;
    :cond_1
    return v2

    .line 238
    :cond_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/AttributeCollector;->finishLastValue2()I

    move-result v0

    return v0
.end method

.method public final finishLastValue2()I
    .locals 13

    .line 243
    iget v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrCount:I

    .line 244
    .local v0, "count":I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_names:[Lcom/fasterxml/aalto/in/PName;

    .line 251
    .local v1, "names":[Lcom/fasterxml/aalto/in/PName;
    iget-object v2, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrMap:[I

    .line 258
    .local v2, "map":[I
    const/16 v3, 0x8

    .line 260
    .local v3, "hashCount":I
    shr-int/lit8 v4, v0, 0x2

    add-int/2addr v4, v0

    .line 264
    .local v4, "min":I
    :goto_0
    if-ge v3, v4, :cond_0

    .line 265
    add-int/2addr v3, v3

    goto :goto_0

    .line 268
    :cond_0
    iput v3, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_hashAreaSize:I

    .line 269
    shr-int/lit8 v5, v3, 0x4

    add-int/2addr v5, v3

    .line 270
    .end local v4    # "min":I
    .local v5, "min":I
    if-eqz v2, :cond_2

    array-length v4, v2

    if-ge v4, v5, :cond_1

    goto :goto_2

    .line 277
    :cond_1
    const/4 v4, 0x7

    const/4 v6, 0x0

    aput v6, v2, v4

    const/4 v4, 0x6

    aput v6, v2, v4

    const/4 v4, 0x5

    aput v6, v2, v4

    const/4 v4, 0x4

    aput v6, v2, v4

    const/4 v4, 0x3

    aput v6, v2, v4

    const/4 v4, 0x2

    aput v6, v2, v4

    const/4 v4, 0x1

    aput v6, v2, v4

    aput v6, v2, v6

    .line 278
    const/16 v4, 0x8

    .local v4, "i":I
    :goto_1
    if-ge v4, v3, :cond_3

    .line 279
    aput v6, v2, v4

    .line 278
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 271
    .end local v4    # "i":I
    :cond_2
    :goto_2
    new-array v2, v5, [I

    .line 285
    .end local v5    # "min":I
    :cond_3
    add-int/lit8 v4, v3, -0x1

    .line 286
    .local v4, "mask":I
    move v5, v3

    .line 289
    .local v5, "spillIndex":I
    const/4 v6, 0x0

    .local v6, "i":I
    :goto_3
    if-ge v6, v0, :cond_9

    .line 290
    aget-object v7, v1, v6

    .line 291
    .local v7, "newName":Lcom/fasterxml/aalto/in/PName;
    invoke-virtual {v7}, Lcom/fasterxml/aalto/in/PName;->boundHashCode()I

    move-result v8

    .line 292
    .local v8, "hash":I
    and-int v9, v8, v4

    .line 294
    .local v9, "index":I
    aget v10, v2, v9

    .line 295
    .local v10, "oldNameIndex":I
    if-nez v10, :cond_4

    .line 296
    add-int/lit8 v11, v6, 0x1

    aput v11, v2, v9

    goto :goto_6

    .line 298
    :cond_4
    add-int/lit8 v10, v10, -0x1

    .line 300
    aget-object v11, v1, v10

    invoke-virtual {v11, v7}, Lcom/fasterxml/aalto/in/PName;->boundEquals(Lcom/fasterxml/aalto/in/PName;)Z

    move-result v11

    if-eqz v11, :cond_5

    .line 302
    iget-object v11, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_errorMsg:Ljava/lang/String;

    if-nez v11, :cond_5

    .line 303
    invoke-direct {p0, v10, v6}, Lcom/fasterxml/aalto/in/AttributeCollector;->noteDupAttr(II)V

    .line 313
    :cond_5
    add-int/lit8 v11, v5, 0x1

    array-length v12, v2

    if-lt v11, v12, :cond_6

    .line 315
    const/16 v11, 0x8

    invoke-static {v2, v11}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([II)[I

    move-result-object v2

    .line 318
    :cond_6
    move v11, v3

    .local v11, "j":I
    :goto_4
    if-ge v11, v5, :cond_8

    .line 319
    aget v12, v2, v11

    if-ne v12, v8, :cond_7

    .line 320
    add-int/lit8 v12, v11, 0x1

    aget v10, v2, v12

    .line 321
    aget-object v12, v1, v10

    invoke-virtual {v12, v7}, Lcom/fasterxml/aalto/in/PName;->boundEquals(Lcom/fasterxml/aalto/in/PName;)Z

    move-result v12

    if-eqz v12, :cond_7

    .line 322
    iget-object v12, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_errorMsg:Ljava/lang/String;

    if-nez v12, :cond_8

    .line 323
    invoke-direct {p0, v10, v6}, Lcom/fasterxml/aalto/in/AttributeCollector;->noteDupAttr(II)V

    goto :goto_5

    .line 318
    :cond_7
    add-int/lit8 v11, v11, 0x2

    goto :goto_4

    .line 329
    .end local v11    # "j":I
    :cond_8
    :goto_5
    add-int/lit8 v11, v5, 0x1

    .end local v5    # "spillIndex":I
    .local v11, "spillIndex":I
    aput v8, v2, v5

    .line 330
    add-int/lit8 v5, v11, 0x1

    .end local v11    # "spillIndex":I
    .restart local v5    # "spillIndex":I
    aput v6, v2, v11

    .line 289
    .end local v7    # "newName":Lcom/fasterxml/aalto/in/PName;
    .end local v8    # "hash":I
    .end local v9    # "index":I
    .end local v10    # "oldNameIndex":I
    :goto_6
    add-int/lit8 v6, v6, 0x1

    goto :goto_3

    .line 333
    .end local v6    # "i":I
    :cond_9
    iput v5, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_spillAreaEnd:I

    .line 335
    .end local v4    # "mask":I
    .end local v5    # "spillIndex":I
    iput-object v2, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrMap:[I

    .line 337
    iget-object v4, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_errorMsg:Ljava/lang/String;

    if-nez v4, :cond_a

    move v4, v0

    goto :goto_7

    :cond_a
    const/4 v4, -0x1

    :goto_7
    return v4
.end method

.method public final getCount()I
    .locals 1

    .line 358
    iget v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrCount:I

    return v0
.end method

.method public getErrorMsg()Ljava/lang/String;
    .locals 1

    .line 444
    iget-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_errorMsg:Ljava/lang/String;

    return-object v0
.end method

.method public final getName(I)Lcom/fasterxml/aalto/in/PName;
    .locals 1
    .param p1, "index"    # I

    .line 360
    iget-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_names:[Lcom/fasterxml/aalto/in/PName;

    aget-object v0, v0, p1

    return-object v0
.end method

.method public final getQName(I)Ljavax/xml/namespace/QName;
    .locals 1
    .param p1, "index"    # I

    .line 364
    iget-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_names:[Lcom/fasterxml/aalto/in/PName;

    aget-object v0, v0, p1

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->constructQName()Ljavax/xml/namespace/QName;

    move-result-object v0

    return-object v0
.end method

.method public getValue(I)Ljava/lang/String;
    .locals 6
    .param p1, "index"    # I

    .line 369
    iget v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrCount:I

    .line 374
    .local v0, "count":I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_allAttrValues:Ljava/lang/String;

    const-string v2, ""

    const/4 v3, 0x0

    if-nez v1, :cond_1

    .line 375
    iget-object v1, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueOffsets:[I

    add-int/lit8 v4, v0, -0x1

    aget v1, v1, v4

    .line 376
    .local v1, "len":I
    if-nez v1, :cond_0

    move-object v4, v2

    goto :goto_0

    :cond_0
    new-instance v4, Ljava/lang/String;

    iget-object v5, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueBuffer:[C

    invoke-direct {v4, v5, v3, v1}, Ljava/lang/String;-><init>([CII)V

    :goto_0
    iput-object v4, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_allAttrValues:Ljava/lang/String;

    .line 378
    .end local v1    # "len":I
    :cond_1
    if-nez p1, :cond_4

    .line 379
    const/4 v1, 0x1

    if-ne v0, v1, :cond_2

    .line 380
    iget-object v1, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_allAttrValues:Ljava/lang/String;

    return-object v1

    .line 382
    :cond_2
    iget-object v1, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueOffsets:[I

    aget v1, v1, v3

    .line 383
    .restart local v1    # "len":I
    if-nez v1, :cond_3

    goto :goto_1

    :cond_3
    iget-object v2, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_allAttrValues:Ljava/lang/String;

    invoke-virtual {v2, v3, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    :goto_1
    return-object v2

    .line 388
    .end local v1    # "len":I
    :cond_4
    iget-object v1, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueOffsets:[I

    add-int/lit8 v3, p1, -0x1

    aget v1, v1, v3

    .line 389
    .local v1, "start":I
    iget-object v3, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueOffsets:[I

    aget v3, v3, p1

    .line 390
    .local v3, "end":I
    if-ne v1, v3, :cond_5

    goto :goto_2

    :cond_5
    iget-object v2, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_allAttrValues:Ljava/lang/String;

    invoke-virtual {v2, v1, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    :goto_2
    return-object v2
.end method

.method public getValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "nsUri"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 395
    invoke-virtual {p0, p1, p2}, Lcom/fasterxml/aalto/in/AttributeCollector;->findIndex(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 396
    .local v0, "ix":I
    if-ltz v0, :cond_0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/AttributeCollector;->getValue(I)Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return-object v1
.end method

.method public startNewValue(Lcom/fasterxml/aalto/in/PName;I)[C
    .locals 8
    .param p1, "attrName"    # Lcom/fasterxml/aalto/in/PName;
    .param p2, "currOffset"    # I

    .line 165
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_needToResetValues:Z

    if-eqz v0, :cond_0

    .line 166
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_needToResetValues:Z

    .line 167
    move v1, v0

    .local v1, "count":I
    iput v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrCount:I

    .line 168
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_allAttrValues:Ljava/lang/String;

    .line 169
    iget-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueBuffer:[C

    if-nez v0, :cond_2

    .line 170
    const/16 v0, 0xc

    new-array v2, v0, [Lcom/fasterxml/aalto/in/PName;

    iput-object v2, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_names:[Lcom/fasterxml/aalto/in/PName;

    .line 171
    const/16 v2, 0x78

    new-array v2, v2, [C

    iput-object v2, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueBuffer:[C

    .line 172
    new-array v0, v0, [I

    iput-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueOffsets:[I

    goto :goto_1

    .line 176
    .end local v1    # "count":I
    :cond_0
    iget v1, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrCount:I

    .line 177
    .restart local v1    # "count":I
    iget-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueOffsets:[I

    array-length v0, v0

    if-lt v1, v0, :cond_1

    .line 178
    iget-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueOffsets:[I

    .line 179
    .local v0, "oldVal":[I
    iget-object v2, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_names:[Lcom/fasterxml/aalto/in/PName;

    .line 180
    .local v2, "oldNames":[Lcom/fasterxml/aalto/in/PName;
    array-length v3, v0

    .line 181
    .local v3, "oldLen":I
    add-int v4, v3, v3

    .line 182
    .local v4, "newLen":I
    new-array v5, v4, [I

    iput-object v5, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueOffsets:[I

    .line 183
    new-array v5, v4, [Lcom/fasterxml/aalto/in/PName;

    iput-object v5, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_names:[Lcom/fasterxml/aalto/in/PName;

    .line 184
    const/4 v5, 0x0

    .local v5, "i":I
    :goto_0
    if-ge v5, v3, :cond_1

    .line 185
    iget-object v6, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueOffsets:[I

    aget v7, v0, v5

    aput v7, v6, v5

    .line 186
    iget-object v6, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_names:[Lcom/fasterxml/aalto/in/PName;

    aget-object v7, v2, v5

    aput-object v7, v6, v5

    .line 184
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 189
    .end local v0    # "oldVal":[I
    .end local v2    # "oldNames":[Lcom/fasterxml/aalto/in/PName;
    .end local v3    # "oldLen":I
    .end local v4    # "newLen":I
    .end local v5    # "i":I
    :cond_1
    if-lez v1, :cond_2

    .line 190
    iget-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueOffsets:[I

    add-int/lit8 v2, v1, -0x1

    aput p2, v0, v2

    .line 193
    :cond_2
    :goto_1
    iget-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_names:[Lcom/fasterxml/aalto/in/PName;

    aput-object p1, v0, v1

    .line 194
    iget v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrCount:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_attrCount:I

    .line 195
    iget-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueBuffer:[C

    return-object v0
.end method

.method public valueBufferFull()[C
    .locals 2

    .line 348
    iget-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueBuffer:[C

    iget-object v1, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueBuffer:[C

    array-length v1, v1

    invoke-static {v0, v1}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueBuffer:[C

    .line 349
    iget-object v0, p0, Lcom/fasterxml/aalto/in/AttributeCollector;->_valueBuffer:[C

    return-object v0
.end method
