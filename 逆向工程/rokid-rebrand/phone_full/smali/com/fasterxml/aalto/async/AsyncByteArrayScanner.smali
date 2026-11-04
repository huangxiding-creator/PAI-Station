.class public Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;
.super Lcom/fasterxml/aalto/async/AsyncByteScanner;
.source "AsyncByteArrayScanner.java"

# interfaces
.implements Lcom/fasterxml/aalto/AsyncByteArrayFeeder;


# instance fields
.field protected _inputBuffer:[B

.field protected _origBufferLen:I


# direct methods
.method public constructor <init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V
    .locals 1
    .param p1, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;

    .line 61
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V

    .line 63
    const/4 v0, 0x1

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 64
    const/16 v0, 0x101

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    .line 65
    return-void
.end method

.method private finishStartElement(Z)I
    .locals 6
    .param p1, "emptyTag"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1848
    iput-boolean p1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_isEmptyTag:Z

    .line 1851
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/AttributeCollector;->finishLastValue(I)I

    move-result v0

    .line 1852
    .local v0, "act":I
    if-gez v0, :cond_0

    .line 1853
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/AttributeCollector;->getCount()I

    move-result v0

    .line 1854
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/AttributeCollector;->getErrorMsg()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1856
    :cond_0
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_attrCount:I

    .line 1857
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_depth:I

    const/4 v2, 0x1

    add-int/2addr v1, v2

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_depth:I

    .line 1863
    iget-boolean v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAllNsBound:Z

    if-nez v1, :cond_3

    .line 1864
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/PName;->isBound()Z

    move-result v1

    if-nez v1, :cond_1

    .line 1865
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    const/4 v3, 0x0

    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportUnboundPrefix(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 1867
    :cond_1
    const/4 v1, 0x0

    .local v1, "i":I
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_attrCount:I

    .local v3, "len":I
    :goto_0
    if-ge v1, v3, :cond_3

    .line 1868
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v4, v1}, Lcom/fasterxml/aalto/in/AttributeCollector;->getName(I)Lcom/fasterxml/aalto/in/PName;

    move-result-object v4

    .line 1869
    .local v4, "attrName":Lcom/fasterxml/aalto/in/PName;
    invoke-virtual {v4}, Lcom/fasterxml/aalto/in/PName;->isBound()Z

    move-result v5

    if-nez v5, :cond_2

    .line 1870
    invoke-virtual {p0, v4, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportUnboundPrefix(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 1867
    .end local v4    # "attrName":Lcom/fasterxml/aalto/in/PName;
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1875
    .end local v1    # "i":I
    .end local v3    # "len":I
    :cond_3
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    return v2
.end method

.method private final handleAndAppendPending()Z
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2468
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    const/4 v2, 0x0

    if-lt v0, v1, :cond_0

    .line 2469
    return v2

    .line 2471
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2472
    .local v0, "c":I
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2475
    const/4 v1, 0x1

    if-gez v0, :cond_3

    .line 2476
    const/4 v3, -0x1

    if-ne v0, v3, :cond_2

    .line 2477
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v2, v2, v3

    const/16 v3, 0xa

    if-ne v2, v3, :cond_1

    .line 2478
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v2, v1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2480
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    .line 2481
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->append(C)V

    .line 2482
    return v1

    .line 2484
    :cond_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInternal()I

    .line 2489
    :cond_3
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v3, v3, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    and-int/lit16 v4, v0, 0xff

    aget v3, v3, v4

    packed-switch v3, :pswitch_data_0

    .line 2549
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInternal()I

    goto/16 :goto_2

    .line 2515
    :pswitch_0
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v3, v3, v4

    and-int/lit16 v3, v3, 0xff

    .line 2517
    .local v3, "next":I
    shr-int/lit8 v4, v0, 0x8

    if-nez v4, :cond_6

    .line 2518
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v5, :cond_4

    .line 2519
    shl-int/lit8 v1, v3, 0x8

    or-int/2addr v1, v0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2520
    return v2

    .line 2522
    :cond_4
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v4, v5

    and-int/lit16 v4, v4, 0xff

    .line 2523
    .local v4, "c2":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v5, v6, :cond_5

    .line 2524
    shl-int/lit8 v1, v3, 0x8

    or-int/2addr v1, v0

    shl-int/lit8 v5, v4, 0x10

    or-int/2addr v1, v5

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2525
    return v2

    .line 2527
    :cond_5
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v2, v2, v5

    and-int/lit16 v2, v2, 0xff

    .line 2528
    .local v2, "c3":I
    invoke-virtual {p0, v0, v3, v4, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_4(IIII)I

    move-result v0

    .line 2529
    .end local v2    # "c3":I
    .end local v4    # "c2":I
    goto :goto_0

    .line 2530
    :cond_6
    shr-int/lit8 v4, v0, 0x8

    and-int/lit16 v4, v4, 0xff

    .line 2531
    .restart local v4    # "c2":I
    shr-int/lit8 v5, v0, 0x10

    .line 2533
    .local v5, "c3":I
    if-nez v5, :cond_8

    .line 2534
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v6, v7, :cond_7

    .line 2535
    shl-int/lit8 v1, v3, 0x10

    or-int/2addr v1, v0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2536
    return v2

    .line 2538
    :cond_7
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v2, v2, v6

    and-int/lit16 v2, v2, 0xff

    .line 2539
    .end local v5    # "c3":I
    .restart local v2    # "c3":I
    and-int/lit16 v5, v0, 0xff

    invoke-virtual {p0, v5, v4, v3, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_4(IIII)I

    move-result v0

    goto :goto_0

    .line 2541
    .end local v2    # "c3":I
    .restart local v5    # "c3":I
    :cond_8
    and-int/lit16 v2, v0, 0xff

    invoke-virtual {p0, v2, v4, v5, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_4(IIII)I

    move-result v0

    .line 2546
    .end local v3    # "next":I
    .end local v4    # "c2":I
    .end local v5    # "c3":I
    :goto_0
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2, v0}, Lcom/fasterxml/aalto/util/TextBuilder;->appendSurrogate(I)V

    .line 2547
    goto :goto_2

    .line 2498
    :pswitch_1
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v3, v3, v4

    and-int/lit16 v3, v3, 0xff

    .line 2499
    .restart local v3    # "next":I
    shr-int/lit8 v4, v0, 0x8

    .line 2500
    .restart local v4    # "c2":I
    if-nez v4, :cond_a

    .line 2501
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v5, v6, :cond_9

    .line 2502
    shl-int/lit8 v1, v3, 0x8

    or-int/2addr v1, v0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2503
    return v2

    .line 2505
    :cond_9
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v2, v2, v5

    and-int/lit16 v2, v2, 0xff

    .line 2506
    .restart local v2    # "c3":I
    invoke-virtual {p0, v0, v3, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_3(III)I

    move-result v0

    .line 2507
    .end local v2    # "c3":I
    goto :goto_1

    .line 2508
    :cond_a
    and-int/lit16 v2, v0, 0xff

    invoke-virtual {p0, v2, v4, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_3(III)I

    move-result v0

    .line 2510
    :goto_1
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    int-to-char v5, v0

    invoke-virtual {v2, v5}, Lcom/fasterxml/aalto/util/TextBuilder;->append(C)V

    .line 2512
    .end local v3    # "next":I
    .end local v4    # "c2":I
    goto :goto_2

    .line 2492
    :pswitch_2
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_2(I)I

    move-result v3

    int-to-char v3, v3

    invoke-virtual {v2, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->append(C)V

    .line 2493
    nop

    .line 2551
    :goto_2
    return v1

    :pswitch_data_0
    .packed-switch 0x5
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private final handleAttrValuePending()Z
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3127
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    const/4 v1, -0x1

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-ne v0, v1, :cond_2

    .line 3128
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handlePartialCR()Z

    move-result v0

    if-nez v0, :cond_0

    .line 3129
    return v2

    .line 3131
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/AttributeCollector;->continueValue()[C

    move-result-object v0

    .line 3132
    .local v0, "attrBuffer":[C
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    array-length v2, v0

    if-lt v1, v2, :cond_1

    .line 3133
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/AttributeCollector;->valueBufferFull()[C

    move-result-object v0

    .line 3136
    :cond_1
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    const/16 v2, 0x20

    aput-char v2, v0, v1

    .line 3137
    return v3

    .line 3140
    .end local v0    # "attrBuffer":[C
    :cond_2
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v1, :cond_3

    .line 3141
    return v2

    .line 3145
    :cond_3
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    const/16 v1, -0x3c

    const/16 v4, -0x3f

    const/16 v5, 0x78

    const/16 v6, -0x3d

    const/16 v7, -0x3e

    if-ne v0, v1, :cond_a

    .line 3146
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v8, v1, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 3147
    .local v0, "b":B
    const/16 v1, 0x23

    if-ne v0, v1, :cond_7

    .line 3148
    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3149
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v1, v4, :cond_4

    .line 3150
    return v2

    .line 3152
    :cond_4
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v4

    if-ne v1, v5, :cond_6

    .line 3153
    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3154
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v1, v3

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 3155
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v1, v4, :cond_5

    .line 3156
    return v2

    .line 3158
    :cond_5
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleHexEntityInAttribute(Z)I

    move-result v1

    .local v1, "ch":I
    goto :goto_0

    .line 3160
    .end local v1    # "ch":I
    :cond_6
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleDecEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_0

    .line 3163
    .end local v1    # "ch":I
    :cond_7
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parseNewEntityName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    .line 3164
    .local v1, "entityName":Lcom/fasterxml/aalto/in/PName;
    if-nez v1, :cond_8

    .line 3165
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3166
    return v2

    .line 3168
    :cond_8
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeGeneralEntity(Lcom/fasterxml/aalto/in/PName;)I

    move-result v4

    .line 3169
    .local v4, "ch":I
    if-nez v4, :cond_9

    .line 3170
    iput-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 3171
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p0, v5, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportUnexpandedEntityInAttr(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 3174
    .end local v0    # "b":B
    .end local v1    # "entityName":Lcom/fasterxml/aalto/in/PName;
    :cond_9
    move v1, v4

    .end local v4    # "ch":I
    .local v1, "ch":I
    :goto_0
    goto :goto_1

    .end local v1    # "ch":I
    :cond_a
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    if-ne v0, v6, :cond_d

    .line 3175
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    if-ne v0, v5, :cond_c

    .line 3176
    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3177
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v0, v3

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 3178
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v1, :cond_b

    .line 3179
    return v2

    .line 3181
    :cond_b
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleHexEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_1

    .line 3183
    .end local v1    # "ch":I
    :cond_c
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleDecEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_1

    .line 3185
    .end local v1    # "ch":I
    :cond_d
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    if-ne v0, v7, :cond_e

    .line 3186
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleHexEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_1

    .line 3187
    .end local v1    # "ch":I
    :cond_e
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    if-ne v0, v4, :cond_11

    .line 3188
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parseEntityName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    .line 3189
    .local v0, "entityName":Lcom/fasterxml/aalto/in/PName;
    if-nez v0, :cond_f

    .line 3190
    return v2

    .line 3192
    :cond_f
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeGeneralEntity(Lcom/fasterxml/aalto/in/PName;)I

    move-result v1

    .line 3193
    .restart local v1    # "ch":I
    if-nez v1, :cond_10

    .line 3194
    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 3195
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p0, v4, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportUnexpandedEntityInAttr(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 3197
    .end local v0    # "entityName":Lcom/fasterxml/aalto/in/PName;
    :cond_10
    goto :goto_1

    .end local v1    # "ch":I
    :cond_11
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    const/16 v1, -0x40

    if-ne v0, v1, :cond_12

    .line 3198
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleDecEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_1

    .line 3199
    .end local v1    # "ch":I
    :cond_12
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    const/16 v1, -0x41

    if-ne v0, v1, :cond_13

    .line 3200
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleHexEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_1

    .line 3204
    .end local v1    # "ch":I
    :cond_13
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleAttrValuePendingUTF8()I

    move-result v1

    .line 3206
    .restart local v1    # "ch":I
    :goto_1
    if-nez v1, :cond_14

    .line 3207
    return v2

    .line 3210
    :cond_14
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/AttributeCollector;->continueValue()[C

    move-result-object v0

    .line 3212
    .local v0, "attrBuffer":[C
    shr-int/lit8 v2, v1, 0x10

    if-eqz v2, :cond_16

    .line 3213
    const/high16 v2, 0x10000

    sub-int/2addr v1, v2

    .line 3214
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    array-length v4, v0

    if-lt v2, v4, :cond_15

    .line 3215
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/in/AttributeCollector;->valueBufferFull()[C

    move-result-object v0

    .line 3217
    :cond_15
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    shr-int/lit8 v4, v1, 0xa

    const v5, 0xd800

    or-int/2addr v4, v5

    int-to-char v4, v4

    aput-char v4, v0, v2

    .line 3218
    and-int/lit16 v2, v1, 0x3ff

    const v4, 0xdc00

    or-int v1, v2, v4

    .line 3220
    :cond_16
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    array-length v4, v0

    if-lt v2, v4, :cond_17

    .line 3221
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/in/AttributeCollector;->valueBufferFull()[C

    move-result-object v0

    .line 3223
    :cond_17
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    int-to-char v4, v1

    aput-char v4, v0, v2

    .line 3224
    return v3
.end method

.method private final handleAttrValuePendingUTF8()I
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3230
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3231
    .local v0, "c":I
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3234
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v2, v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    and-int/lit16 v3, v0, 0xff

    aget v2, v2, v3

    packed-switch v2, :pswitch_data_0

    .line 3289
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInternal()I

    .line 3290
    return v1

    .line 3257
    :pswitch_0
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v2, v2, v3

    and-int/lit16 v2, v2, 0xff

    .line 3259
    .local v2, "next":I
    shr-int/lit8 v3, v0, 0x8

    if-nez v3, :cond_2

    .line 3260
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v3, v4, :cond_0

    .line 3261
    shl-int/lit8 v3, v2, 0x8

    or-int/2addr v3, v0

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3262
    return v1

    .line 3264
    :cond_0
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v3, v3, v4

    and-int/lit16 v3, v3, 0xff

    .line 3265
    .local v3, "c2":I
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v5, :cond_1

    .line 3266
    shl-int/lit8 v4, v2, 0x8

    or-int/2addr v4, v0

    shl-int/lit8 v5, v3, 0x10

    or-int/2addr v4, v5

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3267
    return v1

    .line 3269
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v4

    and-int/lit16 v1, v1, 0xff

    .line 3270
    .local v1, "c3":I
    invoke-virtual {p0, v0, v2, v3, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_4(IIII)I

    move-result v0

    .line 3271
    .end local v1    # "c3":I
    .end local v3    # "c2":I
    goto :goto_0

    .line 3272
    :cond_2
    shr-int/lit8 v3, v0, 0x8

    and-int/lit16 v3, v3, 0xff

    .line 3273
    .restart local v3    # "c2":I
    shr-int/lit8 v4, v0, 0x10

    .line 3275
    .local v4, "c3":I
    if-nez v4, :cond_4

    .line 3276
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v5, v6, :cond_3

    .line 3277
    shl-int/lit8 v5, v2, 0x10

    or-int/2addr v5, v0

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3278
    return v1

    .line 3280
    :cond_3
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v5

    and-int/lit16 v1, v1, 0xff

    .line 3281
    .end local v4    # "c3":I
    .restart local v1    # "c3":I
    and-int/lit16 v4, v0, 0xff

    invoke-virtual {p0, v4, v3, v2, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_4(IIII)I

    move-result v0

    goto :goto_0

    .line 3283
    .end local v1    # "c3":I
    .restart local v4    # "c3":I
    :cond_4
    and-int/lit16 v1, v0, 0xff

    invoke-virtual {p0, v1, v3, v4, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_4(IIII)I

    move-result v0

    .line 3286
    .end local v3    # "c2":I
    .end local v4    # "c3":I
    :goto_0
    return v0

    .line 3241
    .end local v2    # "next":I
    :pswitch_1
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v2, v2, v3

    and-int/lit16 v2, v2, 0xff

    .line 3242
    .restart local v2    # "next":I
    shr-int/lit8 v3, v0, 0x8

    .line 3243
    .restart local v3    # "c2":I
    if-nez v3, :cond_6

    .line 3244
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v5, :cond_5

    .line 3245
    shl-int/lit8 v4, v2, 0x8

    or-int/2addr v4, v0

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3246
    return v1

    .line 3248
    :cond_5
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v4

    and-int/lit16 v1, v1, 0xff

    .line 3249
    .restart local v1    # "c3":I
    invoke-virtual {p0, v0, v2, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_3(III)I

    move-result v0

    .line 3250
    .end local v1    # "c3":I
    goto :goto_1

    .line 3251
    :cond_6
    and-int/lit16 v1, v0, 0xff

    invoke-virtual {p0, v1, v3, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_3(III)I

    move-result v0

    .line 3253
    :goto_1
    return v0

    .line 3237
    .end local v2    # "next":I
    .end local v3    # "c2":I
    :pswitch_2
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_2(I)I

    move-result v1

    return v1

    nop

    :pswitch_data_0
    .packed-switch 0x5
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private handleCData()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1125
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 1126
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parseCDataContents()I

    move-result v0

    return v0

    .line 1128
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v1, :cond_1

    .line 1129
    const/16 v0, 0x101

    return v0

    .line 1131
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleCDataStartMarker(B)I

    move-result v0

    return v0
.end method

.method private handleCDataStartMarker(B)I
    .locals 6
    .param p1, "b"    # B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1136
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    const-string v1, " (expected \'A\' for CDATA)"

    const/16 v2, 0x41

    const/16 v3, 0x101

    packed-switch v0, :pswitch_data_0

    .line 1198
    :pswitch_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInternal()I

    move-result v0

    return v0

    .line 1138
    :pswitch_1
    const/16 v0, 0x43

    if-eq p1, v0, :cond_0

    .line 1139
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v0

    const-string v4, " (expected \'C\' for CDATA)"

    invoke-virtual {p0, v0, v4}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 1141
    :cond_0
    const/4 v0, 0x2

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1142
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v4, :cond_1

    .line 1143
    return v3

    .line 1145
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte p1, v0, v4

    .line 1148
    :pswitch_2
    const/16 v0, 0x44

    if-eq p1, v0, :cond_2

    .line 1149
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v0

    const-string v4, " (expected \'D\' for CDATA)"

    invoke-virtual {p0, v0, v4}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 1151
    :cond_2
    const/4 v0, 0x3

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1152
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v4, :cond_3

    .line 1153
    return v3

    .line 1155
    :cond_3
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte p1, v0, v4

    .line 1158
    :pswitch_3
    if-eq p1, v2, :cond_4

    .line 1159
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v0

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 1161
    :cond_4
    const/4 v0, 0x4

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1162
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v4, :cond_5

    .line 1163
    return v3

    .line 1165
    :cond_5
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte p1, v0, v4

    .line 1168
    :pswitch_4
    const/16 v0, 0x54

    if-eq p1, v0, :cond_6

    .line 1169
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v0

    const-string v4, " (expected \'T\' for CDATA)"

    invoke-virtual {p0, v0, v4}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 1171
    :cond_6
    const/4 v0, 0x5

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1172
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v4, :cond_7

    .line 1173
    return v3

    .line 1175
    :cond_7
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte p1, v0, v4

    .line 1178
    :pswitch_5
    if-eq p1, v2, :cond_8

    .line 1179
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v0

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 1181
    :cond_8
    const/4 v0, 0x6

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1182
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v1, :cond_9

    .line 1183
    return v3

    .line 1185
    :cond_9
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte p1, v0, v1

    .line 1188
    :pswitch_6
    const/16 v0, 0x5b

    if-eq p1, v0, :cond_a

    .line 1189
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v0

    const-string v1, " (expected \'[\' for CDATA)"

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 1191
    :cond_a
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    .line 1192
    const/4 v0, 0x1

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1193
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v1, :cond_b

    .line 1194
    return v3

    .line 1196
    :cond_b
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parseCDataContents()I

    move-result v0

    return v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
    .end packed-switch
.end method

.method private final handleDecEntityInAttribute(Z)I
    .locals 8
    .param p1, "starting"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3296
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 3297
    .local v0, "b":B
    const-string v1, " expected a digit (0 - 9) for character entity"

    const/4 v2, 0x0

    if-eqz p1, :cond_3

    .line 3298
    move v3, v0

    .line 3299
    .local v3, "ch":I
    const/16 v4, 0x30

    if-lt v3, v4, :cond_0

    const/16 v4, 0x39

    if-le v3, v4, :cond_1

    .line 3300
    :cond_0
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v4

    invoke-virtual {p0, v4, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 3302
    :cond_1
    const/16 v4, -0x40

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3303
    add-int/lit8 v4, v3, -0x30

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_entityValue:I

    .line 3304
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v5, :cond_2

    .line 3305
    return v2

    .line 3307
    :cond_2
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v4, v5

    .line 3309
    .end local v3    # "ch":I
    :cond_3
    :goto_0
    const/16 v3, 0x3b

    if-eq v0, v3, :cond_8

    .line 3310
    add-int/lit8 v3, v0, -0x30

    .line 3311
    .restart local v3    # "ch":I
    if-ltz v3, :cond_4

    const/16 v4, 0x9

    if-le v3, v4, :cond_5

    .line 3312
    :cond_4
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v4

    invoke-virtual {p0, v4, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 3314
    :cond_5
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_entityValue:I

    mul-int/lit8 v4, v4, 0xa

    add-int/2addr v4, v3

    .line 3315
    .local v4, "value":I
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_entityValue:I

    .line 3316
    const v5, 0x10ffff

    if-le v4, v5, :cond_6

    .line 3317
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportEntityOverflow()V

    .line 3319
    :cond_6
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v5, v6, :cond_7

    .line 3320
    return v2

    .line 3322
    :cond_7
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v5, v6

    .line 3323
    .end local v3    # "ch":I
    .end local v4    # "value":I
    goto :goto_0

    .line 3324
    :cond_8
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_entityValue:I

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->verifyXmlChar(I)V

    .line 3325
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3326
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_entityValue:I

    return v1
.end method

.method private handleEndElement()I
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1970
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    const/16 v1, 0x101

    const/4 v2, 0x1

    if-nez v0, :cond_7

    .line 1971
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 1972
    .local v0, "elemName":Lcom/fasterxml/aalto/in/PName;
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->sizeInQuads()I

    move-result v3

    sub-int/2addr v3, v2

    .line 1973
    .local v3, "quadSize":I
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadCount:I

    if-ge v4, v3, :cond_3

    .line 1974
    :goto_1
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuadBytes:I

    const/4 v5, 0x4

    if-ge v4, v5, :cond_1

    .line 1975
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v5, :cond_0

    .line 1976
    return v1

    .line 1978
    :cond_0
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuad:I

    shl-int/lit8 v4, v4, 0x8

    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v5, v5, v6

    and-int/lit16 v5, v5, 0xff

    or-int/2addr v4, v5

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuad:I

    .line 1974
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuadBytes:I

    add-int/2addr v4, v2

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuadBytes:I

    goto :goto_1

    .line 1981
    :cond_1
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuad:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadCount:I

    invoke-virtual {v0, v5}, Lcom/fasterxml/aalto/in/PName;->getQuad(I)I

    move-result v5

    if-eq v4, v5, :cond_2

    .line 1982
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportUnexpectedEndTag(Ljava/lang/String;)V

    .line 1984
    :cond_2
    const/4 v4, 0x0

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuadBytes:I

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuad:I

    .line 1973
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadCount:I

    add-int/2addr v4, v2

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadCount:I

    goto :goto_0

    .line 1987
    :cond_3
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getLastQuad()I

    move-result v4

    .line 1990
    .local v4, "lastQ":I
    :goto_2
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v5, v6, :cond_4

    .line 1991
    return v1

    .line 1993
    :cond_4
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuad:I

    shl-int/lit8 v5, v5, 0x8

    .line 1994
    .local v5, "q":I
    iget-object v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v6, v6, v7

    and-int/lit16 v6, v6, 0xff

    or-int/2addr v5, v6

    .line 1995
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuad:I

    .line 1996
    if-ne v5, v4, :cond_5

    .line 1997
    goto :goto_3

    .line 1999
    :cond_5
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuadBytes:I

    add-int/2addr v6, v2

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuadBytes:I

    const/4 v7, 0x3

    if-le v6, v7, :cond_6

    .line 2000
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportUnexpectedEndTag(Ljava/lang/String;)V

    .line 2001
    nop

    .line 2005
    .end local v5    # "q":I
    :goto_3
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .end local v0    # "elemName":Lcom/fasterxml/aalto/in/PName;
    .end local v3    # "quadSize":I
    .end local v4    # "lastQ":I
    goto :goto_4

    .line 2003
    .restart local v0    # "elemName":Lcom/fasterxml/aalto/in/PName;
    .restart local v3    # "quadSize":I
    .restart local v4    # "lastQ":I
    :cond_6
    goto :goto_2

    .line 2006
    .end local v0    # "elemName":Lcom/fasterxml/aalto/in/PName;
    .end local v3    # "quadSize":I
    .end local v4    # "lastQ":I
    :cond_7
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    if-eq v0, v2, :cond_8

    .line 2007
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInternal()I

    goto :goto_5

    .line 2006
    :cond_8
    :goto_4
    nop

    .line 2010
    :goto_5
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    if-eqz v0, :cond_9

    .line 2011
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handlePartialCR()Z

    move-result v0

    if-nez v0, :cond_9

    .line 2012
    return v1

    .line 2019
    :cond_9
    :goto_6
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v3, :cond_a

    .line 2020
    return v1

    .line 2022
    :cond_a
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v3

    and-int/lit16 v0, v0, 0xff

    .line 2023
    .local v0, "i2":I
    const/16 v3, 0x20

    if-gt v0, v3, :cond_f

    .line 2024
    const/16 v4, 0xa

    if-ne v0, v4, :cond_b

    .line 2025
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    goto :goto_6

    .line 2026
    :cond_b
    const/16 v5, 0xd

    if-ne v0, v5, :cond_e

    .line 2027
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v3, v5, :cond_c

    .line 2028
    const/4 v2, -0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2029
    return v1

    .line 2031
    :cond_c
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v3, v3, v5

    if-ne v3, v4, :cond_d

    .line 2032
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v3, v2

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2034
    :cond_d
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    goto :goto_6

    .line 2035
    :cond_e
    if-eq v0, v3, :cond_9

    const/16 v3, 0x9

    if-eq v0, v3, :cond_9

    .line 2036
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInvalidSpace(I)V

    goto :goto_6

    .line 2041
    :cond_f
    const/16 v1, 0x3e

    if-eq v0, v1, :cond_10

    .line 2042
    int-to-byte v1, v0

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v1

    const-string v2, " expected space or closing \'>\'"

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 2045
    :cond_10
    const/4 v1, 0x2

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    return v1
.end method

.method private handleEndElementStart()I
    .locals 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1880
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_depth:I

    const/4 v1, 0x1

    sub-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_depth:I

    .line 1881
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currElem:Lcom/fasterxml/aalto/in/ElementScope;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ElementScope;->getName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 1887
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->sizeInQuads()I

    move-result v0

    .line 1888
    .local v0, "size":I
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v2, v3

    shl-int/lit8 v3, v0, 0x2

    add-int/2addr v3, v1

    const/4 v4, 0x2

    if-ge v2, v3, :cond_0

    .line 1889
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    .line 1890
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1891
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuadBytes:I

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuad:I

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadCount:I

    .line 1895
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleEndElement()I

    move-result v1

    return v1

    .line 1897
    :cond_0
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    .line 1900
    .local v2, "buf":[B
    const/4 v3, -0x1

    add-int/2addr v0, v3

    .line 1901
    const/4 v5, 0x0

    .local v5, "qix":I
    :goto_0
    if-ge v5, v0, :cond_2

    .line 1902
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 1903
    .local v6, "ptr":I
    aget-byte v7, v2, v6

    shl-int/lit8 v7, v7, 0x18

    add-int/lit8 v8, v6, 0x1

    aget-byte v8, v2, v8

    and-int/lit16 v8, v8, 0xff

    shl-int/lit8 v8, v8, 0x10

    or-int/2addr v7, v8

    add-int/lit8 v8, v6, 0x2

    aget-byte v8, v2, v8

    and-int/lit16 v8, v8, 0xff

    shl-int/lit8 v8, v8, 0x8

    or-int/2addr v7, v8

    add-int/lit8 v8, v6, 0x3

    aget-byte v8, v2, v8

    and-int/lit16 v8, v8, 0xff

    or-int/2addr v7, v8

    .line 1908
    .local v7, "q":I
    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v8, v8, 0x4

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 1910
    iget-object v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v8, v5}, Lcom/fasterxml/aalto/in/PName;->getQuad(I)I

    move-result v8

    if-eq v7, v8, :cond_1

    .line 1911
    iget-object v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v8}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p0, v8}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportUnexpectedEndTag(Ljava/lang/String;)V

    .line 1901
    .end local v6    # "ptr":I
    .end local v7    # "q":I
    :cond_1
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 1918
    .end local v5    # "qix":I
    :cond_2
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v5, v0}, Lcom/fasterxml/aalto/in/PName;->getQuad(I)I

    move-result v5

    .line 1919
    .local v5, "lastQ":I
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v6, v2, v6

    and-int/lit16 v6, v6, 0xff

    .line 1920
    .local v6, "q":I
    if-eq v6, v5, :cond_3

    .line 1921
    shl-int/lit8 v7, v6, 0x8

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v8, v2, v8

    and-int/lit16 v8, v8, 0xff

    or-int v6, v7, v8

    .line 1922
    if-eq v6, v5, :cond_3

    .line 1923
    shl-int/lit8 v7, v6, 0x8

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v8, v2, v8

    and-int/lit16 v8, v8, 0xff

    or-int v6, v7, v8

    .line 1924
    if-eq v6, v5, :cond_3

    .line 1925
    shl-int/lit8 v7, v6, 0x8

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v8, v2, v8

    and-int/lit16 v8, v8, 0xff

    or-int v6, v7, v8

    .line 1926
    if-eq v6, v5, :cond_3

    .line 1927
    iget-object v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v7}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p0, v7}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportUnexpectedEndTag(Ljava/lang/String;)V

    .line 1933
    :cond_3
    iget-object v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v7, v7, v8

    and-int/lit16 v7, v7, 0xff

    .line 1934
    .local v7, "i2":I
    :goto_1
    const/16 v8, 0x20

    if-gt v7, v8, :cond_a

    .line 1935
    const/16 v9, 0x101

    const/16 v10, 0xa

    if-ne v7, v10, :cond_4

    .line 1936
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    goto :goto_2

    .line 1937
    :cond_4
    const/16 v11, 0xd

    if-ne v7, v11, :cond_7

    .line 1938
    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v11, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v8, v11, :cond_5

    .line 1939
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 1940
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    .line 1941
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1942
    return v9

    .line 1944
    :cond_5
    iget-object v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v11, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v8, v8, v11

    if-ne v8, v10, :cond_6

    .line 1945
    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v8, v1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 1947
    :cond_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    goto :goto_2

    .line 1948
    :cond_7
    if-eq v7, v8, :cond_8

    const/16 v8, 0x9

    if-eq v7, v8, :cond_8

    .line 1949
    invoke-virtual {p0, v7}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInvalidSpace(I)V

    .line 1951
    :cond_8
    :goto_2
    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v10, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v8, v10, :cond_9

    .line 1952
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    .line 1953
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1954
    return v9

    .line 1956
    :cond_9
    iget-object v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v10, v9, 0x1

    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v8, v8, v9

    and-int/lit16 v7, v8, 0xff

    goto :goto_1

    .line 1958
    :cond_a
    const/16 v1, 0x3e

    if-eq v7, v1, :cond_b

    .line 1959
    int-to-byte v1, v7

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v1

    const-string v3, " expected space or closing \'>\'"

    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1961
    :cond_b
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    return v4
.end method

.method private final handleHexEntityInAttribute(Z)I
    .locals 7
    .param p1, "starting"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3332
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 3333
    .local v0, "b":B
    move v1, p1

    .line 3334
    .local v1, "firstLoop":Z
    :goto_0
    const/16 v2, 0x3b

    const/4 v3, 0x0

    if-eq v0, v2, :cond_6

    .line 3335
    move v2, v0

    .line 3336
    .local v2, "ch":I
    const/16 v4, 0x39

    if-gt v2, v4, :cond_0

    const/16 v4, 0x30

    if-lt v2, v4, :cond_0

    .line 3337
    add-int/lit8 v2, v2, -0x30

    goto :goto_1

    .line 3338
    :cond_0
    const/16 v4, 0x46

    if-gt v2, v4, :cond_1

    const/16 v4, 0x41

    if-lt v2, v4, :cond_1

    .line 3339
    add-int/lit8 v4, v2, -0x41

    add-int/lit8 v2, v4, 0xa

    goto :goto_1

    .line 3340
    :cond_1
    const/16 v4, 0x66

    if-gt v2, v4, :cond_2

    const/16 v4, 0x61

    if-lt v2, v4, :cond_2

    .line 3341
    add-int/lit8 v4, v2, -0x61

    add-int/lit8 v2, v4, 0xa

    goto :goto_1

    .line 3343
    :cond_2
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v4

    const-string v5, " expected a hex digit (0-9a-fA-F) for character entity"

    invoke-virtual {p0, v4, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 3345
    :goto_1
    move v4, v2

    .line 3346
    .local v4, "value":I
    if-eqz v1, :cond_3

    .line 3347
    const/16 v5, -0x41

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3348
    const/4 v1, 0x0

    goto :goto_2

    .line 3350
    :cond_3
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_entityValue:I

    shl-int/lit8 v5, v5, 0x4

    add-int/2addr v4, v5

    .line 3351
    const v5, 0x10ffff

    if-le v4, v5, :cond_4

    .line 3352
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportEntityOverflow()V

    .line 3355
    :cond_4
    :goto_2
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_entityValue:I

    .line 3356
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v5, v6, :cond_5

    .line 3357
    return v3

    .line 3359
    :cond_5
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v3, v5

    .line 3360
    .end local v2    # "ch":I
    .end local v4    # "value":I
    goto :goto_0

    .line 3361
    :cond_6
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_entityValue:I

    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->verifyXmlChar(I)V

    .line 3362
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3363
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_entityValue:I

    return v2
.end method

.method private final handleNsValuePending()Z
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3568
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    const/4 v1, -0x1

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-ne v0, v1, :cond_2

    .line 3569
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handlePartialCR()Z

    move-result v0

    if-nez v0, :cond_0

    .line 3570
    return v2

    .line 3572
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nameBuffer:[C

    .line 3573
    .local v0, "attrBuffer":[C
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    array-length v2, v0

    if-lt v1, v2, :cond_1

    .line 3574
    array-length v1, v0

    invoke-static {v0, v1}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v1

    move-object v0, v1

    iput-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nameBuffer:[C

    .line 3577
    :cond_1
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    const/16 v2, 0x20

    aput-char v2, v0, v1

    .line 3578
    return v3

    .line 3582
    .end local v0    # "attrBuffer":[C
    :cond_2
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v1, :cond_3

    .line 3583
    return v2

    .line 3588
    :cond_3
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    const/16 v1, -0x3c

    const/16 v4, -0x3f

    const/16 v5, 0x78

    const/16 v6, -0x3d

    const/16 v7, -0x3e

    if-ne v0, v1, :cond_a

    .line 3589
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v8, v1, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 3590
    .local v0, "b":B
    const/16 v1, 0x23

    if-ne v0, v1, :cond_7

    .line 3591
    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3592
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v1, v4, :cond_4

    .line 3593
    return v2

    .line 3595
    :cond_4
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v4

    if-ne v1, v5, :cond_6

    .line 3596
    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3597
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v1, v3

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 3598
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v1, v4, :cond_5

    .line 3599
    return v2

    .line 3601
    :cond_5
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleHexEntityInAttribute(Z)I

    move-result v1

    .local v1, "ch":I
    goto :goto_0

    .line 3603
    .end local v1    # "ch":I
    :cond_6
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleDecEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_0

    .line 3606
    .end local v1    # "ch":I
    :cond_7
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parseNewEntityName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    .line 3607
    .local v1, "entityName":Lcom/fasterxml/aalto/in/PName;
    if-nez v1, :cond_8

    .line 3608
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3609
    return v2

    .line 3611
    :cond_8
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeGeneralEntity(Lcom/fasterxml/aalto/in/PName;)I

    move-result v4

    .line 3612
    .local v4, "ch":I
    if-nez v4, :cond_9

    .line 3613
    iput-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 3614
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p0, v5, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportUnexpandedEntityInAttr(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 3617
    .end local v0    # "b":B
    .end local v1    # "entityName":Lcom/fasterxml/aalto/in/PName;
    :cond_9
    move v1, v4

    .end local v4    # "ch":I
    .local v1, "ch":I
    :goto_0
    goto :goto_1

    .end local v1    # "ch":I
    :cond_a
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    if-ne v0, v6, :cond_d

    .line 3618
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    if-ne v0, v5, :cond_c

    .line 3619
    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3620
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v0, v3

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 3621
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v1, :cond_b

    .line 3622
    return v2

    .line 3624
    :cond_b
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleHexEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_1

    .line 3626
    .end local v1    # "ch":I
    :cond_c
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleDecEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_1

    .line 3628
    .end local v1    # "ch":I
    :cond_d
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    if-ne v0, v7, :cond_e

    .line 3629
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleHexEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_1

    .line 3630
    .end local v1    # "ch":I
    :cond_e
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    if-ne v0, v4, :cond_11

    .line 3631
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parseEntityName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    .line 3632
    .local v0, "entityName":Lcom/fasterxml/aalto/in/PName;
    if-nez v0, :cond_f

    .line 3633
    return v2

    .line 3635
    :cond_f
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeGeneralEntity(Lcom/fasterxml/aalto/in/PName;)I

    move-result v1

    .line 3636
    .restart local v1    # "ch":I
    if-nez v1, :cond_10

    .line 3637
    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 3638
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p0, v4, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportUnexpandedEntityInAttr(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 3640
    .end local v0    # "entityName":Lcom/fasterxml/aalto/in/PName;
    :cond_10
    goto :goto_1

    .end local v1    # "ch":I
    :cond_11
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    const/16 v1, -0x40

    if-ne v0, v1, :cond_12

    .line 3641
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleDecEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_1

    .line 3642
    .end local v1    # "ch":I
    :cond_12
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    const/16 v1, -0x41

    if-ne v0, v1, :cond_13

    .line 3643
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleHexEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_1

    .line 3646
    .end local v1    # "ch":I
    :cond_13
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleAttrValuePendingUTF8()I

    move-result v1

    .line 3648
    .restart local v1    # "ch":I
    :goto_1
    if-nez v1, :cond_14

    .line 3649
    return v2

    .line 3652
    :cond_14
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nameBuffer:[C

    .line 3654
    .local v0, "attrBuffer":[C
    shr-int/lit8 v2, v1, 0x10

    if-eqz v2, :cond_16

    .line 3655
    const/high16 v2, 0x10000

    sub-int/2addr v1, v2

    .line 3656
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    array-length v4, v0

    if-lt v2, v4, :cond_15

    .line 3657
    array-length v2, v0

    invoke-static {v0, v2}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v2

    move-object v0, v2

    iput-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nameBuffer:[C

    .line 3659
    :cond_15
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    shr-int/lit8 v4, v1, 0xa

    const v5, 0xd800

    or-int/2addr v4, v5

    int-to-char v4, v4

    aput-char v4, v0, v2

    .line 3660
    and-int/lit16 v2, v1, 0x3ff

    const v4, 0xdc00

    or-int v1, v2, v4

    .line 3662
    :cond_16
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    array-length v4, v0

    if-lt v2, v4, :cond_17

    .line 3663
    array-length v2, v0

    invoke-static {v0, v2}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v2

    move-object v0, v2

    iput-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nameBuffer:[C

    .line 3665
    :cond_17
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    int-to-char v4, v1

    aput-char v4, v0, v2

    .line 3666
    return v3
.end method

.method private initAttribute(B)V
    .locals 6
    .param p1, "quoteChar"    # B

    .line 1809
    iput-byte p1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrQuote:B

    .line 1811
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    .line 1812
    .local v0, "attrName":Lcom/fasterxml/aalto/in/PName;
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getPrefix()Ljava/lang/String;

    move-result-object v1

    .line 1815
    .local v1, "prefix":Ljava/lang/String;
    const/4 v2, 0x1

    const/4 v3, 0x0

    const-string/jumbo v4, "xmlns"

    if-nez v1, :cond_1

    .line 1816
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getLocalName()Ljava/lang/String;

    move-result-object v5

    if-ne v5, v4, :cond_0

    move v4, v2

    goto :goto_0

    :cond_0
    move v4, v3

    .local v4, "nsDecl":Z
    :goto_0
    goto :goto_1

    .line 1819
    .end local v4    # "nsDecl":Z
    :cond_1
    if-ne v1, v4, :cond_2

    .line 1820
    const/4 v4, 0x1

    .restart local v4    # "nsDecl":Z
    goto :goto_1

    .line 1822
    .end local v4    # "nsDecl":Z
    :cond_2
    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->bindName(Lcom/fasterxml/aalto/in/PName;Ljava/lang/String;)Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    .line 1823
    iget-boolean v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAllNsBound:Z

    if-eqz v4, :cond_3

    .line 1824
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->isBound()Z

    move-result v4

    iput-boolean v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAllNsBound:Z

    .line 1826
    :cond_3
    const/4 v4, 0x0

    .line 1830
    .restart local v4    # "nsDecl":Z
    :goto_1
    if-eqz v4, :cond_4

    .line 1831
    const/16 v5, 0x8

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1833
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    .line 1834
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currNsCount:I

    add-int/2addr v3, v2

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currNsCount:I

    goto :goto_2

    .line 1836
    :cond_4
    const/4 v2, 0x7

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1838
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    invoke-virtual {v2, v0, v3}, Lcom/fasterxml/aalto/in/AttributeCollector;->startNewValue(Lcom/fasterxml/aalto/in/PName;I)[C

    .line 1840
    :goto_2
    return-void
.end method

.method private initStartElement(Lcom/fasterxml/aalto/in/PName;)V
    .locals 3
    .param p1, "elemName"    # Lcom/fasterxml/aalto/in/PName;

    .line 1792
    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/PName;->getPrefix()Ljava/lang/String;

    move-result-object v0

    .line 1793
    .local v0, "prefix":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 1794
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAllNsBound:Z

    goto :goto_0

    .line 1796
    :cond_0
    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->bindName(Lcom/fasterxml/aalto/in/PName;Ljava/lang/String;)Lcom/fasterxml/aalto/in/PName;

    move-result-object p1

    .line 1797
    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/PName;->isBound()Z

    move-result v1

    iput-boolean v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAllNsBound:Z

    .line 1799
    :goto_0
    iput-object p1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 1800
    new-instance v1, Lcom/fasterxml/aalto/in/ElementScope;

    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currElem:Lcom/fasterxml/aalto/in/ElementScope;

    invoke-direct {v1, p1, v2}, Lcom/fasterxml/aalto/in/ElementScope;-><init>(Lcom/fasterxml/aalto/in/PName;Lcom/fasterxml/aalto/in/ElementScope;)V

    iput-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currElem:Lcom/fasterxml/aalto/in/ElementScope;

    .line 1801
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_attrCount:I

    .line 1802
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currNsCount:I

    .line 1803
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    .line 1804
    const/4 v1, 0x2

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1805
    return-void
.end method

.method private skipEntityInCharacters()I
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2905
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2906
    .local v0, "ptr":I
    add-int/lit8 v1, v0, 0x3

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-gt v1, v2, :cond_8

    .line 2907
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v2, v0, 0x1

    .end local v0    # "ptr":I
    .local v2, "ptr":I
    aget-byte v0, v1, v0

    .line 2908
    .local v0, "b":B
    const/16 v1, 0x23

    if-ne v0, v1, :cond_1

    .line 2909
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    aget-byte v1, v1, v2

    const/16 v3, 0x78

    if-ne v1, v3, :cond_0

    .line 2910
    add-int/lit8 v1, v2, 0x1

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleHexEntityInCharacters(I)I

    move-result v1

    return v1

    .line 2912
    :cond_0
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleDecEntityInCharacters(I)I

    move-result v1

    return v1

    .line 2915
    :cond_1
    const/16 v1, 0x61

    const/16 v3, 0x27

    const/16 v4, 0x6f

    const/16 v5, 0x3b

    if-ne v0, v1, :cond_4

    .line 2916
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v6, v2, 0x1

    .end local v2    # "ptr":I
    .local v6, "ptr":I
    aget-byte v0, v1, v2

    .line 2917
    const/16 v1, 0x6d

    const/16 v2, 0x70

    if-ne v0, v1, :cond_2

    .line 2918
    add-int/lit8 v1, v6, 0x1

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-ge v1, v3, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    aget-byte v1, v1, v6

    if-ne v1, v2, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v2, v6, 0x1

    aget-byte v1, v1, v2

    if-ne v1, v5, :cond_3

    .line 2921
    add-int/lit8 v1, v6, 0x2

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2922
    const/16 v1, 0x26

    return v1

    .line 2924
    :cond_2
    if-ne v0, v2, :cond_3

    .line 2925
    add-int/lit8 v1, v6, 0x2

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-ge v1, v2, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    aget-byte v1, v1, v6

    if-ne v1, v4, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v2, v6, 0x1

    aget-byte v1, v1, v2

    const/16 v2, 0x73

    if-ne v1, v2, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v2, v6, 0x2

    aget-byte v1, v1, v2

    if-ne v1, v5, :cond_3

    .line 2929
    add-int/lit8 v1, v6, 0x3

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2930
    return v3

    .line 2957
    .end local v0    # "b":B
    :cond_3
    move v0, v6

    goto :goto_0

    .line 2933
    .end local v6    # "ptr":I
    .restart local v0    # "b":B
    .restart local v2    # "ptr":I
    :cond_4
    const/16 v1, 0x67

    const/16 v6, 0x74

    if-ne v0, v1, :cond_5

    .line 2934
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    aget-byte v1, v1, v2

    if-ne v1, v6, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v3, v2, 0x1

    aget-byte v1, v1, v3

    if-ne v1, v5, :cond_7

    .line 2936
    add-int/lit8 v1, v2, 0x2

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2937
    const/16 v1, 0x3e

    return v1

    .line 2939
    :cond_5
    const/16 v1, 0x6c

    if-ne v0, v1, :cond_6

    .line 2940
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    aget-byte v1, v1, v2

    if-ne v1, v6, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v3, v2, 0x1

    aget-byte v1, v1, v3

    if-ne v1, v5, :cond_7

    .line 2942
    add-int/lit8 v1, v2, 0x2

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2943
    const/16 v1, 0x3c

    return v1

    .line 2945
    :cond_6
    const/16 v1, 0x71

    if-ne v0, v1, :cond_7

    .line 2946
    add-int/lit8 v1, v2, 0x3

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-ge v1, v7, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    aget-byte v1, v1, v2

    const/16 v7, 0x75

    if-ne v1, v7, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v7, v2, 0x1

    aget-byte v1, v1, v7

    if-ne v1, v4, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v4, v2, 0x2

    aget-byte v1, v1, v4

    if-ne v1, v6, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v4, v2, 0x3

    aget-byte v1, v1, v4

    if-ne v1, v5, :cond_7

    .line 2951
    add-int/lit8 v1, v2, 0x4

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2952
    return v3

    .line 2957
    .end local v0    # "b":B
    :cond_7
    move v0, v2

    .end local v2    # "ptr":I
    .local v0, "ptr":I
    :cond_8
    :goto_0
    const/4 v1, 0x0

    return v1
.end method

.method private final skipPending()Z
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2708
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    const/4 v2, 0x0

    if-lt v0, v1, :cond_0

    .line 2709
    return v2

    .line 2713
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    const/4 v1, 0x1

    if-gez v0, :cond_10

    .line 2715
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    const/16 v3, 0x9

    const/16 v4, 0x5d

    sparse-switch v0, :sswitch_data_0

    .line 2816
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInternal()I

    goto/16 :goto_0

    .line 2717
    :sswitch_0
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2718
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v2

    const/16 v2, 0xa

    if-ne v0, v2, :cond_2

    .line 2719
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2721
    :cond_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    .line 2722
    return v1

    .line 2725
    :sswitch_1
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v4

    .line 2726
    .local v0, "b":B
    const/16 v4, 0x23

    if-ne v0, v4, :cond_3

    .line 2727
    const/16 v3, -0x51

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2728
    goto/16 :goto_0

    .line 2730
    :cond_3
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parseNewEntityName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v4

    .line 2731
    .local v4, "n":Lcom/fasterxml/aalto/in/PName;
    if-nez v4, :cond_4

    .line 2732
    const/16 v1, -0x54

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2733
    return v2

    .line 2735
    :cond_4
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeGeneralEntity(Lcom/fasterxml/aalto/in/PName;)I

    move-result v5

    .line 2736
    .local v5, "ch":I
    if-nez v5, :cond_5

    .line 2737
    iput-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 2738
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    .line 2741
    .end local v0    # "b":B
    .end local v4    # "n":Lcom/fasterxml/aalto/in/PName;
    .end local v5    # "ch":I
    :cond_5
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2742
    return v1

    .line 2744
    :sswitch_2
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_entityValue:I

    .line 2745
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v3

    const/16 v3, 0x78

    if-ne v0, v3, :cond_7

    .line 2746
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2747
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeHexEntity()Z

    move-result v0

    if-eqz v0, :cond_6

    .line 2748
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2749
    return v1

    .line 2751
    :cond_6
    const/16 v0, -0x53

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2752
    return v2

    .line 2754
    :cond_7
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeDecEntity()Z

    move-result v0

    if-eqz v0, :cond_8

    .line 2755
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2756
    return v1

    .line 2758
    :cond_8
    const/16 v0, -0x52

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2759
    return v2

    .line 2762
    :sswitch_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeDecEntity()Z

    move-result v0

    if-eqz v0, :cond_9

    .line 2763
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2764
    return v1

    .line 2766
    :cond_9
    return v2

    .line 2769
    :sswitch_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeHexEntity()Z

    move-result v0

    if-eqz v0, :cond_a

    .line 2770
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2771
    return v1

    .line 2773
    :cond_a
    return v2

    .line 2777
    :sswitch_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parseEntityName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    .line 2778
    .local v0, "n":Lcom/fasterxml/aalto/in/PName;
    if-nez v0, :cond_b

    .line 2779
    return v2

    .line 2781
    :cond_b
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeGeneralEntity(Lcom/fasterxml/aalto/in/PName;)I

    move-result v4

    .line 2782
    .local v4, "ch":I
    if-nez v4, :cond_c

    .line 2783
    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 2784
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    .line 2787
    .end local v0    # "n":Lcom/fasterxml/aalto/in/PName;
    .end local v4    # "ch":I
    :cond_c
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2788
    return v1

    .line 2791
    :sswitch_6
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v3

    if-eq v0, v4, :cond_d

    .line 2792
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2793
    return v1

    .line 2795
    :cond_d
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2796
    const/16 v0, -0x56

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2797
    goto :goto_0

    .line 2802
    :sswitch_7
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v3

    .line 2803
    .local v0, "b":B
    if-ne v0, v4, :cond_e

    .line 2804
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v3, v1

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2805
    goto :goto_0

    .line 2807
    :cond_e
    const/16 v3, 0x3e

    if-ne v0, v3, :cond_f

    .line 2808
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v3, v1

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2809
    const-string v3, "Encountered \']]>\' in text segment"

    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 2813
    .end local v0    # "b":B
    :cond_f
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2814
    return v1

    .line 2819
    :goto_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v3, :cond_1

    .line 2820
    return v2

    .line 2827
    :cond_10
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2828
    .local v0, "c":I
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v3, v3, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    and-int/lit16 v4, v0, 0xff

    aget v3, v3, v4

    packed-switch v3, :pswitch_data_0

    .line 2885
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInternal()I

    goto/16 :goto_3

    .line 2853
    :pswitch_0
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v3, v3, v4

    and-int/lit16 v3, v3, 0xff

    .line 2855
    .local v3, "next":I
    shr-int/lit8 v4, v0, 0x8

    if-nez v4, :cond_13

    .line 2856
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v5, :cond_11

    .line 2857
    shl-int/lit8 v1, v3, 0x8

    or-int/2addr v1, v0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2858
    return v2

    .line 2860
    :cond_11
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v4, v5

    and-int/lit16 v4, v4, 0xff

    .line 2861
    .local v4, "c2":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v5, v6, :cond_12

    .line 2862
    shl-int/lit8 v1, v3, 0x8

    or-int/2addr v1, v0

    shl-int/lit8 v5, v4, 0x10

    or-int/2addr v1, v5

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2863
    return v2

    .line 2865
    :cond_12
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v5, v5, v6

    and-int/lit16 v5, v5, 0xff

    .line 2866
    .local v5, "c3":I
    invoke-virtual {p0, v0, v3, v4, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_4(IIII)I

    .line 2867
    .end local v4    # "c2":I
    .end local v5    # "c3":I
    goto :goto_1

    .line 2868
    :cond_13
    shr-int/lit8 v4, v0, 0x8

    and-int/lit16 v4, v4, 0xff

    .line 2869
    .restart local v4    # "c2":I
    shr-int/lit8 v5, v0, 0x10

    .line 2871
    .restart local v5    # "c3":I
    if-nez v5, :cond_15

    .line 2872
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v6, v7, :cond_14

    .line 2873
    shl-int/lit8 v1, v3, 0x10

    or-int/2addr v1, v0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2874
    return v2

    .line 2876
    :cond_14
    iget-object v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v6, v6, v7

    and-int/lit16 v5, v6, 0xff

    .line 2877
    and-int/lit16 v6, v0, 0xff

    invoke-virtual {p0, v6, v4, v3, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_4(IIII)I

    goto :goto_1

    .line 2879
    :cond_15
    and-int/lit16 v6, v0, 0xff

    invoke-virtual {p0, v6, v4, v5, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_4(IIII)I

    .line 2883
    .end local v3    # "next":I
    .end local v4    # "c2":I
    .end local v5    # "c3":I
    :goto_1
    goto :goto_3

    .line 2837
    :pswitch_1
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v3, v3, v4

    and-int/lit16 v3, v3, 0xff

    .line 2838
    .restart local v3    # "next":I
    shr-int/lit8 v4, v0, 0x8

    .line 2839
    .restart local v4    # "c2":I
    if-nez v4, :cond_17

    .line 2840
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v5, v6, :cond_16

    .line 2841
    shl-int/lit8 v1, v3, 0x8

    or-int/2addr v1, v0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2842
    return v2

    .line 2844
    :cond_16
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v5, v5, v6

    and-int/lit16 v5, v5, 0xff

    .line 2845
    .restart local v5    # "c3":I
    invoke-virtual {p0, v0, v3, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_3(III)I

    .line 2846
    .end local v5    # "c3":I
    goto :goto_2

    .line 2847
    :cond_17
    and-int/lit16 v5, v0, 0xff

    invoke-virtual {p0, v5, v4, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_3(III)I

    .line 2850
    .end local v3    # "next":I
    .end local v4    # "c2":I
    :goto_2
    goto :goto_3

    .line 2831
    :pswitch_2
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->skipUtf8_2(I)V

    .line 2832
    nop

    .line 2887
    :goto_3
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2888
    return v1

    :sswitch_data_0
    .sparse-switch
        -0x56 -> :sswitch_7
        -0x55 -> :sswitch_6
        -0x54 -> :sswitch_5
        -0x53 -> :sswitch_4
        -0x52 -> :sswitch_3
        -0x51 -> :sswitch_2
        -0x50 -> :sswitch_1
        -0x1 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x5
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method protected final _currentByte()B
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 80
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    return v0
.end method

.method protected final _nextByte()B
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 85
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    return v0
.end method

.method protected final _prevByte()B
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 90
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v1, v1, -0x1

    aget-byte v0, v0, v1

    return v0
.end method

.method protected asyncSkipSpace()Z
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1356
    nop

    :goto_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    const/4 v2, 0x0

    if-ge v0, v1, :cond_7

    .line 1357
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 1358
    .local v0, "b":B
    and-int/lit16 v1, v0, 0xff

    const/4 v3, -0x1

    const/16 v4, 0x20

    const/4 v5, 0x1

    if-le v1, v4, :cond_1

    .line 1360
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    if-ne v1, v3, :cond_0

    .line 1361
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    .line 1362
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 1364
    :cond_0
    return v5

    .line 1366
    :cond_1
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v1, v5

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 1367
    const/16 v1, 0xa

    if-ne v0, v1, :cond_2

    .line 1368
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    goto :goto_1

    .line 1369
    :cond_2
    const/16 v6, 0xd

    if-ne v0, v6, :cond_5

    .line 1370
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v6, :cond_3

    .line 1371
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 1372
    goto :goto_2

    .line 1374
    :cond_3
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v2, v2, v3

    if-ne v2, v1, :cond_4

    .line 1375
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v1, v5

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 1377
    :cond_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    goto :goto_1

    .line 1378
    :cond_5
    if-eq v0, v4, :cond_6

    const/16 v1, 0x9

    if-eq v0, v1, :cond_6

    .line 1379
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInvalidSpace(I)V

    .line 1381
    .end local v0    # "b":B
    :cond_6
    :goto_1
    goto :goto_0

    .line 1382
    :cond_7
    :goto_2
    return v2
.end method

.method protected final decodeDecEntity()Z
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1536
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_entityValue:I

    .line 1537
    .local v0, "value":I
    :goto_0
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-ge v1, v2, :cond_4

    .line 1538
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v2

    .line 1539
    .local v1, "b":B
    const/16 v2, 0x3b

    if-ne v1, v2, :cond_0

    .line 1540
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_entityValue:I

    .line 1541
    const/4 v2, 0x1

    return v2

    .line 1543
    :cond_0
    add-int/lit8 v2, v1, -0x30

    .line 1544
    .local v2, "ch":I
    if-ltz v2, :cond_1

    const/16 v3, 0x9

    if-le v2, v3, :cond_2

    .line 1545
    :cond_1
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v3

    const-string v4, " expected a digit (0 - 9) for character entity"

    invoke-virtual {p0, v3, v4}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1547
    :cond_2
    mul-int/lit8 v3, v0, 0xa

    add-int v0, v3, v2

    .line 1548
    const v3, 0x10ffff

    if-le v0, v3, :cond_3

    .line 1549
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_entityValue:I

    .line 1550
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportEntityOverflow()V

    .line 1552
    .end local v1    # "b":B
    .end local v2    # "ch":I
    :cond_3
    goto :goto_0

    .line 1553
    :cond_4
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_entityValue:I

    .line 1554
    const/4 v1, 0x0

    return v1
.end method

.method protected final decodeGeneralEntity(Lcom/fasterxml/aalto/in/PName;)I
    .locals 4
    .param p1, "entityName"    # Lcom/fasterxml/aalto/in/PName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1568
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 1569
    .local v0, "b":B
    const/16 v1, 0x3b

    if-eq v0, v1, :cond_0

    .line 1570
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " expected \';\' following entity name (\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1573
    :cond_0
    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v1

    .line 1574
    .local v1, "name":Ljava/lang/String;
    const-string v2, "amp"

    if-ne v1, v2, :cond_1

    .line 1575
    const/16 v2, 0x26

    return v2

    .line 1577
    :cond_1
    const-string v2, "lt"

    if-ne v1, v2, :cond_2

    .line 1578
    const/16 v2, 0x3c

    return v2

    .line 1580
    :cond_2
    const-string v2, "apos"

    if-ne v1, v2, :cond_3

    .line 1581
    const/16 v2, 0x27

    return v2

    .line 1583
    :cond_3
    const-string v2, "quot"

    if-ne v1, v2, :cond_4

    .line 1584
    const/16 v2, 0x22

    return v2

    .line 1586
    :cond_4
    const-string v2, "gt"

    if-ne v1, v2, :cond_5

    .line 1587
    const/16 v2, 0x3e

    return v2

    .line 1589
    :cond_5
    const/4 v2, 0x0

    return v2
.end method

.method protected final decodeHexEntity()Z
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1503
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_entityValue:I

    .line 1504
    .local v0, "value":I
    :goto_0
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-ge v1, v2, :cond_5

    .line 1505
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v2

    .line 1506
    .local v1, "b":B
    const/16 v2, 0x3b

    if-ne v1, v2, :cond_0

    .line 1507
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_entityValue:I

    .line 1508
    const/4 v2, 0x1

    return v2

    .line 1510
    :cond_0
    move v2, v1

    .line 1511
    .local v2, "ch":I
    const/16 v3, 0x39

    if-gt v2, v3, :cond_1

    const/16 v3, 0x30

    if-lt v2, v3, :cond_1

    .line 1512
    add-int/lit8 v2, v2, -0x30

    goto :goto_1

    .line 1513
    :cond_1
    const/16 v3, 0x46

    if-gt v2, v3, :cond_2

    const/16 v3, 0x41

    if-lt v2, v3, :cond_2

    .line 1514
    add-int/lit8 v3, v2, -0x41

    add-int/lit8 v2, v3, 0xa

    goto :goto_1

    .line 1515
    :cond_2
    const/16 v3, 0x66

    if-gt v2, v3, :cond_3

    const/16 v3, 0x61

    if-lt v2, v3, :cond_3

    .line 1516
    add-int/lit8 v3, v2, -0x61

    add-int/lit8 v2, v3, 0xa

    goto :goto_1

    .line 1518
    :cond_3
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v3

    const-string v4, " expected a hex digit (0-9a-fA-F) for character entity"

    invoke-virtual {p0, v3, v4}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1520
    :goto_1
    shl-int/lit8 v3, v0, 0x4

    add-int v0, v3, v2

    .line 1521
    const v3, 0x10ffff

    if-le v0, v3, :cond_4

    .line 1522
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_entityValue:I

    .line 1523
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportEntityOverflow()V

    .line 1525
    .end local v1    # "b":B
    .end local v2    # "ch":I
    :cond_4
    goto :goto_0

    .line 1526
    :cond_5
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_entityValue:I

    .line 1527
    const/4 v1, 0x0

    return v1
.end method

.method protected final decodeUtf8_2(I)I
    .locals 3
    .param p1, "c"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3968
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 3969
    .local v0, "d":I
    and-int/lit16 v1, v0, 0xc0

    const/16 v2, 0x80

    if-eq v1, v2, :cond_0

    .line 3970
    and-int/lit16 v1, v0, 0xff

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInvalidOther(II)V

    .line 3972
    :cond_0
    and-int/lit8 v1, p1, 0x1f

    shl-int/lit8 v1, v1, 0x6

    and-int/lit8 v2, v0, 0x3f

    or-int/2addr v1, v2

    return v1
.end method

.method protected final decodeUtf8_3(I)I
    .locals 6
    .param p1, "c1"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3991
    and-int/lit8 p1, p1, 0xf

    .line 3992
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 3993
    .local v0, "d":I
    and-int/lit16 v1, v0, 0xc0

    const/16 v2, 0x80

    if-eq v1, v2, :cond_0

    .line 3994
    and-int/lit16 v1, v0, 0xff

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInvalidOther(II)V

    .line 3996
    :cond_0
    shl-int/lit8 v1, p1, 0x6

    and-int/lit8 v3, v0, 0x3f

    or-int/2addr v1, v3

    .line 3997
    .local v1, "c":I
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v3, v4

    .line 3998
    and-int/lit16 v3, v0, 0xc0

    if-eq v3, v2, :cond_1

    .line 3999
    and-int/lit16 v2, v0, 0xff

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInvalidOther(II)V

    .line 4001
    :cond_1
    shl-int/lit8 v2, v1, 0x6

    and-int/lit8 v3, v0, 0x3f

    or-int v1, v2, v3

    .line 4002
    const/16 v2, 0xd

    if-lt p1, v2, :cond_3

    .line 4003
    const v2, 0xd800

    if-lt v1, v2, :cond_3

    .line 4004
    const v2, 0xe000

    if-lt v1, v2, :cond_2

    const v2, 0xfffe

    if-lt v1, v2, :cond_3

    const v2, 0xffff

    if-gt v1, v2, :cond_3

    .line 4005
    :cond_2
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleInvalidXmlChar(I)C

    move-result v1

    .line 4009
    :cond_3
    return v1
.end method

.method protected final decodeUtf8_3(III)I
    .locals 3
    .param p1, "c1"    # I
    .param p2, "c2"    # I
    .param p3, "c3"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 4015
    and-int/lit16 v0, p2, 0xc0

    const/16 v1, 0x80

    if-eq v0, v1, :cond_0

    .line 4016
    and-int/lit16 v0, p2, 0xff

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInvalidOther(II)V

    .line 4018
    :cond_0
    and-int/lit16 v0, p3, 0xc0

    if-eq v0, v1, :cond_1

    .line 4019
    and-int/lit16 v0, p3, 0xff

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInvalidOther(II)V

    .line 4021
    :cond_1
    and-int/lit8 v0, p1, 0xf

    shl-int/lit8 v0, v0, 0xc

    and-int/lit8 v1, p2, 0x3f

    shl-int/lit8 v1, v1, 0x6

    or-int/2addr v0, v1

    and-int/lit8 v1, p3, 0x3f

    or-int/2addr v0, v1

    .line 4022
    .local v0, "c":I
    const/16 v1, 0xd

    if-lt p1, v1, :cond_3

    .line 4023
    const v1, 0xd800

    if-lt v0, v1, :cond_3

    .line 4024
    const v1, 0xe000

    if-lt v0, v1, :cond_2

    const v1, 0xfffe

    if-lt v0, v1, :cond_3

    const v1, 0xffff

    if-gt v0, v1, :cond_3

    .line 4025
    :cond_2
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleInvalidXmlChar(I)C

    move-result v0

    .line 4029
    :cond_3
    return v0
.end method

.method protected final decodeUtf8_4(I)I
    .locals 5
    .param p1, "c"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 4035
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 4036
    .local v0, "d":I
    and-int/lit16 v1, v0, 0xc0

    const/16 v2, 0x80

    if-eq v1, v2, :cond_0

    .line 4037
    and-int/lit16 v1, v0, 0xff

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInvalidOther(II)V

    .line 4039
    :cond_0
    and-int/lit8 v1, p1, 0x7

    shl-int/lit8 v1, v1, 0x6

    and-int/lit8 v3, v0, 0x3f

    or-int p1, v1, v3

    .line 4040
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v1, v3

    .line 4041
    and-int/lit16 v1, v0, 0xc0

    if-eq v1, v2, :cond_1

    .line 4042
    and-int/lit16 v1, v0, 0xff

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInvalidOther(II)V

    .line 4044
    :cond_1
    shl-int/lit8 v1, p1, 0x6

    and-int/lit8 v3, v0, 0x3f

    or-int p1, v1, v3

    .line 4045
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v1, v3

    .line 4046
    and-int/lit16 v1, v0, 0xc0

    if-eq v1, v2, :cond_2

    .line 4047
    and-int/lit16 v1, v0, 0xff

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInvalidOther(II)V

    .line 4052
    :cond_2
    shl-int/lit8 v1, p1, 0x6

    and-int/lit8 v2, v0, 0x3f

    or-int/2addr v1, v2

    const/high16 v2, 0x10000

    sub-int/2addr v1, v2

    return v1
.end method

.method protected final decodeUtf8_4(IIII)I
    .locals 4
    .param p1, "c1"    # I
    .param p2, "c2"    # I
    .param p3, "c3"    # I
    .param p4, "c4"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 4064
    and-int/lit16 v0, p2, 0xc0

    const/16 v1, 0x80

    if-eq v0, v1, :cond_0

    .line 4065
    and-int/lit16 v0, p2, 0xff

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v2, v2, -0x2

    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInvalidOther(II)V

    .line 4067
    :cond_0
    and-int/lit8 v0, p1, 0x7

    shl-int/lit8 v0, v0, 0x6

    and-int/lit8 v2, p2, 0x3f

    or-int/2addr v0, v2

    .line 4068
    .local v0, "c":I
    and-int/lit16 v2, p3, 0xc0

    if-eq v2, v1, :cond_1

    .line 4069
    and-int/lit16 v2, p3, 0xff

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v3, v3, -0x1

    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInvalidOther(II)V

    .line 4071
    :cond_1
    shl-int/lit8 v2, v0, 0x6

    and-int/lit8 v3, p3, 0x3f

    or-int v0, v2, v3

    .line 4072
    and-int/lit16 v2, p4, 0xc0

    if-eq v2, v1, :cond_2

    .line 4073
    and-int/lit16 v1, p4, 0xff

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInvalidOther(II)V

    .line 4075
    :cond_2
    shl-int/lit8 v1, v0, 0x6

    and-int/lit8 v2, p4, 0x3f

    or-int/2addr v1, v2

    const/high16 v2, 0x10000

    sub-int/2addr v1, v2

    return v1
.end method

.method public feedInput([BII)V
    .locals 4
    .param p1, "buf"    # [B
    .param p2, "start"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 952
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v1, :cond_1

    .line 956
    iget-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_endOfInput:Z

    if-nez v0, :cond_0

    .line 960
    iget-wide v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pastBytesOrChars:J

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_origBufferLen:I

    int-to-long v2, v2

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pastBytesOrChars:J

    .line 961
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_rowStartOffset:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_origBufferLen:I

    sub-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_rowStartOffset:I

    .line 964
    iput-object p1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    .line 965
    iput p2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 966
    add-int v0, p2, p3

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    .line 967
    iput p3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_origBufferLen:I

    .line 968
    return-void

    .line 957
    :cond_0
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    const-string v1, "Already closed, can not feed more input"

    invoke-direct {v0, v1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 953
    :cond_1
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Still have "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v2, v3

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " unread bytes"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected final finishCharacters()V
    .locals 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2161
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    if-eqz v0, :cond_0

    .line 2163
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInternal()I

    .line 2166
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    .line 2167
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    .line 2168
    .local v1, "inputBuffer":[B
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v2

    .line 2170
    .local v2, "outputBuffer":[C
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->getCurrentLength()I

    move-result v3

    .line 2178
    .local v3, "outPtr":I
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2179
    .local v4, "ptr":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v5, :cond_1

    .line 2180
    goto/16 :goto_7

    .line 2182
    :cond_1
    array-length v5, v2

    if-lt v3, v5, :cond_2

    .line 2183
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v5}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2184
    const/4 v3, 0x0

    .line 2186
    :cond_2
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    .line 2188
    .local v5, "max":I
    array-length v6, v2

    sub-int/2addr v6, v3

    add-int/2addr v6, v4

    .line 2189
    .local v6, "max2":I
    if-ge v6, v5, :cond_3

    .line 2190
    move v5, v6

    .line 2193
    .end local v6    # "max2":I
    :cond_3
    :goto_1
    if-ge v4, v5, :cond_14

    .line 2194
    add-int/lit8 v6, v4, 0x1

    .end local v4    # "ptr":I
    .local v6, "ptr":I
    aget-byte v4, v1, v4

    and-int/lit16 v4, v4, 0xff

    .line 2195
    .local v4, "c":I
    aget v7, v0, v4

    if-eqz v7, :cond_13

    .line 2196
    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2197
    nop

    .line 2204
    .end local v5    # "max":I
    .end local v6    # "ptr":I
    aget v5, v0, v4

    const v6, 0xdc00

    const v7, 0xd800

    const/4 v8, -0x1

    const/4 v9, 0x1

    packed-switch v5, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_8

    .line 2296
    :pswitch_1
    const/4 v5, 0x1

    .line 2297
    .local v5, "count":I
    const/4 v6, 0x0

    .line 2298
    .local v6, "b":B
    :goto_2
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v10, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    const/16 v11, 0x5d

    if-ge v7, v10, :cond_5

    .line 2299
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v6, v1, v7

    .line 2300
    if-eq v6, v11, :cond_4

    .line 2301
    goto :goto_3

    .line 2303
    :cond_4
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v7, v9

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2304
    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    .line 2306
    :cond_5
    :goto_3
    const/16 v7, 0x3e

    if-ne v6, v7, :cond_6

    if-le v5, v9, :cond_6

    .line 2307
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportIllegalCDataEnd()V

    .line 2311
    :cond_6
    :goto_4
    add-int/2addr v5, v8

    if-lez v5, :cond_12

    .line 2312
    add-int/lit8 v7, v3, 0x1

    .end local v3    # "outPtr":I
    .local v7, "outPtr":I
    aput-char v11, v2, v3

    .line 2314
    array-length v3, v2

    if-lt v7, v3, :cond_7

    .line 2315
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2316
    const/4 v3, 0x0

    .end local v7    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_4

    .line 2314
    .end local v3    # "outPtr":I
    .restart local v7    # "outPtr":I
    :cond_7
    move v3, v7

    goto :goto_4

    .line 2270
    .end local v5    # "count":I
    .end local v6    # "b":B
    .end local v7    # "outPtr":I
    .restart local v3    # "outPtr":I
    :pswitch_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleEntityInCharacters()I

    move-result v4

    .line 2271
    if-nez v4, :cond_8

    .line 2273
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v5, v9

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2274
    goto/16 :goto_7

    .line 2277
    :cond_8
    shr-int/lit8 v5, v4, 0x10

    if-eqz v5, :cond_12

    .line 2278
    const/high16 v5, 0x10000

    sub-int/2addr v4, v5

    .line 2279
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .local v5, "outPtr":I
    shr-int/lit8 v8, v4, 0xa

    or-int/2addr v7, v8

    int-to-char v7, v7

    aput-char v7, v2, v3

    .line 2281
    array-length v3, v2

    if-lt v5, v3, :cond_9

    .line 2282
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2283
    const/4 v3, 0x0

    .end local v5    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_5

    .line 2281
    .end local v3    # "outPtr":I
    .restart local v5    # "outPtr":I
    :cond_9
    move v3, v5

    .line 2285
    .end local v5    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_5
    and-int/lit16 v5, v4, 0x3ff

    or-int v4, v5, v6

    goto/16 :goto_8

    .line 2242
    :pswitch_3
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v5, v8

    const/4 v8, 0x3

    if-ge v5, v8, :cond_b

    .line 2243
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v5, v6, :cond_a

    .line 2244
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v5, v5, v6

    and-int/lit16 v5, v5, 0xff

    .line 2245
    .local v5, "d":I
    shl-int/lit8 v6, v5, 0x8

    or-int/2addr v4, v6

    .line 2246
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v6, v7, :cond_a

    .line 2247
    iget-object v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v6, v6, v7

    and-int/lit16 v5, v6, 0xff

    .line 2248
    shl-int/lit8 v6, v5, 0x10

    or-int/2addr v4, v6

    .line 2251
    .end local v5    # "d":I
    :cond_a
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2252
    goto/16 :goto_7

    .line 2254
    :cond_b
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_4(I)I

    move-result v4

    .line 2256
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .local v5, "outPtr":I
    shr-int/lit8 v8, v4, 0xa

    or-int/2addr v7, v8

    int-to-char v7, v7

    aput-char v7, v2, v3

    .line 2257
    array-length v3, v2

    if-lt v5, v3, :cond_c

    .line 2258
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2259
    const/4 v3, 0x0

    .end local v5    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_6

    .line 2257
    .end local v3    # "outPtr":I
    .restart local v5    # "outPtr":I
    :cond_c
    move v3, v5

    .line 2261
    .end local v5    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_6
    and-int/lit16 v5, v4, 0x3ff

    or-int v4, v5, v6

    .line 2263
    goto :goto_8

    .line 2231
    :pswitch_4
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v5, v6

    const/4 v6, 0x2

    if-ge v5, v6, :cond_e

    .line 2232
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v5, v6, :cond_d

    .line 2233
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v5, v5, v6

    and-int/lit16 v5, v5, 0xff

    .line 2234
    .local v5, "d":I
    shl-int/lit8 v6, v5, 0x8

    or-int/2addr v4, v6

    .line 2236
    .end local v5    # "d":I
    :cond_d
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2237
    goto :goto_7

    .line 2239
    :cond_e
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_3(I)I

    move-result v4

    .line 2240
    goto :goto_8

    .line 2224
    :pswitch_5
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v5, v6, :cond_f

    .line 2225
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2226
    goto :goto_7

    .line 2228
    :cond_f
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_2(I)I

    move-result v4

    .line 2229
    goto :goto_8

    .line 2265
    :pswitch_6
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInvalidInitial(I)V

    .line 2267
    :pswitch_7
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v5, v9

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2268
    goto :goto_7

    .line 2221
    :pswitch_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    .line 2222
    goto :goto_8

    .line 2206
    :pswitch_9
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleInvalidXmlChar(I)C

    move-result v4

    .line 2209
    :pswitch_a
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v5, v6, :cond_10

    .line 2210
    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2211
    nop

    .line 2329
    .end local v4    # "c":I
    :goto_7
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 2330
    return-void

    .line 2213
    .restart local v4    # "c":I
    :cond_10
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v5, v1, v5

    const/16 v6, 0xa

    if-ne v5, v6, :cond_11

    .line 2214
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v5, v9

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2216
    :cond_11
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    .line 2218
    const/16 v4, 0xa

    .line 2219
    nop

    .line 2327
    :cond_12
    :goto_8
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .local v5, "outPtr":I
    int-to-char v6, v4

    aput-char v6, v2, v3

    .line 2328
    .end local v4    # "c":I
    move v3, v5

    goto/16 :goto_0

    .line 2199
    .restart local v3    # "outPtr":I
    .restart local v4    # "c":I
    .local v5, "max":I
    .local v6, "ptr":I
    :cond_13
    add-int/lit8 v7, v3, 0x1

    .end local v3    # "outPtr":I
    .restart local v7    # "outPtr":I
    int-to-char v8, v4

    aput-char v8, v2, v3

    move v4, v6

    move v3, v7

    goto/16 :goto_1

    .line 2201
    .end local v6    # "ptr":I
    .end local v7    # "outPtr":I
    .restart local v3    # "outPtr":I
    .local v4, "ptr":I
    :cond_14
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2202
    .end local v4    # "ptr":I
    .end local v5    # "max":I
    goto/16 :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_9
        :pswitch_a
        :pswitch_8
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_0
        :pswitch_7
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method protected final finishCharactersCoalescing()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 927
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    if-eqz v0, :cond_0

    .line 928
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleAndAppendPending()Z

    move-result v0

    if-nez v0, :cond_0

    .line 929
    const/16 v0, 0x101

    return v0

    .line 932
    :cond_0
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method

.method protected handleAttrValue()Z
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2987
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    .line 2988
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleAttrValuePending()Z

    move-result v0

    if-nez v0, :cond_0

    .line 2989
    return v1

    .line 2991
    :cond_0
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2994
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/AttributeCollector;->continueValue()[C

    move-result-object v0

    .line 2995
    .local v0, "attrBuffer":[C
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v2, v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    .line 2996
    .local v2, "TYPES":[I
    iget-byte v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrQuote:B

    .line 3004
    .local v3, "quoteChar":I
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v5, :cond_2

    .line 3005
    return v1

    .line 3007
    :cond_2
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    array-length v5, v0

    if-lt v4, v5, :cond_3

    .line 3008
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v4}, Lcom/fasterxml/aalto/in/AttributeCollector;->valueBufferFull()[C

    move-result-object v0

    .line 3010
    :cond_3
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    .line 3012
    .local v4, "max":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    array-length v6, v0

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    sub-int/2addr v6, v7

    add-int/2addr v5, v6

    .line 3013
    .local v5, "max2":I
    if-ge v5, v4, :cond_4

    .line 3014
    move v4, v5

    .line 3017
    .end local v5    # "max2":I
    :cond_4
    :goto_1
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-ge v5, v4, :cond_10

    .line 3018
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v5, v5, v6

    and-int/lit16 v5, v5, 0xff

    .line 3019
    .local v5, "c":I
    aget v6, v2, v5

    if-eqz v6, :cond_f

    .line 3020
    nop

    .line 3026
    .end local v4    # "max":I
    aget v4, v2, v5

    const v6, 0xdc00

    const v7, 0xd800

    const/4 v8, 0x1

    packed-switch v4, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_2

    .line 3107
    :pswitch_1
    if-ne v5, v3, :cond_e

    .line 3108
    nop

    .line 3118
    .end local v5    # "c":I
    return v8

    .line 3064
    .restart local v5    # "c":I
    :pswitch_2
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v4, v8

    const/4 v8, 0x3

    if-ge v4, v8, :cond_6

    .line 3065
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v4, v6, :cond_5

    .line 3066
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v4, v6

    and-int/lit16 v4, v4, 0xff

    .line 3067
    .local v4, "d":I
    shl-int/lit8 v6, v4, 0x8

    or-int/2addr v5, v6

    .line 3068
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v6, v7, :cond_5

    .line 3069
    iget-object v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v6, v6, v7

    and-int/lit16 v4, v6, 0xff

    .line 3070
    shl-int/lit8 v6, v4, 0x10

    or-int/2addr v5, v6

    .line 3073
    .end local v4    # "d":I
    :cond_5
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3074
    return v1

    .line 3076
    :cond_6
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_4(I)I

    move-result v4

    .line 3078
    .end local v5    # "c":I
    .local v4, "c":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    add-int/lit8 v8, v5, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    shr-int/lit8 v8, v4, 0xa

    or-int/2addr v7, v8

    int-to-char v7, v7

    aput-char v7, v0, v5

    .line 3079
    and-int/lit16 v5, v4, 0x3ff

    or-int/2addr v5, v6

    .line 3080
    .end local v4    # "c":I
    .restart local v5    # "c":I
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    array-length v6, v0

    if-lt v4, v6, :cond_e

    .line 3081
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v4}, Lcom/fasterxml/aalto/in/AttributeCollector;->valueBufferFull()[C

    move-result-object v0

    goto/16 :goto_2

    .line 3053
    :pswitch_3
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v4, v6

    const/4 v6, 0x2

    if-ge v4, v6, :cond_8

    .line 3054
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v4, v6, :cond_7

    .line 3055
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v4, v6

    and-int/lit16 v4, v4, 0xff

    .line 3056
    .local v4, "d":I
    shl-int/lit8 v6, v4, 0x8

    or-int/2addr v5, v6

    .line 3058
    .end local v4    # "d":I
    :cond_7
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3059
    return v1

    .line 3061
    :cond_8
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_3(I)I

    move-result v5

    .line 3062
    goto :goto_2

    .line 3046
    :pswitch_4
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v6, :cond_9

    .line 3047
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3048
    return v1

    .line 3050
    :cond_9
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_2(I)I

    move-result v5

    .line 3051
    goto :goto_2

    .line 3085
    :pswitch_5
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInvalidInitial(I)V

    .line 3087
    :pswitch_6
    const-string v4, "\'<\' not allowed in attribute value"

    invoke-virtual {p0, v5, v4}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 3089
    :pswitch_7
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleEntityInAttributeValue()I

    move-result v5

    .line 3090
    if-gtz v5, :cond_b

    .line 3091
    if-gez v5, :cond_a

    .line 3092
    return v1

    .line 3094
    :cond_a
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p0, v4, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportUnexpandedEntityInAttr(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 3097
    :cond_b
    shr-int/lit8 v4, v5, 0x10

    if-eqz v4, :cond_e

    .line 3098
    const/high16 v4, 0x10000

    sub-int/2addr v5, v4

    .line 3099
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    add-int/lit8 v8, v4, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    shr-int/lit8 v8, v5, 0xa

    or-int/2addr v7, v8

    int-to-char v7, v7

    aput-char v7, v0, v4

    .line 3100
    and-int/lit16 v4, v5, 0x3ff

    or-int v5, v4, v6

    .line 3101
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    array-length v6, v0

    if-lt v4, v6, :cond_e

    .line 3102
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v4}, Lcom/fasterxml/aalto/in/AttributeCollector;->valueBufferFull()[C

    move-result-object v0

    goto :goto_2

    .line 3028
    :pswitch_8
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleInvalidXmlChar(I)C

    move-result v5

    .line 3030
    :pswitch_9
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v6, :cond_c

    .line 3031
    const/4 v4, -0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3032
    return v1

    .line 3034
    :cond_c
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v4, v6

    const/16 v6, 0xa

    if-ne v4, v6, :cond_d

    .line 3035
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v4, v8

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 3039
    :cond_d
    :pswitch_a
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    .line 3043
    :pswitch_b
    const/16 v5, 0x20

    .line 3044
    nop

    .line 3115
    :cond_e
    :goto_2
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    add-int/lit8 v6, v4, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    int-to-char v6, v5

    aput-char v6, v0, v4

    .line 3116
    .end local v5    # "c":I
    goto/16 :goto_0

    .line 3022
    .local v4, "max":I
    .restart local v5    # "c":I
    :cond_f
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrPtr:I

    int-to-char v7, v5

    aput-char v7, v0, v6

    goto/16 :goto_1

    .line 3024
    .end local v4    # "max":I
    .end local v5    # "c":I
    :cond_10
    goto/16 :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_8
        :pswitch_9
        :pswitch_a
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_b
        :pswitch_6
        :pswitch_7
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method protected final handleCDataPending()I
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 778
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    const/16 v1, -0x1e

    const/16 v2, -0x1f

    const/16 v3, 0x5d

    const/4 v4, 0x0

    const/16 v5, 0x101

    if-ne v0, v1, :cond_2

    .line 779
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 780
    return v5

    .line 782
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    if-eq v0, v3, :cond_1

    .line 784
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->append(C)V

    .line 785
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    return v4

    .line 787
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 788
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 789
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v1, :cond_2

    .line 790
    return v5

    .line 794
    :cond_2
    :goto_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    if-ne v0, v2, :cond_6

    .line 795
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v1, :cond_3

    .line 796
    return v5

    .line 798
    :cond_3
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v6, v1, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 799
    .local v0, "b":B
    const/16 v1, 0x3e

    if-ne v0, v1, :cond_4

    .line 800
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 801
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 802
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    .line 803
    const/16 v1, 0xc

    return v1

    .line 805
    :cond_4
    if-eq v0, v3, :cond_5

    .line 806
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v1, v1, -0x1

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 807
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    const-string v2, "]]"

    invoke-virtual {v1, v2}, Lcom/fasterxml/aalto/util/TextBuilder;->append(Ljava/lang/String;)V

    .line 808
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    return v4

    .line 810
    :cond_5
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->append(C)V

    .line 811
    .end local v0    # "b":B
    goto :goto_0

    .line 813
    :cond_6
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleAndAppendPending()Z

    move-result v0

    if-eqz v0, :cond_7

    goto :goto_1

    :cond_7
    move v4, v5

    :goto_1
    return v4
.end method

.method protected final handleComment()I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1310
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 1311
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parseCommentContents()I

    move-result v0

    return v0

    .line 1313
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    const/16 v3, 0x101

    if-lt v0, v2, :cond_1

    .line 1314
    return v3

    .line 1316
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v2

    .line 1318
    .local v0, "b":B
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    if-nez v2, :cond_3

    .line 1319
    const/16 v2, 0x2d

    if-eq v0, v2, :cond_2

    .line 1320
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v2

    const-string v3, " (expected \'-\' for COMMENT)"

    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 1322
    :cond_2
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1323
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    .line 1324
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parseCommentContents()I

    move-result v1

    return v1

    .line 1326
    :cond_3
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    const/4 v2, 0x3

    if-ne v1, v2, :cond_5

    .line 1328
    const/16 v1, 0x3e

    if-eq v0, v1, :cond_4

    .line 1329
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportDoubleHyphenInComments()V

    .line 1331
    :cond_4
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1332
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    .line 1333
    const/4 v1, 0x5

    return v1

    .line 1335
    :cond_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInternal()I

    move-result v1

    return v1
.end method

.method protected handleCommentPending()I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 248
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    const/16 v2, 0x101

    if-lt v0, v1, :cond_0

    .line 249
    return v2

    .line 251
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    const/16 v1, -0x14

    const/16 v3, -0x15

    const/4 v4, 0x0

    if-ne v0, v1, :cond_2

    .line 252
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    const/16 v1, 0x2d

    if-eq v0, v1, :cond_1

    .line 254
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 255
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    const-string v1, "-"

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->append(Ljava/lang/String;)V

    .line 256
    return v4

    .line 258
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 259
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 260
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v1, :cond_2

    .line 261
    return v2

    .line 265
    :cond_2
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    if-ne v0, v3, :cond_4

    .line 266
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 267
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 268
    .local v0, "b":B
    const/16 v1, 0x3e

    if-eq v0, v1, :cond_3

    .line 269
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportDoubleHyphenInComments()V

    .line 271
    :cond_3
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 272
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    .line 273
    const/4 v1, 0x5

    return v1

    .line 276
    .end local v0    # "b":B
    :cond_4
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleAndAppendPending()Z

    move-result v0

    if-eqz v0, :cond_5

    move v2, v4

    :cond_5
    return v2
.end method

.method protected final handleDTDInternalSubset(Z)Z
    .locals 10
    .param p1, "init"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 461
    const/4 v0, 0x0

    if-eqz p1, :cond_0

    .line 462
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v1

    .line 463
    .local v1, "outputBuffer":[C
    const/4 v2, 0x0

    .line 464
    .local v2, "outPtr":I
    iput-byte v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrQuote:B

    .line 465
    iput-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inDtdDeclaration:Z

    goto :goto_0

    .line 467
    .end local v1    # "outputBuffer":[C
    .end local v2    # "outPtr":I
    :cond_0
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    if-eqz v1, :cond_1

    .line 468
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleAndAppendPending()Z

    move-result v1

    if-nez v1, :cond_1

    .line 469
    return v0

    .line 472
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v1

    .line 473
    .restart local v1    # "outputBuffer":[C
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->getCurrentLength()I

    move-result v2

    .line 476
    .restart local v2    # "outPtr":I
    :goto_0
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v3, v3, Lcom/fasterxml/aalto/util/XmlCharTypes;->DTD_CHARS:[I

    .line 477
    .local v3, "TYPES":[I
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    .line 485
    .local v4, "inputBuffer":[B
    :goto_1
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v5, v6, :cond_2

    .line 486
    goto/16 :goto_4

    .line 488
    :cond_2
    array-length v5, v1

    if-lt v2, v5, :cond_3

    .line 489
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v5}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v1

    .line 490
    const/4 v2, 0x0

    .line 492
    :cond_3
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    .line 494
    .local v5, "max":I
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    array-length v7, v1

    sub-int/2addr v7, v2

    add-int/2addr v6, v7

    .line 495
    .local v6, "max2":I
    if-ge v6, v5, :cond_4

    .line 496
    move v5, v6

    .line 499
    .end local v6    # "max2":I
    :cond_4
    :goto_2
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-ge v6, v5, :cond_10

    .line 500
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v6, v4, v6

    and-int/lit16 v6, v6, 0xff

    .line 501
    .local v6, "c":I
    aget v7, v3, v6

    if-eqz v7, :cond_f

    .line 502
    nop

    .line 508
    .end local v5    # "max":I
    aget v5, v3, v6

    const/4 v7, 0x1

    packed-switch v5, :pswitch_data_0

    goto/16 :goto_5

    .line 590
    :pswitch_0
    iget-boolean v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inDtdDeclaration:Z

    if-nez v5, :cond_e

    iget-byte v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrQuote:B

    if-nez v5, :cond_e

    .line 591
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0, v2}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 592
    return v7

    .line 585
    :pswitch_1
    iget-byte v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrQuote:B

    if-nez v5, :cond_e

    .line 586
    iput-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inDtdDeclaration:Z

    goto/16 :goto_5

    .line 580
    :pswitch_2
    iget-boolean v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inDtdDeclaration:Z

    if-nez v5, :cond_e

    .line 581
    iput-boolean v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inDtdDeclaration:Z

    goto/16 :goto_5

    .line 544
    :pswitch_3
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v5, v7

    const/4 v7, 0x3

    if-ge v5, v7, :cond_6

    .line 545
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v5, v7, :cond_5

    .line 546
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v5, v5, v7

    and-int/lit16 v5, v5, 0xff

    .line 547
    .local v5, "d":I
    shl-int/lit8 v7, v5, 0x8

    or-int/2addr v6, v7

    .line 548
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v7, v8, :cond_5

    .line 549
    iget-object v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v7, v7, v8

    and-int/lit16 v5, v7, 0xff

    .line 550
    shl-int/lit8 v7, v5, 0x10

    or-int/2addr v6, v7

    .line 553
    .end local v5    # "d":I
    :cond_5
    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 554
    goto/16 :goto_4

    .line 556
    :cond_6
    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_4(I)I

    move-result v5

    .line 558
    .end local v6    # "c":I
    .local v5, "c":I
    add-int/lit8 v6, v2, 0x1

    .end local v2    # "outPtr":I
    .local v6, "outPtr":I
    shr-int/lit8 v7, v5, 0xa

    const v8, 0xd800

    or-int/2addr v7, v8

    int-to-char v7, v7

    aput-char v7, v1, v2

    .line 559
    array-length v2, v1

    if-lt v6, v2, :cond_7

    .line 560
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v1

    .line 561
    const/4 v2, 0x0

    .end local v6    # "outPtr":I
    .restart local v2    # "outPtr":I
    goto :goto_3

    .line 559
    .end local v2    # "outPtr":I
    .restart local v6    # "outPtr":I
    :cond_7
    move v2, v6

    .line 563
    .end local v6    # "outPtr":I
    .restart local v2    # "outPtr":I
    :goto_3
    and-int/lit16 v6, v5, 0x3ff

    const v7, 0xdc00

    or-int/2addr v6, v7

    .line 565
    .end local v5    # "c":I
    .local v6, "c":I
    goto/16 :goto_5

    .line 533
    :pswitch_4
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v5, v7

    const/4 v7, 0x2

    if-ge v5, v7, :cond_9

    .line 534
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v5, v7, :cond_8

    .line 535
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v5, v5, v7

    and-int/lit16 v5, v5, 0xff

    .line 536
    .local v5, "d":I
    shl-int/lit8 v7, v5, 0x8

    or-int/2addr v6, v7

    .line 538
    .end local v5    # "d":I
    :cond_8
    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 539
    goto :goto_4

    .line 541
    :cond_9
    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_3(I)I

    move-result v6

    .line 542
    goto :goto_5

    .line 526
    :pswitch_5
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v5, v7, :cond_a

    .line 527
    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 528
    goto :goto_4

    .line 530
    :cond_a
    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_2(I)I

    move-result v6

    .line 531
    goto :goto_5

    .line 567
    :pswitch_6
    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInvalidInitial(I)V

    .line 570
    :pswitch_7
    iget-byte v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrQuote:B

    if-nez v5, :cond_b

    .line 571
    int-to-byte v5, v6

    iput-byte v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrQuote:B

    goto :goto_5

    .line 573
    :cond_b
    iget-byte v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrQuote:B

    if-ne v5, v6, :cond_e

    .line 574
    iput-byte v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrQuote:B

    goto :goto_5

    .line 523
    :pswitch_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    .line 524
    goto :goto_5

    .line 510
    :pswitch_9
    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleInvalidXmlChar(I)C

    move-result v6

    .line 512
    :pswitch_a
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v5, v8, :cond_c

    .line 513
    const/4 v5, -0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 514
    nop

    .line 601
    .end local v6    # "c":I
    :goto_4
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v5, v2}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 602
    return v0

    .line 516
    .restart local v6    # "c":I
    :cond_c
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v5, v4, v5

    const/16 v8, 0xa

    if-ne v5, v8, :cond_d

    .line 517
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v5, v7

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 519
    :cond_d
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    .line 520
    const/16 v6, 0xa

    .line 521
    nop

    .line 599
    :cond_e
    :goto_5
    add-int/lit8 v5, v2, 0x1

    .end local v2    # "outPtr":I
    .local v5, "outPtr":I
    int-to-char v7, v6

    aput-char v7, v1, v2

    .line 600
    .end local v6    # "c":I
    move v2, v5

    goto/16 :goto_1

    .line 504
    .restart local v2    # "outPtr":I
    .local v5, "max":I
    .restart local v6    # "c":I
    :cond_f
    add-int/lit8 v7, v2, 0x1

    .end local v2    # "outPtr":I
    .local v7, "outPtr":I
    int-to-char v8, v6

    aput-char v8, v1, v2

    move v2, v7

    goto/16 :goto_2

    .line 506
    .end local v5    # "max":I
    .end local v6    # "c":I
    .end local v7    # "outPtr":I
    .restart local v2    # "outPtr":I
    :cond_10
    goto/16 :goto_1

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_9
        :pswitch_a
        :pswitch_8
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_7
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method protected handleDecEntityInCharacters(I)I
    .locals 6
    .param p1, "ptr"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2406
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v1, p1, 0x1

    .end local p1    # "ptr":I
    .local v1, "ptr":I
    aget-byte p1, v0, p1

    .line 2407
    .local p1, "b":B
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    .line 2408
    .local v0, "end":I
    const/4 v2, 0x0

    .line 2410
    .local v2, "value":I
    :goto_0
    move v3, p1

    .line 2411
    .local v3, "ch":I
    const/16 v4, 0x39

    if-gt v3, v4, :cond_0

    const/16 v4, 0x30

    if-ge v3, v4, :cond_1

    .line 2412
    :cond_0
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v4

    const-string v5, " expected a digit (0 - 9) for character entity"

    invoke-virtual {p0, v4, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 2414
    :cond_1
    mul-int/lit8 v4, v2, 0xa

    add-int/lit8 v5, v3, -0x30

    add-int v2, v4, v5

    .line 2415
    const v4, 0x10ffff

    if-le v2, v4, :cond_2

    .line 2416
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportEntityOverflow()V

    .line 2418
    :cond_2
    if-lt v1, v0, :cond_3

    .line 2419
    const/4 v4, 0x0

    return v4

    .line 2421
    :cond_3
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v5, v1, 0x1

    .end local v1    # "ptr":I
    .local v5, "ptr":I
    aget-byte p1, v4, v1

    .line 2422
    .end local v3    # "ch":I
    const/16 v1, 0x3b

    if-ne p1, v1, :cond_4

    .line 2423
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2424
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->verifyXmlChar(I)V

    .line 2425
    return v2

    .line 2422
    :cond_4
    move v1, v5

    goto :goto_0
.end method

.method protected handleEntityInAttributeValue()I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3374
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    const/4 v2, -0x1

    if-lt v0, v1, :cond_0

    .line 3375
    const/16 v0, -0x3c

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3376
    return v2

    .line 3378
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 3379
    .local v0, "b":B
    const/16 v1, 0x23

    if-ne v0, v1, :cond_5

    .line 3380
    const/16 v1, -0x3d

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3381
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v1, v3, :cond_1

    .line 3382
    return v2

    .line 3385
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v3

    const/16 v3, 0x78

    const/4 v4, 0x1

    if-ne v1, v3, :cond_3

    .line 3386
    const/16 v1, -0x3e

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3387
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v1, v4

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 3388
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v1, v3, :cond_2

    .line 3389
    return v2

    .line 3391
    :cond_2
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleHexEntityInAttribute(Z)I

    move-result v1

    .local v1, "ch":I
    goto :goto_0

    .line 3393
    .end local v1    # "ch":I
    :cond_3
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleDecEntityInAttribute(Z)I

    move-result v1

    .line 3395
    .restart local v1    # "ch":I
    :goto_0
    if-nez v1, :cond_4

    .line 3396
    return v2

    .line 3398
    :cond_4
    return v1

    .line 3400
    .end local v1    # "ch":I
    :cond_5
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parseNewEntityName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    .line 3401
    .local v1, "entityName":Lcom/fasterxml/aalto/in/PName;
    if-nez v1, :cond_6

    .line 3402
    const/16 v3, -0x3f

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3403
    return v2

    .line 3405
    :cond_6
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeGeneralEntity(Lcom/fasterxml/aalto/in/PName;)I

    move-result v2

    .line 3406
    .local v2, "ch":I
    if-eqz v2, :cond_7

    .line 3407
    return v2

    .line 3409
    :cond_7
    iput-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 3410
    const/4 v3, 0x0

    return v3
.end method

.method protected handleEntityInCharacters()I
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2349
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2350
    .local v0, "ptr":I
    add-int/lit8 v1, v0, 0x3

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-gt v1, v2, :cond_8

    .line 2351
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v2, v0, 0x1

    .end local v0    # "ptr":I
    .local v2, "ptr":I
    aget-byte v0, v1, v0

    .line 2352
    .local v0, "b":B
    const/16 v1, 0x23

    if-ne v0, v1, :cond_1

    .line 2353
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    aget-byte v1, v1, v2

    const/16 v3, 0x78

    if-ne v1, v3, :cond_0

    .line 2354
    add-int/lit8 v1, v2, 0x1

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleHexEntityInCharacters(I)I

    move-result v1

    return v1

    .line 2356
    :cond_0
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleDecEntityInCharacters(I)I

    move-result v1

    return v1

    .line 2359
    :cond_1
    const/16 v1, 0x61

    const/16 v3, 0x27

    const/16 v4, 0x6f

    const/16 v5, 0x3b

    if-ne v0, v1, :cond_4

    .line 2360
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v6, v2, 0x1

    .end local v2    # "ptr":I
    .local v6, "ptr":I
    aget-byte v0, v1, v2

    .line 2361
    const/16 v1, 0x6d

    const/16 v2, 0x70

    if-ne v0, v1, :cond_2

    .line 2362
    add-int/lit8 v1, v6, 0x1

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-ge v1, v3, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    aget-byte v1, v1, v6

    if-ne v1, v2, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v2, v6, 0x1

    aget-byte v1, v1, v2

    if-ne v1, v5, :cond_3

    .line 2365
    add-int/lit8 v1, v6, 0x2

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2366
    const/16 v1, 0x26

    return v1

    .line 2368
    :cond_2
    if-ne v0, v2, :cond_3

    .line 2369
    add-int/lit8 v1, v6, 0x2

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-ge v1, v2, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    aget-byte v1, v1, v6

    if-ne v1, v4, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v2, v6, 0x1

    aget-byte v1, v1, v2

    const/16 v2, 0x73

    if-ne v1, v2, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v2, v6, 0x2

    aget-byte v1, v1, v2

    if-ne v1, v5, :cond_3

    .line 2373
    add-int/lit8 v1, v6, 0x3

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2374
    return v3

    .line 2401
    .end local v0    # "b":B
    :cond_3
    move v0, v6

    goto :goto_0

    .line 2377
    .end local v6    # "ptr":I
    .restart local v0    # "b":B
    .restart local v2    # "ptr":I
    :cond_4
    const/16 v1, 0x67

    const/16 v6, 0x74

    if-ne v0, v1, :cond_5

    .line 2378
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    aget-byte v1, v1, v2

    if-ne v1, v6, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v3, v2, 0x1

    aget-byte v1, v1, v3

    if-ne v1, v5, :cond_7

    .line 2380
    add-int/lit8 v1, v2, 0x2

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2381
    const/16 v1, 0x3e

    return v1

    .line 2383
    :cond_5
    const/16 v1, 0x6c

    if-ne v0, v1, :cond_6

    .line 2384
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    aget-byte v1, v1, v2

    if-ne v1, v6, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v3, v2, 0x1

    aget-byte v1, v1, v3

    if-ne v1, v5, :cond_7

    .line 2386
    add-int/lit8 v1, v2, 0x2

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2387
    const/16 v1, 0x3c

    return v1

    .line 2389
    :cond_6
    const/16 v1, 0x71

    if-ne v0, v1, :cond_7

    .line 2390
    add-int/lit8 v1, v2, 0x3

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-ge v1, v7, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    aget-byte v1, v1, v2

    const/16 v7, 0x75

    if-ne v1, v7, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v7, v2, 0x1

    aget-byte v1, v1, v7

    if-ne v1, v4, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v4, v2, 0x2

    aget-byte v1, v1, v4

    if-ne v1, v6, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v4, v2, 0x3

    aget-byte v1, v1, v4

    if-ne v1, v5, :cond_7

    .line 2395
    add-int/lit8 v1, v2, 0x4

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2396
    return v3

    .line 2401
    .end local v0    # "b":B
    :cond_7
    move v0, v2

    .end local v2    # "ptr":I
    .local v0, "ptr":I
    :cond_8
    :goto_0
    const/4 v1, 0x0

    return v1
.end method

.method protected handleEntityStartingToken()I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1393
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    .line 1394
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 1395
    .local v0, "b":B
    const/16 v1, 0x23

    const/16 v2, 0x101

    if-ne v0, v1, :cond_1

    .line 1396
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    .line 1397
    const/4 v1, 0x5

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1398
    const/16 v1, -0x46

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 1399
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v1, v3, :cond_0

    .line 1400
    return v2

    .line 1402
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleNumericEntityStartingToken()I

    move-result v1

    return v1

    .line 1404
    :cond_1
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parseNewEntityName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    .line 1406
    .local v1, "n":Lcom/fasterxml/aalto/in/PName;
    if-nez v1, :cond_2

    .line 1408
    const/4 v3, 0x6

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1409
    return v2

    .line 1411
    :cond_2
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeGeneralEntity(Lcom/fasterxml/aalto/in/PName;)I

    move-result v2

    .line 1412
    .local v2, "ch":I
    if-nez v2, :cond_3

    .line 1413
    iput-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 1414
    const/16 v3, 0x9

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    return v3

    .line 1417
    :cond_3
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    int-to-char v4, v2

    invoke-virtual {v3, v4}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithChar(C)V

    .line 1418
    const/4 v3, 0x0

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    .line 1419
    const/4 v3, 0x4

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    .line 1420
    iget-boolean v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_cfgLazyParsing:Z

    if-eqz v3, :cond_4

    .line 1421
    const/4 v3, 0x1

    iput-boolean v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenIncomplete:Z

    goto :goto_0

    .line 1423
    :cond_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->finishCharacters()V

    .line 1425
    :goto_0
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    return v3
.end method

.method protected handleHexEntityInCharacters(I)I
    .locals 6
    .param p1, "ptr"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2430
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v1, p1, 0x1

    .end local p1    # "ptr":I
    .local v1, "ptr":I
    aget-byte p1, v0, p1

    .line 2431
    .local p1, "b":B
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    .line 2432
    .local v0, "end":I
    const/4 v2, 0x0

    .line 2434
    .local v2, "value":I
    :goto_0
    move v3, p1

    .line 2435
    .local v3, "ch":I
    const/16 v4, 0x39

    if-gt v3, v4, :cond_0

    const/16 v4, 0x30

    if-lt v3, v4, :cond_0

    .line 2436
    add-int/lit8 v3, v3, -0x30

    goto :goto_1

    .line 2437
    :cond_0
    const/16 v4, 0x46

    if-gt v3, v4, :cond_1

    const/16 v4, 0x41

    if-lt v3, v4, :cond_1

    .line 2438
    add-int/lit8 v4, v3, -0x41

    add-int/lit8 v3, v4, 0xa

    goto :goto_1

    .line 2439
    :cond_1
    const/16 v4, 0x66

    if-gt v3, v4, :cond_2

    const/16 v4, 0x61

    if-lt v3, v4, :cond_2

    .line 2440
    add-int/lit8 v4, v3, -0x61

    add-int/lit8 v3, v4, 0xa

    goto :goto_1

    .line 2442
    :cond_2
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v4

    const-string v5, " expected a hex digit (0-9a-fA-F) for character entity"

    invoke-virtual {p0, v4, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 2444
    :goto_1
    shl-int/lit8 v4, v2, 0x4

    add-int v2, v4, v3

    .line 2445
    const v4, 0x10ffff

    if-le v2, v4, :cond_3

    .line 2446
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportEntityOverflow()V

    .line 2448
    :cond_3
    if-lt v1, v0, :cond_4

    .line 2449
    const/4 v4, 0x0

    return v4

    .line 2451
    :cond_4
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    add-int/lit8 v5, v1, 0x1

    .end local v1    # "ptr":I
    .local v5, "ptr":I
    aget-byte p1, v4, v1

    .line 2452
    .end local v3    # "ch":I
    const/16 v1, 0x3b

    if-ne p1, v1, :cond_5

    .line 2453
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2454
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->verifyXmlChar(I)V

    .line 2455
    return v2

    .line 2452
    :cond_5
    move v1, v5

    goto :goto_0
.end method

.method protected handleNamedEntityStartingToken()I
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1434
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parseEntityName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    .line 1436
    .local v0, "n":Lcom/fasterxml/aalto/in/PName;
    if-nez v0, :cond_0

    .line 1437
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    return v1

    .line 1439
    :cond_0
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeGeneralEntity(Lcom/fasterxml/aalto/in/PName;)I

    move-result v1

    .line 1440
    .local v1, "ch":I
    if-nez v1, :cond_1

    .line 1441
    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 1442
    const/16 v2, 0x9

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    return v2

    .line 1445
    :cond_1
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    int-to-char v3, v1

    invoke-virtual {v2, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithChar(C)V

    .line 1446
    const/4 v2, 0x0

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    .line 1447
    const/4 v2, 0x4

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    .line 1448
    iget-boolean v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_cfgLazyParsing:Z

    if-eqz v2, :cond_2

    .line 1449
    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenIncomplete:Z

    goto :goto_0

    .line 1451
    :cond_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->finishCharacters()V

    .line 1453
    :goto_0
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    return v2
.end method

.method protected handleNsDecl()Z
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3416
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    .line 3417
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nameBuffer:[C

    .line 3418
    .local v1, "attrBuffer":[C
    iget-byte v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrQuote:B

    .line 3421
    .local v2, "quoteChar":I
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    const/4 v4, 0x0

    if-eqz v3, :cond_1

    .line 3422
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleNsValuePending()Z

    move-result v3

    if-nez v3, :cond_0

    .line 3423
    return v4

    .line 3425
    :cond_0
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3434
    :cond_1
    :goto_0
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v3, v5, :cond_2

    .line 3435
    return v4

    .line 3437
    :cond_2
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    array-length v5, v1

    if-lt v3, v5, :cond_3

    .line 3438
    array-length v3, v1

    invoke-static {v1, v3}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v3

    move-object v1, v3

    iput-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nameBuffer:[C

    .line 3440
    :cond_3
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    .line 3442
    .local v3, "max":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    array-length v6, v1

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    sub-int/2addr v6, v7

    add-int/2addr v5, v6

    .line 3443
    .local v5, "max2":I
    if-ge v5, v3, :cond_4

    .line 3444
    move v3, v5

    .line 3447
    .end local v5    # "max2":I
    :cond_4
    :goto_1
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-ge v5, v3, :cond_11

    .line 3448
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v5, v5, v6

    and-int/lit16 v5, v5, 0xff

    .line 3449
    .local v5, "c":I
    aget v6, v0, v5

    if-eqz v6, :cond_10

    .line 3450
    nop

    .line 3456
    .end local v3    # "max":I
    aget v3, v0, v5

    const v6, 0xdc00

    const v7, 0xd800

    const/4 v8, 0x1

    packed-switch v3, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_3

    .line 3537
    :pswitch_1
    if-ne v5, v2, :cond_f

    .line 3538
    nop

    .line 3552
    .end local v5    # "c":I
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    .line 3553
    .local v3, "attrPtr":I
    if-nez v3, :cond_5

    .line 3554
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    const-string v5, ""

    invoke-virtual {p0, v4, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->bindNs(Lcom/fasterxml/aalto/in/PName;Ljava/lang/String;)V

    goto :goto_2

    .line 3556
    :cond_5
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v4, v1, v3}, Lcom/fasterxml/aalto/in/ReaderConfig;->canonicalizeURI([CI)Ljava/lang/String;

    move-result-object v4

    .line 3557
    .local v4, "uri":Ljava/lang/String;
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p0, v5, v4}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->bindNs(Lcom/fasterxml/aalto/in/PName;Ljava/lang/String;)V

    .line 3559
    .end local v4    # "uri":Ljava/lang/String;
    :goto_2
    return v8

    .line 3494
    .end local v3    # "attrPtr":I
    .restart local v5    # "c":I
    :pswitch_2
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v3, v8

    const/4 v8, 0x3

    if-ge v3, v8, :cond_7

    .line 3495
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v3, v6, :cond_6

    .line 3496
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v3, v3, v6

    and-int/lit16 v3, v3, 0xff

    .line 3497
    .local v3, "d":I
    shl-int/lit8 v6, v3, 0x8

    or-int/2addr v5, v6

    .line 3498
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v6, v7, :cond_6

    .line 3499
    iget-object v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v6, v6, v7

    and-int/lit16 v3, v6, 0xff

    .line 3500
    shl-int/lit8 v6, v3, 0x10

    or-int/2addr v5, v6

    .line 3503
    .end local v3    # "d":I
    :cond_6
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3504
    return v4

    .line 3506
    :cond_7
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_4(I)I

    move-result v3

    .line 3508
    .end local v5    # "c":I
    .local v3, "c":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    add-int/lit8 v8, v5, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    shr-int/lit8 v8, v3, 0xa

    or-int/2addr v7, v8

    int-to-char v7, v7

    aput-char v7, v1, v5

    .line 3509
    and-int/lit16 v5, v3, 0x3ff

    or-int/2addr v5, v6

    .line 3510
    .end local v3    # "c":I
    .restart local v5    # "c":I
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    array-length v6, v1

    if-lt v3, v6, :cond_f

    .line 3511
    array-length v3, v1

    invoke-static {v1, v3}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v3

    move-object v1, v3

    iput-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nameBuffer:[C

    goto/16 :goto_3

    .line 3483
    :pswitch_3
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v3, v6

    const/4 v6, 0x2

    if-ge v3, v6, :cond_9

    .line 3484
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v3, v6, :cond_8

    .line 3485
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v3, v3, v6

    and-int/lit16 v3, v3, 0xff

    .line 3486
    .local v3, "d":I
    shl-int/lit8 v6, v3, 0x8

    or-int/2addr v5, v6

    .line 3488
    .end local v3    # "d":I
    :cond_8
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3489
    return v4

    .line 3491
    :cond_9
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_3(I)I

    move-result v5

    .line 3492
    goto :goto_3

    .line 3476
    :pswitch_4
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v3, v6, :cond_a

    .line 3477
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3478
    return v4

    .line 3480
    :cond_a
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_2(I)I

    move-result v5

    .line 3481
    goto :goto_3

    .line 3515
    :pswitch_5
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInvalidInitial(I)V

    .line 3517
    :pswitch_6
    const-string v3, "\'<\' not allowed in attribute value"

    invoke-virtual {p0, v5, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 3519
    :pswitch_7
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleEntityInAttributeValue()I

    move-result v5

    .line 3520
    if-gtz v5, :cond_c

    .line 3521
    if-gez v5, :cond_b

    .line 3522
    return v4

    .line 3524
    :cond_b
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p0, v3, v8}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportUnexpandedEntityInAttr(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 3527
    :cond_c
    shr-int/lit8 v3, v5, 0x10

    if-eqz v3, :cond_f

    .line 3528
    const/high16 v3, 0x10000

    sub-int/2addr v5, v3

    .line 3529
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    add-int/lit8 v8, v3, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    shr-int/lit8 v8, v5, 0xa

    or-int/2addr v7, v8

    int-to-char v7, v7

    aput-char v7, v1, v3

    .line 3530
    and-int/lit16 v3, v5, 0x3ff

    or-int v5, v3, v6

    .line 3531
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    array-length v6, v1

    if-lt v3, v6, :cond_f

    .line 3532
    array-length v3, v1

    invoke-static {v1, v3}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v3

    move-object v1, v3

    iput-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nameBuffer:[C

    goto :goto_3

    .line 3458
    :pswitch_8
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleInvalidXmlChar(I)C

    move-result v5

    .line 3460
    :pswitch_9
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v3, v6, :cond_d

    .line 3461
    const/4 v3, -0x1

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3462
    return v4

    .line 3464
    :cond_d
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v3, v3, v6

    const/16 v6, 0xa

    if-ne v3, v6, :cond_e

    .line 3465
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v3, v8

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 3469
    :cond_e
    :pswitch_a
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    .line 3473
    :pswitch_b
    const/16 v5, 0x20

    .line 3474
    nop

    .line 3545
    :cond_f
    :goto_3
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    add-int/lit8 v6, v3, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    int-to-char v6, v5

    aput-char v6, v1, v3

    .line 3546
    .end local v5    # "c":I
    goto/16 :goto_0

    .line 3452
    .local v3, "max":I
    .restart local v5    # "c":I
    :cond_10
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemNsPtr:I

    int-to-char v7, v5

    aput-char v7, v1, v6

    goto/16 :goto_1

    .line 3454
    .end local v3    # "max":I
    .end local v5    # "c":I
    :cond_11
    goto/16 :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_8
        :pswitch_9
        :pswitch_a
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_b
        :pswitch_6
        :pswitch_7
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method protected handleNumericEntityStartingToken()I
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1463
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    const/16 v1, -0x46

    const/4 v2, 0x1

    const/4 v3, 0x0

    const/16 v4, -0x49

    const/16 v5, 0x101

    if-ne v0, v1, :cond_1

    .line 1464
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 1465
    .local v0, "b":B
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_entityValue:I

    .line 1466
    const/16 v1, 0x78

    if-ne v0, v1, :cond_0

    .line 1467
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 1468
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v1, v2

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v1, v6, :cond_1

    .line 1469
    return v5

    .line 1472
    :cond_0
    const/16 v1, -0x48

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 1476
    .end local v0    # "b":B
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    if-ne v0, v4, :cond_2

    .line 1477
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeHexEntity()Z

    move-result v0

    if-nez v0, :cond_3

    .line 1478
    return v5

    .line 1481
    :cond_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeDecEntity()Z

    move-result v0

    if-nez v0, :cond_3

    .line 1482
    return v5

    .line 1486
    :cond_3
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_entityValue:I

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->verifyAndAppendEntityCharacter(I)V

    .line 1487
    const/4 v0, 0x4

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    .line 1488
    iget-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_cfgLazyParsing:Z

    if-eqz v0, :cond_4

    .line 1489
    iput-boolean v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenIncomplete:Z

    goto :goto_0

    .line 1491
    :cond_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->finishCharacters()V

    .line 1493
    :goto_0
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 1494
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    return v0
.end method

.method protected handlePI()I
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1211
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    const/4 v1, 0x5

    if-ne v0, v1, :cond_0

    .line 1212
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parsePIData()I

    move-result v0

    return v0

    .line 1217
    :cond_0
    :goto_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    const/16 v3, 0x101

    if-lt v0, v2, :cond_1

    .line 1218
    return v3

    .line 1220
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    const/4 v2, 0x3

    const/16 v4, 0x3e

    const/4 v5, 0x1

    packed-switch v0, :pswitch_data_0

    .line 1298
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInternal()I

    move-result v0

    return v0

    .line 1289
    :pswitch_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parsePName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 1290
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    if-nez v0, :cond_2

    .line 1291
    return v3

    .line 1293
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->checkPITargetName(Lcom/fasterxml/aalto/in/PName;)V

    .line 1294
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1295
    goto :goto_0

    .line 1280
    :pswitch_1
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v5, v1, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 1282
    .local v0, "b":B
    if-eq v0, v4, :cond_3

    .line 1283
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v1

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportMissingPISpace(I)V

    .line 1287
    .end local v0    # "b":B
    :cond_3
    goto/16 :goto_2

    .line 1222
    :pswitch_2
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v6

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parseNewName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 1223
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    if-nez v0, :cond_4

    .line 1224
    const/4 v0, 0x4

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1225
    return v3

    .line 1227
    :cond_4
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1228
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->checkPITargetName(Lcom/fasterxml/aalto/in/PName;)V

    .line 1229
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v6, :cond_5

    .line 1230
    return v3

    .line 1236
    :cond_5
    :pswitch_3
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v6

    .line 1237
    .restart local v0    # "b":B
    const/16 v6, 0x3f

    if-ne v0, v6, :cond_7

    .line 1239
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-ge v6, v7, :cond_6

    iget-object v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v6, v6, v7

    if-ne v6, v4, :cond_6

    .line 1240
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v1, v5

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 1241
    goto :goto_2

    .line 1244
    :cond_6
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1245
    goto/16 :goto_0

    .line 1247
    :cond_7
    const/16 v7, 0x20

    if-eq v0, v7, :cond_a

    const/16 v7, 0xd

    if-eq v0, v7, :cond_a

    const/16 v7, 0xa

    if-eq v0, v7, :cond_a

    const/16 v7, 0x9

    if-ne v0, v7, :cond_8

    goto :goto_1

    .line 1266
    :cond_8
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v2

    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportMissingPISpace(I)V

    .line 1270
    .end local v0    # "b":B
    :pswitch_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->asyncSkipSpace()Z

    move-result v0

    if-nez v0, :cond_9

    .line 1271
    return v3

    .line 1274
    :cond_9
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1275
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    .line 1276
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parsePIData()I

    move-result v0

    return v0

    .line 1249
    .restart local v0    # "b":B
    :cond_a
    :goto_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->asyncSkipSpace()Z

    move-result v7

    const/4 v8, 0x2

    if-nez v7, :cond_b

    .line 1250
    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1251
    return v3

    .line 1253
    :cond_b
    iget-object v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v7}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    .line 1255
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v7, v5

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-ge v7, v9, :cond_c

    iget-object v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v7, v7, v9

    if-ne v7, v6, :cond_c

    iget-object v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v7, v5

    aget-byte v5, v6, v7

    if-ne v5, v4, :cond_c

    .line 1258
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v1, v8

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 1259
    nop

    .line 1302
    .end local v0    # "b":B
    :goto_2
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1303
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    .line 1304
    return v2

    .line 1262
    .restart local v0    # "b":B
    :cond_c
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1263
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parsePIData()I

    move-result v1

    return v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method protected handlePIPending()I
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 429
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    const/16 v1, -0xf

    const/16 v2, 0x101

    const/4 v3, 0x0

    if-ne v0, v1, :cond_2

    .line 430
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 431
    return v2

    .line 433
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 434
    .local v0, "b":B
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 435
    const/16 v1, 0x3e

    if-eq v0, v1, :cond_1

    .line 437
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    const/16 v2, 0x3f

    invoke-virtual {v1, v2}, Lcom/fasterxml/aalto/util/TextBuilder;->append(C)V

    .line 438
    return v3

    .line 440
    :cond_1
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 441
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 442
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    .line 443
    const/4 v1, 0x3

    return v1

    .line 446
    .end local v0    # "b":B
    :cond_2
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleAndAppendPending()Z

    move-result v0

    if-eqz v0, :cond_3

    move v2, v3

    :cond_3
    return v2
.end method

.method protected final handlePartialCR()Z
    .locals 3

    .line 3940
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    .line 3941
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInternal()I

    .line 3943
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    const/4 v2, 0x0

    if-lt v0, v1, :cond_1

    .line 3944
    return v2

    .line 3946
    :cond_1
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 3947
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    const/16 v1, 0xa

    const/4 v2, 0x1

    if-ne v0, v1, :cond_2

    .line 3948
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v0, v2

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 3950
    :cond_2
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currRow:I

    add-int/2addr v0, v2

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currRow:I

    .line 3951
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_rowStartOffset:I

    .line 3952
    return v2
.end method

.method protected handleStartElement()I
    .locals 16
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1614
    move-object/from16 v0, p0

    :goto_0
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v2, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    const/16 v3, 0x101

    if-lt v1, v2, :cond_0

    .line 1615
    return v3

    .line 1621
    :cond_0
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    const/4 v2, -0x1

    const/16 v4, 0xd

    const/4 v5, 0x0

    const/16 v6, 0x2f

    const/4 v7, 0x2

    const/4 v8, 0x5

    const/16 v9, 0x3e

    const/16 v10, 0x9

    const/16 v11, 0xa

    const/16 v12, 0x20

    const/4 v13, 0x1

    packed-switch v1, :pswitch_data_0

    .line 1785
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInternal()I

    goto :goto_0

    .line 1778
    :pswitch_0
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v2, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v2

    .line 1779
    .local v1, "b":B
    if-eq v1, v9, :cond_1

    .line 1780
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v2

    const-string v3, " expected \'>\'"

    invoke-virtual {v0, v2, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1782
    :cond_1
    invoke-direct {v0, v13}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->finishStartElement(Z)I

    move-result v2

    return v2

    .line 1770
    .end local v1    # "b":B
    :pswitch_1
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleNsDecl()Z

    move-result v1

    if-nez v1, :cond_2

    .line 1771
    return v3

    .line 1773
    :cond_2
    iput v7, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1774
    goto :goto_0

    .line 1763
    :pswitch_2
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleAttrValue()Z

    move-result v1

    if-nez v1, :cond_3

    .line 1764
    return v3

    .line 1766
    :cond_3
    iput v7, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1767
    goto :goto_0

    .line 1624
    :pswitch_3
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parsePName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    .line 1625
    .local v1, "elemName":Lcom/fasterxml/aalto/in/PName;
    if-nez v1, :cond_4

    .line 1626
    return v3

    .line 1628
    :cond_4
    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->initStartElement(Lcom/fasterxml/aalto/in/PName;)V

    .line 1630
    .end local v1    # "elemName":Lcom/fasterxml/aalto/in/PName;
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v7, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v1, v7, :cond_5

    .line 1631
    return v3

    .line 1636
    :cond_5
    :pswitch_4
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    if-eqz v1, :cond_6

    .line 1637
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handlePartialCR()Z

    move-result v1

    if-nez v1, :cond_e

    .line 1638
    return v3

    .line 1642
    :cond_6
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v7, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v14, v7, 0x1

    iput v14, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v7

    .line 1643
    .local v1, "b":B
    and-int/lit16 v7, v1, 0xff

    .line 1645
    .local v7, "c":I
    if-gt v7, v12, :cond_b

    .line 1646
    if-ne v7, v11, :cond_7

    .line 1647
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    goto :goto_1

    .line 1648
    :cond_7
    if-ne v7, v4, :cond_a

    .line 1649
    iget v14, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v15, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v14, v15, :cond_8

    .line 1650
    iput v2, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 1651
    return v3

    .line 1653
    :cond_8
    iget-object v14, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v15, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v14, v14, v15

    if-ne v14, v11, :cond_9

    .line 1654
    iget v14, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v14, v13

    iput v14, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 1656
    :cond_9
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    goto :goto_1

    .line 1657
    :cond_a
    if-eq v7, v12, :cond_e

    if-eq v7, v10, :cond_e

    .line 1658
    invoke-virtual {v0, v7}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInvalidSpace(I)V

    goto :goto_1

    .line 1660
    :cond_b
    if-ne v7, v9, :cond_c

    .line 1661
    invoke-direct {v0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->finishStartElement(Z)I

    move-result v2

    return v2

    .line 1662
    :cond_c
    if-ne v7, v6, :cond_d

    .line 1663
    iput v10, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1664
    goto/16 :goto_0

    .line 1666
    :cond_d
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v14

    const-string v15, " expected space, or \'>\' or \"/>\""

    invoke-virtual {v0, v14, v15}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1669
    .end local v1    # "b":B
    .end local v7    # "c":I
    :cond_e
    :goto_1
    const/4 v1, 0x3

    iput v1, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1670
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v7, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v1, v7, :cond_f

    .line 1671
    return v3

    .line 1681
    :cond_f
    :pswitch_5
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    if-eqz v1, :cond_11

    .line 1682
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handlePartialCR()Z

    move-result v1

    if-nez v1, :cond_10

    .line 1683
    return v3

    .line 1685
    :cond_10
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v7, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v1, v7, :cond_11

    .line 1686
    return v3

    .line 1689
    :cond_11
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v7, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v14, v7, 0x1

    iput v14, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v7

    .line 1690
    .restart local v1    # "b":B
    and-int/lit16 v7, v1, 0xff

    .line 1692
    .restart local v7    # "c":I
    :goto_2
    if-gt v7, v12, :cond_18

    .line 1693
    if-ne v7, v11, :cond_12

    .line 1694
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    goto :goto_3

    .line 1695
    :cond_12
    if-ne v7, v4, :cond_15

    .line 1696
    iget v14, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v15, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v14, v15, :cond_13

    .line 1697
    iput v2, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 1698
    return v3

    .line 1700
    :cond_13
    iget-object v14, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v15, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v14, v14, v15

    if-ne v14, v11, :cond_14

    .line 1701
    iget v14, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v14, v13

    iput v14, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 1703
    :cond_14
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    goto :goto_3

    .line 1704
    :cond_15
    if-eq v7, v12, :cond_16

    if-eq v7, v10, :cond_16

    .line 1705
    invoke-virtual {v0, v7}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInvalidSpace(I)V

    .line 1707
    :cond_16
    :goto_3
    iget v14, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v15, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v14, v15, :cond_17

    .line 1708
    return v3

    .line 1710
    :cond_17
    iget-object v14, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v15, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v2, v15, 0x1

    iput v2, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v14, v15

    .line 1711
    and-int/lit16 v7, v1, 0xff

    const/4 v2, -0x1

    goto :goto_2

    .line 1714
    :cond_18
    iget v2, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    packed-switch v2, :pswitch_data_1

    .line 1748
    :pswitch_6
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInternal()I

    goto :goto_4

    .line 1742
    :pswitch_7
    const/16 v2, 0x22

    if-eq v1, v2, :cond_19

    const/16 v2, 0x27

    if-eq v1, v2, :cond_19

    .line 1743
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v2

    const-string v3, " Expected a quote"

    invoke-virtual {v0, v2, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1745
    :cond_19
    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->initAttribute(B)V

    .line 1746
    goto/16 :goto_0

    .line 1735
    :pswitch_8
    const/16 v2, 0x3d

    if-eq v1, v2, :cond_1a

    .line 1736
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v2

    const-string v3, " expected \'=\'"

    invoke-virtual {v0, v2, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1738
    :cond_1a
    const/4 v2, 0x6

    iput v2, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1739
    goto/16 :goto_0

    .line 1716
    :pswitch_9
    if-ne v1, v6, :cond_1b

    .line 1717
    iput v10, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1718
    goto/16 :goto_0

    .line 1720
    :cond_1b
    if-ne v1, v9, :cond_1c

    .line 1721
    invoke-direct {v0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->finishStartElement(Z)I

    move-result v2

    return v2

    .line 1724
    :cond_1c
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parseNewName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    .line 1725
    .local v2, "n":Lcom/fasterxml/aalto/in/PName;
    if-nez v2, :cond_1d

    .line 1726
    const/4 v4, 0x4

    iput v4, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1727
    return v3

    .line 1729
    :cond_1d
    iput v8, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1730
    iput-object v2, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    .line 1732
    .end local v2    # "n":Lcom/fasterxml/aalto/in/PName;
    goto/16 :goto_0

    .line 1753
    .end local v1    # "b":B
    .end local v7    # "c":I
    :goto_4
    :pswitch_a
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parsePName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    .line 1754
    .local v1, "n":Lcom/fasterxml/aalto/in/PName;
    if-nez v1, :cond_1e

    .line 1755
    return v3

    .line 1757
    :cond_1e
    iput-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    .line 1758
    iput v8, v0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1760
    .end local v1    # "n":Lcom/fasterxml/aalto/in/PName;
    goto/16 :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_a
        :pswitch_5
        :pswitch_5
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x3
        :pswitch_9
        :pswitch_6
        :pswitch_8
        :pswitch_7
    .end packed-switch
.end method

.method protected handleStartElementStart(B)I
    .locals 2
    .param p1, "b"    # B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1599
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parseNewName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    .line 1600
    .local v0, "elemName":Lcom/fasterxml/aalto/in/PName;
    const/4 v1, 0x1

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    .line 1601
    if-nez v0, :cond_0

    .line 1602
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1603
    const/16 v1, 0x101

    return v1

    .line 1605
    :cond_0
    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->initStartElement(Lcom/fasterxml/aalto/in/PName;)V

    .line 1606
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleStartElement()I

    move-result v1

    return v1
.end method

.method public final needMoreInput()Z
    .locals 2

    .line 945
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    iget-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_endOfInput:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public nextFromTree()I
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 980
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    const/4 v1, 0x2

    const/4 v2, 0x0

    const/4 v3, 0x1

    const/16 v4, 0x101

    if-eq v0, v4, :cond_4

    .line 984
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    if-ne v0, v3, :cond_0

    .line 985
    iget-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_isEmptyTag:Z

    if-eqz v0, :cond_1

    .line 986
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_depth:I

    sub-int/2addr v0, v3

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_depth:I

    .line 988
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    return v1

    .line 990
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    if-ne v0, v1, :cond_1

    .line 991
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currElem:Lcom/fasterxml/aalto/in/ElementScope;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ElementScope;->getParent()Lcom/fasterxml/aalto/in/ElementScope;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currElem:Lcom/fasterxml/aalto/in/ElementScope;

    .line 993
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->getLevel()I

    move-result v0

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_depth:I

    if-lt v0, v5, :cond_1

    .line 994
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->unbind()Lcom/fasterxml/aalto/in/NsDeclaration;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    goto :goto_0

    .line 999
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->setStartLocation()V

    .line 1006
    iget-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenIncomplete:Z

    if-eqz v0, :cond_3

    .line 1007
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->skipCharacters()Z

    move-result v0

    if-nez v0, :cond_2

    .line 1008
    return v4

    .line 1010
    :cond_2
    iput-boolean v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenIncomplete:Z

    .line 1012
    :cond_3
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    .line 1013
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1017
    :cond_4
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    if-ne v0, v4, :cond_16

    .line 1018
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    if-nez v0, :cond_9

    .line 1022
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    const/4 v4, 0x4

    if-eqz v0, :cond_5

    .line 1023
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    .line 1024
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->startCharactersPending()I

    move-result v0

    return v0

    .line 1026
    :cond_5
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v5, :cond_6

    .line 1027
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    return v0

    .line 1029
    :cond_6
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v5

    .line 1030
    .local v0, "b":B
    const/16 v5, 0x3c

    if-ne v0, v5, :cond_7

    .line 1031
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    goto :goto_1

    .line 1032
    :cond_7
    const/16 v5, 0x26

    if-ne v0, v5, :cond_8

    .line 1033
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    goto :goto_1

    .line 1035
    :cond_8
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    .line 1036
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->startCharacters(B)I

    move-result v1

    return v1

    .line 1040
    .end local v0    # "b":B
    :cond_9
    :goto_1
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v4, :cond_a

    .line 1041
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    return v0

    .line 1043
    :cond_a
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    const/4 v4, 0x5

    const/4 v5, 0x3

    if-ne v0, v3, :cond_e

    .line 1045
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 1046
    .restart local v0    # "b":B
    const/16 v1, 0x21

    if-ne v0, v1, :cond_b

    .line 1047
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1058
    .end local v0    # "b":B
    goto :goto_2

    .line 1048
    .restart local v0    # "b":B
    :cond_b
    const/16 v1, 0x3f

    if-ne v0, v1, :cond_c

    .line 1049
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    .line 1050
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 1051
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handlePI()I

    move-result v1

    return v1

    .line 1052
    :cond_c
    const/16 v1, 0x2f

    if-ne v0, v1, :cond_d

    .line 1053
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleEndElementStart()I

    move-result v1

    return v1

    .line 1056
    :cond_d
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleStartElementStart(B)I

    move-result v1

    return v1

    .line 1058
    .end local v0    # "b":B
    :cond_e
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    if-ne v0, v1, :cond_f

    .line 1059
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleEntityStartingToken()I

    move-result v0

    return v0

    .line 1060
    :cond_f
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    const/4 v1, 0x6

    if-ne v0, v1, :cond_10

    .line 1061
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleNamedEntityStartingToken()I

    move-result v0

    return v0

    .line 1062
    :cond_10
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    if-ne v0, v4, :cond_11

    .line 1063
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleNumericEntityStartingToken()I

    move-result v0

    return v0

    .line 1066
    :cond_11
    :goto_2
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    if-ne v0, v5, :cond_15

    .line 1067
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v0, v1, :cond_12

    .line 1068
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    return v0

    .line 1070
    :cond_12
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 1072
    .restart local v0    # "b":B
    const/16 v1, 0x2d

    if-ne v0, v1, :cond_13

    .line 1073
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    .line 1074
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    goto :goto_3

    .line 1075
    :cond_13
    const/16 v1, 0x5b

    if-ne v0, v1, :cond_14

    .line 1076
    const/16 v1, 0xc

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    .line 1077
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    goto :goto_3

    .line 1079
    :cond_14
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeCharForError(B)I

    move-result v1

    const-string v2, " (expected either \'-\' for COMMENT or \'[CDATA[\' for CDATA section)"

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 1081
    .end local v0    # "b":B
    :goto_3
    goto :goto_4

    .line 1082
    :cond_15
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInternal()I

    .line 1089
    :cond_16
    :goto_4
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    sparse-switch v0, :sswitch_data_0

    goto :goto_5

    .line 1099
    :sswitch_0
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleCData()I

    move-result v0

    return v0

    .line 1097
    :sswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleComment()I

    move-result v0

    return v0

    .line 1101
    :sswitch_2
    iget-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_cfgLazyParsing:Z

    if-nez v0, :cond_17

    .line 1103
    iget-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_cfgCoalescing:Z

    if-eqz v0, :cond_17

    .line 1104
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->finishCharactersCoalescing()I

    move-result v0

    return v0

    .line 1107
    :cond_17
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    if-eqz v0, :cond_18

    .line 1108
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->startCharactersPending()I

    move-result v0

    return v0

    .line 1111
    :cond_18
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInternal()I

    goto :goto_5

    .line 1095
    :sswitch_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handlePI()I

    move-result v0

    return v0

    .line 1093
    :sswitch_4
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleEndElement()I

    move-result v0

    return v0

    .line 1091
    :sswitch_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleStartElement()I

    move-result v0

    return v0

    .line 1114
    :goto_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInternal()I

    move-result v0

    return v0

    nop

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_5
        0x2 -> :sswitch_4
        0x3 -> :sswitch_3
        0x4 -> :sswitch_2
        0x5 -> :sswitch_1
        0xc -> :sswitch_0
    .end sparse-switch
.end method

.method protected final parseCDataContents()I
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 614
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    if-eqz v0, :cond_0

    .line 615
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleCDataPending()I

    move-result v0

    .line 617
    .local v0, "result":I
    if-eqz v0, :cond_0

    .line 618
    return v0

    .line 622
    .end local v0    # "result":I
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v0

    .line 623
    .local v0, "outputBuffer":[C
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->getCurrentLength()I

    move-result v1

    .line 625
    .local v1, "outPtr":I
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v2, v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 626
    .local v2, "TYPES":[I
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    .line 634
    .local v3, "inputBuffer":[B
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    const/16 v6, 0x101

    if-lt v4, v5, :cond_1

    .line 635
    goto/16 :goto_4

    .line 637
    :cond_1
    array-length v4, v0

    if-lt v1, v4, :cond_2

    .line 638
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v0

    .line 639
    const/4 v1, 0x0

    .line 641
    :cond_2
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    .line 643
    .local v4, "max":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    array-length v7, v0

    sub-int/2addr v7, v1

    add-int/2addr v5, v7

    .line 644
    .local v5, "max2":I
    if-ge v5, v4, :cond_3

    .line 645
    move v4, v5

    .line 648
    .end local v5    # "max2":I
    :cond_3
    :goto_1
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-ge v5, v4, :cond_14

    .line 649
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v5, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v5, v3, v5

    and-int/lit16 v5, v5, 0xff

    .line 650
    .local v5, "c":I
    aget v7, v2, v5

    if-eqz v7, :cond_13

    .line 651
    nop

    .line 657
    .end local v4    # "max":I
    aget v4, v2, v5

    packed-switch v4, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_5

    .line 695
    :pswitch_1
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v4, v7

    const/4 v7, 0x3

    if-ge v4, v7, :cond_5

    .line 696
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v4, v7, :cond_4

    .line 697
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v4, v7

    and-int/lit16 v4, v4, 0xff

    .line 698
    .local v4, "d":I
    shl-int/lit8 v7, v4, 0x8

    or-int/2addr v5, v7

    .line 699
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v7, v8, :cond_4

    .line 700
    iget-object v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v7, v7, v8

    and-int/lit16 v4, v7, 0xff

    .line 701
    shl-int/lit8 v7, v4, 0x10

    or-int/2addr v5, v7

    .line 704
    .end local v4    # "d":I
    :cond_4
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 705
    goto/16 :goto_4

    .line 707
    :cond_5
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_4(I)I

    move-result v4

    .line 709
    .end local v5    # "c":I
    .local v4, "c":I
    add-int/lit8 v5, v1, 0x1

    .end local v1    # "outPtr":I
    .local v5, "outPtr":I
    shr-int/lit8 v6, v4, 0xa

    const v7, 0xd800

    or-int/2addr v6, v7

    int-to-char v6, v6

    aput-char v6, v0, v1

    .line 710
    array-length v1, v0

    if-lt v5, v1, :cond_6

    .line 711
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v0

    .line 712
    const/4 v1, 0x0

    .end local v5    # "outPtr":I
    .restart local v1    # "outPtr":I
    goto :goto_2

    .line 710
    .end local v1    # "outPtr":I
    .restart local v5    # "outPtr":I
    :cond_6
    move v1, v5

    .line 714
    .end local v5    # "outPtr":I
    .restart local v1    # "outPtr":I
    :goto_2
    and-int/lit16 v5, v4, 0x3ff

    const v6, 0xdc00

    or-int/2addr v5, v6

    .line 716
    .end local v4    # "c":I
    .local v5, "c":I
    goto/16 :goto_5

    .line 684
    :pswitch_2
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v4, v7

    const/4 v7, 0x2

    if-ge v4, v7, :cond_8

    .line 685
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v4, v7, :cond_7

    .line 686
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v4, v7

    and-int/lit16 v4, v4, 0xff

    .line 687
    .local v4, "d":I
    shl-int/lit8 v7, v4, 0x8

    or-int/2addr v5, v7

    .line 689
    .end local v4    # "d":I
    :cond_7
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 690
    goto/16 :goto_4

    .line 692
    :cond_8
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_3(I)I

    move-result v5

    .line 693
    goto/16 :goto_5

    .line 677
    :pswitch_3
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v7, :cond_9

    .line 678
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 679
    goto/16 :goto_4

    .line 681
    :cond_9
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_2(I)I

    move-result v5

    .line 682
    goto/16 :goto_5

    .line 718
    :pswitch_4
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInvalidInitial(I)V

    .line 720
    :pswitch_5
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v7, :cond_a

    .line 721
    const/16 v4, -0x1e

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 722
    goto/16 :goto_4

    .line 725
    :cond_a
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v4, v7

    const/16 v7, 0x5d

    if-ne v4, v7, :cond_12

    .line 726
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 728
    :goto_3
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v8, :cond_b

    .line 729
    const/16 v4, -0x1f

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 730
    goto :goto_4

    .line 732
    :cond_b
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v4, v8

    const/16 v8, 0x3e

    if-ne v4, v8, :cond_c

    .line 733
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 734
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 735
    const/4 v4, 0x0

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 736
    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    .line 737
    const/16 v4, 0xc

    return v4

    .line 739
    :cond_c
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v4, v8

    if-eq v4, v7, :cond_e

    .line 740
    add-int/lit8 v4, v1, 0x1

    .end local v1    # "outPtr":I
    .local v4, "outPtr":I
    aput-char v7, v0, v1

    .line 741
    array-length v1, v0

    if-lt v4, v1, :cond_d

    .line 742
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v0

    .line 743
    const/4 v4, 0x0

    .line 745
    :cond_d
    add-int/lit8 v1, v4, 0x1

    .end local v4    # "outPtr":I
    .restart local v1    # "outPtr":I
    aput-char v7, v0, v4

    .line 746
    goto/16 :goto_0

    .line 749
    :cond_e
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 750
    add-int/lit8 v4, v1, 0x1

    .end local v1    # "outPtr":I
    .restart local v4    # "outPtr":I
    aput-char v7, v0, v1

    .line 751
    array-length v1, v0

    if-lt v4, v1, :cond_f

    .line 752
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v0

    .line 753
    const/4 v1, 0x0

    .end local v4    # "outPtr":I
    .restart local v1    # "outPtr":I
    goto :goto_3

    .line 751
    .end local v1    # "outPtr":I
    .restart local v4    # "outPtr":I
    :cond_f
    move v1, v4

    goto :goto_3

    .line 674
    .end local v4    # "outPtr":I
    .restart local v1    # "outPtr":I
    :pswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    .line 675
    goto :goto_5

    .line 659
    :pswitch_7
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleInvalidXmlChar(I)C

    move-result v5

    .line 662
    :pswitch_8
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v7, :cond_10

    .line 663
    const/4 v4, -0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 664
    nop

    .line 766
    .end local v5    # "c":I
    :goto_4
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 767
    return v6

    .line 666
    .restart local v5    # "c":I
    :cond_10
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v3, v4

    const/16 v6, 0xa

    if-ne v4, v6, :cond_11

    .line 667
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 669
    :cond_11
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    .line 671
    const/16 v5, 0xa

    .line 672
    nop

    .line 763
    :cond_12
    :goto_5
    add-int/lit8 v4, v1, 0x1

    .end local v1    # "outPtr":I
    .restart local v4    # "outPtr":I
    int-to-char v6, v5

    aput-char v6, v0, v1

    .line 764
    .end local v5    # "c":I
    move v1, v4

    goto/16 :goto_0

    .line 653
    .restart local v1    # "outPtr":I
    .local v4, "max":I
    .restart local v5    # "c":I
    :cond_13
    add-int/lit8 v7, v1, 0x1

    .end local v1    # "outPtr":I
    .local v7, "outPtr":I
    int-to-char v8, v5

    aput-char v8, v0, v1

    move v1, v7

    goto/16 :goto_1

    .line 655
    .end local v4    # "max":I
    .end local v5    # "c":I
    .end local v7    # "outPtr":I
    .restart local v1    # "outPtr":I
    :cond_14
    goto/16 :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_7
        :pswitch_8
        :pswitch_6
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_5
    .end packed-switch
.end method

.method protected parseCommentContents()I
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 102
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    if-eqz v0, :cond_0

    .line 103
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleCommentPending()I

    move-result v0

    .line 105
    .local v0, "result":I
    if-eqz v0, :cond_0

    .line 106
    return v0

    .line 111
    .end local v0    # "result":I
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v0

    .line 112
    .local v0, "outputBuffer":[C
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->getCurrentLength()I

    move-result v1

    .line 114
    .local v1, "outPtr":I
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v2, v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 115
    .local v2, "TYPES":[I
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    .line 123
    .local v3, "inputBuffer":[B
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    const/16 v6, 0x101

    if-lt v4, v5, :cond_1

    .line 124
    goto/16 :goto_3

    .line 126
    :cond_1
    array-length v4, v0

    if-lt v1, v4, :cond_2

    .line 127
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v0

    .line 128
    const/4 v1, 0x0

    .line 130
    :cond_2
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    .line 132
    .local v4, "max":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    array-length v7, v0

    sub-int/2addr v7, v1

    add-int/2addr v5, v7

    .line 133
    .local v5, "max2":I
    if-ge v5, v4, :cond_3

    .line 134
    move v4, v5

    .line 137
    .end local v5    # "max2":I
    :cond_3
    :goto_1
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-ge v5, v4, :cond_11

    .line 138
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v5, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v5, v3, v5

    and-int/lit16 v5, v5, 0xff

    .line 139
    .local v5, "c":I
    aget v7, v2, v5

    if-eqz v7, :cond_10

    .line 140
    nop

    .line 146
    .end local v4    # "max":I
    aget v4, v2, v5

    packed-switch v4, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_4

    .line 184
    :pswitch_1
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v4, v7

    const/4 v7, 0x3

    if-ge v4, v7, :cond_5

    .line 185
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v4, v7, :cond_4

    .line 186
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v4, v7

    and-int/lit16 v4, v4, 0xff

    .line 187
    .local v4, "d":I
    shl-int/lit8 v7, v4, 0x8

    or-int/2addr v5, v7

    .line 188
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v7, v8, :cond_4

    .line 189
    iget-object v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v7, v7, v8

    and-int/lit16 v4, v7, 0xff

    .line 190
    shl-int/lit8 v7, v4, 0x10

    or-int/2addr v5, v7

    .line 193
    .end local v4    # "d":I
    :cond_4
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 194
    goto/16 :goto_3

    .line 196
    :cond_5
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_4(I)I

    move-result v4

    .line 198
    .end local v5    # "c":I
    .local v4, "c":I
    add-int/lit8 v5, v1, 0x1

    .end local v1    # "outPtr":I
    .local v5, "outPtr":I
    shr-int/lit8 v6, v4, 0xa

    const v7, 0xd800

    or-int/2addr v6, v7

    int-to-char v6, v6

    aput-char v6, v0, v1

    .line 199
    array-length v1, v0

    if-lt v5, v1, :cond_6

    .line 200
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v0

    .line 201
    const/4 v1, 0x0

    .end local v5    # "outPtr":I
    .restart local v1    # "outPtr":I
    goto :goto_2

    .line 199
    .end local v1    # "outPtr":I
    .restart local v5    # "outPtr":I
    :cond_6
    move v1, v5

    .line 203
    .end local v5    # "outPtr":I
    .restart local v1    # "outPtr":I
    :goto_2
    and-int/lit16 v5, v4, 0x3ff

    const v6, 0xdc00

    or-int/2addr v5, v6

    .line 205
    .end local v4    # "c":I
    .local v5, "c":I
    goto/16 :goto_4

    .line 173
    :pswitch_2
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v4, v7

    const/4 v7, 0x2

    if-ge v4, v7, :cond_8

    .line 174
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v4, v7, :cond_7

    .line 175
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v4, v7

    and-int/lit16 v4, v4, 0xff

    .line 176
    .local v4, "d":I
    shl-int/lit8 v7, v4, 0x8

    or-int/2addr v5, v7

    .line 178
    .end local v4    # "d":I
    :cond_7
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 179
    goto/16 :goto_3

    .line 181
    :cond_8
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_3(I)I

    move-result v5

    .line 182
    goto/16 :goto_4

    .line 166
    :pswitch_3
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v7, :cond_9

    .line 167
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 168
    goto :goto_3

    .line 170
    :cond_9
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_2(I)I

    move-result v5

    .line 171
    goto/16 :goto_4

    .line 207
    :pswitch_4
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInvalidInitial(I)V

    .line 209
    :pswitch_5
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v7, :cond_a

    .line 210
    const/16 v4, -0x14

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 211
    goto :goto_3

    .line 213
    :cond_a
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v4, v7

    const/16 v7, 0x2d

    if-ne v4, v7, :cond_f

    .line 214
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 215
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v7, :cond_b

    .line 216
    const/16 v4, -0x15

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 217
    goto :goto_3

    .line 219
    :cond_b
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v4, v7

    const/16 v7, 0x3e

    if-eq v4, v7, :cond_c

    .line 220
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportDoubleHyphenInComments()V

    .line 222
    :cond_c
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 223
    const/4 v4, 0x0

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 224
    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    .line 225
    const/4 v4, 0x5

    return v4

    .line 163
    :pswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    .line 164
    goto :goto_4

    .line 148
    :pswitch_7
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleInvalidXmlChar(I)C

    move-result v5

    .line 151
    :pswitch_8
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v7, :cond_d

    .line 152
    const/4 v4, -0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 153
    nop

    .line 236
    .end local v5    # "c":I
    :goto_3
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 237
    return v6

    .line 155
    .restart local v5    # "c":I
    :cond_d
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v3, v4

    const/16 v6, 0xa

    if-ne v4, v6, :cond_e

    .line 156
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 158
    :cond_e
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    .line 160
    const/16 v5, 0xa

    .line 161
    nop

    .line 233
    :cond_f
    :goto_4
    add-int/lit8 v4, v1, 0x1

    .end local v1    # "outPtr":I
    .local v4, "outPtr":I
    int-to-char v6, v5

    aput-char v6, v0, v1

    .line 234
    .end local v5    # "c":I
    move v1, v4

    goto/16 :goto_0

    .line 142
    .restart local v1    # "outPtr":I
    .local v4, "max":I
    .restart local v5    # "c":I
    :cond_10
    add-int/lit8 v7, v1, 0x1

    .end local v1    # "outPtr":I
    .local v7, "outPtr":I
    int-to-char v8, v5

    aput-char v8, v0, v1

    move v1, v7

    goto/16 :goto_1

    .line 144
    .end local v4    # "max":I
    .end local v5    # "c":I
    .end local v7    # "outPtr":I
    .restart local v1    # "outPtr":I
    :cond_11
    goto/16 :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_7
        :pswitch_8
        :pswitch_6
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_5
    .end packed-switch
.end method

.method protected final parseEntityName()Lcom/fasterxml/aalto/in/PName;
    .locals 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3805
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuad:I

    .line 3810
    .local v0, "q":I
    :goto_0
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuadBytes:I

    const/16 v2, 0x2f

    const/16 v3, 0x3a

    const/16 v4, 0x2d

    const/4 v5, 0x0

    const/16 v6, 0x41

    const/4 v7, 0x0

    const/4 v8, 0x1

    packed-switch v1, :pswitch_data_0

    goto/16 :goto_1

    .line 3812
    :pswitch_0
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v1, v9, :cond_0

    .line 3813
    return-object v5

    .line 3815
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v10, v9, 0x1

    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v9

    and-int/lit16 v0, v1, 0xff

    .line 3822
    if-ge v0, v6, :cond_4

    .line 3824
    if-lt v0, v4, :cond_1

    if-gt v0, v3, :cond_1

    if-ne v0, v2, :cond_4

    .line 3826
    :cond_1
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadCount:I

    if-ne v1, v8, :cond_3

    .line 3827
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadBuffer:[I

    aget v0, v1, v7

    .line 3828
    sget v1, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_APOS_QUAD:I

    if-ne v0, v1, :cond_2

    .line 3829
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v1, v8

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 3830
    sget-object v1, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_APOS:Lcom/fasterxml/aalto/in/PNameC;

    return-object v1

    .line 3832
    :cond_2
    sget v1, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_QUOT_QUAD:I

    if-ne v0, v1, :cond_3

    .line 3833
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v1, v8

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 3834
    sget-object v1, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_QUOT:Lcom/fasterxml/aalto/in/PNameC;

    return-object v1

    .line 3838
    :cond_3
    invoke-virtual {p0, v0, v7}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1

    .line 3844
    :cond_4
    :pswitch_1
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v1, v9, :cond_5

    .line 3845
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuad:I

    .line 3846
    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuadBytes:I

    .line 3847
    return-object v5

    .line 3849
    :cond_5
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v10, v9, 0x1

    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v9

    and-int/lit16 v1, v1, 0xff

    .line 3850
    .local v1, "i":I
    if-ge v1, v6, :cond_7

    .line 3851
    if-lt v1, v4, :cond_6

    if-gt v1, v3, :cond_6

    if-ne v1, v2, :cond_7

    .line 3852
    :cond_6
    invoke-virtual {p0, v0, v8}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    return-object v2

    .line 3855
    :cond_7
    shl-int/lit8 v9, v0, 0x8

    or-int v0, v9, v1

    .line 3859
    .end local v1    # "i":I
    :pswitch_2
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    const/4 v10, 0x2

    if-lt v1, v9, :cond_8

    .line 3860
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuad:I

    .line 3861
    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuadBytes:I

    .line 3862
    return-object v5

    .line 3864
    :cond_8
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v11, v9, 0x1

    iput v11, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v9

    and-int/lit16 v1, v1, 0xff

    .line 3865
    .restart local v1    # "i":I
    if-ge v1, v6, :cond_c

    .line 3866
    if-lt v1, v4, :cond_9

    if-gt v1, v3, :cond_9

    if-ne v1, v2, :cond_c

    .line 3868
    :cond_9
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadCount:I

    if-nez v2, :cond_b

    .line 3869
    sget v2, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_GT_QUAD:I

    if-ne v0, v2, :cond_a

    .line 3870
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v2, v8

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 3871
    sget-object v2, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_GT:Lcom/fasterxml/aalto/in/PNameC;

    return-object v2

    .line 3873
    :cond_a
    sget v2, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_LT_QUAD:I

    if-ne v0, v2, :cond_b

    .line 3874
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v2, v8

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 3875
    sget-object v2, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_LT:Lcom/fasterxml/aalto/in/PNameC;

    return-object v2

    .line 3878
    :cond_b
    invoke-virtual {p0, v0, v10}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    return-object v2

    .line 3881
    :cond_c
    shl-int/lit8 v9, v0, 0x8

    or-int v0, v9, v1

    .line 3885
    .end local v1    # "i":I
    :pswitch_3
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    const/4 v10, 0x3

    if-lt v1, v9, :cond_d

    .line 3886
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuad:I

    .line 3887
    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuadBytes:I

    .line 3888
    return-object v5

    .line 3890
    :cond_d
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v9, v5, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v5

    and-int/lit16 v1, v1, 0xff

    .line 3891
    .restart local v1    # "i":I
    if-ge v1, v6, :cond_10

    .line 3892
    if-lt v1, v4, :cond_e

    if-gt v1, v3, :cond_e

    if-ne v1, v2, :cond_10

    .line 3894
    :cond_e
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadCount:I

    if-nez v2, :cond_f

    .line 3895
    sget v2, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_AMP_QUAD:I

    if-ne v0, v2, :cond_f

    .line 3896
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v2, v8

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 3897
    sget-object v2, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_AMP:Lcom/fasterxml/aalto/in/PNameC;

    return-object v2

    .line 3900
    :cond_f
    invoke-virtual {p0, v0, v10}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    return-object v2

    .line 3903
    :cond_10
    shl-int/lit8 v2, v0, 0x8

    or-int v0, v2, v1

    .line 3909
    .end local v1    # "i":I
    :goto_1
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadCount:I

    if-nez v1, :cond_11

    .line 3910
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadBuffer:[I

    aput v0, v1, v7

    .line 3911
    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadCount:I

    goto :goto_2

    .line 3913
    :cond_11
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadCount:I

    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadBuffer:[I

    array-length v2, v2

    if-lt v1, v2, :cond_12

    .line 3914
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadBuffer:[I

    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadBuffer:[I

    array-length v2, v2

    invoke-static {v1, v2}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([II)[I

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadBuffer:[I

    .line 3916
    :cond_12
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadBuffer:[I

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadCount:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadCount:I

    aput v0, v1, v2

    .line 3918
    :goto_2
    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuadBytes:I

    goto/16 :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method protected final parseNewEntityName(B)Lcom/fasterxml/aalto/in/PName;
    .locals 2
    .param p1, "b"    # B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3793
    and-int/lit16 v0, p1, 0xff

    .line 3794
    .local v0, "q":I
    const/16 v1, 0x41

    if-ge v0, v1, :cond_0

    .line 3795
    const-string v1, "; expected a name start character"

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 3797
    :cond_0
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadCount:I

    .line 3798
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuad:I

    .line 3799
    const/4 v1, 0x1

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuadBytes:I

    .line 3800
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parseEntityName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1
.end method

.method protected final parseNewName(B)Lcom/fasterxml/aalto/in/PName;
    .locals 2
    .param p1, "b"    # B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3678
    and-int/lit16 v0, p1, 0xff

    .line 3683
    .local v0, "q":I
    const/16 v1, 0x41

    if-ge v0, v1, :cond_0

    .line 3684
    const-string v1, "; expected a name start character"

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 3686
    :cond_0
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadCount:I

    .line 3687
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuad:I

    .line 3688
    const/4 v1, 0x1

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuadBytes:I

    .line 3689
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->parsePName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1
.end method

.method protected parsePIData()I
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 288
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    if-eqz v0, :cond_0

    .line 289
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handlePIPending()I

    move-result v0

    .line 291
    .local v0, "result":I
    if-eqz v0, :cond_0

    .line 292
    return v0

    .line 297
    .end local v0    # "result":I
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v0

    .line 298
    .local v0, "outputBuffer":[C
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->getCurrentLength()I

    move-result v1

    .line 300
    .local v1, "outPtr":I
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v2, v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 301
    .local v2, "TYPES":[I
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    .line 309
    .local v3, "inputBuffer":[B
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    const/16 v6, 0x101

    if-lt v4, v5, :cond_1

    .line 310
    goto/16 :goto_3

    .line 312
    :cond_1
    array-length v4, v0

    if-lt v1, v4, :cond_2

    .line 313
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v0

    .line 314
    const/4 v1, 0x0

    .line 316
    :cond_2
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    .line 318
    .local v4, "max":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    array-length v7, v0

    sub-int/2addr v7, v1

    add-int/2addr v5, v7

    .line 319
    .local v5, "max2":I
    if-ge v5, v4, :cond_3

    .line 320
    move v4, v5

    .line 323
    .end local v5    # "max2":I
    :cond_3
    :goto_1
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-ge v5, v4, :cond_f

    .line 324
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v5, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v5, v3, v5

    and-int/lit16 v5, v5, 0xff

    .line 325
    .local v5, "c":I
    aget v7, v2, v5

    if-eqz v7, :cond_e

    .line 326
    nop

    .line 332
    .end local v4    # "max":I
    aget v4, v2, v5

    const/4 v7, 0x3

    packed-switch v4, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_4

    .line 370
    :pswitch_1
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v4, v8

    if-ge v4, v7, :cond_5

    .line 371
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v4, v7, :cond_4

    .line 372
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v4, v7

    and-int/lit16 v4, v4, 0xff

    .line 373
    .local v4, "d":I
    shl-int/lit8 v7, v4, 0x8

    or-int/2addr v5, v7

    .line 374
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v7, v8, :cond_4

    .line 375
    iget-object v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v7, v7, v8

    and-int/lit16 v4, v7, 0xff

    .line 376
    shl-int/lit8 v7, v4, 0x10

    or-int/2addr v5, v7

    .line 379
    .end local v4    # "d":I
    :cond_4
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 380
    goto/16 :goto_3

    .line 382
    :cond_5
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_4(I)I

    move-result v4

    .line 384
    .end local v5    # "c":I
    .local v4, "c":I
    add-int/lit8 v5, v1, 0x1

    .end local v1    # "outPtr":I
    .local v5, "outPtr":I
    shr-int/lit8 v6, v4, 0xa

    const v7, 0xd800

    or-int/2addr v6, v7

    int-to-char v6, v6

    aput-char v6, v0, v1

    .line 385
    array-length v1, v0

    if-lt v5, v1, :cond_6

    .line 386
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v0

    .line 387
    const/4 v1, 0x0

    .end local v5    # "outPtr":I
    .restart local v1    # "outPtr":I
    goto :goto_2

    .line 385
    .end local v1    # "outPtr":I
    .restart local v5    # "outPtr":I
    :cond_6
    move v1, v5

    .line 389
    .end local v5    # "outPtr":I
    .restart local v1    # "outPtr":I
    :goto_2
    and-int/lit16 v5, v4, 0x3ff

    const v6, 0xdc00

    or-int/2addr v5, v6

    .line 391
    .end local v4    # "c":I
    .local v5, "c":I
    goto/16 :goto_4

    .line 359
    :pswitch_2
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v4, v7

    const/4 v7, 0x2

    if-ge v4, v7, :cond_8

    .line 360
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v4, v7, :cond_7

    .line 361
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v4, v7

    and-int/lit16 v4, v4, 0xff

    .line 362
    .local v4, "d":I
    shl-int/lit8 v7, v4, 0x8

    or-int/2addr v5, v7

    .line 364
    .end local v4    # "d":I
    :cond_7
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 365
    goto :goto_3

    .line 367
    :cond_8
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_3(I)I

    move-result v5

    .line 368
    goto :goto_4

    .line 352
    :pswitch_3
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v7, :cond_9

    .line 353
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 354
    goto :goto_3

    .line 356
    :cond_9
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_2(I)I

    move-result v5

    .line 357
    goto :goto_4

    .line 393
    :pswitch_4
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInvalidInitial(I)V

    .line 396
    :pswitch_5
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v8, :cond_a

    .line 397
    const/16 v4, -0xf

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 398
    goto :goto_3

    .line 400
    :cond_a
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v4, v8

    const/16 v8, 0x3e

    if-ne v4, v8, :cond_d

    .line 401
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 402
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 403
    const/4 v4, 0x0

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    .line 404
    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    .line 405
    return v7

    .line 349
    :pswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    .line 350
    goto :goto_4

    .line 334
    :pswitch_7
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleInvalidXmlChar(I)C

    move-result v5

    .line 337
    :pswitch_8
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v7, :cond_b

    .line 338
    const/4 v4, -0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 339
    nop

    .line 416
    .end local v5    # "c":I
    :goto_3
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 417
    return v6

    .line 341
    .restart local v5    # "c":I
    :cond_b
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v3, v4

    const/16 v6, 0xa

    if-ne v4, v6, :cond_c

    .line 342
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 344
    :cond_c
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    .line 346
    const/16 v5, 0xa

    .line 347
    nop

    .line 414
    :cond_d
    :goto_4
    add-int/lit8 v4, v1, 0x1

    .end local v1    # "outPtr":I
    .local v4, "outPtr":I
    int-to-char v6, v5

    aput-char v6, v0, v1

    .line 415
    .end local v5    # "c":I
    move v1, v4

    goto/16 :goto_0

    .line 328
    .restart local v1    # "outPtr":I
    .local v4, "max":I
    .restart local v5    # "c":I
    :cond_e
    add-int/lit8 v7, v1, 0x1

    .end local v1    # "outPtr":I
    .local v7, "outPtr":I
    int-to-char v8, v5

    aput-char v8, v0, v1

    move v1, v7

    goto/16 :goto_1

    .line 330
    .end local v4    # "max":I
    .end local v5    # "c":I
    .end local v7    # "outPtr":I
    .restart local v1    # "outPtr":I
    :cond_f
    goto/16 :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_7
        :pswitch_8
        :pswitch_6
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_5
    .end packed-switch
.end method

.method protected final parsePName()Lcom/fasterxml/aalto/in/PName;
    .locals 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3707
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuad:I

    .line 3712
    .local v0, "q":I
    :goto_0
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuadBytes:I

    const/4 v2, 0x0

    const/16 v3, 0x2f

    const/16 v4, 0x3a

    const/16 v5, 0x2d

    const/4 v6, 0x0

    const/16 v7, 0x41

    const/4 v8, 0x1

    packed-switch v1, :pswitch_data_0

    goto/16 :goto_1

    .line 3714
    :pswitch_0
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v1, v9, :cond_0

    .line 3715
    return-object v6

    .line 3717
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v10, v9, 0x1

    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v9

    and-int/lit16 v0, v1, 0xff

    .line 3723
    if-ge v0, v7, :cond_2

    .line 3725
    if-lt v0, v5, :cond_1

    if-gt v0, v4, :cond_1

    if-ne v0, v3, :cond_2

    .line 3727
    :cond_1
    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1

    .line 3733
    :cond_2
    :pswitch_1
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v1, v9, :cond_3

    .line 3734
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuad:I

    .line 3735
    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuadBytes:I

    .line 3736
    return-object v6

    .line 3738
    :cond_3
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v10, v9, 0x1

    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v9

    and-int/lit16 v1, v1, 0xff

    .line 3739
    .local v1, "i":I
    if-ge v1, v7, :cond_5

    .line 3740
    if-lt v1, v5, :cond_4

    if-gt v1, v4, :cond_4

    if-ne v1, v3, :cond_5

    .line 3741
    :cond_4
    invoke-virtual {p0, v0, v8}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    return-object v2

    .line 3744
    :cond_5
    shl-int/lit8 v9, v0, 0x8

    or-int v0, v9, v1

    .line 3748
    .end local v1    # "i":I
    :pswitch_2
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    const/4 v10, 0x2

    if-lt v1, v9, :cond_6

    .line 3749
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuad:I

    .line 3750
    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuadBytes:I

    .line 3751
    return-object v6

    .line 3753
    :cond_6
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v11, v9, 0x1

    iput v11, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v9

    and-int/lit16 v1, v1, 0xff

    .line 3754
    .restart local v1    # "i":I
    if-ge v1, v7, :cond_8

    .line 3755
    if-lt v1, v5, :cond_7

    if-gt v1, v4, :cond_7

    if-ne v1, v3, :cond_8

    .line 3756
    :cond_7
    invoke-virtual {p0, v0, v10}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    return-object v2

    .line 3759
    :cond_8
    shl-int/lit8 v9, v0, 0x8

    or-int v0, v9, v1

    .line 3763
    .end local v1    # "i":I
    :pswitch_3
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    const/4 v10, 0x3

    if-lt v1, v9, :cond_9

    .line 3764
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuad:I

    .line 3765
    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuadBytes:I

    .line 3766
    return-object v6

    .line 3768
    :cond_9
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v9, v6, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v6

    and-int/lit16 v1, v1, 0xff

    .line 3769
    .restart local v1    # "i":I
    if-ge v1, v7, :cond_b

    .line 3770
    if-lt v1, v5, :cond_a

    if-gt v1, v4, :cond_a

    if-ne v1, v3, :cond_b

    .line 3771
    :cond_a
    invoke-virtual {p0, v0, v10}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    return-object v2

    .line 3774
    :cond_b
    shl-int/lit8 v3, v0, 0x8

    or-int v0, v3, v1

    .line 3778
    .end local v1    # "i":I
    :goto_1
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadCount:I

    if-nez v1, :cond_c

    .line 3779
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadBuffer:[I

    aput v0, v1, v2

    .line 3780
    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadCount:I

    goto :goto_2

    .line 3782
    :cond_c
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadCount:I

    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadBuffer:[I

    array-length v3, v3

    if-lt v1, v3, :cond_d

    .line 3783
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadBuffer:[I

    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadBuffer:[I

    array-length v3, v3

    invoke-static {v1, v3}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([II)[I

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadBuffer:[I

    .line 3785
    :cond_d
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadBuffer:[I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadCount:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_quadCount:I

    aput v0, v1, v3

    .line 3787
    :goto_2
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currQuadBytes:I

    goto/16 :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method protected skipCharacters()Z
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2573
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 2574
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->skipPending()Z

    move-result v0

    if-nez v0, :cond_0

    .line 2575
    return v1

    .line 2579
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    .line 2580
    .local v0, "TYPES":[I
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    .line 2588
    .local v2, "inputBuffer":[B
    :goto_0
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2589
    .local v3, "ptr":I
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    .line 2590
    .local v4, "max":I
    if-lt v3, v4, :cond_1

    .line 2591
    goto/16 :goto_4

    .line 2593
    :cond_1
    :goto_1
    if-ge v3, v4, :cond_e

    .line 2594
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "ptr":I
    .local v5, "ptr":I
    aget-byte v3, v2, v3

    and-int/lit16 v3, v3, 0xff

    .line 2595
    .local v3, "c":I
    aget v6, v0, v3

    if-eqz v6, :cond_d

    .line 2596
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2597
    nop

    .line 2603
    .end local v4    # "max":I
    .end local v5    # "ptr":I
    aget v4, v0, v3

    const/4 v5, 0x1

    packed-switch v4, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_5

    .line 2680
    :pswitch_1
    const/4 v4, 0x1

    .line 2681
    .local v4, "count":I
    const/4 v6, 0x0

    .line 2682
    .local v6, "b":B
    :goto_2
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-ge v7, v8, :cond_3

    .line 2683
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v6, v2, v7

    .line 2684
    const/16 v7, 0x5d

    if-eq v6, v7, :cond_2

    .line 2685
    goto :goto_3

    .line 2687
    :cond_2
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v7, v5

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2688
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 2690
    :cond_3
    :goto_3
    const/16 v7, 0x3e

    if-ne v6, v7, :cond_c

    if-le v4, v5, :cond_c

    .line 2691
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportIllegalCDataEnd()V

    goto/16 :goto_5

    .line 2660
    .end local v4    # "count":I
    .end local v6    # "b":B
    :pswitch_2
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->skipEntityInCharacters()I

    move-result v3

    .line 2661
    if-nez v3, :cond_c

    .line 2662
    const/16 v4, -0x50

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2664
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-ge v4, v6, :cond_4

    .line 2665
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->skipPending()Z

    move-result v4

    if-eqz v4, :cond_4

    .line 2666
    return v5

    .line 2669
    :cond_4
    return v1

    .line 2640
    :pswitch_3
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v4, v5

    const/4 v5, 0x3

    if-ge v4, v5, :cond_6

    .line 2641
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v4, v5, :cond_5

    .line 2642
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v4, v5

    and-int/lit16 v4, v4, 0xff

    .line 2643
    .local v4, "d":I
    shl-int/lit8 v5, v4, 0x8

    or-int/2addr v3, v5

    .line 2644
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v5, v6, :cond_5

    .line 2645
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v5, v5, v6

    and-int/lit16 v4, v5, 0xff

    .line 2646
    shl-int/lit8 v5, v4, 0x10

    or-int/2addr v3, v5

    .line 2649
    .end local v4    # "d":I
    :cond_5
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2650
    goto :goto_4

    .line 2652
    :cond_6
    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_4(I)I

    .line 2653
    goto :goto_5

    .line 2629
    :pswitch_4
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v4, v5

    const/4 v5, 0x2

    if-ge v4, v5, :cond_8

    .line 2630
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v4, v5, :cond_7

    .line 2631
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v4, v5

    and-int/lit16 v4, v4, 0xff

    .line 2632
    .restart local v4    # "d":I
    shl-int/lit8 v5, v4, 0x8

    or-int/2addr v3, v5

    .line 2634
    .end local v4    # "d":I
    :cond_7
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2635
    goto :goto_4

    .line 2637
    :cond_8
    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_3(I)I

    .line 2638
    goto :goto_5

    .line 2622
    :pswitch_5
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v5, :cond_9

    .line 2623
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2624
    goto :goto_4

    .line 2626
    :cond_9
    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->skipUtf8_2(I)V

    .line 2627
    goto :goto_5

    .line 2655
    :pswitch_6
    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInvalidInitial(I)V

    .line 2657
    :pswitch_7
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v1, v5

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2658
    return v5

    .line 2619
    :pswitch_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    .line 2620
    goto :goto_5

    .line 2605
    :pswitch_9
    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleInvalidXmlChar(I)C

    move-result v3

    .line 2608
    :pswitch_a
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v6, :cond_a

    .line 2609
    const/4 v4, -0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2610
    nop

    .line 2702
    .end local v3    # "c":I
    :goto_4
    return v1

    .line 2612
    .restart local v3    # "c":I
    :cond_a
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v2, v4

    const/16 v6, 0xa

    if-ne v4, v6, :cond_b

    .line 2613
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v4, v5

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2615
    :cond_b
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    .line 2617
    nop

    .line 2699
    .end local v3    # "c":I
    :cond_c
    :goto_5
    goto/16 :goto_0

    .line 2595
    .restart local v3    # "c":I
    .local v4, "max":I
    .restart local v5    # "ptr":I
    :cond_d
    move v3, v5

    goto/16 :goto_1

    .line 2600
    .end local v5    # "ptr":I
    .local v3, "ptr":I
    :cond_e
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2601
    .end local v3    # "ptr":I
    .end local v4    # "max":I
    goto/16 :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_9
        :pswitch_a
        :pswitch_8
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_0
        :pswitch_7
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method protected skipCoalescedText()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2968
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInternal()I

    .line 2969
    const/4 v0, 0x0

    return v0
.end method

.method protected final skipUtf8_2(I)V
    .locals 3
    .param p1, "c"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3977
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 3978
    .local v0, "d":I
    and-int/lit16 v1, v0, 0xc0

    const/16 v2, 0x80

    if-eq v1, v2, :cond_0

    .line 3979
    and-int/lit16 v1, v0, 0xff

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInvalidOther(II)V

    .line 3981
    :cond_0
    return-void
.end method

.method protected final startCharacters(B)I
    .locals 6
    .param p1, "b"    # B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2060
    and-int/lit16 v0, p1, 0xff

    .line 2061
    .local v0, "c":I
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v1, v1, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    aget v1, v1, v0

    const/16 v2, 0x101

    const/4 v3, 0x1

    packed-switch v1, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_0

    .line 2122
    :pswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInternal()I

    .line 2123
    goto/16 :goto_0

    .line 2100
    :pswitch_2
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v1, v4

    const/4 v4, 0x3

    if-ge v1, v4, :cond_1

    .line 2101
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v1, v3, :cond_0

    .line 2102
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v3

    and-int/lit16 v1, v1, 0xff

    .line 2103
    .local v1, "d":I
    shl-int/lit8 v3, v1, 0x8

    or-int/2addr v0, v3

    .line 2104
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v3, v4, :cond_0

    .line 2105
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v3, v3, v4

    and-int/lit16 v1, v3, 0xff

    .line 2106
    shl-int/lit8 v3, v1, 0x10

    or-int/2addr v0, v3

    .line 2109
    .end local v1    # "d":I
    :cond_0
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2110
    return v2

    .line 2112
    :cond_1
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_4(I)I

    move-result v0

    .line 2114
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1, v0}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithSurrogate(I)V

    .line 2115
    goto :goto_1

    .line 2089
    :pswitch_3
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    sub-int/2addr v1, v4

    const/4 v4, 0x2

    if-ge v1, v4, :cond_3

    .line 2090
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    if-le v1, v3, :cond_2

    .line 2091
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v3

    and-int/lit16 v1, v1, 0xff

    .line 2092
    .restart local v1    # "d":I
    shl-int/lit8 v3, v1, 0x8

    or-int/2addr v0, v3

    .line 2094
    .end local v1    # "d":I
    :cond_2
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2095
    return v2

    .line 2097
    :cond_3
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_3(I)I

    move-result v0

    .line 2098
    goto :goto_0

    .line 2082
    :pswitch_4
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v1, v4, :cond_4

    .line 2083
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2084
    return v2

    .line 2086
    :cond_4
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_2(I)I

    move-result v0

    .line 2087
    goto :goto_0

    .line 2118
    :pswitch_5
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->reportInvalidInitial(I)V

    .line 2119
    goto :goto_0

    .line 2079
    :pswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    .line 2080
    goto :goto_0

    .line 2063
    :pswitch_7
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->handleInvalidXmlChar(I)C

    move-result v0

    .line 2068
    :pswitch_8
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v1, v4, :cond_5

    .line 2069
    const/4 v1, -0x1

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 2070
    return v2

    .line 2072
    :cond_5
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v2

    const/16 v2, 0xa

    if-ne v1, v2, :cond_6

    .line 2073
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v1, v3

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 2075
    :cond_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    .line 2076
    const/16 v0, 0xa

    .line 2077
    nop

    .line 2131
    :goto_0
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    int-to-char v2, v0

    invoke-virtual {v1, v2}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithChar(C)V

    .line 2134
    .end local v0    # "c":I
    :goto_1
    iget-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_cfgCoalescing:Z

    if-eqz v0, :cond_7

    iget-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_cfgLazyParsing:Z

    if-nez v0, :cond_7

    .line 2136
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->finishCharactersCoalescing()I

    move-result v0

    return v0

    .line 2138
    :cond_7
    const/4 v0, 0x4

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    .line 2139
    iget-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_cfgLazyParsing:Z

    if-eqz v0, :cond_8

    .line 2140
    iput-boolean v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenIncomplete:Z

    goto :goto_2

    .line 2142
    :cond_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->finishCharacters()V

    .line 2144
    :goto_2
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    return v0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_7
        :pswitch_8
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_0
        :pswitch_1
        :pswitch_1
    .end packed-switch
.end method

.method protected startCharactersPending()I
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 825
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    const/16 v2, 0x101

    if-lt v0, v1, :cond_0

    .line 826
    return v2

    .line 830
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 831
    .local v0, "c":I
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 834
    const/4 v1, -0x1

    const/4 v3, 0x4

    const/4 v4, 0x1

    if-ne v0, v1, :cond_2

    .line 835
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v2

    const/16 v2, 0xa

    if-ne v1, v2, :cond_1

    .line 836
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/2addr v1, v4

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    .line 838
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->markLF()V

    .line 839
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1, v2}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithChar(C)V

    goto/16 :goto_2

    .line 844
    :cond_2
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v1, v1, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    and-int/lit16 v5, v0, 0xff

    aget v1, v1, v5

    packed-switch v1, :pswitch_data_0

    .line 903
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->throwInternal()I

    goto/16 :goto_2

    .line 869
    :pswitch_0
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v4

    and-int/lit16 v1, v1, 0xff

    .line 871
    .local v1, "next":I
    shr-int/lit8 v4, v0, 0x8

    if-nez v4, :cond_5

    .line 872
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v4, v5, :cond_3

    .line 873
    shl-int/lit8 v3, v1, 0x8

    or-int/2addr v3, v0

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 874
    return v2

    .line 876
    :cond_3
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v4, v4, v5

    and-int/lit16 v4, v4, 0xff

    .line 877
    .local v4, "c2":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v5, v6, :cond_4

    .line 878
    shl-int/lit8 v3, v1, 0x8

    or-int/2addr v3, v0

    shl-int/lit8 v5, v4, 0x10

    or-int/2addr v3, v5

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 879
    return v2

    .line 881
    :cond_4
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v2, v2, v5

    and-int/lit16 v2, v2, 0xff

    .line 882
    .local v2, "c3":I
    invoke-virtual {p0, v0, v1, v4, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_4(IIII)I

    move-result v0

    .line 883
    .end local v2    # "c3":I
    .end local v4    # "c2":I
    goto :goto_0

    .line 884
    :cond_5
    shr-int/lit8 v4, v0, 0x8

    and-int/lit16 v4, v4, 0xff

    .line 885
    .restart local v4    # "c2":I
    shr-int/lit8 v5, v0, 0x10

    .line 887
    .local v5, "c3":I
    if-nez v5, :cond_7

    .line 888
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v6, v7, :cond_6

    .line 889
    shl-int/lit8 v3, v1, 0x10

    or-int/2addr v3, v0

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 890
    return v2

    .line 892
    :cond_6
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v2, v2, v6

    and-int/lit16 v2, v2, 0xff

    .line 893
    .end local v5    # "c3":I
    .restart local v2    # "c3":I
    and-int/lit16 v5, v0, 0xff

    invoke-virtual {p0, v5, v4, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_4(IIII)I

    move-result v0

    goto :goto_0

    .line 895
    .end local v2    # "c3":I
    .restart local v5    # "c3":I
    :cond_7
    and-int/lit16 v2, v0, 0xff

    invoke-virtual {p0, v2, v4, v5, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_4(IIII)I

    move-result v0

    .line 900
    .end local v1    # "next":I
    .end local v4    # "c2":I
    .end local v5    # "c3":I
    :goto_0
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1, v0}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithSurrogate(I)V

    .line 901
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    return v3

    .line 852
    :pswitch_1
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v1, v1, v5

    and-int/lit16 v1, v1, 0xff

    .line 853
    .restart local v1    # "next":I
    shr-int/lit8 v5, v0, 0x8

    .line 854
    .local v5, "c2":I
    if-nez v5, :cond_9

    .line 855
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputEnd:I

    if-lt v6, v7, :cond_8

    .line 856
    shl-int/lit8 v3, v1, 0x8

    or-int/2addr v3, v0

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_pendingInput:I

    .line 857
    return v2

    .line 859
    :cond_8
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_inputPtr:I

    aget-byte v2, v2, v6

    and-int/lit16 v2, v2, 0xff

    .line 860
    .restart local v2    # "c3":I
    invoke-virtual {p0, v0, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_3(III)I

    move-result v0

    .line 861
    .end local v2    # "c3":I
    goto :goto_1

    .line 862
    :cond_9
    and-int/lit16 v2, v0, 0xff

    invoke-virtual {p0, v2, v5, v1}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_3(III)I

    move-result v0

    .line 864
    :goto_1
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    int-to-char v6, v0

    invoke-virtual {v2, v6}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithChar(C)V

    .line 866
    .end local v1    # "next":I
    .end local v5    # "c2":I
    goto :goto_2

    .line 847
    :pswitch_2
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->decodeUtf8_2(I)I

    move-result v2

    int-to-char v2, v2

    invoke-virtual {v1, v2}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithChar(C)V

    .line 848
    nop

    .line 908
    :goto_2
    iget-boolean v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_cfgCoalescing:Z

    if-eqz v1, :cond_a

    iget-boolean v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_cfgLazyParsing:Z

    if-nez v1, :cond_a

    .line 910
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->finishCharactersCoalescing()I

    move-result v1

    return v1

    .line 912
    :cond_a
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    .line 913
    iget-boolean v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_cfgLazyParsing:Z

    if-eqz v1, :cond_b

    .line 914
    iput-boolean v4, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_tokenIncomplete:Z

    goto :goto_3

    .line 916
    :cond_b
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->finishCharacters()V

    .line 918
    :goto_3
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    return v1

    :pswitch_data_0
    .packed-switch 0x5
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 69
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "asyncScanner; curr="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_currToken:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " next="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_nextEvent:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", state = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteArrayScanner;->_state:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
