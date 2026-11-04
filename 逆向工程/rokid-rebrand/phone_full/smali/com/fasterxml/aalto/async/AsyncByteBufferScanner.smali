.class public Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;
.super Lcom/fasterxml/aalto/async/AsyncByteScanner;
.source "AsyncByteBufferScanner.java"

# interfaces
.implements Lcom/fasterxml/aalto/AsyncByteBufferFeeder;


# instance fields
.field protected _inputBuffer:Ljava/nio/ByteBuffer;

.field protected _origBufferLen:I


# direct methods
.method public constructor <init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V
    .locals 1
    .param p1, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;

    .line 64
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V

    .line 66
    const/4 v0, 0x1

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 67
    const/16 v0, 0x101

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    .line 68
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

    .line 1853
    iput-boolean p1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_isEmptyTag:Z

    .line 1856
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/AttributeCollector;->finishLastValue(I)I

    move-result v0

    .line 1857
    .local v0, "act":I
    if-gez v0, :cond_0

    .line 1858
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/AttributeCollector;->getCount()I

    move-result v0

    .line 1859
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/AttributeCollector;->getErrorMsg()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1861
    :cond_0
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_attrCount:I

    .line 1862
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_depth:I

    const/4 v2, 0x1

    add-int/2addr v1, v2

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_depth:I

    .line 1868
    iget-boolean v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAllNsBound:Z

    if-nez v1, :cond_3

    .line 1869
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/PName;->isBound()Z

    move-result v1

    if-nez v1, :cond_1

    .line 1870
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    const/4 v3, 0x0

    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportUnboundPrefix(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 1872
    :cond_1
    const/4 v1, 0x0

    .local v1, "i":I
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_attrCount:I

    .local v3, "len":I
    :goto_0
    if-ge v1, v3, :cond_3

    .line 1873
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v4, v1}, Lcom/fasterxml/aalto/in/AttributeCollector;->getName(I)Lcom/fasterxml/aalto/in/PName;

    move-result-object v4

    .line 1874
    .local v4, "attrName":Lcom/fasterxml/aalto/in/PName;
    invoke-virtual {v4}, Lcom/fasterxml/aalto/in/PName;->isBound()Z

    move-result v5

    if-nez v5, :cond_2

    .line 1875
    invoke-virtual {p0, v4, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportUnboundPrefix(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 1872
    .end local v4    # "attrName":Lcom/fasterxml/aalto/in/PName;
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1880
    .end local v1    # "i":I
    .end local v3    # "len":I
    :cond_3
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    return v2
.end method

.method private final handleAndAppendPending()Z
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2473
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    const/4 v2, 0x0

    if-lt v0, v1, :cond_0

    .line 2474
    return v2

    .line 2476
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2477
    .local v0, "c":I
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2480
    const/4 v1, 0x1

    if-gez v0, :cond_3

    .line 2481
    const/4 v3, -0x1

    if-ne v0, v3, :cond_2

    .line 2482
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v2, v3}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    const/16 v3, 0xa

    if-ne v2, v3, :cond_1

    .line 2483
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v2, v1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2485
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    .line 2486
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->append(C)V

    .line 2487
    return v1

    .line 2489
    :cond_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInternal()I

    .line 2494
    :cond_3
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v3, v3, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    and-int/lit16 v4, v0, 0xff

    aget v3, v3, v4

    packed-switch v3, :pswitch_data_0

    .line 2554
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInternal()I

    goto/16 :goto_2

    .line 2520
    :pswitch_0
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v3

    and-int/lit16 v3, v3, 0xff

    .line 2522
    .local v3, "next":I
    shr-int/lit8 v4, v0, 0x8

    if-nez v4, :cond_6

    .line 2523
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v5, :cond_4

    .line 2524
    shl-int/lit8 v1, v3, 0x8

    or-int/2addr v1, v0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2525
    return v2

    .line 2527
    :cond_4
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 2528
    .local v4, "c2":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v5, v6, :cond_5

    .line 2529
    shl-int/lit8 v1, v3, 0x8

    or-int/2addr v1, v0

    shl-int/lit8 v5, v4, 0x10

    or-int/2addr v1, v5

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2530
    return v2

    .line 2532
    :cond_5
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v2, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    and-int/lit16 v2, v2, 0xff

    .line 2533
    .local v2, "c3":I
    invoke-virtual {p0, v0, v3, v4, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_4(IIII)I

    move-result v0

    .line 2534
    .end local v2    # "c3":I
    .end local v4    # "c2":I
    goto :goto_0

    .line 2535
    :cond_6
    shr-int/lit8 v4, v0, 0x8

    and-int/lit16 v4, v4, 0xff

    .line 2536
    .restart local v4    # "c2":I
    shr-int/lit8 v5, v0, 0x10

    .line 2538
    .local v5, "c3":I
    if-nez v5, :cond_8

    .line 2539
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v6, v7, :cond_7

    .line 2540
    shl-int/lit8 v1, v3, 0x10

    or-int/2addr v1, v0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2541
    return v2

    .line 2543
    :cond_7
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v2, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    and-int/lit16 v2, v2, 0xff

    .line 2544
    .end local v5    # "c3":I
    .restart local v2    # "c3":I
    and-int/lit16 v5, v0, 0xff

    invoke-virtual {p0, v5, v4, v3, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_4(IIII)I

    move-result v0

    goto :goto_0

    .line 2546
    .end local v2    # "c3":I
    .restart local v5    # "c3":I
    :cond_8
    and-int/lit16 v2, v0, 0xff

    invoke-virtual {p0, v2, v4, v5, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_4(IIII)I

    move-result v0

    .line 2551
    .end local v3    # "next":I
    .end local v4    # "c2":I
    .end local v5    # "c3":I
    :goto_0
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2, v0}, Lcom/fasterxml/aalto/util/TextBuilder;->appendSurrogate(I)V

    .line 2552
    goto :goto_2

    .line 2503
    :pswitch_1
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v3

    and-int/lit16 v3, v3, 0xff

    .line 2504
    .restart local v3    # "next":I
    shr-int/lit8 v4, v0, 0x8

    .line 2505
    .restart local v4    # "c2":I
    if-nez v4, :cond_a

    .line 2506
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v5, v6, :cond_9

    .line 2507
    shl-int/lit8 v1, v3, 0x8

    or-int/2addr v1, v0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2508
    return v2

    .line 2510
    :cond_9
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v2, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    and-int/lit16 v2, v2, 0xff

    .line 2511
    .restart local v2    # "c3":I
    invoke-virtual {p0, v0, v3, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_3(III)I

    move-result v0

    .line 2512
    .end local v2    # "c3":I
    goto :goto_1

    .line 2513
    :cond_a
    and-int/lit16 v2, v0, 0xff

    invoke-virtual {p0, v2, v4, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_3(III)I

    move-result v0

    .line 2515
    :goto_1
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    int-to-char v5, v0

    invoke-virtual {v2, v5}, Lcom/fasterxml/aalto/util/TextBuilder;->append(C)V

    .line 2517
    .end local v3    # "next":I
    .end local v4    # "c2":I
    goto :goto_2

    .line 2497
    :pswitch_2
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_2(I)I

    move-result v3

    int-to-char v3, v3

    invoke-virtual {v2, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->append(C)V

    .line 2498
    nop

    .line 2556
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

    .line 3132
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    const/4 v1, -0x1

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-ne v0, v1, :cond_2

    .line 3133
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handlePartialCR()Z

    move-result v0

    if-nez v0, :cond_0

    .line 3134
    return v2

    .line 3136
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/AttributeCollector;->continueValue()[C

    move-result-object v0

    .line 3137
    .local v0, "attrBuffer":[C
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    array-length v2, v0

    if-lt v1, v2, :cond_1

    .line 3138
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/AttributeCollector;->valueBufferFull()[C

    move-result-object v0

    .line 3141
    :cond_1
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    const/16 v2, 0x20

    aput-char v2, v0, v1

    .line 3142
    return v3

    .line 3145
    .end local v0    # "attrBuffer":[C
    :cond_2
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v1, :cond_3

    .line 3146
    return v2

    .line 3150
    :cond_3
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    const/16 v1, -0x3c

    const/16 v4, -0x3f

    const/16 v5, 0x78

    const/16 v6, -0x3d

    const/16 v7, -0x3e

    if-ne v0, v1, :cond_a

    .line 3151
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v8, v1, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 3152
    .local v0, "b":B
    const/16 v1, 0x23

    if-ne v0, v1, :cond_7

    .line 3153
    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3154
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v1, v4, :cond_4

    .line 3155
    return v2

    .line 3157
    :cond_4
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v5, :cond_6

    .line 3158
    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3159
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v1, v3

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 3160
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v1, v4, :cond_5

    .line 3161
    return v2

    .line 3163
    :cond_5
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleHexEntityInAttribute(Z)I

    move-result v1

    .local v1, "ch":I
    goto :goto_0

    .line 3165
    .end local v1    # "ch":I
    :cond_6
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleDecEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_0

    .line 3168
    .end local v1    # "ch":I
    :cond_7
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parseNewEntityName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    .line 3169
    .local v1, "entityName":Lcom/fasterxml/aalto/in/PName;
    if-nez v1, :cond_8

    .line 3170
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3171
    return v2

    .line 3173
    :cond_8
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeGeneralEntity(Lcom/fasterxml/aalto/in/PName;)I

    move-result v4

    .line 3174
    .local v4, "ch":I
    if-nez v4, :cond_9

    .line 3175
    iput-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 3176
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p0, v5, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportUnexpandedEntityInAttr(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 3179
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
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    if-ne v0, v6, :cond_d

    .line 3180
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    if-ne v0, v5, :cond_c

    .line 3181
    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3182
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v0, v3

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 3183
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v1, :cond_b

    .line 3184
    return v2

    .line 3186
    :cond_b
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleHexEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_1

    .line 3188
    .end local v1    # "ch":I
    :cond_c
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleDecEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_1

    .line 3190
    .end local v1    # "ch":I
    :cond_d
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    if-ne v0, v7, :cond_e

    .line 3191
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleHexEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_1

    .line 3192
    .end local v1    # "ch":I
    :cond_e
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    if-ne v0, v4, :cond_11

    .line 3193
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parseEntityName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    .line 3194
    .local v0, "entityName":Lcom/fasterxml/aalto/in/PName;
    if-nez v0, :cond_f

    .line 3195
    return v2

    .line 3197
    :cond_f
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeGeneralEntity(Lcom/fasterxml/aalto/in/PName;)I

    move-result v1

    .line 3198
    .restart local v1    # "ch":I
    if-nez v1, :cond_10

    .line 3199
    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 3200
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p0, v4, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportUnexpandedEntityInAttr(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 3202
    .end local v0    # "entityName":Lcom/fasterxml/aalto/in/PName;
    :cond_10
    goto :goto_1

    .end local v1    # "ch":I
    :cond_11
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    const/16 v1, -0x40

    if-ne v0, v1, :cond_12

    .line 3203
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleDecEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_1

    .line 3204
    .end local v1    # "ch":I
    :cond_12
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    const/16 v1, -0x41

    if-ne v0, v1, :cond_13

    .line 3205
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleHexEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_1

    .line 3209
    .end local v1    # "ch":I
    :cond_13
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleAttrValuePendingUTF8()I

    move-result v1

    .line 3211
    .restart local v1    # "ch":I
    :goto_1
    if-nez v1, :cond_14

    .line 3212
    return v2

    .line 3215
    :cond_14
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/AttributeCollector;->continueValue()[C

    move-result-object v0

    .line 3217
    .local v0, "attrBuffer":[C
    shr-int/lit8 v2, v1, 0x10

    if-eqz v2, :cond_16

    .line 3218
    const/high16 v2, 0x10000

    sub-int/2addr v1, v2

    .line 3219
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    array-length v4, v0

    if-lt v2, v4, :cond_15

    .line 3220
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/in/AttributeCollector;->valueBufferFull()[C

    move-result-object v0

    .line 3222
    :cond_15
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    shr-int/lit8 v4, v1, 0xa

    const v5, 0xd800

    or-int/2addr v4, v5

    int-to-char v4, v4

    aput-char v4, v0, v2

    .line 3223
    and-int/lit16 v2, v1, 0x3ff

    const v4, 0xdc00

    or-int v1, v2, v4

    .line 3225
    :cond_16
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    array-length v4, v0

    if-lt v2, v4, :cond_17

    .line 3226
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/in/AttributeCollector;->valueBufferFull()[C

    move-result-object v0

    .line 3228
    :cond_17
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    int-to-char v4, v1

    aput-char v4, v0, v2

    .line 3229
    return v3
.end method

.method private final handleAttrValuePendingUTF8()I
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3235
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3236
    .local v0, "c":I
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3239
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v2, v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    and-int/lit16 v3, v0, 0xff

    aget v2, v2, v3

    packed-switch v2, :pswitch_data_0

    .line 3294
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInternal()I

    .line 3295
    return v1

    .line 3262
    :pswitch_0
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v2, v3}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    and-int/lit16 v2, v2, 0xff

    .line 3264
    .local v2, "next":I
    shr-int/lit8 v3, v0, 0x8

    if-nez v3, :cond_2

    .line 3265
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v3, v4, :cond_0

    .line 3266
    shl-int/lit8 v3, v2, 0x8

    or-int/2addr v3, v0

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3267
    return v1

    .line 3269
    :cond_0
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v3

    and-int/lit16 v3, v3, 0xff

    .line 3270
    .local v3, "c2":I
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v5, :cond_1

    .line 3271
    shl-int/lit8 v4, v2, 0x8

    or-int/2addr v4, v0

    shl-int/lit8 v5, v3, 0x10

    or-int/2addr v4, v5

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3272
    return v1

    .line 3274
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 3275
    .local v1, "c3":I
    invoke-virtual {p0, v0, v2, v3, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_4(IIII)I

    move-result v0

    .line 3276
    .end local v1    # "c3":I
    .end local v3    # "c2":I
    goto :goto_0

    .line 3277
    :cond_2
    shr-int/lit8 v3, v0, 0x8

    and-int/lit16 v3, v3, 0xff

    .line 3278
    .restart local v3    # "c2":I
    shr-int/lit8 v4, v0, 0x10

    .line 3280
    .local v4, "c3":I
    if-nez v4, :cond_4

    .line 3281
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v5, v6, :cond_3

    .line 3282
    shl-int/lit8 v5, v2, 0x10

    or-int/2addr v5, v0

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3283
    return v1

    .line 3285
    :cond_3
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 3286
    .end local v4    # "c3":I
    .restart local v1    # "c3":I
    and-int/lit16 v4, v0, 0xff

    invoke-virtual {p0, v4, v3, v2, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_4(IIII)I

    move-result v0

    goto :goto_0

    .line 3288
    .end local v1    # "c3":I
    .restart local v4    # "c3":I
    :cond_4
    and-int/lit16 v1, v0, 0xff

    invoke-virtual {p0, v1, v3, v4, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_4(IIII)I

    move-result v0

    .line 3291
    .end local v3    # "c2":I
    .end local v4    # "c3":I
    :goto_0
    return v0

    .line 3246
    .end local v2    # "next":I
    :pswitch_1
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v2, v3}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    and-int/lit16 v2, v2, 0xff

    .line 3247
    .restart local v2    # "next":I
    shr-int/lit8 v3, v0, 0x8

    .line 3248
    .restart local v3    # "c2":I
    if-nez v3, :cond_6

    .line 3249
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v5, :cond_5

    .line 3250
    shl-int/lit8 v4, v2, 0x8

    or-int/2addr v4, v0

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3251
    return v1

    .line 3253
    :cond_5
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 3254
    .restart local v1    # "c3":I
    invoke-virtual {p0, v0, v2, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_3(III)I

    move-result v0

    .line 3255
    .end local v1    # "c3":I
    goto :goto_1

    .line 3256
    :cond_6
    and-int/lit16 v1, v0, 0xff

    invoke-virtual {p0, v1, v3, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_3(III)I

    move-result v0

    .line 3258
    :goto_1
    return v0

    .line 3242
    .end local v2    # "next":I
    .end local v3    # "c2":I
    :pswitch_2
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_2(I)I

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

    .line 1131
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 1132
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parseCDataContents()I

    move-result v0

    return v0

    .line 1134
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v1, :cond_1

    .line 1135
    const/16 v0, 0x101

    return v0

    .line 1137
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleCDataStartMarker(B)I

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

    .line 1142
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    const-string v1, " (expected \'A\' for CDATA)"

    const/16 v2, 0x41

    const/16 v3, 0x101

    packed-switch v0, :pswitch_data_0

    .line 1204
    :pswitch_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInternal()I

    move-result v0

    return v0

    .line 1144
    :pswitch_1
    const/16 v0, 0x43

    if-eq p1, v0, :cond_0

    .line 1145
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v0

    const-string v4, " (expected \'C\' for CDATA)"

    invoke-virtual {p0, v0, v4}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 1147
    :cond_0
    const/4 v0, 0x2

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1148
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v4, :cond_1

    .line 1149
    return v3

    .line 1151
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result p1

    .line 1154
    :pswitch_2
    const/16 v0, 0x44

    if-eq p1, v0, :cond_2

    .line 1155
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v0

    const-string v4, " (expected \'D\' for CDATA)"

    invoke-virtual {p0, v0, v4}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 1157
    :cond_2
    const/4 v0, 0x3

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1158
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v4, :cond_3

    .line 1159
    return v3

    .line 1161
    :cond_3
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result p1

    .line 1164
    :pswitch_3
    if-eq p1, v2, :cond_4

    .line 1165
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v0

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 1167
    :cond_4
    const/4 v0, 0x4

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1168
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v4, :cond_5

    .line 1169
    return v3

    .line 1171
    :cond_5
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result p1

    .line 1174
    :pswitch_4
    const/16 v0, 0x54

    if-eq p1, v0, :cond_6

    .line 1175
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v0

    const-string v4, " (expected \'T\' for CDATA)"

    invoke-virtual {p0, v0, v4}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 1177
    :cond_6
    const/4 v0, 0x5

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1178
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v4, :cond_7

    .line 1179
    return v3

    .line 1181
    :cond_7
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result p1

    .line 1184
    :pswitch_5
    if-eq p1, v2, :cond_8

    .line 1185
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v0

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 1187
    :cond_8
    const/4 v0, 0x6

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1188
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v1, :cond_9

    .line 1189
    return v3

    .line 1191
    :cond_9
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result p1

    .line 1194
    :pswitch_6
    const/16 v0, 0x5b

    if-eq p1, v0, :cond_a

    .line 1195
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v0

    const-string v1, " (expected \'[\' for CDATA)"

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 1197
    :cond_a
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    .line 1198
    const/4 v0, 0x1

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1199
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v1, :cond_b

    .line 1200
    return v3

    .line 1202
    :cond_b
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parseCDataContents()I

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

    .line 3301
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 3302
    .local v0, "b":B
    const-string v1, " expected a digit (0 - 9) for character entity"

    const/4 v2, 0x0

    if-eqz p1, :cond_3

    .line 3303
    move v3, v0

    .line 3304
    .local v3, "ch":I
    const/16 v4, 0x30

    if-lt v3, v4, :cond_0

    const/16 v4, 0x39

    if-le v3, v4, :cond_1

    .line 3305
    :cond_0
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v4

    invoke-virtual {p0, v4, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 3307
    :cond_1
    const/16 v4, -0x40

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3308
    add-int/lit8 v4, v3, -0x30

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_entityValue:I

    .line 3309
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v5, :cond_2

    .line 3310
    return v2

    .line 3312
    :cond_2
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 3314
    .end local v3    # "ch":I
    :cond_3
    :goto_0
    const/16 v3, 0x3b

    if-eq v0, v3, :cond_8

    .line 3315
    add-int/lit8 v3, v0, -0x30

    .line 3316
    .restart local v3    # "ch":I
    if-ltz v3, :cond_4

    const/16 v4, 0x9

    if-le v3, v4, :cond_5

    .line 3317
    :cond_4
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v4

    invoke-virtual {p0, v4, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 3319
    :cond_5
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_entityValue:I

    mul-int/lit8 v4, v4, 0xa

    add-int/2addr v4, v3

    .line 3320
    .local v4, "value":I
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_entityValue:I

    .line 3321
    const v5, 0x10ffff

    if-le v4, v5, :cond_6

    .line 3322
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportEntityOverflow()V

    .line 3324
    :cond_6
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v5, v6, :cond_7

    .line 3325
    return v2

    .line 3327
    :cond_7
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v5, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 3328
    .end local v3    # "ch":I
    .end local v4    # "value":I
    goto :goto_0

    .line 3329
    :cond_8
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_entityValue:I

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->verifyXmlChar(I)V

    .line 3330
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3331
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_entityValue:I

    return v1
.end method

.method private handleEndElement()I
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1975
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    const/16 v1, 0x101

    const/4 v2, 0x1

    if-nez v0, :cond_7

    .line 1976
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 1977
    .local v0, "elemName":Lcom/fasterxml/aalto/in/PName;
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->sizeInQuads()I

    move-result v3

    sub-int/2addr v3, v2

    .line 1978
    .local v3, "quadSize":I
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadCount:I

    if-ge v4, v3, :cond_3

    .line 1979
    :goto_1
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuadBytes:I

    const/4 v5, 0x4

    if-ge v4, v5, :cond_1

    .line 1980
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v5, :cond_0

    .line 1981
    return v1

    .line 1983
    :cond_0
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuad:I

    shl-int/lit8 v4, v4, 0x8

    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v5, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    or-int/2addr v4, v5

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuad:I

    .line 1979
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuadBytes:I

    add-int/2addr v4, v2

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuadBytes:I

    goto :goto_1

    .line 1986
    :cond_1
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuad:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadCount:I

    invoke-virtual {v0, v5}, Lcom/fasterxml/aalto/in/PName;->getQuad(I)I

    move-result v5

    if-eq v4, v5, :cond_2

    .line 1987
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportUnexpectedEndTag(Ljava/lang/String;)V

    .line 1989
    :cond_2
    const/4 v4, 0x0

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuadBytes:I

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuad:I

    .line 1978
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadCount:I

    add-int/2addr v4, v2

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadCount:I

    goto :goto_0

    .line 1992
    :cond_3
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getLastQuad()I

    move-result v4

    .line 1995
    .local v4, "lastQ":I
    :goto_2
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v5, v6, :cond_4

    .line 1996
    return v1

    .line 1998
    :cond_4
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuad:I

    shl-int/lit8 v5, v5, 0x8

    .line 1999
    .local v5, "q":I
    iget-object v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v6, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v6

    and-int/lit16 v6, v6, 0xff

    or-int/2addr v5, v6

    .line 2000
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuad:I

    .line 2001
    if-ne v5, v4, :cond_5

    .line 2002
    goto :goto_3

    .line 2004
    :cond_5
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuadBytes:I

    add-int/2addr v6, v2

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuadBytes:I

    const/4 v7, 0x3

    if-le v6, v7, :cond_6

    .line 2005
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportUnexpectedEndTag(Ljava/lang/String;)V

    .line 2006
    nop

    .line 2010
    .end local v5    # "q":I
    :goto_3
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .end local v0    # "elemName":Lcom/fasterxml/aalto/in/PName;
    .end local v3    # "quadSize":I
    .end local v4    # "lastQ":I
    goto :goto_4

    .line 2008
    .restart local v0    # "elemName":Lcom/fasterxml/aalto/in/PName;
    .restart local v3    # "quadSize":I
    .restart local v4    # "lastQ":I
    :cond_6
    goto :goto_2

    .line 2011
    .end local v0    # "elemName":Lcom/fasterxml/aalto/in/PName;
    .end local v3    # "quadSize":I
    .end local v4    # "lastQ":I
    :cond_7
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    if-eq v0, v2, :cond_8

    .line 2012
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInternal()I

    goto :goto_5

    .line 2011
    :cond_8
    :goto_4
    nop

    .line 2015
    :goto_5
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    if-eqz v0, :cond_9

    .line 2016
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handlePartialCR()Z

    move-result v0

    if-nez v0, :cond_9

    .line 2017
    return v1

    .line 2024
    :cond_9
    :goto_6
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v3, :cond_a

    .line 2025
    return v1

    .line 2027
    :cond_a
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v3}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 2028
    .local v0, "i2":I
    const/16 v3, 0x20

    if-gt v0, v3, :cond_f

    .line 2029
    const/16 v4, 0xa

    if-ne v0, v4, :cond_b

    .line 2030
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    goto :goto_6

    .line 2031
    :cond_b
    const/16 v5, 0xd

    if-ne v0, v5, :cond_e

    .line 2032
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v3, v5, :cond_c

    .line 2033
    const/4 v2, -0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2034
    return v1

    .line 2036
    :cond_c
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v3, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v3

    if-ne v3, v4, :cond_d

    .line 2037
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v3, v2

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2039
    :cond_d
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    goto :goto_6

    .line 2040
    :cond_e
    if-eq v0, v3, :cond_9

    const/16 v3, 0x9

    if-eq v0, v3, :cond_9

    .line 2041
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInvalidSpace(I)V

    goto :goto_6

    .line 2046
    :cond_f
    const/16 v1, 0x3e

    if-eq v0, v1, :cond_10

    .line 2047
    int-to-byte v1, v0

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v1

    const-string v2, " expected space or closing \'>\'"

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 2050
    :cond_10
    const/4 v1, 0x2

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    return v1
.end method

.method private handleEndElementStart()I
    .locals 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1885
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_depth:I

    const/4 v1, 0x1

    sub-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_depth:I

    .line 1886
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currElem:Lcom/fasterxml/aalto/in/ElementScope;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ElementScope;->getName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 1892
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->sizeInQuads()I

    move-result v0

    .line 1893
    .local v0, "size":I
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v2, v3

    shl-int/lit8 v3, v0, 0x2

    add-int/2addr v3, v1

    const/4 v4, 0x2

    if-ge v2, v3, :cond_0

    .line 1894
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    .line 1895
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1896
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuadBytes:I

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuad:I

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadCount:I

    .line 1900
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleEndElement()I

    move-result v1

    return v1

    .line 1902
    :cond_0
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    .line 1905
    .local v2, "buf":Ljava/nio/ByteBuffer;
    const/4 v3, -0x1

    add-int/2addr v0, v3

    .line 1906
    const/4 v5, 0x0

    .local v5, "qix":I
    :goto_0
    if-ge v5, v0, :cond_2

    .line 1907
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 1908
    .local v6, "ptr":I
    invoke-virtual {v2, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v7

    shl-int/lit8 v7, v7, 0x18

    add-int/lit8 v8, v6, 0x1

    .line 1909
    invoke-virtual {v2, v8}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v8

    and-int/lit16 v8, v8, 0xff

    shl-int/lit8 v8, v8, 0x10

    or-int/2addr v7, v8

    add-int/lit8 v8, v6, 0x2

    .line 1910
    invoke-virtual {v2, v8}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v8

    and-int/lit16 v8, v8, 0xff

    shl-int/lit8 v8, v8, 0x8

    or-int/2addr v7, v8

    add-int/lit8 v8, v6, 0x3

    .line 1911
    invoke-virtual {v2, v8}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v8

    and-int/lit16 v8, v8, 0xff

    or-int/2addr v7, v8

    .line 1913
    .local v7, "q":I
    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v8, v8, 0x4

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 1915
    iget-object v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v8, v5}, Lcom/fasterxml/aalto/in/PName;->getQuad(I)I

    move-result v8

    if-eq v7, v8, :cond_1

    .line 1916
    iget-object v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v8}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p0, v8}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportUnexpectedEndTag(Ljava/lang/String;)V

    .line 1906
    .end local v6    # "ptr":I
    .end local v7    # "q":I
    :cond_1
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 1923
    .end local v5    # "qix":I
    :cond_2
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v5, v0}, Lcom/fasterxml/aalto/in/PName;->getQuad(I)I

    move-result v5

    .line 1924
    .local v5, "lastQ":I
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v2, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v6

    and-int/lit16 v6, v6, 0xff

    .line 1925
    .local v6, "q":I
    if-eq v6, v5, :cond_3

    .line 1926
    shl-int/lit8 v7, v6, 0x8

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v2, v8}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v8

    and-int/lit16 v8, v8, 0xff

    or-int v6, v7, v8

    .line 1927
    if-eq v6, v5, :cond_3

    .line 1928
    shl-int/lit8 v7, v6, 0x8

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v2, v8}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v8

    and-int/lit16 v8, v8, 0xff

    or-int v6, v7, v8

    .line 1929
    if-eq v6, v5, :cond_3

    .line 1930
    shl-int/lit8 v7, v6, 0x8

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v2, v8}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v8

    and-int/lit16 v8, v8, 0xff

    or-int v6, v7, v8

    .line 1931
    if-eq v6, v5, :cond_3

    .line 1932
    iget-object v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v7}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p0, v7}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportUnexpectedEndTag(Ljava/lang/String;)V

    .line 1938
    :cond_3
    iget-object v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v7, v8}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v7

    and-int/lit16 v7, v7, 0xff

    .line 1939
    .local v7, "i2":I
    :goto_1
    const/16 v8, 0x20

    if-gt v7, v8, :cond_a

    .line 1940
    const/16 v9, 0x101

    const/16 v10, 0xa

    if-ne v7, v10, :cond_4

    .line 1941
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    goto :goto_2

    .line 1942
    :cond_4
    const/16 v11, 0xd

    if-ne v7, v11, :cond_7

    .line 1943
    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v11, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v8, v11, :cond_5

    .line 1944
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 1945
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    .line 1946
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1947
    return v9

    .line 1949
    :cond_5
    iget-object v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v11, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v8, v11}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v8

    if-ne v8, v10, :cond_6

    .line 1950
    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v8, v1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 1952
    :cond_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    goto :goto_2

    .line 1953
    :cond_7
    if-eq v7, v8, :cond_8

    const/16 v8, 0x9

    if-eq v7, v8, :cond_8

    .line 1954
    invoke-virtual {p0, v7}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInvalidSpace(I)V

    .line 1956
    :cond_8
    :goto_2
    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v10, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v8, v10, :cond_9

    .line 1957
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    .line 1958
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1959
    return v9

    .line 1961
    :cond_9
    iget-object v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v10, v9, 0x1

    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v8, v9}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v8

    and-int/lit16 v7, v8, 0xff

    goto :goto_1

    .line 1963
    :cond_a
    const/16 v1, 0x3e

    if-eq v7, v1, :cond_b

    .line 1964
    int-to-byte v1, v7

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v1

    const-string v3, " expected space or closing \'>\'"

    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1966
    :cond_b
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    return v4
.end method

.method private final handleHexEntityInAttribute(Z)I
    .locals 14
    .param p1, "starting"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3337
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 3338
    .local v0, "b":B
    const-string v1, " expected a hex digit (0-9a-fA-F) for character entity"

    const/16 v2, 0x66

    const/16 v3, 0x30

    const/16 v4, 0x46

    const/16 v5, 0x39

    const/4 v6, 0x0

    const/16 v7, 0x61

    const/16 v8, 0x41

    if-eqz p1, :cond_4

    .line 3339
    move v9, v0

    .line 3340
    .local v9, "ch":I
    if-gt v9, v5, :cond_0

    if-lt v9, v3, :cond_0

    .line 3341
    add-int/lit8 v9, v9, -0x30

    goto :goto_0

    .line 3342
    :cond_0
    if-gt v9, v4, :cond_1

    if-lt v9, v8, :cond_1

    .line 3343
    add-int/lit8 v10, v9, -0x41

    add-int/lit8 v9, v10, 0xa

    goto :goto_0

    .line 3344
    :cond_1
    if-gt v9, v2, :cond_2

    if-lt v9, v7, :cond_2

    .line 3345
    add-int/lit8 v10, v9, -0x61

    add-int/lit8 v9, v10, 0xa

    goto :goto_0

    .line 3347
    :cond_2
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v10

    invoke-virtual {p0, v10, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 3349
    :goto_0
    const/16 v10, -0x41

    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3350
    iput v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_entityValue:I

    .line 3351
    iget v10, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v11, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v10, v11, :cond_3

    .line 3352
    return v6

    .line 3354
    :cond_3
    iget-object v10, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v11, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v12, v11, 0x1

    iput v12, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v10, v11}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 3356
    .end local v9    # "ch":I
    :cond_4
    :goto_1
    const/16 v9, 0x3b

    if-eq v0, v9, :cond_a

    .line 3357
    move v9, v0

    .line 3358
    .restart local v9    # "ch":I
    if-gt v9, v5, :cond_5

    if-lt v9, v3, :cond_5

    .line 3359
    add-int/lit8 v9, v9, -0x30

    goto :goto_2

    .line 3360
    :cond_5
    if-gt v9, v4, :cond_6

    if-lt v9, v8, :cond_6

    .line 3361
    add-int/lit8 v10, v9, -0x41

    add-int/lit8 v9, v10, 0xa

    goto :goto_2

    .line 3362
    :cond_6
    if-gt v9, v2, :cond_7

    if-lt v9, v7, :cond_7

    .line 3363
    add-int/lit8 v10, v9, -0x61

    add-int/lit8 v9, v10, 0xa

    goto :goto_2

    .line 3365
    :cond_7
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v10

    invoke-virtual {p0, v10, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 3367
    :goto_2
    iget v10, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_entityValue:I

    shl-int/lit8 v10, v10, 0x4

    add-int/2addr v10, v9

    .line 3368
    .local v10, "value":I
    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_entityValue:I

    .line 3369
    const v11, 0x10ffff

    if-le v10, v11, :cond_8

    .line 3370
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportEntityOverflow()V

    .line 3372
    :cond_8
    iget v11, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v12, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v11, v12, :cond_9

    .line 3373
    return v6

    .line 3375
    :cond_9
    iget-object v11, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v12, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v13, v12, 0x1

    iput v13, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v11, v12}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 3376
    .end local v9    # "ch":I
    .end local v10    # "value":I
    goto :goto_1

    .line 3377
    :cond_a
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_entityValue:I

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->verifyXmlChar(I)V

    .line 3378
    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3379
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_entityValue:I

    return v1
.end method

.method private final handleNsValuePending()Z
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3584
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    const/4 v1, -0x1

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-ne v0, v1, :cond_2

    .line 3585
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handlePartialCR()Z

    move-result v0

    if-nez v0, :cond_0

    .line 3586
    return v2

    .line 3588
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nameBuffer:[C

    .line 3589
    .local v0, "attrBuffer":[C
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    array-length v2, v0

    if-lt v1, v2, :cond_1

    .line 3590
    array-length v1, v0

    invoke-static {v0, v1}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v1

    move-object v0, v1

    iput-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nameBuffer:[C

    .line 3593
    :cond_1
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    const/16 v2, 0x20

    aput-char v2, v0, v1

    .line 3594
    return v3

    .line 3598
    .end local v0    # "attrBuffer":[C
    :cond_2
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v1, :cond_3

    .line 3599
    return v2

    .line 3604
    :cond_3
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    const/16 v1, -0x3c

    const/16 v4, -0x3f

    const/16 v5, 0x78

    const/16 v6, -0x3d

    const/16 v7, -0x3e

    if-ne v0, v1, :cond_a

    .line 3605
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v8, v1, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 3606
    .local v0, "b":B
    const/16 v1, 0x23

    if-ne v0, v1, :cond_7

    .line 3607
    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3608
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v1, v4, :cond_4

    .line 3609
    return v2

    .line 3611
    :cond_4
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v5, :cond_6

    .line 3612
    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3613
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v1, v3

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 3614
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v1, v4, :cond_5

    .line 3615
    return v2

    .line 3617
    :cond_5
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleHexEntityInAttribute(Z)I

    move-result v1

    .local v1, "ch":I
    goto :goto_0

    .line 3619
    .end local v1    # "ch":I
    :cond_6
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleDecEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_0

    .line 3622
    .end local v1    # "ch":I
    :cond_7
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parseNewEntityName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    .line 3623
    .local v1, "entityName":Lcom/fasterxml/aalto/in/PName;
    if-nez v1, :cond_8

    .line 3624
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3625
    return v2

    .line 3627
    :cond_8
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeGeneralEntity(Lcom/fasterxml/aalto/in/PName;)I

    move-result v4

    .line 3628
    .local v4, "ch":I
    if-nez v4, :cond_9

    .line 3629
    iput-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 3630
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p0, v5, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportUnexpandedEntityInAttr(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 3633
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
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    if-ne v0, v6, :cond_d

    .line 3634
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    if-ne v0, v5, :cond_c

    .line 3635
    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3636
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v0, v3

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 3637
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v1, :cond_b

    .line 3638
    return v2

    .line 3640
    :cond_b
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleHexEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_1

    .line 3642
    .end local v1    # "ch":I
    :cond_c
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleDecEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_1

    .line 3644
    .end local v1    # "ch":I
    :cond_d
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    if-ne v0, v7, :cond_e

    .line 3645
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleHexEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_1

    .line 3646
    .end local v1    # "ch":I
    :cond_e
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    if-ne v0, v4, :cond_11

    .line 3647
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parseEntityName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    .line 3648
    .local v0, "entityName":Lcom/fasterxml/aalto/in/PName;
    if-nez v0, :cond_f

    .line 3649
    return v2

    .line 3651
    :cond_f
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeGeneralEntity(Lcom/fasterxml/aalto/in/PName;)I

    move-result v1

    .line 3652
    .restart local v1    # "ch":I
    if-nez v1, :cond_10

    .line 3653
    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 3654
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p0, v4, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportUnexpandedEntityInAttr(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 3656
    .end local v0    # "entityName":Lcom/fasterxml/aalto/in/PName;
    :cond_10
    goto :goto_1

    .end local v1    # "ch":I
    :cond_11
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    const/16 v1, -0x40

    if-ne v0, v1, :cond_12

    .line 3657
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleDecEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_1

    .line 3658
    .end local v1    # "ch":I
    :cond_12
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    const/16 v1, -0x41

    if-ne v0, v1, :cond_13

    .line 3659
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleHexEntityInAttribute(Z)I

    move-result v1

    .restart local v1    # "ch":I
    goto :goto_1

    .line 3662
    .end local v1    # "ch":I
    :cond_13
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleAttrValuePendingUTF8()I

    move-result v1

    .line 3664
    .restart local v1    # "ch":I
    :goto_1
    if-nez v1, :cond_14

    .line 3665
    return v2

    .line 3668
    :cond_14
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nameBuffer:[C

    .line 3670
    .local v0, "attrBuffer":[C
    shr-int/lit8 v2, v1, 0x10

    if-eqz v2, :cond_16

    .line 3671
    const/high16 v2, 0x10000

    sub-int/2addr v1, v2

    .line 3672
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    array-length v4, v0

    if-lt v2, v4, :cond_15

    .line 3673
    array-length v2, v0

    invoke-static {v0, v2}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v2

    move-object v0, v2

    iput-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nameBuffer:[C

    .line 3675
    :cond_15
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    shr-int/lit8 v4, v1, 0xa

    const v5, 0xd800

    or-int/2addr v4, v5

    int-to-char v4, v4

    aput-char v4, v0, v2

    .line 3676
    and-int/lit16 v2, v1, 0x3ff

    const v4, 0xdc00

    or-int v1, v2, v4

    .line 3678
    :cond_16
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    array-length v4, v0

    if-lt v2, v4, :cond_17

    .line 3679
    array-length v2, v0

    invoke-static {v0, v2}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v2

    move-object v0, v2

    iput-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nameBuffer:[C

    .line 3681
    :cond_17
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    int-to-char v4, v1

    aput-char v4, v0, v2

    .line 3682
    return v3
.end method

.method private initAttribute(B)V
    .locals 6
    .param p1, "quoteChar"    # B

    .line 1814
    iput-byte p1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrQuote:B

    .line 1816
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    .line 1817
    .local v0, "attrName":Lcom/fasterxml/aalto/in/PName;
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getPrefix()Ljava/lang/String;

    move-result-object v1

    .line 1820
    .local v1, "prefix":Ljava/lang/String;
    const/4 v2, 0x1

    const/4 v3, 0x0

    const-string/jumbo v4, "xmlns"

    if-nez v1, :cond_1

    .line 1821
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

    .line 1824
    .end local v4    # "nsDecl":Z
    :cond_1
    if-ne v1, v4, :cond_2

    .line 1825
    const/4 v4, 0x1

    .restart local v4    # "nsDecl":Z
    goto :goto_1

    .line 1827
    .end local v4    # "nsDecl":Z
    :cond_2
    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->bindName(Lcom/fasterxml/aalto/in/PName;Ljava/lang/String;)Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    .line 1828
    iget-boolean v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAllNsBound:Z

    if-eqz v4, :cond_3

    .line 1829
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->isBound()Z

    move-result v4

    iput-boolean v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAllNsBound:Z

    .line 1831
    :cond_3
    const/4 v4, 0x0

    .line 1835
    .restart local v4    # "nsDecl":Z
    :goto_1
    if-eqz v4, :cond_4

    .line 1836
    const/16 v5, 0x8

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1838
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    .line 1839
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currNsCount:I

    add-int/2addr v3, v2

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currNsCount:I

    goto :goto_2

    .line 1841
    :cond_4
    const/4 v2, 0x7

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1843
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    invoke-virtual {v2, v0, v3}, Lcom/fasterxml/aalto/in/AttributeCollector;->startNewValue(Lcom/fasterxml/aalto/in/PName;I)[C

    .line 1845
    :goto_2
    return-void
.end method

.method private initStartElement(Lcom/fasterxml/aalto/in/PName;)V
    .locals 3
    .param p1, "elemName"    # Lcom/fasterxml/aalto/in/PName;

    .line 1797
    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/PName;->getPrefix()Ljava/lang/String;

    move-result-object v0

    .line 1798
    .local v0, "prefix":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 1799
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAllNsBound:Z

    goto :goto_0

    .line 1801
    :cond_0
    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->bindName(Lcom/fasterxml/aalto/in/PName;Ljava/lang/String;)Lcom/fasterxml/aalto/in/PName;

    move-result-object p1

    .line 1802
    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/PName;->isBound()Z

    move-result v1

    iput-boolean v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAllNsBound:Z

    .line 1804
    :goto_0
    iput-object p1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 1805
    new-instance v1, Lcom/fasterxml/aalto/in/ElementScope;

    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currElem:Lcom/fasterxml/aalto/in/ElementScope;

    invoke-direct {v1, p1, v2}, Lcom/fasterxml/aalto/in/ElementScope;-><init>(Lcom/fasterxml/aalto/in/PName;Lcom/fasterxml/aalto/in/ElementScope;)V

    iput-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currElem:Lcom/fasterxml/aalto/in/ElementScope;

    .line 1806
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_attrCount:I

    .line 1807
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currNsCount:I

    .line 1808
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    .line 1809
    const/4 v1, 0x2

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1810
    return-void
.end method

.method private skipEntityInCharacters()I
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2910
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2911
    .local v0, "ptr":I
    add-int/lit8 v1, v0, 0x3

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-gt v1, v2, :cond_8

    .line 2912
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, v0, 0x1

    .end local v0    # "ptr":I
    .local v2, "ptr":I
    invoke-virtual {v1, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 2913
    .local v0, "b":B
    const/16 v1, 0x23

    if-ne v0, v1, :cond_1

    .line 2914
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    const/16 v3, 0x78

    if-ne v1, v3, :cond_0

    .line 2915
    add-int/lit8 v1, v2, 0x1

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleHexEntityInCharacters(I)I

    move-result v1

    return v1

    .line 2917
    :cond_0
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleDecEntityInCharacters(I)I

    move-result v1

    return v1

    .line 2920
    :cond_1
    const/16 v1, 0x61

    const/16 v3, 0x27

    const/16 v4, 0x6f

    const/16 v5, 0x3b

    if-ne v0, v1, :cond_4

    .line 2921
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v6, v2, 0x1

    .end local v2    # "ptr":I
    .local v6, "ptr":I
    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 2922
    const/16 v1, 0x6d

    const/16 v2, 0x70

    if-ne v0, v1, :cond_2

    .line 2923
    add-int/lit8 v1, v6, 0x1

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-ge v1, v3, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    .line 2924
    invoke-virtual {v1, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v2, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, v6, 0x1

    .line 2925
    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v5, :cond_3

    .line 2926
    add-int/lit8 v1, v6, 0x2

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2927
    const/16 v1, 0x26

    return v1

    .line 2929
    :cond_2
    if-ne v0, v2, :cond_3

    .line 2930
    add-int/lit8 v1, v6, 0x2

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-ge v1, v2, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    .line 2931
    invoke-virtual {v1, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v4, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, v6, 0x1

    .line 2932
    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    const/16 v2, 0x73

    if-ne v1, v2, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, v6, 0x2

    .line 2933
    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v5, :cond_3

    .line 2934
    add-int/lit8 v1, v6, 0x3

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2935
    return v3

    .line 2962
    .end local v0    # "b":B
    :cond_3
    move v0, v6

    goto/16 :goto_0

    .line 2938
    .end local v6    # "ptr":I
    .restart local v0    # "b":B
    .restart local v2    # "ptr":I
    :cond_4
    const/16 v1, 0x67

    const/16 v6, 0x74

    if-ne v0, v1, :cond_5

    .line 2939
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v6, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v3, v2, 0x1

    .line 2940
    invoke-virtual {v1, v3}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v5, :cond_7

    .line 2941
    add-int/lit8 v1, v2, 0x2

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2942
    const/16 v1, 0x3e

    return v1

    .line 2944
    :cond_5
    const/16 v1, 0x6c

    if-ne v0, v1, :cond_6

    .line 2945
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v6, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v3, v2, 0x1

    .line 2946
    invoke-virtual {v1, v3}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v5, :cond_7

    .line 2947
    add-int/lit8 v1, v2, 0x2

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2948
    const/16 v1, 0x3c

    return v1

    .line 2950
    :cond_6
    const/16 v1, 0x71

    if-ne v0, v1, :cond_7

    .line 2951
    add-int/lit8 v1, v2, 0x3

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-ge v1, v7, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    .line 2952
    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    const/16 v7, 0x75

    if-ne v1, v7, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v7, v2, 0x1

    .line 2953
    invoke-virtual {v1, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v4, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v4, v2, 0x2

    .line 2954
    invoke-virtual {v1, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v6, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v4, v2, 0x3

    .line 2955
    invoke-virtual {v1, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v5, :cond_7

    .line 2956
    add-int/lit8 v1, v2, 0x4

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2957
    return v3

    .line 2962
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

    .line 2713
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    const/4 v2, 0x0

    if-lt v0, v1, :cond_0

    .line 2714
    return v2

    .line 2718
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    const/4 v1, 0x1

    if-gez v0, :cond_10

    .line 2720
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    const/16 v3, 0x9

    const/16 v4, 0x5d

    sparse-switch v0, :sswitch_data_0

    .line 2821
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInternal()I

    goto/16 :goto_0

    .line 2722
    :sswitch_0
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2723
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    const/16 v2, 0xa

    if-ne v0, v2, :cond_2

    .line 2724
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2726
    :cond_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    .line 2727
    return v1

    .line 2730
    :sswitch_1
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 2731
    .local v0, "b":B
    const/16 v4, 0x23

    if-ne v0, v4, :cond_3

    .line 2732
    const/16 v3, -0x51

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2733
    goto/16 :goto_0

    .line 2735
    :cond_3
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parseNewEntityName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v4

    .line 2736
    .local v4, "n":Lcom/fasterxml/aalto/in/PName;
    if-nez v4, :cond_4

    .line 2737
    const/16 v1, -0x54

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2738
    return v2

    .line 2740
    :cond_4
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeGeneralEntity(Lcom/fasterxml/aalto/in/PName;)I

    move-result v5

    .line 2741
    .local v5, "ch":I
    if-nez v5, :cond_5

    .line 2742
    iput-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 2743
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    .line 2746
    .end local v0    # "b":B
    .end local v4    # "n":Lcom/fasterxml/aalto/in/PName;
    .end local v5    # "ch":I
    :cond_5
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2747
    return v1

    .line 2749
    :sswitch_2
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_entityValue:I

    .line 2750
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v3}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    const/16 v3, 0x78

    if-ne v0, v3, :cond_7

    .line 2751
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2752
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeHexEntity()Z

    move-result v0

    if-eqz v0, :cond_6

    .line 2753
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2754
    return v1

    .line 2756
    :cond_6
    const/16 v0, -0x53

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2757
    return v2

    .line 2759
    :cond_7
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeDecEntity()Z

    move-result v0

    if-eqz v0, :cond_8

    .line 2760
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2761
    return v1

    .line 2763
    :cond_8
    const/16 v0, -0x52

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2764
    return v2

    .line 2767
    :sswitch_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeDecEntity()Z

    move-result v0

    if-eqz v0, :cond_9

    .line 2768
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2769
    return v1

    .line 2771
    :cond_9
    return v2

    .line 2774
    :sswitch_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeHexEntity()Z

    move-result v0

    if-eqz v0, :cond_a

    .line 2775
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2776
    return v1

    .line 2778
    :cond_a
    return v2

    .line 2782
    :sswitch_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parseEntityName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    .line 2783
    .local v0, "n":Lcom/fasterxml/aalto/in/PName;
    if-nez v0, :cond_b

    .line 2784
    return v2

    .line 2786
    :cond_b
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeGeneralEntity(Lcom/fasterxml/aalto/in/PName;)I

    move-result v4

    .line 2787
    .local v4, "ch":I
    if-nez v4, :cond_c

    .line 2788
    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 2789
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    .line 2792
    .end local v0    # "n":Lcom/fasterxml/aalto/in/PName;
    .end local v4    # "ch":I
    :cond_c
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2793
    return v1

    .line 2796
    :sswitch_6
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v3}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    if-eq v0, v4, :cond_d

    .line 2797
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2798
    return v1

    .line 2800
    :cond_d
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2801
    const/16 v0, -0x56

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2802
    goto :goto_0

    .line 2807
    :sswitch_7
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v3}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 2808
    .local v0, "b":B
    if-ne v0, v4, :cond_e

    .line 2809
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v3, v1

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2810
    goto :goto_0

    .line 2812
    :cond_e
    const/16 v3, 0x3e

    if-ne v0, v3, :cond_f

    .line 2813
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v3, v1

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2814
    const-string v3, "Encountered \']]>\' in text segment"

    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 2818
    .end local v0    # "b":B
    :cond_f
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2819
    return v1

    .line 2824
    :goto_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v3, :cond_1

    .line 2825
    return v2

    .line 2832
    :cond_10
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2833
    .local v0, "c":I
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v3, v3, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    and-int/lit16 v4, v0, 0xff

    aget v3, v3, v4

    packed-switch v3, :pswitch_data_0

    .line 2890
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInternal()I

    goto/16 :goto_3

    .line 2858
    :pswitch_0
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v3

    and-int/lit16 v3, v3, 0xff

    .line 2860
    .local v3, "next":I
    shr-int/lit8 v4, v0, 0x8

    if-nez v4, :cond_13

    .line 2861
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v5, :cond_11

    .line 2862
    shl-int/lit8 v1, v3, 0x8

    or-int/2addr v1, v0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2863
    return v2

    .line 2865
    :cond_11
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 2866
    .local v4, "c2":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v5, v6, :cond_12

    .line 2867
    shl-int/lit8 v1, v3, 0x8

    or-int/2addr v1, v0

    shl-int/lit8 v5, v4, 0x10

    or-int/2addr v1, v5

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2868
    return v2

    .line 2870
    :cond_12
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v5, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 2871
    .local v5, "c3":I
    invoke-virtual {p0, v0, v3, v4, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_4(IIII)I

    .line 2872
    .end local v4    # "c2":I
    .end local v5    # "c3":I
    goto :goto_1

    .line 2873
    :cond_13
    shr-int/lit8 v4, v0, 0x8

    and-int/lit16 v4, v4, 0xff

    .line 2874
    .restart local v4    # "c2":I
    shr-int/lit8 v5, v0, 0x10

    .line 2876
    .restart local v5    # "c3":I
    if-nez v5, :cond_15

    .line 2877
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v6, v7, :cond_14

    .line 2878
    shl-int/lit8 v1, v3, 0x10

    or-int/2addr v1, v0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2879
    return v2

    .line 2881
    :cond_14
    iget-object v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v6, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v6

    and-int/lit16 v5, v6, 0xff

    .line 2882
    and-int/lit16 v6, v0, 0xff

    invoke-virtual {p0, v6, v4, v3, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_4(IIII)I

    goto :goto_1

    .line 2884
    :cond_15
    and-int/lit16 v6, v0, 0xff

    invoke-virtual {p0, v6, v4, v5, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_4(IIII)I

    .line 2888
    .end local v3    # "next":I
    .end local v4    # "c2":I
    .end local v5    # "c3":I
    :goto_1
    goto :goto_3

    .line 2842
    :pswitch_1
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v3

    and-int/lit16 v3, v3, 0xff

    .line 2843
    .restart local v3    # "next":I
    shr-int/lit8 v4, v0, 0x8

    .line 2844
    .restart local v4    # "c2":I
    if-nez v4, :cond_17

    .line 2845
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v5, v6, :cond_16

    .line 2846
    shl-int/lit8 v1, v3, 0x8

    or-int/2addr v1, v0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2847
    return v2

    .line 2849
    :cond_16
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v5, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 2850
    .restart local v5    # "c3":I
    invoke-virtual {p0, v0, v3, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_3(III)I

    .line 2851
    .end local v5    # "c3":I
    goto :goto_2

    .line 2852
    :cond_17
    and-int/lit16 v5, v0, 0xff

    invoke-virtual {p0, v5, v4, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_3(III)I

    .line 2855
    .end local v3    # "next":I
    .end local v4    # "c2":I
    :goto_2
    goto :goto_3

    .line 2836
    :pswitch_2
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->skipUtf8_2(I)V

    .line 2837
    nop

    .line 2892
    :goto_3
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2893
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

    .line 83
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    return v0
.end method

.method protected final _nextByte()B
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 88
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    return v0
.end method

.method protected final _prevByte()B
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 93
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    return v0
.end method

.method protected asyncSkipSpace()Z
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1362
    nop

    :goto_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    const/4 v2, 0x0

    if-ge v0, v1, :cond_7

    .line 1363
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 1364
    .local v0, "b":B
    and-int/lit16 v1, v0, 0xff

    const/4 v3, -0x1

    const/16 v4, 0x20

    const/4 v5, 0x1

    if-le v1, v4, :cond_1

    .line 1366
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    if-ne v1, v3, :cond_0

    .line 1367
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    .line 1368
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 1370
    :cond_0
    return v5

    .line 1372
    :cond_1
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v1, v5

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 1373
    const/16 v1, 0xa

    if-ne v0, v1, :cond_2

    .line 1374
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    goto :goto_1

    .line 1375
    :cond_2
    const/16 v6, 0xd

    if-ne v0, v6, :cond_5

    .line 1376
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v6, :cond_3

    .line 1377
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 1378
    goto :goto_2

    .line 1380
    :cond_3
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v2, v3}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    if-ne v2, v1, :cond_4

    .line 1381
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v1, v5

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 1383
    :cond_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    goto :goto_1

    .line 1384
    :cond_5
    if-eq v0, v4, :cond_6

    const/16 v1, 0x9

    if-eq v0, v1, :cond_6

    .line 1385
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInvalidSpace(I)V

    .line 1387
    .end local v0    # "b":B
    :cond_6
    :goto_1
    goto :goto_0

    .line 1388
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

    .line 1542
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_entityValue:I

    .line 1543
    .local v0, "value":I
    :goto_0
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-ge v1, v2, :cond_4

    .line 1544
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    .line 1545
    .local v1, "b":B
    const/16 v2, 0x3b

    if-ne v1, v2, :cond_0

    .line 1546
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_entityValue:I

    .line 1547
    const/4 v2, 0x1

    return v2

    .line 1549
    :cond_0
    add-int/lit8 v2, v1, -0x30

    .line 1550
    .local v2, "ch":I
    if-ltz v2, :cond_1

    const/16 v3, 0x9

    if-le v2, v3, :cond_2

    .line 1551
    :cond_1
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v3

    const-string v4, " expected a digit (0 - 9) for character entity"

    invoke-virtual {p0, v3, v4}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1553
    :cond_2
    mul-int/lit8 v3, v0, 0xa

    add-int v0, v3, v2

    .line 1554
    const v3, 0x10ffff

    if-le v0, v3, :cond_3

    .line 1555
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_entityValue:I

    .line 1556
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportEntityOverflow()V

    .line 1558
    .end local v1    # "b":B
    .end local v2    # "ch":I
    :cond_3
    goto :goto_0

    .line 1559
    :cond_4
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_entityValue:I

    .line 1560
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

    .line 1574
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 1575
    .local v0, "b":B
    const/16 v1, 0x3b

    if-eq v0, v1, :cond_0

    .line 1576
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

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

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1579
    :cond_0
    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v1

    .line 1580
    .local v1, "name":Ljava/lang/String;
    const-string v2, "amp"

    if-ne v1, v2, :cond_1

    .line 1581
    const/16 v2, 0x26

    return v2

    .line 1583
    :cond_1
    const-string v2, "lt"

    if-ne v1, v2, :cond_2

    .line 1584
    const/16 v2, 0x3c

    return v2

    .line 1586
    :cond_2
    const-string v2, "apos"

    if-ne v1, v2, :cond_3

    .line 1587
    const/16 v2, 0x27

    return v2

    .line 1589
    :cond_3
    const-string v2, "quot"

    if-ne v1, v2, :cond_4

    .line 1590
    const/16 v2, 0x22

    return v2

    .line 1592
    :cond_4
    const-string v2, "gt"

    if-ne v1, v2, :cond_5

    .line 1593
    const/16 v2, 0x3e

    return v2

    .line 1595
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

    .line 1509
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_entityValue:I

    .line 1510
    .local v0, "value":I
    :goto_0
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-ge v1, v2, :cond_5

    .line 1511
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    .line 1512
    .local v1, "b":B
    const/16 v2, 0x3b

    if-ne v1, v2, :cond_0

    .line 1513
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_entityValue:I

    .line 1514
    const/4 v2, 0x1

    return v2

    .line 1516
    :cond_0
    move v2, v1

    .line 1517
    .local v2, "ch":I
    const/16 v3, 0x39

    if-gt v2, v3, :cond_1

    const/16 v3, 0x30

    if-lt v2, v3, :cond_1

    .line 1518
    add-int/lit8 v2, v2, -0x30

    goto :goto_1

    .line 1519
    :cond_1
    const/16 v3, 0x46

    if-gt v2, v3, :cond_2

    const/16 v3, 0x41

    if-lt v2, v3, :cond_2

    .line 1520
    add-int/lit8 v3, v2, -0x41

    add-int/lit8 v2, v3, 0xa

    goto :goto_1

    .line 1521
    :cond_2
    const/16 v3, 0x66

    if-gt v2, v3, :cond_3

    const/16 v3, 0x61

    if-lt v2, v3, :cond_3

    .line 1522
    add-int/lit8 v3, v2, -0x61

    add-int/lit8 v2, v3, 0xa

    goto :goto_1

    .line 1524
    :cond_3
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v3

    const-string v4, " expected a hex digit (0-9a-fA-F) for character entity"

    invoke-virtual {p0, v3, v4}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1526
    :goto_1
    shl-int/lit8 v3, v0, 0x4

    add-int v0, v3, v2

    .line 1527
    const v3, 0x10ffff

    if-le v0, v3, :cond_4

    .line 1528
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_entityValue:I

    .line 1529
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportEntityOverflow()V

    .line 1531
    .end local v1    # "b":B
    .end local v2    # "ch":I
    :cond_4
    goto :goto_0

    .line 1532
    :cond_5
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_entityValue:I

    .line 1533
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

    .line 3985
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 3986
    .local v0, "d":I
    and-int/lit16 v1, v0, 0xc0

    const/16 v2, 0x80

    if-eq v1, v2, :cond_0

    .line 3987
    and-int/lit16 v1, v0, 0xff

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInvalidOther(II)V

    .line 3989
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

    .line 4008
    and-int/lit8 p1, p1, 0xf

    .line 4009
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 4010
    .local v0, "d":I
    and-int/lit16 v1, v0, 0xc0

    const/16 v2, 0x80

    if-eq v1, v2, :cond_0

    .line 4011
    and-int/lit16 v1, v0, 0xff

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInvalidOther(II)V

    .line 4013
    :cond_0
    shl-int/lit8 v1, p1, 0x6

    and-int/lit8 v3, v0, 0x3f

    or-int/2addr v1, v3

    .line 4014
    .local v1, "c":I
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 4015
    and-int/lit16 v3, v0, 0xc0

    if-eq v3, v2, :cond_1

    .line 4016
    and-int/lit16 v2, v0, 0xff

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInvalidOther(II)V

    .line 4018
    :cond_1
    shl-int/lit8 v2, v1, 0x6

    and-int/lit8 v3, v0, 0x3f

    or-int v1, v2, v3

    .line 4019
    const/16 v2, 0xd

    if-lt p1, v2, :cond_3

    .line 4020
    const v2, 0xd800

    if-lt v1, v2, :cond_3

    .line 4021
    const v2, 0xe000

    if-lt v1, v2, :cond_2

    const v2, 0xfffe

    if-lt v1, v2, :cond_3

    const v2, 0xffff

    if-gt v1, v2, :cond_3

    .line 4022
    :cond_2
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleInvalidXmlChar(I)C

    move-result v1

    .line 4026
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

    .line 4032
    and-int/lit16 v0, p2, 0xc0

    const/16 v1, 0x80

    if-eq v0, v1, :cond_0

    .line 4033
    and-int/lit16 v0, p2, 0xff

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInvalidOther(II)V

    .line 4035
    :cond_0
    and-int/lit16 v0, p3, 0xc0

    if-eq v0, v1, :cond_1

    .line 4036
    and-int/lit16 v0, p3, 0xff

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInvalidOther(II)V

    .line 4038
    :cond_1
    and-int/lit8 v0, p1, 0xf

    shl-int/lit8 v0, v0, 0xc

    and-int/lit8 v1, p2, 0x3f

    shl-int/lit8 v1, v1, 0x6

    or-int/2addr v0, v1

    and-int/lit8 v1, p3, 0x3f

    or-int/2addr v0, v1

    .line 4039
    .local v0, "c":I
    const/16 v1, 0xd

    if-lt p1, v1, :cond_3

    .line 4040
    const v1, 0xd800

    if-lt v0, v1, :cond_3

    .line 4041
    const v1, 0xe000

    if-lt v0, v1, :cond_2

    const v1, 0xfffe

    if-lt v0, v1, :cond_3

    const v1, 0xffff

    if-gt v0, v1, :cond_3

    .line 4042
    :cond_2
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleInvalidXmlChar(I)C

    move-result v0

    .line 4046
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

    .line 4052
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 4053
    .local v0, "d":I
    and-int/lit16 v1, v0, 0xc0

    const/16 v2, 0x80

    if-eq v1, v2, :cond_0

    .line 4054
    and-int/lit16 v1, v0, 0xff

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInvalidOther(II)V

    .line 4056
    :cond_0
    and-int/lit8 v1, p1, 0x7

    shl-int/lit8 v1, v1, 0x6

    and-int/lit8 v3, v0, 0x3f

    or-int p1, v1, v3

    .line 4057
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v3}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 4058
    and-int/lit16 v1, v0, 0xc0

    if-eq v1, v2, :cond_1

    .line 4059
    and-int/lit16 v1, v0, 0xff

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInvalidOther(II)V

    .line 4061
    :cond_1
    shl-int/lit8 v1, p1, 0x6

    and-int/lit8 v3, v0, 0x3f

    or-int p1, v1, v3

    .line 4062
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v3}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 4063
    and-int/lit16 v1, v0, 0xc0

    if-eq v1, v2, :cond_2

    .line 4064
    and-int/lit16 v1, v0, 0xff

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInvalidOther(II)V

    .line 4069
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

    .line 4081
    and-int/lit16 v0, p2, 0xc0

    const/16 v1, 0x80

    if-eq v0, v1, :cond_0

    .line 4082
    and-int/lit16 v0, p2, 0xff

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v2, v2, -0x2

    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInvalidOther(II)V

    .line 4084
    :cond_0
    and-int/lit8 v0, p1, 0x7

    shl-int/lit8 v0, v0, 0x6

    and-int/lit8 v2, p2, 0x3f

    or-int/2addr v0, v2

    .line 4085
    .local v0, "c":I
    and-int/lit16 v2, p3, 0xc0

    if-eq v2, v1, :cond_1

    .line 4086
    and-int/lit16 v2, p3, 0xff

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v3, v3, -0x1

    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInvalidOther(II)V

    .line 4088
    :cond_1
    shl-int/lit8 v2, v0, 0x6

    and-int/lit8 v3, p3, 0x3f

    or-int v0, v2, v3

    .line 4089
    and-int/lit16 v2, p4, 0xc0

    if-eq v2, v1, :cond_2

    .line 4090
    and-int/lit16 v1, p4, 0xff

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInvalidOther(II)V

    .line 4092
    :cond_2
    shl-int/lit8 v1, v0, 0x6

    and-int/lit8 v2, p4, 0x3f

    or-int/2addr v1, v2

    const/high16 v2, 0x10000

    sub-int/2addr v1, v2

    return v1
.end method

.method public feedInput(Ljava/nio/ByteBuffer;)V
    .locals 4
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 955
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v1, :cond_1

    .line 959
    iget-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_endOfInput:Z

    if-nez v0, :cond_0

    .line 963
    iget-wide v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pastBytesOrChars:J

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_origBufferLen:I

    int-to-long v2, v2

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pastBytesOrChars:J

    .line 964
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_rowStartOffset:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_origBufferLen:I

    sub-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_rowStartOffset:I

    .line 966
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v0

    .line 967
    .local v0, "start":I
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->limit()I

    move-result v1

    .line 970
    .local v1, "end":I
    iput-object p1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    .line 971
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 972
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    .line 973
    sub-int v2, v1, v0

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_origBufferLen:I

    .line 974
    return-void

    .line 960
    .end local v0    # "start":I
    .end local v1    # "end":I
    :cond_0
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    const-string v1, "Already closed, can not feed more input"

    invoke-direct {v0, v1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 956
    :cond_1
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Still have "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

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

    .line 2166
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    if-eqz v0, :cond_0

    .line 2168
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInternal()I

    .line 2171
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    .line 2172
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    .line 2173
    .local v1, "inputBuffer":Ljava/nio/ByteBuffer;
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v2

    .line 2175
    .local v2, "outputBuffer":[C
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->getCurrentLength()I

    move-result v3

    .line 2183
    .local v3, "outPtr":I
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2184
    .local v4, "ptr":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v5, :cond_1

    .line 2185
    goto/16 :goto_7

    .line 2187
    :cond_1
    array-length v5, v2

    if-lt v3, v5, :cond_2

    .line 2188
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v5}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2189
    const/4 v3, 0x0

    .line 2191
    :cond_2
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    .line 2193
    .local v5, "max":I
    array-length v6, v2

    sub-int/2addr v6, v3

    add-int/2addr v6, v4

    .line 2194
    .local v6, "max2":I
    if-ge v6, v5, :cond_3

    .line 2195
    move v5, v6

    .line 2198
    .end local v6    # "max2":I
    :cond_3
    :goto_1
    if-ge v4, v5, :cond_14

    .line 2199
    add-int/lit8 v6, v4, 0x1

    .end local v4    # "ptr":I
    .local v6, "ptr":I
    invoke-virtual {v1, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 2200
    .local v4, "c":I
    aget v7, v0, v4

    if-eqz v7, :cond_13

    .line 2201
    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2202
    nop

    .line 2209
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

    .line 2301
    :pswitch_1
    const/4 v5, 0x1

    .line 2302
    .local v5, "count":I
    const/4 v6, 0x0

    .line 2303
    .local v6, "b":B
    :goto_2
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v10, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    const/16 v11, 0x5d

    if-ge v7, v10, :cond_5

    .line 2304
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v6

    .line 2305
    if-eq v6, v11, :cond_4

    .line 2306
    goto :goto_3

    .line 2308
    :cond_4
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v7, v9

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2309
    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    .line 2311
    :cond_5
    :goto_3
    const/16 v7, 0x3e

    if-ne v6, v7, :cond_6

    if-le v5, v9, :cond_6

    .line 2312
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportIllegalCDataEnd()V

    .line 2316
    :cond_6
    :goto_4
    add-int/2addr v5, v8

    if-lez v5, :cond_12

    .line 2317
    add-int/lit8 v7, v3, 0x1

    .end local v3    # "outPtr":I
    .local v7, "outPtr":I
    aput-char v11, v2, v3

    .line 2319
    array-length v3, v2

    if-lt v7, v3, :cond_7

    .line 2320
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2321
    const/4 v3, 0x0

    .end local v7    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_4

    .line 2319
    .end local v3    # "outPtr":I
    .restart local v7    # "outPtr":I
    :cond_7
    move v3, v7

    goto :goto_4

    .line 2275
    .end local v5    # "count":I
    .end local v6    # "b":B
    .end local v7    # "outPtr":I
    .restart local v3    # "outPtr":I
    :pswitch_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleEntityInCharacters()I

    move-result v4

    .line 2276
    if-nez v4, :cond_8

    .line 2278
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v5, v9

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2279
    goto/16 :goto_7

    .line 2282
    :cond_8
    shr-int/lit8 v5, v4, 0x10

    if-eqz v5, :cond_12

    .line 2283
    const/high16 v5, 0x10000

    sub-int/2addr v4, v5

    .line 2284
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .local v5, "outPtr":I
    shr-int/lit8 v8, v4, 0xa

    or-int/2addr v7, v8

    int-to-char v7, v7

    aput-char v7, v2, v3

    .line 2286
    array-length v3, v2

    if-lt v5, v3, :cond_9

    .line 2287
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2288
    const/4 v3, 0x0

    .end local v5    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_5

    .line 2286
    .end local v3    # "outPtr":I
    .restart local v5    # "outPtr":I
    :cond_9
    move v3, v5

    .line 2290
    .end local v5    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_5
    and-int/lit16 v5, v4, 0x3ff

    or-int v4, v5, v6

    goto/16 :goto_8

    .line 2247
    :pswitch_3
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v5, v8

    const/4 v8, 0x3

    if-ge v5, v8, :cond_b

    .line 2248
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v5, v6, :cond_a

    .line 2249
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v5, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 2250
    .local v5, "d":I
    shl-int/lit8 v6, v5, 0x8

    or-int/2addr v4, v6

    .line 2251
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v6, v7, :cond_a

    .line 2252
    iget-object v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v6, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v6

    and-int/lit16 v5, v6, 0xff

    .line 2253
    shl-int/lit8 v6, v5, 0x10

    or-int/2addr v4, v6

    .line 2256
    .end local v5    # "d":I
    :cond_a
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2257
    goto/16 :goto_7

    .line 2259
    :cond_b
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_4(I)I

    move-result v4

    .line 2261
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .local v5, "outPtr":I
    shr-int/lit8 v8, v4, 0xa

    or-int/2addr v7, v8

    int-to-char v7, v7

    aput-char v7, v2, v3

    .line 2262
    array-length v3, v2

    if-lt v5, v3, :cond_c

    .line 2263
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2264
    const/4 v3, 0x0

    .end local v5    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_6

    .line 2262
    .end local v3    # "outPtr":I
    .restart local v5    # "outPtr":I
    :cond_c
    move v3, v5

    .line 2266
    .end local v5    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_6
    and-int/lit16 v5, v4, 0x3ff

    or-int v4, v5, v6

    .line 2268
    goto :goto_8

    .line 2236
    :pswitch_4
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v5, v6

    const/4 v6, 0x2

    if-ge v5, v6, :cond_e

    .line 2237
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v5, v6, :cond_d

    .line 2238
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v5, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 2239
    .local v5, "d":I
    shl-int/lit8 v6, v5, 0x8

    or-int/2addr v4, v6

    .line 2241
    .end local v5    # "d":I
    :cond_d
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2242
    goto :goto_7

    .line 2244
    :cond_e
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_3(I)I

    move-result v4

    .line 2245
    goto :goto_8

    .line 2229
    :pswitch_5
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v5, v6, :cond_f

    .line 2230
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2231
    goto :goto_7

    .line 2233
    :cond_f
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_2(I)I

    move-result v4

    .line 2234
    goto :goto_8

    .line 2270
    :pswitch_6
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInvalidInitial(I)V

    .line 2272
    :pswitch_7
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v5, v9

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2273
    goto :goto_7

    .line 2226
    :pswitch_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    .line 2227
    goto :goto_8

    .line 2211
    :pswitch_9
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleInvalidXmlChar(I)C

    move-result v4

    .line 2214
    :pswitch_a
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v5, v6, :cond_10

    .line 2215
    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2216
    nop

    .line 2334
    .end local v4    # "c":I
    :goto_7
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 2335
    return-void

    .line 2218
    .restart local v4    # "c":I
    :cond_10
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    const/16 v6, 0xa

    if-ne v5, v6, :cond_11

    .line 2219
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v5, v9

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2221
    :cond_11
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    .line 2223
    const/16 v4, 0xa

    .line 2224
    nop

    .line 2332
    :cond_12
    :goto_8
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .local v5, "outPtr":I
    int-to-char v6, v4

    aput-char v6, v2, v3

    .line 2333
    .end local v4    # "c":I
    move v3, v5

    goto/16 :goto_0

    .line 2204
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

    .line 2206
    .end local v6    # "ptr":I
    .end local v7    # "outPtr":I
    .restart local v3    # "outPtr":I
    .local v4, "ptr":I
    :cond_14
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2207
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

    .line 930
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    if-eqz v0, :cond_0

    .line 931
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleAndAppendPending()Z

    move-result v0

    if-nez v0, :cond_0

    .line 932
    const/16 v0, 0x101

    return v0

    .line 935
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

    .line 2992
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    .line 2993
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleAttrValuePending()Z

    move-result v0

    if-nez v0, :cond_0

    .line 2994
    return v1

    .line 2996
    :cond_0
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2999
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/AttributeCollector;->continueValue()[C

    move-result-object v0

    .line 3000
    .local v0, "attrBuffer":[C
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v2, v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    .line 3001
    .local v2, "TYPES":[I
    iget-byte v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrQuote:B

    .line 3009
    .local v3, "quoteChar":I
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v5, :cond_2

    .line 3010
    return v1

    .line 3012
    :cond_2
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    array-length v5, v0

    if-lt v4, v5, :cond_3

    .line 3013
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v4}, Lcom/fasterxml/aalto/in/AttributeCollector;->valueBufferFull()[C

    move-result-object v0

    .line 3015
    :cond_3
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    .line 3017
    .local v4, "max":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    array-length v6, v0

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    sub-int/2addr v6, v7

    add-int/2addr v5, v6

    .line 3018
    .local v5, "max2":I
    if-ge v5, v4, :cond_4

    .line 3019
    move v4, v5

    .line 3022
    .end local v5    # "max2":I
    :cond_4
    :goto_1
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-ge v5, v4, :cond_10

    .line 3023
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v5, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 3024
    .local v5, "c":I
    aget v6, v2, v5

    if-eqz v6, :cond_f

    .line 3025
    nop

    .line 3031
    .end local v4    # "max":I
    aget v4, v2, v5

    const v6, 0xdc00

    const v7, 0xd800

    const/4 v8, 0x1

    packed-switch v4, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_2

    .line 3112
    :pswitch_1
    if-ne v5, v3, :cond_e

    .line 3113
    nop

    .line 3123
    .end local v5    # "c":I
    return v8

    .line 3069
    .restart local v5    # "c":I
    :pswitch_2
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v4, v8

    const/4 v8, 0x3

    if-ge v4, v8, :cond_6

    .line 3070
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v4, v6, :cond_5

    .line 3071
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 3072
    .local v4, "d":I
    shl-int/lit8 v6, v4, 0x8

    or-int/2addr v5, v6

    .line 3073
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v6, v7, :cond_5

    .line 3074
    iget-object v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v6, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v6

    and-int/lit16 v4, v6, 0xff

    .line 3075
    shl-int/lit8 v6, v4, 0x10

    or-int/2addr v5, v6

    .line 3078
    .end local v4    # "d":I
    :cond_5
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3079
    return v1

    .line 3081
    :cond_6
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_4(I)I

    move-result v4

    .line 3083
    .end local v5    # "c":I
    .local v4, "c":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    add-int/lit8 v8, v5, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    shr-int/lit8 v8, v4, 0xa

    or-int/2addr v7, v8

    int-to-char v7, v7

    aput-char v7, v0, v5

    .line 3084
    and-int/lit16 v5, v4, 0x3ff

    or-int/2addr v5, v6

    .line 3085
    .end local v4    # "c":I
    .restart local v5    # "c":I
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    array-length v6, v0

    if-lt v4, v6, :cond_e

    .line 3086
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v4}, Lcom/fasterxml/aalto/in/AttributeCollector;->valueBufferFull()[C

    move-result-object v0

    goto/16 :goto_2

    .line 3058
    :pswitch_3
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v4, v6

    const/4 v6, 0x2

    if-ge v4, v6, :cond_8

    .line 3059
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v4, v6, :cond_7

    .line 3060
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 3061
    .local v4, "d":I
    shl-int/lit8 v6, v4, 0x8

    or-int/2addr v5, v6

    .line 3063
    .end local v4    # "d":I
    :cond_7
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3064
    return v1

    .line 3066
    :cond_8
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_3(I)I

    move-result v5

    .line 3067
    goto :goto_2

    .line 3051
    :pswitch_4
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v6, :cond_9

    .line 3052
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3053
    return v1

    .line 3055
    :cond_9
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_2(I)I

    move-result v5

    .line 3056
    goto :goto_2

    .line 3090
    :pswitch_5
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInvalidInitial(I)V

    .line 3092
    :pswitch_6
    const-string v4, "\'<\' not allowed in attribute value"

    invoke-virtual {p0, v5, v4}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 3094
    :pswitch_7
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleEntityInAttributeValue()I

    move-result v5

    .line 3095
    if-gtz v5, :cond_b

    .line 3096
    if-gez v5, :cond_a

    .line 3097
    return v1

    .line 3099
    :cond_a
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p0, v4, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportUnexpandedEntityInAttr(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 3102
    :cond_b
    shr-int/lit8 v4, v5, 0x10

    if-eqz v4, :cond_e

    .line 3103
    const/high16 v4, 0x10000

    sub-int/2addr v5, v4

    .line 3104
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    add-int/lit8 v8, v4, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    shr-int/lit8 v8, v5, 0xa

    or-int/2addr v7, v8

    int-to-char v7, v7

    aput-char v7, v0, v4

    .line 3105
    and-int/lit16 v4, v5, 0x3ff

    or-int v5, v4, v6

    .line 3106
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    array-length v6, v0

    if-lt v4, v6, :cond_e

    .line 3107
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v4}, Lcom/fasterxml/aalto/in/AttributeCollector;->valueBufferFull()[C

    move-result-object v0

    goto :goto_2

    .line 3033
    :pswitch_8
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleInvalidXmlChar(I)C

    move-result v5

    .line 3035
    :pswitch_9
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v6, :cond_c

    .line 3036
    const/4 v4, -0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3037
    return v1

    .line 3039
    :cond_c
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    const/16 v6, 0xa

    if-ne v4, v6, :cond_d

    .line 3040
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v4, v8

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 3044
    :cond_d
    :pswitch_a
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    .line 3048
    :pswitch_b
    const/16 v5, 0x20

    .line 3049
    nop

    .line 3120
    :cond_e
    :goto_2
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    add-int/lit8 v6, v4, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    int-to-char v6, v5

    aput-char v6, v0, v4

    .line 3121
    .end local v5    # "c":I
    goto/16 :goto_0

    .line 3027
    .local v4, "max":I
    .restart local v5    # "c":I
    :cond_f
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrPtr:I

    int-to-char v7, v5

    aput-char v7, v0, v6

    goto/16 :goto_1

    .line 3029
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

    .line 781
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    const/16 v1, -0x1e

    const/16 v2, -0x1f

    const/16 v3, 0x5d

    const/4 v4, 0x0

    const/16 v5, 0x101

    if-ne v0, v1, :cond_2

    .line 782
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 783
    return v5

    .line 785
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    if-eq v0, v3, :cond_1

    .line 787
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->append(C)V

    .line 788
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    return v4

    .line 790
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 791
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 792
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v1, :cond_2

    .line 793
    return v5

    .line 797
    :cond_2
    :goto_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    if-ne v0, v2, :cond_6

    .line 798
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v1, :cond_3

    .line 799
    return v5

    .line 801
    :cond_3
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v6, v1, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 802
    .local v0, "b":B
    const/16 v1, 0x3e

    if-ne v0, v1, :cond_4

    .line 803
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 804
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 805
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    .line 806
    const/16 v1, 0xc

    return v1

    .line 808
    :cond_4
    if-eq v0, v3, :cond_5

    .line 809
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v1, v1, -0x1

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 810
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    const-string v2, "]]"

    invoke-virtual {v1, v2}, Lcom/fasterxml/aalto/util/TextBuilder;->append(Ljava/lang/String;)V

    .line 811
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    return v4

    .line 813
    :cond_5
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->append(C)V

    .line 814
    .end local v0    # "b":B
    goto :goto_0

    .line 816
    :cond_6
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleAndAppendPending()Z

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

    .line 1316
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 1317
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parseCommentContents()I

    move-result v0

    return v0

    .line 1319
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    const/16 v3, 0x101

    if-lt v0, v2, :cond_1

    .line 1320
    return v3

    .line 1322
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 1324
    .local v0, "b":B
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    if-nez v2, :cond_3

    .line 1325
    const/16 v2, 0x2d

    if-eq v0, v2, :cond_2

    .line 1326
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v2

    const-string v3, " (expected \'-\' for COMMENT)"

    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 1328
    :cond_2
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1329
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    .line 1330
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parseCommentContents()I

    move-result v1

    return v1

    .line 1332
    :cond_3
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    const/4 v2, 0x3

    if-ne v1, v2, :cond_5

    .line 1334
    const/16 v1, 0x3e

    if-eq v0, v1, :cond_4

    .line 1335
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportDoubleHyphenInComments()V

    .line 1337
    :cond_4
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1338
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    .line 1339
    const/4 v1, 0x5

    return v1

    .line 1341
    :cond_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInternal()I

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

    .line 251
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    const/16 v2, 0x101

    if-lt v0, v1, :cond_0

    .line 252
    return v2

    .line 254
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    const/16 v1, -0x14

    const/16 v3, -0x15

    const/4 v4, 0x0

    if-ne v0, v1, :cond_2

    .line 255
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    const/16 v1, 0x2d

    if-eq v0, v1, :cond_1

    .line 257
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 258
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    const-string v1, "-"

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->append(Ljava/lang/String;)V

    .line 259
    return v4

    .line 261
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 262
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 263
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v1, :cond_2

    .line 264
    return v2

    .line 268
    :cond_2
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    if-ne v0, v3, :cond_4

    .line 269
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 270
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 271
    .local v0, "b":B
    const/16 v1, 0x3e

    if-eq v0, v1, :cond_3

    .line 272
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportDoubleHyphenInComments()V

    .line 274
    :cond_3
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 275
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    .line 276
    const/4 v1, 0x5

    return v1

    .line 279
    .end local v0    # "b":B
    :cond_4
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleAndAppendPending()Z

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

    .line 464
    const/4 v0, 0x0

    if-eqz p1, :cond_0

    .line 465
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v1

    .line 466
    .local v1, "outputBuffer":[C
    const/4 v2, 0x0

    .line 467
    .local v2, "outPtr":I
    iput-byte v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrQuote:B

    .line 468
    iput-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inDtdDeclaration:Z

    goto :goto_0

    .line 470
    .end local v1    # "outputBuffer":[C
    .end local v2    # "outPtr":I
    :cond_0
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    if-eqz v1, :cond_1

    .line 471
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleAndAppendPending()Z

    move-result v1

    if-nez v1, :cond_1

    .line 472
    return v0

    .line 475
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v1

    .line 476
    .restart local v1    # "outputBuffer":[C
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->getCurrentLength()I

    move-result v2

    .line 479
    .restart local v2    # "outPtr":I
    :goto_0
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v3, v3, Lcom/fasterxml/aalto/util/XmlCharTypes;->DTD_CHARS:[I

    .line 480
    .local v3, "TYPES":[I
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    .line 488
    .local v4, "inputBuffer":Ljava/nio/ByteBuffer;
    :goto_1
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v5, v6, :cond_2

    .line 489
    goto/16 :goto_4

    .line 491
    :cond_2
    array-length v5, v1

    if-lt v2, v5, :cond_3

    .line 492
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v5}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v1

    .line 493
    const/4 v2, 0x0

    .line 495
    :cond_3
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    .line 497
    .local v5, "max":I
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    array-length v7, v1

    sub-int/2addr v7, v2

    add-int/2addr v6, v7

    .line 498
    .local v6, "max2":I
    if-ge v6, v5, :cond_4

    .line 499
    move v5, v6

    .line 502
    .end local v6    # "max2":I
    :cond_4
    :goto_2
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-ge v6, v5, :cond_10

    .line 503
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v6

    and-int/lit16 v6, v6, 0xff

    .line 504
    .local v6, "c":I
    aget v7, v3, v6

    if-eqz v7, :cond_f

    .line 505
    nop

    .line 511
    .end local v5    # "max":I
    aget v5, v3, v6

    const/4 v7, 0x1

    packed-switch v5, :pswitch_data_0

    goto/16 :goto_5

    .line 593
    :pswitch_0
    iget-boolean v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inDtdDeclaration:Z

    if-nez v5, :cond_e

    iget-byte v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrQuote:B

    if-nez v5, :cond_e

    .line 594
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0, v2}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 595
    return v7

    .line 588
    :pswitch_1
    iget-byte v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrQuote:B

    if-nez v5, :cond_e

    .line 589
    iput-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inDtdDeclaration:Z

    goto/16 :goto_5

    .line 583
    :pswitch_2
    iget-boolean v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inDtdDeclaration:Z

    if-nez v5, :cond_e

    .line 584
    iput-boolean v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inDtdDeclaration:Z

    goto/16 :goto_5

    .line 547
    :pswitch_3
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v5, v7

    const/4 v7, 0x3

    if-ge v5, v7, :cond_6

    .line 548
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v5, v7, :cond_5

    .line 549
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v5, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 550
    .local v5, "d":I
    shl-int/lit8 v7, v5, 0x8

    or-int/2addr v6, v7

    .line 551
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v7, v8, :cond_5

    .line 552
    iget-object v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v7, v8}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v7

    and-int/lit16 v5, v7, 0xff

    .line 553
    shl-int/lit8 v7, v5, 0x10

    or-int/2addr v6, v7

    .line 556
    .end local v5    # "d":I
    :cond_5
    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 557
    goto/16 :goto_4

    .line 559
    :cond_6
    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_4(I)I

    move-result v5

    .line 561
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

    .line 562
    array-length v2, v1

    if-lt v6, v2, :cond_7

    .line 563
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v1

    .line 564
    const/4 v2, 0x0

    .end local v6    # "outPtr":I
    .restart local v2    # "outPtr":I
    goto :goto_3

    .line 562
    .end local v2    # "outPtr":I
    .restart local v6    # "outPtr":I
    :cond_7
    move v2, v6

    .line 566
    .end local v6    # "outPtr":I
    .restart local v2    # "outPtr":I
    :goto_3
    and-int/lit16 v6, v5, 0x3ff

    const v7, 0xdc00

    or-int/2addr v6, v7

    .line 568
    .end local v5    # "c":I
    .local v6, "c":I
    goto/16 :goto_5

    .line 536
    :pswitch_4
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v5, v7

    const/4 v7, 0x2

    if-ge v5, v7, :cond_9

    .line 537
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v5, v7, :cond_8

    .line 538
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v5, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 539
    .local v5, "d":I
    shl-int/lit8 v7, v5, 0x8

    or-int/2addr v6, v7

    .line 541
    .end local v5    # "d":I
    :cond_8
    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 542
    goto :goto_4

    .line 544
    :cond_9
    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_3(I)I

    move-result v6

    .line 545
    goto :goto_5

    .line 529
    :pswitch_5
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v5, v7, :cond_a

    .line 530
    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 531
    goto :goto_4

    .line 533
    :cond_a
    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_2(I)I

    move-result v6

    .line 534
    goto :goto_5

    .line 570
    :pswitch_6
    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInvalidInitial(I)V

    .line 573
    :pswitch_7
    iget-byte v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrQuote:B

    if-nez v5, :cond_b

    .line 574
    int-to-byte v5, v6

    iput-byte v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrQuote:B

    goto :goto_5

    .line 576
    :cond_b
    iget-byte v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrQuote:B

    if-ne v5, v6, :cond_e

    .line 577
    iput-byte v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrQuote:B

    goto :goto_5

    .line 526
    :pswitch_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    .line 527
    goto :goto_5

    .line 513
    :pswitch_9
    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleInvalidXmlChar(I)C

    move-result v6

    .line 515
    :pswitch_a
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v5, v8, :cond_c

    .line 516
    const/4 v5, -0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 517
    nop

    .line 604
    .end local v6    # "c":I
    :goto_4
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v5, v2}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 605
    return v0

    .line 519
    .restart local v6    # "c":I
    :cond_c
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    const/16 v8, 0xa

    if-ne v5, v8, :cond_d

    .line 520
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v5, v7

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 522
    :cond_d
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    .line 523
    const/16 v6, 0xa

    .line 524
    nop

    .line 602
    :cond_e
    :goto_5
    add-int/lit8 v5, v2, 0x1

    .end local v2    # "outPtr":I
    .local v5, "outPtr":I
    int-to-char v7, v6

    aput-char v7, v1, v2

    .line 603
    .end local v6    # "c":I
    move v2, v5

    goto/16 :goto_1

    .line 507
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

    .line 509
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

    .line 2411
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v1, p1, 0x1

    .end local p1    # "ptr":I
    .local v1, "ptr":I
    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result p1

    .line 2412
    .local p1, "b":B
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    .line 2413
    .local v0, "end":I
    const/4 v2, 0x0

    .line 2415
    .local v2, "value":I
    :goto_0
    move v3, p1

    .line 2416
    .local v3, "ch":I
    const/16 v4, 0x39

    if-gt v3, v4, :cond_0

    const/16 v4, 0x30

    if-ge v3, v4, :cond_1

    .line 2417
    :cond_0
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v4

    const-string v5, " expected a digit (0 - 9) for character entity"

    invoke-virtual {p0, v4, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 2419
    :cond_1
    mul-int/lit8 v4, v2, 0xa

    add-int/lit8 v5, v3, -0x30

    add-int v2, v4, v5

    .line 2420
    const v4, 0x10ffff

    if-le v2, v4, :cond_2

    .line 2421
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportEntityOverflow()V

    .line 2423
    :cond_2
    if-lt v1, v0, :cond_3

    .line 2424
    const/4 v4, 0x0

    return v4

    .line 2426
    :cond_3
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v5, v1, 0x1

    .end local v1    # "ptr":I
    .local v5, "ptr":I
    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result p1

    .line 2427
    .end local v3    # "ch":I
    const/16 v1, 0x3b

    if-ne p1, v1, :cond_4

    .line 2428
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2429
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->verifyXmlChar(I)V

    .line 2430
    return v2

    .line 2427
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

    .line 3390
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    const/4 v2, -0x1

    if-lt v0, v1, :cond_0

    .line 3391
    const/16 v0, -0x3c

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3392
    return v2

    .line 3394
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 3395
    .local v0, "b":B
    const/16 v1, 0x23

    if-ne v0, v1, :cond_5

    .line 3396
    const/16 v1, -0x3d

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3397
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v1, v3, :cond_1

    .line 3398
    return v2

    .line 3401
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v3}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    const/16 v3, 0x78

    const/4 v4, 0x1

    if-ne v1, v3, :cond_3

    .line 3402
    const/16 v1, -0x3e

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3403
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v1, v4

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 3404
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v1, v3, :cond_2

    .line 3405
    return v2

    .line 3407
    :cond_2
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleHexEntityInAttribute(Z)I

    move-result v1

    .local v1, "ch":I
    goto :goto_0

    .line 3409
    .end local v1    # "ch":I
    :cond_3
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleDecEntityInAttribute(Z)I

    move-result v1

    .line 3411
    .restart local v1    # "ch":I
    :goto_0
    if-nez v1, :cond_4

    .line 3412
    return v2

    .line 3414
    :cond_4
    return v1

    .line 3416
    .end local v1    # "ch":I
    :cond_5
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parseNewEntityName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    .line 3417
    .local v1, "entityName":Lcom/fasterxml/aalto/in/PName;
    if-nez v1, :cond_6

    .line 3418
    const/16 v3, -0x3f

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3419
    return v2

    .line 3421
    :cond_6
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeGeneralEntity(Lcom/fasterxml/aalto/in/PName;)I

    move-result v2

    .line 3422
    .local v2, "ch":I
    if-eqz v2, :cond_7

    .line 3423
    return v2

    .line 3425
    :cond_7
    iput-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 3426
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

    .line 2354
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2355
    .local v0, "ptr":I
    add-int/lit8 v1, v0, 0x3

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-gt v1, v2, :cond_8

    .line 2356
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, v0, 0x1

    .end local v0    # "ptr":I
    .local v2, "ptr":I
    invoke-virtual {v1, v0}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 2357
    .local v0, "b":B
    const/16 v1, 0x23

    if-ne v0, v1, :cond_1

    .line 2358
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    const/16 v3, 0x78

    if-ne v1, v3, :cond_0

    .line 2359
    add-int/lit8 v1, v2, 0x1

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleHexEntityInCharacters(I)I

    move-result v1

    return v1

    .line 2361
    :cond_0
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleDecEntityInCharacters(I)I

    move-result v1

    return v1

    .line 2364
    :cond_1
    const/16 v1, 0x61

    const/16 v3, 0x27

    const/16 v4, 0x6f

    const/16 v5, 0x3b

    if-ne v0, v1, :cond_4

    .line 2365
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v6, v2, 0x1

    .end local v2    # "ptr":I
    .local v6, "ptr":I
    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 2366
    const/16 v1, 0x6d

    const/16 v2, 0x70

    if-ne v0, v1, :cond_2

    .line 2367
    add-int/lit8 v1, v6, 0x1

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-ge v1, v3, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    .line 2368
    invoke-virtual {v1, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v2, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, v6, 0x1

    .line 2369
    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v5, :cond_3

    .line 2370
    add-int/lit8 v1, v6, 0x2

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2371
    const/16 v1, 0x26

    return v1

    .line 2373
    :cond_2
    if-ne v0, v2, :cond_3

    .line 2374
    add-int/lit8 v1, v6, 0x2

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-ge v1, v2, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    .line 2375
    invoke-virtual {v1, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v4, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, v6, 0x1

    .line 2376
    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    const/16 v2, 0x73

    if-ne v1, v2, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v2, v6, 0x2

    .line 2377
    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v5, :cond_3

    .line 2378
    add-int/lit8 v1, v6, 0x3

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2379
    return v3

    .line 2406
    .end local v0    # "b":B
    :cond_3
    move v0, v6

    goto/16 :goto_0

    .line 2382
    .end local v6    # "ptr":I
    .restart local v0    # "b":B
    .restart local v2    # "ptr":I
    :cond_4
    const/16 v1, 0x67

    const/16 v6, 0x74

    if-ne v0, v1, :cond_5

    .line 2383
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v6, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v3, v2, 0x1

    .line 2384
    invoke-virtual {v1, v3}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v5, :cond_7

    .line 2385
    add-int/lit8 v1, v2, 0x2

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2386
    const/16 v1, 0x3e

    return v1

    .line 2388
    :cond_5
    const/16 v1, 0x6c

    if-ne v0, v1, :cond_6

    .line 2389
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v6, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v3, v2, 0x1

    .line 2390
    invoke-virtual {v1, v3}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v5, :cond_7

    .line 2391
    add-int/lit8 v1, v2, 0x2

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2392
    const/16 v1, 0x3c

    return v1

    .line 2394
    :cond_6
    const/16 v1, 0x71

    if-ne v0, v1, :cond_7

    .line 2395
    add-int/lit8 v1, v2, 0x3

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-ge v1, v7, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    .line 2396
    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    const/16 v7, 0x75

    if-ne v1, v7, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v7, v2, 0x1

    .line 2397
    invoke-virtual {v1, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v4, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v4, v2, 0x2

    .line 2398
    invoke-virtual {v1, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v6, :cond_7

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v4, v2, 0x3

    .line 2399
    invoke-virtual {v1, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    if-ne v1, v5, :cond_7

    .line 2400
    add-int/lit8 v1, v2, 0x4

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2401
    return v3

    .line 2406
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

    .line 1399
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    .line 1400
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 1401
    .local v0, "b":B
    const/16 v1, 0x23

    const/16 v2, 0x101

    if-ne v0, v1, :cond_1

    .line 1402
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    .line 1403
    const/4 v1, 0x5

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1404
    const/16 v1, -0x46

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 1405
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v1, v3, :cond_0

    .line 1406
    return v2

    .line 1408
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleNumericEntityStartingToken()I

    move-result v1

    return v1

    .line 1410
    :cond_1
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parseNewEntityName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    .line 1412
    .local v1, "n":Lcom/fasterxml/aalto/in/PName;
    if-nez v1, :cond_2

    .line 1414
    const/4 v3, 0x6

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1415
    return v2

    .line 1417
    :cond_2
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeGeneralEntity(Lcom/fasterxml/aalto/in/PName;)I

    move-result v2

    .line 1418
    .local v2, "ch":I
    if-nez v2, :cond_3

    .line 1419
    iput-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 1420
    const/16 v3, 0x9

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    return v3

    .line 1423
    :cond_3
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    int-to-char v4, v2

    invoke-virtual {v3, v4}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithChar(C)V

    .line 1424
    const/4 v3, 0x0

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    .line 1425
    const/4 v3, 0x4

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    .line 1426
    iget-boolean v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_cfgLazyParsing:Z

    if-eqz v3, :cond_4

    .line 1427
    const/4 v3, 0x1

    iput-boolean v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenIncomplete:Z

    goto :goto_0

    .line 1429
    :cond_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->finishCharacters()V

    .line 1431
    :goto_0
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

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

    .line 2435
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v1, p1, 0x1

    .end local p1    # "ptr":I
    .local v1, "ptr":I
    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result p1

    .line 2436
    .local p1, "b":B
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    .line 2437
    .local v0, "end":I
    const/4 v2, 0x0

    .line 2439
    .local v2, "value":I
    :goto_0
    move v3, p1

    .line 2440
    .local v3, "ch":I
    const/16 v4, 0x39

    if-gt v3, v4, :cond_0

    const/16 v4, 0x30

    if-lt v3, v4, :cond_0

    .line 2441
    add-int/lit8 v3, v3, -0x30

    goto :goto_1

    .line 2442
    :cond_0
    const/16 v4, 0x46

    if-gt v3, v4, :cond_1

    const/16 v4, 0x41

    if-lt v3, v4, :cond_1

    .line 2443
    add-int/lit8 v4, v3, -0x41

    add-int/lit8 v3, v4, 0xa

    goto :goto_1

    .line 2444
    :cond_1
    const/16 v4, 0x66

    if-gt v3, v4, :cond_2

    const/16 v4, 0x61

    if-lt v3, v4, :cond_2

    .line 2445
    add-int/lit8 v4, v3, -0x61

    add-int/lit8 v3, v4, 0xa

    goto :goto_1

    .line 2447
    :cond_2
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v4

    const-string v5, " expected a hex digit (0-9a-fA-F) for character entity"

    invoke-virtual {p0, v4, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 2449
    :goto_1
    shl-int/lit8 v4, v2, 0x4

    add-int v2, v4, v3

    .line 2450
    const v4, 0x10ffff

    if-le v2, v4, :cond_3

    .line 2451
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportEntityOverflow()V

    .line 2453
    :cond_3
    if-lt v1, v0, :cond_4

    .line 2454
    const/4 v4, 0x0

    return v4

    .line 2456
    :cond_4
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    add-int/lit8 v5, v1, 0x1

    .end local v1    # "ptr":I
    .local v5, "ptr":I
    invoke-virtual {v4, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result p1

    .line 2457
    .end local v3    # "ch":I
    const/16 v1, 0x3b

    if-ne p1, v1, :cond_5

    .line 2458
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2459
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->verifyXmlChar(I)V

    .line 2460
    return v2

    .line 2457
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

    .line 1440
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parseEntityName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    .line 1442
    .local v0, "n":Lcom/fasterxml/aalto/in/PName;
    if-nez v0, :cond_0

    .line 1443
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    return v1

    .line 1445
    :cond_0
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeGeneralEntity(Lcom/fasterxml/aalto/in/PName;)I

    move-result v1

    .line 1446
    .local v1, "ch":I
    if-nez v1, :cond_1

    .line 1447
    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 1448
    const/16 v2, 0x9

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    return v2

    .line 1451
    :cond_1
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    int-to-char v3, v1

    invoke-virtual {v2, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithChar(C)V

    .line 1452
    const/4 v2, 0x0

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    .line 1453
    const/4 v2, 0x4

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    .line 1454
    iget-boolean v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_cfgLazyParsing:Z

    if-eqz v2, :cond_2

    .line 1455
    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenIncomplete:Z

    goto :goto_0

    .line 1457
    :cond_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->finishCharacters()V

    .line 1459
    :goto_0
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    return v2
.end method

.method protected handleNsDecl()Z
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3432
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    .line 3433
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nameBuffer:[C

    .line 3434
    .local v1, "attrBuffer":[C
    iget-byte v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrQuote:B

    .line 3437
    .local v2, "quoteChar":I
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    const/4 v4, 0x0

    if-eqz v3, :cond_1

    .line 3438
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleNsValuePending()Z

    move-result v3

    if-nez v3, :cond_0

    .line 3439
    return v4

    .line 3441
    :cond_0
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3450
    :cond_1
    :goto_0
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v3, v5, :cond_2

    .line 3451
    return v4

    .line 3453
    :cond_2
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    array-length v5, v1

    if-lt v3, v5, :cond_3

    .line 3454
    array-length v3, v1

    invoke-static {v1, v3}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v3

    move-object v1, v3

    iput-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nameBuffer:[C

    .line 3456
    :cond_3
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    .line 3458
    .local v3, "max":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    array-length v6, v1

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    sub-int/2addr v6, v7

    add-int/2addr v5, v6

    .line 3459
    .local v5, "max2":I
    if-ge v5, v3, :cond_4

    .line 3460
    move v3, v5

    .line 3463
    .end local v5    # "max2":I
    :cond_4
    :goto_1
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-ge v5, v3, :cond_11

    .line 3464
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v5, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 3465
    .local v5, "c":I
    aget v6, v0, v5

    if-eqz v6, :cond_10

    .line 3466
    nop

    .line 3472
    .end local v3    # "max":I
    aget v3, v0, v5

    const v6, 0xdc00

    const v7, 0xd800

    const/4 v8, 0x1

    packed-switch v3, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_3

    .line 3553
    :pswitch_1
    if-ne v5, v2, :cond_f

    .line 3554
    nop

    .line 3568
    .end local v5    # "c":I
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    .line 3569
    .local v3, "attrPtr":I
    if-nez v3, :cond_5

    .line 3570
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    const-string v5, ""

    invoke-virtual {p0, v4, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->bindNs(Lcom/fasterxml/aalto/in/PName;Ljava/lang/String;)V

    goto :goto_2

    .line 3572
    :cond_5
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v4, v1, v3}, Lcom/fasterxml/aalto/in/ReaderConfig;->canonicalizeURI([CI)Ljava/lang/String;

    move-result-object v4

    .line 3573
    .local v4, "uri":Ljava/lang/String;
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p0, v5, v4}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->bindNs(Lcom/fasterxml/aalto/in/PName;Ljava/lang/String;)V

    .line 3575
    .end local v4    # "uri":Ljava/lang/String;
    :goto_2
    return v8

    .line 3510
    .end local v3    # "attrPtr":I
    .restart local v5    # "c":I
    :pswitch_2
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v3, v8

    const/4 v8, 0x3

    if-ge v3, v8, :cond_7

    .line 3511
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v3, v6, :cond_6

    .line 3512
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v3, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v3

    and-int/lit16 v3, v3, 0xff

    .line 3513
    .local v3, "d":I
    shl-int/lit8 v6, v3, 0x8

    or-int/2addr v5, v6

    .line 3514
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v6, v7, :cond_6

    .line 3515
    iget-object v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v6, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v6

    and-int/lit16 v3, v6, 0xff

    .line 3516
    shl-int/lit8 v6, v3, 0x10

    or-int/2addr v5, v6

    .line 3519
    .end local v3    # "d":I
    :cond_6
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3520
    return v4

    .line 3522
    :cond_7
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_4(I)I

    move-result v3

    .line 3524
    .end local v5    # "c":I
    .local v3, "c":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    add-int/lit8 v8, v5, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    shr-int/lit8 v8, v3, 0xa

    or-int/2addr v7, v8

    int-to-char v7, v7

    aput-char v7, v1, v5

    .line 3525
    and-int/lit16 v5, v3, 0x3ff

    or-int/2addr v5, v6

    .line 3526
    .end local v3    # "c":I
    .restart local v5    # "c":I
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    array-length v6, v1

    if-lt v3, v6, :cond_f

    .line 3527
    array-length v3, v1

    invoke-static {v1, v3}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v3

    move-object v1, v3

    iput-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nameBuffer:[C

    goto/16 :goto_3

    .line 3499
    :pswitch_3
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v3, v6

    const/4 v6, 0x2

    if-ge v3, v6, :cond_9

    .line 3500
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v3, v6, :cond_8

    .line 3501
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v3, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v3

    and-int/lit16 v3, v3, 0xff

    .line 3502
    .local v3, "d":I
    shl-int/lit8 v6, v3, 0x8

    or-int/2addr v5, v6

    .line 3504
    .end local v3    # "d":I
    :cond_8
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3505
    return v4

    .line 3507
    :cond_9
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_3(I)I

    move-result v5

    .line 3508
    goto :goto_3

    .line 3492
    :pswitch_4
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v3, v6, :cond_a

    .line 3493
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3494
    return v4

    .line 3496
    :cond_a
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_2(I)I

    move-result v5

    .line 3497
    goto :goto_3

    .line 3531
    :pswitch_5
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInvalidInitial(I)V

    .line 3533
    :pswitch_6
    const-string v3, "\'<\' not allowed in attribute value"

    invoke-virtual {p0, v5, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 3535
    :pswitch_7
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleEntityInAttributeValue()I

    move-result v5

    .line 3536
    if-gtz v5, :cond_c

    .line 3537
    if-gez v5, :cond_b

    .line 3538
    return v4

    .line 3540
    :cond_b
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p0, v3, v8}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportUnexpandedEntityInAttr(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 3543
    :cond_c
    shr-int/lit8 v3, v5, 0x10

    if-eqz v3, :cond_f

    .line 3544
    const/high16 v3, 0x10000

    sub-int/2addr v5, v3

    .line 3545
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    add-int/lit8 v8, v3, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    shr-int/lit8 v8, v5, 0xa

    or-int/2addr v7, v8

    int-to-char v7, v7

    aput-char v7, v1, v3

    .line 3546
    and-int/lit16 v3, v5, 0x3ff

    or-int v5, v3, v6

    .line 3547
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    array-length v6, v1

    if-lt v3, v6, :cond_f

    .line 3548
    array-length v3, v1

    invoke-static {v1, v3}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v3

    move-object v1, v3

    iput-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nameBuffer:[C

    goto :goto_3

    .line 3474
    :pswitch_8
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleInvalidXmlChar(I)C

    move-result v5

    .line 3476
    :pswitch_9
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v3, v6, :cond_d

    .line 3477
    const/4 v3, -0x1

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3478
    return v4

    .line 3480
    :cond_d
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v3, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v3

    const/16 v6, 0xa

    if-ne v3, v6, :cond_e

    .line 3481
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v3, v8

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 3485
    :cond_e
    :pswitch_a
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    .line 3489
    :pswitch_b
    const/16 v5, 0x20

    .line 3490
    nop

    .line 3561
    :cond_f
    :goto_3
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    add-int/lit8 v6, v3, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    int-to-char v6, v5

    aput-char v6, v1, v3

    .line 3562
    .end local v5    # "c":I
    goto/16 :goto_0

    .line 3468
    .local v3, "max":I
    .restart local v5    # "c":I
    :cond_10
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemNsPtr:I

    int-to-char v7, v5

    aput-char v7, v1, v6

    goto/16 :goto_1

    .line 3470
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

    .line 1469
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    const/16 v1, -0x46

    const/4 v2, 0x1

    const/4 v3, 0x0

    const/16 v4, -0x49

    const/16 v5, 0x101

    if-ne v0, v1, :cond_1

    .line 1470
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 1471
    .local v0, "b":B
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_entityValue:I

    .line 1472
    const/16 v1, 0x78

    if-ne v0, v1, :cond_0

    .line 1473
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 1474
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v1, v2

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v1, v6, :cond_1

    .line 1475
    return v5

    .line 1478
    :cond_0
    const/16 v1, -0x48

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 1482
    .end local v0    # "b":B
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    if-ne v0, v4, :cond_2

    .line 1483
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeHexEntity()Z

    move-result v0

    if-nez v0, :cond_3

    .line 1484
    return v5

    .line 1487
    :cond_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeDecEntity()Z

    move-result v0

    if-nez v0, :cond_3

    .line 1488
    return v5

    .line 1492
    :cond_3
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_entityValue:I

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->verifyAndAppendEntityCharacter(I)V

    .line 1493
    const/4 v0, 0x4

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    .line 1494
    iget-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_cfgLazyParsing:Z

    if-eqz v0, :cond_4

    .line 1495
    iput-boolean v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenIncomplete:Z

    goto :goto_0

    .line 1497
    :cond_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->finishCharacters()V

    .line 1499
    :goto_0
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 1500
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    return v0
.end method

.method protected handlePI()I
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1217
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    const/4 v1, 0x5

    if-ne v0, v1, :cond_0

    .line 1218
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parsePIData()I

    move-result v0

    return v0

    .line 1223
    :cond_0
    :goto_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    const/16 v3, 0x101

    if-lt v0, v2, :cond_1

    .line 1224
    return v3

    .line 1226
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    const/4 v2, 0x3

    const/16 v4, 0x3e

    const/4 v5, 0x1

    packed-switch v0, :pswitch_data_0

    .line 1304
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInternal()I

    move-result v0

    return v0

    .line 1295
    :pswitch_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parsePName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 1296
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    if-nez v0, :cond_2

    .line 1297
    return v3

    .line 1299
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->checkPITargetName(Lcom/fasterxml/aalto/in/PName;)V

    .line 1300
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1301
    goto :goto_0

    .line 1286
    :pswitch_1
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v5, v1, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 1288
    .local v0, "b":B
    if-eq v0, v4, :cond_3

    .line 1289
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v1

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportMissingPISpace(I)V

    .line 1293
    .end local v0    # "b":B
    :cond_3
    goto/16 :goto_2

    .line 1228
    :pswitch_2
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parseNewName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 1229
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    if-nez v0, :cond_4

    .line 1230
    const/4 v0, 0x4

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1231
    return v3

    .line 1233
    :cond_4
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1234
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->checkPITargetName(Lcom/fasterxml/aalto/in/PName;)V

    .line 1235
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v6, :cond_5

    .line 1236
    return v3

    .line 1242
    :cond_5
    :pswitch_3
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 1243
    .restart local v0    # "b":B
    const/16 v6, 0x3f

    if-ne v0, v6, :cond_7

    .line 1245
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-ge v6, v7, :cond_6

    iget-object v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v6, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v6

    if-ne v6, v4, :cond_6

    .line 1246
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v1, v5

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 1247
    goto :goto_2

    .line 1250
    :cond_6
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1251
    goto/16 :goto_0

    .line 1253
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

    .line 1272
    :cond_8
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v2

    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportMissingPISpace(I)V

    .line 1276
    .end local v0    # "b":B
    :pswitch_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->asyncSkipSpace()Z

    move-result v0

    if-nez v0, :cond_9

    .line 1277
    return v3

    .line 1280
    :cond_9
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1281
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    .line 1282
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parsePIData()I

    move-result v0

    return v0

    .line 1255
    .restart local v0    # "b":B
    :cond_a
    :goto_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->asyncSkipSpace()Z

    move-result v7

    const/4 v8, 0x2

    if-nez v7, :cond_b

    .line 1256
    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1257
    return v3

    .line 1259
    :cond_b
    iget-object v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v7}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    .line 1261
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v7, v5

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-ge v7, v9, :cond_c

    iget-object v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 1262
    invoke-virtual {v7, v9}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v7

    if-ne v7, v6, :cond_c

    iget-object v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v7, v5

    .line 1263
    invoke-virtual {v6, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    if-ne v5, v4, :cond_c

    .line 1264
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v1, v8

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 1265
    nop

    .line 1308
    .end local v0    # "b":B
    :goto_2
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1309
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    .line 1310
    return v2

    .line 1268
    .restart local v0    # "b":B
    :cond_c
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1269
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parsePIData()I

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

    .line 432
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    const/16 v1, -0xf

    const/16 v2, 0x101

    const/4 v3, 0x0

    if-ne v0, v1, :cond_2

    .line 433
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 434
    return v2

    .line 436
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 437
    .local v0, "b":B
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 438
    const/16 v1, 0x3e

    if-eq v0, v1, :cond_1

    .line 440
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    const/16 v2, 0x3f

    invoke-virtual {v1, v2}, Lcom/fasterxml/aalto/util/TextBuilder;->append(C)V

    .line 441
    return v3

    .line 443
    :cond_1
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 444
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 445
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    .line 446
    const/4 v1, 0x3

    return v1

    .line 449
    .end local v0    # "b":B
    :cond_2
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleAndAppendPending()Z

    move-result v0

    if-eqz v0, :cond_3

    move v2, v3

    :cond_3
    return v2
.end method

.method protected final handlePartialCR()Z
    .locals 3

    .line 3957
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    .line 3958
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInternal()I

    .line 3960
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    const/4 v2, 0x0

    if-lt v0, v1, :cond_1

    .line 3961
    return v2

    .line 3963
    :cond_1
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 3964
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    const/16 v1, 0xa

    const/4 v2, 0x1

    if-ne v0, v1, :cond_2

    .line 3965
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v0, v2

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 3967
    :cond_2
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currRow:I

    add-int/2addr v0, v2

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currRow:I

    .line 3968
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_rowStartOffset:I

    .line 3969
    return v2
.end method

.method protected handleStartElement()I
    .locals 16
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1620
    move-object/from16 v0, p0

    :goto_0
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v2, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    const/16 v3, 0x101

    if-lt v1, v2, :cond_0

    .line 1621
    return v3

    .line 1627
    :cond_0
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

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

    .line 1790
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInternal()I

    goto :goto_0

    .line 1783
    :pswitch_0
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v2, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    .line 1784
    .local v1, "b":B
    if-eq v1, v9, :cond_1

    .line 1785
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v2

    const-string v3, " expected \'>\'"

    invoke-virtual {v0, v2, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1787
    :cond_1
    invoke-direct {v0, v13}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->finishStartElement(Z)I

    move-result v2

    return v2

    .line 1775
    .end local v1    # "b":B
    :pswitch_1
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleNsDecl()Z

    move-result v1

    if-nez v1, :cond_2

    .line 1776
    return v3

    .line 1778
    :cond_2
    iput v7, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1779
    goto :goto_0

    .line 1768
    :pswitch_2
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleAttrValue()Z

    move-result v1

    if-nez v1, :cond_3

    .line 1769
    return v3

    .line 1771
    :cond_3
    iput v7, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1772
    goto :goto_0

    .line 1630
    :pswitch_3
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parsePName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    .line 1631
    .local v1, "elemName":Lcom/fasterxml/aalto/in/PName;
    if-nez v1, :cond_4

    .line 1632
    return v3

    .line 1634
    :cond_4
    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->initStartElement(Lcom/fasterxml/aalto/in/PName;)V

    .line 1636
    .end local v1    # "elemName":Lcom/fasterxml/aalto/in/PName;
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v7, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v1, v7, :cond_5

    .line 1637
    return v3

    .line 1642
    :cond_5
    :pswitch_4
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    if-eqz v1, :cond_6

    .line 1643
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handlePartialCR()Z

    move-result v1

    if-nez v1, :cond_e

    .line 1644
    return v3

    .line 1648
    :cond_6
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v7, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v14, v7, 0x1

    iput v14, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    .line 1649
    .local v1, "b":B
    and-int/lit16 v7, v1, 0xff

    .line 1651
    .local v7, "c":I
    if-gt v7, v12, :cond_b

    .line 1652
    if-ne v7, v11, :cond_7

    .line 1653
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    goto :goto_1

    .line 1654
    :cond_7
    if-ne v7, v4, :cond_a

    .line 1655
    iget v14, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v15, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v14, v15, :cond_8

    .line 1656
    iput v2, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 1657
    return v3

    .line 1659
    :cond_8
    iget-object v14, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v15, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v14, v15}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v14

    if-ne v14, v11, :cond_9

    .line 1660
    iget v14, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v14, v13

    iput v14, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 1662
    :cond_9
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    goto :goto_1

    .line 1663
    :cond_a
    if-eq v7, v12, :cond_e

    if-eq v7, v10, :cond_e

    .line 1664
    invoke-virtual {v0, v7}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInvalidSpace(I)V

    goto :goto_1

    .line 1666
    :cond_b
    if-ne v7, v9, :cond_c

    .line 1667
    invoke-direct {v0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->finishStartElement(Z)I

    move-result v2

    return v2

    .line 1668
    :cond_c
    if-ne v7, v6, :cond_d

    .line 1669
    iput v10, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1670
    goto/16 :goto_0

    .line 1672
    :cond_d
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v14

    const-string v15, " expected space, or \'>\' or \"/>\""

    invoke-virtual {v0, v14, v15}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1675
    .end local v1    # "b":B
    .end local v7    # "c":I
    :cond_e
    :goto_1
    const/4 v1, 0x3

    iput v1, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1676
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v7, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v1, v7, :cond_f

    .line 1677
    return v3

    .line 1686
    :cond_f
    :pswitch_5
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    if-eqz v1, :cond_11

    .line 1687
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handlePartialCR()Z

    move-result v1

    if-nez v1, :cond_10

    .line 1688
    return v3

    .line 1690
    :cond_10
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v7, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v1, v7, :cond_11

    .line 1691
    return v3

    .line 1694
    :cond_11
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v7, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v14, v7, 0x1

    iput v14, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    .line 1695
    .restart local v1    # "b":B
    and-int/lit16 v7, v1, 0xff

    .line 1697
    .restart local v7    # "c":I
    :goto_2
    if-gt v7, v12, :cond_18

    .line 1698
    if-ne v7, v11, :cond_12

    .line 1699
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    goto :goto_3

    .line 1700
    :cond_12
    if-ne v7, v4, :cond_15

    .line 1701
    iget v14, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v15, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v14, v15, :cond_13

    .line 1702
    iput v2, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 1703
    return v3

    .line 1705
    :cond_13
    iget-object v14, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v15, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v14, v15}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v14

    if-ne v14, v11, :cond_14

    .line 1706
    iget v14, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v14, v13

    iput v14, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 1708
    :cond_14
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    goto :goto_3

    .line 1709
    :cond_15
    if-eq v7, v12, :cond_16

    if-eq v7, v10, :cond_16

    .line 1710
    invoke-virtual {v0, v7}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInvalidSpace(I)V

    .line 1712
    :cond_16
    :goto_3
    iget v14, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v15, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v14, v15, :cond_17

    .line 1713
    return v3

    .line 1715
    :cond_17
    iget-object v14, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v15, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v2, v15, 0x1

    iput v2, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v14, v15}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    .line 1716
    and-int/lit16 v7, v1, 0xff

    const/4 v2, -0x1

    goto :goto_2

    .line 1719
    :cond_18
    iget v2, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    packed-switch v2, :pswitch_data_1

    .line 1753
    :pswitch_6
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInternal()I

    goto :goto_4

    .line 1747
    :pswitch_7
    const/16 v2, 0x22

    if-eq v1, v2, :cond_19

    const/16 v2, 0x27

    if-eq v1, v2, :cond_19

    .line 1748
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v2

    const-string v3, " Expected a quote"

    invoke-virtual {v0, v2, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1750
    :cond_19
    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->initAttribute(B)V

    .line 1751
    goto/16 :goto_0

    .line 1740
    :pswitch_8
    const/16 v2, 0x3d

    if-eq v1, v2, :cond_1a

    .line 1741
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v2

    const-string v3, " expected \'=\'"

    invoke-virtual {v0, v2, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1743
    :cond_1a
    const/4 v2, 0x6

    iput v2, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1744
    goto/16 :goto_0

    .line 1721
    :pswitch_9
    if-ne v1, v6, :cond_1b

    .line 1722
    iput v10, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1723
    goto/16 :goto_0

    .line 1725
    :cond_1b
    if-ne v1, v9, :cond_1c

    .line 1726
    invoke-direct {v0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->finishStartElement(Z)I

    move-result v2

    return v2

    .line 1729
    :cond_1c
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parseNewName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    .line 1730
    .local v2, "n":Lcom/fasterxml/aalto/in/PName;
    if-nez v2, :cond_1d

    .line 1731
    const/4 v4, 0x4

    iput v4, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1732
    return v3

    .line 1734
    :cond_1d
    iput v8, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1735
    iput-object v2, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    .line 1737
    .end local v2    # "n":Lcom/fasterxml/aalto/in/PName;
    goto/16 :goto_0

    .line 1758
    .end local v1    # "b":B
    .end local v7    # "c":I
    :goto_4
    :pswitch_a
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parsePName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    .line 1759
    .local v1, "n":Lcom/fasterxml/aalto/in/PName;
    if-nez v1, :cond_1e

    .line 1760
    return v3

    .line 1762
    :cond_1e
    iput-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_elemAttrName:Lcom/fasterxml/aalto/in/PName;

    .line 1763
    iput v8, v0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1765
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

    .line 1605
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parseNewName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    .line 1606
    .local v0, "elemName":Lcom/fasterxml/aalto/in/PName;
    const/4 v1, 0x1

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    .line 1607
    if-nez v0, :cond_0

    .line 1608
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1609
    const/16 v1, 0x101

    return v1

    .line 1611
    :cond_0
    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->initStartElement(Lcom/fasterxml/aalto/in/PName;)V

    .line 1612
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleStartElement()I

    move-result v1

    return v1
.end method

.method public final needMoreInput()Z
    .locals 2

    .line 948
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    iget-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_endOfInput:Z

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

    .line 986
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    const/4 v1, 0x2

    const/4 v2, 0x0

    const/4 v3, 0x1

    const/16 v4, 0x101

    if-eq v0, v4, :cond_4

    .line 990
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    if-ne v0, v3, :cond_0

    .line 991
    iget-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_isEmptyTag:Z

    if-eqz v0, :cond_1

    .line 992
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_depth:I

    sub-int/2addr v0, v3

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_depth:I

    .line 994
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    return v1

    .line 996
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    if-ne v0, v1, :cond_1

    .line 997
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currElem:Lcom/fasterxml/aalto/in/ElementScope;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ElementScope;->getParent()Lcom/fasterxml/aalto/in/ElementScope;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currElem:Lcom/fasterxml/aalto/in/ElementScope;

    .line 999
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->getLevel()I

    move-result v0

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_depth:I

    if-lt v0, v5, :cond_1

    .line 1000
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->unbind()Lcom/fasterxml/aalto/in/NsDeclaration;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    goto :goto_0

    .line 1005
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->setStartLocation()V

    .line 1012
    iget-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenIncomplete:Z

    if-eqz v0, :cond_3

    .line 1013
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->skipCharacters()Z

    move-result v0

    if-nez v0, :cond_2

    .line 1014
    return v4

    .line 1016
    :cond_2
    iput-boolean v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenIncomplete:Z

    .line 1018
    :cond_3
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    .line 1019
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1023
    :cond_4
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    if-ne v0, v4, :cond_16

    .line 1024
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    if-nez v0, :cond_9

    .line 1028
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    const/4 v4, 0x4

    if-eqz v0, :cond_5

    .line 1029
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    .line 1030
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->startCharactersPending()I

    move-result v0

    return v0

    .line 1032
    :cond_5
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v5, :cond_6

    .line 1033
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    return v0

    .line 1035
    :cond_6
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 1036
    .local v0, "b":B
    const/16 v5, 0x3c

    if-ne v0, v5, :cond_7

    .line 1037
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    goto :goto_1

    .line 1038
    :cond_7
    const/16 v5, 0x26

    if-ne v0, v5, :cond_8

    .line 1039
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    goto :goto_1

    .line 1041
    :cond_8
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    .line 1042
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->startCharacters(B)I

    move-result v1

    return v1

    .line 1046
    .end local v0    # "b":B
    :cond_9
    :goto_1
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v4, :cond_a

    .line 1047
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    return v0

    .line 1049
    :cond_a
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    const/4 v4, 0x5

    const/4 v5, 0x3

    if-ne v0, v3, :cond_e

    .line 1051
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 1052
    .restart local v0    # "b":B
    const/16 v1, 0x21

    if-ne v0, v1, :cond_b

    .line 1053
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1064
    .end local v0    # "b":B
    goto :goto_2

    .line 1054
    .restart local v0    # "b":B
    :cond_b
    const/16 v1, 0x3f

    if-ne v0, v1, :cond_c

    .line 1055
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    .line 1056
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 1057
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handlePI()I

    move-result v1

    return v1

    .line 1058
    :cond_c
    const/16 v1, 0x2f

    if-ne v0, v1, :cond_d

    .line 1059
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleEndElementStart()I

    move-result v1

    return v1

    .line 1062
    :cond_d
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleStartElementStart(B)I

    move-result v1

    return v1

    .line 1064
    .end local v0    # "b":B
    :cond_e
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    if-ne v0, v1, :cond_f

    .line 1065
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleEntityStartingToken()I

    move-result v0

    return v0

    .line 1066
    :cond_f
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    const/4 v1, 0x6

    if-ne v0, v1, :cond_10

    .line 1067
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleNamedEntityStartingToken()I

    move-result v0

    return v0

    .line 1068
    :cond_10
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    if-ne v0, v4, :cond_11

    .line 1069
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleNumericEntityStartingToken()I

    move-result v0

    return v0

    .line 1072
    :cond_11
    :goto_2
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    if-ne v0, v5, :cond_15

    .line 1073
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v0, v1, :cond_12

    .line 1074
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    return v0

    .line 1076
    :cond_12
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 1078
    .restart local v0    # "b":B
    const/16 v1, 0x2d

    if-ne v0, v1, :cond_13

    .line 1079
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    .line 1080
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    goto :goto_3

    .line 1081
    :cond_13
    const/16 v1, 0x5b

    if-ne v0, v1, :cond_14

    .line 1082
    const/16 v1, 0xc

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    .line 1083
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    goto :goto_3

    .line 1085
    :cond_14
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeCharForError(B)I

    move-result v1

    const-string v2, " (expected either \'-\' for COMMENT or \'[CDATA[\' for CDATA section)"

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 1087
    .end local v0    # "b":B
    :goto_3
    goto :goto_4

    .line 1088
    :cond_15
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInternal()I

    .line 1095
    :cond_16
    :goto_4
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    sparse-switch v0, :sswitch_data_0

    goto :goto_5

    .line 1105
    :sswitch_0
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleCData()I

    move-result v0

    return v0

    .line 1103
    :sswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleComment()I

    move-result v0

    return v0

    .line 1107
    :sswitch_2
    iget-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_cfgLazyParsing:Z

    if-nez v0, :cond_17

    .line 1109
    iget-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_cfgCoalescing:Z

    if-eqz v0, :cond_17

    .line 1110
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->finishCharactersCoalescing()I

    move-result v0

    return v0

    .line 1113
    :cond_17
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    if-eqz v0, :cond_18

    .line 1114
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->startCharactersPending()I

    move-result v0

    return v0

    .line 1117
    :cond_18
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInternal()I

    goto :goto_5

    .line 1101
    :sswitch_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handlePI()I

    move-result v0

    return v0

    .line 1099
    :sswitch_4
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleEndElement()I

    move-result v0

    return v0

    .line 1097
    :sswitch_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleStartElement()I

    move-result v0

    return v0

    .line 1120
    :goto_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInternal()I

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

    .line 617
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    if-eqz v0, :cond_0

    .line 618
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleCDataPending()I

    move-result v0

    .line 620
    .local v0, "result":I
    if-eqz v0, :cond_0

    .line 621
    return v0

    .line 625
    .end local v0    # "result":I
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v0

    .line 626
    .local v0, "outputBuffer":[C
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->getCurrentLength()I

    move-result v1

    .line 628
    .local v1, "outPtr":I
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v2, v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 629
    .local v2, "TYPES":[I
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    .line 637
    .local v3, "inputBuffer":Ljava/nio/ByteBuffer;
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    const/16 v6, 0x101

    if-lt v4, v5, :cond_1

    .line 638
    goto/16 :goto_4

    .line 640
    :cond_1
    array-length v4, v0

    if-lt v1, v4, :cond_2

    .line 641
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v0

    .line 642
    const/4 v1, 0x0

    .line 644
    :cond_2
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    .line 646
    .local v4, "max":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    array-length v7, v0

    sub-int/2addr v7, v1

    add-int/2addr v5, v7

    .line 647
    .local v5, "max2":I
    if-ge v5, v4, :cond_3

    .line 648
    move v4, v5

    .line 651
    .end local v5    # "max2":I
    :cond_3
    :goto_1
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-ge v5, v4, :cond_14

    .line 652
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v5, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v3, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 653
    .local v5, "c":I
    aget v7, v2, v5

    if-eqz v7, :cond_13

    .line 654
    nop

    .line 660
    .end local v4    # "max":I
    aget v4, v2, v5

    packed-switch v4, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_5

    .line 698
    :pswitch_1
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v4, v7

    const/4 v7, 0x3

    if-ge v4, v7, :cond_5

    .line 699
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v4, v7, :cond_4

    .line 700
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 701
    .local v4, "d":I
    shl-int/lit8 v7, v4, 0x8

    or-int/2addr v5, v7

    .line 702
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v7, v8, :cond_4

    .line 703
    iget-object v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v7, v8}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v7

    and-int/lit16 v4, v7, 0xff

    .line 704
    shl-int/lit8 v7, v4, 0x10

    or-int/2addr v5, v7

    .line 707
    .end local v4    # "d":I
    :cond_4
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 708
    goto/16 :goto_4

    .line 710
    :cond_5
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_4(I)I

    move-result v4

    .line 712
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

    .line 713
    array-length v1, v0

    if-lt v5, v1, :cond_6

    .line 714
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v0

    .line 715
    const/4 v1, 0x0

    .end local v5    # "outPtr":I
    .restart local v1    # "outPtr":I
    goto :goto_2

    .line 713
    .end local v1    # "outPtr":I
    .restart local v5    # "outPtr":I
    :cond_6
    move v1, v5

    .line 717
    .end local v5    # "outPtr":I
    .restart local v1    # "outPtr":I
    :goto_2
    and-int/lit16 v5, v4, 0x3ff

    const v6, 0xdc00

    or-int/2addr v5, v6

    .line 719
    .end local v4    # "c":I
    .local v5, "c":I
    goto/16 :goto_5

    .line 687
    :pswitch_2
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v4, v7

    const/4 v7, 0x2

    if-ge v4, v7, :cond_8

    .line 688
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v4, v7, :cond_7

    .line 689
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 690
    .local v4, "d":I
    shl-int/lit8 v7, v4, 0x8

    or-int/2addr v5, v7

    .line 692
    .end local v4    # "d":I
    :cond_7
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 693
    goto/16 :goto_4

    .line 695
    :cond_8
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_3(I)I

    move-result v5

    .line 696
    goto/16 :goto_5

    .line 680
    :pswitch_3
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v7, :cond_9

    .line 681
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 682
    goto/16 :goto_4

    .line 684
    :cond_9
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_2(I)I

    move-result v5

    .line 685
    goto/16 :goto_5

    .line 721
    :pswitch_4
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInvalidInitial(I)V

    .line 723
    :pswitch_5
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v7, :cond_a

    .line 724
    const/16 v4, -0x1e

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 725
    goto/16 :goto_4

    .line 728
    :cond_a
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    const/16 v7, 0x5d

    if-ne v4, v7, :cond_12

    .line 729
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 731
    :goto_3
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v8, :cond_b

    .line 732
    const/16 v4, -0x1f

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 733
    goto :goto_4

    .line 735
    :cond_b
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v8}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    const/16 v8, 0x3e

    if-ne v4, v8, :cond_c

    .line 736
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 737
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 738
    const/4 v4, 0x0

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 739
    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    .line 740
    const/16 v4, 0xc

    return v4

    .line 742
    :cond_c
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v8}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    if-eq v4, v7, :cond_e

    .line 743
    add-int/lit8 v4, v1, 0x1

    .end local v1    # "outPtr":I
    .local v4, "outPtr":I
    aput-char v7, v0, v1

    .line 744
    array-length v1, v0

    if-lt v4, v1, :cond_d

    .line 745
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v0

    .line 746
    const/4 v4, 0x0

    .line 748
    :cond_d
    add-int/lit8 v1, v4, 0x1

    .end local v4    # "outPtr":I
    .restart local v1    # "outPtr":I
    aput-char v7, v0, v4

    .line 749
    goto/16 :goto_0

    .line 752
    :cond_e
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 753
    add-int/lit8 v4, v1, 0x1

    .end local v1    # "outPtr":I
    .restart local v4    # "outPtr":I
    aput-char v7, v0, v1

    .line 754
    array-length v1, v0

    if-lt v4, v1, :cond_f

    .line 755
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v0

    .line 756
    const/4 v1, 0x0

    .end local v4    # "outPtr":I
    .restart local v1    # "outPtr":I
    goto :goto_3

    .line 754
    .end local v1    # "outPtr":I
    .restart local v4    # "outPtr":I
    :cond_f
    move v1, v4

    goto :goto_3

    .line 677
    .end local v4    # "outPtr":I
    .restart local v1    # "outPtr":I
    :pswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    .line 678
    goto :goto_5

    .line 662
    :pswitch_7
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleInvalidXmlChar(I)C

    move-result v5

    .line 665
    :pswitch_8
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v7, :cond_10

    .line 666
    const/4 v4, -0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 667
    nop

    .line 769
    .end local v5    # "c":I
    :goto_4
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 770
    return v6

    .line 669
    .restart local v5    # "c":I
    :cond_10
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    const/16 v6, 0xa

    if-ne v4, v6, :cond_11

    .line 670
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 672
    :cond_11
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    .line 674
    const/16 v5, 0xa

    .line 675
    nop

    .line 766
    :cond_12
    :goto_5
    add-int/lit8 v4, v1, 0x1

    .end local v1    # "outPtr":I
    .restart local v4    # "outPtr":I
    int-to-char v6, v5

    aput-char v6, v0, v1

    .line 767
    .end local v5    # "c":I
    move v1, v4

    goto/16 :goto_0

    .line 656
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

    .line 658
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

    .line 105
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    if-eqz v0, :cond_0

    .line 106
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleCommentPending()I

    move-result v0

    .line 108
    .local v0, "result":I
    if-eqz v0, :cond_0

    .line 109
    return v0

    .line 114
    .end local v0    # "result":I
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v0

    .line 115
    .local v0, "outputBuffer":[C
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->getCurrentLength()I

    move-result v1

    .line 117
    .local v1, "outPtr":I
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v2, v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 118
    .local v2, "TYPES":[I
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    .line 126
    .local v3, "inputBuffer":Ljava/nio/ByteBuffer;
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    const/16 v6, 0x101

    if-lt v4, v5, :cond_1

    .line 127
    goto/16 :goto_3

    .line 129
    :cond_1
    array-length v4, v0

    if-lt v1, v4, :cond_2

    .line 130
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v0

    .line 131
    const/4 v1, 0x0

    .line 133
    :cond_2
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    .line 135
    .local v4, "max":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    array-length v7, v0

    sub-int/2addr v7, v1

    add-int/2addr v5, v7

    .line 136
    .local v5, "max2":I
    if-ge v5, v4, :cond_3

    .line 137
    move v4, v5

    .line 140
    .end local v5    # "max2":I
    :cond_3
    :goto_1
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-ge v5, v4, :cond_11

    .line 141
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v5, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v3, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 142
    .local v5, "c":I
    aget v7, v2, v5

    if-eqz v7, :cond_10

    .line 143
    nop

    .line 149
    .end local v4    # "max":I
    aget v4, v2, v5

    packed-switch v4, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_4

    .line 187
    :pswitch_1
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v4, v7

    const/4 v7, 0x3

    if-ge v4, v7, :cond_5

    .line 188
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v4, v7, :cond_4

    .line 189
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 190
    .local v4, "d":I
    shl-int/lit8 v7, v4, 0x8

    or-int/2addr v5, v7

    .line 191
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v7, v8, :cond_4

    .line 192
    iget-object v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v7, v8}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v7

    and-int/lit16 v4, v7, 0xff

    .line 193
    shl-int/lit8 v7, v4, 0x10

    or-int/2addr v5, v7

    .line 196
    .end local v4    # "d":I
    :cond_4
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 197
    goto/16 :goto_3

    .line 199
    :cond_5
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_4(I)I

    move-result v4

    .line 201
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

    .line 202
    array-length v1, v0

    if-lt v5, v1, :cond_6

    .line 203
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v0

    .line 204
    const/4 v1, 0x0

    .end local v5    # "outPtr":I
    .restart local v1    # "outPtr":I
    goto :goto_2

    .line 202
    .end local v1    # "outPtr":I
    .restart local v5    # "outPtr":I
    :cond_6
    move v1, v5

    .line 206
    .end local v5    # "outPtr":I
    .restart local v1    # "outPtr":I
    :goto_2
    and-int/lit16 v5, v4, 0x3ff

    const v6, 0xdc00

    or-int/2addr v5, v6

    .line 208
    .end local v4    # "c":I
    .local v5, "c":I
    goto/16 :goto_4

    .line 176
    :pswitch_2
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v4, v7

    const/4 v7, 0x2

    if-ge v4, v7, :cond_8

    .line 177
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v4, v7, :cond_7

    .line 178
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 179
    .local v4, "d":I
    shl-int/lit8 v7, v4, 0x8

    or-int/2addr v5, v7

    .line 181
    .end local v4    # "d":I
    :cond_7
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 182
    goto/16 :goto_3

    .line 184
    :cond_8
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_3(I)I

    move-result v5

    .line 185
    goto/16 :goto_4

    .line 169
    :pswitch_3
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v7, :cond_9

    .line 170
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 171
    goto :goto_3

    .line 173
    :cond_9
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_2(I)I

    move-result v5

    .line 174
    goto/16 :goto_4

    .line 210
    :pswitch_4
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInvalidInitial(I)V

    .line 212
    :pswitch_5
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v7, :cond_a

    .line 213
    const/16 v4, -0x14

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 214
    goto :goto_3

    .line 216
    :cond_a
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    const/16 v7, 0x2d

    if-ne v4, v7, :cond_f

    .line 217
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 218
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v7, :cond_b

    .line 219
    const/16 v4, -0x15

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 220
    goto :goto_3

    .line 222
    :cond_b
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    const/16 v7, 0x3e

    if-eq v4, v7, :cond_c

    .line 223
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportDoubleHyphenInComments()V

    .line 225
    :cond_c
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 226
    const/4 v4, 0x0

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 227
    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    .line 228
    const/4 v4, 0x5

    return v4

    .line 166
    :pswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    .line 167
    goto :goto_4

    .line 151
    :pswitch_7
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleInvalidXmlChar(I)C

    move-result v5

    .line 154
    :pswitch_8
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v7, :cond_d

    .line 155
    const/4 v4, -0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 156
    nop

    .line 239
    .end local v5    # "c":I
    :goto_3
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 240
    return v6

    .line 158
    .restart local v5    # "c":I
    :cond_d
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    const/16 v6, 0xa

    if-ne v4, v6, :cond_e

    .line 159
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 161
    :cond_e
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    .line 163
    const/16 v5, 0xa

    .line 164
    nop

    .line 236
    :cond_f
    :goto_4
    add-int/lit8 v4, v1, 0x1

    .end local v1    # "outPtr":I
    .local v4, "outPtr":I
    int-to-char v6, v5

    aput-char v6, v0, v1

    .line 237
    .end local v5    # "c":I
    move v1, v4

    goto/16 :goto_0

    .line 145
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

    .line 147
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

    .line 3822
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuad:I

    .line 3827
    .local v0, "q":I
    :goto_0
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuadBytes:I

    const/16 v2, 0x2f

    const/16 v3, 0x3a

    const/16 v4, 0x2d

    const/4 v5, 0x0

    const/16 v6, 0x41

    const/4 v7, 0x0

    const/4 v8, 0x1

    packed-switch v1, :pswitch_data_0

    goto/16 :goto_1

    .line 3829
    :pswitch_0
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v1, v9, :cond_0

    .line 3830
    return-object v5

    .line 3832
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v10, v9, 0x1

    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v0, v1, 0xff

    .line 3839
    if-ge v0, v6, :cond_4

    .line 3841
    if-lt v0, v4, :cond_1

    if-gt v0, v3, :cond_1

    if-ne v0, v2, :cond_4

    .line 3843
    :cond_1
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadCount:I

    if-ne v1, v8, :cond_3

    .line 3844
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadBuffer:[I

    aget v0, v1, v7

    .line 3845
    sget v1, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_APOS_QUAD:I

    if-ne v0, v1, :cond_2

    .line 3846
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v1, v8

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 3847
    sget-object v1, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_APOS:Lcom/fasterxml/aalto/in/PNameC;

    return-object v1

    .line 3849
    :cond_2
    sget v1, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_QUOT_QUAD:I

    if-ne v0, v1, :cond_3

    .line 3850
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v1, v8

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 3851
    sget-object v1, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_QUOT:Lcom/fasterxml/aalto/in/PNameC;

    return-object v1

    .line 3855
    :cond_3
    invoke-virtual {p0, v0, v7}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1

    .line 3861
    :cond_4
    :pswitch_1
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v1, v9, :cond_5

    .line 3862
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuad:I

    .line 3863
    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuadBytes:I

    .line 3864
    return-object v5

    .line 3866
    :cond_5
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v10, v9, 0x1

    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 3867
    .local v1, "i":I
    if-ge v1, v6, :cond_7

    .line 3868
    if-lt v1, v4, :cond_6

    if-gt v1, v3, :cond_6

    if-ne v1, v2, :cond_7

    .line 3869
    :cond_6
    invoke-virtual {p0, v0, v8}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    return-object v2

    .line 3872
    :cond_7
    shl-int/lit8 v9, v0, 0x8

    or-int v0, v9, v1

    .line 3876
    .end local v1    # "i":I
    :pswitch_2
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    const/4 v10, 0x2

    if-lt v1, v9, :cond_8

    .line 3877
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuad:I

    .line 3878
    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuadBytes:I

    .line 3879
    return-object v5

    .line 3881
    :cond_8
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v11, v9, 0x1

    iput v11, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 3882
    .restart local v1    # "i":I
    if-ge v1, v6, :cond_c

    .line 3883
    if-lt v1, v4, :cond_9

    if-gt v1, v3, :cond_9

    if-ne v1, v2, :cond_c

    .line 3885
    :cond_9
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadCount:I

    if-nez v2, :cond_b

    .line 3886
    sget v2, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_GT_QUAD:I

    if-ne v0, v2, :cond_a

    .line 3887
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v2, v8

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 3888
    sget-object v2, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_GT:Lcom/fasterxml/aalto/in/PNameC;

    return-object v2

    .line 3890
    :cond_a
    sget v2, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_LT_QUAD:I

    if-ne v0, v2, :cond_b

    .line 3891
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v2, v8

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 3892
    sget-object v2, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_LT:Lcom/fasterxml/aalto/in/PNameC;

    return-object v2

    .line 3895
    :cond_b
    invoke-virtual {p0, v0, v10}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    return-object v2

    .line 3898
    :cond_c
    shl-int/lit8 v9, v0, 0x8

    or-int v0, v9, v1

    .line 3902
    .end local v1    # "i":I
    :pswitch_3
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    const/4 v10, 0x3

    if-lt v1, v9, :cond_d

    .line 3903
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuad:I

    .line 3904
    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuadBytes:I

    .line 3905
    return-object v5

    .line 3907
    :cond_d
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v9, v5, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 3908
    .restart local v1    # "i":I
    if-ge v1, v6, :cond_10

    .line 3909
    if-lt v1, v4, :cond_e

    if-gt v1, v3, :cond_e

    if-ne v1, v2, :cond_10

    .line 3911
    :cond_e
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadCount:I

    if-nez v2, :cond_f

    .line 3912
    sget v2, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_AMP_QUAD:I

    if-ne v0, v2, :cond_f

    .line 3913
    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v2, v8

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 3914
    sget-object v2, Lcom/fasterxml/aalto/in/EntityNames;->ENTITY_AMP:Lcom/fasterxml/aalto/in/PNameC;

    return-object v2

    .line 3917
    :cond_f
    invoke-virtual {p0, v0, v10}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    return-object v2

    .line 3920
    :cond_10
    shl-int/lit8 v2, v0, 0x8

    or-int v0, v2, v1

    .line 3926
    .end local v1    # "i":I
    :goto_1
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadCount:I

    if-nez v1, :cond_11

    .line 3927
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadBuffer:[I

    aput v0, v1, v7

    .line 3928
    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadCount:I

    goto :goto_2

    .line 3930
    :cond_11
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadCount:I

    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadBuffer:[I

    array-length v2, v2

    if-lt v1, v2, :cond_12

    .line 3931
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadBuffer:[I

    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadBuffer:[I

    array-length v2, v2

    invoke-static {v1, v2}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([II)[I

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadBuffer:[I

    .line 3933
    :cond_12
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadBuffer:[I

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadCount:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadCount:I

    aput v0, v1, v2

    .line 3935
    :goto_2
    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuadBytes:I

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

    .line 3810
    and-int/lit16 v0, p1, 0xff

    .line 3811
    .local v0, "q":I
    const/16 v1, 0x41

    if-ge v0, v1, :cond_0

    .line 3812
    const-string v1, "; expected a name start character"

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 3814
    :cond_0
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadCount:I

    .line 3815
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuad:I

    .line 3816
    const/4 v1, 0x1

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuadBytes:I

    .line 3817
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parseEntityName()Lcom/fasterxml/aalto/in/PName;

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

    .line 3694
    and-int/lit16 v0, p1, 0xff

    .line 3699
    .local v0, "q":I
    const/16 v1, 0x41

    if-ge v0, v1, :cond_0

    .line 3700
    const-string v1, "; expected a name start character"

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 3702
    :cond_0
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadCount:I

    .line 3703
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuad:I

    .line 3704
    const/4 v1, 0x1

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuadBytes:I

    .line 3705
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->parsePName()Lcom/fasterxml/aalto/in/PName;

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

    .line 291
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    if-eqz v0, :cond_0

    .line 292
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handlePIPending()I

    move-result v0

    .line 294
    .local v0, "result":I
    if-eqz v0, :cond_0

    .line 295
    return v0

    .line 300
    .end local v0    # "result":I
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v0

    .line 301
    .local v0, "outputBuffer":[C
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->getCurrentLength()I

    move-result v1

    .line 303
    .local v1, "outPtr":I
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v2, v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 304
    .local v2, "TYPES":[I
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    .line 312
    .local v3, "inputBuffer":Ljava/nio/ByteBuffer;
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    const/16 v6, 0x101

    if-lt v4, v5, :cond_1

    .line 313
    goto/16 :goto_3

    .line 315
    :cond_1
    array-length v4, v0

    if-lt v1, v4, :cond_2

    .line 316
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v0

    .line 317
    const/4 v1, 0x0

    .line 319
    :cond_2
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    .line 321
    .local v4, "max":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    array-length v7, v0

    sub-int/2addr v7, v1

    add-int/2addr v5, v7

    .line 322
    .local v5, "max2":I
    if-ge v5, v4, :cond_3

    .line 323
    move v4, v5

    .line 326
    .end local v5    # "max2":I
    :cond_3
    :goto_1
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-ge v5, v4, :cond_f

    .line 327
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v5, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v3, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 328
    .local v5, "c":I
    aget v7, v2, v5

    if-eqz v7, :cond_e

    .line 329
    nop

    .line 335
    .end local v4    # "max":I
    aget v4, v2, v5

    const/4 v7, 0x3

    packed-switch v4, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_4

    .line 373
    :pswitch_1
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v4, v8

    if-ge v4, v7, :cond_5

    .line 374
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v4, v7, :cond_4

    .line 375
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 376
    .local v4, "d":I
    shl-int/lit8 v7, v4, 0x8

    or-int/2addr v5, v7

    .line 377
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v7, v8, :cond_4

    .line 378
    iget-object v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v7, v8}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v7

    and-int/lit16 v4, v7, 0xff

    .line 379
    shl-int/lit8 v7, v4, 0x10

    or-int/2addr v5, v7

    .line 382
    .end local v4    # "d":I
    :cond_4
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 383
    goto/16 :goto_3

    .line 385
    :cond_5
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_4(I)I

    move-result v4

    .line 387
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

    .line 388
    array-length v1, v0

    if-lt v5, v1, :cond_6

    .line 389
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v0

    .line 390
    const/4 v1, 0x0

    .end local v5    # "outPtr":I
    .restart local v1    # "outPtr":I
    goto :goto_2

    .line 388
    .end local v1    # "outPtr":I
    .restart local v5    # "outPtr":I
    :cond_6
    move v1, v5

    .line 392
    .end local v5    # "outPtr":I
    .restart local v1    # "outPtr":I
    :goto_2
    and-int/lit16 v5, v4, 0x3ff

    const v6, 0xdc00

    or-int/2addr v5, v6

    .line 394
    .end local v4    # "c":I
    .local v5, "c":I
    goto/16 :goto_4

    .line 362
    :pswitch_2
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v4, v7

    const/4 v7, 0x2

    if-ge v4, v7, :cond_8

    .line 363
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v4, v7, :cond_7

    .line 364
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 365
    .local v4, "d":I
    shl-int/lit8 v7, v4, 0x8

    or-int/2addr v5, v7

    .line 367
    .end local v4    # "d":I
    :cond_7
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 368
    goto :goto_3

    .line 370
    :cond_8
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_3(I)I

    move-result v5

    .line 371
    goto :goto_4

    .line 355
    :pswitch_3
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v7, :cond_9

    .line 356
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 357
    goto :goto_3

    .line 359
    :cond_9
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_2(I)I

    move-result v5

    .line 360
    goto :goto_4

    .line 396
    :pswitch_4
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInvalidInitial(I)V

    .line 399
    :pswitch_5
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v8, :cond_a

    .line 400
    const/16 v4, -0xf

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 401
    goto :goto_3

    .line 403
    :cond_a
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v8}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    const/16 v8, 0x3e

    if-ne v4, v8, :cond_d

    .line 404
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 405
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 406
    const/4 v4, 0x0

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    .line 407
    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    .line 408
    return v7

    .line 352
    :pswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    .line 353
    goto :goto_4

    .line 337
    :pswitch_7
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleInvalidXmlChar(I)C

    move-result v5

    .line 340
    :pswitch_8
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v7, :cond_b

    .line 341
    const/4 v4, -0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 342
    nop

    .line 419
    .end local v5    # "c":I
    :goto_3
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 420
    return v6

    .line 344
    .restart local v5    # "c":I
    :cond_b
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    const/16 v6, 0xa

    if-ne v4, v6, :cond_c

    .line 345
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 347
    :cond_c
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    .line 349
    const/16 v5, 0xa

    .line 350
    nop

    .line 417
    :cond_d
    :goto_4
    add-int/lit8 v4, v1, 0x1

    .end local v1    # "outPtr":I
    .local v4, "outPtr":I
    int-to-char v6, v5

    aput-char v6, v0, v1

    .line 418
    .end local v5    # "c":I
    move v1, v4

    goto/16 :goto_0

    .line 331
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

    .line 333
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

    .line 3723
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuad:I

    .line 3728
    .local v0, "q":I
    :goto_0
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuadBytes:I

    const/4 v2, 0x0

    const/16 v3, 0x2f

    const/16 v4, 0x3a

    const/16 v5, 0x2d

    const/4 v6, 0x0

    const/16 v7, 0x41

    const/4 v8, 0x1

    packed-switch v1, :pswitch_data_0

    goto/16 :goto_1

    .line 3730
    :pswitch_0
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v1, v9, :cond_0

    .line 3731
    return-object v6

    .line 3733
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v10, v9, 0x1

    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v0, v1, 0xff

    .line 3740
    if-ge v0, v7, :cond_2

    .line 3742
    if-lt v0, v5, :cond_1

    if-gt v0, v4, :cond_1

    if-ne v0, v3, :cond_2

    .line 3744
    :cond_1
    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1

    .line 3750
    :cond_2
    :pswitch_1
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v1, v9, :cond_3

    .line 3751
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuad:I

    .line 3752
    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuadBytes:I

    .line 3753
    return-object v6

    .line 3755
    :cond_3
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v10, v9, 0x1

    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 3756
    .local v1, "i":I
    if-ge v1, v7, :cond_5

    .line 3757
    if-lt v1, v5, :cond_4

    if-gt v1, v4, :cond_4

    if-ne v1, v3, :cond_5

    .line 3758
    :cond_4
    invoke-virtual {p0, v0, v8}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    return-object v2

    .line 3761
    :cond_5
    shl-int/lit8 v9, v0, 0x8

    or-int v0, v9, v1

    .line 3765
    .end local v1    # "i":I
    :pswitch_2
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    const/4 v10, 0x2

    if-lt v1, v9, :cond_6

    .line 3766
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuad:I

    .line 3767
    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuadBytes:I

    .line 3768
    return-object v6

    .line 3770
    :cond_6
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v11, v9, 0x1

    iput v11, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v9}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 3771
    .restart local v1    # "i":I
    if-ge v1, v7, :cond_8

    .line 3772
    if-lt v1, v5, :cond_7

    if-gt v1, v4, :cond_7

    if-ne v1, v3, :cond_8

    .line 3773
    :cond_7
    invoke-virtual {p0, v0, v10}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    return-object v2

    .line 3776
    :cond_8
    shl-int/lit8 v9, v0, 0x8

    or-int v0, v9, v1

    .line 3780
    .end local v1    # "i":I
    :pswitch_3
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    const/4 v10, 0x3

    if-lt v1, v9, :cond_9

    .line 3781
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuad:I

    .line 3782
    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuadBytes:I

    .line 3783
    return-object v6

    .line 3785
    :cond_9
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v9, v6, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 3786
    .restart local v1    # "i":I
    if-ge v1, v7, :cond_b

    .line 3787
    if-lt v1, v5, :cond_a

    if-gt v1, v4, :cond_a

    if-ne v1, v3, :cond_b

    .line 3788
    :cond_a
    invoke-virtual {p0, v0, v10}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    return-object v2

    .line 3791
    :cond_b
    shl-int/lit8 v3, v0, 0x8

    or-int v0, v3, v1

    .line 3795
    .end local v1    # "i":I
    :goto_1
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadCount:I

    if-nez v1, :cond_c

    .line 3796
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadBuffer:[I

    aput v0, v1, v2

    .line 3797
    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadCount:I

    goto :goto_2

    .line 3799
    :cond_c
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadCount:I

    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadBuffer:[I

    array-length v3, v3

    if-lt v1, v3, :cond_d

    .line 3800
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadBuffer:[I

    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadBuffer:[I

    array-length v3, v3

    invoke-static {v1, v3}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([II)[I

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadBuffer:[I

    .line 3802
    :cond_d
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadBuffer:[I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadCount:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_quadCount:I

    aput v0, v1, v3

    .line 3804
    :goto_2
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currQuadBytes:I

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

    .line 2578
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 2579
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->skipPending()Z

    move-result v0

    if-nez v0, :cond_0

    .line 2580
    return v1

    .line 2584
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    .line 2585
    .local v0, "TYPES":[I
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    .line 2593
    .local v2, "inputBuffer":Ljava/nio/ByteBuffer;
    :goto_0
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2594
    .local v3, "ptr":I
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    .line 2595
    .local v4, "max":I
    if-lt v3, v4, :cond_1

    .line 2596
    goto/16 :goto_4

    .line 2598
    :cond_1
    :goto_1
    if-ge v3, v4, :cond_e

    .line 2599
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "ptr":I
    .local v5, "ptr":I
    invoke-virtual {v2, v3}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v3

    and-int/lit16 v3, v3, 0xff

    .line 2600
    .local v3, "c":I
    aget v6, v0, v3

    if-eqz v6, :cond_d

    .line 2601
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2602
    nop

    .line 2608
    .end local v4    # "max":I
    .end local v5    # "ptr":I
    aget v4, v0, v3

    const/4 v5, 0x1

    packed-switch v4, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_5

    .line 2685
    :pswitch_1
    const/4 v4, 0x1

    .line 2686
    .local v4, "count":I
    const/4 v6, 0x0

    .line 2687
    .local v6, "b":B
    :goto_2
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v8, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-ge v7, v8, :cond_3

    .line 2688
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v2, v7}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v6

    .line 2689
    const/16 v7, 0x5d

    if-eq v6, v7, :cond_2

    .line 2690
    goto :goto_3

    .line 2692
    :cond_2
    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v7, v5

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2693
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 2695
    :cond_3
    :goto_3
    const/16 v7, 0x3e

    if-ne v6, v7, :cond_c

    if-le v4, v5, :cond_c

    .line 2696
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportIllegalCDataEnd()V

    goto/16 :goto_5

    .line 2665
    .end local v4    # "count":I
    .end local v6    # "b":B
    :pswitch_2
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->skipEntityInCharacters()I

    move-result v3

    .line 2666
    if-nez v3, :cond_c

    .line 2667
    const/16 v4, -0x50

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2669
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-ge v4, v6, :cond_4

    .line 2670
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->skipPending()Z

    move-result v4

    if-eqz v4, :cond_4

    .line 2671
    return v5

    .line 2674
    :cond_4
    return v1

    .line 2645
    :pswitch_3
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v4, v5

    const/4 v5, 0x3

    if-ge v4, v5, :cond_6

    .line 2646
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v4, v5, :cond_5

    .line 2647
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 2648
    .local v4, "d":I
    shl-int/lit8 v5, v4, 0x8

    or-int/2addr v3, v5

    .line 2649
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v5, v6, :cond_5

    .line 2650
    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v5, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v5

    and-int/lit16 v4, v5, 0xff

    .line 2651
    shl-int/lit8 v5, v4, 0x10

    or-int/2addr v3, v5

    .line 2654
    .end local v4    # "d":I
    :cond_5
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2655
    goto :goto_4

    .line 2657
    :cond_6
    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_4(I)I

    .line 2658
    goto :goto_5

    .line 2634
    :pswitch_4
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v4, v5

    const/4 v5, 0x2

    if-ge v4, v5, :cond_8

    .line 2635
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v4, v5, :cond_7

    .line 2636
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 2637
    .restart local v4    # "d":I
    shl-int/lit8 v5, v4, 0x8

    or-int/2addr v3, v5

    .line 2639
    .end local v4    # "d":I
    :cond_7
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2640
    goto :goto_4

    .line 2642
    :cond_8
    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_3(I)I

    .line 2643
    goto :goto_5

    .line 2627
    :pswitch_5
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v5, :cond_9

    .line 2628
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2629
    goto :goto_4

    .line 2631
    :cond_9
    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->skipUtf8_2(I)V

    .line 2632
    goto :goto_5

    .line 2660
    :pswitch_6
    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInvalidInitial(I)V

    .line 2662
    :pswitch_7
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v1, v5

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2663
    return v5

    .line 2624
    :pswitch_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    .line 2625
    goto :goto_5

    .line 2610
    :pswitch_9
    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleInvalidXmlChar(I)C

    move-result v3

    .line 2613
    :pswitch_a
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v6, :cond_a

    .line 2614
    const/4 v4, -0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2615
    nop

    .line 2707
    .end local v3    # "c":I
    :goto_4
    return v1

    .line 2617
    .restart local v3    # "c":I
    :cond_a
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v2, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    const/16 v6, 0xa

    if-ne v4, v6, :cond_b

    .line 2618
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v4, v5

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2620
    :cond_b
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    .line 2622
    nop

    .line 2704
    .end local v3    # "c":I
    :cond_c
    :goto_5
    goto/16 :goto_0

    .line 2600
    .restart local v3    # "c":I
    .local v4, "max":I
    .restart local v5    # "ptr":I
    :cond_d
    move v3, v5

    goto/16 :goto_1

    .line 2605
    .end local v5    # "ptr":I
    .local v3, "ptr":I
    :cond_e
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2606
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

    .line 2973
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInternal()I

    .line 2974
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

    .line 3994
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    .line 3995
    .local v0, "d":I
    and-int/lit16 v1, v0, 0xc0

    const/16 v2, 0x80

    if-eq v1, v2, :cond_0

    .line 3996
    and-int/lit16 v1, v0, 0xff

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInvalidOther(II)V

    .line 3998
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

    .line 2065
    and-int/lit16 v0, p1, 0xff

    .line 2066
    .local v0, "c":I
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v1, v1, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    aget v1, v1, v0

    const/16 v2, 0x101

    const/4 v3, 0x1

    packed-switch v1, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_0

    .line 2127
    :pswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInternal()I

    .line 2128
    goto/16 :goto_0

    .line 2105
    :pswitch_2
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v1, v4

    const/4 v4, 0x3

    if-ge v1, v4, :cond_1

    .line 2106
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v1, v3, :cond_0

    .line 2107
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v3}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 2108
    .local v1, "d":I
    shl-int/lit8 v3, v1, 0x8

    or-int/2addr v0, v3

    .line 2109
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v3, v4, :cond_0

    .line 2110
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v3

    and-int/lit16 v1, v3, 0xff

    .line 2111
    shl-int/lit8 v3, v1, 0x10

    or-int/2addr v0, v3

    .line 2114
    .end local v1    # "d":I
    :cond_0
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2115
    return v2

    .line 2117
    :cond_1
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_4(I)I

    move-result v0

    .line 2119
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1, v0}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithSurrogate(I)V

    .line 2120
    goto :goto_1

    .line 2094
    :pswitch_3
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    sub-int/2addr v1, v4

    const/4 v4, 0x2

    if-ge v1, v4, :cond_3

    .line 2095
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    if-le v1, v3, :cond_2

    .line 2096
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v3}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 2097
    .restart local v1    # "d":I
    shl-int/lit8 v3, v1, 0x8

    or-int/2addr v0, v3

    .line 2099
    .end local v1    # "d":I
    :cond_2
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2100
    return v2

    .line 2102
    :cond_3
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_3(I)I

    move-result v0

    .line 2103
    goto :goto_0

    .line 2087
    :pswitch_4
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v1, v4, :cond_4

    .line 2088
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2089
    return v2

    .line 2091
    :cond_4
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_2(I)I

    move-result v0

    .line 2092
    goto :goto_0

    .line 2123
    :pswitch_5
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->reportInvalidInitial(I)V

    .line 2124
    goto :goto_0

    .line 2084
    :pswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    .line 2085
    goto :goto_0

    .line 2068
    :pswitch_7
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->handleInvalidXmlChar(I)C

    move-result v0

    .line 2073
    :pswitch_8
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v1, v4, :cond_5

    .line 2074
    const/4 v1, -0x1

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 2075
    return v2

    .line 2077
    :cond_5
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    const/16 v2, 0xa

    if-ne v1, v2, :cond_6

    .line 2078
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v1, v3

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 2080
    :cond_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    .line 2081
    const/16 v0, 0xa

    .line 2082
    nop

    .line 2136
    :goto_0
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    int-to-char v2, v0

    invoke-virtual {v1, v2}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithChar(C)V

    .line 2139
    .end local v0    # "c":I
    :goto_1
    iget-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_cfgCoalescing:Z

    if-eqz v0, :cond_7

    iget-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_cfgLazyParsing:Z

    if-nez v0, :cond_7

    .line 2141
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->finishCharactersCoalescing()I

    move-result v0

    return v0

    .line 2143
    :cond_7
    const/4 v0, 0x4

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    .line 2144
    iget-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_cfgLazyParsing:Z

    if-eqz v0, :cond_8

    .line 2145
    iput-boolean v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenIncomplete:Z

    goto :goto_2

    .line 2147
    :cond_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->finishCharacters()V

    .line 2149
    :goto_2
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

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

    .line 828
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    const/16 v2, 0x101

    if-lt v0, v1, :cond_0

    .line 829
    return v2

    .line 833
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 834
    .local v0, "c":I
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 837
    const/4 v1, -0x1

    const/4 v3, 0x4

    const/4 v4, 0x1

    if-ne v0, v1, :cond_2

    .line 838
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    const/16 v2, 0xa

    if-ne v1, v2, :cond_1

    .line 839
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/2addr v1, v4

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    .line 841
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->markLF()V

    .line 842
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1, v2}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithChar(C)V

    goto/16 :goto_2

    .line 847
    :cond_2
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v1, v1, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    and-int/lit16 v5, v0, 0xff

    aget v1, v1, v5

    packed-switch v1, :pswitch_data_0

    .line 906
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->throwInternal()I

    goto/16 :goto_2

    .line 872
    :pswitch_0
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v4}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 874
    .local v1, "next":I
    shr-int/lit8 v4, v0, 0x8

    if-nez v4, :cond_5

    .line 875
    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v4, v5, :cond_3

    .line 876
    shl-int/lit8 v3, v1, 0x8

    or-int/2addr v3, v0

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 877
    return v2

    .line 879
    :cond_3
    iget-object v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v4, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v4

    and-int/lit16 v4, v4, 0xff

    .line 880
    .local v4, "c2":I
    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v5, v6, :cond_4

    .line 881
    shl-int/lit8 v3, v1, 0x8

    or-int/2addr v3, v0

    shl-int/lit8 v5, v4, 0x10

    or-int/2addr v3, v5

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 882
    return v2

    .line 884
    :cond_4
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v2, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    and-int/lit16 v2, v2, 0xff

    .line 885
    .local v2, "c3":I
    invoke-virtual {p0, v0, v1, v4, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_4(IIII)I

    move-result v0

    .line 886
    .end local v2    # "c3":I
    .end local v4    # "c2":I
    goto :goto_0

    .line 887
    :cond_5
    shr-int/lit8 v4, v0, 0x8

    and-int/lit16 v4, v4, 0xff

    .line 888
    .restart local v4    # "c2":I
    shr-int/lit8 v5, v0, 0x10

    .line 890
    .local v5, "c3":I
    if-nez v5, :cond_7

    .line 891
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v6, v7, :cond_6

    .line 892
    shl-int/lit8 v3, v1, 0x10

    or-int/2addr v3, v0

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 893
    return v2

    .line 895
    :cond_6
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v2, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    and-int/lit16 v2, v2, 0xff

    .line 896
    .end local v5    # "c3":I
    .restart local v2    # "c3":I
    and-int/lit16 v5, v0, 0xff

    invoke-virtual {p0, v5, v4, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_4(IIII)I

    move-result v0

    goto :goto_0

    .line 898
    .end local v2    # "c3":I
    .restart local v5    # "c3":I
    :cond_7
    and-int/lit16 v2, v0, 0xff

    invoke-virtual {p0, v2, v4, v5, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_4(IIII)I

    move-result v0

    .line 903
    .end local v1    # "next":I
    .end local v4    # "c2":I
    .end local v5    # "c3":I
    :goto_0
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1, v0}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithSurrogate(I)V

    .line 904
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    return v3

    .line 855
    :pswitch_1
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v5, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v1, v5}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 856
    .restart local v1    # "next":I
    shr-int/lit8 v5, v0, 0x8

    .line 857
    .local v5, "c2":I
    if-nez v5, :cond_9

    .line 858
    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputEnd:I

    if-lt v6, v7, :cond_8

    .line 859
    shl-int/lit8 v3, v1, 0x8

    or-int/2addr v3, v0

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_pendingInput:I

    .line 860
    return v2

    .line 862
    :cond_8
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputBuffer:Ljava/nio/ByteBuffer;

    iget v6, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_inputPtr:I

    invoke-virtual {v2, v6}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v2

    and-int/lit16 v2, v2, 0xff

    .line 863
    .restart local v2    # "c3":I
    invoke-virtual {p0, v0, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_3(III)I

    move-result v0

    .line 864
    .end local v2    # "c3":I
    goto :goto_1

    .line 865
    :cond_9
    and-int/lit16 v2, v0, 0xff

    invoke-virtual {p0, v2, v5, v1}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_3(III)I

    move-result v0

    .line 867
    :goto_1
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    int-to-char v6, v0

    invoke-virtual {v2, v6}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithChar(C)V

    .line 869
    .end local v1    # "next":I
    .end local v5    # "c2":I
    goto :goto_2

    .line 850
    :pswitch_2
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->decodeUtf8_2(I)I

    move-result v2

    int-to-char v2, v2

    invoke-virtual {v1, v2}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithChar(C)V

    .line 851
    nop

    .line 911
    :goto_2
    iget-boolean v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_cfgCoalescing:Z

    if-eqz v1, :cond_a

    iget-boolean v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_cfgLazyParsing:Z

    if-nez v1, :cond_a

    .line 913
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->finishCharactersCoalescing()I

    move-result v1

    return v1

    .line 915
    :cond_a
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    .line 916
    iget-boolean v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_cfgLazyParsing:Z

    if-eqz v1, :cond_b

    .line 917
    iput-boolean v4, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_tokenIncomplete:Z

    goto :goto_3

    .line 919
    :cond_b
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->finishCharacters()V

    .line 921
    :goto_3
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

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

    .line 72
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "asyncScanner; curr="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_currToken:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " next="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_nextEvent:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", state = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteBufferScanner;->_state:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
