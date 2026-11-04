.class public final Lcom/fasterxml/aalto/out/CharXmlWriter;
.super Lcom/fasterxml/aalto/out/XmlWriter;
.source "CharXmlWriter.java"


# static fields
.field static final DEFAULT_FULL_BUFFER_SIZE:I = 0x3e8

.field static final DEFAULT_SMALL_SIZE:I = 0xc8


# instance fields
.field protected _out:Ljava/io/Writer;

.field protected _outputBuffer:[C

.field protected final _outputBufferLen:I

.field protected _outputPtr:I

.field final mCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

.field private final mEncHighChar:I

.field protected final mSmallWriteSize:I

.field private final mTableCheckEnd:I


# direct methods
.method public constructor <init>(Lcom/fasterxml/aalto/out/WriterConfig;Ljava/io/Writer;)V
    .locals 3
    .param p1, "cfg"    # Lcom/fasterxml/aalto/out/WriterConfig;
    .param p2, "out"    # Ljava/io/Writer;

    .line 118
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/out/XmlWriter;-><init>(Lcom/fasterxml/aalto/out/WriterConfig;)V

    .line 119
    iput-object p2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    .line 120
    const/16 v0, 0x3e8

    invoke-virtual {p1, v0}, Lcom/fasterxml/aalto/out/WriterConfig;->allocFullCBuffer(I)[C

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    .line 121
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    array-length v0, v0

    iput v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    .line 122
    const/16 v0, 0xc8

    iput v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mSmallWriteSize:I

    .line 123
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 132
    invoke-static {p1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->guessEncodingBitSize(Lcom/fasterxml/aalto/out/WriterConfig;)I

    move-result v0

    .line 135
    .local v0, "bitsize":I
    const/16 v1, 0x10

    if-ge v0, v1, :cond_0

    const/4 v1, 0x1

    shl-int/2addr v1, v0

    goto :goto_0

    :cond_0
    const v1, 0xfffe

    :goto_0
    iput v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mEncHighChar:I

    .line 136
    const/16 v1, 0x100

    iget v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mEncHighChar:I

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v1

    iput v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mTableCheckEnd:I

    .line 140
    const/16 v1, 0x8

    if-ge v0, v1, :cond_1

    invoke-static {}, Lcom/fasterxml/aalto/out/OutputCharTypes;->getAsciiCharTypes()Lcom/fasterxml/aalto/util/XmlCharTypes;

    move-result-object v1

    goto :goto_1

    .line 141
    :cond_1
    invoke-static {}, Lcom/fasterxml/aalto/out/OutputCharTypes;->getLatin1CharTypes()Lcom/fasterxml/aalto/util/XmlCharTypes;

    move-result-object v1

    :goto_1
    iput-object v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    .line 142
    return-void
.end method

.method private final fastWriteRaw(C)V
    .locals 3
    .param p1, "c"    # C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1246
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-lt v0, v1, :cond_1

    .line 1247
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    if-nez v0, :cond_0

    .line 1248
    return-void

    .line 1250
    :cond_0
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 1252
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    aput-char p1, v0, v1

    .line 1253
    return-void
.end method

.method private final fastWriteRaw(CC)V
    .locals 3
    .param p1, "c1"    # C
    .param p2, "c2"    # C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1258
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/lit8 v0, v0, 0x1

    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-lt v0, v1, :cond_1

    .line 1259
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    if-nez v0, :cond_0

    .line 1260
    return-void

    .line 1262
    :cond_0
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 1264
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    aput-char p1, v0, v1

    .line 1265
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    aput-char p2, v0, v1

    .line 1266
    return-void
.end method

.method private final fastWriteRaw(Ljava/lang/String;)V
    .locals 5
    .param p1, "str"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1271
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 1272
    .local v0, "len":I
    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 1273
    .local v1, "ptr":I
    add-int v2, v1, v0

    iget v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    const/4 v4, 0x0

    if-lt v2, v3, :cond_2

    .line 1274
    iget-object v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    if-nez v2, :cond_0

    .line 1275
    return-void

    .line 1281
    :cond_0
    iget v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-le v0, v2, :cond_1

    .line 1282
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {p0, p1, v4, v2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeRaw(Ljava/lang/String;II)V

    .line 1283
    return-void

    .line 1285
    :cond_1
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 1286
    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 1288
    :cond_2
    iget-object v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    invoke-virtual {p1, v4, v0, v2, v1}, Ljava/lang/String;->getChars(II[CI)V

    .line 1289
    add-int v2, v1, v0

    iput v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 1290
    return-void
.end method

.method private final flushBuffer()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1209
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    if-eqz v0, :cond_0

    .line 1210
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 1212
    .local v0, "ptr":I
    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_locPastChars:I

    add-int/2addr v1, v0

    iput v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_locPastChars:I

    .line 1213
    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_locRowStartOffset:I

    sub-int/2addr v1, v0

    iput v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_locRowStartOffset:I

    .line 1214
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 1215
    iget-object v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    iget-object v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    invoke-virtual {v2, v3, v1, v0}, Ljava/io/Writer;->write([CII)V

    .line 1217
    .end local v0    # "ptr":I
    :cond_0
    return-void
.end method

.method private final writeAttrValue(Ljava/lang/String;I)V
    .locals 6
    .param p1, "value"    # Ljava/lang/String;
    .param p2, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1010
    const/4 v0, 0x0

    .line 1012
    .local v0, "offset":I
    :goto_0
    if-lez p2, :cond_1

    .line 1013
    iget-object v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_copyBuffer:[C

    .line 1014
    .local v1, "buf":[C
    array-length v2, v1

    .line 1015
    .local v2, "blen":I
    if-ge p2, v2, :cond_0

    move v3, p2

    goto :goto_1

    :cond_0
    move v3, v2

    .line 1016
    .local v3, "len2":I
    :goto_1
    add-int v4, v0, v3

    const/4 v5, 0x0

    invoke-virtual {p1, v0, v4, v1, v5}, Ljava/lang/String;->getChars(II[CI)V

    .line 1017
    invoke-direct {p0, v1, v5, v3}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeAttrValue([CII)V

    .line 1018
    add-int/2addr v0, v3

    .line 1019
    sub-int/2addr p2, v3

    .line 1020
    .end local v1    # "buf":[C
    .end local v2    # "blen":I
    .end local v3    # "len2":I
    goto :goto_0

    .line 1021
    :cond_1
    return-void
.end method

.method private final writeAttrValue([CII)V
    .locals 6
    .param p1, "cbuf"    # [C
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1026
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    if-nez v0, :cond_0

    .line 1027
    return-void

    .line 1030
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/2addr v0, p3

    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-le v0, v1, :cond_1

    .line 1031
    invoke-direct {p0, p1, p2, p3}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeSplitAttrValue([CII)V

    .line 1032
    return-void

    .line 1036
    :cond_1
    add-int/2addr p3, p2

    .line 1039
    :goto_0
    if-ge p2, p3, :cond_8

    .line 1040
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    .line 1041
    .local v0, "charTypes":[I
    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mTableCheckEnd:I

    .line 1045
    .local v1, "limit":I
    :goto_1
    aget-char v2, p1, p2

    .line 1046
    .local v2, "ch":C
    if-lt v2, v1, :cond_2

    .line 1047
    goto :goto_2

    .line 1049
    :cond_2
    aget v3, v0, v2

    if-eqz v3, :cond_6

    .line 1050
    nop

    .line 1059
    .end local v2    # "ch":C
    :goto_2
    add-int/lit8 v2, p2, 0x1

    .end local p2    # "offset":I
    .local v2, "offset":I
    aget-char p2, p1, p2

    .line 1060
    .local p2, "ch":C
    if-ge p2, v1, :cond_3

    .line 1061
    aget v3, v0, p2

    sparse-switch v3, :sswitch_data_0

    .line 1077
    iget-object v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    aput-char p2, v3, v4

    .line 1078
    goto :goto_4

    .line 1075
    :sswitch_0
    goto :goto_3

    .line 1063
    :sswitch_1
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->reportInvalidChar(I)V

    .line 1068
    :sswitch_2
    goto :goto_3

    .line 1080
    :cond_3
    iget v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mEncHighChar:I

    if-ge p2, v3, :cond_4

    .line 1081
    iget-object v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    aput-char p2, v3, v4

    .line 1082
    goto :goto_4

    .line 1084
    :cond_4
    :goto_3
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeAsEntity(I)V

    .line 1089
    sub-int v3, p3, v2

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    iget v5, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    sub-int/2addr v4, v5

    if-lt v3, v4, :cond_5

    .line 1090
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 1092
    .end local v0    # "charTypes":[I
    .end local v1    # "limit":I
    .end local p2    # "ch":C
    :cond_5
    nop

    .line 1039
    :goto_4
    move p2, v2

    goto :goto_0

    .line 1052
    .restart local v0    # "charTypes":[I
    .restart local v1    # "limit":I
    .local v2, "ch":C
    .local p2, "offset":I
    :cond_6
    iget-object v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    aput-char v2, v3, v4

    .line 1053
    add-int/lit8 p2, p2, 0x1

    if-lt p2, p3, :cond_7

    .line 1054
    goto :goto_5

    .line 1056
    .end local v2    # "ch":C
    :cond_7
    goto :goto_1

    .line 1093
    .end local v0    # "charTypes":[I
    .end local v1    # "limit":I
    :cond_8
    :goto_5
    return-void

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_1
        0x2 -> :sswitch_0
        0x3 -> :sswitch_0
        0x4 -> :sswitch_2
        0x9 -> :sswitch_2
        0xa -> :sswitch_2
        0xe -> :sswitch_2
    .end sparse-switch
.end method

.method private writeCDataContents([CII)I
    .locals 7
    .param p1, "cbuf"    # [C
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 383
    add-int/2addr p3, p2

    .line 385
    move v0, p2

    .line 388
    .local v0, "start":I
    :goto_0
    if-ge p2, p3, :cond_8

    .line 389
    iget-object v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v1, v1, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 390
    .local v1, "charTypes":[I
    iget v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mTableCheckEnd:I

    .line 394
    .local v2, "limit":I
    :goto_1
    aget-char v3, p1, p2

    .line 395
    .local v3, "ch":C
    if-lt v3, v2, :cond_0

    .line 396
    goto :goto_2

    .line 398
    :cond_0
    aget v4, v1, v3

    if-eqz v4, :cond_5

    .line 399
    nop

    .line 411
    .end local v3    # "ch":C
    :goto_2
    add-int/lit8 v3, p2, 0x1

    .end local p2    # "offset":I
    .local v3, "offset":I
    aget-char p2, p1, p2

    .line 412
    .local p2, "ch":I
    const-string v4, "CDATA block"

    if-ge p2, v2, :cond_2

    .line 413
    aget v5, v1, p2

    sparse-switch v5, :sswitch_data_0

    goto :goto_3

    .line 420
    :sswitch_0
    invoke-virtual {p0, v4, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->reportFailedEscaping(Ljava/lang/String;I)V

    .line 422
    :sswitch_1
    sub-int v4, v3, v0

    const/4 v5, 0x3

    if-lt v4, v5, :cond_1

    add-int/lit8 v4, v3, -0x2

    aget-char v4, p1, v4

    const/16 v5, 0x5d

    if-ne v4, v5, :cond_1

    add-int/lit8 v4, v3, -0x3

    aget-char v4, p1, v4

    if-ne v4, v5, :cond_1

    .line 424
    add-int/lit8 v3, v3, -0x1

    .line 426
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeCDataEnd()V

    .line 427
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeCDataStart()V

    goto :goto_3

    .line 415
    :sswitch_2
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->reportInvalidChar(I)V

    .line 418
    :sswitch_3
    nop

    .line 429
    :cond_1
    :goto_3
    goto :goto_4

    .line 433
    :cond_2
    iget v5, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mEncHighChar:I

    if-lt p2, v5, :cond_3

    .line 434
    invoke-virtual {p0, v4, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->reportFailedEscaping(Ljava/lang/String;I)V

    .line 438
    :cond_3
    :goto_4
    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-lt v4, v5, :cond_4

    .line 439
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 441
    :cond_4
    iget-object v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v5, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    int-to-char v6, p2

    aput-char v6, v4, v5

    .line 442
    .end local v1    # "charTypes":[I
    .end local v2    # "limit":I
    .end local p2    # "ch":I
    move p2, v3

    goto :goto_0

    .line 401
    .restart local v1    # "charTypes":[I
    .restart local v2    # "limit":I
    .local v3, "ch":C
    .local p2, "offset":I
    :cond_5
    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-lt v4, v5, :cond_6

    .line 402
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 404
    :cond_6
    iget-object v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v5, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    aput-char v3, v4, v5

    .line 405
    add-int/lit8 p2, p2, 0x1

    if-lt p2, p3, :cond_7

    .line 406
    goto :goto_5

    .line 408
    .end local v3    # "ch":C
    :cond_7
    goto :goto_1

    .line 443
    .end local v1    # "charTypes":[I
    .end local v2    # "limit":I
    :cond_8
    :goto_5
    const/4 v1, -0x1

    return v1

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_2
        0x2 -> :sswitch_3
        0x3 -> :sswitch_3
        0x4 -> :sswitch_0
        0x11 -> :sswitch_1
    .end sparse-switch
.end method

.method private writeCommentContents([CIIZ)I
    .locals 6
    .param p1, "cbuf"    # [C
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .param p4, "last"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 646
    add-int/2addr p3, p2

    .line 649
    :goto_0
    if-ge p2, p3, :cond_b

    .line 650
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 651
    .local v0, "charTypes":[I
    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mTableCheckEnd:I

    .line 655
    .local v1, "limit":I
    :goto_1
    aget-char v2, p1, p2

    .line 656
    .local v2, "ch":C
    if-lt v2, v1, :cond_0

    .line 657
    goto :goto_2

    .line 659
    :cond_0
    aget v3, v0, v2

    if-eqz v3, :cond_8

    .line 660
    nop

    .line 672
    .end local v2    # "ch":C
    :goto_2
    add-int/lit8 v2, p2, 0x1

    .end local p2    # "offset":I
    .local v2, "offset":I
    aget-char p2, p1, p2

    .line 673
    .local p2, "ch":I
    const-string v3, "comment"

    if-ge p2, v1, :cond_5

    .line 674
    aget v4, v0, p2

    sparse-switch v4, :sswitch_data_0

    goto :goto_3

    .line 681
    :sswitch_0
    invoke-virtual {p0, v3, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->reportFailedEscaping(Ljava/lang/String;I)V

    .line 686
    :sswitch_1
    if-eq v2, p3, :cond_1

    aget-char v3, p1, v2

    const/16 v4, 0x2d

    if-ne v3, v4, :cond_4

    .line 687
    :cond_1
    iget-object v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/out/WriterConfig;->willFixContent()Z

    move-result v3

    if-nez v3, :cond_2

    .line 688
    add-int/lit8 v3, v2, -0x1

    return v3

    .line 690
    :cond_2
    iget v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-lt v3, v4, :cond_3

    .line 691
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 693
    :cond_3
    iget-object v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    const/16 v5, 0x20

    aput-char v5, v3, v4

    goto :goto_3

    .line 676
    :sswitch_2
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->reportInvalidChar(I)V

    .line 679
    :sswitch_3
    nop

    .line 695
    :cond_4
    :goto_3
    goto :goto_4

    .line 699
    :cond_5
    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mEncHighChar:I

    if-lt p2, v4, :cond_6

    .line 700
    invoke-virtual {p0, v3, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->reportFailedEscaping(Ljava/lang/String;I)V

    .line 703
    :cond_6
    :goto_4
    iget v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-lt v3, v4, :cond_7

    .line 704
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 706
    :cond_7
    iget-object v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    int-to-char v5, p2

    aput-char v5, v3, v4

    .line 707
    .end local v0    # "charTypes":[I
    .end local v1    # "limit":I
    .end local p2    # "ch":I
    move p2, v2

    goto :goto_0

    .line 662
    .restart local v0    # "charTypes":[I
    .restart local v1    # "limit":I
    .local v2, "ch":C
    .local p2, "offset":I
    :cond_8
    iget v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-lt v3, v4, :cond_9

    .line 663
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 665
    :cond_9
    iget-object v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    aput-char v2, v3, v4

    .line 666
    add-int/lit8 p2, p2, 0x1

    if-lt p2, p3, :cond_a

    .line 667
    goto :goto_5

    .line 669
    .end local v2    # "ch":C
    :cond_a
    goto :goto_1

    .line 708
    .end local v0    # "charTypes":[I
    .end local v1    # "limit":I
    :cond_b
    :goto_5
    const/4 v0, -0x1

    return v0

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_2
        0x2 -> :sswitch_3
        0x3 -> :sswitch_3
        0x4 -> :sswitch_0
        0xd -> :sswitch_1
    .end sparse-switch
.end method

.method private writePIContents([CII)I
    .locals 6
    .param p1, "cbuf"    # [C
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 828
    add-int/2addr p3, p2

    .line 831
    :goto_0
    if-ge p2, p3, :cond_8

    .line 832
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 833
    .local v0, "charTypes":[I
    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mTableCheckEnd:I

    .line 837
    .local v1, "limit":I
    :goto_1
    aget-char v2, p1, p2

    .line 838
    .local v2, "ch":C
    if-lt v2, v1, :cond_0

    .line 839
    goto :goto_2

    .line 841
    :cond_0
    aget v3, v0, v2

    if-eqz v3, :cond_5

    .line 842
    nop

    .line 854
    .end local v2    # "ch":C
    :goto_2
    add-int/lit8 v2, p2, 0x1

    .end local p2    # "offset":I
    .local v2, "offset":I
    aget-char p2, p1, p2

    .line 855
    .local p2, "ch":I
    const-string v3, "processing instruction"

    if-ge p2, v1, :cond_2

    .line 856
    aget v4, v0, p2

    sparse-switch v4, :sswitch_data_0

    goto :goto_3

    .line 863
    :sswitch_0
    invoke-virtual {p0, v3, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->reportFailedEscaping(Ljava/lang/String;I)V

    .line 865
    :sswitch_1
    if-ge v2, p3, :cond_1

    aget-char v3, p1, v2

    const/16 v4, 0x3e

    if-ne v3, v4, :cond_1

    .line 866
    return v2

    .line 858
    :sswitch_2
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->reportInvalidChar(I)V

    .line 861
    :sswitch_3
    nop

    .line 868
    :cond_1
    :goto_3
    goto :goto_4

    .line 872
    :cond_2
    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mEncHighChar:I

    if-lt p2, v4, :cond_3

    .line 873
    invoke-virtual {p0, v3, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->reportFailedEscaping(Ljava/lang/String;I)V

    .line 876
    :cond_3
    :goto_4
    iget v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-lt v3, v4, :cond_4

    .line 877
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 879
    :cond_4
    iget-object v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    int-to-char v5, p2

    aput-char v5, v3, v4

    .line 880
    .end local v0    # "charTypes":[I
    .end local v1    # "limit":I
    .end local p2    # "ch":I
    move p2, v2

    goto :goto_0

    .line 844
    .restart local v0    # "charTypes":[I
    .restart local v1    # "limit":I
    .local v2, "ch":C
    .local p2, "offset":I
    :cond_5
    iget v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-lt v3, v4, :cond_6

    .line 845
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 847
    :cond_6
    iget-object v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    aput-char v2, v3, v4

    .line 848
    add-int/lit8 p2, p2, 0x1

    if-lt p2, p3, :cond_7

    .line 849
    goto :goto_5

    .line 851
    .end local v2    # "ch":C
    :cond_7
    goto :goto_1

    .line 881
    .end local v0    # "charTypes":[I
    .end local v1    # "limit":I
    :cond_8
    :goto_5
    const/4 v0, -0x1

    return v0

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_2
        0x2 -> :sswitch_3
        0x3 -> :sswitch_3
        0x4 -> :sswitch_0
        0xc -> :sswitch_1
    .end sparse-switch
.end method

.method private final writeSplitAttrValue([CII)V
    .locals 6
    .param p1, "cbuf"    # [C
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1098
    add-int/2addr p3, p2

    .line 1101
    :goto_0
    if-ge p2, p3, :cond_7

    .line 1102
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    .line 1103
    .local v0, "charTypes":[I
    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mTableCheckEnd:I

    .line 1107
    .local v1, "limit":I
    :goto_1
    aget-char v2, p1, p2

    .line 1108
    .local v2, "ch":C
    if-lt v2, v1, :cond_0

    .line 1109
    goto :goto_2

    .line 1111
    :cond_0
    aget v3, v0, v2

    if-eqz v3, :cond_4

    .line 1112
    nop

    .line 1124
    .end local v2    # "ch":C
    :goto_2
    add-int/lit8 v2, p2, 0x1

    .end local p2    # "offset":I
    .local v2, "offset":I
    aget-char p2, p1, p2

    .line 1125
    .local p2, "ch":I
    if-ge p2, v1, :cond_1

    .line 1126
    aget v3, v0, p2

    sparse-switch v3, :sswitch_data_0

    .line 1144
    goto :goto_3

    .line 1141
    :sswitch_0
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeAsEntity(I)V

    .line 1142
    goto :goto_4

    .line 1128
    :sswitch_1
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->reportInvalidChar(I)V

    .line 1133
    :sswitch_2
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeAsEntity(I)V

    .line 1134
    goto :goto_4

    .line 1146
    :cond_1
    iget v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mEncHighChar:I

    if-lt p2, v3, :cond_2

    .line 1147
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeAsEntity(I)V

    .line 1148
    goto :goto_4

    .line 1150
    :cond_2
    :goto_3
    iget v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-lt v3, v4, :cond_3

    .line 1151
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 1153
    :cond_3
    iget-object v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    int-to-char v5, p2

    aput-char v5, v3, v4

    .line 1154
    .end local v0    # "charTypes":[I
    .end local v1    # "limit":I
    .end local p2    # "ch":I
    nop

    .line 1101
    :goto_4
    move p2, v2

    goto :goto_0

    .line 1114
    .restart local v0    # "charTypes":[I
    .restart local v1    # "limit":I
    .local v2, "ch":C
    .local p2, "offset":I
    :cond_4
    iget v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-lt v3, v4, :cond_5

    .line 1115
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 1117
    :cond_5
    iget-object v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    aput-char v2, v3, v4

    .line 1118
    add-int/lit8 p2, p2, 0x1

    if-lt p2, p3, :cond_6

    .line 1119
    goto :goto_5

    .line 1121
    .end local v2    # "ch":C
    :cond_6
    goto :goto_1

    .line 1155
    .end local v0    # "charTypes":[I
    .end local v1    # "limit":I
    :cond_7
    :goto_5
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_1
        0x2 -> :sswitch_0
        0x3 -> :sswitch_0
        0x4 -> :sswitch_2
        0x9 -> :sswitch_2
        0xa -> :sswitch_2
        0xe -> :sswitch_2
    .end sparse-switch
.end method


# virtual methods
.method public _closeTarget(Z)V
    .locals 1
    .param p1, "doClose"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 190
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    if-eqz v0, :cond_1

    .line 195
    if-nez p1, :cond_0

    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    instance-of v0, v0, Lcom/fasterxml/aalto/io/UTF8Writer;

    if-eqz v0, :cond_1

    .line 196
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    invoke-virtual {v0}, Ljava/io/Writer;->close()V

    .line 197
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    .line 200
    :cond_1
    return-void
.end method

.method public _releaseBuffers()V
    .locals 2

    .line 180
    invoke-super {p0}, Lcom/fasterxml/aalto/out/XmlWriter;->_releaseBuffers()V

    .line 181
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    if-eqz v0, :cond_0

    .line 182
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    iget-object v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/out/WriterConfig;->freeFullCBuffer([C)V

    .line 183
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    .line 185
    :cond_0
    return-void
.end method

.method public constructName(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;
    .locals 1
    .param p1, "localName"    # Ljava/lang/String;

    .line 163
    new-instance v0, Lcom/fasterxml/aalto/out/CharWName;

    invoke-direct {v0, p1}, Lcom/fasterxml/aalto/out/CharWName;-><init>(Ljava/lang/String;)V

    return-object v0
.end method

.method public constructName(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 168
    new-instance v0, Lcom/fasterxml/aalto/out/CharWName;

    invoke-direct {v0, p1, p2}, Lcom/fasterxml/aalto/out/CharWName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method

.method public final flush()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 205
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    if-eqz v0, :cond_0

    .line 206
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 207
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    invoke-virtual {v0}, Ljava/io/Writer;->flush()V

    .line 209
    :cond_0
    return-void
.end method

.method public getHighestEncodable()I
    .locals 1

    .line 152
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mEncHighChar:I

    return v0
.end method

.method protected getOutputPtr()I
    .locals 1

    .line 146
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    return v0
.end method

.method protected verifyCDataContent(Ljava/lang/String;)I
    .locals 2
    .param p1, "content"    # Ljava/lang/String;

    .line 1304
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x3

    if-lt v0, v1, :cond_0

    .line 1305
    const/16 v0, 0x5d

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    .line 1306
    .local v0, "ix":I
    if-ltz v0, :cond_0

    .line 1307
    const-string v1, "]]>"

    invoke-virtual {p1, v1, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result v1

    return v1

    .line 1310
    .end local v0    # "ix":I
    :cond_0
    const/4 v0, -0x1

    return v0
.end method

.method protected verifyCDataContent([CII)I
    .locals 3
    .param p1, "c"    # [C
    .param p2, "start"    # I
    .param p3, "end"    # I

    .line 1315
    if-eqz p1, :cond_2

    .line 1316
    add-int/lit8 p2, p2, 0x2

    .line 1320
    :goto_0
    if-ge p2, p3, :cond_2

    .line 1321
    aget-char v0, p1, p2

    .line 1322
    .local v0, "ch":C
    const/16 v1, 0x5d

    if-ne v0, v1, :cond_0

    .line 1323
    add-int/lit8 p2, p2, 0x1

    .line 1324
    goto :goto_0

    .line 1326
    :cond_0
    const/16 v2, 0x3e

    if-ne v0, v2, :cond_1

    .line 1327
    add-int/lit8 v2, p2, -0x1

    aget-char v2, p1, v2

    if-ne v2, v1, :cond_1

    add-int/lit8 v2, p2, -0x2

    aget-char v2, p1, v2

    if-ne v2, v1, :cond_1

    .line 1329
    add-int/lit8 v1, p2, -0x2

    return v1

    .line 1332
    :cond_1
    nop

    .end local v0    # "ch":C
    add-int/lit8 p2, p2, 0x2

    .line 1333
    goto :goto_0

    .line 1335
    :cond_2
    const/4 v0, -0x1

    return v0
.end method

.method protected verifyCommentContent(Ljava/lang/String;)I
    .locals 2
    .param p1, "content"    # Ljava/lang/String;

    .line 1340
    const/16 v0, 0x2d

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    .line 1341
    .local v0, "ix":I
    if-ltz v0, :cond_0

    .line 1345
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    if-ge v0, v1, :cond_0

    .line 1346
    const-string v1, "--"

    invoke-virtual {p1, v1, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result v0

    .line 1349
    :cond_0
    return v0
.end method

.method protected final writeAsEntity(I)V
    .locals 10
    .param p1, "c"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1437
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    .line 1438
    .local v0, "buf":[C
    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 1439
    .local v1, "ptr":I
    add-int/lit8 v2, v1, 0xa

    array-length v3, v0

    if-lt v2, v3, :cond_0

    .line 1440
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 1441
    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 1443
    :cond_0
    add-int/lit8 v2, v1, 0x1

    .end local v1    # "ptr":I
    .local v2, "ptr":I
    const/16 v3, 0x26

    aput-char v3, v0, v1

    .line 1446
    const/16 v1, 0x100

    const/16 v4, 0x78

    const/16 v5, 0x23

    const/16 v6, 0xa

    if-ge p1, v1, :cond_9

    .line 1450
    const/16 v1, 0x70

    const/16 v7, 0x61

    if-ne p1, v3, :cond_1

    .line 1451
    add-int/lit8 v3, v2, 0x1

    .end local v2    # "ptr":I
    .local v3, "ptr":I
    aput-char v7, v0, v2

    .line 1452
    add-int/lit8 v2, v3, 0x1

    .end local v3    # "ptr":I
    .restart local v2    # "ptr":I
    const/16 v4, 0x6d

    aput-char v4, v0, v3

    .line 1453
    add-int/lit8 v3, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v3    # "ptr":I
    aput-char v1, v0, v2

    goto/16 :goto_4

    .line 1454
    .end local v3    # "ptr":I
    .restart local v2    # "ptr":I
    :cond_1
    const/16 v3, 0x3c

    const/16 v8, 0x74

    if-ne p1, v3, :cond_2

    .line 1455
    add-int/lit8 v1, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v1    # "ptr":I
    const/16 v3, 0x6c

    aput-char v3, v0, v2

    .line 1456
    add-int/lit8 v3, v1, 0x1

    .end local v1    # "ptr":I
    .restart local v3    # "ptr":I
    aput-char v8, v0, v1

    goto/16 :goto_4

    .line 1457
    .end local v3    # "ptr":I
    .restart local v2    # "ptr":I
    :cond_2
    const/16 v3, 0x3e

    if-ne p1, v3, :cond_3

    .line 1458
    add-int/lit8 v1, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v1    # "ptr":I
    const/16 v3, 0x67

    aput-char v3, v0, v2

    .line 1459
    add-int/lit8 v3, v1, 0x1

    .end local v1    # "ptr":I
    .restart local v3    # "ptr":I
    aput-char v8, v0, v1

    goto/16 :goto_4

    .line 1460
    .end local v3    # "ptr":I
    .restart local v2    # "ptr":I
    :cond_3
    const/16 v3, 0x27

    const/16 v9, 0x6f

    if-ne p1, v3, :cond_4

    .line 1461
    add-int/lit8 v3, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v3    # "ptr":I
    aput-char v7, v0, v2

    .line 1462
    add-int/lit8 v2, v3, 0x1

    .end local v3    # "ptr":I
    .restart local v2    # "ptr":I
    aput-char v1, v0, v3

    .line 1463
    add-int/lit8 v1, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v1    # "ptr":I
    aput-char v9, v0, v2

    .line 1464
    add-int/lit8 v3, v1, 0x1

    .end local v1    # "ptr":I
    .restart local v3    # "ptr":I
    const/16 v2, 0x73

    aput-char v2, v0, v1

    goto/16 :goto_4

    .line 1465
    .end local v3    # "ptr":I
    .restart local v2    # "ptr":I
    :cond_4
    const/16 v1, 0x22

    if-ne p1, v1, :cond_5

    .line 1466
    add-int/lit8 v1, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v1    # "ptr":I
    const/16 v3, 0x71

    aput-char v3, v0, v2

    .line 1467
    add-int/lit8 v2, v1, 0x1

    .end local v1    # "ptr":I
    .restart local v2    # "ptr":I
    const/16 v3, 0x75

    aput-char v3, v0, v1

    .line 1468
    add-int/lit8 v1, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v1    # "ptr":I
    aput-char v9, v0, v2

    .line 1469
    add-int/lit8 v3, v1, 0x1

    .end local v1    # "ptr":I
    .restart local v3    # "ptr":I
    aput-char v8, v0, v1

    goto :goto_4

    .line 1471
    .end local v3    # "ptr":I
    .restart local v2    # "ptr":I
    :cond_5
    add-int/lit8 v1, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v1    # "ptr":I
    aput-char v5, v0, v2

    .line 1472
    add-int/lit8 v2, v1, 0x1

    .end local v1    # "ptr":I
    .restart local v2    # "ptr":I
    aput-char v4, v0, v1

    .line 1474
    const/16 v1, 0x10

    if-lt p1, v1, :cond_7

    .line 1475
    shr-int/lit8 v1, p1, 0x4

    .line 1476
    .local v1, "digit":I
    add-int/lit8 v3, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v3    # "ptr":I
    if-ge v1, v6, :cond_6

    add-int/lit8 v4, v1, 0x30

    goto :goto_0

    :cond_6
    add-int/lit8 v4, v1, 0x57

    :goto_0
    int-to-char v4, v4

    aput-char v4, v0, v2

    .line 1477
    and-int/lit8 p1, p1, 0xf

    move v2, v3

    .line 1479
    .end local v1    # "digit":I
    .end local v3    # "ptr":I
    .restart local v2    # "ptr":I
    :cond_7
    add-int/lit8 v3, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v3    # "ptr":I
    if-ge p1, v6, :cond_8

    add-int/lit8 v1, p1, 0x30

    goto :goto_1

    :cond_8
    add-int/lit8 v1, p1, 0x57

    :goto_1
    int-to-char v1, v1

    aput-char v1, v0, v2

    goto :goto_4

    .line 1482
    .end local v3    # "ptr":I
    .restart local v2    # "ptr":I
    :cond_9
    add-int/lit8 v1, v2, 0x1

    .end local v2    # "ptr":I
    .local v1, "ptr":I
    aput-char v5, v0, v2

    .line 1483
    add-int/lit8 v2, v1, 0x1

    .end local v1    # "ptr":I
    .restart local v2    # "ptr":I
    aput-char v4, v0, v1

    .line 1486
    const/16 v1, 0x14

    .line 1487
    .local v1, "shift":I
    move v3, v2

    .line 1490
    .local v3, "origPtr":I
    :cond_a
    shr-int v4, p1, v1

    and-int/lit8 v4, v4, 0xf

    .line 1491
    .local v4, "digit":I
    if-gtz v4, :cond_b

    if-eq v2, v3, :cond_d

    .line 1492
    :cond_b
    add-int/lit8 v5, v2, 0x1

    .end local v2    # "ptr":I
    .local v5, "ptr":I
    if-ge v4, v6, :cond_c

    add-int/lit8 v7, v4, 0x30

    goto :goto_2

    :cond_c
    add-int/lit8 v7, v4, 0x57

    :goto_2
    int-to-char v7, v7

    aput-char v7, v0, v2

    move v2, v5

    .line 1494
    .end local v5    # "ptr":I
    .restart local v2    # "ptr":I
    :cond_d
    nop

    .end local v4    # "digit":I
    add-int/lit8 v1, v1, -0x4

    .line 1495
    if-gtz v1, :cond_a

    .line 1496
    and-int/lit8 p1, p1, 0xf

    .line 1497
    add-int/lit8 v4, v2, 0x1

    .end local v2    # "ptr":I
    .local v4, "ptr":I
    if-ge p1, v6, :cond_e

    add-int/lit8 v5, p1, 0x30

    goto :goto_3

    :cond_e
    add-int/lit8 v5, p1, 0x57

    :goto_3
    int-to-char v5, v5

    aput-char v5, v0, v2

    move v3, v4

    .line 1499
    .end local v1    # "shift":I
    .end local v4    # "ptr":I
    .local v3, "ptr":I
    :goto_4
    add-int/lit8 v1, v3, 0x1

    .end local v3    # "ptr":I
    .local v1, "ptr":I
    const/16 v2, 0x3b

    aput-char v2, v0, v3

    .line 1500
    iput v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 1501
    return-void
.end method

.method public writeAttribute(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)V
    .locals 2
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;
    .param p2, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 977
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    if-nez v0, :cond_0

    .line 978
    return-void

    .line 980
    :cond_0
    const/16 v0, 0x20

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(C)V

    .line 981
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeName(Lcom/fasterxml/aalto/out/WName;)V

    .line 982
    const/16 v0, 0x3d

    const/16 v1, 0x22

    invoke-direct {p0, v0, v1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(CC)V

    .line 983
    if-nez p2, :cond_1

    const/4 v0, 0x0

    goto :goto_0

    :cond_1
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    .line 984
    .local v0, "len":I
    :goto_0
    if-lez v0, :cond_2

    .line 985
    invoke-direct {p0, p2, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeAttrValue(Ljava/lang/String;I)V

    .line 987
    :cond_2
    invoke-direct {p0, v1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(C)V

    .line 988
    return-void
.end method

.method public final writeAttribute(Lcom/fasterxml/aalto/out/WName;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V
    .locals 2
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;
    .param p2, "enc"    # Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1190
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    if-nez v0, :cond_0

    .line 1191
    return-void

    .line 1193
    :cond_0
    const/16 v0, 0x20

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(C)V

    .line 1194
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeName(Lcom/fasterxml/aalto/out/WName;)V

    .line 1195
    const/16 v0, 0x3d

    const/16 v1, 0x22

    invoke-direct {p0, v0, v1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(CC)V

    .line 1196
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeTypedValue(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V

    .line 1197
    invoke-direct {p0, v1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(C)V

    .line 1198
    return-void
.end method

.method public writeAttribute(Lcom/fasterxml/aalto/out/WName;[CII)V
    .locals 2
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;
    .param p2, "value"    # [C
    .param p3, "offset"    # I
    .param p4, "vlen"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 994
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    if-nez v0, :cond_0

    .line 995
    return-void

    .line 997
    :cond_0
    const/16 v0, 0x20

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(C)V

    .line 998
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeName(Lcom/fasterxml/aalto/out/WName;)V

    .line 999
    const/16 v0, 0x3d

    const/16 v1, 0x22

    invoke-direct {p0, v0, v1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(CC)V

    .line 1001
    if-lez p4, :cond_1

    .line 1002
    invoke-direct {p0, p2, p3, p4}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeAttrValue([CII)V

    .line 1004
    :cond_1
    invoke-direct {p0, v1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(C)V

    .line 1005
    return-void
.end method

.method public writeCData(Ljava/lang/String;)I
    .locals 7
    .param p1, "data"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 344
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeCDataStart()V

    .line 349
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 350
    .local v0, "len":I
    const/4 v1, 0x0

    .line 352
    .local v1, "offset":I
    :goto_0
    if-lez v0, :cond_2

    .line 353
    iget-object v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_copyBuffer:[C

    .line 354
    .local v2, "buf":[C
    array-length v3, v2

    .line 355
    .local v3, "blen":I
    if-ge v0, v3, :cond_0

    move v4, v0

    goto :goto_1

    :cond_0
    move v4, v3

    .line 356
    .local v4, "len2":I
    :goto_1
    add-int v5, v1, v4

    const/4 v6, 0x0

    invoke-virtual {p1, v1, v5, v2, v6}, Ljava/lang/String;->getChars(II[CI)V

    .line 357
    invoke-direct {p0, v2, v6, v4}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeCDataContents([CII)I

    move-result v5

    .line 358
    .local v5, "cix":I
    if-ltz v5, :cond_1

    .line 359
    add-int v6, v1, v5

    return v6

    .line 361
    :cond_1
    add-int/2addr v1, v4

    .line 362
    sub-int/2addr v0, v4

    .line 363
    .end local v2    # "buf":[C
    .end local v3    # "blen":I
    .end local v4    # "len2":I
    .end local v5    # "cix":I
    goto :goto_0

    .line 364
    :cond_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeCDataEnd()V

    .line 365
    const/4 v2, -0x1

    return v2
.end method

.method public writeCData([CII)I
    .locals 2
    .param p1, "cbuf"    # [C
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 372
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeCDataStart()V

    .line 373
    invoke-direct {p0, p1, p2, p3}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeCDataContents([CII)I

    move-result v0

    .line 374
    .local v0, "ix":I
    if-gez v0, :cond_0

    .line 375
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeCDataEnd()V

    .line 377
    :cond_0
    const/4 v1, -0x1

    return v1
.end method

.method public final writeCDataEnd()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 314
    const-string v0, "]]>"

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 315
    return-void
.end method

.method public final writeCDataStart()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 308
    const-string v0, "<![CDATA["

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 309
    return-void
.end method

.method public writeCharacters(Ljava/lang/String;)V
    .locals 7
    .param p1, "text"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 450
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    if-nez v0, :cond_0

    .line 451
    return-void

    .line 454
    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 455
    .local v0, "len":I
    const/4 v1, 0x0

    .line 457
    .local v1, "offset":I
    :goto_0
    if-lez v0, :cond_2

    .line 458
    iget-object v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_copyBuffer:[C

    .line 459
    .local v2, "buf":[C
    array-length v3, v2

    .line 460
    .local v3, "blen":I
    if-ge v0, v3, :cond_1

    move v4, v0

    goto :goto_1

    :cond_1
    move v4, v3

    .line 461
    .local v4, "len2":I
    :goto_1
    add-int v5, v1, v4

    const/4 v6, 0x0

    invoke-virtual {p1, v1, v5, v2, v6}, Ljava/lang/String;->getChars(II[CI)V

    .line 462
    invoke-virtual {p0, v2, v6, v4}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeCharacters([CII)V

    .line 463
    add-int/2addr v1, v4

    .line 464
    sub-int/2addr v0, v4

    .line 465
    .end local v2    # "buf":[C
    .end local v3    # "blen":I
    .end local v4    # "len2":I
    goto :goto_0

    .line 466
    :cond_2
    return-void
.end method

.method public writeCharacters([CII)V
    .locals 6
    .param p1, "cbuf"    # [C
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 472
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    if-nez v0, :cond_0

    .line 473
    return-void

    .line 476
    :cond_0
    add-int/2addr p3, p2

    .line 479
    :goto_0
    if-ge p2, p3, :cond_9

    .line 480
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    .line 481
    .local v0, "charTypes":[I
    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mTableCheckEnd:I

    .line 485
    .local v1, "limit":I
    :goto_1
    aget-char v2, p1, p2

    .line 486
    .local v2, "ch":C
    if-lt v2, v1, :cond_1

    .line 487
    goto :goto_2

    .line 489
    :cond_1
    aget v3, v0, v2

    if-eqz v3, :cond_6

    .line 490
    nop

    .line 502
    .end local v2    # "ch":C
    :goto_2
    add-int/lit8 v2, p2, 0x1

    .end local p2    # "offset":I
    .local v2, "offset":I
    aget-char p2, p1, p2

    .line 503
    .local p2, "ch":I
    if-ge p2, v1, :cond_3

    .line 504
    aget v3, v0, p2

    packed-switch v3, :pswitch_data_0

    .line 529
    :pswitch_0
    goto :goto_3

    .line 521
    :pswitch_1
    iget-object v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/out/WriterConfig;->willEscapeCR()Z

    move-result v3

    if-eqz v3, :cond_4

    .line 522
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeAsEntity(I)V

    .line 523
    goto :goto_4

    .line 506
    :pswitch_2
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->reportInvalidChar(I)V

    .line 509
    :pswitch_3
    if-ge v2, p3, :cond_2

    aget-char v3, p1, v2

    const/16 v4, 0x3e

    if-eq v3, v4, :cond_2

    .line 510
    goto :goto_3

    .line 516
    :cond_2
    :pswitch_4
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeAsEntity(I)V

    .line 517
    goto :goto_4

    .line 531
    :cond_3
    iget v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mEncHighChar:I

    if-lt p2, v3, :cond_4

    .line 532
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeAsEntity(I)V

    .line 533
    goto :goto_4

    .line 535
    :cond_4
    :goto_3
    iget v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-lt v3, v4, :cond_5

    .line 536
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 538
    :cond_5
    iget-object v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    int-to-char v5, p2

    aput-char v5, v3, v4

    .line 539
    .end local v0    # "charTypes":[I
    .end local v1    # "limit":I
    .end local p2    # "ch":I
    nop

    .line 479
    :goto_4
    move p2, v2

    goto :goto_0

    .line 492
    .restart local v0    # "charTypes":[I
    .restart local v1    # "limit":I
    .local v2, "ch":C
    .local p2, "offset":I
    :cond_6
    iget v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-lt v3, v4, :cond_7

    .line 493
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 495
    :cond_7
    iget-object v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    aput-char v2, v3, v4

    .line 496
    add-int/lit8 p2, p2, 0x1

    if-lt p2, p3, :cond_8

    .line 497
    goto :goto_5

    .line 499
    .end local v2    # "ch":C
    :cond_8
    goto :goto_1

    .line 540
    .end local v0    # "charTypes":[I
    .end local v1    # "limit":I
    :cond_9
    :goto_5
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_4
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_4
        :pswitch_4
        :pswitch_3
    .end packed-switch
.end method

.method public writeComment(Ljava/lang/String;)I
    .locals 8
    .param p1, "data"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 601
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    const/4 v1, -0x1

    if-nez v0, :cond_0

    .line 602
    return v1

    .line 605
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeCommentStart()V

    .line 610
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 611
    .local v0, "len":I
    const/4 v2, 0x0

    .line 612
    .local v2, "offset":I
    const/4 v3, -0x1

    .line 614
    .local v3, "cix":I
    :goto_0
    if-lez v0, :cond_3

    .line 615
    iget-object v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_copyBuffer:[C

    .line 616
    .local v4, "buf":[C
    array-length v5, v4

    .line 619
    .local v5, "blen":I
    if-le v5, v0, :cond_1

    .line 620
    move v5, v0

    .line 623
    :cond_1
    add-int v6, v2, v5

    const/4 v7, 0x0

    invoke-virtual {p1, v2, v6, v4, v7}, Ljava/lang/String;->getChars(II[CI)V

    .line 624
    invoke-direct {p0, v4, v7, v5, v7}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeCommentContents([CIIZ)I

    move-result v3

    .line 625
    if-ltz v3, :cond_2

    .line 626
    goto :goto_1

    .line 628
    :cond_2
    add-int/2addr v2, v5

    .line 629
    sub-int/2addr v0, v5

    .line 630
    .end local v4    # "buf":[C
    .end local v5    # "blen":I
    goto :goto_0

    .line 631
    :cond_3
    :goto_1
    if-ltz v3, :cond_4

    .line 632
    add-int v1, v2, v3

    return v1

    .line 634
    :cond_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeCommentEnd()V

    .line 635
    return v1
.end method

.method public final writeCommentEnd()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 326
    const-string v0, "-->"

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 327
    return-void
.end method

.method public final writeCommentStart()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 320
    const-string v0, "<!--"

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 321
    return-void
.end method

.method public writeDTD(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "rootName"    # Lcom/fasterxml/aalto/out/WName;
    .param p2, "systemId"    # Ljava/lang/String;
    .param p3, "publicId"    # Ljava/lang/String;
    .param p4, "internalSubset"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 724
    const-string v0, "<!DOCTYPE "

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 729
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeName(Lcom/fasterxml/aalto/out/WName;)V

    .line 730
    if-eqz p2, :cond_1

    .line 731
    if-eqz p3, :cond_0

    .line 732
    const-string v0, " PUBLIC \""

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 734
    invoke-direct {p0, p3}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 735
    const-string v0, "\" \""

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    goto :goto_0

    .line 737
    :cond_0
    const-string v0, " SYSTEM \""

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 740
    :goto_0
    invoke-direct {p0, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 741
    const/16 v0, 0x22

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(C)V

    .line 744
    :cond_1
    if-eqz p4, :cond_2

    invoke-virtual {p4}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_2

    .line 745
    const/16 v0, 0x20

    const/16 v1, 0x5b

    invoke-direct {p0, v0, v1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(CC)V

    .line 747
    invoke-direct {p0, p4}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 748
    const/16 v0, 0x5d

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(C)V

    .line 750
    :cond_2
    const/16 v0, 0x3e

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(C)V

    .line 751
    return-void
.end method

.method public writeDTD(Ljava/lang/String;)V
    .locals 2
    .param p1, "data"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 716
    const/4 v0, 0x0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {p0, p1, v0, v1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeRaw(Ljava/lang/String;II)V

    .line 717
    return-void
.end method

.method public writeEndTag(Lcom/fasterxml/aalto/out/WName;)V
    .locals 7
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 944
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 945
    .local v0, "ptr":I
    invoke-virtual {p1}, Lcom/fasterxml/aalto/out/WName;->serializedLength()I

    move-result v1

    .line 946
    .local v1, "len":I
    add-int v2, v0, v1

    add-int/lit8 v2, v2, 0x3

    iget v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    const/16 v4, 0x3e

    const/16 v5, 0x2f

    const/16 v6, 0x3c

    if-le v2, v3, :cond_1

    .line 947
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 949
    add-int/lit8 v2, v1, 0x3

    iget v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-le v2, v3, :cond_0

    .line 950
    iget-object v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    invoke-virtual {v2, v6}, Ljava/io/Writer;->write(I)V

    .line 951
    iget-object v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    invoke-virtual {v2, v5}, Ljava/io/Writer;->write(I)V

    .line 952
    iget-object v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    invoke-virtual {p1, v2}, Lcom/fasterxml/aalto/out/WName;->writeChars(Ljava/io/Writer;)V

    .line 953
    iget-object v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/lit8 v5, v3, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    aput-char v4, v2, v3

    .line 954
    return-void

    .line 956
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 958
    :cond_1
    iget-object v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    .line 959
    .local v2, "buf":[C
    add-int/lit8 v3, v0, 0x1

    .end local v0    # "ptr":I
    .local v3, "ptr":I
    aput-char v6, v2, v0

    .line 960
    add-int/lit8 v0, v3, 0x1

    .end local v3    # "ptr":I
    .restart local v0    # "ptr":I
    aput-char v5, v2, v3

    .line 961
    invoke-virtual {p1, v2, v0}, Lcom/fasterxml/aalto/out/WName;->appendChars([CI)I

    .line 962
    add-int/2addr v0, v1

    .line 963
    add-int/lit8 v3, v0, 0x1

    .end local v0    # "ptr":I
    .restart local v3    # "ptr":I
    aput-char v4, v2, v0

    .line 964
    iput v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 965
    return-void
.end method

.method public writeEntityReference(Lcom/fasterxml/aalto/out/WName;)V
    .locals 1
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 757
    const/16 v0, 0x26

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(C)V

    .line 758
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeName(Lcom/fasterxml/aalto/out/WName;)V

    .line 759
    const/16 v0, 0x3b

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(C)V

    .line 760
    return-void
.end method

.method protected final writeName(Lcom/fasterxml/aalto/out/WName;)V
    .locals 4
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1228
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 1229
    .local v0, "ptr":I
    invoke-virtual {p1}, Lcom/fasterxml/aalto/out/WName;->serializedLength()I

    move-result v1

    .line 1230
    .local v1, "len":I
    add-int v2, v0, v1

    iget v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-le v2, v3, :cond_1

    .line 1231
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 1233
    iget v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-lt v1, v2, :cond_0

    .line 1234
    iget-object v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    invoke-virtual {p1, v2}, Lcom/fasterxml/aalto/out/WName;->writeChars(Ljava/io/Writer;)V

    .line 1235
    return-void

    .line 1237
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 1239
    :cond_1
    iget-object v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    invoke-virtual {p1, v2, v0}, Lcom/fasterxml/aalto/out/WName;->appendChars([CI)I

    .line 1240
    iget v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/2addr v2, v1

    iput v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 1241
    return-void
.end method

.method public writePI(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)I
    .locals 8
    .param p1, "target"    # Lcom/fasterxml/aalto/out/WName;
    .param p2, "data"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 790
    const/16 v0, 0x3c

    const/16 v1, 0x3f

    invoke-direct {p0, v0, v1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(CC)V

    .line 791
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeName(Lcom/fasterxml/aalto/out/WName;)V

    .line 793
    if-eqz p2, :cond_3

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_3

    .line 794
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    .line 795
    .local v0, "len":I
    const/4 v2, 0x0

    .line 796
    .local v2, "offset":I
    const/4 v3, -0x1

    .line 798
    .local v3, "cix":I
    const/16 v4, 0x20

    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(C)V

    .line 801
    :goto_0
    if-lez v0, :cond_2

    .line 802
    iget-object v4, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_copyBuffer:[C

    .line 803
    .local v4, "buf":[C
    array-length v5, v4

    .line 806
    .local v5, "blen":I
    if-le v5, v0, :cond_0

    .line 807
    move v5, v0

    .line 809
    :cond_0
    add-int v6, v2, v5

    const/4 v7, 0x0

    invoke-virtual {p2, v2, v6, v4, v7}, Ljava/lang/String;->getChars(II[CI)V

    .line 810
    invoke-direct {p0, v4, v7, v5}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writePIContents([CII)I

    move-result v3

    .line 811
    if-ltz v3, :cond_1

    .line 812
    goto :goto_1

    .line 814
    :cond_1
    add-int/2addr v2, v5

    .line 815
    sub-int/2addr v0, v5

    .line 816
    .end local v4    # "buf":[C
    .end local v5    # "blen":I
    goto :goto_0

    .line 817
    :cond_2
    :goto_1
    if-ltz v3, :cond_3

    .line 818
    add-int v1, v2, v3

    return v1

    .line 821
    .end local v0    # "len":I
    .end local v2    # "offset":I
    .end local v3    # "cix":I
    :cond_3
    const/16 v0, 0x3e

    invoke-direct {p0, v1, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(CC)V

    .line 822
    const/4 v0, -0x1

    return v0
.end method

.method public writeRaw(Ljava/lang/String;II)V
    .locals 4
    .param p1, "str"    # Ljava/lang/String;
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 258
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    if-nez v0, :cond_0

    .line 259
    return-void

    .line 263
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mSmallWriteSize:I

    if-ge p3, v0, :cond_2

    .line 265
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/2addr v0, p3

    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-lt v0, v1, :cond_1

    .line 266
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 268
    :cond_1
    add-int v0, p2, p3

    iget-object v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    invoke-virtual {p1, p2, v0, v1, v2}, Ljava/lang/String;->getChars(II[CI)V

    .line 269
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/2addr v0, p3

    iput v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 270
    return-void

    .line 274
    :cond_2
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 275
    .local v0, "ptr":I
    if-lez v0, :cond_4

    .line 277
    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mSmallWriteSize:I

    if-ge v0, v1, :cond_3

    .line 284
    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mSmallWriteSize:I

    sub-int/2addr v1, v0

    .line 287
    .local v1, "needed":I
    add-int v2, p2, v1

    iget-object v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    invoke-virtual {p1, p2, v2, v3, v0}, Ljava/lang/String;->getChars(II[CI)V

    .line 288
    add-int v2, v0, v1

    iput v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 289
    sub-int/2addr p3, v1

    .line 290
    add-int/2addr p2, v1

    .line 292
    .end local v1    # "needed":I
    :cond_3
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 296
    :cond_4
    iget-object v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    invoke-virtual {v1, p1, p2, p3}, Ljava/io/Writer;->write(Ljava/lang/String;II)V

    .line 297
    return-void
.end method

.method public writeRaw([CII)V
    .locals 3
    .param p1, "cbuf"    # [C
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 214
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    if-nez v0, :cond_0

    .line 215
    return-void

    .line 219
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mSmallWriteSize:I

    if-ge p3, v0, :cond_2

    .line 221
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/2addr v0, p3

    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-le v0, v1, :cond_1

    .line 222
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 224
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    invoke-static {p1, p2, v0, v1, p3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 225
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/2addr v0, p3

    iput v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 226
    return-void

    .line 230
    :cond_2
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 231
    .local v0, "ptr":I
    if-lez v0, :cond_4

    .line 233
    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mSmallWriteSize:I

    if-ge v0, v1, :cond_3

    .line 240
    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->mSmallWriteSize:I

    sub-int/2addr v1, v0

    .line 243
    .local v1, "needed":I
    iget-object v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    invoke-static {p1, p2, v2, v0, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 244
    add-int v2, v0, v1

    iput v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 245
    sub-int/2addr p3, v1

    .line 246
    add-int/2addr p2, v1

    .line 248
    .end local v1    # "needed":I
    :cond_3
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 252
    :cond_4
    iget-object v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    invoke-virtual {v1, p1, p2, p3}, Ljava/io/Writer;->write([CII)V

    .line 253
    return-void
.end method

.method protected writeSegmentedCData(Ljava/lang/String;I)V
    .locals 3
    .param p1, "content"    # Ljava/lang/String;
    .param p2, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1359
    const/4 v0, 0x0

    .line 1360
    .local v0, "start":I
    :goto_0
    const-string v1, "<![CDATA["

    const-string v2, "]]>"

    if-ltz p2, :cond_0

    .line 1361
    invoke-direct {p0, v1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 1362
    add-int/lit8 v1, p2, 0x2

    sub-int/2addr v1, v0

    invoke-virtual {p0, p1, v0, v1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeRaw(Ljava/lang/String;II)V

    .line 1363
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 1364
    add-int/lit8 v0, p2, 0x2

    .line 1365
    invoke-virtual {p1, v2, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result p2

    goto :goto_0

    .line 1368
    :cond_0
    invoke-direct {p0, v1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 1369
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    sub-int/2addr v1, v0

    invoke-virtual {p0, p1, v0, v1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeRaw(Ljava/lang/String;II)V

    .line 1370
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 1371
    return-void
.end method

.method protected writeSegmentedCData([CIII)V
    .locals 3
    .param p1, "c"    # [C
    .param p2, "start"    # I
    .param p3, "len"    # I
    .param p4, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1376
    add-int v0, p2, p3

    .line 1377
    .local v0, "end":I
    :goto_0
    const-string v1, "]]>"

    const-string v2, "<![CDATA["

    if-ltz p4, :cond_0

    .line 1378
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 1379
    add-int/lit8 v2, p4, 0x2

    sub-int/2addr v2, p2

    invoke-virtual {p0, p1, p2, v2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeRaw([CII)V

    .line 1380
    invoke-direct {p0, v1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 1381
    add-int/lit8 p2, p4, 0x2

    .line 1382
    invoke-virtual {p0, p1, p2, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->verifyCDataContent([CII)I

    move-result p4

    goto :goto_0

    .line 1385
    :cond_0
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 1386
    sub-int v2, v0, p2

    invoke-virtual {p0, p1, p2, v2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeRaw([CII)V

    .line 1387
    invoke-direct {p0, v1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 1388
    return-void
.end method

.method protected writeSegmentedComment(Ljava/lang/String;I)V
    .locals 5
    .param p1, "content"    # Ljava/lang/String;
    .param p2, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1393
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 1395
    .local v0, "len":I
    add-int/lit8 v1, v0, -0x1

    const-string v2, "<!--"

    if-ne p2, v1, :cond_0

    .line 1396
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 1397
    const/4 v1, 0x0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {p0, p1, v1, v2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeRaw(Ljava/lang/String;II)V

    .line 1399
    const-string v1, " -->"

    invoke-direct {p0, v1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 1400
    return-void

    .line 1412
    :cond_0
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 1413
    const/4 v1, 0x0

    .line 1414
    .local v1, "start":I
    :goto_0
    const/16 v2, 0x20

    if-ltz p2, :cond_1

    .line 1416
    add-int/lit8 v3, p2, 0x1

    sub-int/2addr v3, v1

    invoke-virtual {p0, p1, v1, v3}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeRaw(Ljava/lang/String;II)V

    .line 1418
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(C)V

    .line 1420
    add-int/lit8 v1, p2, 0x1

    .line 1421
    const-string v2, "--"

    invoke-virtual {p1, v2, v1}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result p2

    goto :goto_0

    .line 1424
    :cond_1
    sub-int v3, v0, v1

    invoke-virtual {p0, p1, v1, v3}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeRaw(Ljava/lang/String;II)V

    .line 1426
    add-int/lit8 v3, v0, -0x1

    invoke-virtual {p1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v4, 0x2d

    if-ne v3, v4, :cond_2

    .line 1427
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(C)V

    .line 1429
    :cond_2
    const-string v2, "-->"

    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 1430
    return-void
.end method

.method public writeSpace(Ljava/lang/String;)V
    .locals 7
    .param p1, "data"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 546
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    if-nez v0, :cond_0

    .line 547
    return-void

    .line 550
    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 551
    .local v0, "len":I
    const/4 v1, 0x0

    .line 555
    .local v1, "offset":I
    :goto_0
    if-lez v0, :cond_2

    .line 556
    iget-object v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_copyBuffer:[C

    .line 557
    .local v2, "buf":[C
    array-length v3, v2

    .line 558
    .local v3, "blen":I
    if-ge v0, v3, :cond_1

    move v4, v0

    goto :goto_1

    :cond_1
    move v4, v3

    .line 559
    .local v4, "len2":I
    :goto_1
    add-int v5, v1, v4

    const/4 v6, 0x0

    invoke-virtual {p1, v1, v5, v2, v6}, Ljava/lang/String;->getChars(II[CI)V

    .line 560
    invoke-virtual {p0, v2, v6, v4}, Lcom/fasterxml/aalto/out/CharXmlWriter;->writeSpace([CII)V

    .line 561
    add-int/2addr v1, v4

    .line 562
    sub-int/2addr v0, v4

    .line 563
    .end local v2    # "buf":[C
    .end local v3    # "blen":I
    .end local v4    # "len2":I
    goto :goto_0

    .line 564
    :cond_2
    return-void
.end method

.method public writeSpace([CII)V
    .locals 4
    .param p1, "cbuf"    # [C
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 570
    iget-object v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    if-nez v0, :cond_0

    .line 571
    return-void

    .line 574
    :cond_0
    add-int/2addr p3, p2

    .line 576
    :goto_0
    if-ge p2, p3, :cond_4

    .line 577
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "offset":I
    .local v0, "offset":I
    aget-char p2, p1, p2

    .line 578
    .local p2, "ch":C
    const/16 v1, 0x20

    if-le p2, v1, :cond_2

    .line 579
    iget-object v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/out/WriterConfig;->isXml11()Z

    move-result v1

    if-eqz v1, :cond_1

    const/16 v1, 0x85

    if-eq p2, v1, :cond_2

    const/16 v1, 0x2028

    if-eq p2, v1, :cond_2

    .line 580
    :cond_1
    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_SPACE_CONTENT:Ljava/lang/String;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    add-int/lit8 v3, v0, -0x1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {p0, v1, v2, v3}, Lcom/fasterxml/aalto/out/CharXmlWriter;->reportNwfContent(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 583
    :cond_2
    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-lt v1, v2, :cond_3

    .line 584
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 586
    :cond_3
    iget-object v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    aput-char p2, v1, v2

    .line 587
    .end local p2    # "ch":C
    move p2, v0

    goto :goto_0

    .line 588
    .end local v0    # "offset":I
    .local p2, "offset":I
    :cond_4
    return-void
.end method

.method public writeStartTagEmptyEnd()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 926
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 927
    .local v0, "ptr":I
    add-int/lit8 v1, v0, 0x2

    iget v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-le v1, v2, :cond_1

    .line 928
    iget-object v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    if-nez v1, :cond_0

    .line 929
    return-void

    .line 931
    :cond_0
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 932
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 934
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    .line 935
    .local v1, "buf":[C
    add-int/lit8 v2, v0, 0x1

    .end local v0    # "ptr":I
    .local v2, "ptr":I
    const/16 v3, 0x2f

    aput-char v3, v1, v0

    .line 936
    add-int/lit8 v0, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v0    # "ptr":I
    const/16 v3, 0x3e

    aput-char v3, v1, v2

    .line 937
    iput v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 938
    return-void
.end method

.method public writeStartTagEnd()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 919
    const/16 v0, 0x3e

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(C)V

    .line 920
    return-void
.end method

.method public writeStartTagStart(Lcom/fasterxml/aalto/out/WName;)V
    .locals 5
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 894
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 895
    .local v0, "ptr":I
    invoke-virtual {p1}, Lcom/fasterxml/aalto/out/WName;->serializedLength()I

    move-result v1

    .line 896
    .local v1, "len":I
    add-int v2, v0, v1

    add-int/lit8 v2, v2, 0x1

    iget v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    const/16 v4, 0x3c

    if-le v2, v3, :cond_2

    .line 897
    iget-object v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    if-nez v2, :cond_0

    .line 898
    return-void

    .line 900
    :cond_0
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    .line 902
    iget v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    if-lt v1, v2, :cond_1

    .line 903
    iget-object v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    invoke-virtual {v2, v4}, Ljava/io/Writer;->write(I)V

    .line 904
    iget-object v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_out:Ljava/io/Writer;

    invoke-virtual {p1, v2}, Lcom/fasterxml/aalto/out/WName;->writeChars(Ljava/io/Writer;)V

    .line 905
    return-void

    .line 907
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 909
    :cond_2
    iget-object v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    .line 910
    .local v2, "buf":[C
    add-int/lit8 v3, v0, 0x1

    .end local v0    # "ptr":I
    .local v3, "ptr":I
    aput-char v4, v2, v0

    .line 911
    invoke-virtual {p1, v2, v3}, Lcom/fasterxml/aalto/out/WName;->appendChars([CI)I

    .line 912
    add-int v0, v3, v1

    iput v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 913
    return-void
.end method

.method public writeTypedValue(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V
    .locals 4
    .param p1, "enc"    # Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1167
    iget v0, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    iget v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    sub-int/2addr v0, v1

    .line 1168
    .local v0, "free":I
    invoke-virtual {p1, v0}, Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;->bufferNeedsFlush(I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1169
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flush()V

    .line 1172
    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputBufferLen:I

    invoke-virtual {p1, v1, v2, v3}, Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;->encodeMore([CII)I

    move-result v1

    iput v1, p0, Lcom/fasterxml/aalto/out/CharXmlWriter;->_outputPtr:I

    .line 1173
    invoke-virtual {p1}, Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;->isCompleted()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 1174
    nop

    .line 1178
    return-void

    .line 1176
    :cond_1
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->flushBuffer()V

    goto :goto_0
.end method

.method public writeXmlDeclaration(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "version"    # Ljava/lang/String;
    .param p2, "encoding"    # Ljava/lang/String;
    .param p3, "standalone"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 766
    const-string v0, "<?xml version=\'"

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 768
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 769
    const/16 v0, 0x27

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(C)V

    .line 771
    if-eqz p2, :cond_0

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    .line 772
    const-string v1, " encoding=\'"

    invoke-direct {p0, v1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 774
    invoke-direct {p0, p2}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 775
    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(C)V

    .line 777
    :cond_0
    if-eqz p3, :cond_1

    .line 778
    const-string v1, " standalone=\'"

    invoke-direct {p0, v1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 780
    invoke-direct {p0, p3}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(Ljava/lang/String;)V

    .line 781
    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(C)V

    .line 783
    :cond_1
    const/16 v0, 0x3f

    const/16 v1, 0x3e

    invoke-direct {p0, v0, v1}, Lcom/fasterxml/aalto/out/CharXmlWriter;->fastWriteRaw(CC)V

    .line 784
    return-void
.end method
