.class public abstract Lcom/fasterxml/aalto/in/StreamScanner;
.super Lcom/fasterxml/aalto/in/ByteBasedScanner;
.source "StreamScanner.java"


# instance fields
.field protected final _charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

.field protected _in:Ljava/io/InputStream;

.field protected _inputBuffer:[B

.field protected _quadBuffer:[I

.field protected final _symbols:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;


# direct methods
.method public constructor <init>(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/InputStream;[BII)V
    .locals 1
    .param p1, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;
    .param p2, "in"    # Ljava/io/InputStream;
    .param p3, "buffer"    # [B
    .param p4, "ptr"    # I
    .param p5, "last"    # I

    .line 84
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/in/ByteBasedScanner;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V

    .line 73
    const/16 v0, 0x20

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_quadBuffer:[I

    .line 85
    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/ReaderConfig;->getCharTypes()Lcom/fasterxml/aalto/util/XmlCharTypes;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    .line 86
    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/ReaderConfig;->getBBSymbols()Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_symbols:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    .line 88
    iput-object p2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_in:Ljava/io/InputStream;

    .line 89
    iput-object p3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    .line 90
    iput p4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    .line 91
    iput p5, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    .line 92
    return-void
.end method

.method private final findPName(II)Lcom/fasterxml/aalto/in/PName;
    .locals 5
    .param p1, "onlyQuad"    # I
    .param p2, "lastByteCount"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1131
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    const/4 v1, 0x1

    sub-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    .line 1132
    invoke-static {p1}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->calcHash(I)I

    move-result v0

    .line 1133
    .local v0, "hash":I
    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_symbols:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    const/4 v3, 0x0

    invoke-virtual {v2, v0, p1, v3}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->findSymbol(III)Lcom/fasterxml/aalto/in/ByteBasedPName;

    move-result-object v2

    .line 1134
    .local v2, "name":Lcom/fasterxml/aalto/in/PName;
    if-nez v2, :cond_0

    .line 1136
    iget-object v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_quadBuffer:[I

    aput p1, v4, v3

    .line 1137
    iget-object v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_quadBuffer:[I

    invoke-virtual {p0, v0, v3, v1, p2}, Lcom/fasterxml/aalto/in/StreamScanner;->addPName(I[III)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    .line 1139
    :cond_0
    return-object v2
.end method

.method private final findPName(III)Lcom/fasterxml/aalto/in/PName;
    .locals 5
    .param p1, "firstQuad"    # I
    .param p2, "secondQuad"    # I
    .param p3, "lastByteCount"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1158
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    const/4 v1, 0x1

    sub-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    .line 1159
    invoke-static {p1, p2}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->calcHash(II)I

    move-result v0

    .line 1160
    .local v0, "hash":I
    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_symbols:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    invoke-virtual {v2, v0, p1, p2}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->findSymbol(III)Lcom/fasterxml/aalto/in/ByteBasedPName;

    move-result-object v2

    .line 1161
    .local v2, "name":Lcom/fasterxml/aalto/in/PName;
    if-nez v2, :cond_0

    .line 1163
    iget-object v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_quadBuffer:[I

    const/4 v4, 0x0

    aput p1, v3, v4

    .line 1164
    iget-object v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_quadBuffer:[I

    aput p2, v3, v1

    .line 1165
    iget-object v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_quadBuffer:[I

    const/4 v3, 0x2

    invoke-virtual {p0, v0, v1, v3, p3}, Lcom/fasterxml/aalto/in/StreamScanner;->addPName(I[III)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    .line 1167
    :cond_0
    return-object v2
.end method

.method private final findPName(IIII[I)Lcom/fasterxml/aalto/in/PName;
    .locals 1
    .param p1, "lastQuad"    # I
    .param p2, "lastByteCount"    # I
    .param p3, "firstQuad"    # I
    .param p4, "qlen"    # I
    .param p5, "quads"    # [I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1229
    const/4 v0, 0x1

    if-gt p4, v0, :cond_1

    .line 1230
    if-nez p4, :cond_0

    .line 1231
    invoke-direct {p0, p1, p2}, Lcom/fasterxml/aalto/in/StreamScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    return-object v0

    .line 1233
    :cond_0
    invoke-direct {p0, p3, p1, p2}, Lcom/fasterxml/aalto/in/StreamScanner;->findPName(III)Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    return-object v0

    .line 1235
    :cond_1
    invoke-direct {p0, p1, p5, p4, p2}, Lcom/fasterxml/aalto/in/StreamScanner;->findPName(I[III)Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    return-object v0
.end method

.method private final findPName(I[III)Lcom/fasterxml/aalto/in/PName;
    .locals 2
    .param p1, "lastQuad"    # I
    .param p2, "quads"    # [I
    .param p3, "qlen"    # I
    .param p4, "lastByteCount"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1190
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    .line 1194
    array-length v0, p2

    if-lt p3, v0, :cond_0

    .line 1195
    array-length v0, p2

    invoke-static {p2, v0}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([II)[I

    move-result-object v0

    move-object p2, v0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_quadBuffer:[I

    .line 1197
    :cond_0
    add-int/lit8 v0, p3, 0x1

    .end local p3    # "qlen":I
    .local v0, "qlen":I
    aput p1, p2, p3

    .line 1198
    invoke-static {p2, v0}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->calcHash([II)I

    move-result p3

    .line 1199
    .local p3, "hash":I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_symbols:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    invoke-virtual {v1, p3, p2, v0}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->findSymbol(I[II)Lcom/fasterxml/aalto/in/ByteBasedPName;

    move-result-object v1

    .line 1200
    .local v1, "name":Lcom/fasterxml/aalto/in/PName;
    if-nez v1, :cond_1

    .line 1201
    invoke-virtual {p0, p3, p2, v0, p4}, Lcom/fasterxml/aalto/in/StreamScanner;->addPName(I[III)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    .line 1203
    :cond_1
    return-object v1
.end method

.method private final handleCommentOrCdataStart()I
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 412
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 413
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 415
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 418
    .local v0, "b":B
    const/16 v1, 0x2d

    const/4 v2, 0x1

    if-ne v0, v1, :cond_4

    .line 419
    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v3, v4, :cond_1

    .line 420
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 422
    :cond_1
    iget-object v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v0, v3, v4

    .line 423
    if-eq v0, v1, :cond_2

    .line 424
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->decodeCharForError(B)I

    move-result v1

    const-string v3, " (expected \'-\' for COMMENT)"

    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/in/StreamScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 426
    :cond_2
    iget-boolean v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_cfgLazyParsing:Z

    if-eqz v1, :cond_3

    .line 427
    iput-boolean v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenIncomplete:Z

    goto :goto_0

    .line 429
    :cond_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->finishComment()V

    .line 431
    :goto_0
    const/4 v1, 0x5

    iput v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_currToken:I

    return v1

    .line 435
    :cond_4
    const/16 v1, 0x5b

    if-ne v0, v1, :cond_9

    .line 436
    const/16 v1, 0xc

    iput v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_currToken:I

    .line 437
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_1
    const/4 v4, 0x6

    if-ge v3, v4, :cond_7

    .line 438
    iget v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v4, v5, :cond_5

    .line 439
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 441
    :cond_5
    iget-object v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v0, v4, v5

    .line 442
    const-string v4, "CDATA["

    invoke-virtual {v4, v3}, Ljava/lang/String;->charAt(I)C

    move-result v5

    int-to-byte v5, v5

    if-eq v0, v5, :cond_6

    .line 443
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->decodeCharForError(B)I

    move-result v5

    .line 444
    .local v5, "ch":I
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, " (expected \'"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v4, v3}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v6, "\' for CDATA section)"

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v5, v4}, Lcom/fasterxml/aalto/in/StreamScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 437
    .end local v5    # "ch":I
    :cond_6
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 447
    .end local v3    # "i":I
    :cond_7
    iget-boolean v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_cfgLazyParsing:Z

    if-eqz v3, :cond_8

    .line 448
    iput-boolean v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenIncomplete:Z

    goto :goto_2

    .line 450
    :cond_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->finishCData()V

    .line 452
    :goto_2
    return v1

    .line 454
    :cond_9
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->decodeCharForError(B)I

    move-result v1

    const-string v2, " (expected either \'-\' for COMMENT or \'[CDATA[\' for CDATA section)"

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/in/StreamScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 455
    const/4 v1, -0x1

    return v1
.end method

.method private final handleDtdStart()I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 362
    const-string v0, "DOCTYPE"

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->matchAsciiKeyword(Ljava/lang/String;)V

    .line 365
    const-string v0, "after DOCTYPE keyword, before root name"

    const/4 v1, 0x1

    invoke-virtual {p0, v1, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->skipInternalWs(ZLjava/lang/String;)B

    move-result v0

    .line 366
    .local v0, "b":B
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->parsePName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    iput-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 367
    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/aalto/in/StreamScanner;->skipInternalWs(ZLjava/lang/String;)B

    move-result v0

    .line 369
    const/16 v4, 0x50

    if-ne v0, v4, :cond_0

    .line 370
    const-string v4, "PUBLIC"

    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/StreamScanner;->matchAsciiKeyword(Ljava/lang/String;)V

    .line 371
    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/in/StreamScanner;->skipInternalWs(ZLjava/lang/String;)B

    move-result v0

    .line 372
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->parsePublicId(B)Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_publicId:Ljava/lang/String;

    .line 373
    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/in/StreamScanner;->skipInternalWs(ZLjava/lang/String;)B

    move-result v0

    .line 374
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->parseSystemId(B)Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_systemId:Ljava/lang/String;

    .line 375
    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/aalto/in/StreamScanner;->skipInternalWs(ZLjava/lang/String;)B

    move-result v0

    goto :goto_0

    .line 376
    :cond_0
    const/16 v4, 0x53

    if-ne v0, v4, :cond_1

    .line 377
    const-string v4, "SYSTEM"

    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/StreamScanner;->matchAsciiKeyword(Ljava/lang/String;)V

    .line 378
    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/in/StreamScanner;->skipInternalWs(ZLjava/lang/String;)B

    move-result v0

    .line 379
    iput-object v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_publicId:Ljava/lang/String;

    .line 380
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->parseSystemId(B)Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_systemId:Ljava/lang/String;

    .line 381
    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/aalto/in/StreamScanner;->skipInternalWs(ZLjava/lang/String;)B

    move-result v0

    goto :goto_0

    .line 383
    :cond_1
    iput-object v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_systemId:Ljava/lang/String;

    iput-object v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_publicId:Ljava/lang/String;

    .line 389
    :goto_0
    const/16 v3, 0x3e

    const/16 v4, 0xb

    if-ne v0, v3, :cond_2

    .line 390
    iput-boolean v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenIncomplete:Z

    .line 391
    iput v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_currToken:I

    return v4

    .line 394
    :cond_2
    const/16 v2, 0x5b

    if-eq v0, v2, :cond_4

    .line 395
    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_systemId:Ljava/lang/String;

    if-eqz v2, :cond_3

    const-string v2, " (expected \'[\' for the internal subset, or \'>\' to end DOCTYPE declaration)"

    goto :goto_1

    :cond_3
    const-string v2, " (expected a \'PUBLIC\' or \'SYSTEM\' keyword, \'[\' for the internal subset, or \'>\' to end DOCTYPE declaration)"

    .line 398
    .local v2, "msg":Ljava/lang/String;
    :goto_1
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->decodeCharForError(B)I

    move-result v3

    invoke-virtual {p0, v3, v2}, Lcom/fasterxml/aalto/in/StreamScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 405
    .end local v2    # "msg":Ljava/lang/String;
    :cond_4
    iput-boolean v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenIncomplete:Z

    .line 406
    iput v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_currToken:I

    return v4
.end method

.method private final handleEndElementSlow(I)I
    .locals 8
    .param p1, "size"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 696
    add-int/lit8 p1, p1, -0x1

    .line 697
    const/4 v0, 0x0

    .local v0, "qix":I
    :goto_0
    if-ge v0, p1, :cond_3

    .line 698
    const/4 v1, 0x0

    .line 699
    .local v1, "q":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_1
    const/4 v3, 0x4

    if-ge v2, v3, :cond_1

    .line 700
    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v3, v4, :cond_0

    .line 701
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 703
    :cond_0
    shl-int/lit8 v3, v1, 0x8

    iget-object v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v4, v4, v5

    and-int/lit16 v4, v4, 0xff

    or-int v1, v3, v4

    .line 699
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 706
    .end local v2    # "i":I
    :cond_1
    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v2, v0}, Lcom/fasterxml/aalto/in/PName;->getQuad(I)I

    move-result v2

    if-eq v1, v2, :cond_2

    .line 707
    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/StreamScanner;->reportUnexpectedEndTag(Ljava/lang/String;)V

    .line 697
    .end local v1    # "q":I
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 712
    .end local v0    # "qix":I
    :cond_3
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/PName;->getQuad(I)I

    move-result v0

    .line 713
    .local v0, "lastQ":I
    const/4 v1, 0x0

    .line 714
    .restart local v1    # "q":I
    const/4 v2, 0x0

    .line 717
    .restart local v2    # "i":I
    :cond_4
    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v3, v4, :cond_5

    .line 718
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 720
    :cond_5
    shl-int/lit8 v3, v1, 0x8

    iget-object v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v4, v4, v5

    and-int/lit16 v4, v4, 0xff

    or-int v1, v3, v4

    .line 721
    if-ne v1, v0, :cond_6

    .line 722
    goto :goto_2

    .line 724
    :cond_6
    add-int/lit8 v2, v2, 0x1

    const/4 v3, 0x3

    if-le v2, v3, :cond_4

    .line 725
    iget-object v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/in/StreamScanner;->reportUnexpectedEndTag(Ljava/lang/String;)V

    .line 726
    nop

    .line 731
    :goto_2
    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v3, v4, :cond_7

    .line 732
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 734
    :cond_7
    iget-object v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v3, v3, v4

    .line 735
    .local v3, "i2":I
    :goto_3
    const/16 v4, 0x20

    if-gt v3, v4, :cond_e

    .line 736
    const/16 v5, 0xa

    if-ne v3, v5, :cond_8

    .line 737
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->markLF()V

    goto :goto_6

    .line 738
    :cond_8
    const/16 v6, 0xd

    if-ne v3, v6, :cond_b

    .line 739
    iget v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-ge v4, v6, :cond_9

    iget-object v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v4, v4, v6

    goto :goto_4

    :cond_9
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadOne()B

    move-result v4

    .line 740
    .local v4, "b":B
    :goto_4
    if-eq v4, v5, :cond_a

    .line 741
    iget v5, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v5, v5, -0x1

    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/in/StreamScanner;->markLF(I)V

    .line 742
    and-int/lit16 v3, v4, 0xff

    .line 743
    goto :goto_3

    .line 745
    :cond_a
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->markLF()V

    .end local v4    # "b":B
    goto :goto_5

    .line 746
    :cond_b
    if-eq v3, v4, :cond_c

    const/16 v4, 0x9

    if-eq v3, v4, :cond_c

    .line 747
    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/in/StreamScanner;->throwInvalidSpace(I)V

    goto :goto_6

    .line 746
    :cond_c
    :goto_5
    nop

    .line 749
    :goto_6
    iget v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-ge v4, v5, :cond_d

    iget-object v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v4, v4, v5

    goto :goto_7

    :cond_d
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadOne()B

    move-result v4

    :goto_7
    and-int/lit16 v3, v4, 0xff

    goto :goto_3

    .line 751
    :cond_e
    const/16 v4, 0x3e

    if-eq v3, v4, :cond_f

    .line 752
    int-to-byte v4, v3

    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/StreamScanner;->decodeCharForError(B)I

    move-result v4

    const-string v5, " expected space or closing \'>\'"

    invoke-virtual {p0, v4, v5}, Lcom/fasterxml/aalto/in/StreamScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 754
    :cond_f
    const/4 v4, 0x2

    return v4
.end method

.method private final handlePIStart()I
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 464
    const/4 v0, 0x3

    iput v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_currToken:I

    .line 467
    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v1, v2, :cond_0

    .line 468
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 470
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v1, v1, v2

    .line 471
    .local v1, "b":B
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/StreamScanner;->parsePName(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    iput-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 473
    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/in/PName;->getLocalName()Ljava/lang/String;

    move-result-object v2

    .line 474
    .local v2, "ln":Ljava/lang/String;
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    if-ne v3, v0, :cond_1

    const-string/jumbo v3, "xml"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    iget-object v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 475
    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/PName;->getPrefix()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    .line 476
    sget-object v3, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_WF_PI_XML_TARGET:Ljava/lang/String;

    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/in/StreamScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 484
    .end local v2    # "ln":Ljava/lang/String;
    :cond_1
    iget v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v2, v3, :cond_2

    .line 485
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 487
    :cond_2
    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v2, v2, v3

    and-int/lit16 v2, v2, 0xff

    .line 489
    .local v2, "c":I
    const/16 v3, 0x20

    if-gt v2, v3, :cond_b

    .line 492
    :goto_0
    const/16 v4, 0xa

    const/4 v5, 0x1

    if-ne v2, v4, :cond_3

    .line 493
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->markLF()V

    goto :goto_1

    .line 494
    :cond_3
    const/16 v6, 0xd

    if-ne v2, v6, :cond_6

    .line 495
    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v6, v7, :cond_4

    .line 496
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 498
    :cond_4
    iget-object v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v6, v6, v7

    if-ne v6, v4, :cond_5

    .line 499
    iget v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/2addr v4, v5

    iput v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    .line 501
    :cond_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->markLF()V

    goto :goto_1

    .line 502
    :cond_6
    if-eq v2, v3, :cond_7

    const/16 v4, 0x9

    if-eq v2, v4, :cond_7

    .line 503
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/StreamScanner;->throwInvalidSpace(I)V

    .line 505
    :cond_7
    :goto_1
    iget v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v4, v6, :cond_8

    .line 506
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 508
    :cond_8
    iget-object v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v4, v4, v6

    and-int/lit16 v2, v4, 0xff

    .line 509
    if-le v2, v3, :cond_a

    .line 510
    nop

    .line 515
    iget-boolean v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_cfgLazyParsing:Z

    if-eqz v3, :cond_9

    .line 516
    iput-boolean v5, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenIncomplete:Z

    goto :goto_2

    .line 518
    :cond_9
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->finishPI()V

    goto :goto_2

    .line 512
    :cond_a
    iget v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/2addr v4, v5

    iput v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    goto :goto_0

    .line 521
    :cond_b
    const/16 v3, 0x3f

    if-eq v2, v3, :cond_c

    .line 522
    int-to-byte v3, v2

    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/in/StreamScanner;->decodeCharForError(B)I

    move-result v3

    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/in/StreamScanner;->reportMissingPISpace(I)V

    .line 524
    :cond_c
    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v3, v4, :cond_d

    .line 525
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 527
    :cond_d
    iget-object v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v1, v3, v4

    .line 528
    const/16 v3, 0x3e

    if-eq v1, v3, :cond_e

    .line 529
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/StreamScanner;->decodeCharForError(B)I

    move-result v3

    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/in/StreamScanner;->reportMissingPISpace(I)V

    .line 531
    :cond_e
    iget-object v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    .line 532
    const/4 v3, 0x0

    iput-boolean v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenIncomplete:Z

    .line 535
    :goto_2
    return v0
.end method

.method private final handlePrologDeclStart(Z)I
    .locals 6
    .param p1, "isProlog"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 319
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 320
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 322
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 323
    .local v0, "b":B
    const/16 v1, 0x2d

    const/4 v2, 0x1

    if-ne v0, v1, :cond_3

    .line 324
    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v3, v4, :cond_1

    .line 325
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 327
    :cond_1
    iget-object v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v0, v3, v4

    .line 328
    if-ne v0, v1, :cond_5

    .line 329
    iget-boolean v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_cfgLazyParsing:Z

    if-eqz v1, :cond_2

    .line 330
    iput-boolean v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenIncomplete:Z

    goto :goto_0

    .line 332
    :cond_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->finishComment()V

    .line 334
    :goto_0
    const/4 v1, 0x5

    iput v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_currToken:I

    return v1

    .line 336
    :cond_3
    const/16 v1, 0x44

    if-ne v0, v1, :cond_5

    .line 337
    if-eqz p1, :cond_5

    .line 338
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->handleDtdStart()I

    .line 340
    iget-boolean v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_cfgLazyParsing:Z

    if-nez v1, :cond_4

    .line 341
    iget-boolean v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenIncomplete:Z

    if-eqz v1, :cond_4

    .line 342
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/StreamScanner;->finishDTD(Z)V

    .line 343
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenIncomplete:Z

    .line 346
    :cond_4
    const/16 v1, 0xb

    return v1

    .line 353
    :cond_5
    iput-boolean v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenIncomplete:Z

    .line 354
    const/4 v1, 0x4

    iput v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_currToken:I

    .line 355
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->decodeCharForError(B)I

    move-result v1

    const-string v2, " (expected \'-\' for COMMENT)"

    invoke-virtual {p0, p1, v1, v2}, Lcom/fasterxml/aalto/in/StreamScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    .line 356
    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_currToken:I

    return v1
.end method

.method private final matchAsciiKeyword(Ljava/lang/String;)V
    .locals 6
    .param p1, "keyw"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1295
    const/4 v0, 0x1

    .local v0, "i":I
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    .local v1, "len":I
    :goto_0
    if-ge v0, v1, :cond_2

    .line 1296
    iget v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v2, v3, :cond_0

    .line 1297
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 1299
    :cond_0
    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v2, v2, v3

    .line 1300
    .local v2, "b":B
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    int-to-byte v3, v3

    if-eq v2, v3, :cond_1

    .line 1301
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/StreamScanner;->decodeCharForError(B)I

    move-result v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " (expected \'"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "\' for "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " keyword)"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v3, v4}, Lcom/fasterxml/aalto/in/StreamScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 1295
    .end local v2    # "b":B
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1304
    .end local v0    # "i":I
    .end local v1    # "len":I
    :cond_2
    return-void
.end method


# virtual methods
.method protected _closeSource()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 116
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_in:Ljava/io/InputStream;

    if-eqz v0, :cond_0

    .line 117
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_in:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 118
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_in:Ljava/io/InputStream;

    .line 120
    :cond_0
    return-void
.end method

.method protected _nextEntity()I
    .locals 1

    .line 305
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    .line 307
    const/16 v0, 0x9

    iput v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_currToken:I

    return v0
.end method

.method protected _releaseBuffers()V
    .locals 2

    .line 97
    invoke-super {p0}, Lcom/fasterxml/aalto/in/ByteBasedScanner;->_releaseBuffers()V

    .line 98
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_symbols:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->maybeDirty()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 99
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    iget-object v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_symbols:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->updateBBSymbols(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;)V

    .line 105
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_in:Ljava/io/InputStream;

    if-eqz v0, :cond_1

    .line 106
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    if-eqz v0, :cond_1

    .line 107
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    iget-object v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->freeFullBBuffer([B)V

    .line 108
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    .line 111
    :cond_1
    return-void
.end method

.method protected final addPName(I[III)Lcom/fasterxml/aalto/in/PName;
    .locals 7
    .param p1, "hash"    # I
    .param p2, "quads"    # [I
    .param p3, "qlen"    # I
    .param p4, "lastQuadBytes"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1241
    iget-object v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_symbols:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    move-object v0, p0

    move v3, p1

    move-object v4, p2

    move v5, p3

    move v6, p4

    invoke-virtual/range {v0 .. v6}, Lcom/fasterxml/aalto/in/StreamScanner;->addUTFPName(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;Lcom/fasterxml/aalto/util/XmlCharTypes;I[III)Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    return-object v0
.end method

.method protected final checkInTreeIndentation(I)I
    .locals 11
    .param p1, "c"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1320
    const/16 v0, 0xd

    const/4 v1, -0x1

    const/16 v2, 0xa

    const/4 v3, 0x0

    const/16 v4, 0x20

    const/4 v5, 0x1

    if-ne p1, v0, :cond_1

    .line 1322
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v0, v6, :cond_0

    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_0

    .line 1323
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0, v3, v4}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithIndentation(IC)V

    .line 1324
    return v1

    .line 1326
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v0, v0, v6

    if-ne v0, v2, :cond_1

    .line 1327
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/2addr v0, v5

    iput v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    .line 1330
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->markLF()V

    .line 1332
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v0, v6, :cond_2

    .line 1333
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 1335
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v0, v0, v6

    .line 1336
    .local v0, "b":B
    const/16 v6, 0x21

    const/16 v7, 0x3c

    if-eq v0, v4, :cond_4

    const/16 v8, 0x9

    if-eq v0, v8, :cond_4

    .line 1338
    if-ne v0, v7, :cond_3

    .line 1339
    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/2addr v7, v5

    iget v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-ge v7, v8, :cond_3

    iget-object v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/2addr v8, v5

    aget-byte v7, v7, v8

    if-eq v7, v6, :cond_3

    .line 1340
    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2, v3, v4}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithIndentation(IC)V

    .line 1341
    return v1

    .line 1344
    :cond_3
    iget-object v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v1

    .line 1345
    .local v1, "outBuf":[C
    aput-char v2, v1, v3

    .line 1346
    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2, v5}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 1347
    return v5

    .line 1350
    .end local v1    # "outBuf":[C
    :cond_4
    iget v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/2addr v8, v5

    iput v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    .line 1351
    const/4 v8, 0x1

    .line 1352
    .local v8, "count":I
    if-ne v0, v4, :cond_5

    goto :goto_0

    :cond_5
    const/16 v4, 0x8

    .line 1353
    .local v4, "max":I
    :goto_0
    if-gt v8, v4, :cond_8

    .line 1354
    iget v9, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v10, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v9, v10, :cond_6

    .line 1355
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 1357
    :cond_6
    iget-object v9, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v10, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v9, v9, v10

    .line 1358
    .local v9, "b2":B
    if-eq v9, v0, :cond_7

    .line 1360
    if-ne v9, v7, :cond_8

    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/2addr v7, v5

    iget v10, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-ge v7, v10, :cond_8

    iget-object v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v10, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/2addr v10, v5

    aget-byte v7, v7, v10

    if-eq v7, v6, :cond_8

    .line 1362
    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    int-to-char v3, v0

    invoke-virtual {v2, v8, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithIndentation(IC)V

    .line 1363
    return v1

    .line 1367
    :cond_7
    iget v10, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/2addr v10, v5

    iput v10, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    .line 1368
    nop

    .end local v9    # "b2":B
    add-int/lit8 v8, v8, 0x1

    .line 1369
    goto :goto_0

    .line 1372
    :cond_8
    iget-object v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v1

    .line 1373
    .restart local v1    # "outBuf":[C
    aput-char v2, v1, v3

    .line 1374
    int-to-char v2, v0

    .line 1375
    .local v2, "ind":C
    const/4 v3, 0x1

    .local v3, "i":I
    :goto_1
    if-gt v3, v8, :cond_9

    .line 1376
    aput-char v2, v1, v3

    .line 1375
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 1378
    .end local v3    # "i":I
    :cond_9
    add-int/2addr v8, v5

    .line 1379
    iget-object v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3, v8}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 1380
    return v8
.end method

.method protected final checkPrologIndentation(I)I
    .locals 9
    .param p1, "c"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1391
    const/16 v0, 0xd

    const/16 v1, 0xa

    const/4 v2, -0x1

    const/4 v3, 0x0

    const/16 v4, 0x20

    const/4 v5, 0x1

    if-ne p1, v0, :cond_1

    .line 1393
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v0, v6, :cond_0

    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_0

    .line 1394
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0, v3, v4}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithIndentation(IC)V

    .line 1395
    return v2

    .line 1397
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v0, v0, v6

    if-ne v0, v1, :cond_1

    .line 1398
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/2addr v0, v5

    iput v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    .line 1401
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->markLF()V

    .line 1403
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v0, v6, :cond_2

    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_2

    .line 1404
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0, v3, v4}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithIndentation(IC)V

    .line 1405
    return v2

    .line 1407
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v0, v0, v6

    .line 1408
    .local v0, "b":B
    if-eq v0, v4, :cond_4

    const/16 v6, 0x9

    if-eq v0, v6, :cond_4

    .line 1410
    const/16 v6, 0x3c

    if-ne v0, v6, :cond_3

    .line 1411
    iget-object v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1, v3, v4}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithIndentation(IC)V

    .line 1412
    return v2

    .line 1415
    :cond_3
    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v2

    .line 1416
    .local v2, "outBuf":[C
    aput-char v1, v2, v3

    .line 1417
    iget-object v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1, v5}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 1418
    return v5

    .line 1421
    .end local v2    # "outBuf":[C
    :cond_4
    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/2addr v6, v5

    iput v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    .line 1422
    const/4 v6, 0x1

    .line 1423
    .local v6, "count":I
    if-ne v0, v4, :cond_5

    goto :goto_0

    :cond_5
    const/16 v4, 0x8

    .line 1425
    .local v4, "max":I
    :cond_6
    :goto_0
    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v7, v8, :cond_7

    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMore()Z

    move-result v7

    if-nez v7, :cond_7

    .line 1426
    goto :goto_1

    .line 1428
    :cond_7
    iget-object v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v7, v7, v8

    if-eq v7, v0, :cond_8

    .line 1429
    nop

    .line 1447
    :goto_1
    iget-object v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    int-to-char v3, v0

    invoke-virtual {v1, v6, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithIndentation(IC)V

    .line 1448
    return v2

    .line 1431
    :cond_8
    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/2addr v7, v5

    iput v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    .line 1432
    add-int/lit8 v6, v6, 0x1

    .line 1433
    if-lt v6, v4, :cond_6

    .line 1435
    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v2

    .line 1436
    .restart local v2    # "outBuf":[C
    aput-char v1, v2, v3

    .line 1437
    int-to-char v1, v0

    .line 1438
    .local v1, "ind":C
    const/4 v3, 0x1

    .local v3, "i":I
    :goto_2
    if-gt v3, v6, :cond_9

    .line 1439
    aput-char v1, v2, v3

    .line 1438
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 1441
    .end local v3    # "i":I
    :cond_9
    add-int/2addr v6, v5

    .line 1442
    iget-object v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3, v6}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 1443
    return v6
.end method

.method protected final handleCharEntity()I
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 546
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 547
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 549
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 550
    .local v0, "b":B
    const/4 v1, 0x0

    .line 551
    .local v1, "value":I
    const/16 v2, 0x78

    const v3, 0x10ffff

    const/16 v4, 0x39

    const/16 v5, 0x3b

    const/16 v6, 0x30

    if-ne v0, v2, :cond_7

    .line 553
    :goto_0
    iget v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v2, v7, :cond_1

    .line 554
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 556
    :cond_1
    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v0, v2, v7

    .line 557
    if-ne v0, v5, :cond_2

    .line 558
    goto/16 :goto_4

    .line 560
    :cond_2
    shl-int/lit8 v1, v1, 0x4

    .line 561
    move v2, v0

    .line 562
    .local v2, "c":I
    if-gt v2, v4, :cond_3

    if-lt v2, v6, :cond_3

    .line 563
    add-int/lit8 v7, v2, -0x30

    add-int/2addr v1, v7

    goto :goto_1

    .line 564
    :cond_3
    const/16 v7, 0x61

    if-lt v2, v7, :cond_4

    const/16 v7, 0x66

    if-gt v2, v7, :cond_4

    .line 565
    add-int/lit8 v7, v2, -0x61

    add-int/lit8 v7, v7, 0xa

    add-int/2addr v1, v7

    goto :goto_1

    .line 566
    :cond_4
    const/16 v7, 0x41

    if-lt v2, v7, :cond_5

    const/16 v7, 0x46

    if-gt v2, v7, :cond_5

    .line 567
    add-int/lit8 v7, v2, -0x41

    add-int/lit8 v7, v7, 0xa

    add-int/2addr v1, v7

    goto :goto_1

    .line 569
    :cond_5
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->decodeCharForError(B)I

    move-result v7

    const-string v8, "; expected a hex digit (0-9a-fA-F)"

    invoke-virtual {p0, v7, v8}, Lcom/fasterxml/aalto/in/StreamScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 571
    :goto_1
    if-le v1, v3, :cond_6

    .line 572
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->reportEntityOverflow()V

    .line 574
    .end local v2    # "c":I
    :cond_6
    goto :goto_0

    .line 576
    :cond_7
    :goto_2
    if-eq v0, v5, :cond_b

    .line 577
    move v2, v0

    .line 578
    .restart local v2    # "c":I
    if-gt v2, v4, :cond_9

    if-lt v2, v6, :cond_9

    .line 579
    mul-int/lit8 v7, v1, 0xa

    add-int/lit8 v8, v2, -0x30

    add-int/2addr v7, v8

    .line 580
    .end local v1    # "value":I
    .local v7, "value":I
    if-le v7, v3, :cond_8

    .line 581
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->reportEntityOverflow()V

    .line 586
    :cond_8
    move v1, v7

    goto :goto_3

    .line 584
    .end local v7    # "value":I
    .restart local v1    # "value":I
    :cond_9
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->decodeCharForError(B)I

    move-result v7

    const-string v8, "; expected a decimal number"

    invoke-virtual {p0, v7, v8}, Lcom/fasterxml/aalto/in/StreamScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 586
    :goto_3
    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v7, v8, :cond_a

    .line 587
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 589
    :cond_a
    iget-object v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v0, v7, v8

    .line 590
    .end local v2    # "c":I
    goto :goto_2

    .line 592
    :cond_b
    :goto_4
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/StreamScanner;->verifyXmlChar(I)V

    .line 593
    return v1
.end method

.method protected final handleEndElement()I
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 613
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_depth:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_depth:I

    .line 614
    const/4 v0, 0x2

    iput v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_currToken:I

    .line 616
    iget-object v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_currElem:Lcom/fasterxml/aalto/in/ElementScope;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/ElementScope;->getName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 618
    iget-object v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/PName;->sizeInQuads()I

    move-result v1

    .line 624
    .local v1, "size":I
    iget v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    sub-int/2addr v2, v3

    shl-int/lit8 v3, v1, 0x2

    add-int/lit8 v3, v3, 0x1

    if-ge v2, v3, :cond_0

    .line 625
    invoke-direct {p0, v1}, Lcom/fasterxml/aalto/in/StreamScanner;->handleEndElementSlow(I)I

    move-result v0

    return v0

    .line 628
    :cond_0
    iget v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    .line 629
    .local v2, "ptr":I
    iget-object v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    .line 632
    .local v3, "buf":[B
    add-int/lit8 v1, v1, -0x1

    .line 633
    const/4 v4, 0x0

    .local v4, "qix":I
    :goto_0
    if-ge v4, v1, :cond_2

    .line 634
    aget-byte v5, v3, v2

    shl-int/lit8 v5, v5, 0x18

    add-int/lit8 v6, v2, 0x1

    aget-byte v6, v3, v6

    and-int/lit16 v6, v6, 0xff

    shl-int/lit8 v6, v6, 0x10

    or-int/2addr v5, v6

    add-int/lit8 v6, v2, 0x2

    aget-byte v6, v3, v6

    and-int/lit16 v6, v6, 0xff

    shl-int/lit8 v6, v6, 0x8

    or-int/2addr v5, v6

    add-int/lit8 v6, v2, 0x3

    aget-byte v6, v3, v6

    and-int/lit16 v6, v6, 0xff

    or-int/2addr v5, v6

    .line 639
    .local v5, "q":I
    add-int/lit8 v2, v2, 0x4

    .line 641
    iget-object v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v6, v4}, Lcom/fasterxml/aalto/in/PName;->getQuad(I)I

    move-result v6

    if-eq v5, v6, :cond_1

    .line 642
    iput v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    .line 643
    iget-object v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v6}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/in/StreamScanner;->reportUnexpectedEndTag(Ljava/lang/String;)V

    .line 633
    .end local v5    # "q":I
    :cond_1
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 650
    .end local v4    # "qix":I
    :cond_2
    iget-object v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v4, v1}, Lcom/fasterxml/aalto/in/PName;->getQuad(I)I

    move-result v4

    .line 651
    .local v4, "lastQ":I
    add-int/lit8 v5, v2, 0x1

    .end local v2    # "ptr":I
    .local v5, "ptr":I
    aget-byte v2, v3, v2

    and-int/lit16 v2, v2, 0xff

    .line 652
    .local v2, "q":I
    if-eq v2, v4, :cond_6

    .line 653
    shl-int/lit8 v6, v2, 0x8

    add-int/lit8 v7, v5, 0x1

    .end local v5    # "ptr":I
    .local v7, "ptr":I
    aget-byte v5, v3, v5

    and-int/lit16 v5, v5, 0xff

    or-int v2, v6, v5

    .line 654
    if-eq v2, v4, :cond_5

    .line 655
    shl-int/lit8 v5, v2, 0x8

    add-int/lit8 v6, v7, 0x1

    .end local v7    # "ptr":I
    .local v6, "ptr":I
    aget-byte v7, v3, v7

    and-int/lit16 v7, v7, 0xff

    or-int v2, v5, v7

    .line 656
    if-eq v2, v4, :cond_4

    .line 657
    shl-int/lit8 v5, v2, 0x8

    add-int/lit8 v7, v6, 0x1

    .end local v6    # "ptr":I
    .restart local v7    # "ptr":I
    aget-byte v6, v3, v6

    and-int/lit16 v6, v6, 0xff

    or-int v2, v5, v6

    .line 658
    if-eq v2, v4, :cond_3

    .line 659
    iput v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    .line 660
    iget-object v5, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v5}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/in/StreamScanner;->reportUnexpectedEndTag(Ljava/lang/String;)V

    .line 666
    :cond_3
    move v5, v7

    goto :goto_1

    .line 656
    .end local v7    # "ptr":I
    .restart local v6    # "ptr":I
    :cond_4
    move v5, v6

    goto :goto_1

    .line 654
    .end local v6    # "ptr":I
    .restart local v7    # "ptr":I
    :cond_5
    move v5, v7

    .line 666
    .end local v7    # "ptr":I
    .restart local v5    # "ptr":I
    :cond_6
    :goto_1
    iget-object v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    aget-byte v6, v6, v5

    and-int/lit16 v6, v6, 0xff

    .line 667
    .local v6, "i2":I
    add-int/lit8 v7, v5, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    .line 668
    :goto_2
    const/16 v7, 0x20

    if-gt v6, v7, :cond_d

    .line 669
    const/16 v8, 0xa

    if-ne v6, v8, :cond_7

    .line 670
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->markLF()V

    goto :goto_5

    .line 671
    :cond_7
    const/16 v9, 0xd

    if-ne v6, v9, :cond_a

    .line 672
    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-ge v7, v9, :cond_8

    iget-object v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v9, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v10, v9, 0x1

    iput v10, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v7, v7, v9

    goto :goto_3

    :cond_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadOne()B

    move-result v7

    .line 673
    .local v7, "b":B
    :goto_3
    if-eq v7, v8, :cond_9

    .line 674
    iget v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v8, v8, -0x1

    invoke-virtual {p0, v8}, Lcom/fasterxml/aalto/in/StreamScanner;->markLF(I)V

    .line 675
    and-int/lit16 v6, v7, 0xff

    .line 676
    goto :goto_2

    .line 678
    :cond_9
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->markLF()V

    .end local v7    # "b":B
    goto :goto_4

    .line 679
    :cond_a
    if-eq v6, v7, :cond_b

    const/16 v7, 0x9

    if-eq v6, v7, :cond_b

    .line 680
    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/in/StreamScanner;->throwInvalidSpace(I)V

    goto :goto_5

    .line 679
    :cond_b
    :goto_4
    nop

    .line 682
    :goto_5
    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-ge v7, v8, :cond_c

    iget-object v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v7, v7, v8

    goto :goto_6

    :cond_c
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadOne()B

    move-result v7

    :goto_6
    and-int/lit16 v6, v7, 0xff

    goto :goto_2

    .line 684
    :cond_d
    const/16 v7, 0x3e

    if-eq v6, v7, :cond_e

    .line 685
    int-to-byte v7, v6

    invoke-virtual {p0, v7}, Lcom/fasterxml/aalto/in/StreamScanner;->decodeCharForError(B)I

    move-result v7

    const-string v8, " expected space or closing \'>\'"

    invoke-virtual {p0, v7, v8}, Lcom/fasterxml/aalto/in/StreamScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 687
    :cond_e
    return v0
.end method

.method protected abstract handleEntityInText(Z)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract handleStartElement(B)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected final loadAndRetain(I)Z
    .locals 6
    .param p1, "nrOfChars"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1536
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_in:Ljava/io/InputStream;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 1537
    return v1

    .line 1542
    :cond_0
    iget-wide v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_pastBytesOrChars:J

    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    int-to-long v4, v0

    add-long/2addr v2, v4

    iput-wide v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_pastBytesOrChars:J

    .line 1543
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_rowStartOffset:I

    iget v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    sub-int/2addr v0, v2

    iput v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_rowStartOffset:I

    .line 1545
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    iget v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    sub-int/2addr v0, v2

    .line 1546
    .local v0, "remaining":I
    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget-object v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    invoke-static {v2, v3, v4, v1, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1547
    iput v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    .line 1548
    iput v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    .line 1552
    :cond_1
    :try_start_0
    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    array-length v2, v2

    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    sub-int/2addr v2, v3

    .line 1553
    .local v2, "max":I
    iget-object v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_in:Ljava/io/InputStream;

    iget-object v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    invoke-virtual {v3, v4, v5, v2}, Ljava/io/InputStream;->read([BII)I

    move-result v3

    .line 1554
    .local v3, "count":I
    const/4 v4, 0x1

    if-ge v3, v4, :cond_3

    .line 1555
    if-nez v3, :cond_2

    .line 1557
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "InputStream returned 0 bytes, even when asked to read up to "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/StreamScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1559
    :cond_2
    return v1

    .line 1561
    :cond_3
    iget v5, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    add-int/2addr v5, v3

    iput v5, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    .line 1562
    .end local v2    # "max":I
    .end local v3    # "count":I
    iget v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    if-lt v2, p1, :cond_1

    .line 1563
    return v4

    .line 1564
    :catch_0
    move-exception v1

    .line 1565
    .local v1, "ioe":Ljava/io/IOException;
    new-instance v2, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v2, v1}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v2
.end method

.method protected final loadMore()Z
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1461
    iget-wide v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_pastBytesOrChars:J

    iget v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    int-to-long v2, v2

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_pastBytesOrChars:J

    .line 1462
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_rowStartOffset:I

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    sub-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_rowStartOffset:I

    .line 1463
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    .line 1466
    iget-object v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_in:Ljava/io/InputStream;

    if-nez v1, :cond_0

    .line 1467
    iput v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    .line 1468
    return v0

    .line 1472
    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_in:Ljava/io/InputStream;

    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget-object v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    array-length v3, v3

    invoke-virtual {v1, v2, v0, v3}, Ljava/io/InputStream;->read([BII)I

    move-result v1

    .line 1473
    .local v1, "count":I
    const/4 v2, 0x1

    if-ge v1, v2, :cond_2

    .line 1474
    iput v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    .line 1475
    if-nez v1, :cond_1

    .line 1479
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "InputStream returned 0 bytes, even when asked to read up to "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    array-length v3, v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/StreamScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1481
    :cond_1
    return v0

    .line 1483
    :cond_2
    iput v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1484
    return v2

    .line 1485
    .end local v1    # "count":I
    :catch_0
    move-exception v0

    .line 1486
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method protected final loadOne()B
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1515
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_0

    .line 1516
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Unexpected end-of-input when trying to parse "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_currToken:I

    invoke-static {v1}, Lcom/fasterxml/aalto/impl/ErrorConsts;->tokenTypeDesc(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1518
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    return v0
.end method

.method protected final loadOne(I)B
    .locals 3
    .param p1, "type"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1524
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_0

    .line 1525
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Unexpected end-of-input when trying to parse "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Lcom/fasterxml/aalto/impl/ErrorConsts;->tokenTypeDesc(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1527
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    return v0
.end method

.method protected final nextByte()B
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1504
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 1505
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_0

    .line 1506
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Unexpected end-of-input when trying to parse "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_currToken:I

    invoke-static {v1}, Lcom/fasterxml/aalto/impl/ErrorConsts;->tokenTypeDesc(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1509
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    return v0
.end method

.method protected final nextByte(I)B
    .locals 3
    .param p1, "tt"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1493
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 1494
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_0

    .line 1495
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Unexpected end-of-input when trying to parse "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Lcom/fasterxml/aalto/impl/ErrorConsts;->tokenTypeDesc(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1498
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    return v0
.end method

.method public final nextFromProlog(Z)I
    .locals 5
    .param p1, "isProlog"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 146
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenIncomplete:Z

    if-eqz v0, :cond_0

    .line 147
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->skipToken()Z

    .line 151
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->setStartLocation()V

    .line 154
    :goto_0
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    const/4 v2, -0x1

    if-lt v0, v1, :cond_1

    .line 155
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_1

    .line 156
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->setStartLocation()V

    .line 157
    return v2

    .line 160
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    and-int/lit16 v0, v0, 0xff

    .line 163
    .local v0, "c":I
    const/16 v1, 0x3c

    if-ne v0, v1, :cond_7

    .line 164
    nop

    .line 193
    .end local v0    # "c":I
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v0, v1, :cond_2

    .line 194
    const/4 v0, 0x5

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed(I)V

    .line 196
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 197
    .local v0, "b":B
    const/16 v1, 0x21

    if-ne v0, v1, :cond_3

    .line 198
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/in/StreamScanner;->handlePrologDeclStart(Z)I

    move-result v1

    return v1

    .line 200
    :cond_3
    const/16 v1, 0x3f

    if-ne v0, v1, :cond_4

    .line 201
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->handlePIStart()I

    move-result v1

    return v1

    .line 206
    :cond_4
    const/16 v1, 0x2f

    if-eq v0, v1, :cond_5

    if-nez p1, :cond_6

    .line 207
    :cond_5
    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->reportPrologUnexpElement(ZI)V

    .line 209
    :cond_6
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->handleStartElement(B)I

    move-result v1

    return v1

    .line 171
    .local v0, "c":I
    :cond_7
    const/16 v1, 0x20

    if-eq v0, v1, :cond_c

    .line 172
    const/16 v1, 0xa

    if-ne v0, v1, :cond_8

    .line 173
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->markLF()V

    goto :goto_1

    .line 174
    :cond_8
    const/16 v3, 0xd

    if-ne v0, v3, :cond_b

    .line 175
    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v3, v4, :cond_9

    .line 176
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMore()Z

    move-result v3

    if-nez v3, :cond_9

    .line 177
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->markLF()V

    .line 178
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->setStartLocation()V

    .line 179
    return v2

    .line 182
    :cond_9
    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v2, v2, v3

    if-ne v2, v1, :cond_a

    .line 183
    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    .line 185
    :cond_a
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->markLF()V

    goto :goto_1

    .line 186
    :cond_b
    const/16 v1, 0x9

    if-eq v0, v1, :cond_c

    .line 187
    int-to-byte v1, v0

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/StreamScanner;->decodeCharForError(B)I

    move-result v1

    const/4 v2, 0x0

    invoke-virtual {p0, p1, v1, v2}, Lcom/fasterxml/aalto/in/StreamScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    .line 190
    .end local v0    # "c":I
    :cond_c
    :goto_1
    goto/16 :goto_0
.end method

.method public final nextFromTree()I
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 215
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenIncomplete:Z

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    .line 216
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->skipToken()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 218
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->_nextEntity()I

    move-result v0

    return v0

    .line 221
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_currToken:I

    const/4 v3, 0x2

    if-ne v0, v2, :cond_1

    .line 222
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_isEmptyTag:Z

    if-eqz v0, :cond_3

    .line 223
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_depth:I

    sub-int/2addr v0, v2

    iput v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_depth:I

    .line 224
    iput v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_currToken:I

    return v3

    .line 226
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_currToken:I

    if-ne v0, v3, :cond_2

    .line 227
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_currElem:Lcom/fasterxml/aalto/in/ElementScope;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ElementScope;->getParent()Lcom/fasterxml/aalto/in/ElementScope;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_currElem:Lcom/fasterxml/aalto/in/ElementScope;

    .line 229
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->getLevel()I

    move-result v0

    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_depth:I

    if-lt v0, v3, :cond_3

    .line 230
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->unbind()Lcom/fasterxml/aalto/in/NsDeclaration;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    goto :goto_0

    .line 234
    :cond_2
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_entityPending:Z

    if-eqz v0, :cond_3

    .line 235
    iput-boolean v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_entityPending:Z

    .line 236
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->_nextEntity()I

    move-result v0

    return v0

    .line 241
    :cond_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->setStartLocation()V

    .line 246
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v0, v3, :cond_4

    .line 247
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_4

    .line 248
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->setStartLocation()V

    .line 249
    const/4 v0, -0x1

    return v0

    .line 252
    :cond_4
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v0, v0, v3

    .line 257
    .local v0, "b":B
    const/16 v3, 0x3c

    if-ne v0, v3, :cond_9

    .line 258
    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/2addr v1, v2

    iput v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    .line 259
    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-ge v1, v2, :cond_5

    iget-object v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v1, v1, v2

    goto :goto_1

    :cond_5
    const/4 v1, 0x5

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/StreamScanner;->loadOne(I)B

    move-result v1

    :goto_1
    move v0, v1

    .line 260
    const/16 v1, 0x21

    if-ne v0, v1, :cond_6

    .line 261
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->handleCommentOrCdataStart()I

    move-result v1

    return v1

    .line 263
    :cond_6
    const/16 v1, 0x3f

    if-ne v0, v1, :cond_7

    .line 264
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->handlePIStart()I

    move-result v1

    return v1

    .line 266
    :cond_7
    const/16 v1, 0x2f

    if-ne v0, v1, :cond_8

    .line 267
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->handleEndElement()I

    move-result v1

    return v1

    .line 269
    :cond_8
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->handleStartElement(B)I

    move-result v1

    return v1

    .line 271
    :cond_9
    const/16 v3, 0x26

    if-ne v0, v3, :cond_b

    .line 272
    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/2addr v3, v2

    iput v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    .line 276
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/StreamScanner;->handleEntityInText(Z)I

    move-result v1

    .line 277
    .local v1, "i":I
    if-nez v1, :cond_a

    .line 278
    const/16 v2, 0x9

    iput v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_currToken:I

    return v2

    .line 284
    :cond_a
    neg-int v3, v1

    iput v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tmpChar:I

    .line 285
    .end local v1    # "i":I
    goto :goto_2

    .line 289
    :cond_b
    and-int/lit16 v1, v0, 0xff

    iput v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tmpChar:I

    .line 291
    :goto_2
    iget-boolean v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_cfgLazyParsing:Z

    if-eqz v1, :cond_c

    .line 292
    iput-boolean v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_tokenIncomplete:Z

    goto :goto_3

    .line 294
    :cond_c
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->finishCharacters()V

    .line 296
    :goto_3
    const/4 v1, 0x4

    iput v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_currToken:I

    return v1
.end method

.method protected final parsePName(B)Lcom/fasterxml/aalto/in/PName;
    .locals 9
    .param p1, "b"    # B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 898
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    sub-int/2addr v0, v1

    const/16 v1, 0x8

    if-ge v0, v1, :cond_0

    .line 899
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/in/StreamScanner;->parsePNameSlow(B)Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    return-object v0

    .line 903
    :cond_0
    and-int/lit16 v0, p1, 0xff

    .line 907
    .local v0, "q":I
    const/16 v1, 0x41

    if-ge v0, v1, :cond_1

    .line 908
    const-string v2, "; expected a name start character"

    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/aalto/in/StreamScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 911
    :cond_1
    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v2, v2, v3

    and-int/lit16 v2, v2, 0xff

    .line 915
    .local v2, "i2":I
    const/16 v3, 0x2f

    const/16 v4, 0x3a

    const/16 v5, 0x2d

    if-ge v2, v1, :cond_3

    .line 917
    if-lt v2, v5, :cond_2

    if-gt v2, v4, :cond_2

    if-ne v2, v3, :cond_3

    .line 918
    :cond_2
    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Lcom/fasterxml/aalto/in/StreamScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1

    .line 921
    :cond_3
    shl-int/lit8 v6, v0, 0x8

    or-int v0, v6, v2

    .line 922
    iget-object v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v6, v6, v7

    and-int/lit16 v2, v6, 0xff

    .line 923
    if-ge v2, v1, :cond_5

    .line 924
    if-lt v2, v5, :cond_4

    if-gt v2, v4, :cond_4

    if-ne v2, v3, :cond_5

    .line 925
    :cond_4
    const/4 v1, 0x2

    invoke-direct {p0, v0, v1}, Lcom/fasterxml/aalto/in/StreamScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1

    .line 928
    :cond_5
    shl-int/lit8 v6, v0, 0x8

    or-int v0, v6, v2

    .line 929
    iget-object v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v6, v6, v7

    and-int/lit16 v2, v6, 0xff

    .line 930
    if-ge v2, v1, :cond_7

    .line 931
    if-lt v2, v5, :cond_6

    if-gt v2, v4, :cond_6

    if-ne v2, v3, :cond_7

    .line 932
    :cond_6
    const/4 v1, 0x3

    invoke-direct {p0, v0, v1}, Lcom/fasterxml/aalto/in/StreamScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1

    .line 935
    :cond_7
    shl-int/lit8 v6, v0, 0x8

    or-int v0, v6, v2

    .line 936
    iget-object v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v6, v6, v7

    and-int/lit16 v2, v6, 0xff

    .line 937
    if-ge v2, v1, :cond_9

    .line 938
    if-lt v2, v5, :cond_8

    if-gt v2, v4, :cond_8

    if-ne v2, v3, :cond_9

    .line 939
    :cond_8
    const/4 v1, 0x4

    invoke-direct {p0, v0, v1}, Lcom/fasterxml/aalto/in/StreamScanner;->findPName(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1

    .line 944
    :cond_9
    invoke-virtual {p0, v2, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->parsePNameMedium(II)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1
.end method

.method protected final parsePNameLong(I[I)Lcom/fasterxml/aalto/in/PName;
    .locals 9
    .param p1, "q"    # I
    .param p2, "quads"    # [I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 992
    const/4 v0, 0x2

    .line 995
    .local v0, "qix":I
    :goto_0
    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v1, v2, :cond_0

    .line 996
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 998
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v1, v1, v2

    and-int/lit16 v1, v1, 0xff

    .line 999
    .local v1, "i2":I
    const/16 v2, 0x2f

    const/16 v3, 0x3a

    const/16 v4, 0x2d

    const/16 v5, 0x41

    if-ge v1, v5, :cond_2

    .line 1000
    if-lt v1, v4, :cond_1

    if-gt v1, v3, :cond_1

    if-ne v1, v2, :cond_2

    .line 1002
    :cond_1
    const/4 v2, 0x1

    invoke-direct {p0, p1, p2, v0, v2}, Lcom/fasterxml/aalto/in/StreamScanner;->findPName(I[III)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    return-object v2

    .line 1006
    :cond_2
    shl-int/lit8 v6, p1, 0x8

    or-int p1, v6, v1

    .line 1007
    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-ge v6, v7, :cond_3

    iget-object v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v6, v6, v7

    goto :goto_1

    :cond_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadOne()B

    move-result v6

    :goto_1
    and-int/lit16 v1, v6, 0xff

    .line 1008
    if-ge v1, v5, :cond_5

    .line 1009
    if-lt v1, v4, :cond_4

    if-gt v1, v3, :cond_4

    if-ne v1, v2, :cond_5

    .line 1010
    :cond_4
    const/4 v2, 0x2

    invoke-direct {p0, p1, p2, v0, v2}, Lcom/fasterxml/aalto/in/StreamScanner;->findPName(I[III)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    return-object v2

    .line 1014
    :cond_5
    shl-int/lit8 v6, p1, 0x8

    or-int p1, v6, v1

    .line 1015
    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-ge v6, v7, :cond_6

    iget-object v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v6, v6, v7

    goto :goto_2

    :cond_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadOne()B

    move-result v6

    :goto_2
    and-int/lit16 v1, v6, 0xff

    .line 1016
    if-ge v1, v5, :cond_8

    .line 1017
    if-lt v1, v4, :cond_7

    if-gt v1, v3, :cond_7

    if-ne v1, v2, :cond_8

    .line 1018
    :cond_7
    const/4 v2, 0x3

    invoke-direct {p0, p1, p2, v0, v2}, Lcom/fasterxml/aalto/in/StreamScanner;->findPName(I[III)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    return-object v2

    .line 1021
    :cond_8
    shl-int/lit8 v6, p1, 0x8

    or-int p1, v6, v1

    .line 1022
    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-ge v6, v7, :cond_9

    iget-object v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v6, v6, v7

    goto :goto_3

    :cond_9
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadOne()B

    move-result v6

    :goto_3
    and-int/lit16 v1, v6, 0xff

    .line 1023
    if-ge v1, v5, :cond_b

    .line 1024
    if-lt v1, v4, :cond_a

    if-gt v1, v3, :cond_a

    if-ne v1, v2, :cond_b

    .line 1025
    :cond_a
    const/4 v2, 0x4

    invoke-direct {p0, p1, p2, v0, v2}, Lcom/fasterxml/aalto/in/StreamScanner;->findPName(I[III)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    return-object v2

    .line 1028
    :cond_b
    array-length v2, p2

    if-lt v0, v2, :cond_c

    .line 1029
    array-length v2, p2

    invoke-static {p2, v2}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([II)[I

    move-result-object v2

    move-object p2, v2

    iput-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_quadBuffer:[I

    .line 1031
    :cond_c
    aput p1, p2, v0

    .line 1032
    add-int/lit8 v0, v0, 0x1

    .line 1033
    move p1, v1

    .line 1034
    .end local v1    # "i2":I
    goto/16 :goto_0
.end method

.method protected parsePNameMedium(II)Lcom/fasterxml/aalto/in/PName;
    .locals 9
    .param p1, "i2"    # I
    .param p2, "q1"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 951
    move v0, p1

    .line 952
    .local v0, "q2":I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v1, v1, v2

    and-int/lit16 p1, v1, 0xff

    .line 953
    const/16 v1, 0x2f

    const/16 v2, 0x3a

    const/16 v3, 0x2d

    const/4 v4, 0x1

    const/16 v5, 0x41

    if-ge p1, v5, :cond_1

    .line 955
    if-lt p1, v3, :cond_0

    if-gt p1, v2, :cond_0

    if-ne p1, v1, :cond_1

    .line 956
    :cond_0
    invoke-direct {p0, p2, v0, v4}, Lcom/fasterxml/aalto/in/StreamScanner;->findPName(III)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1

    .line 960
    :cond_1
    shl-int/lit8 v6, v0, 0x8

    or-int v0, v6, p1

    .line 961
    iget-object v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v6, v6, v7

    and-int/lit16 p1, v6, 0xff

    .line 962
    if-ge p1, v5, :cond_3

    .line 963
    if-lt p1, v3, :cond_2

    if-gt p1, v2, :cond_2

    if-ne p1, v1, :cond_3

    .line 964
    :cond_2
    const/4 v1, 0x2

    invoke-direct {p0, p2, v0, v1}, Lcom/fasterxml/aalto/in/StreamScanner;->findPName(III)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1

    .line 967
    :cond_3
    shl-int/lit8 v6, v0, 0x8

    or-int v0, v6, p1

    .line 968
    iget-object v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v6, v6, v7

    and-int/lit16 p1, v6, 0xff

    .line 969
    if-ge p1, v5, :cond_5

    .line 970
    if-lt p1, v3, :cond_4

    if-gt p1, v2, :cond_4

    if-ne p1, v1, :cond_5

    .line 971
    :cond_4
    const/4 v1, 0x3

    invoke-direct {p0, p2, v0, v1}, Lcom/fasterxml/aalto/in/StreamScanner;->findPName(III)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1

    .line 974
    :cond_5
    shl-int/lit8 v6, v0, 0x8

    or-int v0, v6, p1

    .line 975
    iget-object v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v6, v6, v7

    and-int/lit16 p1, v6, 0xff

    .line 976
    if-ge p1, v5, :cond_7

    .line 977
    if-lt p1, v3, :cond_6

    if-gt p1, v2, :cond_6

    if-ne p1, v1, :cond_7

    .line 978
    :cond_6
    const/4 v1, 0x4

    invoke-direct {p0, p2, v0, v1}, Lcom/fasterxml/aalto/in/StreamScanner;->findPName(III)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1

    .line 983
    :cond_7
    iget-object v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_quadBuffer:[I

    .line 984
    .local v1, "quads":[I
    const/4 v2, 0x0

    aput p2, v1, v2

    .line 985
    aput v0, v1, v4

    .line 986
    invoke-virtual {p0, p1, v1}, Lcom/fasterxml/aalto/in/StreamScanner;->parsePNameLong(I[I)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    return-object v2
.end method

.method protected final parsePNameSlow(B)Lcom/fasterxml/aalto/in/PName;
    .locals 14
    .param p1, "b"    # B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1040
    and-int/lit16 v0, p1, 0xff

    .line 1045
    .local v0, "q":I
    const/16 v1, 0x41

    if-ge v0, v1, :cond_0

    .line 1046
    const-string v2, "; expected a name start character"

    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/aalto/in/StreamScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1049
    :cond_0
    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_quadBuffer:[I

    .line 1050
    .local v2, "quads":[I
    const/4 v3, 0x0

    .line 1052
    .local v3, "qix":I
    const/4 v4, 0x0

    move-object v11, v2

    move v12, v3

    move v13, v4

    .line 1056
    .end local v2    # "quads":[I
    .end local v3    # "qix":I
    .local v11, "quads":[I
    .local v12, "qix":I
    .local v13, "firstQuad":I
    :goto_0
    iget v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v2, v3, :cond_1

    .line 1057
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 1059
    :cond_1
    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v2, v2, v3

    and-int/lit16 v2, v2, 0xff

    .line 1063
    .local v2, "i2":I
    const/16 v3, 0x2f

    const/16 v4, 0x3a

    const/16 v5, 0x2d

    if-ge v2, v1, :cond_3

    .line 1065
    if-lt v2, v5, :cond_2

    if-gt v2, v4, :cond_2

    if-ne v2, v3, :cond_3

    .line 1067
    :cond_2
    const/4 v7, 0x1

    move-object v5, p0

    move v6, v0

    move v8, v13

    move v9, v12

    move-object v10, v11

    invoke-direct/range {v5 .. v10}, Lcom/fasterxml/aalto/in/StreamScanner;->findPName(IIII[I)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1

    .line 1072
    :cond_3
    shl-int/lit8 v6, v0, 0x8

    or-int v0, v6, v2

    .line 1073
    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-ge v6, v7, :cond_4

    iget-object v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v8, v7, 0x1

    iput v8, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v6, v6, v7

    goto :goto_1

    :cond_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadOne()B

    move-result v6

    :goto_1
    and-int/lit16 v8, v6, 0xff

    .line 1074
    .end local v2    # "i2":I
    .local v8, "i2":I
    if-ge v8, v1, :cond_6

    .line 1075
    if-lt v8, v5, :cond_5

    if-gt v8, v4, :cond_5

    if-ne v8, v3, :cond_6

    .line 1076
    :cond_5
    const/4 v4, 0x2

    move-object v2, p0

    move v3, v0

    move v5, v13

    move v6, v12

    move-object v7, v11

    invoke-direct/range {v2 .. v7}, Lcom/fasterxml/aalto/in/StreamScanner;->findPName(IIII[I)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1

    .line 1081
    :cond_6
    shl-int/lit8 v2, v0, 0x8

    or-int v0, v2, v8

    .line 1082
    iget v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-ge v2, v6, :cond_7

    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v2, v2, v6

    goto :goto_2

    :cond_7
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadOne()B

    move-result v2

    :goto_2
    and-int/lit16 v8, v2, 0xff

    .line 1083
    if-ge v8, v1, :cond_9

    .line 1084
    if-lt v8, v5, :cond_8

    if-gt v8, v4, :cond_8

    if-ne v8, v3, :cond_9

    .line 1085
    :cond_8
    const/4 v4, 0x3

    move-object v2, p0

    move v3, v0

    move v5, v13

    move v6, v12

    move-object v7, v11

    invoke-direct/range {v2 .. v7}, Lcom/fasterxml/aalto/in/StreamScanner;->findPName(IIII[I)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1

    .line 1088
    :cond_9
    shl-int/lit8 v2, v0, 0x8

    or-int v0, v2, v8

    .line 1092
    iget v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-ge v2, v6, :cond_a

    iget-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v2, v2, v6

    goto :goto_3

    :cond_a
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadOne()B

    move-result v2

    :goto_3
    and-int/lit16 v8, v2, 0xff

    .line 1093
    if-ge v8, v1, :cond_c

    .line 1094
    if-lt v8, v5, :cond_b

    if-gt v8, v4, :cond_b

    if-ne v8, v3, :cond_c

    .line 1095
    :cond_b
    const/4 v4, 0x4

    move-object v2, p0

    move v3, v0

    move v5, v13

    move v6, v12

    move-object v7, v11

    invoke-direct/range {v2 .. v7}, Lcom/fasterxml/aalto/in/StreamScanner;->findPName(IIII[I)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1

    .line 1101
    :cond_c
    if-nez v12, :cond_d

    .line 1102
    move v2, v0

    move v13, v2

    .end local v13    # "firstQuad":I
    .local v2, "firstQuad":I
    goto :goto_4

    .line 1103
    .end local v2    # "firstQuad":I
    .restart local v13    # "firstQuad":I
    :cond_d
    const/4 v2, 0x1

    if-ne v12, v2, :cond_e

    .line 1104
    const/4 v3, 0x0

    aput v13, v11, v3

    .line 1105
    aput v0, v11, v2

    goto :goto_4

    .line 1107
    :cond_e
    array-length v2, v11

    if-lt v12, v2, :cond_f

    .line 1108
    array-length v2, v11

    invoke-static {v11, v2}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([II)[I

    move-result-object v2

    move-object v11, v2

    iput-object v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_quadBuffer:[I

    .line 1110
    :cond_f
    aput v0, v11, v12

    .line 1112
    :goto_4
    add-int/lit8 v12, v12, 0x1

    .line 1113
    move v0, v8

    .line 1114
    .end local v8    # "i2":I
    goto/16 :goto_0
.end method

.method protected abstract parsePublicId(B)Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract parseSystemId(B)Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected skipInternalWs(ZLjava/lang/String;)B
    .locals 6
    .param p1, "reqd"    # Z
    .param p2, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1256
    iget v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 1257
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 1259
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v0, v0, v1

    .line 1260
    .local v0, "b":B
    and-int/lit16 v1, v0, 0xff

    .line 1261
    .local v1, "c":I
    const/16 v2, 0x20

    if-le v1, v2, :cond_2

    .line 1262
    if-nez p1, :cond_1

    .line 1263
    return v0

    .line 1265
    :cond_1
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->decodeCharForError(B)I

    move-result v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " (expected white space "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ")"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v3, v4}, Lcom/fasterxml/aalto/in/StreamScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 1269
    :cond_2
    const/16 v3, 0xa

    if-ne v0, v3, :cond_3

    .line 1270
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->markLF()V

    goto :goto_0

    .line 1271
    :cond_3
    const/16 v4, 0xd

    if-ne v0, v4, :cond_6

    .line 1272
    iget v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v4, v5, :cond_4

    .line 1273
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 1275
    :cond_4
    iget-object v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v4, v4, v5

    if-ne v4, v3, :cond_5

    .line 1276
    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    .line 1278
    :cond_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->markLF()V

    goto :goto_0

    .line 1279
    :cond_6
    if-eq v0, v2, :cond_7

    const/16 v3, 0x9

    if-eq v0, v3, :cond_7

    .line 1280
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/StreamScanner;->throwInvalidSpace(I)V

    .line 1283
    :cond_7
    :goto_0
    iget v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputEnd:I

    if-lt v3, v4, :cond_8

    .line 1284
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/StreamScanner;->loadMoreGuaranteed()V

    .line 1286
    :cond_8
    iget-object v3, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/StreamScanner;->_inputPtr:I

    aget-byte v0, v3, v4

    .line 1287
    and-int/lit16 v3, v0, 0xff

    if-le v3, v2, :cond_2

    .line 1289
    return v0
.end method
