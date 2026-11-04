.class public abstract Lcom/fasterxml/aalto/async/AsyncByteScanner;
.super Lcom/fasterxml/aalto/in/ByteBasedScanner;
.source "AsyncByteScanner.java"

# interfaces
.implements Lcom/fasterxml/aalto/AsyncInputFeeder;


# static fields
.field protected static final EVENT_INCOMPLETE:I = 0x101

.field protected static final PENDING_STATE_ATTR_VALUE_AMP:I = -0x3c

.field protected static final PENDING_STATE_ATTR_VALUE_AMP_HASH:I = -0x3d

.field protected static final PENDING_STATE_ATTR_VALUE_AMP_HASH_X:I = -0x3e

.field protected static final PENDING_STATE_ATTR_VALUE_DEC_DIGIT:I = -0x40

.field protected static final PENDING_STATE_ATTR_VALUE_ENTITY_NAME:I = -0x3f

.field protected static final PENDING_STATE_ATTR_VALUE_HEX_DIGIT:I = -0x41

.field protected static final PENDING_STATE_CDATA_BRACKET1:I = -0x1e

.field protected static final PENDING_STATE_CDATA_BRACKET2:I = -0x1f

.field protected static final PENDING_STATE_COMMENT_HYPHEN1:I = -0x14

.field protected static final PENDING_STATE_COMMENT_HYPHEN2:I = -0x15

.field protected static final PENDING_STATE_CR:I = -0x1

.field protected static final PENDING_STATE_ENT_IN_DEC_DIGIT:I = -0x48

.field protected static final PENDING_STATE_ENT_IN_HEX_DIGIT:I = -0x49

.field protected static final PENDING_STATE_ENT_SEEN_HASH:I = -0x46

.field protected static final PENDING_STATE_ENT_SEEN_HASH_X:I = -0x47

.field protected static final PENDING_STATE_PI_QMARK:I = -0xf

.field protected static final PENDING_STATE_TEXT_AMP:I = -0x50

.field protected static final PENDING_STATE_TEXT_AMP_HASH:I = -0x51

.field protected static final PENDING_STATE_TEXT_BRACKET1:I = -0x55

.field protected static final PENDING_STATE_TEXT_BRACKET2:I = -0x56

.field protected static final PENDING_STATE_TEXT_DEC_ENTITY:I = -0x52

.field protected static final PENDING_STATE_TEXT_HEX_ENTITY:I = -0x53

.field protected static final PENDING_STATE_TEXT_IN_ENTITY:I = -0x54

.field protected static final PENDING_STATE_XMLDECL_LT:I = -0x5

.field protected static final PENDING_STATE_XMLDECL_LTQ:I = -0x6

.field protected static final PENDING_STATE_XMLDECL_TARGET:I = -0x7

.field protected static final STATE_CDATA_C:I = 0x2

.field protected static final STATE_CDATA_CD:I = 0x3

.field protected static final STATE_CDATA_CDA:I = 0x4

.field protected static final STATE_CDATA_CDAT:I = 0x5

.field protected static final STATE_CDATA_CDATA:I = 0x6

.field protected static final STATE_CDATA_CONTENT:I = 0x1

.field protected static final STATE_COMMENT_CONTENT:I = 0x1

.field protected static final STATE_COMMENT_HYPHEN:I = 0x2

.field protected static final STATE_COMMENT_HYPHEN2:I = 0x3

.field protected static final STATE_DEFAULT:I = 0x0

.field protected static final STATE_DTD_AFTER_DOCTYPE:I = 0x2

.field protected static final STATE_DTD_AFTER_PUBLIC:I = 0x8

.field protected static final STATE_DTD_AFTER_PUBLIC_ID:I = 0xc

.field protected static final STATE_DTD_AFTER_ROOT_NAME:I = 0x5

.field protected static final STATE_DTD_AFTER_SYSTEM:I = 0x9

.field protected static final STATE_DTD_AFTER_SYSTEM_ID:I = 0xf

.field protected static final STATE_DTD_BEFORE_IDS:I = 0x6

.field protected static final STATE_DTD_BEFORE_PUBLIC_ID:I = 0xa

.field protected static final STATE_DTD_BEFORE_ROOT_NAME:I = 0x3

.field protected static final STATE_DTD_BEFORE_SYSTEM_ID:I = 0xd

.field protected static final STATE_DTD_DOCTYPE:I = 0x1

.field protected static final STATE_DTD_EXPECT_CLOSING_GT:I = 0x32

.field protected static final STATE_DTD_INT_SUBSET:I = 0x10

.field protected static final STATE_DTD_PUBLIC_ID:I = 0xb

.field protected static final STATE_DTD_PUBLIC_OR_SYSTEM:I = 0x7

.field protected static final STATE_DTD_ROOT_NAME:I = 0x4

.field protected static final STATE_DTD_SYSTEM_ID:I = 0xe

.field protected static final STATE_EE_NEED_GT:I = 0x1

.field protected static final STATE_PI_AFTER_TARGET:I = 0x1

.field protected static final STATE_PI_AFTER_TARGET_QMARK:I = 0x3

.field protected static final STATE_PI_AFTER_TARGET_WS:I = 0x2

.field protected static final STATE_PI_IN_DATA:I = 0x5

.field protected static final STATE_PI_IN_TARGET:I = 0x4

.field protected static final STATE_PROLOG_DECL:I = 0x3

.field protected static final STATE_PROLOG_INITIAL:I = 0x1

.field protected static final STATE_PROLOG_SEEN_LT:I = 0x2

.field protected static final STATE_SE_ATTR_NAME:I = 0x4

.field protected static final STATE_SE_ATTR_VALUE_NORMAL:I = 0x7

.field protected static final STATE_SE_ATTR_VALUE_NSDECL:I = 0x8

.field protected static final STATE_SE_ELEM_NAME:I = 0x1

.field protected static final STATE_SE_SEEN_SLASH:I = 0x9

.field protected static final STATE_SE_SPACE_OR_ATTRNAME:I = 0x3

.field protected static final STATE_SE_SPACE_OR_ATTRVALUE:I = 0x6

.field protected static final STATE_SE_SPACE_OR_END:I = 0x2

.field protected static final STATE_SE_SPACE_OR_EQ:I = 0x5

.field protected static final STATE_TEXT_AMP:I = 0x4

.field protected static final STATE_TEXT_AMP_NAME:I = 0x6

.field protected static final STATE_TREE_NAMED_ENTITY_START:I = 0x6

.field protected static final STATE_TREE_NUMERIC_ENTITY_START:I = 0x5

.field protected static final STATE_TREE_SEEN_AMP:I = 0x2

.field protected static final STATE_TREE_SEEN_EXCL:I = 0x3

.field protected static final STATE_TREE_SEEN_LT:I = 0x1

.field protected static final STATE_TREE_SEEN_SLASH:I = 0x4

.field protected static final STATE_XMLDECL_AFTER_ENCODING:I = 0xa

.field protected static final STATE_XMLDECL_AFTER_ENCODING_VALUE:I = 0xd

.field protected static final STATE_XMLDECL_AFTER_STANDALONE:I = 0x10

.field protected static final STATE_XMLDECL_AFTER_STANDALONE_VALUE:I = 0x13

.field protected static final STATE_XMLDECL_AFTER_VERSION:I = 0x4

.field protected static final STATE_XMLDECL_AFTER_VERSION_VALUE:I = 0x7

.field protected static final STATE_XMLDECL_AFTER_XML:I = 0x1

.field protected static final STATE_XMLDECL_BEFORE_ENCODING:I = 0x8

.field protected static final STATE_XMLDECL_BEFORE_STANDALONE:I = 0xe

.field protected static final STATE_XMLDECL_BEFORE_VERSION:I = 0x2

.field protected static final STATE_XMLDECL_ENCODING:I = 0x9

.field protected static final STATE_XMLDECL_ENCODING_EQ:I = 0xb

.field protected static final STATE_XMLDECL_ENCODING_VALUE:I = 0xc

.field protected static final STATE_XMLDECL_ENDQ:I = 0x14

.field protected static final STATE_XMLDECL_STANDALONE:I = 0xf

.field protected static final STATE_XMLDECL_STANDALONE_EQ:I = 0x11

.field protected static final STATE_XMLDECL_STANDALONE_VALUE:I = 0x12

.field protected static final STATE_XMLDECL_VERSION:I = 0x3

.field protected static final STATE_XMLDECL_VERSION_EQ:I = 0x5

.field protected static final STATE_XMLDECL_VERSION_VALUE:I = 0x6


# instance fields
.field protected _charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

.field protected _currQuad:I

.field protected _currQuadBytes:I

.field protected _elemAllNsBound:Z

.field protected _elemAttrCount:Z

.field protected _elemAttrName:Lcom/fasterxml/aalto/in/PName;

.field protected _elemAttrPtr:I

.field protected _elemAttrQuote:B

.field protected _elemNsPtr:I

.field protected _endOfInput:Z

.field protected _entityValue:I

.field protected _inDtdDeclaration:Z

.field protected _nextEvent:I

.field protected _pendingInput:I

.field protected _quadBuffer:[I

.field protected _quadCount:I

.field protected _state:I

.field protected _surroundingEvent:I

.field protected _symbols:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;


# direct methods
.method protected constructor <init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V
    .locals 1
    .param p1, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;

    .line 344
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/in/ByteBasedScanner;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V

    .line 220
    const/16 v0, 0x20

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    .line 233
    const/16 v0, 0x101

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextEvent:I

    .line 246
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_surroundingEvent:I

    .line 264
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_pendingInput:I

    .line 270
    iput-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_endOfInput:Z

    .line 292
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currQuadBytes:I

    .line 297
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_entityValue:I

    .line 349
    return-void
.end method

.method private final _parseNewXmlDeclName(B)Lcom/fasterxml/aalto/in/PName;
    .locals 2
    .param p1, "b"    # B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1643
    and-int/lit16 v0, p1, 0xff

    .line 1644
    .local v0, "q":I
    const/16 v1, 0x41

    if-ge v0, v1, :cond_0

    .line 1645
    const-string v1, "; expected a name start character"

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1647
    :cond_0
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadCount:I

    .line 1648
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currQuad:I

    .line 1649
    const/4 v1, 0x1

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currQuadBytes:I

    .line 1650
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_parseXmlDeclName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1
.end method

.method private final _parseXmlDeclName()Lcom/fasterxml/aalto/in/PName;
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1655
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currQuad:I

    .line 1660
    .local v0, "q":I
    :goto_0
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currQuadBytes:I

    const/4 v2, 0x0

    const/16 v3, 0x2f

    const/16 v4, 0x3a

    const/16 v5, 0x2d

    const/4 v6, 0x0

    const/16 v7, 0x41

    const/4 v8, 0x1

    packed-switch v1, :pswitch_data_0

    goto/16 :goto_1

    .line 1662
    :pswitch_0
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v1, v9, :cond_0

    .line 1663
    return-object v6

    .line 1665
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    and-int/lit16 v0, v1, 0xff

    .line 1667
    if-ge v0, v7, :cond_2

    .line 1668
    if-lt v0, v5, :cond_1

    if-gt v0, v4, :cond_1

    if-ne v0, v3, :cond_2

    .line 1669
    :cond_1
    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_findXmlDeclName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1

    .line 1674
    :cond_2
    :pswitch_1
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v1, v9, :cond_3

    .line 1675
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currQuad:I

    .line 1676
    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currQuadBytes:I

    .line 1677
    return-object v6

    .line 1679
    :cond_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 1680
    .local v1, "i":I
    if-ge v1, v7, :cond_5

    .line 1681
    if-lt v1, v5, :cond_4

    if-gt v1, v4, :cond_4

    if-ne v1, v3, :cond_5

    .line 1682
    :cond_4
    invoke-virtual {p0, v0, v8}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_findXmlDeclName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    return-object v2

    .line 1685
    :cond_5
    shl-int/lit8 v9, v0, 0x8

    or-int v0, v9, v1

    .line 1688
    .end local v1    # "i":I
    :pswitch_2
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    const/4 v10, 0x2

    if-lt v1, v9, :cond_6

    .line 1689
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currQuad:I

    .line 1690
    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currQuadBytes:I

    .line 1691
    return-object v6

    .line 1693
    :cond_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 1694
    .restart local v1    # "i":I
    if-ge v1, v7, :cond_8

    .line 1695
    if-lt v1, v5, :cond_7

    if-gt v1, v4, :cond_7

    if-ne v1, v3, :cond_8

    .line 1696
    :cond_7
    invoke-virtual {p0, v0, v10}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_findXmlDeclName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    return-object v2

    .line 1699
    :cond_8
    shl-int/lit8 v9, v0, 0x8

    or-int v0, v9, v1

    .line 1702
    .end local v1    # "i":I
    :pswitch_3
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    const/4 v10, 0x3

    if-lt v1, v9, :cond_9

    .line 1703
    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currQuad:I

    .line 1704
    iput v10, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currQuadBytes:I

    .line 1705
    return-object v6

    .line 1707
    :cond_9
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 1708
    .restart local v1    # "i":I
    if-ge v1, v7, :cond_b

    .line 1709
    if-lt v1, v5, :cond_a

    if-gt v1, v4, :cond_a

    if-ne v1, v3, :cond_b

    .line 1710
    :cond_a
    invoke-virtual {p0, v0, v10}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_findXmlDeclName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    return-object v2

    .line 1713
    :cond_b
    shl-int/lit8 v3, v0, 0x8

    or-int v0, v3, v1

    .line 1717
    .end local v1    # "i":I
    :goto_1
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadCount:I

    if-nez v1, :cond_c

    .line 1718
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    aput v0, v1, v2

    .line 1719
    iput v8, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadCount:I

    goto :goto_2

    .line 1721
    :cond_c
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadCount:I

    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    array-length v3, v3

    if-lt v1, v3, :cond_d

    .line 1722
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    array-length v3, v3

    invoke-static {v1, v3}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([II)[I

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    .line 1724
    :cond_d
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadCount:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadCount:I

    aput v0, v1, v3

    .line 1726
    :goto_2
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currQuadBytes:I

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

.method private handleDTD()I
    .locals 16
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1350
    move-object/from16 v0, p0

    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_pendingInput:I

    const/4 v2, -0x1

    const/16 v3, 0x101

    if-ne v1, v2, :cond_0

    .line 1351
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->handlePartialCR()Z

    move-result v1

    if-nez v1, :cond_0

    .line 1352
    return v3

    .line 1355
    :cond_0
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    const/16 v2, 0x32

    const/16 v4, 0x10

    const/4 v5, 0x0

    if-ne v1, v4, :cond_2

    .line 1356
    invoke-virtual {v0, v5}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->handleDTDInternalSubset(Z)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 1357
    iput v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    goto :goto_0

    .line 1359
    :cond_1
    return v3

    .line 1364
    :cond_2
    :goto_0
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v6, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-ge v1, v6, :cond_31

    .line 1365
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    const-string v7, "SYSTEM"

    const-string v8, "expected \'DOCTYPE\'"

    const/16 v10, 0xf

    const/16 v11, 0xc

    const-string v13, "PUBLIC"

    const-string v14, "DOCTYPE"

    const/16 v6, 0x3e

    const/16 v12, 0xb

    const/16 v9, 0x20

    const/4 v15, 0x1

    sparse-switch v1, :sswitch_data_0

    .line 1608
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->throwInternal()I

    goto :goto_0

    .line 1561
    :sswitch_0
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v1

    iget-object v7, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v7}, Lcom/fasterxml/aalto/util/TextBuilder;->getCurrentLength()I

    move-result v7

    invoke-direct {v0, v1, v7, v15}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->parseDtdId([CIZ)Z

    move-result v1

    if-nez v1, :cond_3

    .line 1562
    goto :goto_0

    .line 1564
    :cond_3
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->verifyAndSetSystemId()V

    .line 1565
    iput v10, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1566
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v7, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v1, v7, :cond_4

    .line 1567
    goto :goto_0

    .line 1572
    :cond_4
    :sswitch_1
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->asyncSkipSpace()Z

    move-result v1

    if-nez v1, :cond_5

    .line 1573
    goto :goto_0

    .line 1576
    :cond_5
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    .line 1577
    .local v1, "b":B
    if-ne v1, v6, :cond_6

    .line 1578
    iput v5, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1579
    iput v3, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextEvent:I

    .line 1580
    return v12

    .line 1582
    :cond_6
    const/16 v7, 0x5b

    if-eq v1, v7, :cond_7

    .line 1583
    iget-byte v7, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    invoke-virtual {v0, v7}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v7

    const-string v8, " (expected either \'[\' for internal subset, or \'>\' to end DOCTYPE)"

    invoke-virtual {v0, v15, v7, v8}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    .line 1586
    .end local v1    # "b":B
    :cond_7
    iput v4, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1587
    invoke-virtual {v0, v15}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->handleDTDInternalSubset(Z)Z

    move-result v1

    if-eqz v1, :cond_a

    .line 1588
    iput v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1595
    :sswitch_2
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->asyncSkipSpace()Z

    move-result v1

    if-nez v1, :cond_8

    .line 1596
    goto :goto_0

    .line 1599
    :cond_8
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    .line 1600
    .restart local v1    # "b":B
    if-eq v1, v6, :cond_9

    .line 1601
    const-string v2, "expected \'>\' to end DTD"

    invoke-virtual {v0, v15, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    .line 1604
    .end local v1    # "b":B
    :cond_9
    iput v5, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1605
    iput v3, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextEvent:I

    .line 1606
    return v12

    .line 1590
    :cond_a
    return v3

    .line 1521
    :sswitch_3
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v1

    iget-object v6, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v6}, Lcom/fasterxml/aalto/util/TextBuilder;->getCurrentLength()I

    move-result v6

    invoke-direct {v0, v1, v6, v5}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->parseDtdId([CIZ)Z

    move-result v1

    if-nez v1, :cond_b

    .line 1522
    goto/16 :goto_0

    .line 1524
    :cond_b
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->verifyAndSetPublicId()V

    .line 1525
    iput v11, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1526
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v6, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v1, v6, :cond_c

    .line 1527
    goto/16 :goto_0

    .line 1532
    :cond_c
    :sswitch_4
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    .line 1533
    .restart local v1    # "b":B
    if-eq v1, v9, :cond_e

    const/16 v6, 0xd

    if-eq v1, v6, :cond_e

    const/16 v6, 0xa

    if-eq v1, v6, :cond_e

    const/16 v6, 0x9

    if-ne v1, v6, :cond_d

    goto :goto_1

    .line 1536
    :cond_d
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v6

    const-string v7, " (expected space after PUBLIC ID)"

    invoke-virtual {v0, v15, v6, v7}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    goto :goto_2

    .line 1534
    :cond_e
    :goto_1
    const/16 v6, 0xd

    iput v6, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1542
    .end local v1    # "b":B
    :goto_2
    :sswitch_5
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->asyncSkipSpace()Z

    move-result v1

    if-nez v1, :cond_f

    .line 1543
    goto/16 :goto_0

    .line 1545
    :cond_f
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    iput-byte v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    .line 1546
    iget-byte v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    const/16 v6, 0x22

    if-eq v1, v6, :cond_10

    iget-byte v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    const/16 v6, 0x27

    if-eq v1, v6, :cond_10

    .line 1547
    iget-byte v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v1

    const-string v6, " (expected \'\"\' or \'\'\' for SYSTEM ID)"

    invoke-virtual {v0, v15, v1, v6}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    .line 1550
    :cond_10
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v1

    .line 1551
    .local v1, "buf":[C
    iget v6, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v7, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-ge v6, v7, :cond_12

    invoke-direct {v0, v1, v5, v15}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->parseDtdId([CIZ)Z

    move-result v6

    if-nez v6, :cond_11

    goto :goto_3

    .line 1556
    .end local v1    # "buf":[C
    :cond_11
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->verifyAndSetSystemId()V

    .line 1557
    iput v10, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1558
    goto/16 :goto_0

    .line 1552
    .restart local v1    # "buf":[C
    :cond_12
    :goto_3
    const/16 v6, 0xe

    iput v6, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1553
    goto/16 :goto_0

    .line 1502
    .end local v1    # "buf":[C
    :sswitch_6
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->asyncSkipSpace()Z

    move-result v1

    if-nez v1, :cond_13

    .line 1503
    goto/16 :goto_0

    .line 1505
    :cond_13
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    iput-byte v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    .line 1506
    iget-byte v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    const/16 v6, 0x22

    if-eq v1, v6, :cond_14

    iget-byte v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    const/16 v6, 0x27

    if-eq v1, v6, :cond_14

    .line 1507
    iget-byte v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v1

    const-string v6, " (expected \'\"\' or \'\'\' for PUBLIC ID)"

    invoke-virtual {v0, v15, v1, v6}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    .line 1510
    :cond_14
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v1

    .line 1511
    .restart local v1    # "buf":[C
    iget v6, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v7, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-ge v6, v7, :cond_16

    invoke-direct {v0, v1, v5, v5}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->parseDtdId([CIZ)Z

    move-result v6

    if-nez v6, :cond_15

    goto :goto_4

    .line 1516
    .end local v1    # "buf":[C
    :cond_15
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->verifyAndSetPublicId()V

    .line 1517
    iput v11, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1518
    goto/16 :goto_0

    .line 1512
    .restart local v1    # "buf":[C
    :cond_16
    :goto_4
    iput v12, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1513
    goto/16 :goto_0

    .line 1492
    .end local v1    # "buf":[C
    :sswitch_7
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    .line 1493
    .local v1, "b":B
    if-eq v1, v9, :cond_18

    const/16 v6, 0xd

    if-eq v1, v6, :cond_18

    const/16 v6, 0xa

    if-eq v1, v6, :cond_18

    const/16 v6, 0x9

    if-ne v1, v6, :cond_17

    goto :goto_5

    .line 1496
    :cond_17
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v6

    const-string v7, " (expected space after SYSTEM keyword)"

    invoke-virtual {v0, v15, v6, v7}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    goto :goto_6

    .line 1494
    :cond_18
    :goto_5
    const/16 v6, 0xd

    iput v6, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1499
    .end local v1    # "b":B
    :goto_6
    goto/16 :goto_0

    .line 1481
    :sswitch_8
    const/16 v6, 0xd

    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    .line 1482
    .restart local v1    # "b":B
    if-eq v1, v9, :cond_1a

    if-eq v1, v6, :cond_1a

    const/16 v6, 0xa

    if-eq v1, v6, :cond_1a

    const/16 v6, 0x9

    if-ne v1, v6, :cond_19

    goto :goto_7

    .line 1485
    :cond_19
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v6

    const-string v7, " (expected space after PUBLIC keyword)"

    invoke-virtual {v0, v15, v6, v7}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    goto :goto_8

    .line 1483
    :cond_1a
    :goto_7
    const/16 v6, 0xa

    iput v6, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1488
    .end local v1    # "b":B
    :goto_8
    goto/16 :goto_0

    .line 1464
    :sswitch_9
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->parsePName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    move-object v6, v1

    .local v6, "name":Lcom/fasterxml/aalto/in/PName;
    if-nez v1, :cond_1b

    .line 1465
    const/4 v1, 0x7

    iput v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1466
    goto/16 :goto_0

    .line 1468
    :cond_1b
    invoke-virtual {v6}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v1

    .line 1469
    .local v1, "str":Ljava/lang/String;
    invoke-virtual {v13, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_1c

    .line 1470
    const/16 v7, 0x8

    iput v7, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    goto :goto_9

    .line 1471
    :cond_1c
    invoke-virtual {v7, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_1d

    .line 1472
    const/16 v7, 0x9

    iput v7, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    goto :goto_9

    .line 1474
    :cond_1d
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v8, "unexpected token \'"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "\': expected either PUBLIC or SYSTEM"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v0, v15, v7}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologProblem(ZLjava/lang/String;)V

    .line 1477
    .end local v1    # "str":Ljava/lang/String;
    .end local v6    # "name":Lcom/fasterxml/aalto/in/PName;
    :goto_9
    goto/16 :goto_0

    .line 1411
    :sswitch_a
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->parsePName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    iput-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    if-nez v1, :cond_1e

    .line 1412
    goto/16 :goto_0

    .line 1414
    :cond_1e
    const/4 v1, 0x5

    iput v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1415
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v8, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v1, v8, :cond_1f

    .line 1416
    goto/16 :goto_0

    .line 1421
    :cond_1f
    :sswitch_b
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    .line 1422
    .local v1, "b":B
    if-ne v1, v6, :cond_20

    .line 1423
    iput v5, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1424
    iput v3, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextEvent:I

    .line 1425
    return v12

    .line 1427
    :cond_20
    if-eq v1, v9, :cond_22

    const/16 v8, 0xd

    if-eq v1, v8, :cond_22

    const/16 v8, 0xa

    if-eq v1, v8, :cond_22

    const/16 v8, 0x9

    if-ne v1, v8, :cond_21

    goto :goto_a

    .line 1430
    :cond_21
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v8

    const-string v9, " (expected space after root name in DOCTYPE declaration)"

    invoke-virtual {v0, v15, v8, v9}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    goto :goto_b

    .line 1428
    :cond_22
    :goto_a
    const/4 v8, 0x6

    iput v8, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1435
    .end local v1    # "b":B
    :goto_b
    :sswitch_c
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->asyncSkipSpace()Z

    move-result v1

    if-nez v1, :cond_23

    .line 1436
    goto/16 :goto_0

    .line 1439
    :cond_23
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    .line 1440
    .restart local v1    # "b":B
    if-ne v1, v6, :cond_24

    .line 1441
    iput v5, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1442
    iput v3, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextEvent:I

    .line 1443
    return v12

    .line 1446
    :cond_24
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->parseNewName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v6

    move-object v8, v6

    .local v8, "name":Lcom/fasterxml/aalto/in/PName;
    if-nez v6, :cond_25

    .line 1447
    const/4 v6, 0x7

    iput v6, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1448
    goto/16 :goto_0

    .line 1450
    :cond_25
    invoke-virtual {v8}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v6

    .line 1451
    .local v6, "str":Ljava/lang/String;
    invoke-virtual {v13, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_26

    .line 1452
    const/16 v7, 0x8

    iput v7, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    goto :goto_c

    .line 1453
    :cond_26
    invoke-virtual {v7, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_27

    .line 1454
    const/16 v7, 0x9

    iput v7, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    goto :goto_c

    .line 1456
    :cond_27
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v9, "unexpected token \'"

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v9, "\': expected either PUBLIC or SYSTEM"

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v0, v15, v7}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologProblem(ZLjava/lang/String;)V

    .line 1459
    .end local v1    # "b":B
    .end local v6    # "str":Ljava/lang/String;
    .end local v8    # "name":Lcom/fasterxml/aalto/in/PName;
    :goto_c
    goto/16 :goto_0

    .line 1378
    :sswitch_d
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->parsePName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    iput-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 1379
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    if-nez v1, :cond_28

    .line 1380
    iput v15, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1381
    return v3

    .line 1383
    :cond_28
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v14, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_29

    .line 1384
    invoke-virtual {v0, v15, v8}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologProblem(ZLjava/lang/String;)V

    .line 1386
    :cond_29
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v6, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v1, v6, :cond_2a

    .line 1387
    goto/16 :goto_0

    .line 1392
    :cond_2a
    :sswitch_e
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    .line 1393
    .restart local v1    # "b":B
    if-eq v1, v9, :cond_2c

    const/16 v6, 0xd

    if-eq v1, v6, :cond_2c

    const/16 v6, 0xa

    if-eq v1, v6, :cond_2c

    const/16 v6, 0x9

    if-ne v1, v6, :cond_2b

    goto :goto_d

    .line 1396
    :cond_2b
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v6

    const-string v7, " (expected space after \'DOCTYPE\')"

    invoke-virtual {v0, v15, v6, v7}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    goto :goto_e

    .line 1394
    :cond_2c
    :goto_d
    const/4 v6, 0x3

    iput v6, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1401
    .end local v1    # "b":B
    :goto_e
    :sswitch_f
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->asyncSkipSpace()Z

    move-result v1

    if-nez v1, :cond_2d

    .line 1402
    goto/16 :goto_0

    .line 1404
    :cond_2d
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->parseNewName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    iput-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    const/4 v6, 0x4

    if-nez v1, :cond_2e

    .line 1405
    iput v6, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1406
    goto/16 :goto_0

    .line 1408
    :cond_2e
    iput v6, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1409
    goto/16 :goto_0

    .line 1367
    :sswitch_10
    const/16 v1, 0x44

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->parseNewName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    iput-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 1368
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    if-nez v1, :cond_2f

    .line 1369
    iput v15, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1370
    return v3

    .line 1372
    :cond_2f
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v14, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_30

    .line 1373
    invoke-virtual {v0, v15, v8}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologProblem(ZLjava/lang/String;)V

    .line 1375
    :cond_30
    const/4 v1, 0x2

    iput v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1376
    goto/16 :goto_0

    .line 1611
    :cond_31
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currToken:I

    return v1

    nop

    :sswitch_data_0
    .sparse-switch
        0x0 -> :sswitch_10
        0x1 -> :sswitch_d
        0x2 -> :sswitch_e
        0x3 -> :sswitch_f
        0x4 -> :sswitch_a
        0x5 -> :sswitch_b
        0x6 -> :sswitch_c
        0x7 -> :sswitch_9
        0x8 -> :sswitch_8
        0x9 -> :sswitch_7
        0xa -> :sswitch_6
        0xb -> :sswitch_3
        0xc -> :sswitch_4
        0xd -> :sswitch_5
        0xe -> :sswitch_0
        0xf -> :sswitch_1
        0x32 -> :sswitch_2
    .end sparse-switch
.end method

.method private final handlePrologDeclStart(Z)I
    .locals 4
    .param p1, "isProlog"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 927
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    const/16 v2, 0x101

    if-lt v0, v1, :cond_0

    .line 928
    return v2

    .line 930
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v0

    .line 932
    .local v0, "b":B
    const/16 v1, 0x2d

    const/4 v3, 0x0

    if-ne v0, v1, :cond_1

    .line 933
    const/4 v1, 0x5

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextEvent:I

    .line 934
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 935
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->handleComment()I

    move-result v1

    return v1

    .line 937
    :cond_1
    const/16 v1, 0x44

    if-ne v0, v1, :cond_2

    .line 938
    const/16 v1, 0xb

    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextEvent:I

    .line 939
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 940
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->handleDTD()I

    move-result v1

    return v1

    .line 942
    :cond_2
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v1

    const-string v3, " (expected \'-\' for COMMENT)"

    invoke-virtual {p0, p1, v1, v3}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    .line 943
    return v2
.end method

.method private handleXmlDeclaration()I
    .locals 16
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1016
    move-object/from16 v0, p0

    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_pendingInput:I

    const/4 v2, -0x1

    const/16 v3, 0x101

    if-ne v1, v2, :cond_0

    .line 1017
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->handlePartialCR()Z

    move-result v1

    if-nez v1, :cond_0

    .line 1018
    return v3

    .line 1023
    :cond_0
    :goto_0
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-ge v1, v2, :cond_41

    .line 1024
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    const/16 v2, 0x12

    const/16 v4, 0x13

    const-string v5, "encoding"

    const-string/jumbo v7, "version"

    const/4 v10, 0x7

    const/16 v12, 0x3d

    const/16 v15, 0x10

    const-string/jumbo v6, "standalone"

    const/4 v14, 0x0

    const-string v13, "Unexpected keyword \'"

    const/16 v9, 0x14

    const/16 v8, 0x3f

    const/4 v11, 0x1

    packed-switch v1, :pswitch_data_0

    .line 1340
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->throwInternal()I

    goto :goto_0

    .line 1304
    :pswitch_0
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v1

    iget-object v5, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v5}, Lcom/fasterxml/aalto/util/TextBuilder;->getCurrentLength()I

    move-result v5

    invoke-virtual {v0, v1, v5}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->parseXmlDeclAttr([CI)Z

    move-result v1

    if-nez v1, :cond_1

    .line 1305
    iput v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1306
    goto :goto_0

    .line 1308
    :cond_1
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->verifyAndSetXmlStandalone()V

    .line 1309
    iput v4, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1310
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v1, v2, :cond_2

    .line 1311
    goto :goto_0

    .line 1315
    :cond_2
    :pswitch_1
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->asyncSkipSpace()Z

    move-result v1

    if-nez v1, :cond_3

    .line 1316
    goto :goto_0

    .line 1318
    :cond_3
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    if-eq v1, v8, :cond_4

    .line 1319
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_prevByte()B

    move-result v1

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v1

    const-string v2, " (expected \'?>\' to end xml declaration)"

    invoke-virtual {v0, v11, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    .line 1321
    :cond_4
    iput v9, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1322
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v1, v2, :cond_5

    .line 1323
    goto :goto_0

    .line 1329
    :cond_5
    :pswitch_2
    const/4 v1, 0x0

    iput-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 1330
    iput v14, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1331
    iput v3, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextEvent:I

    .line 1332
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    const/16 v2, 0x3e

    if-eq v1, v2, :cond_6

    .line 1333
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_prevByte()B

    move-result v1

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v1

    const-string v2, " (expected \'>\' to end xml declaration)"

    invoke-virtual {v0, v11, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    .line 1336
    :cond_6
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_activateEncoding()V

    .line 1337
    return v10

    .line 1257
    :pswitch_3
    invoke-direct/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_parseXmlDeclName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    iput-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    if-nez v1, :cond_7

    .line 1258
    goto/16 :goto_0

    .line 1260
    :cond_7
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v1, v6}, Lcom/fasterxml/aalto/in/PName;->hasPrefixedName(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_8

    .line 1261
    const-string v1, "Unexpected keyword \'encoding\' in XML declaration: expected \'standalone\'"

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1263
    :cond_8
    iput v15, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1264
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v5, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v1, v5, :cond_9

    .line 1265
    goto/16 :goto_0

    .line 1269
    :cond_9
    :pswitch_4
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->asyncSkipSpace()Z

    move-result v1

    if-nez v1, :cond_a

    .line 1270
    goto/16 :goto_0

    .line 1273
    :cond_a
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    .line 1274
    .local v1, "b":B
    if-eq v1, v12, :cond_b

    .line 1275
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v5

    const-string v6, " (expected \'=\' after \'standalone\' in xml declaration)"

    invoke-virtual {v0, v11, v5, v6}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    .line 1278
    .end local v1    # "b":B
    :cond_b
    const/16 v1, 0x11

    iput v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1279
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v5, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v1, v5, :cond_c

    .line 1280
    goto/16 :goto_0

    .line 1284
    :cond_c
    :pswitch_5
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->asyncSkipSpace()Z

    move-result v1

    if-nez v1, :cond_d

    .line 1285
    goto/16 :goto_0

    .line 1287
    :cond_d
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    iput-byte v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    .line 1288
    iget-byte v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    const/16 v5, 0x22

    if-eq v1, v5, :cond_e

    iget-byte v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    const/16 v5, 0x27

    if-eq v1, v5, :cond_e

    .line 1289
    iget-byte v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v1

    const-string v5, " (expected \'\"\' or \'\'\' in xml declaration for standalone value)"

    invoke-virtual {v0, v11, v1, v5}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    .line 1292
    :cond_e
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v1

    .line 1293
    .local v1, "buf":[C
    iget v5, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v6, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-ge v5, v6, :cond_10

    invoke-virtual {v0, v1, v14}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->parseXmlDeclAttr([CI)Z

    move-result v5

    if-nez v5, :cond_f

    goto :goto_1

    .line 1298
    .end local v1    # "buf":[C
    :cond_f
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->verifyAndSetXmlStandalone()V

    .line 1299
    iput v4, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1300
    goto/16 :goto_0

    .line 1294
    .restart local v1    # "buf":[C
    :cond_10
    :goto_1
    iput v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1295
    goto/16 :goto_0

    .line 1206
    .end local v1    # "buf":[C
    :pswitch_6
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v1

    iget-object v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->getCurrentLength()I

    move-result v2

    invoke-virtual {v0, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->parseXmlDeclAttr([CI)Z

    move-result v1

    if-nez v1, :cond_11

    .line 1207
    const/16 v1, 0xc

    iput v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1208
    goto/16 :goto_0

    .line 1210
    :cond_11
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->verifyAndSetXmlEncoding()V

    .line 1211
    const/16 v1, 0xd

    iput v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1212
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v1, v2, :cond_12

    .line 1213
    goto/16 :goto_0

    .line 1219
    :cond_12
    :pswitch_7
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    .line 1220
    .local v1, "b":B
    if-ne v1, v8, :cond_13

    .line 1221
    iput v9, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1222
    goto/16 :goto_0

    .line 1224
    :cond_13
    const/16 v2, 0x20

    if-eq v1, v2, :cond_15

    const/16 v2, 0xd

    if-eq v1, v2, :cond_15

    const/16 v2, 0xa

    if-eq v1, v2, :cond_15

    const/16 v2, 0x9

    if-ne v1, v2, :cond_14

    goto :goto_2

    .line 1227
    :cond_14
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v2

    const-string v4, " (expected space after encoding value in xml declaration)"

    invoke-virtual {v0, v11, v2, v4}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    goto :goto_3

    .line 1225
    :cond_15
    :goto_2
    const/16 v2, 0xe

    iput v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1230
    .end local v1    # "b":B
    :goto_3
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v1, v2, :cond_16

    .line 1231
    goto/16 :goto_0

    .line 1236
    :cond_16
    :pswitch_8
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->asyncSkipSpace()Z

    move-result v1

    if-nez v1, :cond_17

    .line 1237
    goto/16 :goto_0

    .line 1240
    :cond_17
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    .line 1241
    .restart local v1    # "b":B
    if-ne v1, v8, :cond_18

    .line 1242
    iput v9, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1243
    goto/16 :goto_0

    .line 1245
    :cond_18
    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_parseNewXmlDeclName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    iput-object v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    if-nez v2, :cond_19

    .line 1246
    const/16 v2, 0xf

    iput v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1247
    goto/16 :goto_0

    .line 1249
    :cond_19
    iget-object v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v2, v6}, Lcom/fasterxml/aalto/in/PName;->hasPrefixedName(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1a

    .line 1250
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v4, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v4}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "\' in XML declaration: expected \'standalone\'"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1253
    .end local v1    # "b":B
    :cond_1a
    iput v15, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1254
    goto/16 :goto_0

    .line 1154
    :pswitch_9
    invoke-direct/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_parseXmlDeclName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    iput-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    if-nez v1, :cond_1b

    .line 1155
    goto/16 :goto_0

    .line 1158
    :cond_1b
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v1, v5}, Lcom/fasterxml/aalto/in/PName;->hasPrefixedName(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1c

    .line 1159
    const/16 v1, 0xa

    iput v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    goto :goto_4

    .line 1160
    :cond_1c
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v1, v6}, Lcom/fasterxml/aalto/in/PName;->hasPrefixedName(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1d

    .line 1161
    iput v15, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1162
    goto/16 :goto_0

    .line 1164
    :cond_1d
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\' in XML declaration: expected \'encoding\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1166
    :goto_4
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v1, v2, :cond_1e

    .line 1167
    goto/16 :goto_0

    .line 1171
    :cond_1e
    :pswitch_a
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->asyncSkipSpace()Z

    move-result v1

    if-nez v1, :cond_1f

    .line 1172
    goto/16 :goto_0

    .line 1175
    :cond_1f
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    .line 1176
    .restart local v1    # "b":B
    if-eq v1, v12, :cond_20

    .line 1177
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v2

    const-string v4, " (expected \'=\' after \'encoding\' in xml declaration)"

    invoke-virtual {v0, v11, v2, v4}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    .line 1180
    .end local v1    # "b":B
    :cond_20
    const/16 v1, 0xb

    iput v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1181
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v1, v2, :cond_21

    .line 1182
    goto/16 :goto_0

    .line 1186
    :cond_21
    :pswitch_b
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->asyncSkipSpace()Z

    move-result v1

    if-nez v1, :cond_22

    .line 1187
    goto/16 :goto_0

    .line 1189
    :cond_22
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    iput-byte v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    .line 1190
    iget-byte v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    const/16 v2, 0x22

    if-eq v1, v2, :cond_23

    iget-byte v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    const/16 v2, 0x27

    if-eq v1, v2, :cond_23

    .line 1191
    iget-byte v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v1

    const-string v2, " (expected \'\"\' or \'\'\' in xml declaration for encoding value)"

    invoke-virtual {v0, v11, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    .line 1193
    :cond_23
    const/16 v1, 0xc

    iput v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1195
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v1

    .line 1196
    .local v1, "buf":[C
    iget v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v4, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-ge v2, v4, :cond_25

    invoke-virtual {v0, v1, v14}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->parseXmlDeclAttr([CI)Z

    move-result v2

    if-nez v2, :cond_24

    goto :goto_5

    .line 1201
    .end local v1    # "buf":[C
    :cond_24
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->verifyAndSetXmlEncoding()V

    .line 1202
    const/16 v1, 0xd

    iput v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1203
    goto/16 :goto_0

    .line 1197
    .restart local v1    # "buf":[C
    :cond_25
    :goto_5
    const/16 v2, 0xc

    iput v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1198
    goto/16 :goto_0

    .line 1098
    .end local v1    # "buf":[C
    :pswitch_c
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v1

    iget-object v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->getCurrentLength()I

    move-result v2

    invoke-virtual {v0, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->parseXmlDeclAttr([CI)Z

    move-result v1

    if-nez v1, :cond_26

    .line 1099
    const/4 v1, 0x6

    iput v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1100
    goto/16 :goto_0

    .line 1102
    :cond_26
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->verifyAndSetXmlVersion()V

    .line 1103
    iput v10, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1104
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v1, v2, :cond_27

    .line 1105
    goto/16 :goto_0

    .line 1111
    :cond_27
    :pswitch_d
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    .line 1112
    .local v1, "b":B
    if-ne v1, v8, :cond_28

    .line 1113
    iput v9, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1114
    goto/16 :goto_0

    .line 1116
    :cond_28
    const/16 v2, 0x20

    if-eq v1, v2, :cond_2a

    const/16 v2, 0xd

    if-eq v1, v2, :cond_2a

    const/16 v2, 0xa

    if-eq v1, v2, :cond_2a

    const/16 v2, 0x9

    if-ne v1, v2, :cond_29

    goto :goto_6

    .line 1119
    :cond_29
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v2

    const-string v4, " (expected space after version value in xml declaration)"

    invoke-virtual {v0, v11, v2, v4}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    goto :goto_7

    .line 1117
    :cond_2a
    :goto_6
    const/16 v2, 0x8

    iput v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1122
    .end local v1    # "b":B
    :goto_7
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v1, v2, :cond_2b

    .line 1123
    goto/16 :goto_0

    .line 1128
    :cond_2b
    :pswitch_e
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->asyncSkipSpace()Z

    move-result v1

    if-nez v1, :cond_2c

    .line 1129
    goto/16 :goto_0

    .line 1132
    :cond_2c
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    .line 1133
    .restart local v1    # "b":B
    if-ne v1, v8, :cond_2d

    .line 1134
    iput v9, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1135
    goto/16 :goto_0

    .line 1137
    :cond_2d
    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_parseNewXmlDeclName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    iput-object v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    if-nez v2, :cond_2e

    .line 1138
    const/16 v2, 0x9

    iput v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1139
    goto/16 :goto_0

    .line 1142
    :cond_2e
    iget-object v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v2, v5}, Lcom/fasterxml/aalto/in/PName;->hasPrefixedName(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2f

    .line 1143
    const/16 v2, 0xa

    iput v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    goto :goto_8

    .line 1144
    :cond_2f
    iget-object v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v2, v6}, Lcom/fasterxml/aalto/in/PName;->hasPrefixedName(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_30

    .line 1145
    iput v15, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1146
    goto/16 :goto_0

    .line 1148
    :cond_30
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v4, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v4}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "\' in XML declaration: expected \'encoding\'"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1151
    .end local v1    # "b":B
    :goto_8
    goto/16 :goto_0

    .line 1052
    :pswitch_f
    invoke-direct/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_parseXmlDeclName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    iput-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    if-nez v1, :cond_31

    .line 1053
    goto/16 :goto_0

    .line 1055
    :cond_31
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v1, v7}, Lcom/fasterxml/aalto/in/PName;->hasPrefixedName(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_32

    .line 1056
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\' in XML declaration: expected \'version\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1058
    :cond_32
    const/4 v1, 0x4

    iput v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1059
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v1, v2, :cond_33

    .line 1060
    goto/16 :goto_0

    .line 1064
    :cond_33
    :pswitch_10
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->asyncSkipSpace()Z

    move-result v1

    if-nez v1, :cond_34

    .line 1065
    goto/16 :goto_0

    .line 1068
    :cond_34
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    .line 1069
    .restart local v1    # "b":B
    if-eq v1, v12, :cond_35

    .line 1070
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v2

    const-string v4, " (expected \'=\' after \'version\' in xml declaration)"

    invoke-virtual {v0, v11, v2, v4}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    .line 1073
    .end local v1    # "b":B
    :cond_35
    const/4 v1, 0x5

    iput v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1074
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v1, v2, :cond_36

    .line 1075
    goto/16 :goto_0

    .line 1079
    :cond_36
    :pswitch_11
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->asyncSkipSpace()Z

    move-result v1

    if-nez v1, :cond_37

    .line 1080
    goto/16 :goto_0

    .line 1082
    :cond_37
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    iput-byte v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    .line 1083
    iget-byte v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    const/16 v2, 0x22

    if-eq v1, v2, :cond_38

    iget-byte v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    const/16 v2, 0x27

    if-eq v1, v2, :cond_38

    .line 1084
    iget-byte v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v1

    const-string v2, " (expected \'\"\' or \'\'\' in xml declaration for version value)"

    invoke-virtual {v0, v11, v1, v2}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    .line 1087
    :cond_38
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v1

    .line 1088
    .local v1, "buf":[C
    iget v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v4, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-ge v2, v4, :cond_3a

    invoke-virtual {v0, v1, v14}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->parseXmlDeclAttr([CI)Z

    move-result v2

    if-nez v2, :cond_39

    goto :goto_9

    .line 1093
    .end local v1    # "buf":[C
    :cond_39
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->verifyAndSetXmlVersion()V

    .line 1094
    iput v10, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1095
    goto/16 :goto_0

    .line 1089
    .restart local v1    # "buf":[C
    :cond_3a
    :goto_9
    const/4 v2, 0x6

    iput v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1090
    goto/16 :goto_0

    .line 1027
    .end local v1    # "buf":[C
    :pswitch_12
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    .line 1028
    .local v1, "b":B
    const/16 v2, 0x20

    if-eq v1, v2, :cond_3c

    const/16 v2, 0xd

    if-eq v1, v2, :cond_3c

    const/16 v2, 0xa

    if-eq v1, v2, :cond_3c

    const/16 v2, 0x9

    if-ne v1, v2, :cond_3b

    goto :goto_a

    .line 1031
    :cond_3b
    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v2

    const-string v4, " (expected space after \'xml\' in xml declaration)"

    invoke-virtual {v0, v11, v2, v4}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    goto :goto_b

    .line 1029
    :cond_3c
    :goto_a
    const/4 v2, 0x2

    iput v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1034
    .end local v1    # "b":B
    :goto_b
    iget v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v1, v2, :cond_3d

    .line 1035
    goto/16 :goto_0

    .line 1039
    :cond_3d
    :pswitch_13
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->asyncSkipSpace()Z

    move-result v1

    if-nez v1, :cond_3e

    .line 1040
    goto/16 :goto_0

    .line 1042
    :cond_3e
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_parseNewXmlDeclName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    iput-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    if-nez v1, :cond_3f

    .line 1043
    const/4 v1, 0x3

    iput v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1044
    goto/16 :goto_0

    .line 1046
    :cond_3f
    iget-object v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v1, v7}, Lcom/fasterxml/aalto/in/PName;->hasPrefixedName(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_40

    .line 1047
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\' in XML declaration: expected \'version\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1049
    :cond_40
    const/4 v1, 0x4

    iput v1, v0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1050
    goto/16 :goto_0

    .line 1344
    :cond_41
    return v3

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_12
        :pswitch_13
        :pswitch_f
        :pswitch_10
        :pswitch_11
        :pswitch_c
        :pswitch_d
        :pswitch_e
        :pswitch_9
        :pswitch_a
        :pswitch_b
        :pswitch_6
        :pswitch_7
        :pswitch_8
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method private final parseDtdId([CIZ)Z
    .locals 6
    .param p1, "outputBuffer"    # [C
    .param p2, "outputPtr"    # I
    .param p3, "system"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1616
    iget-byte v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    .line 1617
    .local v0, "quote":I
    :goto_0
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-ge v1, v2, :cond_4

    .line 1618
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 1619
    .local v1, "ch":I
    const/4 v2, 0x1

    if-ne v1, v0, :cond_0

    .line 1620
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3, p2}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 1621
    return v2

    .line 1623
    :cond_0
    if-nez p3, :cond_2

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->validPublicIdChar(I)Z

    move-result v3

    if-nez v3, :cond_2

    .line 1624
    int-to-byte v3, v1

    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " (not valid in "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    if-eqz p3, :cond_1

    const-string v5, "SYSTEM"

    goto :goto_1

    :cond_1
    const-string v5, "PUBLIC"

    :goto_1
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " ID)"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v2, v3, v4}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    .line 1626
    :cond_2
    array-length v2, p1

    if-lt p2, v2, :cond_3

    .line 1627
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object p1

    .line 1628
    const/4 p2, 0x0

    .line 1630
    :cond_3
    add-int/lit8 v2, p2, 0x1

    .end local p2    # "outputPtr":I
    .local v2, "outputPtr":I
    int-to-char v3, v1

    aput-char v3, p1, p2

    .line 1631
    .end local v1    # "ch":I
    move p2, v2

    goto :goto_0

    .line 1632
    .end local v2    # "outputPtr":I
    .restart local p2    # "outputPtr":I
    :cond_4
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1, p2}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 1633
    const/4 v1, 0x0

    return v1
.end method

.method private final startXmlDeclaration()Ljava/lang/Boolean;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 956
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    const/4 v2, 0x0

    if-lt v0, v1, :cond_0

    .line 957
    return-object v2

    .line 959
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_pendingInput:I

    const/4 v1, -0x5

    const/4 v3, -0x6

    const/4 v4, 0x0

    const/4 v5, 0x1

    if-ne v0, v1, :cond_2

    .line 960
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currentByte()B

    move-result v0

    const/16 v1, 0x3f

    if-eq v0, v1, :cond_1

    .line 961
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_pendingInput:I

    .line 962
    const/4 v0, 0x2

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 963
    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    return-object v0

    .line 965
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    add-int/2addr v0, v5

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    .line 966
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_pendingInput:I

    .line 967
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v0, v1, :cond_2

    .line 968
    return-object v2

    .line 971
    :cond_2
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_pendingInput:I

    const/4 v1, 0x3

    const-string/jumbo v6, "xml"

    const/4 v7, -0x7

    if-ne v0, v3, :cond_5

    .line 972
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v0

    .line 973
    .local v0, "b":B
    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_parseNewXmlDeclName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v3

    iput-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 974
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    if-nez v3, :cond_3

    .line 975
    iput v7, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_pendingInput:I

    .line 976
    return-object v2

    .line 979
    :cond_3
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v6, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_4

    .line 980
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_pendingInput:I

    .line 981
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 982
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextEvent:I

    .line 983
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->checkPITargetName(Lcom/fasterxml/aalto/in/PName;)V

    .line 984
    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    return-object v1

    .line 986
    .end local v0    # "b":B
    :cond_4
    goto :goto_0

    :cond_5
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_pendingInput:I

    if-ne v0, v7, :cond_7

    .line 987
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_parseXmlDeclName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    if-nez v0, :cond_6

    .line 988
    return-object v2

    .line 990
    :cond_6
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_8

    .line 991
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_pendingInput:I

    .line 992
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 993
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextEvent:I

    .line 994
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->checkPITargetName(Lcom/fasterxml/aalto/in/PName;)V

    .line 995
    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    return-object v0

    .line 998
    :cond_7
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->throwInternal()I

    .line 1000
    :cond_8
    :goto_0
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_pendingInput:I

    .line 1001
    const/4 v0, 0x7

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextEvent:I

    .line 1002
    iput v5, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 1003
    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    return-object v0
.end method


# virtual methods
.method protected _activateEncoding()V
    .locals 1

    .line 360
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_symbols:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    if-nez v0, :cond_0

    .line 361
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getCharTypes()Lcom/fasterxml/aalto/util/XmlCharTypes;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    .line 362
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getBBSymbols()Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_symbols:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    .line 364
    :cond_0
    return-void
.end method

.method protected _closeSource()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 390
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_endOfInput:Z

    .line 391
    return-void
.end method

.method protected abstract _currentByte()B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected final _findXmlDeclName(II)Lcom/fasterxml/aalto/in/PName;
    .locals 4
    .param p1, "lastQuad"    # I
    .param p2, "lastByteCount"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1732
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadCount:I

    .line 1734
    .local v0, "qlen":I
    if-nez p2, :cond_0

    .line 1735
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    add-int/lit8 v0, v0, -0x1

    aget p1, v1, v0

    .line 1744
    :cond_0
    const/4 v1, 0x1

    const/4 v2, 0x0

    packed-switch v0, :pswitch_data_0

    .line 1755
    const/4 v2, 0x0

    .local v2, "pname":Lcom/fasterxml/aalto/in/PName;
    goto :goto_0

    .line 1752
    .end local v2    # "pname":Lcom/fasterxml/aalto/in/PName;
    :pswitch_0
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    aget v2, v3, v2

    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    aget v3, v3, v1

    invoke-static {v2, v3, p1}, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->find(III)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    .line 1753
    .restart local v2    # "pname":Lcom/fasterxml/aalto/in/PName;
    goto :goto_0

    .line 1749
    .end local v2    # "pname":Lcom/fasterxml/aalto/in/PName;
    :pswitch_1
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    aget v2, v3, v2

    invoke-static {v2, p1}, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->find(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    .line 1750
    .restart local v2    # "pname":Lcom/fasterxml/aalto/in/PName;
    goto :goto_0

    .line 1746
    .end local v2    # "pname":Lcom/fasterxml/aalto/in/PName;
    :pswitch_2
    invoke-static {p1}, Lcom/fasterxml/aalto/async/AsyncXmlDeclHelper;->find(I)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    .line 1747
    .restart local v2    # "pname":Lcom/fasterxml/aalto/in/PName;
    nop

    .line 1757
    :goto_0
    if-eqz v2, :cond_1

    .line 1759
    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    sub-int/2addr v3, v1

    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    .line 1760
    return-object v2

    .line 1765
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_activateEncoding()V

    .line 1766
    invoke-virtual {p0, p1, p2}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method protected abstract _nextByte()B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract _prevByte()B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected _releaseBuffers()V
    .locals 2

    .line 374
    invoke-super {p0}, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_releaseBuffers()V

    .line 375
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_symbols:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->maybeDirty()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 376
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_symbols:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->updateBBSymbols(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;)V

    .line 378
    :cond_0
    return-void
.end method

.method protected _startDocumentNoXmlDecl()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 920
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_activateEncoding()V

    .line 921
    const/4 v0, 0x7

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currToken:I

    .line 922
    return v0
.end method

.method protected final addPName(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;I[III)Lcom/fasterxml/aalto/in/PName;
    .locals 7
    .param p1, "symbols"    # Lcom/fasterxml/aalto/in/ByteBasedPNameTable;
    .param p2, "hash"    # I
    .param p3, "quads"    # [I
    .param p4, "qlen"    # I
    .param p5, "lastQuadBytes"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 687
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    move-object v0, p0

    move-object v1, p1

    move v3, p2

    move-object v4, p3

    move v5, p4

    move v6, p5

    invoke-virtual/range {v0 .. v6}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->addUTFPName(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;Lcom/fasterxml/aalto/util/XmlCharTypes;I[III)Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    return-object v0
.end method

.method protected abstract asyncSkipSpace()Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected checkPITargetName(Lcom/fasterxml/aalto/in/PName;)V
    .locals 3
    .param p1, "targetName"    # Lcom/fasterxml/aalto/in/PName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 752
    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/PName;->getLocalName()Ljava/lang/String;

    move-result-object v0

    .line 753
    .local v0, "ln":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v2, 0x3

    if-ne v1, v2, :cond_0

    const-string/jumbo v1, "xml"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 754
    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/PName;->hasPrefix()Z

    move-result v1

    if-nez v1, :cond_0

    .line 755
    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_WF_PI_XML_TARGET:Ljava/lang/String;

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 757
    :cond_0
    return-void
.end method

.method protected decodeCharForError(B)I
    .locals 0
    .param p1, "b"    # B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 747
    return p1
.end method

.method public endOfInput()V
    .locals 1

    .line 368
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_endOfInput:Z

    .line 369
    return-void
.end method

.method protected final findPName(II)Lcom/fasterxml/aalto/in/PName;
    .locals 11
    .param p1, "lastQuad"    # I
    .param p2, "lastByteCount"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 640
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    const/4 v1, 0x1

    sub-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    .line 641
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadCount:I

    .line 643
    .local v0, "qlen":I
    if-nez p2, :cond_0

    .line 644
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    add-int/lit8 v0, v0, -0x1

    aget p1, v2, v0

    .line 645
    const/4 p2, 0x4

    .line 648
    :cond_0
    if-gt v0, v1, :cond_4

    .line 649
    const/4 v2, 0x0

    if-nez v0, :cond_2

    .line 650
    invoke-static {p1}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->calcHash(I)I

    move-result v1

    .line 651
    .local v1, "hash":I
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_symbols:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    invoke-virtual {v3, v1, p1, v2}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->findSymbol(III)Lcom/fasterxml/aalto/in/ByteBasedPName;

    move-result-object v8

    .line 652
    .local v8, "name":Lcom/fasterxml/aalto/in/PName;
    if-nez v8, :cond_1

    .line 654
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    aput p1, v3, v2

    .line 655
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_symbols:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    const/4 v6, 0x1

    move-object v2, p0

    move v4, v1

    move v7, p2

    invoke-virtual/range {v2 .. v7}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->addPName(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;I[III)Lcom/fasterxml/aalto/in/PName;

    move-result-object v8

    .line 657
    :cond_1
    return-object v8

    .line 659
    .end local v1    # "hash":I
    .end local v8    # "name":Lcom/fasterxml/aalto/in/PName;
    :cond_2
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    aget v8, v3, v2

    .line 660
    .local v8, "firstQuad":I
    invoke-static {v8, p1}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->calcHash(II)I

    move-result v9

    .line 661
    .local v9, "hash":I
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_symbols:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    invoke-virtual {v2, v9, v8, p1}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->findSymbol(III)Lcom/fasterxml/aalto/in/ByteBasedPName;

    move-result-object v10

    .line 662
    .local v10, "name":Lcom/fasterxml/aalto/in/PName;
    if-nez v10, :cond_3

    .line 664
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    aput p1, v2, v1

    .line 665
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_symbols:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    const/4 v6, 0x2

    move-object v2, p0

    move v4, v9

    move v7, p2

    invoke-virtual/range {v2 .. v7}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->addPName(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;I[III)Lcom/fasterxml/aalto/in/PName;

    move-result-object v10

    .line 667
    :cond_3
    return-object v10

    .line 671
    .end local v8    # "firstQuad":I
    .end local v9    # "hash":I
    .end local v10    # "name":Lcom/fasterxml/aalto/in/PName;
    :cond_4
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    array-length v1, v1

    if-lt v0, v1, :cond_5

    .line 672
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    array-length v2, v2

    invoke-static {v1, v2}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([II)[I

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    .line 674
    :cond_5
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    add-int/lit8 v8, v0, 0x1

    .end local v0    # "qlen":I
    .local v8, "qlen":I
    aput p1, v1, v0

    .line 675
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    invoke-static {v0, v8}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->calcHash([II)I

    move-result v0

    .line 676
    .local v0, "hash":I
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_symbols:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    invoke-virtual {v1, v0, v2, v8}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->findSymbol(I[II)Lcom/fasterxml/aalto/in/ByteBasedPName;

    move-result-object v1

    .line 677
    .local v1, "name":Lcom/fasterxml/aalto/in/PName;
    if-nez v1, :cond_6

    .line 678
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_symbols:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    iget-object v5, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_quadBuffer:[I

    move-object v2, p0

    move v4, v0

    move v6, v8

    move v7, p2

    invoke-virtual/range {v2 .. v7}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->addPName(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;I[III)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    .line 680
    :cond_6
    return-object v1
.end method

.method protected finishCData()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 540
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->throwInternal()I

    .line 541
    return-void
.end method

.method protected abstract finishCharacters()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected finishComment()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 547
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->throwInternal()I

    .line 548
    return-void
.end method

.method protected finishDTD(Z)V
    .locals 0
    .param p1, "copyContents"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 554
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->throwInternal()I

    .line 555
    return-void
.end method

.method protected finishPI()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 561
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->throwInternal()I

    .line 562
    return-void
.end method

.method protected finishSpace()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 568
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->throwInternal()I

    .line 569
    return-void
.end method

.method protected final finishToken()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 482
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenIncomplete:Z

    .line 483
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currToken:I

    packed-switch v0, :pswitch_data_0

    .line 503
    :pswitch_0
    invoke-static {}, Lcom/fasterxml/aalto/impl/ErrorConsts;->throwInternalError()V

    goto :goto_0

    .line 500
    :pswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->finishCData()V

    .line 501
    goto :goto_0

    .line 497
    :pswitch_2
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->finishDTD(Z)V

    .line 498
    goto :goto_0

    .line 494
    :pswitch_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->finishSpace()V

    .line 495
    goto :goto_0

    .line 491
    :pswitch_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->finishComment()V

    .line 492
    goto :goto_0

    .line 488
    :pswitch_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->finishCharacters()V

    .line 489
    goto :goto_0

    .line 485
    :pswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->finishPI()V

    .line 486
    nop

    .line 505
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

.method protected abstract handleAttrValue()Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract handleComment()I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract handleDTDInternalSubset(Z)Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract handleNsDecl()Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract handlePI()I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract handlePartialCR()Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract handleStartElement()I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract handleStartElementStart(B)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected loadMore()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 613
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->throwInternal()I

    .line 614
    const/4 v0, 0x0

    return v0
.end method

.method public final nextFromProlog(Z)I
    .locals 7
    .param p1, "isProlog"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 780
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currToken:I

    const/4 v1, 0x0

    const/4 v2, 0x1

    const/4 v3, 0x3

    const/16 v4, 0x101

    if-eq v0, v4, :cond_1

    .line 782
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->setStartLocation()V

    .line 785
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currToken:I

    const/4 v5, 0x7

    if-ne v0, v5, :cond_0

    .line 786
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currToken:I

    .line 787
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    if-eqz v0, :cond_1

    .line 788
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextEvent:I

    .line 789
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 790
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->checkPITargetName(Lcom/fasterxml/aalto/in/PName;)V

    .line 791
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->handlePI()I

    move-result v0

    return v0

    .line 794
    :cond_0
    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextEvent:I

    iput v4, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currToken:I

    .line 795
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 800
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextEvent:I

    if-ne v0, v4, :cond_1a

    .line 802
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    const/16 v5, 0x3c

    if-ne v0, v2, :cond_9

    .line 803
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v0, v3, :cond_2

    .line 804
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currToken:I

    return v0

    .line 807
    :cond_2
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_pendingInput:I

    if-eqz v0, :cond_5

    .line 808
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->startXmlDeclaration()Ljava/lang/Boolean;

    move-result-object v0

    .line 809
    .local v0, "b":Ljava/lang/Boolean;
    if-nez v0, :cond_3

    .line 810
    return v4

    .line 812
    :cond_3
    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    if-ne v0, v1, :cond_4

    .line 813
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_startDocumentNoXmlDecl()I

    move-result v1

    return v1

    .line 815
    :cond_4
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->handleXmlDeclaration()I

    move-result v1

    return v1

    .line 817
    .end local v0    # "b":Ljava/lang/Boolean;
    :cond_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currentByte()B

    move-result v0

    if-ne v0, v5, :cond_8

    .line 818
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    add-int/2addr v0, v2

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    .line 819
    const/4 v0, -0x5

    iput v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_pendingInput:I

    .line 820
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->startXmlDeclaration()Ljava/lang/Boolean;

    move-result-object v0

    .line 821
    .restart local v0    # "b":Ljava/lang/Boolean;
    if-nez v0, :cond_6

    .line 822
    return v4

    .line 824
    :cond_6
    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    if-ne v0, v1, :cond_7

    .line 825
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_startDocumentNoXmlDecl()I

    move-result v1

    return v1

    .line 827
    :cond_7
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->handleXmlDeclaration()I

    move-result v1

    return v1

    .line 830
    .end local v0    # "b":Ljava/lang/Boolean;
    :cond_8
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 831
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_startDocumentNoXmlDecl()I

    move-result v0

    return v0

    .line 835
    :cond_9
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_pendingInput:I

    if-eqz v0, :cond_a

    .line 836
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->handlePartialCR()Z

    move-result v0

    if-nez v0, :cond_a

    .line 837
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currToken:I

    return v0

    .line 840
    :cond_a
    :goto_0
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    const/4 v2, 0x2

    if-nez v0, :cond_12

    .line 841
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    const/4 v6, -0x1

    if-lt v0, v4, :cond_c

    .line 842
    iget-boolean v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_endOfInput:Z

    if-eqz v0, :cond_b

    .line 843
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->setStartLocation()V

    .line 844
    return v6

    .line 846
    :cond_b
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currToken:I

    return v0

    .line 848
    :cond_c
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v0

    .line 852
    .local v0, "b":B
    if-ne v0, v5, :cond_d

    .line 853
    iput v2, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 854
    goto :goto_3

    .line 856
    :cond_d
    const/16 v2, 0x20

    if-eq v0, v2, :cond_f

    const/16 v2, 0xd

    if-eq v0, v2, :cond_f

    const/16 v2, 0xa

    if-eq v0, v2, :cond_f

    const/16 v2, 0x9

    if-ne v0, v2, :cond_e

    goto :goto_1

    .line 867
    :cond_e
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v2

    const/4 v4, 0x0

    invoke-virtual {p0, p1, v2, v4}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    goto :goto_2

    .line 859
    :cond_f
    :goto_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->asyncSkipSpace()Z

    move-result v2

    if-nez v2, :cond_11

    .line 860
    iget-boolean v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_endOfInput:Z

    if-eqz v1, :cond_10

    .line 861
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->setStartLocation()V

    .line 862
    return v6

    .line 864
    :cond_10
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currToken:I

    return v1

    .line 869
    .end local v0    # "b":B
    :cond_11
    :goto_2
    goto :goto_0

    .line 870
    :cond_12
    :goto_3
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    if-ne v0, v2, :cond_18

    .line 871
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-lt v0, v2, :cond_13

    .line 872
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_currToken:I

    return v0

    .line 874
    :cond_13
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v0

    .line 875
    .restart local v0    # "b":B
    const/16 v2, 0x21

    if-ne v0, v2, :cond_14

    .line 876
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 877
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->handlePrologDeclStart(Z)I

    move-result v1

    return v1

    .line 879
    :cond_14
    const/16 v2, 0x3f

    if-ne v0, v2, :cond_15

    .line 880
    iput v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextEvent:I

    .line 881
    iput v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    .line 882
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->handlePI()I

    move-result v1

    return v1

    .line 884
    :cond_15
    const/16 v1, 0x2f

    if-eq v0, v1, :cond_16

    if-nez p1, :cond_17

    .line 885
    :cond_16
    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpElement(ZI)V

    .line 887
    :cond_17
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->handleStartElementStart(B)I

    move-result v1

    return v1

    .line 889
    .end local v0    # "b":B
    :cond_18
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_state:I

    if-ne v0, v3, :cond_19

    .line 890
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->handlePrologDeclStart(Z)I

    move-result v0

    return v0

    .line 893
    :cond_19
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->throwInternal()I

    move-result v0

    return v0

    .line 897
    :cond_1a
    iget v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextEvent:I

    sparse-switch v0, :sswitch_data_0

    .line 909
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->throwInternal()I

    move-result v0

    return v0

    .line 907
    :sswitch_0
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->handleDTD()I

    move-result v0

    return v0

    .line 901
    :sswitch_1
    invoke-direct {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->handleXmlDeclaration()I

    move-result v0

    return v0

    .line 905
    :sswitch_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->handleComment()I

    move-result v0

    return v0

    .line 903
    :sswitch_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->handlePI()I

    move-result v0

    return v0

    .line 899
    :sswitch_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->handleStartElement()I

    move-result v0

    return v0

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_4
        0x3 -> :sswitch_3
        0x5 -> :sswitch_2
        0x7 -> :sswitch_1
        0xb -> :sswitch_0
    .end sparse-switch
.end method

.method protected abstract parseNewName(B)Lcom/fasterxml/aalto/in/PName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract parsePName()Lcom/fasterxml/aalto/in/PName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected parseXmlDeclAttr([CI)Z
    .locals 5
    .param p1, "outputBuffer"    # [C
    .param p2, "outputPtr"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1781
    iget-byte v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_elemAttrQuote:B

    .line 1782
    .local v0, "quote":I
    :goto_0
    iget v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputEnd:I

    if-ge v1, v2, :cond_4

    .line 1783
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_nextByte()B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 1784
    .local v1, "ch":I
    const/4 v2, 0x1

    if-ne v1, v0, :cond_0

    .line 1785
    iget-object v3, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3, p2}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 1786
    return v2

    .line 1789
    :cond_0
    const/16 v3, 0x20

    if-le v1, v3, :cond_1

    const/16 v3, 0x7a

    if-le v1, v3, :cond_2

    .line 1790
    :cond_1
    int-to-byte v3, v1

    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->decodeCharForError(B)I

    move-result v3

    const-string v4, " (not valid in XML pseudo-attribute values)"

    invoke-virtual {p0, v2, v3, v4}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    .line 1792
    :cond_2
    array-length v2, p1

    if-lt p2, v2, :cond_3

    .line 1793
    iget-object v2, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object p1

    .line 1794
    const/4 p2, 0x0

    .line 1796
    :cond_3
    add-int/lit8 v2, p2, 0x1

    .end local p2    # "outputPtr":I
    .local v2, "outputPtr":I
    int-to-char v3, v1

    aput-char v3, p1, p2

    .line 1797
    .end local v1    # "ch":I
    move p2, v2

    goto :goto_0

    .line 1798
    .end local v2    # "outputPtr":I
    .restart local p2    # "outputPtr":I
    :cond_4
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1, p2}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 1799
    const/4 v1, 0x0

    return v1
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

    .line 765
    iput p2, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_inputPtr:I

    .line 766
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportInvalidOther(I)V

    .line 767
    return-void
.end method

.method protected skipCData()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 585
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->throwInternal()I

    .line 586
    return-void
.end method

.method protected abstract skipCharacters()Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected skipComment()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 592
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->throwInternal()I

    .line 593
    return-void
.end method

.method protected skipPI()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 599
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->throwInternal()I

    .line 600
    return-void
.end method

.method protected skipSpace()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 606
    invoke-virtual {p0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->throwInternal()I

    .line 607
    return-void
.end method

.method protected abstract startCharacters(B)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected throwInternal()I
    .locals 2

    .line 760
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Internal error: should never execute this code path"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected validPublicIdChar(I)Z
    .locals 1
    .param p1, "c"    # I

    .line 722
    const/16 v0, 0xa

    if-eq p1, v0, :cond_7

    const/16 v0, 0xd

    if-eq p1, v0, :cond_7

    const/16 v0, 0x20

    if-eq p1, v0, :cond_7

    const/16 v0, 0x30

    if-lt p1, v0, :cond_0

    const/16 v0, 0x39

    if-le p1, v0, :cond_7

    :cond_0
    const/16 v0, 0x40

    if-lt p1, v0, :cond_1

    const/16 v0, 0x5a

    if-le p1, v0, :cond_7

    :cond_1
    const/16 v0, 0x61

    if-lt p1, v0, :cond_2

    const/16 v0, 0x7a

    if-le p1, v0, :cond_7

    :cond_2
    const/16 v0, 0x21

    if-eq p1, v0, :cond_7

    const/16 v0, 0x23

    if-lt p1, v0, :cond_3

    const/16 v0, 0x25

    if-le p1, v0, :cond_7

    :cond_3
    const/16 v0, 0x27

    if-lt p1, v0, :cond_4

    const/16 v0, 0x2f

    if-le p1, v0, :cond_7

    :cond_4
    const/16 v0, 0x3a

    if-lt p1, v0, :cond_5

    const/16 v0, 0x3b

    if-le p1, v0, :cond_7

    :cond_5
    const/16 v0, 0x3d

    if-eq p1, v0, :cond_7

    const/16 v0, 0x3f

    if-eq p1, v0, :cond_7

    const/16 v0, 0x5f

    if-ne p1, v0, :cond_6

    goto :goto_0

    :cond_6
    const/4 v0, 0x0

    goto :goto_1

    :cond_7
    :goto_0
    const/4 v0, 0x1

    :goto_1
    return v0
.end method

.method protected verifyAndAppendEntityCharacter(I)V
    .locals 3
    .param p1, "charFromEntity"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 702
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->verifyXmlChar(I)V

    .line 704
    shr-int/lit8 v0, p1, 0x10

    if-eqz v0, :cond_0

    .line 705
    const/high16 v0, 0x10000

    sub-int/2addr p1, v0

    .line 706
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    shr-int/lit8 v1, p1, 0xa

    const v2, 0xd800

    or-int/2addr v1, v2

    int-to-char v1, v1

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->append(C)V

    .line 707
    and-int/lit16 v0, p1, 0x3ff

    const v1, 0xdc00

    or-int p1, v0, v1

    .line 709
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    int-to-char v1, p1

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->append(C)V

    .line 710
    return-void
.end method

.method protected verifyAndSetPublicId()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 438
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->contentsAsString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_publicId:Ljava/lang/String;

    .line 439
    return-void
.end method

.method protected verifyAndSetSystemId()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 442
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->contentsAsString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_systemId:Ljava/lang/String;

    .line 443
    return-void
.end method

.method protected verifyAndSetXmlEncoding()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 412
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->contentsAsString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/fasterxml/aalto/util/CharsetNames;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 413
    .local v0, "enc":Ljava/lang/String;
    const-string v1, "UTF-8"

    if-eq v1, v0, :cond_0

    const-string v1, "US-ASCII"

    if-eq v1, v0, :cond_0

    const-string v1, "ISO-8859-1"

    if-eq v1, v0, :cond_0

    .line 415
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unsupported encoding \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\': only UTF-8 and US-ASCII support by async parser"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 419
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v1, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->setXmlEncoding(Ljava/lang/String;)V

    .line 420
    if-eqz v0, :cond_1

    .line 421
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v1, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->setActualEncoding(Ljava/lang/String;)V

    .line 423
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->getCharTypes()Lcom/fasterxml/aalto/util/XmlCharTypes;

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    .line 424
    return-void
.end method

.method protected verifyAndSetXmlStandalone()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 428
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    const-string/jumbo v1, "yes"

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->equalsString(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 429
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->setXmlStandalone(Ljava/lang/Boolean;)V

    goto :goto_0

    .line 430
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    const-string v1, "no"

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->equalsString(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 431
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->setXmlStandalone(Ljava/lang/Boolean;)V

    goto :goto_0

    .line 433
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Invalid standalone value \'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->contentsAsString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\': can only use \'yes\' and \'no\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 435
    :goto_0
    return-void
.end method

.method protected verifyAndSetXmlVersion()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 401
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    const-string v1, "1.0"

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->equalsString(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 402
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->setXmlVersion(Ljava/lang/String;)V

    goto :goto_0

    .line 403
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    const-string v1, "1.1"

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->equalsString(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 404
    iget-object v0, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->setXmlVersion(Ljava/lang/String;)V

    goto :goto_0

    .line 406
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Unrecognized XML version \'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/fasterxml/aalto/async/AsyncByteScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->contentsAsString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\' (expected \'1.0\' or \'1.1\')"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/async/AsyncByteScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 408
    :goto_0
    return-void
.end method
