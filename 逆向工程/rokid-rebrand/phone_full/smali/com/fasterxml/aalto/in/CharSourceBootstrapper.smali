.class public final Lcom/fasterxml/aalto/in/CharSourceBootstrapper;
.super Lcom/fasterxml/aalto/in/InputBootstrapper;
.source "CharSourceBootstrapper.java"


# static fields
.field static final CHAR_BOM_MARKER:C = '\ufeff'

.field static final DEFAULT_BUFFER_SIZE:I = 0xfa0


# instance fields
.field final _in:Ljava/io/Reader;

.field final _inputBuffer:[C

.field private _inputLast:I

.field private _inputPtr:I


# direct methods
.method private constructor <init>(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/Reader;)V
    .locals 1
    .param p1, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;
    .param p2, "r"    # Ljava/io/Reader;

    .line 80
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/in/InputBootstrapper;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V

    .line 81
    iput-object p2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_in:Ljava/io/Reader;

    .line 82
    const/16 v0, 0xfa0

    invoke-virtual {p1, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->allocFullCBuffer(I)[C

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputBuffer:[C

    .line 83
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    iput v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputLast:I

    .line 84
    return-void
.end method

.method private constructor <init>(Lcom/fasterxml/aalto/in/ReaderConfig;[CII)V
    .locals 1
    .param p1, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;
    .param p2, "buffer"    # [C
    .param p3, "start"    # I
    .param p4, "len"    # I

    .line 88
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/in/InputBootstrapper;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V

    .line 89
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_in:Ljava/io/Reader;

    .line 90
    iput-object p2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputBuffer:[C

    .line 91
    iput p3, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    .line 92
    add-int v0, p3, p4

    iput v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputLast:I

    .line 93
    return-void
.end method

.method public static construct(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/Reader;)Lcom/fasterxml/aalto/in/CharSourceBootstrapper;
    .locals 1
    .param p0, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;
    .param p1, "r"    # Ljava/io/Reader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 98
    new-instance v0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;

    invoke-direct {v0, p0, p1}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/Reader;)V

    return-object v0
.end method

.method public static construct(Lcom/fasterxml/aalto/in/ReaderConfig;[CII)Lcom/fasterxml/aalto/in/CharSourceBootstrapper;
    .locals 1
    .param p0, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;
    .param p1, "buffer"    # [C
    .param p2, "start"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 104
    new-instance v0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;[CII)V

    return-object v0
.end method


# virtual methods
.method public final bootstrap()Lcom/fasterxml/aalto/in/XmlScanner;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 111
    :try_start_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->doBootstrap()Lcom/fasterxml/aalto/in/XmlScanner;

    move-result-object v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 115
    iget-object v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    iget-object v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->mKeyword:[C

    invoke-virtual {v1, v2}, Lcom/fasterxml/aalto/in/ReaderConfig;->freeSmallCBuffer([C)V

    .line 111
    return-object v0

    .line 115
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 112
    :catch_0
    move-exception v0

    .line 113
    .local v0, "ioe":Ljava/io/IOException;
    :try_start_1
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 115
    .end local v0    # "ioe":Ljava/io/IOException;
    :goto_0
    iget-object v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    iget-object v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->mKeyword:[C

    invoke-virtual {v1, v2}, Lcom/fasterxml/aalto/in/ReaderConfig;->freeSmallCBuffer([C)V

    .line 116
    throw v0
.end method

.method protected checkKeyword(Ljava/lang/String;)I
    .locals 5
    .param p1, "exp"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 306
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 308
    .local v0, "len":I
    const/4 v1, 0x1

    .local v1, "ptr":I
    :goto_0
    if-ge v1, v0, :cond_3

    .line 309
    iget v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputLast:I

    if-ge v2, v3, :cond_0

    iget-object v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputBuffer:[C

    iget v3, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    aget-char v2, v2, v3

    goto :goto_1

    .line 310
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->nextChar()C

    move-result v2

    :goto_1
    nop

    .line 312
    .local v2, "c":C
    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v3

    if-eq v2, v3, :cond_1

    .line 313
    return v2

    .line 315
    :cond_1
    if-nez v2, :cond_2

    .line 316
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->reportNull()V

    .line 308
    .end local v2    # "c":C
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 320
    .end local v1    # "ptr":I
    :cond_3
    const/4 v1, 0x0

    return v1
.end method

.method public doBootstrap()Lcom/fasterxml/aalto/in/XmlScanner;
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 121
    iget v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputLast:I

    const/4 v2, 0x7

    if-lt v0, v1, :cond_0

    .line 122
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->initialLoad(I)Z

    .line 125
    :cond_0
    const/4 v0, 0x0

    .line 132
    .local v0, "normEnc":Ljava/lang/String;
    iget v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputLast:I

    iget v3, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    sub-int/2addr v1, v3

    if-lt v1, v2, :cond_4

    .line 133
    iget-object v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    aget-char v1, v1, v2

    .line 136
    .local v1, "c":C
    const v2, 0xfeff

    if-ne v1, v2, :cond_1

    .line 137
    iget-object v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputBuffer:[C

    iget v3, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    aget-char v1, v2, v3

    .line 139
    :cond_1
    const/16 v2, 0x3c

    if-ne v1, v2, :cond_2

    .line 140
    iget-object v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputBuffer:[C

    iget v3, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v3, v3, 0x1

    aget-char v2, v2, v3

    const/16 v3, 0x3f

    if-ne v2, v3, :cond_4

    iget-object v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputBuffer:[C

    iget v3, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v3, v3, 0x2

    aget-char v2, v2, v3

    const/16 v3, 0x78

    if-ne v2, v3, :cond_4

    iget-object v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputBuffer:[C

    iget v3, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v3, v3, 0x3

    aget-char v2, v2, v3

    const/16 v3, 0x6d

    if-ne v2, v3, :cond_4

    iget-object v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputBuffer:[C

    iget v3, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v3, v3, 0x4

    aget-char v2, v2, v3

    const/16 v3, 0x6c

    if-ne v2, v3, :cond_4

    iget-object v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputBuffer:[C

    iget v3, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v3, v3, 0x5

    aget-char v2, v2, v3

    const/16 v3, 0x20

    if-gt v2, v3, :cond_4

    .line 146
    iget v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v2, v2, 0x6

    iput v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    .line 147
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->readXmlDeclaration()V

    .line 149
    iget-object v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->mFoundEncoding:Ljava/lang/String;

    if-eqz v2, :cond_4

    .line 150
    iget-object v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->mFoundEncoding:Ljava/lang/String;

    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->verifyXmlEncoding(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 165
    :cond_2
    const/16 v2, 0xef

    if-eq v1, v2, :cond_3

    goto :goto_0

    .line 166
    :cond_3
    new-instance v2, Lcom/fasterxml/aalto/impl/IoStreamException;

    const-string v3, "Unexpected first character (char code 0xEF), not valid in xml document: could be mangled UTF-8 BOM marker. Make sure that the Reader uses correct encoding or pass an InputStream instead"

    invoke-direct {v2, v3}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 170
    .end local v1    # "c":C
    :cond_4
    :goto_0
    iget-object v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v1, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->setActualEncoding(Ljava/lang/String;)V

    .line 171
    iget-object v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    iget v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->mDeclaredXmlVersion:I

    iget-object v3, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->mFoundEncoding:Ljava/lang/String;

    iget-object v4, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->mStandalone:Ljava/lang/String;

    invoke-virtual {v1, v2, v3, v4}, Lcom/fasterxml/aalto/in/ReaderConfig;->setXmlDeclInfo(ILjava/lang/String;Ljava/lang/String;)V

    .line 172
    new-instance v1, Lcom/fasterxml/aalto/in/ReaderScanner;

    iget-object v6, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    iget-object v7, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_in:Ljava/io/Reader;

    iget-object v8, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputBuffer:[C

    iget v9, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    iget v10, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputLast:I

    move-object v5, v1

    invoke-direct/range {v5 .. v10}, Lcom/fasterxml/aalto/in/ReaderScanner;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/Reader;[CII)V

    return-object v1
.end method

.method protected getLocation()Ljavax/xml/stream/Location;
    .locals 7

    .line 351
    iget-object v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    .line 352
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getPublicId()Ljava/lang/String;

    move-result-object v1

    iget-object v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getSystemId()Ljava/lang/String;

    move-result-object v2

    iget v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputProcessed:I

    iget v3, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    add-int/2addr v0, v3

    int-to-long v3, v0

    iget v5, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputRow:I

    iget v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputRowStart:I

    sub-int v6, v0, v6

    invoke-static/range {v1 .. v6}, Lcom/fasterxml/aalto/impl/LocationImpl;->fromZeroBased(Ljava/lang/String;Ljava/lang/String;JII)Lcom/fasterxml/aalto/impl/LocationImpl;

    move-result-object v0

    .line 351
    return-object v0
.end method

.method protected getNext()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 269
    iget v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputLast:I

    if-ge v0, v1, :cond_0

    iget-object v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputBuffer:[C

    iget v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    aget-char v0, v0, v1

    goto :goto_0

    .line 270
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->nextChar()C

    move-result v0

    .line 269
    :goto_0
    return v0
.end method

.method protected getNextAfterWs(Z)I
    .locals 4
    .param p1, "reqWs"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 277
    const/4 v0, 0x0

    .line 280
    .local v0, "count":I
    :goto_0
    iget v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputLast:I

    if-ge v1, v2, :cond_0

    iget-object v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    aget-char v1, v1, v2

    goto :goto_1

    .line 281
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->nextChar()C

    move-result v1

    :goto_1
    nop

    .line 283
    .local v1, "c":C
    const/16 v2, 0x20

    if-le v1, v2, :cond_2

    .line 284
    if-eqz p1, :cond_1

    if-nez v0, :cond_1

    .line 285
    const-string v2, "; expected a white space"

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->reportUnexpectedChar(ILjava/lang/String;)V

    .line 287
    :cond_1
    return v1

    .line 289
    :cond_2
    const/16 v2, 0xd

    if-eq v1, v2, :cond_4

    const/16 v2, 0xa

    if-ne v1, v2, :cond_3

    goto :goto_2

    .line 291
    :cond_3
    if-nez v1, :cond_5

    .line 292
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->reportNull()V

    goto :goto_3

    .line 290
    :cond_4
    :goto_2
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->skipCRLF(C)V

    .line 294
    :cond_5
    :goto_3
    nop

    .end local v1    # "c":C
    add-int/lit8 v0, v0, 0x1

    .line 295
    goto :goto_0
.end method

.method protected initialLoad(I)Z
    .locals 7
    .param p1, "minimum"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 216
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    .line 217
    iput v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputLast:I

    .line 219
    iget-object v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_in:Ljava/io/Reader;

    if-nez v1, :cond_0

    .line 220
    return v0

    .line 223
    :cond_0
    :goto_0
    iget v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputLast:I

    const/4 v2, 0x1

    if-ge v1, p1, :cond_2

    .line 224
    iget-object v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_in:Ljava/io/Reader;

    iget-object v3, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputLast:I

    iget-object v5, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputBuffer:[C

    array-length v5, v5

    iget v6, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputLast:I

    sub-int/2addr v5, v6

    invoke-virtual {v1, v3, v4, v5}, Ljava/io/Reader;->read([CII)I

    move-result v1

    .line 226
    .local v1, "count":I
    if-ge v1, v2, :cond_1

    .line 227
    return v0

    .line 229
    :cond_1
    iget v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputLast:I

    add-int/2addr v2, v1

    iput v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputLast:I

    .line 230
    .end local v1    # "count":I
    goto :goto_0

    .line 231
    :cond_2
    return v2
.end method

.method protected loadMore()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 241
    iget v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputProcessed:I

    iget v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputLast:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputProcessed:I

    .line 242
    iget v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputRowStart:I

    iget v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputLast:I

    sub-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputRowStart:I

    .line 244
    iget-object v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_in:Ljava/io/Reader;

    if-nez v0, :cond_0

    .line 245
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->reportEof()V

    .line 248
    :cond_0
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    .line 249
    iget-object v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_in:Ljava/io/Reader;

    iget-object v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputBuffer:[C

    iget-object v3, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputBuffer:[C

    array-length v3, v3

    invoke-virtual {v1, v2, v0, v3}, Ljava/io/Reader;->read([CII)I

    move-result v0

    iput v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputLast:I

    .line 250
    iget v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputLast:I

    const/4 v1, 0x1

    if-ge v0, v1, :cond_1

    .line 251
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->reportEof()V

    .line 253
    :cond_1
    return-void
.end method

.method protected nextChar()C
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 364
    iget v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputLast:I

    if-lt v0, v1, :cond_0

    .line 365
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->loadMore()V

    .line 367
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputBuffer:[C

    iget v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    aget-char v0, v0, v1

    return v0
.end method

.method protected pushback()V
    .locals 1

    .line 263
    iget v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    .line 264
    return-void
.end method

.method protected readQuotedValue([CI)I
    .locals 5
    .param p1, "kw"    # [C
    .param p2, "quoteChar"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 327
    const/4 v0, 0x0

    .line 328
    .local v0, "i":I
    array-length v1, p1

    .line 331
    .local v1, "len":I
    :goto_0
    iget v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputLast:I

    if-ge v2, v3, :cond_0

    iget-object v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputBuffer:[C

    iget v3, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    aget-char v2, v2, v3

    goto :goto_1

    .line 332
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->nextChar()C

    move-result v2

    :goto_1
    nop

    .line 333
    .local v2, "c":C
    const/16 v3, 0xd

    if-eq v2, v3, :cond_2

    const/16 v3, 0xa

    if-ne v2, v3, :cond_1

    goto :goto_2

    .line 335
    :cond_1
    if-nez v2, :cond_3

    .line 336
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->reportNull()V

    goto :goto_3

    .line 334
    :cond_2
    :goto_2
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->skipCRLF(C)V

    .line 338
    :cond_3
    :goto_3
    if-ne v2, p2, :cond_5

    .line 339
    if-ge v0, v1, :cond_4

    move v3, v0

    goto :goto_4

    :cond_4
    const/4 v3, -0x1

    :goto_4
    return v3

    .line 342
    :cond_5
    if-ge v0, v1, :cond_6

    .line 343
    add-int/lit8 v3, v0, 0x1

    .end local v0    # "i":I
    .local v3, "i":I
    aput-char v2, p1, v0

    move v0, v3

    .line 345
    .end local v2    # "c":C
    .end local v3    # "i":I
    .restart local v0    # "i":I
    :cond_6
    goto :goto_0
.end method

.method protected skipCRLF(C)V
    .locals 3
    .param p1, "lf"    # C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 372
    const/16 v0, 0xd

    if-ne p1, v0, :cond_1

    .line 373
    iget v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputLast:I

    if-ge v0, v1, :cond_0

    iget-object v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputBuffer:[C

    iget v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    aget-char v0, v0, v1

    goto :goto_0

    .line 374
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->nextChar()C

    move-result v0

    :goto_0
    nop

    .line 375
    .local v0, "c":C
    const/16 v1, 0xa

    if-eq v0, v1, :cond_1

    .line 376
    iget v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v1, v1, -0x1

    iput v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    .line 379
    .end local v0    # "c":C
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputRow:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputRow:I

    .line 380
    iget v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputPtr:I

    iput v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_inputRowStart:I

    .line 381
    return-void
.end method

.method protected verifyXmlEncoding(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p1, "enc"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 187
    invoke-static {p1}, Lcom/fasterxml/aalto/util/CharsetNames;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 191
    iget-object v0, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getExternalEncoding()Ljava/lang/String;

    move-result-object v0

    .line 192
    .local v0, "extEnc":Ljava/lang/String;
    if-eqz v0, :cond_0

    if-eqz p1, :cond_0

    .line 193
    invoke-virtual {v0, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 194
    iget-object v1, p0, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->getXMLReporter()Ljavax/xml/stream/XMLReporter;

    move-result-object v1

    .line 195
    .local v1, "rep":Ljavax/xml/stream/XMLReporter;
    if-eqz v1, :cond_0

    .line 196
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/CharSourceBootstrapper;->getLocation()Ljavax/xml/stream/Location;

    move-result-object v2

    .line 197
    .local v2, "loc":Ljavax/xml/stream/Location;
    sget-object v3, Lcom/fasterxml/aalto/impl/ErrorConsts;->W_MIXED_ENCODINGS:Ljava/lang/String;

    filled-new-array {v0, p1}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Ljava/text/MessageFormat;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    sget-object v4, Lcom/fasterxml/aalto/impl/ErrorConsts;->WT_XML_DECL:Ljava/lang/String;

    invoke-interface {v1, v3, v4, p0, v2}, Ljavax/xml/stream/XMLReporter;->report(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Ljavax/xml/stream/Location;)V

    .line 204
    .end local v1    # "rep":Ljavax/xml/stream/XMLReporter;
    .end local v2    # "loc":Ljavax/xml/stream/Location;
    :cond_0
    return-object p1
.end method
