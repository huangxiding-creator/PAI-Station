.class public final Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;
.super Lcom/fasterxml/aalto/in/InputBootstrapper;
.source "ByteSourceBootstrapper.java"


# static fields
.field private static final BYTE_CR:B = 0xdt

.field private static final BYTE_LF:B = 0xat

.field private static final BYTE_NULL:B


# instance fields
.field final _in:Ljava/io/InputStream;

.field final _inputBuffer:[B

.field private _inputLen:I

.field private _inputPtr:I

.field mBigEndian:Z

.field mByteSizeFound:Z

.field mBytesPerChar:I

.field mHadBOM:Z


# direct methods
.method private constructor <init>(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/InputStream;)V
    .locals 2
    .param p1, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;
    .param p2, "in"    # Ljava/io/InputStream;

    .line 85
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/in/InputBootstrapper;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V

    .line 71
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBigEndian:Z

    .line 72
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    .line 74
    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mHadBOM:Z

    .line 75
    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mByteSizeFound:Z

    .line 86
    iput-object p2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_in:Ljava/io/InputStream;

    .line 87
    const/16 v1, 0xfa0

    invoke-virtual {p1, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->allocFullBBuffer(I)[B

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    .line 88
    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    .line 89
    return-void
.end method

.method private constructor <init>(Lcom/fasterxml/aalto/in/ReaderConfig;[BII)V
    .locals 1
    .param p1, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;
    .param p2, "inputBuffer"    # [B
    .param p3, "inputStart"    # I
    .param p4, "inputLen"    # I

    .line 93
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/in/InputBootstrapper;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V

    .line 71
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBigEndian:Z

    .line 72
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    .line 74
    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mHadBOM:Z

    .line 75
    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mByteSizeFound:Z

    .line 94
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_in:Ljava/io/InputStream;

    .line 95
    iput-object p2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    .line 96
    iput p3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    .line 97
    add-int v0, p3, p4

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    .line 99
    neg-int v0, p3

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputProcessed:I

    .line 100
    return-void
.end method

.method public static construct(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/InputStream;)Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;
    .locals 1
    .param p0, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;
    .param p1, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 105
    new-instance v0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;

    invoke-direct {v0, p0, p1}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/InputStream;)V

    return-object v0
.end method

.method public static construct(Lcom/fasterxml/aalto/in/ReaderConfig;[BII)Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;
    .locals 1
    .param p0, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;
    .param p1, "inputBuffer"    # [B
    .param p2, "inputStart"    # I
    .param p3, "inputLen"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 111
    new-instance v0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;[BII)V

    return-object v0
.end method

.method private determineStreamEncoding()V
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 214
    const/4 v0, 0x4

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->ensureLoaded(I)Z

    move-result v1

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eqz v1, :cond_4

    .line 215
    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    .line 219
    .local v1, "origPtr":I
    iget-object v4, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    aget-byte v4, v4, v5

    shl-int/lit8 v4, v4, 0x18

    iget-object v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/2addr v6, v3

    aget-byte v5, v5, v6

    and-int/lit16 v5, v5, 0xff

    shl-int/lit8 v5, v5, 0x10

    or-int/2addr v4, v5

    iget-object v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    const/4 v7, 0x2

    add-int/2addr v6, v7

    aget-byte v5, v5, v6

    and-int/lit16 v5, v5, 0xff

    shl-int/lit8 v5, v5, 0x8

    or-int/2addr v4, v5

    iget-object v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v6, v6, 0x3

    aget-byte v5, v5, v6

    and-int/lit16 v5, v5, 0xff

    or-int/2addr v4, v5

    .line 227
    .local v4, "quartet":I
    const-string v5, "2143"

    const-string v6, "3412"

    sparse-switch v4, :sswitch_data_0

    .line 247
    ushr-int/lit8 v8, v4, 0x10

    .line 248
    .local v8, "msw":I
    const v9, 0xfeff

    if-ne v8, v9, :cond_0

    .line 249
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/2addr v0, v7

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    .line 250
    iput v7, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    .line 251
    iput-boolean v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBigEndian:Z

    .line 252
    goto/16 :goto_0

    .line 239
    .end local v8    # "msw":I
    :sswitch_0
    invoke-direct {p0, v5}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->reportWeirdUCS4(Ljava/lang/String;)V

    .line 240
    goto/16 :goto_0

    .line 229
    :sswitch_1
    iput-boolean v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBigEndian:Z

    .line 230
    iget v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/2addr v5, v0

    iput v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    .line 231
    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    .line 232
    goto :goto_0

    .line 234
    :sswitch_2
    iput-boolean v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBigEndian:Z

    .line 235
    iget v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/2addr v5, v0

    iput v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    .line 236
    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    .line 237
    goto :goto_0

    .line 242
    :sswitch_3
    invoke-direct {p0, v6}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->reportWeirdUCS4(Ljava/lang/String;)V

    .line 243
    goto :goto_0

    .line 254
    .restart local v8    # "msw":I
    :cond_0
    const v9, 0xfffe

    if-ne v8, v9, :cond_1

    .line 255
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/2addr v0, v7

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    .line 256
    iput v7, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    .line 257
    iput-boolean v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBigEndian:Z

    .line 258
    goto :goto_0

    .line 262
    :cond_1
    ushr-int/lit8 v9, v4, 0x8

    const v10, 0xefbbbf

    if-ne v9, v10, :cond_2

    .line 263
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v0, v0, 0x3

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    .line 264
    iput v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    .line 265
    iput-boolean v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBigEndian:Z

    .line 266
    goto :goto_0

    .line 274
    :cond_2
    sparse-switch v4, :sswitch_data_1

    goto :goto_0

    .line 303
    :sswitch_4
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->reportEBCDIC()V

    goto :goto_0

    .line 298
    :sswitch_5
    iput v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    .line 299
    iput-boolean v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBigEndian:Z

    .line 300
    goto :goto_0

    .line 294
    :sswitch_6
    iput v7, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    .line 295
    iput-boolean v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBigEndian:Z

    .line 296
    goto :goto_0

    .line 280
    :sswitch_7
    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    .line 281
    iput-boolean v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBigEndian:Z

    .line 282
    goto :goto_0

    .line 290
    :sswitch_8
    iput v7, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    .line 291
    iput-boolean v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBigEndian:Z

    .line 292
    goto :goto_0

    .line 287
    :sswitch_9
    invoke-direct {p0, v6}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->reportWeirdUCS4(Ljava/lang/String;)V

    .line 288
    goto :goto_0

    .line 284
    :sswitch_a
    invoke-direct {p0, v5}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->reportWeirdUCS4(Ljava/lang/String;)V

    .line 285
    goto :goto_0

    .line 276
    :sswitch_b
    iput-boolean v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBigEndian:Z

    .line 277
    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    .line 278
    nop

    .line 311
    .end local v4    # "quartet":I
    .end local v8    # "msw":I
    :goto_0
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    if-le v0, v1, :cond_3

    move v0, v3

    goto :goto_1

    :cond_3
    move v0, v2

    :goto_1
    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mHadBOM:Z

    .line 316
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputRowStart:I

    .line 322
    .end local v1    # "origPtr":I
    :cond_4
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    if-lez v0, :cond_5

    move v2, v3

    :cond_5
    iput-boolean v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mByteSizeFound:Z

    .line 323
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mByteSizeFound:Z

    if-nez v0, :cond_6

    .line 324
    iput v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    .line 325
    iput-boolean v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBigEndian:Z

    .line 327
    :cond_6
    return-void

    :sswitch_data_0
    .sparse-switch
        -0x1010000 -> :sswitch_3
        -0x20000 -> :sswitch_2
        0xfeff -> :sswitch_1
        0xfffe -> :sswitch_0
    .end sparse-switch

    :sswitch_data_1
    .sparse-switch
        0x3c -> :sswitch_b
        0x3c00 -> :sswitch_a
        0x3c0000 -> :sswitch_9
        0x3c003f -> :sswitch_8
        0x3c000000 -> :sswitch_7
        0x3c003f00 -> :sswitch_6
        0x3c3f786d -> :sswitch_5
        0x4c6fa794 -> :sswitch_4
    .end sparse-switch
.end method

.method private reportEBCDIC()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 797
    new-instance v0, Ljava/io/CharConversionException;

    const-string v1, "Unsupported encoding (EBCDIC)"

    invoke-direct {v0, v1}, Ljava/io/CharConversionException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private reportWeirdUCS4(Ljava/lang/String;)V
    .locals 3
    .param p1, "type"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 791
    new-instance v0, Ljava/io/CharConversionException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unsupported UCS-4 endianness ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") detected"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/CharConversionException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private verifyEncoding(Ljava/lang/String;I)V
    .locals 2
    .param p1, "id"    # Ljava/lang/String;
    .param p2, "bpc"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 762
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mByteSizeFound:Z

    if-eqz v0, :cond_0

    .line 766
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    if-eq p2, v0, :cond_0

    .line 767
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Declared encoding \'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\' uses "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " bytes per character; but physical encoding appeared to use "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "; cannot decode"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->reportXmlProblem(Ljava/lang/String;)V

    .line 771
    :cond_0
    return-void
.end method

.method private verifyEncoding(Ljava/lang/String;IZ)V
    .locals 3
    .param p1, "id"    # Ljava/lang/String;
    .param p2, "bpc"    # I
    .param p3, "bigEndian"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 776
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mByteSizeFound:Z

    if-eqz v0, :cond_1

    .line 777
    invoke-direct {p0, p1, p2}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->verifyEncoding(Ljava/lang/String;I)V

    .line 779
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBigEndian:Z

    if-eq p3, v0, :cond_1

    .line 780
    if-eqz p3, :cond_0

    const-string v0, "big"

    goto :goto_0

    :cond_0
    const-string v0, "little"

    .line 781
    .local v0, "bigStr":Ljava/lang/String;
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Declared encoding \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\' has different endianness ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " endian) than what physical ordering appeared to be; cannot decode"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 782
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->reportXmlProblem(Ljava/lang/String;)V

    .line 786
    .end local v0    # "bigStr":Ljava/lang/String;
    :cond_1
    return-void
.end method


# virtual methods
.method public final bootstrap()Lcom/fasterxml/aalto/in/XmlScanner;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 118
    :try_start_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->doBootstrap()Lcom/fasterxml/aalto/in/XmlScanner;

    move-result-object v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 122
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    iget-object v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mKeyword:[C

    invoke-virtual {v1, v2}, Lcom/fasterxml/aalto/in/ReaderConfig;->freeSmallCBuffer([C)V

    .line 118
    return-object v0

    .line 122
    :catchall_0
    move-exception v0

    goto :goto_0

    .line 119
    :catch_0
    move-exception v0

    .line 120
    .local v0, "ioe":Ljava/io/IOException;
    :try_start_1
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 122
    .end local v0    # "ioe":Ljava/io/IOException;
    :goto_0
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    iget-object v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mKeyword:[C

    invoke-virtual {v1, v2}, Lcom/fasterxml/aalto/in/ReaderConfig;->freeSmallCBuffer([C)V

    .line 123
    throw v0
.end method

.method protected checkKeyword(Ljava/lang/String;)I
    .locals 2
    .param p1, "exp"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 509
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    const/4 v1, 0x1

    if-le v0, v1, :cond_0

    .line 510
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->checkMbKeyword(Ljava/lang/String;)I

    move-result v0

    return v0

    .line 512
    :cond_0
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->checkSbKeyword(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method protected checkMbKeyword(Ljava/lang/String;)I
    .locals 4
    .param p1, "expected"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 738
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 740
    .local v0, "len":I
    const/4 v1, 0x1

    .local v1, "ptr":I
    :goto_0
    if-ge v1, v0, :cond_2

    .line 741
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextMultiByte()I

    move-result v2

    .line 742
    .local v2, "c":I
    if-nez v2, :cond_0

    .line 743
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->reportNull()V

    .line 745
    :cond_0
    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v3

    if-eq v2, v3, :cond_1

    .line 746
    return v2

    .line 740
    .end local v2    # "c":I
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 750
    .end local v1    # "ptr":I
    :cond_2
    const/4 v1, 0x0

    return v1
.end method

.method protected checkSbKeyword(Ljava/lang/String;)I
    .locals 5
    .param p1, "expected"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 635
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 637
    .local v0, "len":I
    const/4 v1, 0x1

    .local v1, "ptr":I
    :goto_0
    if-ge v1, v0, :cond_3

    .line 638
    iget v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    if-ge v2, v3, :cond_0

    iget-object v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    aget-byte v2, v2, v3

    goto :goto_1

    .line 639
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextByte()B

    move-result v2

    :goto_1
    nop

    .line 641
    .local v2, "b":B
    if-nez v2, :cond_1

    .line 642
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->reportNull()V

    .line 644
    :cond_1
    and-int/lit16 v3, v2, 0xff

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v4

    if-eq v3, v4, :cond_2

    .line 645
    and-int/lit16 v3, v2, 0xff

    return v3

    .line 637
    .end local v2    # "b":B
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 649
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

    .line 128
    const/4 v0, 0x0

    .line 130
    .local v0, "normEnc":Ljava/lang/String;
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->determineStreamEncoding()V

    .line 131
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->hasXmlDeclaration()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 132
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->readXmlDeclaration()V

    .line 133
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mFoundEncoding:Ljava/lang/String;

    if-eqz v1, :cond_0

    .line 134
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mFoundEncoding:Ljava/lang/String;

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->verifyXmlEncoding(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 140
    :cond_0
    const-string v1, "UTF-32BE"

    const-string v2, "UTF-32LE"

    const-string v3, "UTF-16BE"

    const-string v4, "UTF-16LE"

    if-nez v0, :cond_5

    .line 141
    iget v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    const/4 v6, 0x2

    if-ne v5, v6, :cond_2

    .line 142
    iget-boolean v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBigEndian:Z

    if-eqz v5, :cond_1

    move-object v5, v3

    goto :goto_0

    :cond_1
    move-object v5, v4

    :goto_0
    move-object v0, v5

    goto :goto_2

    .line 143
    :cond_2
    iget v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    const/4 v6, 0x4

    if-ne v5, v6, :cond_4

    .line 149
    iget-boolean v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBigEndian:Z

    if-eqz v5, :cond_3

    move-object v5, v1

    goto :goto_1

    :cond_3
    move-object v5, v2

    :goto_1
    move-object v0, v5

    goto :goto_2

    .line 152
    :cond_4
    const-string v0, "UTF-8"

    .line 156
    :cond_5
    :goto_2
    iget-object v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v5, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->setActualEncoding(Ljava/lang/String;)V

    .line 157
    iget-object v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    iget v6, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mDeclaredXmlVersion:I

    iget-object v7, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mFoundEncoding:Ljava/lang/String;

    iget-object v8, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mStandalone:Ljava/lang/String;

    invoke-virtual {v5, v6, v7, v8}, Lcom/fasterxml/aalto/in/ReaderConfig;->setXmlDeclInfo(ILjava/lang/String;Ljava/lang/String;)V

    .line 161
    const-string v5, "UTF-8"

    if-eq v0, v5, :cond_d

    const-string v5, "ISO-8859-1"

    if-eq v0, v5, :cond_d

    const-string v5, "US-ASCII"

    if-ne v0, v5, :cond_6

    goto/16 :goto_5

    .line 166
    :cond_6
    const-string v5, "UTF-32"

    invoke-virtual {v0, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_9

    .line 171
    if-ne v0, v5, :cond_8

    .line 172
    iget-boolean v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBigEndian:Z

    if-eqz v3, :cond_7

    goto :goto_3

    :cond_7
    move-object v1, v2

    :goto_3
    move-object v0, v1

    .line 174
    :cond_8
    new-instance v8, Lcom/fasterxml/aalto/in/Utf32Reader;

    iget-object v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    iget-object v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_in:Ljava/io/InputStream;

    iget-object v4, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    iget-boolean v7, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBigEndian:Z

    move-object v1, v8

    invoke-direct/range {v1 .. v7}, Lcom/fasterxml/aalto/in/Utf32Reader;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/InputStream;[BIIZ)V

    .line 176
    .local v1, "r":Ljava/io/Reader;
    new-instance v2, Lcom/fasterxml/aalto/in/ReaderScanner;

    iget-object v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-direct {v2, v3, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/Reader;)V

    return-object v2

    .line 182
    .end local v1    # "r":Ljava/io/Reader;
    :cond_9
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_in:Ljava/io/InputStream;

    .line 183
    .local v1, "in":Ljava/io/InputStream;
    iget v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    if-ge v2, v5, :cond_a

    .line 184
    new-instance v2, Lcom/fasterxml/aalto/in/MergedStream;

    iget-object v6, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    iget-object v8, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v9, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iget v10, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    move-object v5, v2

    move-object v7, v1

    invoke-direct/range {v5 .. v10}, Lcom/fasterxml/aalto/in/MergedStream;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/InputStream;[BII)V

    move-object v1, v2

    .line 186
    :cond_a
    const-string v2, "UTF-16"

    if-ne v0, v2, :cond_c

    .line 187
    iget-boolean v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBigEndian:Z

    if-eqz v2, :cond_b

    goto :goto_4

    :cond_b
    move-object v3, v4

    :goto_4
    move-object v0, v3

    .line 190
    :cond_c
    :try_start_0
    new-instance v2, Ljava/io/InputStreamReader;

    invoke-direct {v2, v1, v0}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    .line 191
    .local v2, "r":Ljava/io/Reader;
    new-instance v3, Lcom/fasterxml/aalto/in/ReaderScanner;

    iget-object v4, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-direct {v3, v4, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/Reader;)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v3

    .line 192
    .end local v2    # "r":Ljava/io/Reader;
    :catch_0
    move-exception v2

    .line 193
    .local v2, "usex":Ljava/io/UnsupportedEncodingException;
    new-instance v3, Lcom/fasterxml/aalto/impl/IoStreamException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Unsupported encoding: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Ljava/io/UnsupportedEncodingException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 164
    .end local v1    # "in":Ljava/io/InputStream;
    .end local v2    # "usex":Ljava/io/UnsupportedEncodingException;
    :cond_d
    :goto_5
    new-instance v1, Lcom/fasterxml/aalto/in/Utf8Scanner;

    iget-object v6, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    iget-object v7, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_in:Ljava/io/InputStream;

    iget-object v8, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v9, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iget v10, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    move-object v5, v1

    invoke-direct/range {v5 .. v10}, Lcom/fasterxml/aalto/in/Utf8Scanner;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/InputStream;[BII)V

    return-object v1
.end method

.method protected ensureLoaded(I)Z
    .locals 7
    .param p1, "minimum"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 418
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    sub-int/2addr v0, v1

    .line 419
    .local v0, "gotten":I
    :goto_0
    const/4 v1, 0x1

    if-ge v0, p1, :cond_2

    .line 422
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_in:Ljava/io/InputStream;

    if-nez v2, :cond_0

    .line 423
    const/4 v2, -0x1

    .local v2, "count":I
    goto :goto_1

    .line 425
    .end local v2    # "count":I
    :cond_0
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_in:Ljava/io/InputStream;

    iget-object v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    iget-object v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    array-length v5, v5

    iget v6, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    sub-int/2addr v5, v6

    invoke-virtual {v2, v3, v4, v5}, Ljava/io/InputStream;->read([BII)I

    move-result v2

    .line 427
    .restart local v2    # "count":I
    :goto_1
    if-ge v2, v1, :cond_1

    .line 428
    const/4 v1, 0x0

    return v1

    .line 430
    :cond_1
    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    add-int/2addr v1, v2

    iput v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    .line 431
    add-int/2addr v0, v2

    .line 432
    .end local v2    # "count":I
    goto :goto_0

    .line 433
    :cond_2
    return v1
.end method

.method protected getLocation()Ljavax/xml/stream/Location;
    .locals 8

    .line 564
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputProcessed:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/2addr v0, v1

    .line 565
    .local v0, "total":I
    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputRowStart:I

    sub-int/2addr v1, v2

    .line 567
    .local v1, "col":I
    iget v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    const/4 v3, 0x1

    if-le v2, v3, :cond_0

    .line 568
    iget v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    div-int/2addr v0, v2

    .line 569
    iget v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    div-int/2addr v1, v2

    move v7, v1

    goto :goto_0

    .line 567
    :cond_0
    move v7, v1

    .line 571
    .end local v1    # "col":I
    .local v7, "col":I
    :goto_0
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    .line 572
    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->getPublicId()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/in/ReaderConfig;->getSystemId()Ljava/lang/String;

    move-result-object v2

    int-to-long v3, v0

    iget v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputRow:I

    move v6, v7

    invoke-static/range {v1 .. v6}, Lcom/fasterxml/aalto/impl/LocationImpl;->fromZeroBased(Ljava/lang/String;Ljava/lang/String;JII)Lcom/fasterxml/aalto/impl/LocationImpl;

    move-result-object v1

    .line 571
    return-object v1
.end method

.method protected getNext()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 468
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    const/4 v1, 0x1

    if-le v0, v1, :cond_0

    .line 469
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextMultiByte()I

    move-result v0

    return v0

    .line 471
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    if-ge v0, v1, :cond_1

    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    aget-byte v0, v0, v1

    goto :goto_0

    .line 472
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextByte()B

    move-result v0

    :goto_0
    nop

    .line 473
    .local v0, "b":B
    and-int/lit16 v1, v0, 0xff

    return v1
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

    .line 482
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    const/4 v1, 0x1

    if-le v0, v1, :cond_0

    .line 483
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->skipMbWs()I

    move-result v0

    .local v0, "count":I
    goto :goto_0

    .line 485
    .end local v0    # "count":I
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->skipSbWs()I

    move-result v0

    .line 488
    .restart local v0    # "count":I
    :goto_0
    if-eqz p1, :cond_1

    if-nez v0, :cond_1

    .line 489
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->getNext()I

    move-result v2

    const-string v3, "; expected a white space"

    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->reportUnexpectedChar(ILjava/lang/String;)V

    .line 493
    :cond_1
    iget v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    if-le v2, v1, :cond_2

    .line 494
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextMultiByte()I

    move-result v1

    return v1

    .line 496
    :cond_2
    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    if-ge v1, v2, :cond_3

    iget-object v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    aget-byte v1, v1, v2

    goto :goto_1

    .line 497
    :cond_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextByte()B

    move-result v1

    :goto_1
    nop

    .line 498
    .local v1, "b":B
    and-int/lit16 v2, v1, 0xff

    return v2
.end method

.method protected hasXmlDeclaration()Z
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 333
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    const/16 v1, 0x20

    const/16 v2, 0x6c

    const/16 v3, 0x6d

    const/16 v4, 0x78

    const/16 v5, 0x3f

    const/16 v6, 0x3c

    const/4 v7, 0x6

    const/4 v8, 0x1

    if-ne v0, v8, :cond_0

    .line 335
    invoke-virtual {p0, v7}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->ensureLoaded(I)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 336
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v9, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    aget-byte v0, v0, v9

    if-ne v0, v6, :cond_2

    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/2addr v6, v8

    aget-byte v0, v0, v6

    if-ne v0, v5, :cond_2

    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v5, v5, 0x2

    aget-byte v0, v0, v5

    if-ne v0, v4, :cond_2

    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v4, v4, 0x3

    aget-byte v0, v0, v4

    if-ne v0, v3, :cond_2

    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v3, v3, 0x4

    aget-byte v0, v0, v3

    if-ne v0, v2, :cond_2

    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v2, v2, 0x5

    aget-byte v0, v0, v2

    and-int/lit16 v0, v0, 0xff

    if-gt v0, v1, :cond_2

    .line 344
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/2addr v0, v7

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    .line 345
    return v8

    .line 349
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    mul-int/2addr v0, v7

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->ensureLoaded(I)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 350
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    .line 351
    .local v0, "start":I
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextMultiByte()I

    move-result v7

    if-ne v7, v6, :cond_1

    .line 352
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextMultiByte()I

    move-result v6

    if-ne v6, v5, :cond_1

    .line 353
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextMultiByte()I

    move-result v5

    if-ne v5, v4, :cond_1

    .line 354
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextMultiByte()I

    move-result v4

    if-ne v4, v3, :cond_1

    .line 355
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextMultiByte()I

    move-result v3

    if-ne v3, v2, :cond_1

    .line 356
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextMultiByte()I

    move-result v2

    if-gt v2, v1, :cond_1

    .line 357
    return v8

    .line 359
    :cond_1
    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    .line 362
    .end local v0    # "start":I
    :cond_2
    const/4 v0, 0x0

    return v0
.end method

.method protected loadMore()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 439
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputProcessed:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputProcessed:I

    .line 440
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputRowStart:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    sub-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputRowStart:I

    .line 442
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    .line 443
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_in:Ljava/io/InputStream;

    if-nez v1, :cond_0

    .line 444
    const/4 v0, -0x1

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    goto :goto_0

    .line 446
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_in:Ljava/io/InputStream;

    iget-object v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget-object v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    array-length v3, v3

    invoke-virtual {v1, v2, v0, v3}, Ljava/io/InputStream;->read([BII)I

    move-result v0

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    .line 448
    :goto_0
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    const/4 v1, 0x1

    if-ge v0, v1, :cond_1

    .line 449
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->reportEof()V

    .line 451
    :cond_1
    return-void
.end method

.method protected nextByte()B
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 585
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    if-lt v0, v1, :cond_0

    .line 586
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->loadMore()V

    .line 588
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    aget-byte v0, v0, v1

    return v0
.end method

.method protected nextMultiByte()I
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 661
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    if-ge v0, v1, :cond_0

    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    aget-byte v0, v0, v1

    goto :goto_0

    .line 662
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextByte()B

    move-result v0

    :goto_0
    nop

    .line 663
    .local v0, "b":B
    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    if-ge v1, v2, :cond_1

    iget-object v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    aget-byte v1, v1, v2

    goto :goto_1

    .line 664
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextByte()B

    move-result v1

    :goto_1
    nop

    .line 667
    .local v1, "b2":B
    iget v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    const/4 v3, 0x2

    if-ne v2, v3, :cond_3

    .line 668
    iget-boolean v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBigEndian:Z

    if-eqz v2, :cond_2

    .line 669
    and-int/lit16 v2, v0, 0xff

    shl-int/lit8 v2, v2, 0x8

    and-int/lit16 v3, v1, 0xff

    or-int/2addr v2, v3

    .local v2, "c":I
    goto :goto_4

    .line 671
    .end local v2    # "c":I
    :cond_2
    and-int/lit16 v2, v0, 0xff

    and-int/lit16 v3, v1, 0xff

    shl-int/lit8 v3, v3, 0x8

    or-int/2addr v2, v3

    .restart local v2    # "c":I
    goto :goto_4

    .line 675
    .end local v2    # "c":I
    :cond_3
    iget v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    if-ge v2, v3, :cond_4

    iget-object v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    aget-byte v2, v2, v3

    goto :goto_2

    .line 676
    :cond_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextByte()B

    move-result v2

    :goto_2
    nop

    .line 677
    .local v2, "b3":B
    iget v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    if-ge v3, v4, :cond_5

    iget-object v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v4, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    aget-byte v3, v3, v4

    goto :goto_3

    .line 678
    :cond_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextByte()B

    move-result v3

    :goto_3
    nop

    .line 680
    .local v3, "b4":B
    iget-boolean v4, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBigEndian:Z

    if-eqz v4, :cond_6

    .line 681
    shl-int/lit8 v4, v0, 0x18

    and-int/lit16 v5, v1, 0xff

    shl-int/lit8 v5, v5, 0x10

    or-int/2addr v4, v5

    and-int/lit16 v5, v2, 0xff

    shl-int/lit8 v5, v5, 0x8

    or-int/2addr v4, v5

    and-int/lit16 v5, v3, 0xff

    or-int/2addr v4, v5

    move v2, v4

    .local v4, "c":I
    goto :goto_4

    .line 684
    .end local v4    # "c":I
    :cond_6
    shl-int/lit8 v4, v3, 0x18

    and-int/lit16 v5, v2, 0xff

    shl-int/lit8 v5, v5, 0x10

    or-int/2addr v4, v5

    and-int/lit16 v5, v1, 0xff

    shl-int/lit8 v5, v5, 0x8

    or-int/2addr v4, v5

    and-int/lit16 v5, v0, 0xff

    or-int/2addr v4, v5

    move v2, v4

    .line 690
    .end local v3    # "b4":B
    .local v2, "c":I
    :goto_4
    if-nez v2, :cond_7

    .line 691
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->reportNull()V

    .line 693
    :cond_7
    return v2
.end method

.method protected pushback()V
    .locals 2

    .line 461
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    sub-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    .line 462
    return-void
.end method

.method protected readQuotedValue([CI)I
    .locals 8
    .param p1, "kw"    # [C
    .param p2, "quoteChar"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 519
    const/4 v0, 0x0

    .line 520
    .local v0, "i":I
    array-length v1, p1

    .line 521
    .local v1, "len":I
    iget v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    const/4 v3, 0x1

    if-le v2, v3, :cond_0

    goto :goto_0

    :cond_0
    const/4 v3, 0x0

    :goto_0
    move v2, v3

    .line 523
    .local v2, "mb":Z
    :goto_1
    if-ge v0, v1, :cond_9

    .line 526
    const/16 v3, 0xa

    const/16 v4, 0xd

    if-eqz v2, :cond_2

    .line 527
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextMultiByte()I

    move-result v5

    .line 528
    .local v5, "c":I
    if-eq v5, v4, :cond_1

    if-ne v5, v3, :cond_7

    .line 529
    :cond_1
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->skipMbLF(I)V

    .line 530
    const/16 v5, 0xa

    goto :goto_3

    .line 533
    .end local v5    # "c":I
    :cond_2
    iget v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    if-ge v5, v6, :cond_3

    iget-object v5, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v6, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    aget-byte v5, v5, v6

    goto :goto_2

    .line 534
    :cond_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextByte()B

    move-result v5

    :goto_2
    nop

    .line 535
    .local v5, "b":B
    if-nez v5, :cond_4

    .line 536
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->reportNull()V

    .line 538
    :cond_4
    if-eq v5, v4, :cond_5

    if-ne v5, v3, :cond_6

    .line 539
    :cond_5
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->skipSbLF(B)V

    .line 540
    const/16 v5, 0xa

    .line 542
    :cond_6
    and-int/lit16 v3, v5, 0xff

    move v5, v3

    .line 545
    .local v5, "c":I
    :cond_7
    :goto_3
    if-ne v5, p2, :cond_8

    .line 546
    return v0

    .line 548
    :cond_8
    add-int/lit8 v3, v0, 0x1

    .end local v0    # "i":I
    .local v3, "i":I
    int-to-char v4, v5

    aput-char v4, p1, v0

    .line 549
    .end local v5    # "c":I
    move v0, v3

    goto :goto_1

    .line 553
    .end local v3    # "i":I
    .restart local v0    # "i":I
    :cond_9
    const/4 v3, -0x1

    return v3
.end method

.method protected skipMbLF(I)V
    .locals 3
    .param p1, "lf"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 721
    const/16 v0, 0xd

    if-ne p1, v0, :cond_0

    .line 722
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextMultiByte()I

    move-result v0

    .line 723
    .local v0, "c":I
    const/16 v1, 0xa

    if-eq v0, v1, :cond_0

    .line 724
    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    sub-int/2addr v1, v2

    iput v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    .line 727
    .end local v0    # "c":I
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputRow:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputRow:I

    .line 728
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputRowStart:I

    .line 729
    return-void
.end method

.method protected skipMbWs()I
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 699
    const/4 v0, 0x0

    .line 702
    .local v0, "count":I
    :goto_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextMultiByte()I

    move-result v1

    .line 704
    .local v1, "c":I
    const/16 v2, 0x20

    if-le v1, v2, :cond_0

    .line 705
    iget v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->mBytesPerChar:I

    sub-int/2addr v2, v3

    iput v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    .line 706
    nop

    .line 715
    .end local v1    # "c":I
    return v0

    .line 708
    .restart local v1    # "c":I
    :cond_0
    const/16 v2, 0xd

    if-eq v1, v2, :cond_2

    const/16 v2, 0xa

    if-ne v1, v2, :cond_1

    goto :goto_1

    .line 710
    :cond_1
    if-nez v1, :cond_3

    .line 711
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->reportNull()V

    goto :goto_2

    .line 709
    :cond_2
    :goto_1
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->skipMbLF(I)V

    .line 713
    :cond_3
    :goto_2
    nop

    .end local v1    # "c":I
    add-int/lit8 v0, v0, 0x1

    .line 714
    goto :goto_0
.end method

.method protected skipSbLF(B)V
    .locals 3
    .param p1, "lfByte"    # B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 617
    const/16 v0, 0xd

    if-ne p1, v0, :cond_1

    .line 618
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    if-ge v0, v1, :cond_0

    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    aget-byte v0, v0, v1

    goto :goto_0

    .line 619
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextByte()B

    move-result v0

    :goto_0
    nop

    .line 620
    .local v0, "b":B
    const/16 v1, 0xa

    if-eq v0, v1, :cond_1

    .line 621
    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v1, v1, -0x1

    iput v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    .line 624
    .end local v0    # "b":B
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputRow:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputRow:I

    .line 625
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputRowStart:I

    .line 626
    return-void
.end method

.method protected skipSbWs()I
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 594
    const/4 v0, 0x0

    .line 597
    .local v0, "count":I
    :goto_0
    iget v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputLen:I

    if-ge v1, v2, :cond_0

    iget-object v1, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    aget-byte v1, v1, v2

    goto :goto_1

    .line 598
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->nextByte()B

    move-result v1

    :goto_1
    nop

    .line 600
    .local v1, "b":B
    and-int/lit16 v2, v1, 0xff

    const/16 v3, 0x20

    if-le v2, v3, :cond_1

    .line 601
    iget v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    add-int/lit8 v2, v2, -0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->_inputPtr:I

    .line 602
    nop

    .line 611
    .end local v1    # "b":B
    return v0

    .line 604
    .restart local v1    # "b":B
    :cond_1
    const/16 v2, 0xd

    if-eq v1, v2, :cond_3

    const/16 v2, 0xa

    if-ne v1, v2, :cond_2

    goto :goto_2

    .line 606
    :cond_2
    if-nez v1, :cond_4

    .line 607
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->reportNull()V

    goto :goto_3

    .line 605
    :cond_3
    :goto_2
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->skipSbLF(B)V

    .line 609
    :cond_4
    :goto_3
    nop

    .end local v1    # "b":B
    add-int/lit8 v0, v0, 0x1

    .line 610
    goto :goto_0
.end method

.method protected verifyXmlEncoding(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "enc"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 371
    invoke-static {p1}, Lcom/fasterxml/aalto/util/CharsetNames;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 374
    const-string v0, "UTF-8"

    const/4 v1, 0x1

    if-ne p1, v0, :cond_0

    .line 375
    invoke-direct {p0, p1, v1}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->verifyEncoding(Ljava/lang/String;I)V

    goto :goto_0

    .line 376
    :cond_0
    const-string v0, "ISO-8859-1"

    if-ne p1, v0, :cond_1

    .line 377
    invoke-direct {p0, p1, v1}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->verifyEncoding(Ljava/lang/String;I)V

    goto :goto_0

    .line 378
    :cond_1
    const-string v0, "US-ASCII"

    if-ne p1, v0, :cond_2

    .line 379
    invoke-direct {p0, p1, v1}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->verifyEncoding(Ljava/lang/String;I)V

    goto :goto_0

    .line 380
    :cond_2
    const-string v0, "UTF-16"

    const/4 v2, 0x2

    if-ne p1, v0, :cond_3

    .line 386
    invoke-direct {p0, p1, v2}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->verifyEncoding(Ljava/lang/String;I)V

    goto :goto_0

    .line 387
    :cond_3
    const-string v0, "UTF-16LE"

    const/4 v3, 0x0

    if-ne p1, v0, :cond_4

    .line 388
    invoke-direct {p0, p1, v2, v3}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->verifyEncoding(Ljava/lang/String;IZ)V

    goto :goto_0

    .line 389
    :cond_4
    const-string v0, "UTF-16BE"

    if-ne p1, v0, :cond_5

    .line 390
    invoke-direct {p0, p1, v2, v1}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->verifyEncoding(Ljava/lang/String;IZ)V

    goto :goto_0

    .line 392
    :cond_5
    const-string v0, "UTF-32"

    const/4 v2, 0x4

    if-ne p1, v0, :cond_6

    .line 397
    invoke-direct {p0, p1, v2}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->verifyEncoding(Ljava/lang/String;I)V

    goto :goto_0

    .line 398
    :cond_6
    const-string v0, "UTF-32LE"

    if-ne p1, v0, :cond_7

    .line 399
    invoke-direct {p0, p1, v2, v3}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->verifyEncoding(Ljava/lang/String;IZ)V

    goto :goto_0

    .line 400
    :cond_7
    const-string v0, "UTF-32BE"

    if-ne p1, v0, :cond_8

    .line 401
    invoke-direct {p0, p1, v2, v1}, Lcom/fasterxml/aalto/in/ByteSourceBootstrapper;->verifyEncoding(Ljava/lang/String;IZ)V

    .line 403
    :cond_8
    :goto_0
    return-object p1
.end method
