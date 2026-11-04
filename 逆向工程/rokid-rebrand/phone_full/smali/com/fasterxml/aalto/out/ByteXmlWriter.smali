.class public abstract Lcom/fasterxml/aalto/out/ByteXmlWriter;
.super Lcom/fasterxml/aalto/out/XmlWriter;
.source "ByteXmlWriter.java"


# static fields
.field static final BYTES_CDATA_END:[B

.field static final BYTES_CDATA_START:[B

.field static final BYTES_COMMENT_END:[B

.field static final BYTES_COMMENT_START:[B

.field static final BYTES_XMLDECL_ENCODING:[B

.field static final BYTES_XMLDECL_STANDALONE:[B

.field static final BYTES_XMLDECL_START:[B

.field static final BYTE_A:B = 0x61t

.field static final BYTE_AMP:B = 0x26t

.field static final BYTE_APOS:B = 0x27t

.field static final BYTE_COLON:B = 0x3at

.field static final BYTE_EQ:B = 0x3dt

.field static final BYTE_G:B = 0x67t

.field static final BYTE_GT:B = 0x3et

.field static final BYTE_HASH:B = 0x23t

.field static final BYTE_HYPHEN:B = 0x2dt

.field static final BYTE_L:B = 0x6ct

.field static final BYTE_LBRACKET:B = 0x5bt

.field static final BYTE_LT:B = 0x3ct

.field static final BYTE_M:B = 0x6dt

.field static final BYTE_O:B = 0x6ft

.field static final BYTE_P:B = 0x70t

.field static final BYTE_Q:B = 0x71t

.field static final BYTE_QMARK:B = 0x3ft

.field static final BYTE_QUOT:B = 0x22t

.field static final BYTE_RBRACKET:B = 0x5dt

.field static final BYTE_S:B = 0x73t

.field static final BYTE_SEMICOLON:B = 0x3bt

.field static final BYTE_SLASH:B = 0x2ft

.field static final BYTE_SPACE:B = 0x20t

.field static final BYTE_T:B = 0x74t

.field static final BYTE_U:B = 0x75t

.field static final BYTE_X:B = 0x78t

.field static final DEFAULT_COPY_BUFFER_SIZE:I = 0x3e8

.field static final DEFAULT_FULL_BUFFER_SIZE:I = 0xfa0

.field static final SMALL_WRITE:I = 0xfa


# instance fields
.field protected final _charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

.field protected _out:Ljava/io/OutputStream;

.field protected _outputBuffer:[B

.field protected final _outputBufferLen:I

.field protected _outputPtr:I

.field protected _surrogate:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 93
    const-string v0, "<![CDATA["

    invoke-static {v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->getAscii(Ljava/lang/String;)[B

    move-result-object v0

    sput-object v0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->BYTES_CDATA_START:[B

    .line 94
    const-string v0, "]]>"

    invoke-static {v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->getAscii(Ljava/lang/String;)[B

    move-result-object v0

    sput-object v0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->BYTES_CDATA_END:[B

    .line 95
    const-string v0, "<!--"

    invoke-static {v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->getAscii(Ljava/lang/String;)[B

    move-result-object v0

    sput-object v0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->BYTES_COMMENT_START:[B

    .line 96
    const-string v0, "-->"

    invoke-static {v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->getAscii(Ljava/lang/String;)[B

    move-result-object v0

    sput-object v0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->BYTES_COMMENT_END:[B

    .line 98
    const-string v0, "<?xml version=\'"

    invoke-static {v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->getAscii(Ljava/lang/String;)[B

    move-result-object v0

    sput-object v0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->BYTES_XMLDECL_START:[B

    .line 99
    const-string v0, " encoding=\'"

    invoke-static {v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->getAscii(Ljava/lang/String;)[B

    move-result-object v0

    sput-object v0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->BYTES_XMLDECL_ENCODING:[B

    .line 100
    const-string v0, " standalone=\'"

    invoke-static {v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->getAscii(Ljava/lang/String;)[B

    move-result-object v0

    sput-object v0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->BYTES_XMLDECL_STANDALONE:[B

    return-void
.end method

.method protected constructor <init>(Lcom/fasterxml/aalto/out/WriterConfig;Ljava/io/OutputStream;Lcom/fasterxml/aalto/util/XmlCharTypes;)V
    .locals 2
    .param p1, "cfg"    # Lcom/fasterxml/aalto/out/WriterConfig;
    .param p2, "out"    # Ljava/io/OutputStream;
    .param p3, "charTypes"    # Lcom/fasterxml/aalto/util/XmlCharTypes;

    .line 147
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/out/XmlWriter;-><init>(Lcom/fasterxml/aalto/out/WriterConfig;)V

    .line 126
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_surrogate:I

    .line 148
    iput-object p2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_out:Ljava/io/OutputStream;

    .line 149
    const/16 v1, 0xfa0

    invoke-virtual {p1, v1}, Lcom/fasterxml/aalto/out/WriterConfig;->allocFullBBuffer(I)[B

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    .line 150
    iget-object v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    array-length v1, v1

    iput v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    .line 151
    iput v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 152
    iput-object p3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    .line 153
    return-void
.end method

.method protected static final getAscii(Ljava/lang/String;[B)V
    .locals 3
    .param p0, "str"    # Ljava/lang/String;
    .param p1, "result"    # [B

    .line 1696
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 1697
    .local v0, "len":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v0, :cond_0

    .line 1698
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    int-to-byte v2, v2

    aput-byte v2, p1, v1

    .line 1697
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1700
    .end local v1    # "i":I
    :cond_0
    return-void
.end method

.method protected static final getAscii(Ljava/lang/String;[BI)V
    .locals 4
    .param p0, "str"    # Ljava/lang/String;
    .param p1, "result"    # [B
    .param p2, "offset"    # I

    .line 1704
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 1705
    .local v0, "len":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v0, :cond_0

    .line 1706
    add-int v2, p2, v1

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v3

    int-to-byte v3, v3

    aput-byte v3, p1, v2

    .line 1705
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1708
    .end local v1    # "i":I
    :cond_0
    return-void
.end method

.method protected static final getAscii(Ljava/lang/String;)[B
    .locals 3
    .param p0, "str"    # Ljava/lang/String;

    .line 1688
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 1689
    .local v0, "len":I
    new-array v1, v0, [B

    .line 1690
    .local v1, "result":[B
    const/4 v2, 0x0

    invoke-static {p0, v1, v2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->getAscii(Ljava/lang/String;[BI)V

    .line 1691
    return-object v1
.end method

.method private final longWriteCharacters(Ljava/lang/String;)V
    .locals 7
    .param p1, "text"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 891
    const/4 v0, 0x0

    .line 892
    .local v0, "offset":I
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    .line 893
    .local v1, "len":I
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_copyBuffer:[C

    .line 896
    .local v2, "buf":[C
    :cond_0
    array-length v3, v2

    .line 897
    .local v3, "blen":I
    if-ge v1, v3, :cond_1

    move v4, v1

    goto :goto_0

    :cond_1
    move v4, v3

    .line 898
    .local v4, "len2":I
    :goto_0
    add-int v5, v0, v4

    const/4 v6, 0x0

    invoke-virtual {p1, v0, v5, v2, v6}, Ljava/lang/String;->getChars(II[CI)V

    .line 899
    invoke-virtual {p0, v2, v6, v4}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeCharacters([CII)V

    .line 900
    add-int/2addr v0, v4

    .line 901
    sub-int/2addr v1, v4

    .line 902
    .end local v3    # "blen":I
    .end local v4    # "len2":I
    if-gtz v1, :cond_0

    .line 903
    return-void
.end method

.method private final writeAttrNameEqQ(Lcom/fasterxml/aalto/out/WName;)V
    .locals 7
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 714
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_surrogate:I

    if-eqz v0, :cond_0

    .line 715
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->throwUnpairedSurrogate()V

    .line 718
    :cond_0
    invoke-virtual {p1}, Lcom/fasterxml/aalto/out/WName;->serializedLength()I

    move-result v0

    .line 719
    .local v0, "nlen":I
    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 720
    .local v1, "ptr":I
    add-int v2, v1, v0

    add-int/lit8 v2, v2, 0x3

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    const/16 v4, 0x22

    const/16 v5, 0x3d

    const/16 v6, 0x20

    if-lt v2, v3, :cond_1

    .line 721
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 722
    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 724
    add-int v2, v1, v0

    add-int/lit8 v2, v2, 0x3

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-lt v2, v3, :cond_1

    .line 725
    invoke-virtual {p0, v6, p1}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeName(BLcom/fasterxml/aalto/out/WName;)V

    .line 726
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(B)V

    .line 727
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(B)V

    .line 728
    return-void

    .line 731
    :cond_1
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    .line 732
    .local v2, "bbuf":[B
    add-int/lit8 v3, v1, 0x1

    .end local v1    # "ptr":I
    .local v3, "ptr":I
    aput-byte v6, v2, v1

    .line 733
    invoke-virtual {p1, v2, v3}, Lcom/fasterxml/aalto/out/WName;->appendBytes([BI)I

    move-result v1

    add-int/2addr v3, v1

    .line 734
    add-int/lit8 v1, v3, 0x1

    .end local v3    # "ptr":I
    .restart local v1    # "ptr":I
    aput-byte v5, v2, v3

    .line 735
    add-int/lit8 v3, v1, 0x1

    .end local v1    # "ptr":I
    .restart local v3    # "ptr":I
    aput-byte v4, v2, v1

    .line 736
    iput v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 737
    return-void
.end method

.method private final writeSplitCharacters([CII)V
    .locals 5
    .param p1, "cbuf"    # [C
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1018
    add-int/2addr p3, p2

    .line 1021
    :goto_0
    if-ge p2, p3, :cond_a

    .line 1022
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    .line 1026
    .local v0, "charTypes":[I
    :goto_1
    aget-char v1, p1, p2

    .line 1027
    .local v1, "ch":I
    const/16 v2, 0x800

    if-lt v1, v2, :cond_0

    .line 1028
    goto :goto_2

    .line 1030
    :cond_0
    aget v3, v0, v1

    if-eqz v3, :cond_7

    .line 1031
    const/16 v3, 0xa

    if-eq v1, v3, :cond_6

    .line 1032
    nop

    .line 1046
    .end local v1    # "ch":I
    :goto_2
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "offset":I
    .local v1, "offset":I
    aget-char p2, p1, p2

    .line 1047
    .local p2, "ch":I
    if-ge p2, v2, :cond_5

    .line 1048
    aget v2, v0, p2

    packed-switch v2, :pswitch_data_0

    .line 1079
    :pswitch_0
    goto :goto_3

    .line 1073
    :pswitch_1
    if-ge v1, p3, :cond_1

    aget-char v2, p1, v1

    const/16 v3, 0x3e

    if-ne v2, v3, :cond_3

    .line 1074
    :cond_1
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeAsEntity(I)V

    .line 1075
    goto :goto_4

    .line 1069
    :pswitch_2
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->output2ByteChar(I)V

    .line 1070
    goto :goto_4

    .line 1065
    :pswitch_3
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeAsEntity(I)V

    .line 1066
    goto :goto_4

    .line 1061
    :pswitch_4
    goto :goto_3

    .line 1050
    :pswitch_5
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportInvalidChar(I)V

    .line 1054
    :pswitch_6
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/out/WriterConfig;->willEscapeCR()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 1055
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeAsEntity(I)V

    .line 1056
    goto :goto_4

    .line 1058
    :cond_2
    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_locRowNr:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_locRowNr:I

    .line 1059
    nop

    .line 1086
    :cond_3
    :goto_3
    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-lt v2, v3, :cond_4

    .line 1087
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 1089
    :cond_4
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    int-to-byte v4, p2

    aput-byte v4, v2, v3

    .line 1090
    .end local v0    # "charTypes":[I
    .end local p2    # "ch":I
    nop

    .line 1021
    :goto_4
    move p2, v1

    goto :goto_0

    .line 1082
    .restart local v0    # "charTypes":[I
    .restart local p2    # "ch":I
    :cond_5
    invoke-virtual {p0, p2, p1, v1, p3}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->outputMultiByteChar(I[CII)I

    move-result v1

    .line 1083
    move p2, v1

    goto :goto_0

    .line 1034
    .local v1, "ch":I
    .local p2, "offset":I
    :cond_6
    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_locRowNr:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_locRowNr:I

    .line 1036
    :cond_7
    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-lt v2, v3, :cond_8

    .line 1037
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 1039
    :cond_8
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    int-to-byte v4, v1

    aput-byte v4, v2, v3

    .line 1040
    add-int/lit8 p2, p2, 0x1

    if-lt p2, p3, :cond_9

    .line 1041
    goto :goto_5

    .line 1043
    .end local v1    # "ch":I
    :cond_9
    goto/16 :goto_1

    .line 1091
    .end local v0    # "charTypes":[I
    :cond_a
    :goto_5
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_5
        :pswitch_6
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_3
        :pswitch_3
        :pswitch_1
    .end packed-switch
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

    .line 311
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_out:Ljava/io/OutputStream;

    if-eqz v0, :cond_0

    .line 312
    if-eqz p1, :cond_0

    .line 313
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_out:Ljava/io/OutputStream;

    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V

    .line 314
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_out:Ljava/io/OutputStream;

    .line 317
    :cond_0
    return-void
.end method

.method public _releaseBuffers()V
    .locals 3

    .line 297
    invoke-super {p0}, Lcom/fasterxml/aalto/out/XmlWriter;->_releaseBuffers()V

    .line 298
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 299
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    invoke-virtual {v0, v2}, Lcom/fasterxml/aalto/out/WriterConfig;->freeFullBBuffer([B)V

    .line 300
    iput-object v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    .line 302
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_copyBuffer:[C

    if-eqz v0, :cond_1

    .line 303
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_copyBuffer:[C

    invoke-virtual {v0, v2}, Lcom/fasterxml/aalto/out/WriterConfig;->freeFullCBuffer([C)V

    .line 304
    iput-object v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_copyBuffer:[C

    .line 306
    :cond_1
    return-void
.end method

.method protected final calcSurrogate(IILjava/lang/String;)I
    .locals 3
    .param p1, "surr1"    # I
    .param p2, "surr2"    # I
    .param p3, "context"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1669
    const v0, 0xdc00

    if-lt p2, v0, :cond_0

    const v1, 0xdfff

    if-le p2, v1, :cond_1

    .line 1670
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Incomplete surrogate pair"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ": first char 0x"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", second 0x"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p2}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1671
    .local v1, "msg":Ljava/lang/String;
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportNwfContent(Ljava/lang/String;)V

    .line 1673
    .end local v1    # "msg":Ljava/lang/String;
    :cond_1
    const v1, 0xd800

    sub-int v1, p1, v1

    shl-int/lit8 v1, v1, 0xa

    const/high16 v2, 0x10000

    add-int/2addr v1, v2

    sub-int v0, p2, v0

    add-int/2addr v1, v0

    .line 1674
    .local v1, "c":I
    const v0, 0x10ffff

    if-le v1, v0, :cond_2

    .line 1675
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportInvalidChar(I)V

    .line 1677
    :cond_2
    return v1
.end method

.method public final constructName(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;
    .locals 1
    .param p1, "localName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 170
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->verifyNameComponent(Ljava/lang/String;)V

    .line 171
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->doConstructName(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    return-object v0
.end method

.method public constructName(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 178
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->verifyNameComponent(Ljava/lang/String;)V

    .line 179
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->verifyNameComponent(Ljava/lang/String;)V

    .line 180
    invoke-virtual {p0, p1, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->doConstructName(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v0

    return-object v0
.end method

.method protected abstract doConstructName(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract doConstructName(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected final fastWriteAttrValue([CII[BI)I
    .locals 5
    .param p1, "vbuf"    # [C
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .param p4, "bbuf"    # [B
    .param p5, "ptr"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 514
    add-int/2addr p3, p2

    .line 517
    :goto_0
    if-ge p2, p3, :cond_5

    .line 518
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    .line 522
    .local v0, "charTypes":[I
    :goto_1
    aget-char v1, p1, p2

    .line 523
    .local v1, "ch":I
    const/16 v2, 0x800

    if-lt v1, v2, :cond_0

    .line 524
    goto :goto_2

    .line 526
    :cond_0
    aget v3, v0, v1

    if-eqz v3, :cond_3

    .line 528
    nop

    .line 536
    .end local v1    # "ch":I
    :goto_2
    iput p5, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 538
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "offset":I
    .local v1, "offset":I
    aget-char p2, p1, p2

    .line 539
    .local p2, "ch":I
    if-ge p2, v2, :cond_1

    .line 540
    aget v2, v0, p2

    sparse-switch v2, :sswitch_data_0

    .line 548
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeAsEntity(I)V

    goto :goto_3

    .line 545
    :sswitch_0
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->output2ByteChar(I)V

    .line 546
    goto :goto_3

    .line 542
    :sswitch_1
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportInvalidChar(I)V

    .line 543
    goto :goto_3

    .line 551
    :cond_1
    invoke-virtual {p0, p2, p1, v1, p3}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->outputMultiByteChar(I[CII)I

    move-result v1

    .line 561
    :goto_3
    sub-int v2, p3, v1

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    iget v4, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    sub-int/2addr v3, v4

    if-lt v2, v3, :cond_2

    .line 562
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 564
    :cond_2
    iget p5, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 565
    .end local v0    # "charTypes":[I
    .end local p2    # "ch":I
    move p2, v1

    goto :goto_0

    .line 530
    .restart local v0    # "charTypes":[I
    .local v1, "ch":I
    .local p2, "offset":I
    :cond_3
    add-int/lit8 v2, p5, 0x1

    .end local p5    # "ptr":I
    .local v2, "ptr":I
    int-to-byte v3, v1

    aput-byte v3, p4, p5

    .line 531
    add-int/lit8 p2, p2, 0x1

    if-lt p2, p3, :cond_4

    .line 532
    move p5, v2

    goto :goto_4

    .line 534
    .end local v1    # "ch":I
    :cond_4
    move p5, v2

    goto :goto_1

    .line 567
    .end local v0    # "charTypes":[I
    .end local v2    # "ptr":I
    .restart local p5    # "ptr":I
    :cond_5
    :goto_4
    return p5

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_1
        0x5 -> :sswitch_0
    .end sparse-switch
.end method

.method public final flush()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 322
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_out:Ljava/io/OutputStream;

    if-eqz v0, :cond_0

    .line 323
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 324
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_out:Ljava/io/OutputStream;

    invoke-virtual {v0}, Ljava/io/OutputStream;->flush()V

    .line 326
    :cond_0
    return-void
.end method

.method protected final flushBuffer()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1584
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_out:Ljava/io/OutputStream;

    if-eqz v0, :cond_0

    .line 1585
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 1587
    .local v0, "ptr":I
    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_locPastChars:I

    add-int/2addr v1, v0

    iput v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_locPastChars:I

    .line 1588
    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_locRowStartOffset:I

    sub-int/2addr v1, v0

    iput v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_locRowStartOffset:I

    .line 1589
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 1590
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_out:Ljava/io/OutputStream;

    iget-object v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    invoke-virtual {v2, v3, v1, v0}, Ljava/io/OutputStream;->write([BII)V

    .line 1592
    .end local v0    # "ptr":I
    :cond_0
    return-void
.end method

.method protected final getOutputPtr()I
    .locals 1

    .line 157
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    return v0
.end method

.method protected abstract output2ByteChar(I)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract outputMultiByteChar(I[CII)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract outputStrictMultiByteChar(I[CII)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract outputSurrogates(II)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected final throwUnpairedSurrogate()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1562
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_surrogate:I

    .line 1563
    .local v0, "surr":I
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_surrogate:I

    .line 1564
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->throwUnpairedSurrogate(I)V

    .line 1565
    return-void
.end method

.method protected final throwUnpairedSurrogate(I)V
    .locals 3
    .param p1, "code"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1571
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flush()V

    .line 1572
    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unpaired surrogate character (0x"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected verifyNameComponent(Ljava/lang/String;)V
    .locals 13
    .param p1, "part"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 200
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    .line 201
    :cond_0
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_NAME_EMPTY:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportNwfName(Ljava/lang/String;)V

    .line 203
    :cond_1
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 204
    .local v0, "ch":I
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    .line 208
    .local v1, "len":I
    const-string v2, " in name"

    const-string v3, ") not valid surrogate first character"

    const v4, 0xdc00

    const v5, 0xdfff

    const v6, 0xd800

    if-lt v0, v6, :cond_4

    if-gt v0, v5, :cond_4

    .line 210
    if-lt v0, v4, :cond_2

    .line 211
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Illegal surrogate pairing in name: first character ("

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-static {v0}, Lcom/fasterxml/aalto/util/XmlChars;->getCharDesc(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {p0, v7}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportNwfName(Ljava/lang/String;)V

    .line 214
    :cond_2
    const/4 v7, 0x2

    if-ge v1, v7, :cond_3

    .line 215
    const-string v7, "Illegal surrogate pairing in name: incomplete surrogate (missing second half)"

    invoke-virtual {p0, v7}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportNwfName(Ljava/lang/String;)V

    .line 218
    :cond_3
    const/4 v7, 0x1

    invoke-virtual {p1, v7}, Ljava/lang/String;->charAt(I)C

    move-result v7

    invoke-virtual {p0, v0, v7, v2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->calcSurrogate(IILjava/lang/String;)I

    move-result v0

    .line 219
    const/4 v7, 0x2

    .local v7, "i":I
    goto :goto_0

    .line 221
    .end local v7    # "i":I
    :cond_4
    const/4 v7, 0x1

    .line 223
    .restart local v7    # "i":I
    :goto_0
    invoke-static {v0}, Lcom/fasterxml/aalto/util/XmlChars;->is10NameStartChar(I)Z

    move-result v8

    const-string v9, " (name \""

    if-nez v8, :cond_5

    .line 224
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "Invalid name start character "

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-static {v0}, Lcom/fasterxml/aalto/util/XmlChars;->getCharDesc(I)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v10, "\")"

    invoke-virtual {v8, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p0, v8}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportNwfName(Ljava/lang/String;)V

    .line 227
    :cond_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->getHighestEncodable()I

    move-result v8

    .line 228
    .local v8, "lastValid":I
    const-string v10, ")"

    if-le v0, v8, :cond_6

    .line 229
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Illegal name start character "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-static {v0}, Lcom/fasterxml/aalto/util/XmlChars;->getCharDesc(I)Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, "\"): can not be expressed using effective encoding ("

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-object v12, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v12}, Lcom/fasterxml/aalto/out/WriterConfig;->getActualEncoding()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {p0, v11}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportNwfName(Ljava/lang/String;)V

    .line 232
    :cond_6
    :goto_1
    if-ge v7, v1, :cond_c

    .line 233
    invoke-virtual {p1, v7}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 234
    if-lt v0, v6, :cond_9

    if-gt v0, v5, :cond_9

    .line 236
    if-lt v0, v4, :cond_7

    .line 237
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Illegal surrogate pairing in name: character at #"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, " ("

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-static {v0}, Lcom/fasterxml/aalto/util/XmlChars;->getCharDesc(I)Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {p0, v11}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportNwfName(Ljava/lang/String;)V

    .line 240
    :cond_7
    add-int/lit8 v7, v7, 0x1

    .line 241
    if-lt v7, v1, :cond_8

    .line 242
    const-string v11, "Illegal surrogate pairing in name: name ends with incomplete surrogate pair"

    invoke-virtual {p0, v11}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportNwfName(Ljava/lang/String;)V

    .line 245
    :cond_8
    invoke-virtual {p1, v7}, Ljava/lang/String;->charAt(I)C

    move-result v11

    invoke-virtual {p0, v0, v11, v2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->calcSurrogate(IILjava/lang/String;)I

    move-result v0

    .line 247
    :cond_9
    if-le v0, v8, :cond_a

    .line 248
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Illegal name character "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-static {v0}, Lcom/fasterxml/aalto/util/XmlChars;->getCharDesc(I)Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, "\", index #"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, "): can not be expressed using effective encoding ("

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-object v12, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v12}, Lcom/fasterxml/aalto/out/WriterConfig;->getActualEncoding()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {p0, v11}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportNwfName(Ljava/lang/String;)V

    .line 250
    :cond_a
    invoke-static {v0}, Lcom/fasterxml/aalto/util/XmlChars;->is10NameChar(I)Z

    move-result v11

    if-nez v11, :cond_b

    .line 251
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Invalid name character "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-static {v0}, Lcom/fasterxml/aalto/util/XmlChars;->getCharDesc(I)Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, ") in name (\""

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, "\"), index #"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {p0, v11}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportNwfName(Ljava/lang/String;)V

    .line 232
    :cond_b
    add-int/lit8 v7, v7, 0x1

    goto/16 :goto_1

    .line 254
    :cond_c
    return-void
.end method

.method protected final writeAsEntity(I)V
    .locals 10
    .param p1, "c"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1599
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    .line 1600
    .local v0, "buf":[B
    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 1601
    .local v1, "ptr":I
    add-int/lit8 v2, v1, 0xa

    array-length v3, v0

    if-lt v2, v3, :cond_0

    .line 1602
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 1603
    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 1605
    :cond_0
    add-int/lit8 v2, v1, 0x1

    .end local v1    # "ptr":I
    .local v2, "ptr":I
    const/16 v3, 0x26

    aput-byte v3, v0, v1

    .line 1608
    const/16 v1, 0x100

    const/16 v4, 0x78

    const/16 v5, 0x23

    const/16 v6, 0xa

    if-ge p1, v1, :cond_9

    .line 1612
    const/16 v1, 0x70

    const/16 v7, 0x61

    if-ne p1, v3, :cond_1

    .line 1613
    add-int/lit8 v3, v2, 0x1

    .end local v2    # "ptr":I
    .local v3, "ptr":I
    aput-byte v7, v0, v2

    .line 1614
    add-int/lit8 v2, v3, 0x1

    .end local v3    # "ptr":I
    .restart local v2    # "ptr":I
    const/16 v4, 0x6d

    aput-byte v4, v0, v3

    .line 1615
    add-int/lit8 v3, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v3    # "ptr":I
    aput-byte v1, v0, v2

    goto/16 :goto_4

    .line 1616
    .end local v3    # "ptr":I
    .restart local v2    # "ptr":I
    :cond_1
    const/16 v3, 0x3c

    const/16 v8, 0x74

    if-ne p1, v3, :cond_2

    .line 1617
    add-int/lit8 v1, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v1    # "ptr":I
    const/16 v3, 0x6c

    aput-byte v3, v0, v2

    .line 1618
    add-int/lit8 v3, v1, 0x1

    .end local v1    # "ptr":I
    .restart local v3    # "ptr":I
    aput-byte v8, v0, v1

    goto/16 :goto_4

    .line 1619
    .end local v3    # "ptr":I
    .restart local v2    # "ptr":I
    :cond_2
    const/16 v3, 0x3e

    if-ne p1, v3, :cond_3

    .line 1620
    add-int/lit8 v1, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v1    # "ptr":I
    const/16 v3, 0x67

    aput-byte v3, v0, v2

    .line 1621
    add-int/lit8 v3, v1, 0x1

    .end local v1    # "ptr":I
    .restart local v3    # "ptr":I
    aput-byte v8, v0, v1

    goto/16 :goto_4

    .line 1622
    .end local v3    # "ptr":I
    .restart local v2    # "ptr":I
    :cond_3
    const/16 v3, 0x27

    const/16 v9, 0x6f

    if-ne p1, v3, :cond_4

    .line 1623
    add-int/lit8 v3, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v3    # "ptr":I
    aput-byte v7, v0, v2

    .line 1624
    add-int/lit8 v2, v3, 0x1

    .end local v3    # "ptr":I
    .restart local v2    # "ptr":I
    aput-byte v1, v0, v3

    .line 1625
    add-int/lit8 v1, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v1    # "ptr":I
    aput-byte v9, v0, v2

    .line 1626
    add-int/lit8 v3, v1, 0x1

    .end local v1    # "ptr":I
    .restart local v3    # "ptr":I
    const/16 v2, 0x73

    aput-byte v2, v0, v1

    goto/16 :goto_4

    .line 1627
    .end local v3    # "ptr":I
    .restart local v2    # "ptr":I
    :cond_4
    const/16 v1, 0x22

    if-ne p1, v1, :cond_5

    .line 1628
    add-int/lit8 v1, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v1    # "ptr":I
    const/16 v3, 0x71

    aput-byte v3, v0, v2

    .line 1629
    add-int/lit8 v2, v1, 0x1

    .end local v1    # "ptr":I
    .restart local v2    # "ptr":I
    const/16 v3, 0x75

    aput-byte v3, v0, v1

    .line 1630
    add-int/lit8 v1, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v1    # "ptr":I
    aput-byte v9, v0, v2

    .line 1631
    add-int/lit8 v3, v1, 0x1

    .end local v1    # "ptr":I
    .restart local v3    # "ptr":I
    aput-byte v8, v0, v1

    goto :goto_4

    .line 1633
    .end local v3    # "ptr":I
    .restart local v2    # "ptr":I
    :cond_5
    add-int/lit8 v1, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v1    # "ptr":I
    aput-byte v5, v0, v2

    .line 1634
    add-int/lit8 v2, v1, 0x1

    .end local v1    # "ptr":I
    .restart local v2    # "ptr":I
    aput-byte v4, v0, v1

    .line 1636
    const/16 v1, 0x10

    if-lt p1, v1, :cond_7

    .line 1637
    shr-int/lit8 v1, p1, 0x4

    .line 1638
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
    int-to-byte v4, v4

    aput-byte v4, v0, v2

    .line 1639
    and-int/lit8 p1, p1, 0xf

    move v2, v3

    .line 1641
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
    int-to-byte v1, v1

    aput-byte v1, v0, v2

    goto :goto_4

    .line 1644
    .end local v3    # "ptr":I
    .restart local v2    # "ptr":I
    :cond_9
    add-int/lit8 v1, v2, 0x1

    .end local v2    # "ptr":I
    .local v1, "ptr":I
    aput-byte v5, v0, v2

    .line 1645
    add-int/lit8 v2, v1, 0x1

    .end local v1    # "ptr":I
    .restart local v2    # "ptr":I
    aput-byte v4, v0, v1

    .line 1648
    const/16 v1, 0x14

    .line 1649
    .local v1, "shift":I
    move v3, v2

    .line 1652
    .local v3, "origPtr":I
    :cond_a
    shr-int v4, p1, v1

    and-int/lit8 v4, v4, 0xf

    .line 1653
    .local v4, "digit":I
    if-gtz v4, :cond_b

    if-eq v2, v3, :cond_d

    .line 1654
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
    int-to-byte v7, v7

    aput-byte v7, v0, v2

    move v2, v5

    .line 1656
    .end local v5    # "ptr":I
    .restart local v2    # "ptr":I
    :cond_d
    nop

    .end local v4    # "digit":I
    add-int/lit8 v1, v1, -0x4

    .line 1657
    if-gtz v1, :cond_a

    .line 1658
    and-int/lit8 p1, p1, 0xf

    .line 1659
    add-int/lit8 v4, v2, 0x1

    .end local v2    # "ptr":I
    .local v4, "ptr":I
    if-ge p1, v6, :cond_e

    add-int/lit8 v5, p1, 0x30

    goto :goto_3

    :cond_e
    add-int/lit8 v5, p1, 0x57

    :goto_3
    int-to-byte v5, v5

    aput-byte v5, v0, v2

    move v3, v4

    .line 1661
    .end local v1    # "shift":I
    .end local v4    # "ptr":I
    .local v3, "ptr":I
    :goto_4
    add-int/lit8 v1, v3, 0x1

    .end local v3    # "ptr":I
    .local v1, "ptr":I
    const/16 v2, 0x3b

    aput-byte v2, v0, v3

    .line 1662
    iput v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 1663
    return-void
.end method

.method protected final writeAttrValue([CII)V
    .locals 5
    .param p1, "vbuf"    # [C
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 573
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_surrogate:I

    if-eqz v0, :cond_0

    .line 574
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_surrogate:I

    aget-char v1, p1, p2

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->outputSurrogates(II)V

    .line 575
    add-int/lit8 p2, p2, 0x1

    .line 576
    add-int/lit8 p3, p3, -0x1

    .line 579
    :cond_0
    add-int/2addr p3, p2

    .line 582
    :goto_0
    if-ge p2, p3, :cond_6

    .line 583
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    .line 587
    .local v0, "charTypes":[I
    :goto_1
    aget-char v1, p1, p2

    .line 588
    .local v1, "ch":I
    const/16 v2, 0x800

    if-lt v1, v2, :cond_1

    .line 589
    goto :goto_2

    .line 591
    :cond_1
    aget v3, v0, v1

    if-eqz v3, :cond_3

    .line 592
    nop

    .line 604
    .end local v1    # "ch":I
    :goto_2
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "offset":I
    .local v1, "offset":I
    aget-char p2, p1, p2

    .line 605
    .local p2, "ch":I
    if-ge p2, v2, :cond_2

    .line 606
    aget v2, v0, p2

    sparse-switch v2, :sswitch_data_0

    .line 613
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeAsEntity(I)V

    .line 614
    goto :goto_3

    .line 608
    :sswitch_0
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportInvalidChar(I)V

    .line 610
    :sswitch_1
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->output2ByteChar(I)V

    .line 611
    nop

    .line 620
    .end local v0    # "charTypes":[I
    .end local p2    # "ch":I
    :goto_3
    move p2, v1

    goto :goto_0

    .line 617
    .restart local v0    # "charTypes":[I
    .restart local p2    # "ch":I
    :cond_2
    invoke-virtual {p0, p2, p1, v1, p3}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->outputMultiByteChar(I[CII)I

    move-result v1

    .line 618
    move p2, v1

    goto :goto_0

    .line 594
    .local v1, "ch":I
    .local p2, "offset":I
    :cond_3
    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-lt v2, v3, :cond_4

    .line 595
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 597
    :cond_4
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    int-to-byte v4, v1

    aput-byte v4, v2, v3

    .line 598
    add-int/lit8 p2, p2, 0x1

    if-lt p2, p3, :cond_5

    .line 599
    goto :goto_4

    .line 601
    .end local v1    # "ch":I
    :cond_5
    goto :goto_1

    .line 621
    .end local v0    # "charTypes":[I
    :cond_6
    :goto_4
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_0
        0x5 -> :sswitch_1
    .end sparse-switch
.end method

.method public final writeAttribute(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)V
    .locals 3
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;
    .param p2, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 450
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    .line 452
    .local v0, "vlen":I
    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_copyBufferLen:I

    if-le v0, v1, :cond_0

    .line 453
    invoke-virtual {p0, p1, p2, v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeLongAttribute(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;I)V

    .line 454
    return-void

    .line 456
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_copyBuffer:[C

    .line 457
    .local v1, "cbuf":[C
    const/4 v2, 0x0

    if-lez v0, :cond_1

    .line 458
    invoke-virtual {p2, v2, v0, v1, v2}, Ljava/lang/String;->getChars(II[CI)V

    .line 460
    :cond_1
    invoke-virtual {p0, p1, v1, v2, v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeAttribute(Lcom/fasterxml/aalto/out/WName;[CII)V

    .line 461
    return-void
.end method

.method public final writeAttribute(Lcom/fasterxml/aalto/out/WName;Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)V
    .locals 4
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;
    .param p2, "enc"    # Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1123
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeAttrNameEqQ(Lcom/fasterxml/aalto/out/WName;)V

    .line 1127
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    sub-int/2addr v0, v1

    .line 1128
    .local v0, "free":I
    invoke-virtual {p2, v0}, Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;->bufferNeedsFlush(I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1129
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flush()V

    .line 1132
    :cond_0
    :goto_0
    iget-object v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    invoke-virtual {p2, v1, v2, v3}, Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;->encodeMore([BII)I

    move-result v1

    iput v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 1133
    invoke-virtual {p2}, Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;->isCompleted()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 1134
    nop

    .line 1141
    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-lt v1, v2, :cond_1

    .line 1142
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 1144
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    const/16 v3, 0x22

    aput-byte v3, v1, v2

    .line 1145
    return-void

    .line 1136
    :cond_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    goto :goto_0
.end method

.method public final writeAttribute(Lcom/fasterxml/aalto/out/WName;[CII)V
    .locals 9
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;
    .param p2, "vbuf"    # [C
    .param p3, "offset"    # I
    .param p4, "vlen"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 467
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_surrogate:I

    if-eqz v0, :cond_0

    .line 468
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->throwUnpairedSurrogate()V

    .line 472
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 473
    .local v0, "ptr":I
    iget-object v7, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    .line 475
    .local v7, "bbuf":[B
    invoke-virtual {p1}, Lcom/fasterxml/aalto/out/WName;->serializedLength()I

    move-result v1

    add-int/2addr v1, v0

    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    const/16 v3, 0x20

    if-lt v1, v2, :cond_1

    .line 476
    invoke-virtual {p0, v3, p1}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeName(BLcom/fasterxml/aalto/out/WName;)V

    .line 477
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    goto :goto_0

    .line 479
    :cond_1
    add-int/lit8 v1, v0, 0x1

    .end local v0    # "ptr":I
    .local v1, "ptr":I
    aput-byte v3, v7, v0

    .line 480
    invoke-virtual {p1, v7, v1}, Lcom/fasterxml/aalto/out/WName;->appendBytes([BI)I

    move-result v0

    add-int/2addr v0, v1

    .line 484
    .end local v1    # "ptr":I
    .restart local v0    # "ptr":I
    :goto_0
    add-int/lit8 v1, v0, 0x3

    add-int/2addr v1, p4

    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    const/16 v3, 0x3d

    const/16 v8, 0x22

    if-le v1, v2, :cond_3

    .line 485
    iput v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 486
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 487
    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    aput-byte v3, v7, v1

    .line 488
    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    aput-byte v8, v7, v1

    .line 489
    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/2addr v1, p4

    add-int/lit8 v1, v1, 0x1

    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-le v1, v2, :cond_2

    .line 490
    invoke-virtual {p0, p2, p3, p4}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeAttrValue([CII)V

    .line 491
    invoke-virtual {p0, v8}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(B)V

    .line 492
    return-void

    .line 494
    :cond_2
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    goto :goto_1

    .line 496
    :cond_3
    add-int/lit8 v1, v0, 0x1

    .end local v0    # "ptr":I
    .restart local v1    # "ptr":I
    aput-byte v3, v7, v0

    .line 497
    add-int/lit8 v0, v1, 0x1

    .end local v1    # "ptr":I
    .restart local v0    # "ptr":I
    aput-byte v8, v7, v1

    .line 499
    :goto_1
    if-lez p4, :cond_4

    .line 500
    move-object v1, p0

    move-object v2, p2

    move v3, p3

    move v4, p4

    move-object v5, v7

    move v6, v0

    invoke-virtual/range {v1 .. v6}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->fastWriteAttrValue([CII[BI)I

    move-result v0

    .line 502
    :cond_4
    add-int/lit8 v1, v0, 0x1

    .end local v0    # "ptr":I
    .restart local v1    # "ptr":I
    aput-byte v8, v7, v0

    .line 503
    iput v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 504
    return-void
.end method

.method public writeCData(Ljava/lang/String;)I
    .locals 6
    .param p1, "data"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 754
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeCDataStart()V

    .line 755
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 756
    .local v0, "len":I
    const/4 v1, 0x0

    .line 757
    .local v1, "offset":I
    :goto_0
    if-lez v0, :cond_2

    .line 758
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_copyBuffer:[C

    .line 759
    .local v2, "buf":[C
    array-length v3, v2

    .line 762
    .local v3, "blen":I
    if-le v3, v0, :cond_0

    .line 763
    move v3, v0

    .line 766
    :cond_0
    add-int v4, v1, v3

    const/4 v5, 0x0

    invoke-virtual {p1, v1, v4, v2, v5}, Ljava/lang/String;->getChars(II[CI)V

    .line 767
    invoke-virtual {p0, v2, v5, v3}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeCDataContents([CII)I

    move-result v4

    .line 768
    .local v4, "cix":I
    if-ltz v4, :cond_1

    .line 769
    add-int v5, v1, v4

    return v5

    .line 771
    :cond_1
    add-int/2addr v1, v3

    .line 772
    sub-int/2addr v0, v3

    .line 773
    .end local v2    # "buf":[C
    .end local v3    # "blen":I
    .end local v4    # "cix":I
    goto :goto_0

    .line 774
    :cond_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeCDataEnd()V

    .line 775
    const/4 v2, -0x1

    return v2
.end method

.method public writeCData([CII)I
    .locals 1
    .param p1, "cbuf"    # [C
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 782
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeCDataStart()V

    .line 783
    invoke-virtual {p0, p1, p2, p3}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeCDataContents([CII)I

    move-result v0

    .line 784
    .local v0, "ix":I
    if-gez v0, :cond_0

    .line 785
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeCDataEnd()V

    .line 787
    :cond_0
    return v0
.end method

.method protected writeCDataContents([CII)I
    .locals 5
    .param p1, "cbuf"    # [C
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 799
    add-int/2addr p3, p2

    .line 802
    :goto_0
    if-ge p2, p3, :cond_8

    .line 803
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 807
    .local v0, "charTypes":[I
    :goto_1
    aget-char v1, p1, p2

    .line 808
    .local v1, "ch":I
    const/16 v2, 0x800

    if-lt v1, v2, :cond_0

    .line 809
    goto :goto_2

    .line 811
    :cond_0
    aget v3, v0, v1

    if-eqz v3, :cond_5

    .line 812
    nop

    .line 824
    .end local v1    # "ch":I
    :goto_2
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "offset":I
    .local v1, "offset":I
    aget-char p2, p1, p2

    .line 825
    .local p2, "ch":I
    if-ge p2, v2, :cond_4

    .line 826
    aget v2, v0, p2

    packed-switch v2, :pswitch_data_0

    :pswitch_0
    goto :goto_3

    .line 843
    :pswitch_1
    if-ge v1, p3, :cond_2

    aget-char v2, p1, v1

    const/16 v3, 0x5d

    if-ne v2, v3, :cond_2

    .line 844
    add-int/lit8 v2, v1, 0x1

    if-ge v2, p3, :cond_1

    add-int/lit8 v2, v1, 0x1

    aget-char v2, p1, v2

    const/16 v4, 0x3e

    if-ne v2, v4, :cond_1

    .line 846
    add-int/lit8 v1, v1, 0x2

    .line 847
    invoke-virtual {p0, v3, v3}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(BB)V

    .line 848
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeCDataEnd()V

    .line 850
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeCDataStart()V

    .line 851
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(B)V

    move p2, v1

    goto :goto_0

    .line 834
    :pswitch_2
    const-string v2, "CDATA"

    invoke-virtual {p0, v2, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportFailedEscaping(Ljava/lang/String;I)V

    .line 837
    :pswitch_3
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->output2ByteChar(I)V

    .line 838
    nop

    .line 802
    .end local v0    # "charTypes":[I
    .end local p2    # "ch":I
    :cond_1
    move p2, v1

    goto :goto_0

    .line 828
    .restart local v0    # "charTypes":[I
    .restart local p2    # "ch":I
    :pswitch_4
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportInvalidChar(I)V

    .line 831
    :pswitch_5
    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_locRowNr:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_locRowNr:I

    .line 832
    nop

    .line 859
    :cond_2
    :goto_3
    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-lt v2, v3, :cond_3

    .line 860
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 862
    :cond_3
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    int-to-byte v4, p2

    aput-byte v4, v2, v3

    move p2, v1

    goto :goto_4

    .line 864
    :cond_4
    invoke-virtual {p0, p2, p1, v1, p3}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->outputMultiByteChar(I[CII)I

    move-result v1

    move p2, v1

    .line 866
    .end local v0    # "charTypes":[I
    .end local v1    # "offset":I
    .local p2, "offset":I
    :goto_4
    goto :goto_0

    .line 814
    .restart local v0    # "charTypes":[I
    .local v1, "ch":I
    :cond_5
    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-lt v2, v3, :cond_6

    .line 815
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 817
    :cond_6
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    int-to-byte v4, v1

    aput-byte v4, v2, v3

    .line 818
    add-int/lit8 p2, p2, 0x1

    if-lt p2, p3, :cond_7

    .line 819
    goto :goto_5

    .line 821
    .end local v1    # "ch":I
    :cond_7
    goto/16 :goto_1

    .line 867
    .end local v0    # "charTypes":[I
    :cond_8
    :goto_5
    const/4 v0, -0x1

    return v0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_5
        :pswitch_5
        :pswitch_2
        :pswitch_3
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method protected final writeCDataEnd()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1473
    sget-object v0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->BYTES_CDATA_END:[B

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw([B)V

    .line 1474
    return-void
.end method

.method protected final writeCDataStart()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1467
    sget-object v0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->BYTES_CDATA_START:[B

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw([B)V

    .line 1468
    return-void
.end method

.method public final writeCharacters(Ljava/lang/String;)V
    .locals 3
    .param p1, "text"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 874
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 877
    .local v0, "len":I
    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_copyBufferLen:I

    if-le v0, v1, :cond_0

    .line 878
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->longWriteCharacters(Ljava/lang/String;)V

    .line 879
    return-void

    .line 881
    :cond_0
    if-lez v0, :cond_1

    .line 882
    iget-object v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_copyBuffer:[C

    .line 883
    .local v1, "buf":[C
    const/4 v2, 0x0

    invoke-virtual {p1, v2, v0, v1, v2}, Ljava/lang/String;->getChars(II[CI)V

    .line 884
    invoke-virtual {p0, v1, v2, v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeCharacters([CII)V

    .line 886
    .end local v1    # "buf":[C
    :cond_1
    return-void
.end method

.method public final writeCharacters([CII)V
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

    .line 909
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_surrogate:I

    if-eqz v0, :cond_0

    .line 910
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_surrogate:I

    aget-char v1, p1, p2

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->outputSurrogates(II)V

    .line 911
    add-int/lit8 p2, p2, 0x1

    .line 912
    add-int/lit8 p3, p3, -0x1

    .line 917
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 918
    .local v0, "ptr":I
    add-int v1, v0, p3

    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-le v1, v2, :cond_1

    .line 919
    invoke-direct {p0, p1, p2, p3}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeSplitCharacters([CII)V

    .line 920
    return-void

    .line 922
    :cond_1
    add-int/2addr p3, p2

    .line 925
    :goto_0
    if-ge p2, p3, :cond_b

    .line 926
    iget-object v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v1, v1, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    .line 930
    .local v1, "charTypes":[I
    :goto_1
    aget-char v2, p1, p2

    .line 931
    .local v2, "ch":I
    const/16 v3, 0x800

    if-lt v2, v3, :cond_2

    .line 932
    goto :goto_2

    .line 934
    :cond_2
    aget v4, v1, v2

    if-eqz v4, :cond_9

    .line 938
    const/16 v4, 0xa

    if-eq v2, v4, :cond_8

    .line 939
    nop

    .line 949
    .end local v2    # "ch":I
    :goto_2
    add-int/lit8 v2, p2, 0x1

    .end local p2    # "offset":I
    .local v2, "offset":I
    aget-char p2, p1, p2

    .line 950
    .local p2, "ch":I
    if-ge p2, v3, :cond_6

    .line 951
    aget v3, v1, p2

    packed-switch v3, :pswitch_data_0

    :pswitch_0
    goto :goto_3

    .line 980
    :pswitch_1
    if-ge v2, p3, :cond_3

    aget-char v3, p1, v2

    const/16 v4, 0x3e

    if-ne v3, v4, :cond_5

    .line 981
    :cond_3
    iput v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 982
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeAsEntity(I)V

    .line 983
    goto :goto_4

    .line 975
    :pswitch_2
    iput v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 976
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->output2ByteChar(I)V

    .line 977
    goto :goto_4

    .line 970
    :pswitch_3
    iput v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 971
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeAsEntity(I)V

    .line 972
    goto :goto_4

    .line 966
    :pswitch_4
    goto :goto_4

    .line 953
    :pswitch_5
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportInvalidChar(I)V

    .line 957
    :pswitch_6
    iget-object v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/out/WriterConfig;->willEscapeCR()Z

    move-result v3

    if-eqz v3, :cond_4

    .line 958
    iput v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 959
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeAsEntity(I)V

    .line 960
    goto :goto_4

    .line 962
    :cond_4
    iget-object v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    add-int/lit8 v4, v0, 0x1

    .end local v0    # "ptr":I
    .local v4, "ptr":I
    int-to-byte v5, p2

    aput-byte v5, v3, v0

    .line 963
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_locRowNr:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_locRowNr:I

    .line 964
    move p2, v2

    move v0, v4

    goto :goto_0

    .line 987
    .end local v4    # "ptr":I
    .restart local v0    # "ptr":I
    :cond_5
    :goto_3
    iget-object v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    add-int/lit8 v4, v0, 0x1

    .end local v0    # "ptr":I
    .restart local v4    # "ptr":I
    int-to-byte v5, p2

    aput-byte v5, v3, v0

    .line 988
    move p2, v2

    move v0, v4

    goto :goto_0

    .line 991
    .end local v4    # "ptr":I
    .restart local v0    # "ptr":I
    :cond_6
    iput v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 992
    invoke-virtual {p0, p2, p1, v2, p3}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->outputMultiByteChar(I[CII)I

    move-result v2

    .line 1000
    :goto_4
    sub-int v3, p3, v2

    iget v4, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    iget v5, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    sub-int/2addr v4, v5

    if-lt v3, v4, :cond_7

    .line 1001
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 1003
    :cond_7
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 1004
    .end local v1    # "charTypes":[I
    .end local p2    # "ch":I
    move p2, v2

    goto :goto_0

    .line 941
    .restart local v1    # "charTypes":[I
    .local v2, "ch":I
    .local p2, "offset":I
    :cond_8
    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_locRowNr:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_locRowNr:I

    .line 943
    :cond_9
    iget-object v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    add-int/lit8 v4, v0, 0x1

    .end local v0    # "ptr":I
    .restart local v4    # "ptr":I
    int-to-byte v5, v2

    aput-byte v5, v3, v0

    .line 944
    add-int/lit8 p2, p2, 0x1

    if-lt p2, p3, :cond_a

    .line 945
    move v0, v4

    goto :goto_5

    .line 947
    .end local v2    # "ch":I
    :cond_a
    move v0, v4

    goto/16 :goto_1

    .line 1005
    .end local v1    # "charTypes":[I
    .end local v4    # "ptr":I
    .restart local v0    # "ptr":I
    :cond_b
    :goto_5
    iput v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 1006
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_5
        :pswitch_6
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_3
        :pswitch_3
        :pswitch_1
    .end packed-switch
.end method

.method public writeComment(Ljava/lang/String;)I
    .locals 7
    .param p1, "data"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1163
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeCommentStart()V

    .line 1165
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 1166
    .local v0, "len":I
    const/4 v1, 0x0

    .line 1167
    .local v1, "offset":I
    :goto_0
    if-lez v0, :cond_2

    .line 1168
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_copyBuffer:[C

    .line 1169
    .local v2, "buf":[C
    array-length v3, v2

    .line 1170
    .local v3, "blen":I
    if-ge v0, v3, :cond_0

    move v4, v0

    goto :goto_1

    :cond_0
    move v4, v3

    .line 1172
    .local v4, "len2":I
    :goto_1
    add-int v5, v1, v4

    const/4 v6, 0x0

    invoke-virtual {p1, v1, v5, v2, v6}, Ljava/lang/String;->getChars(II[CI)V

    .line 1173
    invoke-virtual {p0, v2, v6, v4}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeCommentContents([CII)I

    move-result v5

    .line 1174
    .local v5, "cix":I
    if-ltz v5, :cond_1

    .line 1175
    add-int v6, v1, v5

    return v6

    .line 1177
    :cond_1
    add-int/2addr v1, v3

    .line 1178
    sub-int/2addr v0, v3

    .line 1179
    .end local v2    # "buf":[C
    .end local v3    # "blen":I
    .end local v4    # "len2":I
    .end local v5    # "cix":I
    goto :goto_0

    .line 1180
    :cond_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeCommentEnd()V

    .line 1181
    const/4 v2, -0x1

    return v2
.end method

.method protected writeCommentContents([CII)I
    .locals 5
    .param p1, "cbuf"    # [C
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1197
    add-int/2addr p3, p2

    .line 1200
    :goto_0
    if-ge p2, p3, :cond_7

    .line 1201
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 1205
    .local v0, "charTypes":[I
    :goto_1
    aget-char v1, p1, p2

    .line 1206
    .local v1, "ch":I
    const/16 v2, 0x800

    if-lt v1, v2, :cond_0

    .line 1207
    goto :goto_2

    .line 1209
    :cond_0
    aget v3, v0, v1

    if-eqz v3, :cond_4

    .line 1210
    nop

    .line 1222
    .end local v1    # "ch":I
    :goto_2
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "offset":I
    .local v1, "offset":I
    aget-char p2, p1, p2

    .line 1223
    .local p2, "ch":I
    if-ge p2, v2, :cond_3

    .line 1224
    aget v2, v0, p2

    sparse-switch v2, :sswitch_data_0

    goto :goto_4

    .line 1239
    :sswitch_0
    const/16 v2, 0x2d

    if-ge v1, p3, :cond_1

    aget-char v3, p1, v1

    if-eq v3, v2, :cond_1

    .line 1240
    goto :goto_4

    .line 1243
    :cond_1
    const/16 v3, 0x20

    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(BB)V

    .line 1244
    goto :goto_3

    .line 1232
    :sswitch_1
    const-string v2, "comment"

    invoke-virtual {p0, v2, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportFailedEscaping(Ljava/lang/String;I)V

    .line 1235
    :sswitch_2
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->output2ByteChar(I)V

    .line 1236
    nop

    .line 1200
    .end local v0    # "charTypes":[I
    .end local p2    # "ch":I
    :goto_3
    move p2, v1

    goto :goto_0

    .line 1226
    .restart local v0    # "charTypes":[I
    .restart local p2    # "ch":I
    :sswitch_3
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportInvalidChar(I)V

    .line 1229
    :sswitch_4
    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_locRowNr:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_locRowNr:I

    .line 1230
    nop

    .line 1249
    :goto_4
    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-lt v2, v3, :cond_2

    .line 1250
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 1252
    :cond_2
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    int-to-byte v4, p2

    aput-byte v4, v2, v3

    move p2, v1

    goto :goto_5

    .line 1254
    :cond_3
    invoke-virtual {p0, p2, p1, v1, p3}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->outputMultiByteChar(I[CII)I

    move-result v1

    move p2, v1

    .line 1256
    .end local v0    # "charTypes":[I
    .end local v1    # "offset":I
    .local p2, "offset":I
    :goto_5
    goto :goto_0

    .line 1212
    .restart local v0    # "charTypes":[I
    .local v1, "ch":I
    :cond_4
    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-lt v2, v3, :cond_5

    .line 1213
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 1215
    :cond_5
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    int-to-byte v4, v1

    aput-byte v4, v2, v3

    .line 1216
    add-int/lit8 p2, p2, 0x1

    if-lt p2, p3, :cond_6

    .line 1217
    goto :goto_6

    .line 1219
    .end local v1    # "ch":I
    :cond_6
    goto :goto_1

    .line 1257
    .end local v0    # "charTypes":[I
    :cond_7
    :goto_6
    const/4 v0, -0x1

    return v0

    nop

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_3
        0x2 -> :sswitch_4
        0x3 -> :sswitch_4
        0x4 -> :sswitch_1
        0x5 -> :sswitch_2
        0xd -> :sswitch_0
    .end sparse-switch
.end method

.method protected final writeCommentEnd()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1485
    sget-object v0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->BYTES_COMMENT_END:[B

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw([B)V

    .line 1486
    return-void
.end method

.method protected final writeCommentStart()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1479
    sget-object v0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->BYTES_COMMENT_START:[B

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw([B)V

    .line 1480
    return-void
.end method

.method public writeDTD(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
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

    .line 1275
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

    .line 1265
    const/4 v0, 0x0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {p0, p1, v0, v1}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(Ljava/lang/String;II)V

    .line 1266
    return-void
.end method

.method public final writeEndTag(Lcom/fasterxml/aalto/out/WName;)V
    .locals 7
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 414
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_surrogate:I

    if-eqz v0, :cond_0

    .line 415
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->throwUnpairedSurrogate()V

    .line 417
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 418
    .local v0, "ptr":I
    invoke-virtual {p1}, Lcom/fasterxml/aalto/out/WName;->serializedLength()I

    move-result v1

    .line 419
    .local v1, "len":I
    add-int v2, v0, v1

    add-int/lit8 v2, v2, 0x3

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    const/16 v4, 0x3e

    const/16 v5, 0x2f

    const/16 v6, 0x3c

    if-le v2, v3, :cond_2

    .line 420
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 422
    add-int/lit8 v2, v1, 0x3

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-le v2, v3, :cond_1

    .line 423
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_out:Ljava/io/OutputStream;

    invoke-virtual {v2, v6}, Ljava/io/OutputStream;->write(I)V

    .line 424
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_out:Ljava/io/OutputStream;

    invoke-virtual {v2, v5}, Ljava/io/OutputStream;->write(I)V

    .line 425
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_out:Ljava/io/OutputStream;

    invoke-virtual {p1, v2}, Lcom/fasterxml/aalto/out/WName;->writeBytes(Ljava/io/OutputStream;)V

    .line 427
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/lit8 v5, v3, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    aput-byte v4, v2, v3

    .line 428
    return-void

    .line 430
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 432
    :cond_2
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    .line 433
    .local v2, "bbuf":[B
    add-int/lit8 v3, v0, 0x1

    .end local v0    # "ptr":I
    .local v3, "ptr":I
    aput-byte v6, v2, v0

    .line 434
    add-int/lit8 v0, v3, 0x1

    .end local v3    # "ptr":I
    .restart local v0    # "ptr":I
    aput-byte v5, v2, v3

    .line 435
    invoke-virtual {p1, v2, v0}, Lcom/fasterxml/aalto/out/WName;->appendBytes([BI)I

    move-result v3

    add-int/2addr v0, v3

    .line 436
    add-int/lit8 v3, v0, 0x1

    .end local v0    # "ptr":I
    .restart local v3    # "ptr":I
    aput-byte v4, v2, v0

    .line 437
    iput v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 438
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

    .line 1350
    const/16 v0, 0x26

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(B)V

    .line 1351
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeName(Lcom/fasterxml/aalto/out/WName;)V

    .line 1352
    const/16 v0, 0x3b

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(B)V

    .line 1353
    return-void
.end method

.method protected final writeLongAttribute(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;I)V
    .locals 8
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;
    .param p2, "value"    # Ljava/lang/String;
    .param p3, "vlen"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 626
    const/16 v0, 0x20

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(B)V

    .line 627
    invoke-virtual {p1}, Lcom/fasterxml/aalto/out/WName;->serializedLength()I

    move-result v0

    .line 628
    .local v0, "nlen":I
    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/2addr v1, v0

    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-le v1, v2, :cond_1

    .line 629
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 630
    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-le v0, v1, :cond_0

    .line 631
    iget-object v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_out:Ljava/io/OutputStream;

    invoke-virtual {p1, v1}, Lcom/fasterxml/aalto/out/WName;->writeBytes(Ljava/io/OutputStream;)V

    goto :goto_0

    .line 633
    :cond_0
    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    invoke-virtual {p1, v2, v3}, Lcom/fasterxml/aalto/out/WName;->appendBytes([BI)I

    move-result v2

    add-int/2addr v1, v2

    iput v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    goto :goto_0

    .line 636
    :cond_1
    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    invoke-virtual {p1, v2, v3}, Lcom/fasterxml/aalto/out/WName;->appendBytes([BI)I

    move-result v2

    add-int/2addr v1, v2

    iput v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 638
    :goto_0
    const/16 v1, 0x3d

    const/16 v2, 0x22

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(BB)V

    .line 639
    const/4 v1, 0x0

    .line 640
    .local v1, "offset":I
    :goto_1
    if-lez p3, :cond_3

    .line 641
    iget-object v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_copyBuffer:[C

    .line 642
    .local v3, "buf":[C
    array-length v4, v3

    .line 643
    .local v4, "blen":I
    if-ge p3, v4, :cond_2

    move v5, p3

    goto :goto_2

    :cond_2
    move v5, v4

    .line 644
    .local v5, "len2":I
    :goto_2
    add-int v6, v1, v5

    const/4 v7, 0x0

    invoke-virtual {p2, v1, v6, v3, v7}, Ljava/lang/String;->getChars(II[CI)V

    .line 645
    invoke-virtual {p0, v3, v7, v5}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeAttrValue([CII)V

    .line 646
    add-int/2addr v1, v5

    .line 647
    sub-int/2addr p3, v5

    .line 648
    .end local v3    # "buf":[C
    .end local v4    # "blen":I
    .end local v5    # "len2":I
    goto :goto_1

    .line 649
    :cond_3
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(B)V

    .line 650
    return-void
.end method

.method protected final writeName(BLcom/fasterxml/aalto/out/WName;)V
    .locals 4
    .param p1, "preChar"    # B
    .param p2, "name"    # Lcom/fasterxml/aalto/out/WName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 679
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 681
    invoke-virtual {p2}, Lcom/fasterxml/aalto/out/WName;->serializedLength()I

    move-result v0

    .line 682
    .local v0, "len":I
    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-lt v0, v1, :cond_0

    .line 683
    iget-object v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_out:Ljava/io/OutputStream;

    invoke-virtual {v1, p1}, Ljava/io/OutputStream;->write(I)V

    .line 684
    iget-object v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_out:Ljava/io/OutputStream;

    invoke-virtual {p2, v1}, Lcom/fasterxml/aalto/out/WName;->writeBytes(Ljava/io/OutputStream;)V

    .line 685
    return-void

    .line 687
    :cond_0
    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 688
    .local v1, "ptr":I
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    .line 689
    .local v2, "buf":[B
    add-int/lit8 v3, v1, 0x1

    .end local v1    # "ptr":I
    .local v3, "ptr":I
    aput-byte p1, v2, v1

    .line 690
    invoke-virtual {p2, v2, v3}, Lcom/fasterxml/aalto/out/WName;->appendBytes([BI)I

    move-result v1

    add-int/2addr v3, v1

    .line 691
    iput v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 692
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

    .line 661
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 662
    .local v0, "ptr":I
    invoke-virtual {p1}, Lcom/fasterxml/aalto/out/WName;->serializedLength()I

    move-result v1

    .line 663
    .local v1, "len":I
    add-int v2, v0, v1

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-le v2, v3, :cond_1

    .line 664
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 666
    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-lt v1, v2, :cond_0

    .line 667
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_out:Ljava/io/OutputStream;

    invoke-virtual {p1, v2}, Lcom/fasterxml/aalto/out/WName;->writeBytes(Ljava/io/OutputStream;)V

    .line 668
    return-void

    .line 670
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 672
    :cond_1
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    invoke-virtual {p1, v2, v0}, Lcom/fasterxml/aalto/out/WName;->appendBytes([BI)I

    move-result v2

    add-int/2addr v0, v2

    .line 673
    iput v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 674
    return-void
.end method

.method protected final writeName(Lcom/fasterxml/aalto/out/WName;B)V
    .locals 3
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;
    .param p2, "postChar"    # B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 697
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 699
    invoke-virtual {p1}, Lcom/fasterxml/aalto/out/WName;->serializedLength()I

    move-result v0

    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-lt v0, v1, :cond_0

    .line 700
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_out:Ljava/io/OutputStream;

    invoke-virtual {p1, v0}, Lcom/fasterxml/aalto/out/WName;->writeBytes(Ljava/io/OutputStream;)V

    .line 701
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_out:Ljava/io/OutputStream;

    invoke-virtual {v0, p2}, Ljava/io/OutputStream;->write(I)V

    .line 702
    return-void

    .line 704
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 705
    .local v0, "ptr":I
    iget-object v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    .line 706
    .local v1, "buf":[B
    invoke-virtual {p1, v1, v0}, Lcom/fasterxml/aalto/out/WName;->appendBytes([BI)I

    move-result v2

    add-int/2addr v0, v2

    .line 707
    add-int/lit8 v2, v0, 0x1

    .end local v0    # "ptr":I
    .local v2, "ptr":I
    aput-byte p2, v1, v0

    .line 708
    iput v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 709
    return-void
.end method

.method public writePI(Lcom/fasterxml/aalto/out/WName;Ljava/lang/String;)I
    .locals 7
    .param p1, "target"    # Lcom/fasterxml/aalto/out/WName;
    .param p2, "data"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1359
    const/16 v0, 0x3c

    const/16 v1, 0x3f

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(BB)V

    .line 1360
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeName(Lcom/fasterxml/aalto/out/WName;)V

    .line 1361
    if-eqz p2, :cond_2

    .line 1363
    const/16 v0, 0x20

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(B)V

    .line 1365
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    .line 1366
    .local v0, "len":I
    const/4 v2, 0x0

    .line 1367
    .local v2, "offset":I
    :goto_0
    if-lez v0, :cond_2

    .line 1368
    iget-object v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_copyBuffer:[C

    .line 1369
    .local v3, "buf":[C
    array-length v4, v3

    .line 1372
    .local v4, "blen":I
    if-le v4, v0, :cond_0

    .line 1373
    move v4, v0

    .line 1376
    :cond_0
    add-int v5, v2, v4

    const/4 v6, 0x0

    invoke-virtual {p2, v2, v5, v3, v6}, Ljava/lang/String;->getChars(II[CI)V

    .line 1377
    invoke-virtual {p0, v3, v6, v4}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writePIData([CII)I

    move-result v5

    .line 1378
    .local v5, "cix":I
    if-ltz v5, :cond_1

    .line 1379
    add-int v1, v2, v5

    return v1

    .line 1381
    :cond_1
    add-int/2addr v2, v4

    .line 1382
    sub-int/2addr v0, v4

    .line 1383
    .end local v3    # "buf":[C
    .end local v4    # "blen":I
    .end local v5    # "cix":I
    goto :goto_0

    .line 1385
    .end local v0    # "len":I
    .end local v2    # "offset":I
    :cond_2
    const/16 v0, 0x3e

    invoke-virtual {p0, v1, v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(BB)V

    .line 1386
    const/4 v0, -0x1

    return v0
.end method

.method protected writePIData([CII)I
    .locals 5
    .param p1, "cbuf"    # [C
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1286
    add-int/2addr p3, p2

    .line 1289
    :goto_0
    if-ge p2, p3, :cond_7

    .line 1290
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_charTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 1294
    .local v0, "charTypes":[I
    :goto_1
    aget-char v1, p1, p2

    .line 1295
    .local v1, "ch":I
    const/16 v2, 0x800

    if-lt v1, v2, :cond_0

    .line 1296
    goto :goto_2

    .line 1298
    :cond_0
    aget v3, v0, v1

    if-eqz v3, :cond_4

    .line 1299
    nop

    .line 1311
    .end local v1    # "ch":I
    :goto_2
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "offset":I
    .local v1, "offset":I
    aget-char p2, p1, p2

    .line 1312
    .local p2, "ch":I
    if-ge p2, v2, :cond_3

    .line 1313
    aget v2, v0, p2

    sparse-switch v2, :sswitch_data_0

    goto :goto_3

    .line 1328
    :sswitch_0
    if-ge v1, p3, :cond_1

    aget-char v2, p1, v1

    const/16 v3, 0x3e

    if-ne v2, v3, :cond_1

    .line 1329
    return v1

    .line 1321
    :sswitch_1
    const-string v2, "processing instruction"

    invoke-virtual {p0, v2, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportFailedEscaping(Ljava/lang/String;I)V

    .line 1324
    :sswitch_2
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->output2ByteChar(I)V

    .line 1325
    move p2, v1

    goto :goto_0

    .line 1315
    :sswitch_3
    invoke-virtual {p0, p2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportInvalidChar(I)V

    .line 1318
    :sswitch_4
    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_locRowNr:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_locRowNr:I

    .line 1319
    nop

    .line 1335
    :cond_1
    :goto_3
    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-lt v2, v3, :cond_2

    .line 1336
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 1338
    :cond_2
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    int-to-byte v4, p2

    aput-byte v4, v2, v3

    move p2, v1

    goto :goto_4

    .line 1340
    :cond_3
    invoke-virtual {p0, p2, p1, v1, p3}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->outputMultiByteChar(I[CII)I

    move-result v1

    move p2, v1

    .line 1342
    .end local v0    # "charTypes":[I
    .end local v1    # "offset":I
    .local p2, "offset":I
    :goto_4
    goto :goto_0

    .line 1301
    .restart local v0    # "charTypes":[I
    .local v1, "ch":I
    :cond_4
    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-lt v2, v3, :cond_5

    .line 1302
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 1304
    :cond_5
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    int-to-byte v4, v1

    aput-byte v4, v2, v3

    .line 1305
    add-int/lit8 p2, p2, 0x1

    if-lt p2, p3, :cond_6

    .line 1306
    goto :goto_5

    .line 1308
    .end local v1    # "ch":I
    :cond_6
    goto :goto_1

    .line 1343
    .end local v0    # "charTypes":[I
    :cond_7
    :goto_5
    const/4 v0, -0x1

    return v0

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_3
        0x2 -> :sswitch_4
        0x3 -> :sswitch_4
        0x4 -> :sswitch_1
        0x5 -> :sswitch_2
        0xc -> :sswitch_0
    .end sparse-switch
.end method

.method protected final writeRaw(B)V
    .locals 3
    .param p1, "b"    # B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1497
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_surrogate:I

    if-eqz v0, :cond_0

    .line 1498
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->throwUnpairedSurrogate()V

    .line 1500
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-lt v0, v1, :cond_1

    .line 1501
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 1503
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    aput-byte p1, v0, v1

    .line 1504
    return-void
.end method

.method protected final writeRaw(BB)V
    .locals 3
    .param p1, "b1"    # B
    .param p2, "b2"    # B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1509
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_surrogate:I

    if-eqz v0, :cond_0

    .line 1510
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->throwUnpairedSurrogate()V

    .line 1512
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/lit8 v0, v0, 0x1

    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-lt v0, v1, :cond_1

    .line 1513
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 1515
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    aput-byte p1, v0, v1

    .line 1516
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    aput-byte p2, v0, v1

    .line 1517
    return-void
.end method

.method public final writeRaw(Ljava/lang/String;II)V
    .locals 5
    .param p1, "text"    # Ljava/lang/String;
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 338
    nop

    :goto_0
    if-lez p3, :cond_1

    .line 339
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_copyBuffer:[C

    .line 340
    .local v0, "buf":[C
    array-length v1, v0

    .line 341
    .local v1, "blen":I
    if-ge p3, v1, :cond_0

    move v2, p3

    goto :goto_1

    :cond_0
    move v2, v1

    .line 342
    .local v2, "len2":I
    :goto_1
    add-int v3, p2, v2

    const/4 v4, 0x0

    invoke-virtual {p1, p2, v3, v0, v4}, Ljava/lang/String;->getChars(II[CI)V

    .line 343
    invoke-virtual {p0, v0, v4, v2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw([CII)V

    .line 344
    add-int/2addr p2, v2

    .line 345
    sub-int/2addr p3, v2

    .line 346
    .end local v0    # "buf":[C
    .end local v1    # "blen":I
    .end local v2    # "len2":I
    goto :goto_0

    .line 347
    :cond_1
    return-void
.end method

.method protected final writeRaw([B)V
    .locals 2
    .param p1, "buf"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1522
    const/4 v0, 0x0

    array-length v1, p1

    invoke-virtual {p0, p1, v0, v1}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw([BII)V

    .line 1523
    return-void
.end method

.method protected final writeRaw([BII)V
    .locals 3
    .param p1, "buf"    # [B
    .param p2, "offset"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1528
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_surrogate:I

    if-eqz v0, :cond_0

    .line 1529
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->throwUnpairedSurrogate()V

    .line 1532
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 1534
    .local v0, "ptr":I
    add-int v1, v0, p3

    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-gt v1, v2, :cond_1

    .line 1535
    iget-object v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    invoke-static {p1, p2, v1, v0, p3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1536
    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/2addr v1, p3

    iput v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 1537
    return-void

    .line 1541
    :cond_1
    if-lez v0, :cond_2

    .line 1542
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flush()V

    .line 1543
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 1545
    :cond_2
    const/16 v1, 0xfa

    if-ge p3, v1, :cond_3

    .line 1546
    iget-object v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    invoke-static {p1, p2, v1, v0, p3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1547
    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/2addr v1, p3

    iput v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    goto :goto_0

    .line 1549
    :cond_3
    iget-object v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_out:Ljava/io/OutputStream;

    invoke-virtual {v1, p1, p2, p3}, Ljava/io/OutputStream;->write([BII)V

    .line 1551
    :goto_0
    return-void
.end method

.method public abstract writeRaw([CII)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public final writeSpace(Ljava/lang/String;)V
    .locals 7
    .param p1, "data"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1393
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 1394
    .local v0, "len":I
    const/4 v1, 0x0

    .line 1396
    .local v1, "offset":I
    :goto_0
    if-lez v0, :cond_1

    .line 1397
    iget-object v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_copyBuffer:[C

    .line 1398
    .local v2, "buf":[C
    array-length v3, v2

    .line 1399
    .local v3, "blen":I
    if-ge v0, v3, :cond_0

    move v4, v0

    goto :goto_1

    :cond_0
    move v4, v3

    .line 1400
    .local v4, "len2":I
    :goto_1
    add-int v5, v1, v4

    const/4 v6, 0x0

    invoke-virtual {p1, v1, v5, v2, v6}, Ljava/lang/String;->getChars(II[CI)V

    .line 1401
    invoke-virtual {p0, v2, v6, v4}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeSpace([CII)V

    .line 1402
    add-int/2addr v1, v4

    .line 1403
    sub-int/2addr v0, v4

    .line 1404
    .end local v2    # "buf":[C
    .end local v3    # "blen":I
    .end local v4    # "len2":I
    goto :goto_0

    .line 1405
    :cond_1
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

    .line 1411
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_out:Ljava/io/OutputStream;

    if-nez v0, :cond_0

    .line 1412
    return-void

    .line 1414
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_surrogate:I

    if-eqz v0, :cond_1

    .line 1415
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_SPACE_CONTENT:Ljava/lang/String;

    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_surrogate:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    add-int/lit8 v2, p2, -0x1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {p0, v0, v1, v2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportNwfContent(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 1418
    :cond_1
    add-int/2addr p3, p2

    .line 1419
    :goto_0
    if-ge p2, p3, :cond_5

    .line 1420
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "offset":I
    .local v0, "offset":I
    aget-char p2, p1, p2

    .line 1421
    .local p2, "ch":C
    const/16 v1, 0x20

    if-le p2, v1, :cond_3

    .line 1422
    iget-object v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_config:Lcom/fasterxml/aalto/out/WriterConfig;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/out/WriterConfig;->isXml11()Z

    move-result v1

    if-eqz v1, :cond_2

    const/16 v1, 0x85

    if-eq p2, v1, :cond_3

    const/16 v1, 0x2028

    if-eq p2, v1, :cond_3

    .line 1423
    :cond_2
    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_SPACE_CONTENT:Ljava/lang/String;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    add-int/lit8 v3, v0, -0x1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {p0, v1, v2, v3}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->reportNwfContent(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 1426
    :cond_3
    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-lt v1, v2, :cond_4

    .line 1427
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 1430
    :cond_4
    iget-object v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    int-to-byte v3, p2

    aput-byte v3, v1, v2

    .line 1431
    .end local p2    # "ch":C
    move p2, v0

    goto :goto_0

    .line 1432
    .end local v0    # "offset":I
    .local p2, "offset":I
    :cond_5
    return-void
.end method

.method public writeStartTagEmptyEnd()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 399
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 400
    .local v0, "ptr":I
    add-int/lit8 v1, v0, 0x2

    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-le v1, v2, :cond_0

    .line 401
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 402
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 404
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    .line 405
    .local v1, "bbuf":[B
    add-int/lit8 v2, v0, 0x1

    .end local v0    # "ptr":I
    .local v2, "ptr":I
    const/16 v3, 0x2f

    aput-byte v3, v1, v0

    .line 406
    add-int/lit8 v0, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v0    # "ptr":I
    const/16 v3, 0x3e

    aput-byte v3, v1, v2

    .line 407
    iput v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 408
    return-void
.end method

.method public final writeStartTagEnd()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 386
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_surrogate:I

    if-eqz v0, :cond_0

    .line 387
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->throwUnpairedSurrogate()V

    .line 389
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    if-lt v0, v1, :cond_1

    .line 390
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    .line 392
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    const/16 v2, 0x3e

    aput-byte v2, v0, v1

    .line 393
    return-void
.end method

.method public final writeStartTagStart(Lcom/fasterxml/aalto/out/WName;)V
    .locals 4
    .param p1, "name"    # Lcom/fasterxml/aalto/out/WName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 367
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_surrogate:I

    if-eqz v0, :cond_0

    .line 368
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->throwUnpairedSurrogate()V

    .line 370
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 371
    .local v0, "ptr":I
    invoke-virtual {p1}, Lcom/fasterxml/aalto/out/WName;->serializedLength()I

    move-result v1

    add-int/2addr v1, v0

    add-int/lit8 v1, v1, 0x1

    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    const/16 v3, 0x3c

    if-le v1, v2, :cond_1

    .line 372
    invoke-virtual {p0, v3, p1}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeName(BLcom/fasterxml/aalto/out/WName;)V

    .line 373
    return-void

    .line 375
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    .line 376
    .local v1, "bbuf":[B
    add-int/lit8 v2, v0, 0x1

    .end local v0    # "ptr":I
    .local v2, "ptr":I
    aput-byte v3, v1, v0

    .line 377
    invoke-virtual {p1, v1, v2}, Lcom/fasterxml/aalto/out/WName;->appendBytes([BI)I

    move-result v0

    add-int/2addr v2, v0

    .line 378
    iput v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 379
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

    .line 1103
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_surrogate:I

    if-eqz v0, :cond_0

    .line 1104
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->throwUnpairedSurrogate()V

    .line 1106
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    iget v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    sub-int/2addr v0, v1

    .line 1107
    .local v0, "free":I
    invoke-virtual {p1, v0}, Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;->bufferNeedsFlush(I)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 1108
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flush()V

    .line 1111
    :cond_1
    :goto_0
    iget-object v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBuffer:[B

    iget v2, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputBufferLen:I

    invoke-virtual {p1, v1, v2, v3}, Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;->encodeMore([BII)I

    move-result v1

    iput v1, p0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->_outputPtr:I

    .line 1112
    invoke-virtual {p1}, Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;->isCompleted()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 1113
    nop

    .line 1117
    return-void

    .line 1115
    :cond_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->flushBuffer()V

    goto :goto_0
.end method

.method public writeXmlDeclaration(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "version"    # Ljava/lang/String;
    .param p2, "encoding"    # Ljava/lang/String;
    .param p3, "standalone"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1438
    sget-object v0, Lcom/fasterxml/aalto/out/ByteXmlWriter;->BYTES_XMLDECL_START:[B

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw([B)V

    .line 1440
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(Ljava/lang/String;II)V

    .line 1441
    const/16 v0, 0x27

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(B)V

    .line 1443
    if-eqz p2, :cond_0

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_0

    .line 1444
    sget-object v2, Lcom/fasterxml/aalto/out/ByteXmlWriter;->BYTES_XMLDECL_ENCODING:[B

    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw([B)V

    .line 1446
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {p0, p2, v1, v2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(Ljava/lang/String;II)V

    .line 1447
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(B)V

    .line 1449
    :cond_0
    if-eqz p3, :cond_1

    .line 1450
    sget-object v2, Lcom/fasterxml/aalto/out/ByteXmlWriter;->BYTES_XMLDECL_STANDALONE:[B

    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw([B)V

    .line 1452
    invoke-virtual {p3}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {p0, p3, v1, v2}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(Ljava/lang/String;II)V

    .line 1453
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(B)V

    .line 1455
    :cond_1
    const/16 v0, 0x3f

    const/16 v1, 0x3e

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/out/ByteXmlWriter;->writeRaw(BB)V

    .line 1456
    return-void
.end method
