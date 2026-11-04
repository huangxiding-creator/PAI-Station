.class public final Lcom/fasterxml/aalto/in/Utf8Scanner;
.super Lcom/fasterxml/aalto/in/StreamScanner;
.source "Utf8Scanner.java"


# direct methods
.method public constructor <init>(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/InputStream;[BII)V
    .locals 0
    .param p1, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "buffer"    # [B
    .param p4, "ptr"    # I
    .param p5, "last"    # I

    .line 44
    invoke-direct/range {p0 .. p5}, Lcom/fasterxml/aalto/in/StreamScanner;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/InputStream;[BII)V

    .line 45
    return-void
.end method

.method private final collectValue(IBLcom/fasterxml/aalto/in/PName;)I
    .locals 8
    .param p1, "attrPtr"    # I
    .param p2, "quoteByte"    # B
    .param p3, "attrName"    # Lcom/fasterxml/aalto/in/PName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 291
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v0, p3, p1}, Lcom/fasterxml/aalto/in/AttributeCollector;->startNewValue(Lcom/fasterxml/aalto/in/PName;I)[C

    move-result-object v0

    .line 292
    .local v0, "attrBuffer":[C
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v1, v1, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    .line 293
    .local v1, "TYPES":[I
    move v2, p2

    .line 301
    .local v2, "quoteChar":I
    :goto_0
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 302
    .local v3, "ptr":I
    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v3, v4, :cond_0

    .line 303
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 304
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 306
    :cond_0
    array-length v4, v0

    if-lt p1, v4, :cond_1

    .line 307
    iget-object v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v4}, Lcom/fasterxml/aalto/in/AttributeCollector;->valueBufferFull()[C

    move-result-object v0

    .line 309
    :cond_1
    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    .line 311
    .local v4, "max":I
    array-length v5, v0

    sub-int/2addr v5, p1

    add-int/2addr v5, v3

    .line 312
    .local v5, "max2":I
    if-ge v5, v4, :cond_2

    .line 313
    move v4, v5

    .line 316
    .end local v5    # "max2":I
    :cond_2
    :goto_1
    if-ge v3, v4, :cond_a

    .line 317
    iget-object v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    add-int/lit8 v6, v3, 0x1

    .end local v3    # "ptr":I
    .local v6, "ptr":I
    aget-byte v3, v5, v3

    and-int/lit16 v3, v3, 0xff

    .line 318
    .local v3, "c":I
    aget v5, v1, v3

    if-eqz v5, :cond_9

    .line 319
    iput v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 320
    nop

    .line 327
    .end local v4    # "max":I
    .end local v6    # "ptr":I
    aget v4, v1, v3

    const v5, 0xdc00

    const v6, 0xd800

    packed-switch v4, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_2

    .line 380
    :pswitch_1
    if-ne v3, v2, :cond_8

    .line 381
    nop

    .line 391
    .end local v3    # "c":I
    return p1

    .line 352
    .restart local v3    # "c":I
    :pswitch_2
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_4(I)I

    move-result v3

    .line 354
    add-int/lit8 v4, p1, 0x1

    .end local p1    # "attrPtr":I
    .local v4, "attrPtr":I
    shr-int/lit8 v7, v3, 0xa

    or-int/2addr v6, v7

    int-to-char v6, v6

    aput-char v6, v0, p1

    .line 355
    and-int/lit16 p1, v3, 0x3ff

    or-int v3, p1, v5

    .line 356
    array-length p1, v0

    if-lt v4, p1, :cond_3

    .line 357
    iget-object p1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/AttributeCollector;->valueBufferFull()[C

    move-result-object p1

    move-object v0, p1

    move p1, v4

    .end local v0    # "attrBuffer":[C
    .local p1, "attrBuffer":[C
    goto :goto_2

    .line 356
    .end local p1    # "attrBuffer":[C
    .restart local v0    # "attrBuffer":[C
    :cond_3
    move p1, v4

    goto :goto_2

    .line 349
    .end local v4    # "attrPtr":I
    .local p1, "attrPtr":I
    :pswitch_3
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_3(I)I

    move-result v3

    .line 350
    goto :goto_2

    .line 346
    :pswitch_4
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_2(I)I

    move-result v3

    .line 347
    goto :goto_2

    .line 361
    :pswitch_5
    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidInitial(I)V

    .line 363
    :pswitch_6
    const-string v4, "\'<\' not allowed in attribute value"

    invoke-virtual {p0, v3, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 365
    :pswitch_7
    const/4 v4, 0x0

    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleEntityInText(Z)I

    move-result v3

    .line 366
    if-nez v3, :cond_4

    .line 367
    invoke-virtual {p0, p3, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportUnexpandedEntityInAttr(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 370
    :cond_4
    shr-int/lit8 v4, v3, 0x10

    if-eqz v4, :cond_8

    .line 371
    const/high16 v4, 0x10000

    sub-int/2addr v3, v4

    .line 372
    add-int/lit8 v4, p1, 0x1

    .end local p1    # "attrPtr":I
    .restart local v4    # "attrPtr":I
    shr-int/lit8 v7, v3, 0xa

    or-int/2addr v6, v7

    int-to-char v6, v6

    aput-char v6, v0, p1

    .line 373
    and-int/lit16 p1, v3, 0x3ff

    or-int v3, p1, v5

    .line 374
    array-length p1, v0

    if-lt v4, p1, :cond_5

    .line 375
    iget-object p1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/AttributeCollector;->valueBufferFull()[C

    move-result-object p1

    move-object v0, p1

    move p1, v4

    .end local v0    # "attrBuffer":[C
    .local p1, "attrBuffer":[C
    goto :goto_2

    .line 374
    .end local p1    # "attrBuffer":[C
    .restart local v0    # "attrBuffer":[C
    :cond_5
    move p1, v4

    goto :goto_2

    .line 329
    .end local v4    # "attrPtr":I
    .local p1, "attrPtr":I
    :pswitch_8
    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleInvalidXmlChar(I)C

    move-result v3

    .line 331
    :pswitch_9
    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v4, v5, :cond_6

    .line 332
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 334
    :cond_6
    iget-object v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v4, v4, v5

    const/16 v5, 0xa

    if-ne v4, v5, :cond_7

    .line 335
    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 339
    :cond_7
    :pswitch_a
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 343
    :pswitch_b
    const/16 v3, 0x20

    .line 344
    nop

    .line 388
    :cond_8
    :goto_2
    add-int/lit8 v4, p1, 0x1

    .end local p1    # "attrPtr":I
    .restart local v4    # "attrPtr":I
    int-to-char v5, v3

    aput-char v5, v0, p1

    .line 389
    .end local v3    # "c":I
    move p1, v4

    goto/16 :goto_0

    .line 322
    .restart local v3    # "c":I
    .local v4, "max":I
    .restart local v6    # "ptr":I
    .restart local p1    # "attrPtr":I
    :cond_9
    add-int/lit8 v5, p1, 0x1

    .end local p1    # "attrPtr":I
    .local v5, "attrPtr":I
    int-to-char v7, v3

    aput-char v7, v0, p1

    move p1, v5

    move v3, v6

    goto/16 :goto_1

    .line 324
    .end local v5    # "attrPtr":I
    .end local v6    # "ptr":I
    .local v3, "ptr":I
    .restart local p1    # "attrPtr":I
    :cond_a
    iput v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 325
    .end local v3    # "ptr":I
    .end local v4    # "max":I
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

.method private final decodeMultiByteChar(II)I
    .locals 5
    .param p1, "c"    # I
    .param p2, "ptr"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2515
    and-int/lit16 v0, p1, 0xe0

    const/16 v1, 0xc0

    if-ne v0, v1, :cond_0

    .line 2516
    and-int/lit8 p1, p1, 0x1f

    .line 2517
    const/4 v0, 0x1

    .local v0, "needed":I
    goto :goto_0

    .line 2518
    .end local v0    # "needed":I
    :cond_0
    and-int/lit16 v0, p1, 0xf0

    const/16 v1, 0xe0

    if-ne v0, v1, :cond_1

    .line 2519
    and-int/lit8 p1, p1, 0xf

    .line 2520
    const/4 v0, 0x2

    .restart local v0    # "needed":I
    goto :goto_0

    .line 2521
    .end local v0    # "needed":I
    :cond_1
    and-int/lit16 v0, p1, 0xf8

    const/16 v1, 0xf0

    if-ne v0, v1, :cond_2

    .line 2523
    and-int/lit8 p1, p1, 0x7

    .line 2524
    const/4 v0, 0x3

    .restart local v0    # "needed":I
    goto :goto_0

    .line 2526
    .end local v0    # "needed":I
    :cond_2
    and-int/lit16 v0, p1, 0xff

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidInitial(I)V

    .line 2527
    const/4 v0, 0x1

    .line 2530
    .restart local v0    # "needed":I
    :goto_0
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt p2, v1, :cond_3

    .line 2531
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 2532
    iget p2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2534
    :cond_3
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    add-int/lit8 v2, p2, 0x1

    .end local p2    # "ptr":I
    .local v2, "ptr":I
    aget-byte p2, v1, p2

    .line 2535
    .local p2, "d":I
    and-int/lit16 v1, p2, 0xc0

    const/16 v3, 0x80

    if-eq v1, v3, :cond_4

    .line 2536
    and-int/lit16 v1, p2, 0xff

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 2538
    :cond_4
    shl-int/lit8 v1, p1, 0x6

    and-int/lit8 v4, p2, 0x3f

    or-int p1, v1, v4

    .line 2540
    const/4 v1, 0x1

    if-le v0, v1, :cond_a

    .line 2541
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v2, v1, :cond_5

    .line 2542
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 2543
    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2545
    :cond_5
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    add-int/lit8 v4, v2, 0x1

    .end local v2    # "ptr":I
    .local v4, "ptr":I
    aget-byte p2, v1, v2

    .line 2546
    and-int/lit16 v1, p2, 0xc0

    if-eq v1, v3, :cond_6

    .line 2547
    and-int/lit16 v1, p2, 0xff

    invoke-virtual {p0, v1, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 2549
    :cond_6
    shl-int/lit8 v1, p1, 0x6

    and-int/lit8 v2, p2, 0x3f

    or-int p1, v1, v2

    .line 2550
    const/4 v1, 0x2

    if-le v0, v1, :cond_9

    .line 2551
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v4, v1, :cond_7

    .line 2552
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 2553
    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2555
    :cond_7
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    add-int/lit8 v2, v4, 0x1

    .end local v4    # "ptr":I
    .restart local v2    # "ptr":I
    aget-byte p2, v1, v4

    .line 2556
    and-int/lit16 v1, p2, 0xc0

    if-eq v1, v3, :cond_8

    .line 2557
    and-int/lit16 v1, p2, 0xff

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 2559
    :cond_8
    shl-int/lit8 v1, p1, 0x6

    and-int/lit8 v3, p2, 0x3f

    or-int p1, v1, v3

    .line 2563
    neg-int p1, p1

    goto :goto_1

    .line 2550
    .end local v2    # "ptr":I
    .restart local v4    # "ptr":I
    :cond_9
    move v2, v4

    .line 2566
    .end local v4    # "ptr":I
    .restart local v2    # "ptr":I
    :cond_a
    :goto_1
    iput v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2567
    return p1
.end method

.method private final decodeUtf8_2(I)I
    .locals 3
    .param p1, "c"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2573
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 2574
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 2576
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 2577
    .local v0, "d":I
    and-int/lit16 v1, v0, 0xc0

    const/16 v2, 0x80

    if-eq v1, v2, :cond_1

    .line 2578
    and-int/lit16 v1, v0, 0xff

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 2580
    :cond_1
    and-int/lit8 v1, p1, 0x1f

    shl-int/lit8 v1, v1, 0x6

    and-int/lit8 v2, v0, 0x3f

    or-int/2addr v1, v2

    return v1
.end method

.method private final decodeUtf8_3(I)I
    .locals 6
    .param p1, "c1"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2586
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 2587
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 2589
    :cond_0
    and-int/lit8 p1, p1, 0xf

    .line 2590
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 2591
    .local v0, "d":I
    and-int/lit16 v1, v0, 0xc0

    const/16 v2, 0x80

    if-eq v1, v2, :cond_1

    .line 2592
    and-int/lit16 v1, v0, 0xff

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 2594
    :cond_1
    shl-int/lit8 v1, p1, 0x6

    and-int/lit8 v3, v0, 0x3f

    or-int/2addr v1, v3

    .line 2595
    .local v1, "c":I
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v3, v4, :cond_2

    .line 2596
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 2598
    :cond_2
    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v0, v3, v4

    .line 2599
    and-int/lit16 v3, v0, 0xc0

    if-eq v3, v2, :cond_3

    .line 2600
    and-int/lit16 v2, v0, 0xff

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 2602
    :cond_3
    shl-int/lit8 v2, v1, 0x6

    and-int/lit8 v3, v0, 0x3f

    or-int v1, v2, v3

    .line 2603
    const/16 v2, 0xd

    if-lt p1, v2, :cond_5

    .line 2604
    const v2, 0xd800

    if-lt v1, v2, :cond_5

    .line 2605
    const v2, 0xe000

    if-lt v1, v2, :cond_4

    const v2, 0xfffe

    if-lt v1, v2, :cond_5

    const v2, 0xffff

    if-gt v1, v2, :cond_5

    .line 2606
    :cond_4
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleInvalidXmlChar(I)C

    move-result v1

    .line 2610
    :cond_5
    return v1
.end method

.method private final decodeUtf8_3fast(I)I
    .locals 6
    .param p1, "c1"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2616
    and-int/lit8 p1, p1, 0xf

    .line 2617
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 2618
    .local v0, "d":I
    and-int/lit16 v1, v0, 0xc0

    const/16 v2, 0x80

    if-eq v1, v2, :cond_0

    .line 2619
    and-int/lit16 v1, v0, 0xff

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 2621
    :cond_0
    shl-int/lit8 v1, p1, 0x6

    and-int/lit8 v3, v0, 0x3f

    or-int/2addr v1, v3

    .line 2622
    .local v1, "c":I
    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v0, v3, v4

    .line 2623
    and-int/lit16 v3, v0, 0xc0

    if-eq v3, v2, :cond_1

    .line 2624
    and-int/lit16 v2, v0, 0xff

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 2626
    :cond_1
    shl-int/lit8 v2, v1, 0x6

    and-int/lit8 v3, v0, 0x3f

    or-int v1, v2, v3

    .line 2627
    const/16 v2, 0xd

    if-lt p1, v2, :cond_3

    .line 2628
    const v2, 0xd800

    if-lt v1, v2, :cond_3

    .line 2629
    const v2, 0xe000

    if-lt v1, v2, :cond_2

    const v2, 0xfffe

    if-lt v1, v2, :cond_3

    const v2, 0xffff

    if-gt v1, v2, :cond_3

    .line 2630
    :cond_2
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleInvalidXmlChar(I)C

    move-result v1

    .line 2634
    :cond_3
    return v1
.end method

.method private final decodeUtf8_4(I)I
    .locals 5
    .param p1, "c"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2644
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 2645
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 2647
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 2648
    .local v0, "d":I
    and-int/lit16 v1, v0, 0xc0

    const/16 v2, 0x80

    if-eq v1, v2, :cond_1

    .line 2649
    and-int/lit16 v1, v0, 0xff

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 2651
    :cond_1
    and-int/lit8 v1, p1, 0x7

    shl-int/lit8 v1, v1, 0x6

    and-int/lit8 v3, v0, 0x3f

    or-int p1, v1, v3

    .line 2653
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v1, v3, :cond_2

    .line 2654
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 2656
    :cond_2
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v0, v1, v3

    .line 2657
    and-int/lit16 v1, v0, 0xc0

    if-eq v1, v2, :cond_3

    .line 2658
    and-int/lit16 v1, v0, 0xff

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 2660
    :cond_3
    shl-int/lit8 v1, p1, 0x6

    and-int/lit8 v3, v0, 0x3f

    or-int p1, v1, v3

    .line 2661
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v1, v3, :cond_4

    .line 2662
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 2664
    :cond_4
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v0, v1, v3

    .line 2665
    and-int/lit16 v1, v0, 0xc0

    if-eq v1, v2, :cond_5

    .line 2666
    and-int/lit16 v1, v0, 0xff

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 2672
    :cond_5
    shl-int/lit8 v1, p1, 0x6

    and-int/lit8 v2, v0, 0x3f

    or-int/2addr v1, v2

    const/high16 v2, 0x10000

    sub-int/2addr v1, v2

    return v1
.end method

.method private handleNsDeclaration(Lcom/fasterxml/aalto/in/PName;B)V
    .locals 9
    .param p1, "name"    # Lcom/fasterxml/aalto/in/PName;
    .param p2, "quoteByte"    # B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 401
    const/4 v0, 0x0

    .line 402
    .local v0, "attrPtr":I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_nameBuffer:[C

    .line 405
    .local v1, "attrBuffer":[C
    :goto_0
    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v2, v3, :cond_0

    .line 406
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 408
    :cond_0
    iget-object v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v2, v2, v3

    .line 409
    .local v2, "b":B
    if-ne v2, p2, :cond_2

    .line 410
    nop

    .line 470
    .end local v2    # "b":B
    if-nez v0, :cond_1

    .line 471
    const-string v2, ""

    invoke-virtual {p0, p1, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->bindNs(Lcom/fasterxml/aalto/in/PName;Ljava/lang/String;)V

    goto :goto_1

    .line 473
    :cond_1
    iget-object v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v2, v1, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->canonicalizeURI([CI)Ljava/lang/String;

    move-result-object v2

    .line 474
    .local v2, "uri":Ljava/lang/String;
    invoke-virtual {p0, p1, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->bindNs(Lcom/fasterxml/aalto/in/PName;Ljava/lang/String;)V

    .line 476
    .end local v2    # "uri":Ljava/lang/String;
    :goto_1
    return-void

    .line 413
    .local v2, "b":B
    :cond_2
    const/16 v3, 0x26

    const v4, 0xdc00

    const v5, 0xd800

    const/high16 v6, 0x10000

    const/4 v7, 0x1

    if-ne v2, v3, :cond_5

    .line 414
    const/4 v3, 0x0

    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleEntityInText(Z)I

    move-result v3

    .line 415
    .local v3, "c":I
    if-nez v3, :cond_3

    .line 416
    invoke-virtual {p0, p1, v7}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportUnexpandedEntityInAttr(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 419
    :cond_3
    shr-int/lit8 v7, v3, 0x10

    if-eqz v7, :cond_d

    .line 420
    array-length v7, v1

    if-lt v0, v7, :cond_4

    .line 421
    array-length v7, v1

    invoke-static {v1, v7}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v7

    move-object v1, v7

    iput-object v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_nameBuffer:[C

    .line 423
    :cond_4
    sub-int/2addr v3, v6

    .line 424
    add-int/lit8 v6, v0, 0x1

    .end local v0    # "attrPtr":I
    .local v6, "attrPtr":I
    shr-int/lit8 v7, v3, 0xa

    or-int/2addr v5, v7

    int-to-char v5, v5

    aput-char v5, v1, v0

    .line 425
    and-int/lit16 v0, v3, 0x3ff

    or-int v3, v0, v4

    move v0, v6

    goto/16 :goto_2

    .line 427
    .end local v3    # "c":I
    .end local v6    # "attrPtr":I
    .restart local v0    # "attrPtr":I
    :cond_5
    const/16 v3, 0x3c

    if-ne v2, v3, :cond_6

    .line 428
    move v3, v2

    .line 429
    .restart local v3    # "c":I
    const-string v4, "\'<\' not allowed in attribute value"

    invoke-virtual {p0, v3, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->throwUnexpectedChar(ILjava/lang/String;)V

    goto :goto_2

    .line 431
    .end local v3    # "c":I
    :cond_6
    and-int/lit16 v3, v2, 0xff

    .line 432
    .restart local v3    # "c":I
    const/16 v8, 0x20

    if-ge v3, v8, :cond_b

    .line 433
    const/16 v4, 0xa

    if-ne v3, v4, :cond_7

    .line 434
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    goto :goto_2

    .line 435
    :cond_7
    const/16 v5, 0xd

    if-ne v3, v5, :cond_a

    .line 436
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v5, v6, :cond_8

    .line 437
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 439
    :cond_8
    iget-object v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v5, v5, v6

    if-ne v5, v4, :cond_9

    .line 440
    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/2addr v4, v7

    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 442
    :cond_9
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    goto :goto_2

    .line 443
    :cond_a
    const/16 v4, 0x9

    if-eq v3, v4, :cond_d

    .line 444
    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->throwInvalidSpace(I)V

    goto :goto_2

    .line 446
    :cond_b
    const/16 v7, 0x7f

    if-le v3, v7, :cond_d

    .line 447
    iget v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    invoke-direct {p0, v3, v7}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeMultiByteChar(II)I

    move-result v3

    .line 448
    if-gez v3, :cond_d

    .line 449
    neg-int v3, v3

    .line 451
    array-length v7, v1

    if-lt v0, v7, :cond_c

    .line 452
    array-length v7, v1

    invoke-static {v1, v7}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v7

    move-object v1, v7

    iput-object v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_nameBuffer:[C

    .line 454
    :cond_c
    sub-int/2addr v3, v6

    .line 455
    add-int/lit8 v6, v0, 0x1

    .end local v0    # "attrPtr":I
    .restart local v6    # "attrPtr":I
    shr-int/lit8 v7, v3, 0xa

    or-int/2addr v5, v7

    int-to-char v5, v5

    aput-char v5, v1, v0

    .line 456
    and-int/lit16 v0, v3, 0x3ff

    or-int v3, v0, v4

    move v0, v6

    .line 460
    .end local v6    # "attrPtr":I
    .restart local v0    # "attrPtr":I
    :cond_d
    :goto_2
    array-length v4, v1

    if-lt v0, v4, :cond_e

    .line 461
    array-length v4, v1

    invoke-static {v1, v4}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v4

    move-object v1, v4

    iput-object v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_nameBuffer:[C

    .line 463
    :cond_e
    add-int/lit8 v4, v0, 0x1

    .end local v0    # "attrPtr":I
    .local v4, "attrPtr":I
    int-to-char v5, v3

    aput-char v5, v1, v0

    .line 464
    .end local v2    # "b":B
    .end local v3    # "c":I
    move v0, v4

    goto/16 :goto_0
.end method

.method private final skipUtf8_2(I)V
    .locals 3
    .param p1, "c"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1257
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 1258
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1260
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte p1, v0, v1

    .line 1261
    and-int/lit16 v0, p1, 0xc0

    const/16 v1, 0x80

    if-eq v0, v1, :cond_1

    .line 1262
    and-int/lit16 v0, p1, 0xff

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 1264
    :cond_1
    return-void
.end method

.method private final skipUtf8_3(I)V
    .locals 5
    .param p1, "c"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1272
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 1273
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1275
    :cond_0
    and-int/lit8 p1, p1, 0xf

    .line 1276
    const/16 v0, 0xd

    const/16 v1, 0x80

    if-lt p1, v0, :cond_6

    .line 1277
    shl-int/lit8 p1, p1, 0x6

    .line 1278
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v0, v0, v2

    .line 1279
    .local v0, "d":I
    and-int/lit16 v2, v0, 0xc0

    if-eq v2, v1, :cond_1

    .line 1280
    and-int/lit16 v2, v0, 0xff

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 1282
    :cond_1
    and-int/lit8 v2, v0, 0x3f

    or-int/2addr p1, v2

    .line 1283
    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v2, v3, :cond_2

    .line 1284
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1286
    :cond_2
    iget-object v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v0, v2, v3

    .line 1287
    and-int/lit16 v2, v0, 0xc0

    if-eq v2, v1, :cond_3

    .line 1288
    and-int/lit16 v1, v0, 0xff

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 1290
    :cond_3
    shl-int/lit8 v1, p1, 0x6

    and-int/lit8 v2, v0, 0x3f

    or-int p1, v1, v2

    .line 1292
    const v1, 0xd800

    if-lt p1, v1, :cond_5

    .line 1293
    const v1, 0xe000

    if-lt p1, v1, :cond_4

    const v1, 0xfffe

    if-lt p1, v1, :cond_5

    const v1, 0xffff

    if-gt p1, v1, :cond_5

    .line 1294
    :cond_4
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleInvalidXmlChar(I)C

    move-result p1

    .line 1297
    .end local v0    # "d":I
    :cond_5
    goto :goto_0

    .line 1298
    :cond_6
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte p1, v0, v2

    .line 1299
    and-int/lit16 v0, p1, 0xc0

    if-eq v0, v1, :cond_7

    .line 1300
    and-int/lit16 v0, p1, 0xff

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 1302
    :cond_7
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v0, v2, :cond_8

    .line 1303
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1305
    :cond_8
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte p1, v0, v2

    .line 1306
    and-int/lit16 v0, p1, 0xc0

    if-eq v0, v1, :cond_9

    .line 1307
    and-int/lit16 v0, p1, 0xff

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 1310
    :cond_9
    :goto_0
    return-void
.end method

.method private final skipUtf8_4(I)V
    .locals 5
    .param p1, "c"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1314
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v0, v0, 0x4

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-le v0, v1, :cond_0

    .line 1315
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/in/Utf8Scanner;->skipUtf8_4Slow(I)V

    .line 1316
    return-void

    .line 1318
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 1319
    .local v0, "d":I
    and-int/lit16 v1, v0, 0xc0

    const/16 v2, 0x80

    if-eq v1, v2, :cond_1

    .line 1320
    and-int/lit16 v1, v0, 0xff

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 1322
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v0, v1, v3

    .line 1323
    and-int/lit16 v1, v0, 0xc0

    if-eq v1, v2, :cond_2

    .line 1324
    and-int/lit16 v1, v0, 0xff

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 1326
    :cond_2
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v0, v1, v3

    .line 1327
    and-int/lit16 v1, v0, 0xc0

    if-eq v1, v2, :cond_3

    .line 1328
    and-int/lit16 v1, v0, 0xff

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 1330
    :cond_3
    return-void
.end method

.method private final skipUtf8_4Slow(I)V
    .locals 5
    .param p1, "c"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1334
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 1335
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1337
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 1338
    .local v0, "d":I
    and-int/lit16 v1, v0, 0xc0

    const/16 v2, 0x80

    if-eq v1, v2, :cond_1

    .line 1339
    and-int/lit16 v1, v0, 0xff

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 1341
    :cond_1
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v1, v3, :cond_2

    .line 1342
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1344
    :cond_2
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v0, v1, v3

    .line 1345
    and-int/lit16 v1, v0, 0xc0

    if-eq v1, v2, :cond_3

    .line 1346
    and-int/lit16 v1, v0, 0xff

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 1348
    :cond_3
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v1, v3, :cond_4

    .line 1349
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1351
    :cond_4
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v0, v1, v3

    .line 1352
    and-int/lit16 v1, v0, 0xc0

    if-eq v1, v2, :cond_5

    .line 1353
    and-int/lit16 v1, v0, 0xff

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(II)V

    .line 1355
    :cond_5
    return-void
.end method


# virtual methods
.method public decodeCharForError(B)I
    .locals 6
    .param p1, "b"    # B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2690
    move v0, p1

    .line 2691
    .local v0, "c":I
    if-ltz v0, :cond_0

    .line 2692
    return v0

    .line 2697
    :cond_0
    and-int/lit16 v1, v0, 0xe0

    const/16 v2, 0xc0

    if-ne v1, v2, :cond_1

    .line 2698
    and-int/lit8 v0, v0, 0x1f

    .line 2699
    const/4 v1, 0x1

    .local v1, "needed":I
    goto :goto_0

    .line 2700
    .end local v1    # "needed":I
    :cond_1
    and-int/lit16 v1, v0, 0xf0

    const/16 v2, 0xe0

    if-ne v1, v2, :cond_2

    .line 2701
    and-int/lit8 v0, v0, 0xf

    .line 2702
    const/4 v1, 0x2

    .restart local v1    # "needed":I
    goto :goto_0

    .line 2703
    .end local v1    # "needed":I
    :cond_2
    and-int/lit16 v1, v0, 0xf8

    const/16 v2, 0xf0

    if-ne v1, v2, :cond_3

    .line 2705
    and-int/lit8 v0, v0, 0x7

    .line 2706
    const/4 v1, 0x3

    .restart local v1    # "needed":I
    goto :goto_0

    .line 2708
    .end local v1    # "needed":I
    :cond_3
    and-int/lit16 v1, v0, 0xff

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidInitial(I)V

    .line 2709
    const/4 v1, 0x1

    .line 2712
    .restart local v1    # "needed":I
    :goto_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->nextByte()B

    move-result v2

    .line 2713
    .local v2, "d":I
    and-int/lit16 v3, v2, 0xc0

    const/16 v4, 0x80

    if-eq v3, v4, :cond_4

    .line 2714
    and-int/lit16 v3, v2, 0xff

    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(I)V

    .line 2716
    :cond_4
    shl-int/lit8 v3, v0, 0x6

    and-int/lit8 v5, v2, 0x3f

    or-int v0, v3, v5

    .line 2718
    const/4 v3, 0x1

    if-le v1, v3, :cond_7

    .line 2719
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->nextByte()B

    move-result v2

    .line 2720
    and-int/lit16 v3, v2, 0xc0

    if-eq v3, v4, :cond_5

    .line 2721
    and-int/lit16 v3, v2, 0xff

    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(I)V

    .line 2723
    :cond_5
    shl-int/lit8 v3, v0, 0x6

    and-int/lit8 v5, v2, 0x3f

    or-int v0, v3, v5

    .line 2724
    const/4 v3, 0x2

    if-le v1, v3, :cond_7

    .line 2725
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->nextByte()B

    move-result v2

    .line 2726
    and-int/lit16 v3, v2, 0xc0

    if-eq v3, v4, :cond_6

    .line 2727
    and-int/lit16 v3, v2, 0xff

    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(I)V

    .line 2729
    :cond_6
    shl-int/lit8 v3, v0, 0x6

    and-int/lit8 v4, v2, 0x3f

    or-int v0, v3, v4

    .line 2732
    :cond_7
    return v0
.end method

.method protected final finishCData()V
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1367
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 1368
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    .line 1369
    .local v1, "inputBuffer":[B
    iget-object v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v2

    .line 1370
    .local v2, "outputBuffer":[C
    const/4 v3, 0x0

    .line 1381
    .local v3, "outPtr":I
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1382
    .local v4, "ptr":I
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v4, v5, :cond_0

    .line 1383
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1384
    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1386
    :cond_0
    array-length v5, v2

    if-lt v3, v5, :cond_1

    .line 1387
    iget-object v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v5}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 1388
    const/4 v3, 0x0

    .line 1390
    :cond_1
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    .line 1392
    .local v5, "max":I
    array-length v6, v2

    sub-int/2addr v6, v3

    add-int/2addr v6, v4

    .line 1393
    .local v6, "max2":I
    if-ge v6, v5, :cond_2

    .line 1394
    move v5, v6

    .line 1397
    .end local v6    # "max2":I
    :cond_2
    :goto_1
    if-ge v4, v5, :cond_f

    .line 1398
    add-int/lit8 v6, v4, 0x1

    .end local v4    # "ptr":I
    .local v6, "ptr":I
    aget-byte v4, v1, v4

    and-int/lit16 v4, v4, 0xff

    .line 1399
    .local v4, "c":I
    aget v7, v0, v4

    if-eqz v7, :cond_e

    .line 1400
    iput v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1401
    nop

    .line 1408
    .end local v5    # "max":I
    .end local v6    # "ptr":I
    aget v5, v0, v4

    const/4 v6, 0x1

    packed-switch v5, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_7

    .line 1431
    :pswitch_1
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_4(I)I

    move-result v4

    .line 1433
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .local v5, "outPtr":I
    shr-int/lit8 v6, v4, 0xa

    const v7, 0xd800

    or-int/2addr v6, v7

    int-to-char v6, v6

    aput-char v6, v2, v3

    .line 1434
    array-length v3, v2

    if-lt v5, v3, :cond_3

    .line 1435
    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 1436
    const/4 v3, 0x0

    .end local v5    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_2

    .line 1434
    .end local v3    # "outPtr":I
    .restart local v5    # "outPtr":I
    :cond_3
    move v3, v5

    .line 1438
    .end local v5    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_2
    and-int/lit16 v5, v4, 0x3ff

    const v6, 0xdc00

    or-int v4, v5, v6

    .line 1440
    goto/16 :goto_7

    .line 1428
    :pswitch_2
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_3(I)I

    move-result v4

    .line 1429
    goto/16 :goto_7

    .line 1425
    :pswitch_3
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_2(I)I

    move-result v4

    .line 1426
    goto/16 :goto_7

    .line 1442
    :pswitch_4
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidInitial(I)V

    .line 1449
    :pswitch_5
    const/4 v5, 0x0

    .line 1453
    .local v5, "count":I
    :goto_3
    iget v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v7, v8, :cond_4

    .line 1454
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1456
    :cond_4
    iget-object v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v7, v7, v8

    .line 1457
    .local v7, "b":B
    const/16 v8, 0x5d

    if-eq v7, v8, :cond_a

    .line 1458
    nop

    .line 1465
    const/16 v9, 0x3e

    if-ne v7, v9, :cond_5

    if-lt v5, v6, :cond_5

    move v9, v6

    goto :goto_4

    :cond_5
    const/4 v9, 0x0

    .line 1466
    .local v9, "ok":Z
    :goto_4
    if-eqz v9, :cond_6

    .line 1467
    add-int/lit8 v5, v5, -0x1

    .line 1470
    :cond_6
    :goto_5
    if-lez v5, :cond_8

    .line 1471
    add-int/lit8 v10, v3, 0x1

    .end local v3    # "outPtr":I
    .local v10, "outPtr":I
    aput-char v8, v2, v3

    .line 1472
    array-length v3, v2

    if-lt v10, v3, :cond_7

    .line 1473
    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 1474
    const/4 v3, 0x0

    .end local v10    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_6

    .line 1472
    .end local v3    # "outPtr":I
    .restart local v10    # "outPtr":I
    :cond_7
    move v3, v10

    .line 1470
    .end local v10    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_6
    add-int/lit8 v5, v5, -0x1

    goto :goto_5

    .line 1477
    :cond_8
    if-eqz v9, :cond_d

    .line 1478
    iget v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/2addr v8, v6

    iput v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1479
    nop

    .line 1487
    .end local v4    # "c":I
    .end local v5    # "count":I
    .end local v7    # "b":B
    .end local v9    # "ok":Z
    iget-object v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 1491
    iget-boolean v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_cfgCoalescing:Z

    if-eqz v4, :cond_9

    iget-boolean v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_entityPending:Z

    if-nez v4, :cond_9

    .line 1492
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->finishCoalescedText()V

    .line 1494
    :cond_9
    return-void

    .line 1460
    .restart local v4    # "c":I
    .restart local v5    # "count":I
    .restart local v7    # "b":B
    :cond_a
    iget v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/2addr v8, v6

    iput v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1461
    add-int/lit8 v5, v5, 0x1

    .line 1462
    goto :goto_3

    .line 1422
    .end local v5    # "count":I
    .end local v7    # "b":B
    :pswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 1423
    goto :goto_7

    .line 1410
    :pswitch_7
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleInvalidXmlChar(I)C

    move-result v4

    .line 1412
    :pswitch_8
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v5, v7, :cond_b

    .line 1413
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1415
    :cond_b
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v5, v1, v5

    const/16 v7, 0xa

    if-ne v5, v7, :cond_c

    .line 1416
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/2addr v5, v6

    iput v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1418
    :cond_c
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 1419
    const/16 v4, 0xa

    .line 1420
    nop

    .line 1484
    :cond_d
    :goto_7
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .local v5, "outPtr":I
    int-to-char v6, v4

    aput-char v6, v2, v3

    .line 1485
    .end local v4    # "c":I
    move v3, v5

    goto/16 :goto_0

    .line 1403
    .restart local v3    # "outPtr":I
    .restart local v4    # "c":I
    .local v5, "max":I
    .restart local v6    # "ptr":I
    :cond_e
    add-int/lit8 v7, v3, 0x1

    .end local v3    # "outPtr":I
    .local v7, "outPtr":I
    int-to-char v8, v4

    aput-char v8, v2, v3

    move v4, v6

    move v3, v7

    goto/16 :goto_1

    .line 1405
    .end local v6    # "ptr":I
    .end local v7    # "outPtr":I
    .restart local v3    # "outPtr":I
    .local v4, "ptr":I
    :cond_f
    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1406
    .end local v4    # "ptr":I
    .end local v5    # "max":I
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

.method protected final finishCharacters()V
    .locals 14
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1504
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_tmpChar:I

    .line 1505
    .local v0, "c":I
    const/high16 v1, 0x10000

    const v2, 0xdc00

    const v3, 0xd800

    const/16 v4, 0xa

    const/4 v5, 0x1

    if-gez v0, :cond_1

    .line 1506
    neg-int v0, v0

    .line 1507
    iget-object v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v6}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v6

    .line 1508
    .local v6, "outputBuffer":[C
    const/4 v7, 0x0

    .line 1509
    .local v7, "outPtr":I
    shr-int/lit8 v8, v0, 0x10

    if-eqz v8, :cond_0

    .line 1510
    sub-int/2addr v0, v1

    .line 1514
    add-int/lit8 v8, v7, 0x1

    .end local v7    # "outPtr":I
    .local v8, "outPtr":I
    shr-int/lit8 v9, v0, 0xa

    or-int/2addr v9, v3

    int-to-char v9, v9

    aput-char v9, v6, v7

    .line 1515
    and-int/lit16 v7, v0, 0x3ff

    or-int v0, v7, v2

    move v7, v8

    .line 1517
    .end local v8    # "outPtr":I
    .restart local v7    # "outPtr":I
    :cond_0
    add-int/lit8 v8, v7, 0x1

    .end local v7    # "outPtr":I
    .restart local v8    # "outPtr":I
    int-to-char v9, v0

    aput-char v9, v6, v7

    goto :goto_1

    .line 1519
    .end local v6    # "outputBuffer":[C
    .end local v8    # "outPtr":I
    :cond_1
    const/16 v6, 0xd

    if-eq v0, v6, :cond_3

    if-ne v0, v4, :cond_2

    goto :goto_0

    .line 1528
    :cond_2
    iget-object v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v6}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v6

    .line 1529
    .restart local v6    # "outputBuffer":[C
    const/4 v8, 0x0

    .restart local v8    # "outPtr":I
    goto :goto_1

    .line 1520
    .end local v6    # "outputBuffer":[C
    .end local v8    # "outPtr":I
    :cond_3
    :goto_0
    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/2addr v6, v5

    iput v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1521
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->checkInTreeIndentation(I)I

    move-result v8

    .line 1522
    .restart local v8    # "outPtr":I
    if-gez v8, :cond_4

    .line 1523
    return-void

    .line 1526
    :cond_4
    iget-object v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v6}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v6

    .line 1533
    .restart local v6    # "outputBuffer":[C
    :goto_1
    iget-object v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v7, v7, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    .line 1534
    .local v7, "TYPES":[I
    iget-object v9, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    .line 1541
    .local v9, "inputBuffer":[B
    :goto_2
    iget v10, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1542
    .local v10, "ptr":I
    iget v11, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v10, v11, :cond_5

    .line 1543
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1544
    iget v10, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1546
    :cond_5
    array-length v11, v6

    if-lt v8, v11, :cond_6

    .line 1547
    iget-object v11, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v11}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v6

    .line 1548
    const/4 v8, 0x0

    .line 1550
    :cond_6
    iget v11, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    .line 1552
    .local v11, "max":I
    array-length v12, v6

    sub-int/2addr v12, v8

    add-int/2addr v12, v10

    .line 1553
    .local v12, "max2":I
    if-ge v12, v11, :cond_7

    .line 1554
    move v11, v12

    .line 1557
    .end local v12    # "max2":I
    :cond_7
    :goto_3
    if-ge v10, v11, :cond_15

    .line 1558
    add-int/lit8 v12, v10, 0x1

    .end local v10    # "ptr":I
    .local v12, "ptr":I
    aget-byte v10, v9, v10

    and-int/lit16 v0, v10, 0xff

    .line 1559
    aget v10, v7, v0

    if-eqz v10, :cond_14

    .line 1560
    iput v12, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1561
    nop

    .line 1568
    .end local v11    # "max":I
    .end local v12    # "ptr":I
    aget v10, v7, v0

    packed-switch v10, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_a

    .line 1633
    :pswitch_1
    const/4 v10, 0x1

    .line 1636
    .local v10, "count":I
    :goto_4
    iget v11, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v12, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v11, v12, :cond_8

    .line 1637
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1639
    :cond_8
    iget v11, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v11, v9, v11

    .line 1640
    .local v11, "b":B
    const/16 v12, 0x5d

    if-eq v11, v12, :cond_b

    .line 1641
    nop

    .line 1646
    const/16 v13, 0x3e

    if-ne v11, v13, :cond_9

    if-le v10, v5, :cond_9

    .line 1647
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportIllegalCDataEnd()V

    .line 1651
    :cond_9
    :goto_5
    if-le v10, v5, :cond_13

    .line 1652
    add-int/lit8 v13, v8, 0x1

    .end local v8    # "outPtr":I
    .local v13, "outPtr":I
    aput-char v12, v6, v8

    .line 1654
    array-length v8, v6

    if-lt v13, v8, :cond_a

    .line 1655
    iget-object v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v8}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v6

    .line 1656
    const/4 v8, 0x0

    .end local v13    # "outPtr":I
    .restart local v8    # "outPtr":I
    goto :goto_6

    .line 1654
    .end local v8    # "outPtr":I
    .restart local v13    # "outPtr":I
    :cond_a
    move v8, v13

    .line 1658
    .end local v13    # "outPtr":I
    .restart local v8    # "outPtr":I
    :goto_6
    add-int/lit8 v10, v10, -0x1

    goto :goto_5

    .line 1643
    :cond_b
    iget v12, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/2addr v12, v5

    iput v12, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1644
    add-int/lit8 v10, v10, 0x1

    goto :goto_4

    .line 1611
    .end local v10    # "count":I
    .end local v11    # "b":B
    :pswitch_2
    const/4 v10, 0x0

    invoke-virtual {p0, v10}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleEntityInText(Z)I

    move-result v0

    .line 1612
    if-nez v0, :cond_c

    .line 1614
    iput-boolean v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_entityPending:Z

    .line 1615
    goto :goto_9

    .line 1618
    :cond_c
    shr-int/lit8 v10, v0, 0x10

    if-eqz v10, :cond_13

    .line 1619
    sub-int/2addr v0, v1

    .line 1620
    add-int/lit8 v10, v8, 0x1

    .end local v8    # "outPtr":I
    .local v10, "outPtr":I
    shr-int/lit8 v11, v0, 0xa

    or-int/2addr v11, v3

    int-to-char v11, v11

    aput-char v11, v6, v8

    .line 1622
    array-length v8, v6

    if-lt v10, v8, :cond_d

    .line 1623
    iget-object v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v8}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v6

    .line 1624
    const/4 v8, 0x0

    .end local v10    # "outPtr":I
    .restart local v8    # "outPtr":I
    goto :goto_7

    .line 1622
    .end local v8    # "outPtr":I
    .restart local v10    # "outPtr":I
    :cond_d
    move v8, v10

    .line 1626
    .end local v10    # "outPtr":I
    .restart local v8    # "outPtr":I
    :goto_7
    and-int/lit16 v10, v0, 0x3ff

    or-int v0, v10, v2

    goto/16 :goto_a

    .line 1595
    :pswitch_3
    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_4(I)I

    move-result v0

    .line 1597
    add-int/lit8 v10, v8, 0x1

    .end local v8    # "outPtr":I
    .restart local v10    # "outPtr":I
    shr-int/lit8 v11, v0, 0xa

    or-int/2addr v11, v3

    int-to-char v11, v11

    aput-char v11, v6, v8

    .line 1598
    array-length v8, v6

    if-lt v10, v8, :cond_e

    .line 1599
    iget-object v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v8}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v6

    .line 1600
    const/4 v8, 0x0

    .end local v10    # "outPtr":I
    .restart local v8    # "outPtr":I
    goto :goto_8

    .line 1598
    .end local v8    # "outPtr":I
    .restart local v10    # "outPtr":I
    :cond_e
    move v8, v10

    .line 1602
    .end local v10    # "outPtr":I
    .restart local v8    # "outPtr":I
    :goto_8
    and-int/lit16 v10, v0, 0x3ff

    or-int v0, v10, v2

    .line 1604
    goto :goto_a

    .line 1588
    :pswitch_4
    iget v10, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    iget v11, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    sub-int/2addr v10, v11

    const/4 v11, 0x2

    if-lt v10, v11, :cond_f

    .line 1589
    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_3fast(I)I

    move-result v0

    goto :goto_a

    .line 1591
    :cond_f
    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_3(I)I

    move-result v0

    .line 1593
    goto :goto_a

    .line 1585
    :pswitch_5
    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_2(I)I

    move-result v0

    .line 1586
    goto :goto_a

    .line 1606
    :pswitch_6
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidInitial(I)V

    .line 1608
    :pswitch_7
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    sub-int/2addr v1, v5

    iput v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1609
    nop

    .line 1671
    :goto_9
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1, v8}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 1676
    iget-boolean v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_cfgCoalescing:Z

    if-eqz v1, :cond_10

    iget-boolean v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_entityPending:Z

    if-nez v1, :cond_10

    .line 1677
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->finishCoalescedText()V

    .line 1679
    :cond_10
    return-void

    .line 1582
    :pswitch_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 1583
    goto :goto_a

    .line 1570
    :pswitch_9
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleInvalidXmlChar(I)C

    move-result v0

    .line 1572
    :pswitch_a
    iget v10, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v11, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v10, v11, :cond_11

    .line 1573
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1575
    :cond_11
    iget v10, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v10, v9, v10

    if-ne v10, v4, :cond_12

    .line 1576
    iget v10, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/2addr v10, v5

    iput v10, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1578
    :cond_12
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 1579
    const/16 v0, 0xa

    .line 1580
    nop

    .line 1668
    :cond_13
    :goto_a
    add-int/lit8 v10, v8, 0x1

    .end local v8    # "outPtr":I
    .restart local v10    # "outPtr":I
    int-to-char v11, v0

    aput-char v11, v6, v8

    move v8, v10

    goto/16 :goto_2

    .line 1563
    .end local v10    # "outPtr":I
    .restart local v8    # "outPtr":I
    .local v11, "max":I
    .restart local v12    # "ptr":I
    :cond_14
    add-int/lit8 v10, v8, 0x1

    .end local v8    # "outPtr":I
    .restart local v10    # "outPtr":I
    int-to-char v13, v0

    aput-char v13, v6, v8

    move v8, v10

    move v10, v12

    goto/16 :goto_3

    .line 1565
    .end local v12    # "ptr":I
    .restart local v8    # "outPtr":I
    .local v10, "ptr":I
    :cond_15
    iput v10, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1566
    .end local v10    # "ptr":I
    .end local v11    # "max":I
    goto/16 :goto_2

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

.method protected final finishCoalescedCData()V
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2320
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 2321
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    .line 2323
    .local v1, "inputBuffer":[B
    iget-object v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v2

    .line 2324
    .local v2, "outputBuffer":[C
    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->getCurrentLength()I

    move-result v3

    .line 2335
    .local v3, "outPtr":I
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2336
    .local v4, "ptr":I
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v4, v5, :cond_0

    .line 2337
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 2338
    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2340
    :cond_0
    array-length v5, v2

    if-lt v3, v5, :cond_1

    .line 2341
    iget-object v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v5}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2342
    const/4 v3, 0x0

    .line 2344
    :cond_1
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    .line 2346
    .local v5, "max":I
    array-length v6, v2

    sub-int/2addr v6, v3

    add-int/2addr v6, v4

    .line 2347
    .local v6, "max2":I
    if-ge v6, v5, :cond_2

    .line 2348
    move v5, v6

    .line 2351
    .end local v6    # "max2":I
    :cond_2
    :goto_1
    if-ge v4, v5, :cond_e

    .line 2352
    add-int/lit8 v6, v4, 0x1

    .end local v4    # "ptr":I
    .local v6, "ptr":I
    aget-byte v4, v1, v4

    and-int/lit16 v4, v4, 0xff

    .line 2353
    .local v4, "c":I
    aget v7, v0, v4

    if-eqz v7, :cond_d

    .line 2354
    iput v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2355
    nop

    .line 2362
    .end local v5    # "max":I
    .end local v6    # "ptr":I
    aget v5, v0, v4

    const/4 v6, 0x1

    packed-switch v5, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_7

    .line 2385
    :pswitch_1
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_4(I)I

    move-result v4

    .line 2387
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .local v5, "outPtr":I
    shr-int/lit8 v6, v4, 0xa

    const v7, 0xd800

    or-int/2addr v6, v7

    int-to-char v6, v6

    aput-char v6, v2, v3

    .line 2388
    array-length v3, v2

    if-lt v5, v3, :cond_3

    .line 2389
    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2390
    const/4 v3, 0x0

    .end local v5    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_2

    .line 2388
    .end local v3    # "outPtr":I
    .restart local v5    # "outPtr":I
    :cond_3
    move v3, v5

    .line 2392
    .end local v5    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_2
    and-int/lit16 v5, v4, 0x3ff

    const v6, 0xdc00

    or-int v4, v5, v6

    .line 2394
    goto/16 :goto_7

    .line 2382
    :pswitch_2
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_3(I)I

    move-result v4

    .line 2383
    goto/16 :goto_7

    .line 2379
    :pswitch_3
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_2(I)I

    move-result v4

    .line 2380
    goto/16 :goto_7

    .line 2396
    :pswitch_4
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidInitial(I)V

    .line 2403
    :pswitch_5
    const/4 v5, 0x0

    .line 2407
    .local v5, "count":I
    :goto_3
    iget v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v7, v8, :cond_4

    .line 2408
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 2410
    :cond_4
    iget-object v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v7, v7, v8

    .line 2411
    .local v7, "b":B
    const/16 v8, 0x5d

    if-eq v7, v8, :cond_9

    .line 2412
    nop

    .line 2419
    const/16 v9, 0x3e

    if-ne v7, v9, :cond_5

    if-lt v5, v6, :cond_5

    move v9, v6

    goto :goto_4

    :cond_5
    const/4 v9, 0x0

    .line 2420
    .local v9, "ok":Z
    :goto_4
    if-eqz v9, :cond_6

    .line 2421
    add-int/lit8 v5, v5, -0x1

    .line 2424
    :cond_6
    :goto_5
    if-lez v5, :cond_8

    .line 2425
    add-int/lit8 v10, v3, 0x1

    .end local v3    # "outPtr":I
    .local v10, "outPtr":I
    aput-char v8, v2, v3

    .line 2426
    array-length v3, v2

    if-lt v10, v3, :cond_7

    .line 2427
    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2428
    const/4 v3, 0x0

    .end local v10    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_6

    .line 2426
    .end local v3    # "outPtr":I
    .restart local v10    # "outPtr":I
    :cond_7
    move v3, v10

    .line 2424
    .end local v10    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_6
    add-int/lit8 v5, v5, -0x1

    goto :goto_5

    .line 2431
    :cond_8
    if-eqz v9, :cond_c

    .line 2432
    iget v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/2addr v8, v6

    iput v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2433
    nop

    .line 2441
    .end local v4    # "c":I
    .end local v5    # "count":I
    .end local v7    # "b":B
    .end local v9    # "ok":Z
    iget-object v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 2442
    return-void

    .line 2414
    .restart local v4    # "c":I
    .restart local v5    # "count":I
    .restart local v7    # "b":B
    :cond_9
    iget v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/2addr v8, v6

    iput v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2415
    add-int/lit8 v5, v5, 0x1

    .line 2416
    goto :goto_3

    .line 2376
    .end local v5    # "count":I
    .end local v7    # "b":B
    :pswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 2377
    goto :goto_7

    .line 2364
    :pswitch_7
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleInvalidXmlChar(I)C

    move-result v4

    .line 2366
    :pswitch_8
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v5, v7, :cond_a

    .line 2367
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 2369
    :cond_a
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v5, v1, v5

    const/16 v7, 0xa

    if-ne v5, v7, :cond_b

    .line 2370
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/2addr v5, v6

    iput v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2372
    :cond_b
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 2373
    const/16 v4, 0xa

    .line 2374
    nop

    .line 2438
    :cond_c
    :goto_7
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .local v5, "outPtr":I
    int-to-char v6, v4

    aput-char v6, v2, v3

    .line 2439
    .end local v4    # "c":I
    move v3, v5

    goto/16 :goto_0

    .line 2357
    .restart local v3    # "outPtr":I
    .restart local v4    # "c":I
    .local v5, "max":I
    .restart local v6    # "ptr":I
    :cond_d
    add-int/lit8 v7, v3, 0x1

    .end local v3    # "outPtr":I
    .local v7, "outPtr":I
    int-to-char v8, v4

    aput-char v8, v2, v3

    move v4, v6

    move v3, v7

    goto/16 :goto_1

    .line 2359
    .end local v6    # "ptr":I
    .end local v7    # "outPtr":I
    .restart local v3    # "outPtr":I
    .local v4, "ptr":I
    :cond_e
    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2360
    .end local v4    # "ptr":I
    .end local v5    # "max":I
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

.method protected final finishCoalescedCharacters()V
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2169
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    .line 2170
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    .line 2172
    .local v1, "inputBuffer":[B
    iget-object v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v2

    .line 2173
    .local v2, "outputBuffer":[C
    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->getCurrentLength()I

    move-result v3

    .line 2182
    .local v3, "outPtr":I
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2183
    .local v4, "ptr":I
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v4, v5, :cond_0

    .line 2184
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 2185
    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2187
    :cond_0
    array-length v5, v2

    if-lt v3, v5, :cond_1

    .line 2188
    iget-object v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v5}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2189
    const/4 v3, 0x0

    .line 2191
    :cond_1
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    .line 2193
    .local v5, "max":I
    array-length v6, v2

    sub-int/2addr v6, v3

    add-int/2addr v6, v4

    .line 2194
    .local v6, "max2":I
    if-ge v6, v5, :cond_2

    .line 2195
    move v5, v6

    .line 2198
    .end local v6    # "max2":I
    :cond_2
    :goto_1
    if-ge v4, v5, :cond_f

    .line 2199
    add-int/lit8 v6, v4, 0x1

    .end local v4    # "ptr":I
    .local v6, "ptr":I
    aget-byte v4, v1, v4

    and-int/lit16 v4, v4, 0xff

    .line 2200
    .local v4, "c":I
    aget v7, v0, v4

    if-eqz v7, :cond_e

    .line 2201
    iput v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2202
    nop

    .line 2209
    .end local v5    # "max":I
    .end local v6    # "ptr":I
    aget v5, v0, v4

    const v6, 0xdc00

    const v7, 0xd800

    const/4 v8, 0x1

    packed-switch v5, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_8

    .line 2274
    :pswitch_1
    const/4 v5, 0x1

    .line 2277
    .local v5, "count":I
    :goto_2
    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v6, v7, :cond_3

    .line 2278
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 2280
    :cond_3
    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v6, v1, v6

    .line 2281
    .local v6, "b":B
    const/16 v7, 0x5d

    if-eq v6, v7, :cond_6

    .line 2282
    nop

    .line 2287
    const/16 v9, 0x3e

    if-ne v6, v9, :cond_4

    if-le v5, v8, :cond_4

    .line 2288
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportIllegalCDataEnd()V

    .line 2292
    :cond_4
    :goto_3
    if-le v5, v8, :cond_d

    .line 2293
    add-int/lit8 v9, v3, 0x1

    .end local v3    # "outPtr":I
    .local v9, "outPtr":I
    aput-char v7, v2, v3

    .line 2295
    array-length v3, v2

    if-lt v9, v3, :cond_5

    .line 2296
    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2297
    const/4 v3, 0x0

    .end local v9    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_4

    .line 2295
    .end local v3    # "outPtr":I
    .restart local v9    # "outPtr":I
    :cond_5
    move v3, v9

    .line 2299
    .end local v9    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_4
    add-int/lit8 v5, v5, -0x1

    goto :goto_3

    .line 2284
    :cond_6
    iget v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/2addr v7, v8

    iput v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2285
    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    .line 2252
    .end local v5    # "count":I
    .end local v6    # "b":B
    :pswitch_2
    const/4 v5, 0x0

    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleEntityInText(Z)I

    move-result v4

    .line 2253
    if-nez v4, :cond_7

    .line 2255
    iput-boolean v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_entityPending:Z

    .line 2256
    goto :goto_7

    .line 2259
    :cond_7
    shr-int/lit8 v5, v4, 0x10

    if-eqz v5, :cond_d

    .line 2260
    const/high16 v5, 0x10000

    sub-int/2addr v4, v5

    .line 2261
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .local v5, "outPtr":I
    shr-int/lit8 v8, v4, 0xa

    or-int/2addr v7, v8

    int-to-char v7, v7

    aput-char v7, v2, v3

    .line 2263
    array-length v3, v2

    if-lt v5, v3, :cond_8

    .line 2264
    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2265
    const/4 v3, 0x0

    .end local v5    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_5

    .line 2263
    .end local v3    # "outPtr":I
    .restart local v5    # "outPtr":I
    :cond_8
    move v3, v5

    .line 2267
    .end local v5    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_5
    and-int/lit16 v5, v4, 0x3ff

    or-int v4, v5, v6

    goto :goto_8

    .line 2236
    :pswitch_3
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_4(I)I

    move-result v4

    .line 2238
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .restart local v5    # "outPtr":I
    shr-int/lit8 v8, v4, 0xa

    or-int/2addr v7, v8

    int-to-char v7, v7

    aput-char v7, v2, v3

    .line 2239
    array-length v3, v2

    if-lt v5, v3, :cond_9

    .line 2240
    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2241
    const/4 v3, 0x0

    .end local v5    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_6

    .line 2239
    .end local v3    # "outPtr":I
    .restart local v5    # "outPtr":I
    :cond_9
    move v3, v5

    .line 2243
    .end local v5    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_6
    and-int/lit16 v5, v4, 0x3ff

    or-int v4, v5, v6

    .line 2245
    goto :goto_8

    .line 2229
    :pswitch_4
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    sub-int/2addr v5, v6

    const/4 v6, 0x2

    if-lt v5, v6, :cond_a

    .line 2230
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_3fast(I)I

    move-result v4

    goto :goto_8

    .line 2232
    :cond_a
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_3(I)I

    move-result v4

    .line 2234
    goto :goto_8

    .line 2226
    :pswitch_5
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_2(I)I

    move-result v4

    .line 2227
    goto :goto_8

    .line 2247
    :pswitch_6
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidInitial(I)V

    .line 2249
    :pswitch_7
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    sub-int/2addr v5, v8

    iput v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2250
    nop

    .line 2312
    :goto_7
    iget-object v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v5, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 2313
    return-void

    .line 2223
    :pswitch_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 2224
    goto :goto_8

    .line 2211
    :pswitch_9
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleInvalidXmlChar(I)C

    move-result v4

    .line 2213
    :pswitch_a
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v5, v6, :cond_b

    .line 2214
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 2216
    :cond_b
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v5, v1, v5

    const/16 v6, 0xa

    if-ne v5, v6, :cond_c

    .line 2217
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/2addr v5, v8

    iput v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2219
    :cond_c
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 2220
    const/16 v4, 0xa

    .line 2221
    nop

    .line 2309
    :cond_d
    :goto_8
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .restart local v5    # "outPtr":I
    int-to-char v6, v4

    aput-char v6, v2, v3

    move v3, v5

    goto/16 :goto_0

    .line 2204
    .restart local v3    # "outPtr":I
    .local v5, "max":I
    .local v6, "ptr":I
    :cond_e
    add-int/lit8 v7, v3, 0x1

    .end local v3    # "outPtr":I
    .local v7, "outPtr":I
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
    :cond_f
    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

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

.method protected final finishCoalescedText()V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2119
    nop

    :cond_0
    :goto_0
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v0, v1, :cond_1

    .line 2120
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_1

    .line 2121
    return-void

    .line 2125
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v0, v0, v1

    const/16 v1, 0x3c

    if-ne v0, v1, :cond_8

    .line 2129
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    const/4 v1, 0x3

    add-int/2addr v0, v1

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v0, v2, :cond_2

    .line 2130
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadAndRetain(I)Z

    move-result v0

    if-nez v0, :cond_2

    .line 2132
    return-void

    .line 2135
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v2, v2, 0x1

    aget-byte v0, v0, v2

    const/16 v2, 0x21

    if-ne v0, v2, :cond_7

    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v2, v2, 0x2

    aget-byte v0, v0, v2

    const/16 v2, 0x5b

    if-eq v0, v2, :cond_3

    goto :goto_2

    .line 2141
    :cond_3
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2142
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    const/4 v1, 0x6

    if-ge v0, v1, :cond_6

    .line 2143
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v1, v2, :cond_4

    .line 2144
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 2146
    :cond_4
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v1, v1, v2

    .line 2147
    .local v1, "b":B
    const-string v2, "CDATA["

    invoke-virtual {v2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    int-to-byte v3, v3

    if-eq v1, v3, :cond_5

    .line 2148
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeCharForError(B)I

    move-result v3

    .line 2149
    .local v3, "ch":I
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " (expected \'"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "\' for CDATA section)"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v3, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 2142
    .end local v1    # "b":B
    .end local v3    # "ch":I
    :cond_5
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 2152
    .end local v0    # "i":I
    :cond_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->finishCoalescedCData()V

    goto/16 :goto_0

    .line 2138
    :cond_7
    :goto_2
    return-void

    .line 2154
    :cond_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->finishCoalescedCharacters()V

    .line 2155
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_entityPending:Z

    if-eqz v0, :cond_0

    .line 2156
    nop

    .line 2160
    return-void
.end method

.method protected final finishComment()V
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1684
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 1685
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    .line 1686
    .local v1, "inputBuffer":[B
    iget-object v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v2

    .line 1687
    .local v2, "outputBuffer":[C
    const/4 v3, 0x0

    .line 1695
    .local v3, "outPtr":I
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1696
    .local v4, "ptr":I
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v4, v5, :cond_0

    .line 1697
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1698
    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1700
    :cond_0
    array-length v5, v2

    if-lt v3, v5, :cond_1

    .line 1701
    iget-object v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v5}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 1702
    const/4 v3, 0x0

    .line 1704
    :cond_1
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    .line 1706
    .local v5, "max":I
    array-length v6, v2

    sub-int/2addr v6, v3

    add-int/2addr v6, v4

    .line 1707
    .local v6, "max2":I
    if-ge v6, v5, :cond_2

    .line 1708
    move v5, v6

    .line 1711
    .end local v6    # "max2":I
    :cond_2
    :goto_1
    if-ge v4, v5, :cond_b

    .line 1712
    add-int/lit8 v6, v4, 0x1

    .end local v4    # "ptr":I
    .local v6, "ptr":I
    aget-byte v4, v1, v4

    and-int/lit16 v4, v4, 0xff

    .line 1713
    .local v4, "c":I
    aget v7, v0, v4

    if-eqz v7, :cond_a

    .line 1714
    iput v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1715
    nop

    .line 1722
    .end local v5    # "max":I
    .end local v6    # "ptr":I
    aget v5, v0, v4

    packed-switch v5, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_3

    .line 1745
    :pswitch_1
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_4(I)I

    move-result v4

    .line 1747
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .local v5, "outPtr":I
    shr-int/lit8 v6, v4, 0xa

    const v7, 0xd800

    or-int/2addr v6, v7

    int-to-char v6, v6

    aput-char v6, v2, v3

    .line 1748
    array-length v3, v2

    if-lt v5, v3, :cond_3

    .line 1749
    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 1750
    const/4 v3, 0x0

    .end local v5    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_2

    .line 1748
    .end local v3    # "outPtr":I
    .restart local v5    # "outPtr":I
    :cond_3
    move v3, v5

    .line 1752
    .end local v5    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_2
    and-int/lit16 v5, v4, 0x3ff

    const v6, 0xdc00

    or-int v4, v5, v6

    .line 1754
    goto :goto_3

    .line 1742
    :pswitch_2
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_3(I)I

    move-result v4

    .line 1743
    goto :goto_3

    .line 1739
    :pswitch_3
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_2(I)I

    move-result v4

    .line 1740
    goto :goto_3

    .line 1756
    :pswitch_4
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidInitial(I)V

    .line 1758
    :pswitch_5
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v5, v6, :cond_4

    .line 1759
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1761
    :cond_4
    iget-object v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v5, v5, v6

    const/16 v6, 0x2d

    if-ne v5, v6, :cond_9

    .line 1762
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v5, v5, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1763
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v5, v6, :cond_5

    .line 1764
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1766
    :cond_5
    iget-object v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v5, v5, v6

    const/16 v6, 0x3e

    if-eq v5, v6, :cond_6

    .line 1767
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportDoubleHyphenInComments()V

    .line 1779
    .end local v4    # "c":I
    :cond_6
    iget-object v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 1780
    return-void

    .line 1736
    .restart local v4    # "c":I
    :pswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 1737
    goto :goto_3

    .line 1724
    :pswitch_7
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleInvalidXmlChar(I)C

    move-result v4

    .line 1726
    :pswitch_8
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v5, v6, :cond_7

    .line 1727
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1729
    :cond_7
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v5, v1, v5

    const/16 v6, 0xa

    if-ne v5, v6, :cond_8

    .line 1730
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v5, v5, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1732
    :cond_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 1733
    const/16 v4, 0xa

    .line 1734
    nop

    .line 1777
    :cond_9
    :goto_3
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .restart local v5    # "outPtr":I
    int-to-char v6, v4

    aput-char v6, v2, v3

    .line 1778
    .end local v4    # "c":I
    move v3, v5

    goto/16 :goto_0

    .line 1717
    .restart local v3    # "outPtr":I
    .restart local v4    # "c":I
    .local v5, "max":I
    .restart local v6    # "ptr":I
    :cond_a
    add-int/lit8 v7, v3, 0x1

    .end local v3    # "outPtr":I
    .local v7, "outPtr":I
    int-to-char v8, v4

    aput-char v8, v2, v3

    move v4, v6

    move v3, v7

    goto/16 :goto_1

    .line 1719
    .end local v6    # "ptr":I
    .end local v7    # "outPtr":I
    .restart local v3    # "outPtr":I
    .local v4, "ptr":I
    :cond_b
    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1720
    .end local v4    # "ptr":I
    .end local v5    # "max":I
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
        :pswitch_0
        :pswitch_0
        :pswitch_5
    .end packed-switch
.end method

.method protected final finishDTD(Z)V
    .locals 11
    .param p1, "copyContents"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1789
    const/4 v0, 0x0

    if-eqz p1, :cond_0

    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v1, v0

    .line 1790
    .local v1, "outputBuffer":[C
    :goto_0
    const/4 v2, 0x0

    .line 1792
    .local v2, "outPtr":I
    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v3, v3, Lcom/fasterxml/aalto/util/XmlCharTypes;->DTD_CHARS:[I

    .line 1793
    .local v3, "TYPES":[I
    const/4 v4, 0x0

    .line 1794
    .local v4, "inDecl":Z
    const/4 v5, 0x0

    .line 1805
    .local v5, "quoteChar":I
    :goto_1
    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1806
    .local v6, "ptr":I
    iget v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v6, v7, :cond_1

    .line 1807
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1808
    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1810
    :cond_1
    iget v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    .line 1811
    .local v7, "max":I
    if-eqz v1, :cond_3

    .line 1812
    array-length v8, v1

    if-lt v2, v8, :cond_2

    .line 1813
    iget-object v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v8}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v1

    .line 1814
    const/4 v2, 0x0

    .line 1817
    :cond_2
    array-length v8, v1

    sub-int/2addr v8, v2

    add-int/2addr v8, v6

    .line 1818
    .local v8, "max2":I
    if-ge v8, v7, :cond_3

    .line 1819
    move v7, v8

    .line 1823
    .end local v8    # "max2":I
    :cond_3
    :goto_2
    if-ge v6, v7, :cond_e

    .line 1824
    iget-object v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    add-int/lit8 v9, v6, 0x1

    .end local v6    # "ptr":I
    .local v9, "ptr":I
    aget-byte v6, v8, v6

    and-int/lit16 v6, v6, 0xff

    .line 1825
    .local v6, "c":I
    aget v8, v3, v6

    if-eqz v8, :cond_c

    .line 1826
    iput v9, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1827
    nop

    .line 1836
    .end local v7    # "max":I
    .end local v9    # "ptr":I
    aget v7, v3, v6

    packed-switch v7, :pswitch_data_0

    goto/16 :goto_3

    .line 1900
    :pswitch_0
    if-nez v4, :cond_a

    if-nez v5, :cond_a

    .line 1901
    nop

    .line 1913
    .end local v6    # "c":I
    if-eqz v1, :cond_4

    .line 1914
    iget-object v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v6, v2}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 1918
    :cond_4
    const/4 v6, 0x0

    invoke-virtual {p0, v6, v0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->skipInternalWs(ZLjava/lang/String;)B

    move-result v0

    .line 1919
    .local v0, "b":B
    const/16 v6, 0x3e

    if-eq v0, v6, :cond_5

    .line 1920
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeCharForError(B)I

    move-result v6

    const-string v7, " expected \'>\' after the internal subset"

    invoke-virtual {p0, v6, v7}, Lcom/fasterxml/aalto/in/Utf8Scanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1922
    :cond_5
    return-void

    .line 1895
    .end local v0    # "b":B
    .restart local v6    # "c":I
    :pswitch_1
    if-nez v5, :cond_a

    .line 1896
    const/4 v4, 0x0

    goto/16 :goto_3

    .line 1890
    :pswitch_2
    if-nez v4, :cond_a

    .line 1891
    const/4 v4, 0x1

    goto :goto_3

    .line 1862
    :pswitch_3
    invoke-direct {p0, v6}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_4(I)I

    move-result v6

    .line 1863
    if-eqz v1, :cond_a

    .line 1865
    add-int/lit8 v7, v2, 0x1

    .end local v2    # "outPtr":I
    .local v7, "outPtr":I
    shr-int/lit8 v8, v6, 0xa

    const v9, 0xd800

    or-int/2addr v8, v9

    int-to-char v8, v8

    aput-char v8, v1, v2

    .line 1866
    and-int/lit16 v2, v6, 0x3ff

    const v8, 0xdc00

    or-int v6, v2, v8

    .line 1867
    array-length v2, v1

    if-lt v7, v2, :cond_6

    .line 1868
    iget-object v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v1

    .line 1869
    const/4 v2, 0x0

    .end local v7    # "outPtr":I
    .restart local v2    # "outPtr":I
    goto :goto_3

    .line 1867
    .end local v2    # "outPtr":I
    .restart local v7    # "outPtr":I
    :cond_6
    move v2, v7

    goto :goto_3

    .line 1859
    .end local v7    # "outPtr":I
    .restart local v2    # "outPtr":I
    :pswitch_4
    invoke-direct {p0, v6}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_3(I)I

    move-result v6

    .line 1860
    goto :goto_3

    .line 1856
    :pswitch_5
    invoke-direct {p0, v6}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_2(I)I

    move-result v6

    .line 1857
    goto :goto_3

    .line 1875
    :pswitch_6
    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidInitial(I)V

    .line 1880
    :pswitch_7
    if-nez v5, :cond_7

    .line 1881
    move v5, v6

    goto :goto_3

    .line 1883
    :cond_7
    if-ne v5, v6, :cond_a

    .line 1884
    const/4 v5, 0x0

    goto :goto_3

    .line 1853
    :pswitch_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 1854
    goto :goto_3

    .line 1841
    :pswitch_9
    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleInvalidXmlChar(I)C

    move-result v6

    .line 1843
    :pswitch_a
    iget v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v7, v8, :cond_8

    .line 1844
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1846
    :cond_8
    iget-object v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v7, v7, v8

    const/16 v8, 0xa

    if-ne v7, v8, :cond_9

    .line 1847
    iget v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v7, v7, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1849
    :cond_9
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 1850
    const/16 v6, 0xa

    .line 1851
    nop

    .line 1909
    :cond_a
    :goto_3
    if-eqz v1, :cond_b

    .line 1910
    add-int/lit8 v7, v2, 0x1

    .end local v2    # "outPtr":I
    .restart local v7    # "outPtr":I
    int-to-char v8, v6

    aput-char v8, v1, v2

    move v2, v7

    .line 1912
    .end local v6    # "c":I
    .end local v7    # "outPtr":I
    .restart local v2    # "outPtr":I
    :cond_b
    goto/16 :goto_1

    .line 1829
    .restart local v6    # "c":I
    .local v7, "max":I
    .restart local v9    # "ptr":I
    :cond_c
    if-eqz v1, :cond_d

    .line 1830
    add-int/lit8 v8, v2, 0x1

    .end local v2    # "outPtr":I
    .local v8, "outPtr":I
    int-to-char v10, v6

    aput-char v10, v1, v2

    move v2, v8

    move v6, v9

    goto/16 :goto_2

    .line 1829
    .end local v8    # "outPtr":I
    .restart local v2    # "outPtr":I
    :cond_d
    move v6, v9

    goto/16 :goto_2

    .line 1833
    .end local v9    # "ptr":I
    .local v6, "ptr":I
    :cond_e
    iput v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1834
    .end local v6    # "ptr":I
    .end local v7    # "max":I
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

.method protected final finishPI()V
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1927
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 1928
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    .line 1929
    .local v1, "inputBuffer":[B
    iget-object v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v2

    .line 1930
    .local v2, "outputBuffer":[C
    const/4 v3, 0x0

    .line 1941
    .local v3, "outPtr":I
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1942
    .local v4, "ptr":I
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v4, v5, :cond_0

    .line 1943
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1944
    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1946
    :cond_0
    array-length v5, v2

    if-lt v3, v5, :cond_1

    .line 1947
    iget-object v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v5}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 1948
    const/4 v3, 0x0

    .line 1950
    :cond_1
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    .line 1952
    .local v5, "max":I
    array-length v6, v2

    sub-int/2addr v6, v3

    add-int/2addr v6, v4

    .line 1953
    .local v6, "max2":I
    if-ge v6, v5, :cond_2

    .line 1954
    move v5, v6

    .line 1957
    .end local v6    # "max2":I
    :cond_2
    :goto_1
    if-ge v4, v5, :cond_9

    .line 1958
    add-int/lit8 v6, v4, 0x1

    .end local v4    # "ptr":I
    .local v6, "ptr":I
    aget-byte v4, v1, v4

    and-int/lit16 v4, v4, 0xff

    .line 1959
    .local v4, "c":I
    aget v7, v0, v4

    if-eqz v7, :cond_8

    .line 1960
    iput v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1961
    nop

    .line 1968
    .end local v5    # "max":I
    .end local v6    # "ptr":I
    aget v5, v0, v4

    packed-switch v5, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_3

    .line 1991
    :pswitch_1
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_4(I)I

    move-result v4

    .line 1993
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .local v5, "outPtr":I
    shr-int/lit8 v6, v4, 0xa

    const v7, 0xd800

    or-int/2addr v6, v7

    int-to-char v6, v6

    aput-char v6, v2, v3

    .line 1994
    array-length v3, v2

    if-lt v5, v3, :cond_3

    .line 1995
    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 1996
    const/4 v3, 0x0

    .end local v5    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_2

    .line 1994
    .end local v3    # "outPtr":I
    .restart local v5    # "outPtr":I
    :cond_3
    move v3, v5

    .line 1998
    .end local v5    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_2
    and-int/lit16 v5, v4, 0x3ff

    const v6, 0xdc00

    or-int v4, v5, v6

    .line 2000
    goto :goto_3

    .line 1988
    :pswitch_2
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_3(I)I

    move-result v4

    .line 1989
    goto :goto_3

    .line 1985
    :pswitch_3
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_2(I)I

    move-result v4

    .line 1986
    goto :goto_3

    .line 2002
    :pswitch_4
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidInitial(I)V

    .line 2004
    :pswitch_5
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v5, v6, :cond_4

    .line 2005
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 2007
    :cond_4
    iget-object v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v5, v5, v6

    const/16 v6, 0x3e

    if-ne v5, v6, :cond_7

    .line 2008
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v5, v5, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2009
    nop

    .line 2018
    .end local v4    # "c":I
    iget-object v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 2019
    return-void

    .line 1982
    .restart local v4    # "c":I
    :pswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 1983
    goto :goto_3

    .line 1970
    :pswitch_7
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleInvalidXmlChar(I)C

    move-result v4

    .line 1972
    :pswitch_8
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v5, v6, :cond_5

    .line 1973
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1975
    :cond_5
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v5, v1, v5

    const/16 v6, 0xa

    if-ne v5, v6, :cond_6

    .line 1976
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v5, v5, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1978
    :cond_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 1979
    const/16 v4, 0xa

    .line 1980
    nop

    .line 2016
    :cond_7
    :goto_3
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .restart local v5    # "outPtr":I
    int-to-char v6, v4

    aput-char v6, v2, v3

    .line 2017
    .end local v4    # "c":I
    move v3, v5

    goto/16 :goto_0

    .line 1963
    .restart local v3    # "outPtr":I
    .restart local v4    # "c":I
    .local v5, "max":I
    .restart local v6    # "ptr":I
    :cond_8
    add-int/lit8 v7, v3, 0x1

    .end local v3    # "outPtr":I
    .local v7, "outPtr":I
    int-to-char v8, v4

    aput-char v8, v2, v3

    move v4, v6

    move v3, v7

    goto/16 :goto_1

    .line 1965
    .end local v6    # "ptr":I
    .end local v7    # "outPtr":I
    .restart local v3    # "outPtr":I
    .local v4, "ptr":I
    :cond_9
    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1966
    .end local v4    # "ptr":I
    .end local v5    # "max":I
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

.method protected final finishSpace()V
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2032
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_tmpChar:I

    .line 2036
    .local v0, "tmp":I
    const/16 v1, 0xa

    const/16 v2, 0xd

    if-eq v0, v2, :cond_1

    if-ne v0, v1, :cond_0

    goto :goto_0

    .line 2044
    :cond_0
    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v3

    .line 2045
    .local v3, "outputBuffer":[C
    const/4 v4, 0x0

    int-to-char v5, v0

    aput-char v5, v3, v4

    .line 2046
    const/4 v4, 0x1

    .local v4, "outPtr":I
    goto :goto_1

    .line 2037
    .end local v3    # "outputBuffer":[C
    .end local v4    # "outPtr":I
    :cond_1
    :goto_0
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->checkPrologIndentation(I)I

    move-result v4

    .line 2038
    .restart local v4    # "outPtr":I
    if-gez v4, :cond_2

    .line 2039
    return-void

    .line 2042
    :cond_2
    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v3

    .line 2049
    .restart local v3    # "outputBuffer":[C
    :goto_1
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2052
    .local v5, "ptr":I
    :goto_2
    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v5, v6, :cond_4

    .line 2053
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMore()Z

    move-result v6

    if-nez v6, :cond_3

    .line 2054
    goto :goto_3

    .line 2056
    :cond_3
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2058
    :cond_4
    iget-object v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    aget-byte v6, v6, v5

    and-int/lit16 v6, v6, 0xff

    .line 2060
    .local v6, "c":I
    const/16 v7, 0x20

    if-le v6, v7, :cond_5

    .line 2061
    goto :goto_3

    .line 2063
    :cond_5
    add-int/lit8 v5, v5, 0x1

    .line 2065
    if-ne v6, v1, :cond_6

    .line 2066
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF(I)V

    goto :goto_4

    .line 2067
    :cond_6
    if-ne v6, v2, :cond_b

    .line 2068
    iget v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v5, v7, :cond_9

    .line 2069
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMore()Z

    move-result v7

    if-nez v7, :cond_8

    .line 2070
    array-length v2, v3

    if-lt v4, v2, :cond_7

    .line 2071
    iget-object v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2072
    .end local v3    # "outputBuffer":[C
    .local v2, "outputBuffer":[C
    const/4 v4, 0x0

    move-object v3, v2

    .line 2074
    .end local v2    # "outputBuffer":[C
    .restart local v3    # "outputBuffer":[C
    :cond_7
    add-int/lit8 v2, v4, 0x1

    .end local v4    # "outPtr":I
    .local v2, "outPtr":I
    aput-char v1, v3, v4

    .line 2075
    move v4, v2

    .line 2097
    .end local v2    # "outPtr":I
    .end local v6    # "c":I
    .restart local v4    # "outPtr":I
    :goto_3
    iput v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2098
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1, v4}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 2099
    return-void

    .line 2077
    .restart local v6    # "c":I
    :cond_8
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2079
    :cond_9
    iget-object v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    aget-byte v7, v7, v5

    if-ne v7, v1, :cond_a

    .line 2080
    add-int/lit8 v5, v5, 0x1

    .line 2082
    :cond_a
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF(I)V

    .line 2083
    const/16 v6, 0xa

    goto :goto_4

    .line 2084
    :cond_b
    if-eq v6, v7, :cond_c

    const/16 v7, 0x9

    if-eq v6, v7, :cond_c

    .line 2085
    iput v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2086
    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/in/Utf8Scanner;->throwInvalidSpace(I)V

    .line 2090
    :cond_c
    :goto_4
    array-length v7, v3

    if-lt v4, v7, :cond_d

    .line 2091
    iget-object v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v7}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v3

    .line 2092
    const/4 v4, 0x0

    .line 2094
    :cond_d
    add-int/lit8 v7, v4, 0x1

    .end local v4    # "outPtr":I
    .local v7, "outPtr":I
    int-to-char v8, v6

    aput-char v8, v3, v4

    .line 2095
    .end local v6    # "c":I
    move v4, v7

    goto :goto_2
.end method

.method protected final finishToken()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 56
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_tokenIncomplete:Z

    .line 57
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_currToken:I

    packed-switch v0, :pswitch_data_0

    .line 77
    :pswitch_0
    invoke-static {}, Lcom/fasterxml/aalto/impl/ErrorConsts;->throwInternalError()V

    goto :goto_0

    .line 74
    :pswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->finishCData()V

    .line 75
    goto :goto_0

    .line 71
    :pswitch_2
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->finishDTD(Z)V

    .line 72
    goto :goto_0

    .line 68
    :pswitch_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->finishSpace()V

    .line 69
    goto :goto_0

    .line 65
    :pswitch_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->finishComment()V

    .line 66
    goto :goto_0

    .line 62
    :pswitch_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->finishCharacters()V

    .line 63
    goto :goto_0

    .line 59
    :pswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->finishPI()V

    .line 60
    nop

    .line 79
    :goto_0
    return-void

    :pswitch_data_0
    .packed-switch 0x3
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method protected final handleEntityInText(Z)I
    .locals 11
    .param p1, "inAttr"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 496
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 497
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 499
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 500
    .local v0, "b":B
    const/16 v1, 0x23

    if-ne v0, v1, :cond_1

    .line 501
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleCharEntity()I

    move-result v1

    return v1

    .line 504
    :cond_1
    const/16 v1, 0x61

    const/16 v2, 0x6f

    const/16 v3, 0x3b

    if-ne v0, v1, :cond_f

    .line 505
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-ge v1, v4, :cond_2

    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v1, v1, v4

    goto :goto_0

    :cond_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadOne()B

    move-result v1

    :goto_0
    move v0, v1

    .line 506
    const/16 v1, 0x6d

    const/16 v4, 0x70

    if-ne v0, v1, :cond_7

    .line 507
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-ge v1, v2, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v5, v2, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v1, v1, v2

    goto :goto_1

    :cond_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadOne()B

    move-result v1

    :goto_1
    move v0, v1

    .line 508
    if-ne v0, v4, :cond_6

    .line 509
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-ge v1, v2, :cond_4

    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v1, v1, v2

    goto :goto_2

    :cond_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadOne()B

    move-result v1

    :goto_2
    move v0, v1

    .line 510
    if-ne v0, v3, :cond_5

    .line 511
    const/16 v1, 0x26

    return v1

    .line 513
    :cond_5
    const-string v1, "amp"

    .local v1, "start":Ljava/lang/String;
    goto/16 :goto_e

    .line 515
    .end local v1    # "start":Ljava/lang/String;
    :cond_6
    const-string v1, "am"

    .restart local v1    # "start":Ljava/lang/String;
    goto/16 :goto_e

    .line 517
    .end local v1    # "start":Ljava/lang/String;
    :cond_7
    if-ne v0, v4, :cond_e

    .line 518
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-ge v1, v4, :cond_8

    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v1, v1, v4

    goto :goto_3

    :cond_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadOne()B

    move-result v1

    :goto_3
    move v0, v1

    .line 519
    if-ne v0, v2, :cond_d

    .line 520
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-ge v1, v2, :cond_9

    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v1, v1, v2

    goto :goto_4

    :cond_9
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadOne()B

    move-result v1

    :goto_4
    move v0, v1

    .line 521
    const/16 v1, 0x73

    if-ne v0, v1, :cond_c

    .line 522
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-ge v1, v2, :cond_a

    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v1, v1, v2

    goto :goto_5

    :cond_a
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadOne()B

    move-result v1

    :goto_5
    move v0, v1

    .line 523
    if-ne v0, v3, :cond_b

    .line 524
    const/16 v1, 0x27

    return v1

    .line 526
    :cond_b
    const-string v1, "apos"

    .restart local v1    # "start":Ljava/lang/String;
    goto/16 :goto_e

    .line 528
    .end local v1    # "start":Ljava/lang/String;
    :cond_c
    const-string v1, "apo"

    .restart local v1    # "start":Ljava/lang/String;
    goto/16 :goto_e

    .line 531
    .end local v1    # "start":Ljava/lang/String;
    :cond_d
    const-string v1, "ap"

    .restart local v1    # "start":Ljava/lang/String;
    goto/16 :goto_e

    .line 534
    .end local v1    # "start":Ljava/lang/String;
    :cond_e
    const-string v1, "a"

    .restart local v1    # "start":Ljava/lang/String;
    goto/16 :goto_e

    .line 536
    .end local v1    # "start":Ljava/lang/String;
    :cond_f
    const/16 v1, 0x6c

    const/16 v4, 0x74

    if-ne v0, v1, :cond_14

    .line 537
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-ge v1, v2, :cond_10

    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v5, v2, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v1, v1, v2

    goto :goto_6

    :cond_10
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadOne()B

    move-result v1

    :goto_6
    move v0, v1

    .line 538
    if-ne v0, v4, :cond_13

    .line 539
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-ge v1, v2, :cond_11

    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v1, v1, v2

    goto :goto_7

    :cond_11
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadOne()B

    move-result v1

    :goto_7
    move v0, v1

    .line 540
    if-ne v0, v3, :cond_12

    .line 541
    const/16 v1, 0x3c

    return v1

    .line 543
    :cond_12
    const-string v1, "lt"

    .restart local v1    # "start":Ljava/lang/String;
    goto/16 :goto_e

    .line 545
    .end local v1    # "start":Ljava/lang/String;
    :cond_13
    const-string v1, "l"

    .restart local v1    # "start":Ljava/lang/String;
    goto/16 :goto_e

    .line 547
    .end local v1    # "start":Ljava/lang/String;
    :cond_14
    const/16 v1, 0x67

    if-ne v0, v1, :cond_19

    .line 548
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-ge v1, v2, :cond_15

    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v5, v2, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v1, v1, v2

    goto :goto_8

    :cond_15
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadOne()B

    move-result v1

    :goto_8
    move v0, v1

    .line 549
    if-ne v0, v4, :cond_18

    .line 550
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-ge v1, v2, :cond_16

    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v1, v1, v2

    goto :goto_9

    :cond_16
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadOne()B

    move-result v1

    :goto_9
    move v0, v1

    .line 551
    if-ne v0, v3, :cond_17

    .line 552
    const/16 v1, 0x3e

    return v1

    .line 554
    :cond_17
    const-string v1, "gt"

    .restart local v1    # "start":Ljava/lang/String;
    goto/16 :goto_e

    .line 556
    .end local v1    # "start":Ljava/lang/String;
    :cond_18
    const-string v1, "g"

    .restart local v1    # "start":Ljava/lang/String;
    goto/16 :goto_e

    .line 558
    .end local v1    # "start":Ljava/lang/String;
    :cond_19
    const/16 v1, 0x71

    if-ne v0, v1, :cond_22

    .line 559
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-ge v1, v5, :cond_1a

    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v1, v1, v5

    goto :goto_a

    :cond_1a
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadOne()B

    move-result v1

    :goto_a
    move v0, v1

    .line 560
    const/16 v1, 0x75

    if-ne v0, v1, :cond_21

    .line 561
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-ge v1, v5, :cond_1b

    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v1, v1, v5

    goto :goto_b

    :cond_1b
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadOne()B

    move-result v1

    :goto_b
    move v0, v1

    .line 562
    if-ne v0, v2, :cond_20

    .line 563
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-ge v1, v2, :cond_1c

    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v5, v2, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v1, v1, v2

    goto :goto_c

    :cond_1c
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadOne()B

    move-result v1

    :goto_c
    move v0, v1

    .line 564
    if-ne v0, v4, :cond_1f

    .line 565
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-ge v1, v2, :cond_1d

    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v1, v1, v2

    goto :goto_d

    :cond_1d
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadOne()B

    move-result v1

    :goto_d
    move v0, v1

    .line 566
    if-ne v0, v3, :cond_1e

    .line 567
    const/16 v1, 0x22

    return v1

    .line 569
    :cond_1e
    const-string v1, "quot"

    .restart local v1    # "start":Ljava/lang/String;
    goto :goto_e

    .line 571
    .end local v1    # "start":Ljava/lang/String;
    :cond_1f
    const-string v1, "quo"

    .restart local v1    # "start":Ljava/lang/String;
    goto :goto_e

    .line 574
    .end local v1    # "start":Ljava/lang/String;
    :cond_20
    const-string v1, "qu"

    .restart local v1    # "start":Ljava/lang/String;
    goto :goto_e

    .line 577
    .end local v1    # "start":Ljava/lang/String;
    :cond_21
    const-string v1, "q"

    .restart local v1    # "start":Ljava/lang/String;
    goto :goto_e

    .line 580
    .end local v1    # "start":Ljava/lang/String;
    :cond_22
    const-string v1, ""

    .line 583
    .restart local v1    # "start":Ljava/lang/String;
    :goto_e
    iget-object v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v2, v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->NAME_CHARS:[I

    .line 588
    .local v2, "TYPES":[I
    iget-object v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_nameBuffer:[C

    .line 589
    .local v4, "cbuf":[C
    const/4 v5, 0x0

    .line 590
    .local v5, "cix":I
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v6

    .local v6, "len":I
    :goto_f
    if-ge v5, v6, :cond_23

    .line 591
    invoke-virtual {v1, v5}, Ljava/lang/String;->charAt(I)C

    move-result v7

    aput-char v7, v4, v5

    .line 590
    add-int/lit8 v5, v5, 0x1

    goto :goto_f

    .line 594
    .end local v6    # "len":I
    :cond_23
    :goto_10
    const/4 v6, 0x0

    if-eq v0, v3, :cond_2a

    .line 596
    and-int/lit16 v7, v0, 0xff

    .line 599
    .local v7, "c":I
    aget v8, v2, v7

    packed-switch v8, :pswitch_data_0

    .line 631
    :pswitch_0
    const/4 v6, 0x0

    .local v6, "ok":Z
    goto :goto_11

    .line 617
    .end local v6    # "ok":Z
    :pswitch_1
    invoke-direct {p0, v7}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_4(I)I

    move-result v7

    .line 618
    invoke-static {v7}, Lcom/fasterxml/aalto/util/XmlChars;->is10NameStartChar(I)Z

    move-result v6

    .line 619
    .restart local v6    # "ok":Z
    if-eqz v6, :cond_26

    .line 620
    array-length v8, v4

    if-lt v5, v8, :cond_24

    .line 621
    array-length v8, v4

    invoke-static {v4, v8}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v8

    move-object v4, v8

    iput-object v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_nameBuffer:[C

    .line 624
    :cond_24
    const/high16 v8, 0x10000

    sub-int/2addr v7, v8

    .line 625
    add-int/lit8 v8, v5, 0x1

    .end local v5    # "cix":I
    .local v8, "cix":I
    shr-int/lit8 v9, v7, 0xa

    const v10, 0xd800

    or-int/2addr v9, v10

    int-to-char v9, v9

    aput-char v9, v4, v5

    .line 626
    and-int/lit16 v5, v7, 0x3ff

    const v9, 0xdc00

    or-int v7, v5, v9

    move v5, v8

    goto :goto_11

    .line 613
    .end local v6    # "ok":Z
    .end local v8    # "cix":I
    .restart local v5    # "cix":I
    :pswitch_2
    invoke-direct {p0, v7}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_3(I)I

    move-result v7

    .line 614
    invoke-static {v7}, Lcom/fasterxml/aalto/util/XmlChars;->is10NameStartChar(I)Z

    move-result v6

    .line 615
    .restart local v6    # "ok":Z
    goto :goto_11

    .line 609
    .end local v6    # "ok":Z
    :pswitch_3
    invoke-direct {p0, v7}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_2(I)I

    move-result v7

    .line 610
    invoke-static {v7}, Lcom/fasterxml/aalto/util/XmlChars;->is10NameStartChar(I)Z

    move-result v6

    .line 611
    .restart local v6    # "ok":Z
    goto :goto_11

    .line 606
    .end local v6    # "ok":Z
    :pswitch_4
    const/4 v6, 0x1

    .line 607
    .restart local v6    # "ok":Z
    goto :goto_11

    .line 603
    .end local v6    # "ok":Z
    :pswitch_5
    if-lez v5, :cond_25

    const/4 v6, 0x1

    .line 604
    .restart local v6    # "ok":Z
    :cond_25
    nop

    .line 634
    :cond_26
    :goto_11
    if-nez v6, :cond_27

    .line 635
    invoke-virtual {p0, v7, v5}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidNameChar(II)V

    .line 637
    :cond_27
    array-length v8, v4

    if-lt v5, v8, :cond_28

    .line 638
    array-length v8, v4

    invoke-static {v4, v8}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v8

    move-object v4, v8

    iput-object v8, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_nameBuffer:[C

    .line 640
    :cond_28
    add-int/lit8 v8, v5, 0x1

    .end local v5    # "cix":I
    .restart local v8    # "cix":I
    int-to-char v9, v7

    aput-char v9, v4, v5

    .line 641
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v5, v9, :cond_29

    .line 642
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 644
    :cond_29
    iget-object v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v9, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v10, v9, 0x1

    iput v10, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v0, v5, v9

    .line 645
    .end local v6    # "ok":Z
    .end local v7    # "c":I
    move v5, v8

    goto :goto_10

    .line 648
    .end local v8    # "cix":I
    .restart local v5    # "cix":I
    :cond_2a
    new-instance v3, Ljava/lang/String;

    invoke-direct {v3, v4, v6, v5}, Ljava/lang/String;-><init>([CII)V

    .line 650
    .local v3, "pname":Ljava/lang/String;
    new-instance v7, Lcom/fasterxml/aalto/in/PNameC;

    const/4 v8, 0x0

    invoke-direct {v7, v3, v8, v3, v6}, Lcom/fasterxml/aalto/in/PNameC;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    iput-object v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 655
    iget-object v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v7}, Lcom/fasterxml/aalto/in/ReaderConfig;->willExpandEntities()Z

    move-result v7

    const-string v8, "General entity reference (&"

    if-eqz v7, :cond_2b

    .line 656
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v9, ";) encountered in entity expanding mode: operation not (yet) implemented"

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p0, v7}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInputProblem(Ljava/lang/String;)V

    .line 658
    :cond_2b
    if-eqz p1, :cond_2c

    .line 659
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ";) encountered in attribute value, in non-entity-expanding mode: no way to handle it"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p0, v7}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInputProblem(Ljava/lang/String;)V

    .line 661
    :cond_2c
    return v6

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_5
        :pswitch_5
        :pswitch_5
        :pswitch_4
        :pswitch_0
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method protected handleStartElement(B)I
    .locals 16
    .param p1, "b"    # B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 85
    move-object/from16 v0, p0

    const/4 v1, 0x1

    iput v1, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_currToken:I

    .line 86
    const/4 v2, 0x0

    iput v2, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_currNsCount:I

    .line 87
    invoke-virtual/range {p0 .. p1}, Lcom/fasterxml/aalto/in/Utf8Scanner;->parsePName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v3

    .line 93
    .local v3, "elemName":Lcom/fasterxml/aalto/in/PName;
    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/PName;->getPrefix()Ljava/lang/String;

    move-result-object v4

    .line 96
    .local v4, "prefix":Ljava/lang/String;
    if-nez v4, :cond_0

    .line 97
    const/4 v5, 0x1

    .local v5, "allBound":Z
    goto :goto_0

    .line 99
    .end local v5    # "allBound":Z
    :cond_0
    invoke-virtual {v0, v3, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->bindName(Lcom/fasterxml/aalto/in/PName;Ljava/lang/String;)Lcom/fasterxml/aalto/in/PName;

    move-result-object v3

    .line 100
    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/PName;->isBound()Z

    move-result v5

    .line 103
    .restart local v5    # "allBound":Z
    :goto_0
    iput-object v3, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 104
    new-instance v6, Lcom/fasterxml/aalto/in/ElementScope;

    iget-object v7, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_currElem:Lcom/fasterxml/aalto/in/ElementScope;

    invoke-direct {v6, v3, v7}, Lcom/fasterxml/aalto/in/ElementScope;-><init>(Lcom/fasterxml/aalto/in/PName;Lcom/fasterxml/aalto/in/ElementScope;)V

    iput-object v6, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_currElem:Lcom/fasterxml/aalto/in/ElementScope;

    .line 107
    const/4 v6, 0x0

    move v7, v6

    move v6, v5

    move-object v5, v4

    move/from16 v4, p1

    .line 110
    .end local p1    # "b":B
    .local v4, "b":B
    .local v5, "prefix":Ljava/lang/String;
    .local v6, "allBound":Z
    .local v7, "attrPtr":I
    :goto_1
    iget v8, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v9, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v8, v9, :cond_1

    .line 111
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 113
    :cond_1
    iget-object v8, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v9, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v10, v9, 0x1

    iput v10, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v4, v8, v9

    .line 114
    and-int/lit16 v8, v4, 0xff

    .line 116
    .local v8, "c":I
    const/16 v9, 0x2f

    const/16 v10, 0x9

    const/16 v11, 0x3e

    const/16 v12, 0xd

    const/16 v13, 0xa

    const/16 v14, 0x20

    if-gt v8, v14, :cond_9

    .line 118
    :goto_2
    if-ne v8, v13, :cond_2

    .line 119
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    goto :goto_3

    .line 120
    :cond_2
    if-ne v8, v12, :cond_5

    .line 121
    iget v15, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v12, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v15, v12, :cond_3

    .line 122
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 124
    :cond_3
    iget-object v12, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v15, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v12, v12, v15

    if-ne v12, v13, :cond_4

    .line 125
    iget v12, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/2addr v12, v1

    iput v12, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 127
    :cond_4
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    goto :goto_3

    .line 128
    :cond_5
    if-eq v8, v14, :cond_6

    if-eq v8, v10, :cond_6

    .line 129
    invoke-virtual {v0, v8}, Lcom/fasterxml/aalto/in/Utf8Scanner;->throwInvalidSpace(I)V

    .line 131
    :cond_6
    :goto_3
    iget v12, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v15, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v12, v15, :cond_7

    .line 132
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 134
    :cond_7
    iget-object v12, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v15, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v10, v15, 0x1

    iput v10, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v4, v12, v15

    .line 135
    and-int/lit16 v8, v4, 0xff

    .line 136
    if-le v8, v14, :cond_8

    goto :goto_4

    :cond_8
    const/16 v10, 0x9

    const/16 v12, 0xd

    goto :goto_2

    .line 137
    :cond_9
    if-eq v8, v9, :cond_a

    if-eq v8, v11, :cond_a

    .line 138
    invoke-virtual {v0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeCharForError(B)I

    move-result v8

    .line 139
    const-string v10, " expected space, or \'>\' or \"/>\""

    invoke-virtual {v0, v8, v10}, Lcom/fasterxml/aalto/in/Utf8Scanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 143
    :cond_a
    :goto_4
    if-ne v8, v9, :cond_d

    .line 144
    iget v9, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v10, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v9, v10, :cond_b

    .line 145
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 147
    :cond_b
    iget-object v9, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v10, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v12, v10, 0x1

    iput v12, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v4, v9, v10

    .line 148
    if-eq v4, v11, :cond_c

    .line 149
    invoke-virtual {v0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeCharForError(B)I

    move-result v8

    .line 150
    const-string v9, " expected \'>\'"

    invoke-virtual {v0, v8, v9}, Lcom/fasterxml/aalto/in/Utf8Scanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 152
    :cond_c
    iput-boolean v1, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_isEmptyTag:Z

    .line 153
    goto :goto_5

    .line 154
    :cond_d
    if-ne v8, v11, :cond_12

    .line 155
    iput-boolean v2, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_isEmptyTag:Z

    .line 156
    nop

    .line 255
    .end local v8    # "c":I
    :goto_5
    iget-object v8, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v8, v7}, Lcom/fasterxml/aalto/in/AttributeCollector;->finishLastValue(I)I

    move-result v8

    .line 256
    .local v8, "act":I
    if-gez v8, :cond_e

    .line 257
    iget-object v9, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v9}, Lcom/fasterxml/aalto/in/AttributeCollector;->getCount()I

    move-result v8

    .line 258
    iget-object v9, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v9}, Lcom/fasterxml/aalto/in/AttributeCollector;->getErrorMsg()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v0, v9}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInputProblem(Ljava/lang/String;)V

    .line 260
    :cond_e
    iput v8, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_attrCount:I

    .line 262
    .end local v8    # "act":I
    iget v8, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_depth:I

    add-int/2addr v8, v1

    iput v8, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_depth:I

    .line 268
    if-nez v6, :cond_11

    .line 269
    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/PName;->isBound()Z

    move-result v8

    if-nez v8, :cond_f

    .line 270
    iget-object v8, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v0, v8, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportUnboundPrefix(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 272
    :cond_f
    const/4 v2, 0x0

    .local v2, "i":I
    iget v8, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_attrCount:I

    .local v8, "len":I
    :goto_6
    if-ge v2, v8, :cond_11

    .line 273
    iget-object v9, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v9, v2}, Lcom/fasterxml/aalto/in/AttributeCollector;->getName(I)Lcom/fasterxml/aalto/in/PName;

    move-result-object v9

    .line 274
    .local v9, "attrName":Lcom/fasterxml/aalto/in/PName;
    invoke-virtual {v9}, Lcom/fasterxml/aalto/in/PName;->isBound()Z

    move-result v10

    if-nez v10, :cond_10

    .line 275
    invoke-virtual {v0, v9, v1}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportUnboundPrefix(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 272
    .end local v9    # "attrName":Lcom/fasterxml/aalto/in/PName;
    :cond_10
    add-int/lit8 v2, v2, 0x1

    goto :goto_6

    .line 279
    .end local v2    # "i":I
    .end local v8    # "len":I
    :cond_11
    return v1

    .line 157
    .local v8, "c":I
    :cond_12
    const/16 v9, 0x3c

    if-ne v8, v9, :cond_13

    .line 158
    const-string v9, "Unexpected \'<\' character in element (missing closing \'>\'?)"

    invoke-virtual {v0, v9}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInputProblem(Ljava/lang/String;)V

    .line 162
    :cond_13
    invoke-virtual {v0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->parsePName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v9

    .line 163
    .restart local v9    # "attrName":Lcom/fasterxml/aalto/in/PName;
    invoke-virtual {v9}, Lcom/fasterxml/aalto/in/PName;->getPrefix()Ljava/lang/String;

    move-result-object v5

    .line 167
    const-string/jumbo v10, "xmlns"

    if-nez v5, :cond_15

    .line 168
    invoke-virtual {v9}, Lcom/fasterxml/aalto/in/PName;->getLocalName()Ljava/lang/String;

    move-result-object v11

    if-ne v11, v10, :cond_14

    move v10, v1

    goto :goto_7

    :cond_14
    move v10, v2

    .local v10, "isNsDecl":Z
    :goto_7
    goto :goto_8

    .line 171
    .end local v10    # "isNsDecl":Z
    :cond_15
    if-ne v5, v10, :cond_16

    .line 172
    const/4 v10, 0x1

    .restart local v10    # "isNsDecl":Z
    goto :goto_8

    .line 174
    .end local v10    # "isNsDecl":Z
    :cond_16
    invoke-virtual {v0, v9, v5}, Lcom/fasterxml/aalto/in/Utf8Scanner;->bindName(Lcom/fasterxml/aalto/in/PName;Ljava/lang/String;)Lcom/fasterxml/aalto/in/PName;

    move-result-object v9

    .line 175
    if-eqz v6, :cond_17

    .line 176
    invoke-virtual {v9}, Lcom/fasterxml/aalto/in/PName;->isBound()Z

    move-result v6

    .line 178
    :cond_17
    const/4 v10, 0x0

    .line 184
    .restart local v10    # "isNsDecl":Z
    :cond_18
    :goto_8
    iget v11, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v12, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v11, v12, :cond_19

    .line 185
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 187
    :cond_19
    iget-object v11, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v12, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v15, v12, 0x1

    iput v15, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v4, v11, v12

    .line 188
    and-int/lit16 v8, v4, 0xff

    .line 189
    if-le v8, v14, :cond_23

    .line 190
    nop

    .line 207
    const/16 v11, 0x3d

    if-eq v8, v11, :cond_1a

    .line 208
    invoke-virtual {v0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeCharForError(B)I

    move-result v8

    .line 209
    const-string v11, " expected \'=\'"

    invoke-virtual {v0, v8, v11}, Lcom/fasterxml/aalto/in/Utf8Scanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 214
    :cond_1a
    :goto_9
    iget v11, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v12, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v11, v12, :cond_1b

    .line 215
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 217
    :cond_1b
    iget-object v11, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v12, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v15, v12, 0x1

    iput v15, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v4, v11, v12

    .line 218
    and-int/lit16 v8, v4, 0xff

    .line 219
    if-le v8, v14, :cond_1e

    .line 220
    nop

    .line 237
    const/16 v11, 0x22

    if-eq v8, v11, :cond_1c

    const/16 v11, 0x27

    if-eq v8, v11, :cond_1c

    .line 238
    invoke-virtual {v0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeCharForError(B)I

    move-result v8

    .line 239
    const-string v11, " Expected a quote"

    invoke-virtual {v0, v8, v11}, Lcom/fasterxml/aalto/in/Utf8Scanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 246
    :cond_1c
    if-eqz v10, :cond_1d

    .line 247
    invoke-direct {v0, v9, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleNsDeclaration(Lcom/fasterxml/aalto/in/PName;B)V

    .line 248
    iget v11, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_currNsCount:I

    add-int/2addr v11, v1

    iput v11, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_currNsCount:I

    goto :goto_a

    .line 250
    :cond_1d
    invoke-direct {v0, v7, v4, v9}, Lcom/fasterxml/aalto/in/Utf8Scanner;->collectValue(IBLcom/fasterxml/aalto/in/PName;)I

    move-result v7

    .line 252
    .end local v8    # "c":I
    .end local v9    # "attrName":Lcom/fasterxml/aalto/in/PName;
    .end local v10    # "isNsDecl":Z
    :goto_a
    goto/16 :goto_1

    .line 222
    .restart local v8    # "c":I
    .restart local v9    # "attrName":Lcom/fasterxml/aalto/in/PName;
    .restart local v10    # "isNsDecl":Z
    :cond_1e
    if-ne v8, v13, :cond_1f

    .line 223
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    goto :goto_9

    .line 224
    :cond_1f
    const/16 v11, 0xd

    if-ne v8, v11, :cond_22

    .line 225
    iget v11, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v12, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v11, v12, :cond_20

    .line 226
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 228
    :cond_20
    iget-object v11, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v12, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v11, v11, v12

    if-ne v11, v13, :cond_21

    .line 229
    iget v11, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/2addr v11, v1

    iput v11, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 231
    :cond_21
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    goto :goto_9

    .line 232
    :cond_22
    if-eq v8, v14, :cond_1a

    const/16 v11, 0x9

    if-eq v8, v11, :cond_1a

    .line 233
    invoke-virtual {v0, v8}, Lcom/fasterxml/aalto/in/Utf8Scanner;->throwInvalidSpace(I)V

    goto :goto_9

    .line 192
    :cond_23
    if-ne v8, v13, :cond_24

    .line 193
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    const/16 v11, 0xd

    const/16 v12, 0x9

    goto/16 :goto_8

    .line 194
    :cond_24
    const/16 v11, 0xd

    if-ne v8, v11, :cond_27

    .line 195
    iget v12, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v15, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v12, v15, :cond_25

    .line 196
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 198
    :cond_25
    iget-object v12, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v15, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v12, v12, v15

    if-ne v12, v13, :cond_26

    .line 199
    iget v12, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/2addr v12, v1

    iput v12, v0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 201
    :cond_26
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    const/16 v12, 0x9

    goto/16 :goto_8

    .line 202
    :cond_27
    if-eq v8, v14, :cond_28

    const/16 v12, 0x9

    if-eq v8, v12, :cond_18

    .line 203
    invoke-virtual {v0, v8}, Lcom/fasterxml/aalto/in/Utf8Scanner;->throwInvalidSpace(I)V

    goto/16 :goto_8

    .line 202
    :cond_28
    const/16 v12, 0x9

    goto/16 :goto_8
.end method

.method protected parsePublicId(B)Ljava/lang/String;
    .locals 8
    .param p1, "quoteChar"    # B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 677
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_nameBuffer:[C

    .line 678
    .local v0, "outputBuffer":[C
    const/4 v1, 0x0

    .line 679
    .local v1, "outPtr":I
    sget-object v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    .line 680
    .local v2, "TYPES":[I
    const/4 v3, 0x0

    .line 684
    .local v3, "addSpace":Z
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v4, v5, :cond_0

    .line 685
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 688
    :cond_0
    iget-object v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v4, v4, v5

    .line 689
    .local v4, "b":B
    if-ne v4, p1, :cond_1

    .line 690
    nop

    .line 716
    .end local v4    # "b":B
    new-instance v4, Ljava/lang/String;

    const/4 v5, 0x0

    invoke-direct {v4, v0, v5, v1}, Ljava/lang/String;-><init>([CII)V

    return-object v4

    .line 692
    .restart local v4    # "b":B
    :cond_1
    and-int/lit16 v5, v4, 0xff

    .line 693
    .local v5, "c":I
    aget v6, v2, v5

    const/4 v7, 0x1

    if-eq v6, v7, :cond_2

    .line 694
    const-string v6, " in public identifier"

    invoke-virtual {p0, v5, v6}, Lcom/fasterxml/aalto/in/Utf8Scanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 698
    :cond_2
    const/16 v6, 0x20

    if-gt v5, v6, :cond_3

    .line 699
    const/4 v3, 0x1

    .line 700
    goto :goto_0

    .line 702
    :cond_3
    if-eqz v3, :cond_5

    .line 703
    array-length v7, v0

    if-lt v1, v7, :cond_4

    .line 704
    array-length v7, v0

    invoke-static {v0, v7}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v7

    move-object v0, v7

    iput-object v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_nameBuffer:[C

    .line 705
    const/4 v1, 0x0

    .line 707
    :cond_4
    add-int/lit8 v7, v1, 0x1

    .end local v1    # "outPtr":I
    .local v7, "outPtr":I
    aput-char v6, v0, v1

    .line 708
    const/4 v1, 0x0

    move v3, v1

    move v1, v7

    .line 710
    .end local v7    # "outPtr":I
    .restart local v1    # "outPtr":I
    :cond_5
    array-length v6, v0

    if-lt v1, v6, :cond_6

    .line 711
    array-length v6, v0

    invoke-static {v0, v6}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v6

    move-object v0, v6

    iput-object v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_nameBuffer:[C

    .line 712
    const/4 v1, 0x0

    .line 714
    :cond_6
    add-int/lit8 v6, v1, 0x1

    .end local v1    # "outPtr":I
    .local v6, "outPtr":I
    int-to-char v7, v5

    aput-char v7, v0, v1

    .line 715
    .end local v4    # "b":B
    .end local v5    # "c":I
    move v1, v6

    goto :goto_0
.end method

.method protected parseSystemId(B)Ljava/lang/String;
    .locals 7
    .param p1, "quoteChar"    # B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 723
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_nameBuffer:[C

    .line 724
    .local v0, "outputBuffer":[C
    const/4 v1, 0x0

    .line 726
    .local v1, "outPtr":I
    iget-object v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v2, v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    .line 731
    .local v2, "TYPES":[I
    :goto_0
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v3, v4, :cond_0

    .line 732
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 734
    :cond_0
    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v3, v3, v4

    and-int/lit16 v3, v3, 0xff

    .line 735
    .local v3, "c":I
    aget v4, v2, v3

    if-eqz v4, :cond_4

    .line 736
    aget v4, v2, v3

    packed-switch v4, :pswitch_data_0

    :pswitch_0
    goto :goto_1

    .line 759
    :pswitch_1
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_4(I)I

    move-result v3

    .line 760
    array-length v4, v0

    if-lt v1, v4, :cond_1

    .line 761
    iget-object v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v0

    .line 762
    const/4 v1, 0x0

    .line 765
    :cond_1
    add-int/lit8 v4, v1, 0x1

    .end local v1    # "outPtr":I
    .local v4, "outPtr":I
    shr-int/lit8 v5, v3, 0xa

    const v6, 0xd800

    or-int/2addr v5, v6

    int-to-char v5, v5

    aput-char v5, v0, v1

    .line 766
    and-int/lit16 v1, v3, 0x3ff

    const v5, 0xdc00

    or-int v3, v1, v5

    .line 768
    move v1, v4

    goto :goto_1

    .line 756
    .end local v4    # "outPtr":I
    .restart local v1    # "outPtr":I
    :pswitch_2
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_3(I)I

    move-result v3

    .line 757
    goto :goto_1

    .line 753
    :pswitch_3
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeUtf8_2(I)I

    move-result v3

    .line 754
    goto :goto_1

    .line 770
    :pswitch_4
    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidInitial(I)V

    .line 773
    :pswitch_5
    if-ne v3, p1, :cond_4

    .line 774
    nop

    .line 786
    .end local v3    # "c":I
    new-instance v3, Ljava/lang/String;

    const/4 v4, 0x0

    invoke-direct {v3, v0, v4, v1}, Ljava/lang/String;-><init>([CII)V

    return-object v3

    .line 750
    .restart local v3    # "c":I
    :pswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 751
    goto :goto_1

    .line 738
    :pswitch_7
    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleInvalidXmlChar(I)C

    move-result v3

    .line 740
    :pswitch_8
    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v4, v5, :cond_2

    .line 741
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 743
    :cond_2
    iget-object v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v4, v4, v5

    const/16 v5, 0xa

    if-ne v4, v5, :cond_3

    .line 744
    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 746
    :cond_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 747
    const/16 v3, 0xa

    .line 748
    nop

    .line 780
    :cond_4
    :goto_1
    array-length v4, v0

    if-lt v1, v4, :cond_5

    .line 781
    array-length v4, v0

    invoke-static {v0, v4}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v4

    move-object v0, v4

    iput-object v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_nameBuffer:[C

    .line 782
    const/4 v1, 0x0

    .line 784
    :cond_5
    add-int/lit8 v4, v1, 0x1

    .end local v1    # "outPtr":I
    .restart local v4    # "outPtr":I
    int-to-char v5, v3

    aput-char v5, v0, v1

    .line 785
    .end local v3    # "c":I
    move v1, v4

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
        :pswitch_0
        :pswitch_5
    .end packed-switch
.end method

.method protected reportInvalidOther(II)V
    .locals 0
    .param p1, "mask"    # I
    .param p2, "ptr"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2737
    iput p2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2738
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidOther(I)V

    .line 2739
    return-void
.end method

.method protected final skipCData()V
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 968
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 969
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    .line 977
    .local v1, "inputBuffer":[B
    :goto_0
    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 978
    .local v2, "ptr":I
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    .line 979
    .local v3, "max":I
    if-lt v2, v3, :cond_0

    .line 980
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 981
    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 982
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    .line 984
    :cond_0
    :goto_1
    if-ge v2, v3, :cond_8

    .line 985
    add-int/lit8 v4, v2, 0x1

    .end local v2    # "ptr":I
    .local v4, "ptr":I
    aget-byte v2, v1, v2

    and-int/lit16 v2, v2, 0xff

    .line 986
    .local v2, "c":I
    aget v5, v0, v2

    if-eqz v5, :cond_7

    .line 987
    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 988
    nop

    .line 994
    .end local v3    # "max":I
    .end local v4    # "ptr":I
    aget v3, v0, v2

    const/4 v4, 0x1

    packed-switch v3, :pswitch_data_0

    :pswitch_0
    goto :goto_2

    .line 1016
    :pswitch_1
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->skipUtf8_4(I)V

    .line 1017
    goto :goto_2

    .line 1013
    :pswitch_2
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->skipUtf8_3(I)V

    .line 1014
    goto :goto_2

    .line 1010
    :pswitch_3
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->skipUtf8_2(I)V

    .line 1011
    goto :goto_2

    .line 1019
    :pswitch_4
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidInitial(I)V

    .line 1023
    :pswitch_5
    const/4 v3, 0x0

    .line 1027
    .local v3, "count":I
    :cond_1
    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v5, v6, :cond_2

    .line 1028
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1030
    :cond_2
    add-int/2addr v3, v4

    .line 1031
    iget-object v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v5, v5, v6

    .line 1032
    .local v5, "b":B
    const/16 v6, 0x5d

    if-eq v5, v6, :cond_1

    .line 1034
    const/16 v6, 0x3e

    if-ne v5, v6, :cond_3

    .line 1035
    if-le v3, v4, :cond_6

    .line 1036
    return-void

    .line 1040
    :cond_3
    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    sub-int/2addr v6, v4

    iput v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    goto :goto_2

    .line 1007
    .end local v3    # "count":I
    .end local v5    # "b":B
    :pswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 1008
    goto :goto_2

    .line 996
    :pswitch_7
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleInvalidXmlChar(I)C

    move-result v2

    .line 998
    :pswitch_8
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v3, v5, :cond_4

    .line 999
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1001
    :cond_4
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v3, v1, v3

    const/16 v5, 0xa

    if-ne v3, v5, :cond_5

    .line 1002
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/2addr v3, v4

    iput v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1004
    :cond_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 1005
    nop

    .line 1048
    .end local v2    # "c":I
    :cond_6
    :goto_2
    goto :goto_0

    .line 986
    .restart local v2    # "c":I
    .local v3, "max":I
    .restart local v4    # "ptr":I
    :cond_7
    move v2, v4

    goto :goto_1

    .line 991
    .end local v4    # "ptr":I
    .local v2, "ptr":I
    :cond_8
    iput v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 992
    .end local v2    # "ptr":I
    .end local v3    # "max":I
    goto :goto_0

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

.method protected final skipCharacters()Z
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 798
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    .line 799
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    .line 807
    .local v1, "inputBuffer":[B
    :goto_0
    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 808
    .local v2, "ptr":I
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    .line 809
    .local v3, "max":I
    if-lt v2, v3, :cond_0

    .line 810
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 811
    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 812
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    .line 814
    :cond_0
    :goto_1
    if-ge v2, v3, :cond_7

    .line 815
    add-int/lit8 v4, v2, 0x1

    .end local v2    # "ptr":I
    .local v4, "ptr":I
    aget-byte v2, v1, v2

    and-int/lit16 v2, v2, 0xff

    .line 816
    .local v2, "c":I
    aget v5, v0, v2

    if-eqz v5, :cond_6

    .line 817
    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 818
    nop

    .line 824
    .end local v3    # "max":I
    .end local v4    # "ptr":I
    aget v3, v0, v2

    const/4 v4, 0x0

    const/4 v5, 0x1

    packed-switch v3, :pswitch_data_0

    :pswitch_0
    goto :goto_3

    .line 863
    :pswitch_1
    const/4 v3, 0x1

    .line 866
    .local v3, "count":I
    :goto_2
    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v4, v6, :cond_1

    .line 867
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 869
    :cond_1
    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v4, v1, v4

    .line 870
    .local v4, "b":B
    const/16 v6, 0x5d

    if-eq v4, v6, :cond_2

    .line 871
    nop

    .line 876
    const/16 v6, 0x3e

    if-ne v4, v6, :cond_5

    if-le v3, v5, :cond_5

    .line 877
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportIllegalCDataEnd()V

    goto :goto_3

    .line 873
    :cond_2
    iget v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/2addr v6, v5

    iput v6, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 874
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 854
    .end local v3    # "count":I
    .end local v4    # "b":B
    :pswitch_2
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleEntityInText(Z)I

    move-result v2

    .line 855
    if-nez v2, :cond_5

    .line 856
    return v5

    .line 846
    :pswitch_3
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->skipUtf8_4(I)V

    .line 847
    goto :goto_3

    .line 843
    :pswitch_4
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->skipUtf8_3(I)V

    .line 844
    goto :goto_3

    .line 840
    :pswitch_5
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->skipUtf8_2(I)V

    .line 841
    goto :goto_3

    .line 849
    :pswitch_6
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidInitial(I)V

    .line 851
    :pswitch_7
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    sub-int/2addr v3, v5

    iput v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 852
    return v4

    .line 837
    :pswitch_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 838
    goto :goto_3

    .line 826
    :pswitch_9
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleInvalidXmlChar(I)C

    move-result v2

    .line 828
    :pswitch_a
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v3, v4, :cond_3

    .line 829
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 831
    :cond_3
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v3, v1, v3

    const/16 v4, 0xa

    if-ne v3, v4, :cond_4

    .line 832
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/2addr v3, v5

    iput v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 834
    :cond_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 835
    nop

    .line 885
    .end local v2    # "c":I
    :cond_5
    :goto_3
    goto/16 :goto_0

    .line 816
    .restart local v2    # "c":I
    .local v3, "max":I
    .local v4, "ptr":I
    :cond_6
    move v2, v4

    goto :goto_1

    .line 821
    .end local v4    # "ptr":I
    .local v2, "ptr":I
    :cond_7
    iput v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 822
    .end local v2    # "ptr":I
    .end local v3    # "max":I
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

.method protected final skipCoalescedText()Z
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2459
    nop

    :cond_0
    :goto_0
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    const/4 v2, 0x0

    if-lt v0, v1, :cond_1

    .line 2460
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_1

    .line 2461
    return v2

    .line 2465
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v0, v0, v1

    const/16 v1, 0x3c

    const/4 v3, 0x1

    if-ne v0, v1, :cond_8

    .line 2469
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    const/4 v1, 0x3

    add-int/2addr v0, v1

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v0, v4, :cond_2

    .line 2470
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadAndRetain(I)Z

    move-result v0

    if-nez v0, :cond_2

    .line 2471
    return v2

    .line 2474
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/2addr v4, v3

    aget-byte v0, v0, v4

    const/16 v3, 0x21

    if-ne v0, v3, :cond_7

    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v3, v3, 0x2

    aget-byte v0, v0, v3

    const/16 v3, 0x5b

    if-eq v0, v3, :cond_3

    goto :goto_2

    .line 2480
    :cond_3
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 2481
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    const/4 v1, 0x6

    if-ge v0, v1, :cond_6

    .line 2482
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v1, v2, :cond_4

    .line 2483
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 2485
    :cond_4
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v1, v1, v2

    .line 2486
    .local v1, "b":B
    const-string v2, "CDATA["

    invoke-virtual {v2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    int-to-byte v3, v3

    if-eq v1, v3, :cond_5

    .line 2487
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/Utf8Scanner;->decodeCharForError(B)I

    move-result v3

    .line 2488
    .local v3, "ch":I
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " (expected \'"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "\' for CDATA section)"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v3, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 2481
    .end local v1    # "b":B
    .end local v3    # "ch":I
    :cond_5
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 2491
    .end local v0    # "i":I
    :cond_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->skipCData()V

    goto/16 :goto_0

    .line 2477
    :cond_7
    :goto_2
    return v2

    .line 2493
    :cond_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->skipCharacters()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 2494
    return v3
.end method

.method protected final skipComment()V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 891
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 892
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    .line 900
    .local v1, "inputBuffer":[B
    :goto_0
    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 901
    .local v2, "ptr":I
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    .line 902
    .local v3, "max":I
    if-lt v2, v3, :cond_0

    .line 903
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 904
    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 905
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    .line 907
    :cond_0
    :goto_1
    if-ge v2, v3, :cond_8

    .line 908
    add-int/lit8 v4, v2, 0x1

    .end local v2    # "ptr":I
    .local v4, "ptr":I
    aget-byte v2, v1, v2

    and-int/lit16 v2, v2, 0xff

    .line 909
    .local v2, "c":I
    aget v5, v0, v2

    if-eqz v5, :cond_7

    .line 910
    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 911
    nop

    .line 917
    .end local v3    # "max":I
    .end local v4    # "ptr":I
    aget v3, v0, v2

    packed-switch v3, :pswitch_data_0

    :pswitch_0
    goto :goto_2

    .line 939
    :pswitch_1
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->skipUtf8_4(I)V

    .line 940
    goto :goto_2

    .line 936
    :pswitch_2
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->skipUtf8_3(I)V

    .line 937
    goto :goto_2

    .line 933
    :pswitch_3
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->skipUtf8_2(I)V

    .line 934
    goto :goto_2

    .line 942
    :pswitch_4
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidInitial(I)V

    .line 944
    :pswitch_5
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v3, v4, :cond_1

    .line 945
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 947
    :cond_1
    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v3, v3, v4

    const/16 v4, 0x2d

    if-ne v3, v4, :cond_6

    .line 948
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 949
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v3, v4, :cond_2

    .line 950
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 952
    :cond_2
    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v3, v3, v4

    const/16 v4, 0x3e

    if-eq v3, v4, :cond_3

    .line 953
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportDoubleHyphenInComments()V

    .line 955
    :cond_3
    return-void

    .line 930
    :pswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 931
    goto :goto_2

    .line 919
    :pswitch_7
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleInvalidXmlChar(I)C

    move-result v2

    .line 921
    :pswitch_8
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v3, v4, :cond_4

    .line 922
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 924
    :cond_4
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v3, v1, v3

    const/16 v4, 0xa

    if-ne v3, v4, :cond_5

    .line 925
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 927
    :cond_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 928
    nop

    .line 962
    .end local v2    # "c":I
    :cond_6
    :goto_2
    goto/16 :goto_0

    .line 909
    .restart local v2    # "c":I
    .restart local v3    # "max":I
    .restart local v4    # "ptr":I
    :cond_7
    move v2, v4

    goto :goto_1

    .line 914
    .end local v4    # "ptr":I
    .local v2, "ptr":I
    :cond_8
    iput v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 915
    .end local v2    # "ptr":I
    .end local v3    # "max":I
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

.method protected final skipPI()V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1054
    iget-object v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 1055
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    .line 1063
    .local v1, "inputBuffer":[B
    :goto_0
    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1064
    .local v2, "ptr":I
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    .line 1065
    .local v3, "max":I
    if-lt v2, v3, :cond_0

    .line 1066
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1067
    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1068
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    .line 1070
    :cond_0
    :goto_1
    if-ge v2, v3, :cond_6

    .line 1071
    add-int/lit8 v4, v2, 0x1

    .end local v2    # "ptr":I
    .local v4, "ptr":I
    aget-byte v2, v1, v2

    and-int/lit16 v2, v2, 0xff

    .line 1072
    .local v2, "c":I
    aget v5, v0, v2

    if-eqz v5, :cond_5

    .line 1073
    iput v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1074
    nop

    .line 1080
    .end local v3    # "max":I
    .end local v4    # "ptr":I
    aget v3, v0, v2

    packed-switch v3, :pswitch_data_0

    :pswitch_0
    goto :goto_2

    .line 1102
    :pswitch_1
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->skipUtf8_4(I)V

    .line 1103
    goto :goto_2

    .line 1099
    :pswitch_2
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->skipUtf8_3(I)V

    .line 1100
    goto :goto_2

    .line 1096
    :pswitch_3
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->skipUtf8_2(I)V

    .line 1097
    goto :goto_2

    .line 1105
    :pswitch_4
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->reportInvalidInitial(I)V

    .line 1107
    :pswitch_5
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v3, v4, :cond_1

    .line 1108
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1110
    :cond_1
    iget-object v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v3, v3, v4

    const/16 v4, 0x3e

    if-ne v3, v4, :cond_4

    .line 1111
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1112
    return-void

    .line 1093
    :pswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 1094
    goto :goto_2

    .line 1082
    :pswitch_7
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/Utf8Scanner;->handleInvalidXmlChar(I)C

    move-result v2

    .line 1084
    :pswitch_8
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v3, v4, :cond_2

    .line 1085
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMoreGuaranteed()V

    .line 1087
    :cond_2
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    aget-byte v3, v1, v3

    const/16 v4, 0xa

    if-ne v3, v4, :cond_3

    .line 1088
    iget v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1090
    :cond_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF()V

    .line 1091
    nop

    .line 1119
    .end local v2    # "c":I
    :cond_4
    :goto_2
    goto :goto_0

    .line 1072
    .restart local v2    # "c":I
    .restart local v3    # "max":I
    .restart local v4    # "ptr":I
    :cond_5
    move v2, v4

    goto :goto_1

    .line 1077
    .end local v4    # "ptr":I
    .local v2, "ptr":I
    :cond_6
    iput v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1078
    .end local v2    # "ptr":I
    .end local v3    # "max":I
    goto :goto_0

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

.method protected final skipSpace()V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1126
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1129
    .local v0, "ptr":I
    :goto_0
    iget v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v0, v1, :cond_1

    .line 1130
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMore()Z

    move-result v1

    if-nez v1, :cond_0

    .line 1131
    goto :goto_1

    .line 1133
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1135
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    aget-byte v1, v1, v0

    and-int/lit16 v1, v1, 0xff

    .line 1136
    .local v1, "c":I
    const/16 v2, 0x20

    if-le v1, v2, :cond_2

    .line 1137
    goto :goto_1

    .line 1139
    :cond_2
    add-int/lit8 v0, v0, 0x1

    .line 1141
    const/16 v3, 0xa

    if-ne v1, v3, :cond_3

    .line 1142
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF(I)V

    goto :goto_2

    .line 1143
    :cond_3
    const/16 v4, 0xd

    if-ne v1, v4, :cond_7

    .line 1144
    iget v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputEnd:I

    if-lt v0, v2, :cond_5

    .line 1145
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->loadMore()Z

    move-result v2

    if-nez v2, :cond_4

    .line 1146
    nop

    .line 1160
    .end local v1    # "c":I
    :goto_1
    iput v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1161
    return-void

    .line 1148
    .restart local v1    # "c":I
    :cond_4
    iget v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1150
    :cond_5
    iget-object v2, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputBuffer:[B

    aget-byte v2, v2, v0

    if-ne v2, v3, :cond_6

    .line 1151
    add-int/lit8 v0, v0, 0x1

    .line 1153
    :cond_6
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/Utf8Scanner;->markLF(I)V

    goto :goto_2

    .line 1154
    :cond_7
    if-eq v1, v2, :cond_8

    const/16 v2, 0x9

    if-eq v1, v2, :cond_8

    .line 1155
    iput v0, p0, Lcom/fasterxml/aalto/in/Utf8Scanner;->_inputPtr:I

    .line 1156
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/Utf8Scanner;->throwInvalidSpace(I)V

    .line 1158
    .end local v1    # "c":I
    :cond_8
    :goto_2
    goto :goto_0
.end method
