.class public abstract Lcom/fasterxml/aalto/out/XmlWriter;
.super Lcom/fasterxml/aalto/out/WNameFactory;
.source "XmlWriter.java"


# static fields
.field protected static final ATTR_MIN_ARRAYCOPY:I = 0xc

.field protected static final DEFAULT_COPYBUFFER_LEN:I = 0x200

.field protected static final MIN_ARRAYCOPY:I = 0xc

.field protected static final SURR1_FIRST:I = 0xd800

.field protected static final SURR1_LAST:I = 0xdbff

.field protected static final SURR2_FIRST:I = 0xdc00

.field protected static final SURR2_LAST:I = 0xdfff


# instance fields
.field protected final _cfgNsAware:Z

.field protected final _checkContent:Z

.field protected final _checkNames:Z

.field protected final _config:Lcom/fasterxml/aalto/out/WriterConfig;

.field protected _copyBuffer:[C

.field protected final _copyBufferLen:I

.field protected _locPastChars:I

.field protected _locRowNr:I

.field protected _locRowStartOffset:I

.field protected _xml11:Z


# direct methods
.method protected constructor <init>(Lcom/fasterxml/aalto/out/WriterConfig;)V
    .locals 2
    .param p1, "cfg"    # Lcom/fasterxml/aalto/out/WriterConfig;

    .line 113
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/WNameFactory;-><init>()V

    .line 73
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/XmlWriter;->_xml11:Z

    .line 86
    iput v0, p0, Lcom/fasterxml/aalto/out/XmlWriter;->_locPastChars:I

    .line 88
    const/4 v1, 0x1

    iput v1, p0, Lcom/fasterxml/aalto/out/XmlWriter;->_locRowNr:I

    .line 94
    iput v0, p0, Lcom/fasterxml/aalto/out/XmlWriter;->_locRowStartOffset:I

    .line 114
    iput-object p1, p0, Lcom/fasterxml/aalto/out/XmlWriter;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    .line 115
    const/16 v0, 0x200

    invoke-virtual {p1, v0}, Lcom/fasterxml/aalto/out/WriterConfig;->allocMediumCBuffer(I)[C

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/XmlWriter;->_copyBuffer:[C

    .line 116
    iget-object v0, p0, Lcom/fasterxml/aalto/out/XmlWriter;->_copyBuffer:[C

    array-length v0, v0

    iput v0, p0, Lcom/fasterxml/aalto/out/XmlWriter;->_copyBufferLen:I

    .line 118
    invoke-virtual {p1}, Lcom/fasterxml/aalto/out/WriterConfig;->isNamespaceAware()Z

    move-result v0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/XmlWriter;->_cfgNsAware:Z

    .line 119
    invoke-virtual {p1}, Lcom/fasterxml/aalto/out/WriterConfig;->willCheckContent()Z

    move-result v0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/XmlWriter;->_checkContent:Z

    .line 120
    invoke-virtual {p1}, Lcom/fasterxml/aalto/out/WriterConfig;->willCheckNames()Z

    move-result v0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/XmlWriter;->_checkNames:Z

    .line 121
    return-void
.end method

.method public static final guessEncodingBitSize(Lcom/fasterxml/aalto/out/WriterConfig;)I
    .locals 4
    .param p0, "cfg"    # Lcom/fasterxml/aalto/out/WriterConfig;

    .line 346
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/WriterConfig;->getPreferredEncoding()Ljava/lang/String;

    move-result-object v0

    .line 348
    .local v0, "enc":Ljava/lang/String;
    const/16 v1, 0x10

    if-eqz v0, :cond_6

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-nez v2, :cond_0

    goto :goto_1

    .line 352
    :cond_0
    invoke-static {v0}, Lcom/fasterxml/aalto/util/CharsetNames;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 355
    const-string v2, "UTF-8"

    if-ne v0, v2, :cond_1

    .line 356
    return v1

    .line 357
    :cond_1
    const-string v2, "ISO-8859-1"

    const/16 v3, 0x8

    if-ne v0, v2, :cond_2

    .line 358
    return v3

    .line 359
    :cond_2
    const-string v2, "US-ASCII"

    if-ne v0, v2, :cond_3

    .line 360
    const/4 v1, 0x7

    return v1

    .line 361
    :cond_3
    const-string v2, "UTF-16"

    if-eq v0, v2, :cond_5

    const-string v2, "UTF-16BE"

    if-eq v0, v2, :cond_5

    const-string v2, "UTF-16LE"

    if-eq v0, v2, :cond_5

    const-string v2, "UTF-32BE"

    if-eq v0, v2, :cond_5

    const-string v2, "UTF-32LE"

    if-ne v0, v2, :cond_4

    goto :goto_0

    .line 374
    :cond_4
    return v3

    .line 366
    :cond_5
    :goto_0
    return v1

    .line 349
    :cond_6
    :goto_1
    return v1
.end method


# virtual methods
.method public abstract _closeTarget(Z)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method

.method public _releaseBuffers()V
    .locals 2

    .line 178
    iget-object v0, p0, Lcom/fasterxml/aalto/out/XmlWriter;->_copyBuffer:[C

    .line 179
    .local v0, "buf":[C
    if-eqz v0, :cond_0

    .line 180
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/fasterxml/aalto/out/XmlWriter;->_copyBuffer:[C

    .line 181
    iget-object v1, p0, Lcom/fasterxml/aalto/out/XmlWriter;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v1, v0}, Lcom/fasterxml/aalto/out/WriterConfig;->freeMediumCBuffer([C)V

    .line 183
    :cond_0
    return-void
.end method

.method public final close(Z)V
    .locals 1
    .param p1, "forceTargetClose"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 171
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/XmlWriter;->flush()V

    .line 172
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/XmlWriter;->_releaseBuffers()V

    .line 173
    if-nez p1, :cond_1

    iget-object v0, p0, Lcom/fasterxml/aalto/out/XmlWriter;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WriterConfig;->willAutoCloseOutput()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/XmlWriter;->_closeTarget(Z)V

    .line 174
    return-void
.end method

.method public abstract constructName(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract constructName(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public enableXml11()V
    .locals 1

    .line 144
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/XmlWriter;->_xml11:Z

    .line 145
    return-void
.end method

.method public abstract flush()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method

.method public getAbsOffset()I
    .locals 2

    .line 328
    iget v0, p0, Lcom/fasterxml/aalto/out/XmlWriter;->_locPastChars:I

    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/XmlWriter;->getOutputPtr()I

    move-result v1

    add-int/2addr v0, v1

    return v0
.end method

.method public getColumn()I
    .locals 2

    .line 324
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/XmlWriter;->getOutputPtr()I

    move-result v0

    iget v1, p0, Lcom/fasterxml/aalto/out/XmlWriter;->_locRowStartOffset:I

    sub-int/2addr v0, v1

    add-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public abstract getHighestEncodable()I
.end method

.method protected abstract getOutputPtr()I
.end method

.method public getRow()I
    .locals 1

    .line 320
    iget v0, p0, Lcom/fasterxml/aalto/out/XmlWriter;->_locRowNr:I

    return v0
.end method

.method protected reportFailedEscaping(Ljava/lang/String;I)V
    .locals 2
    .param p1, "type"    # Ljava/lang/String;
    .param p2, "ch"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 411
    const v0, 0xfffe

    if-eq p2, v0, :cond_0

    const v0, 0xffff

    if-eq p2, v0, :cond_0

    const v0, 0xd800

    if-lt p2, v0, :cond_1

    const v0, 0xdfff

    if-gt p2, v0, :cond_1

    .line 412
    :cond_0
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/XmlWriter;->reportInvalidChar(I)V

    .line 415
    :cond_1
    const/16 v0, 0x20

    if-ge p2, v0, :cond_3

    .line 416
    if-eqz p2, :cond_2

    iget-object v0, p0, Lcom/fasterxml/aalto/out/XmlWriter;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/out/WriterConfig;->isXml11()Z

    move-result v0

    if-nez v0, :cond_3

    .line 417
    :cond_2
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/XmlWriter;->reportInvalidChar(I)V

    .line 420
    :cond_3
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_NO_ESCAPING:Ljava/lang/String;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    filled-new-array {p1, v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Ljava/text/MessageFormat;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 421
    .local v0, "msg":Ljava/lang/String;
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/XmlWriter;->reportNwfContent(Ljava/lang/String;)V

    .line 422
    return-void
.end method

.method protected reportInvalidChar(I)V
    .locals 3
    .param p1, "c"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 435
    :try_start_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/XmlWriter;->flush()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 438
    nop

    .line 440
    if-nez p1, :cond_0

    .line 441
    const-string v0, "Invalid null character in text to output"

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/XmlWriter;->reportNwfContent(Ljava/lang/String;)V

    .line 443
    :cond_0
    const/16 v0, 0x20

    if-lt p1, v0, :cond_1

    const/16 v0, 0x7f

    if-lt p1, v0, :cond_3

    const/16 v0, 0x9f

    if-gt p1, v0, :cond_3

    .line 444
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Invalid white space character (0x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ") in text to output"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 445
    .local v0, "msg":Ljava/lang/String;
    iget-boolean v1, p0, Lcom/fasterxml/aalto/out/XmlWriter;->_xml11:Z

    if-eqz v1, :cond_2

    .line 446
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " (can only be output using character entity)"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 448
    :cond_2
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/XmlWriter;->reportNwfContent(Ljava/lang/String;)V

    .line 450
    .end local v0    # "msg":Ljava/lang/String;
    :cond_3
    const v0, 0x10ffff

    if-le p1, v0, :cond_4

    .line 451
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Illegal unicode character point (0x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ") to output; max is 0x10FFFF as per RFC 3629"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/XmlWriter;->reportNwfContent(Ljava/lang/String;)V

    .line 456
    :cond_4
    const v0, 0xd800

    if-lt p1, v0, :cond_5

    const v0, 0xdfff

    if-gt p1, v0, :cond_5

    .line 457
    const-string v0, "Illegal surrogate pair -- can only be output via character entities (for current encoding), which are not allowed in this content"

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/XmlWriter;->reportNwfContent(Ljava/lang/String;)V

    .line 461
    :cond_5
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Invalid XML character "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Lcom/fasterxml/aalto/util/XmlChars;->getCharDesc(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " in text to output"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/XmlWriter;->reportNwfContent(Ljava/lang/String;)V

    .line 462
    return-void

    .line 436
    :catch_0
    move-exception v0

    .line 437
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method protected reportInvalidEmptyName()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 427
    const-string v0, "Empty String is not a valid name (local name, prefix or processing instruction target)"

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/XmlWriter;->reportNwfContent(Ljava/lang/String;)V

    .line 428
    return-void
.end method

.method protected reportNwfContent(Ljava/lang/String;)V
    .locals 0
    .param p1, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 397
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/XmlWriter;->throwOutputError(Ljava/lang/String;)V

    .line 398
    return-void
.end method

.method protected reportNwfContent(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 1
    .param p1, "format"    # Ljava/lang/String;
    .param p2, "arg1"    # Ljava/lang/Object;
    .param p3, "arg2"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 403
    filled-new-array {p2, p3}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {p1, v0}, Ljava/text/MessageFormat;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 404
    .local v0, "msg":Ljava/lang/String;
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/XmlWriter;->reportNwfContent(Ljava/lang/String;)V

    .line 405
    return-void
.end method

.method protected reportNwfName(Ljava/lang/String;)V
    .locals 0
    .param p1, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 385
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/XmlWriter;->throwOutputError(Ljava/lang/String;)V

    .line 386
    return-void
.end method

.method protected reportNwfName(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 0
    .param p1, "msg"    # Ljava/lang/String;
    .param p2, "arg"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 391
    invoke-virtual {p0, p1, p2}, Lcom/fasterxml/aalto/out/XmlWriter;->throwOutputError(Ljava/lang/String;Ljava/lang/Object;)V

    .line 392
    return-void
.end method

.method protected throwOutputError(Ljava/lang/String;)V
    .locals 2
    .param p1, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 469
    :try_start_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/XmlWriter;->flush()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 472
    nop

    .line 473
    new-instance v0, Ljavax/xml/stream/XMLStreamException;

    invoke-direct {v0, p1}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 470
    :catch_0
    move-exception v0

    .line 471
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method protected throwOutputError(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1
    .param p1, "format"    # Ljava/lang/String;
    .param p2, "arg"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 479
    filled-new-array {p2}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {p1, v0}, Ljava/text/MessageFormat;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 480
    .local v0, "msg":Ljava/lang/String;
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/XmlWriter;->throwOutputError(Ljava/lang/String;)V

    .line 481
    return-void
.end method

.method public abstract writeAttribute(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeAttribute(Lcom/fasterxml/aalto/out/WName;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeAttribute(Lcom/fasterxml/aalto/out/WName;[CII)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeCData(Ljava/lang/String;)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeCData([CII)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeCharacters(Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeCharacters([CII)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeComment(Ljava/lang/String;)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeDTD(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeDTD(Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeEndTag(Lcom/fasterxml/aalto/out/WName;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeEntityReference(Lcom/fasterxml/aalto/out/WName;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writePI(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeRaw(Ljava/lang/String;II)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeRaw([CII)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeSpace(Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeSpace([CII)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeStartTagEmptyEnd()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeStartTagEnd()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeStartTagStart(Lcom/fasterxml/aalto/out/WName;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeTypedValue(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract writeXmlDeclaration(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method
