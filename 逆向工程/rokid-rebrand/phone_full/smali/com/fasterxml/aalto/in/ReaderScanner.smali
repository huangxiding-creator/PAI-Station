.class public final Lcom/fasterxml/aalto/in/ReaderScanner;
.super Lcom/fasterxml/aalto/in/XmlScanner;
.source "ReaderScanner.java"


# static fields
.field private static final sCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;


# instance fields
.field protected _in:Ljava/io/Reader;

.field protected _inputBuffer:[C

.field protected _inputEnd:I

.field protected _inputPtr:I

.field protected final _symbols:Lcom/fasterxml/aalto/in/CharBasedPNameTable;

.field protected mTmpChar:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 32
    invoke-static {}, Lcom/fasterxml/aalto/in/InputCharTypes;->getLatin1CharTypes()Lcom/fasterxml/aalto/util/XmlCharTypes;

    move-result-object v0

    sput-object v0, Lcom/fasterxml/aalto/in/ReaderScanner;->sCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    return-void
.end method

.method public constructor <init>(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/Reader;)V
    .locals 3
    .param p1, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;
    .param p2, "r"    # Ljava/io/Reader;

    .line 97
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V

    .line 61
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->mTmpChar:I

    .line 98
    iput-object p2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_in:Ljava/io/Reader;

    .line 99
    const/16 v1, 0xfa0

    invoke-virtual {p1, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->allocFullCBuffer(I)[C

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    .line 100
    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 101
    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_pastBytesOrChars:J

    .line 102
    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_rowStartOffset:I

    .line 104
    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/ReaderConfig;->getCBSymbols()Lcom/fasterxml/aalto/in/CharBasedPNameTable;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_symbols:Lcom/fasterxml/aalto/in/CharBasedPNameTable;

    .line 105
    return-void
.end method

.method public constructor <init>(Lcom/fasterxml/aalto/in/ReaderConfig;Ljava/io/Reader;[CII)V
    .locals 3
    .param p1, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;
    .param p2, "r"    # Ljava/io/Reader;
    .param p3, "buffer"    # [C
    .param p4, "ptr"    # I
    .param p5, "last"    # I

    .line 84
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V

    .line 61
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->mTmpChar:I

    .line 85
    iput-object p2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_in:Ljava/io/Reader;

    .line 86
    iput-object p3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    .line 87
    iput p4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 88
    iput p5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    .line 89
    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_pastBytesOrChars:J

    .line 90
    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_rowStartOffset:I

    .line 92
    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/ReaderConfig;->getCBSymbols()Lcom/fasterxml/aalto/in/CharBasedPNameTable;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_symbols:Lcom/fasterxml/aalto/in/CharBasedPNameTable;

    .line 93
    return-void
.end method

.method private checkSurrogate(C)C
    .locals 4
    .param p1, "firstChar"    # C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3188
    const v0, 0xdc00

    if-lt p1, v0, :cond_0

    .line 3189
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInvalidFirstSurrogate(C)V

    .line 3191
    :cond_0
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v1, v2, :cond_1

    .line 3192
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 3194
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v1, v1, v2

    .line 3195
    .local v1, "sec":C
    if-lt v1, v0, :cond_2

    const v0, 0xe000

    if-lt v1, v0, :cond_3

    .line 3196
    :cond_2
    invoke-direct {p0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInvalidSecondSurrogate(C)V

    .line 3199
    :cond_3
    const v0, 0xd800

    sub-int v0, p1, v0

    shl-int/lit8 v0, v0, 0xa

    const/high16 v2, 0x10000

    add-int/2addr v0, v2

    .line 3200
    .local v0, "val":I
    const v2, 0x10ffff

    if-le v0, v2, :cond_4

    .line 3201
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInvalidXmlChar(I)V

    .line 3203
    :cond_4
    return v1
.end method

.method private checkSurrogateNameChar(CCI)I
    .locals 2
    .param p1, "firstChar"    # C
    .param p2, "sec"    # C
    .param p3, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3209
    const v0, 0xdc00

    if-lt p1, v0, :cond_0

    .line 3210
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInvalidFirstSurrogate(C)V

    .line 3212
    :cond_0
    if-lt p2, v0, :cond_1

    const v0, 0xe000

    if-lt p2, v0, :cond_2

    .line 3213
    :cond_1
    invoke-direct {p0, p2}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInvalidSecondSurrogate(C)V

    .line 3216
    :cond_2
    const v0, 0xd800

    sub-int v0, p1, v0

    shl-int/lit8 v0, v0, 0xa

    const/high16 v1, 0x10000

    add-int/2addr v0, v1

    .line 3217
    .local v0, "val":I
    const v1, 0x10ffff

    if-le v0, v1, :cond_3

    .line 3218
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInvalidXmlChar(I)V

    .line 3222
    :cond_3
    invoke-virtual {p0, v0, p3}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInvalidNameChar(II)V

    .line 3224
    return v0
.end method

.method private collectValue(ICLcom/fasterxml/aalto/in/PName;)I
    .locals 8
    .param p1, "attrPtr"    # I
    .param p2, "quoteChar"    # C
    .param p3, "attrName"    # Lcom/fasterxml/aalto/in/PName;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 836
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v0, p3, p1}, Lcom/fasterxml/aalto/in/AttributeCollector;->startNewValue(Lcom/fasterxml/aalto/in/PName;I)[C

    move-result-object v0

    .line 837
    .local v0, "attrBuffer":[C
    sget-object v1, Lcom/fasterxml/aalto/in/ReaderScanner;->sCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v1, v1, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    .line 845
    .local v1, "TYPES":[I
    :goto_0
    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 846
    .local v2, "ptr":I
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v2, v3, :cond_0

    .line 847
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 848
    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 850
    :cond_0
    array-length v3, v0

    if-lt p1, v3, :cond_1

    .line 851
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/AttributeCollector;->valueBufferFull()[C

    move-result-object v0

    .line 853
    :cond_1
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    .line 855
    .local v3, "max":I
    array-length v4, v0

    sub-int/2addr v4, p1

    add-int/2addr v4, v2

    .line 856
    .local v4, "max2":I
    if-ge v4, v3, :cond_2

    .line 857
    move v3, v4

    .line 860
    .end local v4    # "max2":I
    :cond_2
    :goto_1
    if-ge v2, v3, :cond_f

    .line 861
    iget-object v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    add-int/lit8 v5, v2, 0x1

    .end local v2    # "ptr":I
    .local v5, "ptr":I
    aget-char v2, v4, v2

    .line 862
    .local v2, "c":C
    const/16 v4, 0xff

    const v6, 0xd800

    if-gt v2, v4, :cond_3

    .line 863
    aget v7, v1, v2

    if-eqz v7, :cond_e

    .line 864
    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 865
    goto :goto_2

    .line 867
    :cond_3
    if-lt v2, v6, :cond_e

    .line 868
    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 869
    nop

    .line 876
    .end local v3    # "max":I
    .end local v5    # "ptr":I
    :goto_2
    if-gt v2, v4, :cond_a

    .line 877
    aget v3, v1, v2

    sparse-switch v3, :sswitch_data_0

    goto :goto_4

    .line 918
    :sswitch_0
    if-ne v2, p2, :cond_9

    .line 919
    nop

    .line 943
    .end local v2    # "c":C
    return p1

    .line 896
    .restart local v2    # "c":C
    :sswitch_1
    const-string v3, "\'<\' not allowed in attribute value"

    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/aalto/in/ReaderScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 899
    :sswitch_2
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/ReaderConfig;->willRetainAttributeGeneralEntities()Z

    move-result v3

    if-nez v3, :cond_9

    .line 900
    const/4 v3, 0x0

    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleEntityInText(Z)I

    move-result v4

    .line 901
    .local v4, "d":I
    if-nez v4, :cond_4

    .line 902
    invoke-virtual {p0, p3, v3}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportUnexpandedEntityInAttr(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 905
    :cond_4
    shr-int/lit8 v3, v4, 0x10

    if-eqz v3, :cond_6

    .line 906
    const/high16 v3, 0x10000

    sub-int/2addr v4, v3

    .line 907
    add-int/lit8 v3, p1, 0x1

    .end local p1    # "attrPtr":I
    .local v3, "attrPtr":I
    shr-int/lit8 v5, v4, 0xa

    or-int/2addr v5, v6

    int-to-char v5, v5

    aput-char v5, v0, p1

    .line 908
    and-int/lit16 p1, v4, 0x3ff

    const v5, 0xdc00

    or-int v4, p1, v5

    .line 909
    array-length p1, v0

    if-lt v3, p1, :cond_5

    .line 910
    iget-object p1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/AttributeCollector;->valueBufferFull()[C

    move-result-object p1

    move-object v0, p1

    move p1, v3

    .end local v0    # "attrBuffer":[C
    .local p1, "attrBuffer":[C
    goto :goto_3

    .line 909
    .end local p1    # "attrBuffer":[C
    .restart local v0    # "attrBuffer":[C
    :cond_5
    move p1, v3

    .line 913
    .end local v3    # "attrPtr":I
    .local p1, "attrPtr":I
    :cond_6
    :goto_3
    int-to-char v2, v4

    .line 914
    .end local v4    # "d":I
    goto :goto_4

    .line 879
    :sswitch_3
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    move-result v2

    .line 881
    :sswitch_4
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v3, v4, :cond_7

    .line 882
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 884
    :cond_7
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v3, v3, v4

    const/16 v4, 0xa

    if-ne v3, v4, :cond_8

    .line 885
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 889
    :cond_8
    :sswitch_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 893
    :sswitch_6
    const/16 v2, 0x20

    .line 894
    nop

    .line 919
    :cond_9
    :goto_4
    goto :goto_5

    .line 925
    :cond_a
    if-lt v2, v6, :cond_d

    .line 926
    const v3, 0xe000

    if-ge v2, v3, :cond_c

    .line 928
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->checkSurrogate(C)C

    move-result v3

    .line 929
    .local v3, "d":C
    add-int/lit8 v4, p1, 0x1

    .end local p1    # "attrPtr":I
    .local v4, "attrPtr":I
    aput-char v2, v0, p1

    .line 931
    array-length p1, v0

    if-lt v4, p1, :cond_b

    .line 932
    iget-object p1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/AttributeCollector;->valueBufferFull()[C

    move-result-object v0

    .line 934
    :cond_b
    move v2, v3

    .line 935
    .end local v3    # "d":C
    move p1, v4

    goto :goto_5

    .end local v4    # "attrPtr":I
    .restart local p1    # "attrPtr":I
    :cond_c
    const v3, 0xfffe

    if-lt v2, v3, :cond_d

    .line 936
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    move-result v2

    .line 940
    :cond_d
    :goto_5
    add-int/lit8 v3, p1, 0x1

    .end local p1    # "attrPtr":I
    .local v3, "attrPtr":I
    aput-char v2, v0, p1

    .line 941
    .end local v2    # "c":C
    move p1, v3

    goto/16 :goto_0

    .line 871
    .restart local v2    # "c":C
    .local v3, "max":I
    .restart local v5    # "ptr":I
    .restart local p1    # "attrPtr":I
    :cond_e
    add-int/lit8 v4, p1, 0x1

    .end local p1    # "attrPtr":I
    .restart local v4    # "attrPtr":I
    aput-char v2, v0, p1

    move p1, v4

    move v2, v5

    goto/16 :goto_1

    .line 873
    .end local v4    # "attrPtr":I
    .end local v5    # "ptr":I
    .local v2, "ptr":I
    .restart local p1    # "attrPtr":I
    :cond_f
    iput v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 874
    .end local v2    # "ptr":I
    .end local v3    # "max":I
    goto/16 :goto_0

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_3
        0x2 -> :sswitch_4
        0x3 -> :sswitch_5
        0x8 -> :sswitch_6
        0x9 -> :sswitch_1
        0xa -> :sswitch_2
        0xe -> :sswitch_0
    .end sparse-switch
.end method

.method private decodeSurrogate(C)I
    .locals 4
    .param p1, "firstChar"    # C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3236
    const v0, 0xdc00

    if-lt p1, v0, :cond_0

    .line 3237
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInvalidFirstSurrogate(C)V

    .line 3239
    :cond_0
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v1, v2, :cond_1

    .line 3240
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 3242
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v1, v1, v2

    .line 3243
    .local v1, "sec":C
    if-lt v1, v0, :cond_2

    const v0, 0xe000

    if-lt v1, v0, :cond_3

    .line 3244
    :cond_2
    invoke-direct {p0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInvalidSecondSurrogate(C)V

    .line 3247
    :cond_3
    const v0, 0xd800

    sub-int v0, p1, v0

    shl-int/lit8 v0, v0, 0xa

    const/high16 v2, 0x10000

    add-int/2addr v0, v2

    .line 3248
    .local v0, "val":I
    const v2, 0x10ffff

    if-le v0, v2, :cond_4

    .line 3249
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInvalidXmlChar(I)V

    .line 3251
    :cond_4
    return v0
.end method

.method private final handleDtdStart()I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 390
    const-string v0, "DOCTYPE"

    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->matchAsciiKeyword(Ljava/lang/String;)V

    .line 392
    const-string v0, "after DOCTYPE keyword, before root name"

    const/4 v1, 0x1

    invoke-virtual {p0, v1, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->skipInternalWs(ZLjava/lang/String;)C

    move-result v0

    .line 393
    .local v0, "c":C
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->parsePName(C)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    iput-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 394
    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/aalto/in/ReaderScanner;->skipInternalWs(ZLjava/lang/String;)C

    move-result v0

    .line 398
    const/16 v4, 0x50

    if-ne v0, v4, :cond_0

    .line 399
    const-string v4, "PUBLIC"

    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->matchAsciiKeyword(Ljava/lang/String;)V

    .line 400
    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/in/ReaderScanner;->skipInternalWs(ZLjava/lang/String;)C

    move-result v0

    .line 401
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->parsePublicId(C)Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_publicId:Ljava/lang/String;

    .line 402
    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/in/ReaderScanner;->skipInternalWs(ZLjava/lang/String;)C

    move-result v0

    .line 403
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->parseSystemId(C)Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_systemId:Ljava/lang/String;

    .line 404
    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/aalto/in/ReaderScanner;->skipInternalWs(ZLjava/lang/String;)C

    move-result v0

    goto :goto_0

    .line 405
    :cond_0
    const/16 v4, 0x53

    if-ne v0, v4, :cond_1

    .line 406
    const-string v4, "SYSTEM"

    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->matchAsciiKeyword(Ljava/lang/String;)V

    .line 407
    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/aalto/in/ReaderScanner;->skipInternalWs(ZLjava/lang/String;)C

    move-result v0

    .line 408
    iput-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_publicId:Ljava/lang/String;

    .line 409
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->parseSystemId(C)Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_systemId:Ljava/lang/String;

    .line 410
    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/aalto/in/ReaderScanner;->skipInternalWs(ZLjava/lang/String;)C

    move-result v0

    goto :goto_0

    .line 412
    :cond_1
    iput-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_systemId:Ljava/lang/String;

    iput-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_publicId:Ljava/lang/String;

    .line 418
    :goto_0
    const/16 v3, 0x3e

    const/16 v4, 0xb

    if-ne v0, v3, :cond_2

    .line 419
    iput-boolean v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenIncomplete:Z

    .line 420
    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currToken:I

    return v4

    .line 423
    :cond_2
    const/16 v2, 0x5b

    if-eq v0, v2, :cond_4

    .line 424
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_systemId:Ljava/lang/String;

    if-eqz v2, :cond_3

    const-string v2, " (expected \'[\' for the internal subset, or \'>\' to end DOCTYPE declaration)"

    goto :goto_1

    :cond_3
    const-string v2, " (expected a \'PUBLIC\' or \'SYSTEM\' keyword, \'[\' for the internal subset, or \'>\' to end DOCTYPE declaration)"

    .line 427
    .local v2, "msg":Ljava/lang/String;
    :goto_1
    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 433
    .end local v2    # "msg":Ljava/lang/String;
    :cond_4
    iput-boolean v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenIncomplete:Z

    .line 434
    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currToken:I

    return v4
.end method

.method private handleNsDeclaration(Lcom/fasterxml/aalto/in/PName;C)V
    .locals 7
    .param p1, "name"    # Lcom/fasterxml/aalto/in/PName;
    .param p2, "quoteChar"    # C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 953
    const/4 v0, 0x0

    .line 954
    .local v0, "attrPtr":I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_nameBuffer:[C

    .line 957
    .local v1, "attrBuffer":[C
    :goto_0
    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v2, v3, :cond_0

    .line 958
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 960
    :cond_0
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v2, v2, v3

    .line 961
    .local v2, "c":C
    if-ne v2, p2, :cond_2

    .line 962
    nop

    .line 1009
    .end local v2    # "c":C
    if-nez v0, :cond_1

    .line 1010
    const-string v2, ""

    invoke-virtual {p0, p1, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->bindNs(Lcom/fasterxml/aalto/in/PName;Ljava/lang/String;)V

    goto :goto_1

    .line 1012
    :cond_1
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v2, v1, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->canonicalizeURI([CI)Ljava/lang/String;

    move-result-object v2

    .line 1013
    .local v2, "uri":Ljava/lang/String;
    invoke-virtual {p0, p1, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->bindNs(Lcom/fasterxml/aalto/in/PName;Ljava/lang/String;)V

    .line 1015
    .end local v2    # "uri":Ljava/lang/String;
    :goto_1
    return-void

    .line 964
    .local v2, "c":C
    :cond_2
    const/16 v3, 0x26

    const/4 v4, 0x1

    if-ne v2, v3, :cond_6

    .line 965
    const/4 v3, 0x0

    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleEntityInText(Z)I

    move-result v3

    .line 966
    .local v3, "d":I
    if-nez v3, :cond_3

    .line 967
    invoke-virtual {p0, p1, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportUnexpandedEntityInAttr(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 970
    :cond_3
    shr-int/lit8 v4, v3, 0x10

    if-eqz v4, :cond_5

    .line 971
    array-length v4, v1

    if-lt v0, v4, :cond_4

    .line 972
    array-length v4, v1

    invoke-static {v1, v4}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v4

    move-object v1, v4

    iput-object v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_nameBuffer:[C

    .line 974
    :cond_4
    const/high16 v4, 0x10000

    sub-int/2addr v3, v4

    .line 975
    add-int/lit8 v4, v0, 0x1

    .end local v0    # "attrPtr":I
    .local v4, "attrPtr":I
    shr-int/lit8 v5, v3, 0xa

    const v6, 0xd800

    or-int/2addr v5, v6

    int-to-char v5, v5

    aput-char v5, v1, v0

    .line 976
    and-int/lit16 v0, v3, 0x3ff

    const v5, 0xdc00

    or-int v3, v0, v5

    move v0, v4

    .line 978
    .end local v4    # "attrPtr":I
    .restart local v0    # "attrPtr":I
    :cond_5
    int-to-char v2, v3

    .line 979
    .end local v3    # "d":I
    goto :goto_2

    :cond_6
    const/16 v3, 0x3c

    if-ne v2, v3, :cond_7

    .line 980
    const-string v3, "\'<\' not allowed in attribute value"

    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/aalto/in/ReaderScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    goto :goto_2

    .line 982
    :cond_7
    const/16 v3, 0x20

    if-ge v2, v3, :cond_c

    .line 983
    const/16 v3, 0xa

    if-ne v2, v3, :cond_8

    .line 984
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    goto :goto_2

    .line 985
    :cond_8
    const/16 v5, 0xd

    if-ne v2, v5, :cond_b

    .line 986
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v5, v6, :cond_9

    .line 987
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 989
    :cond_9
    iget-object v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v5, v5, v6

    if-ne v5, v3, :cond_a

    .line 990
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v3, v4

    iput v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 992
    :cond_a
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 993
    const/16 v2, 0xa

    goto :goto_2

    .line 994
    :cond_b
    const/16 v3, 0x9

    if-eq v2, v3, :cond_c

    .line 995
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->throwInvalidSpace(I)V

    .line 999
    :cond_c
    :goto_2
    array-length v3, v1

    if-lt v0, v3, :cond_d

    .line 1000
    array-length v3, v1

    invoke-static {v1, v3}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v3

    move-object v1, v3

    iput-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_nameBuffer:[C

    .line 1002
    :cond_d
    add-int/lit8 v3, v0, 0x1

    .end local v0    # "attrPtr":I
    .local v3, "attrPtr":I
    aput-char v2, v1, v0

    .line 1003
    .end local v2    # "c":C
    move v0, v3

    goto/16 :goto_0
.end method

.method private final matchAsciiKeyword(Ljava/lang/String;)V
    .locals 5
    .param p1, "keyw"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2839
    const/4 v0, 0x1

    .local v0, "i":I
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    .local v1, "len":I
    :goto_0
    if-ge v0, v1, :cond_2

    .line 2840
    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v2, v3, :cond_0

    .line 2841
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2843
    :cond_0
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v2, v2, v3

    .line 2844
    .local v2, "c":C
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    if-eq v2, v3, :cond_1

    .line 2845
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, " (expected \'"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "\' for "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " keyword)"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 2839
    .end local v2    # "c":C
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 2848
    .end local v0    # "i":I
    .end local v1    # "len":I
    :cond_2
    return-void
.end method

.method private reportInvalidFirstSurrogate(C)V
    .locals 2
    .param p1, "ch"    # C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3257
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Invalid surrogate character (code 0x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "): can not start a surrogate pair"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 3258
    return-void
.end method

.method private reportInvalidSecondSurrogate(C)V
    .locals 2
    .param p1, "ch"    # C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3263
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Invalid surrogate character (code "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "): is not legal as the second part of a surrogate pair"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 3264
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

    .line 131
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_in:Ljava/io/Reader;

    if-eqz v0, :cond_0

    .line 132
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_in:Ljava/io/Reader;

    invoke-virtual {v0}, Ljava/io/Reader;->close()V

    .line 133
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_in:Ljava/io/Reader;

    .line 135
    :cond_0
    return-void
.end method

.method protected _nextEntity()I
    .locals 1

    .line 334
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    .line 336
    const/16 v0, 0x9

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currToken:I

    return v0
.end method

.method protected _releaseBuffers()V
    .locals 2

    .line 110
    invoke-super {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->_releaseBuffers()V

    .line 111
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_symbols:Lcom/fasterxml/aalto/in/CharBasedPNameTable;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->maybeDirty()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 112
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_symbols:Lcom/fasterxml/aalto/in/CharBasedPNameTable;

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->updateCBSymbols(Lcom/fasterxml/aalto/in/CharBasedPNameTable;)V

    .line 120
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_in:Ljava/io/Reader;

    if-eqz v0, :cond_1

    .line 121
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    if-eqz v0, :cond_1

    .line 122
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->freeFullCBuffer([C)V

    .line 123
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    .line 126
    :cond_1
    return-void
.end method

.method protected final addPName([CII)Lcom/fasterxml/aalto/in/PName;
    .locals 7
    .param p1, "nameBuffer"    # [C
    .param p2, "nameLen"    # I
    .param p3, "hash"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3039
    const/4 v0, 0x0

    aget-char v1, p1, v0

    .line 3040
    .local v1, "c":C
    const/4 v2, 0x1

    .line 3041
    .local v2, "namePtr":I
    const/4 v3, -0x1

    .line 3043
    .local v3, "last_colon":I
    const v4, 0xe000

    const v5, 0xd800

    if-lt v1, v5, :cond_2

    if-lt v1, v4, :cond_0

    goto :goto_0

    .line 3048
    :cond_0
    const/4 v6, 0x1

    if-ne p2, v6, :cond_1

    .line 3049
    invoke-direct {p0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInvalidFirstSurrogate(C)V

    .line 3052
    :cond_1
    aget-char v6, p1, v6

    invoke-direct {p0, v1, v6, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->checkSurrogateNameChar(CCI)I

    .line 3053
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 3044
    :cond_2
    :goto_0
    invoke-static {v1}, Lcom/fasterxml/aalto/util/XmlChars;->is10NameStartChar(I)Z

    move-result v6

    if-nez v6, :cond_3

    .line 3045
    invoke-virtual {p0, v1, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInvalidNameChar(II)V

    .line 3056
    :cond_3
    :goto_1
    if-ge v2, p2, :cond_a

    .line 3057
    aget-char v1, p1, v2

    .line 3059
    if-lt v1, v5, :cond_6

    if-lt v1, v4, :cond_4

    goto :goto_2

    .line 3071
    :cond_4
    add-int/lit8 v6, v2, 0x1

    if-lt v6, p2, :cond_5

    .line 3072
    invoke-direct {p0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInvalidFirstSurrogate(C)V

    .line 3074
    :cond_5
    add-int/lit8 v6, v2, 0x1

    aget-char v6, p1, v6

    invoke-direct {p0, v1, v6, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->checkSurrogateNameChar(CCI)I

    goto :goto_3

    .line 3060
    :cond_6
    :goto_2
    const/16 v6, 0x3a

    if-ne v1, v6, :cond_8

    .line 3061
    if-ltz v3, :cond_7

    .line 3062
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportMultipleColonsInName()V

    .line 3064
    :cond_7
    move v3, v2

    goto :goto_3

    .line 3066
    :cond_8
    invoke-static {v1}, Lcom/fasterxml/aalto/util/XmlChars;->is10NameChar(I)Z

    move-result v6

    if-nez v6, :cond_9

    .line 3067
    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInvalidNameChar(II)V

    .line 3056
    :cond_9
    :goto_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 3077
    :cond_a
    iget-object v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_symbols:Lcom/fasterxml/aalto/in/CharBasedPNameTable;

    invoke-virtual {v4, p1, v0, p2, p3}, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->addSymbol([CIII)Lcom/fasterxml/aalto/in/PNameC;

    move-result-object v0

    return-object v0
.end method

.method protected final checkInTreeIndentation(C)I
    .locals 10
    .param p1, "c"    # C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2865
    const/16 v0, 0xd

    const/4 v1, -0x1

    const/16 v2, 0xa

    const/4 v3, 0x0

    const/16 v4, 0x20

    const/4 v5, 0x1

    if-ne p1, v0, :cond_1

    .line 2867
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v0, v6, :cond_0

    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_0

    .line 2868
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0, v3, v4}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithIndentation(IC)V

    .line 2869
    return v1

    .line 2871
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v0, v6

    if-ne v0, v2, :cond_1

    .line 2872
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v0, v5

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2875
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 2877
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v0, v6, :cond_2

    .line 2878
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2880
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char p1, v0, v6

    .line 2881
    const/16 v0, 0x21

    const/16 v6, 0x3c

    if-eq p1, v4, :cond_4

    const/16 v7, 0x9

    if-eq p1, v7, :cond_4

    .line 2883
    if-ne p1, v6, :cond_3

    .line 2884
    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v6, v5

    iget v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-ge v6, v7, :cond_3

    iget-object v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v7, v5

    aget-char v6, v6, v7

    if-eq v6, v0, :cond_3

    .line 2885
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0, v3, v4}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithIndentation(IC)V

    .line 2886
    return v1

    .line 2889
    :cond_3
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v0

    .line 2890
    .local v0, "outputBuffer":[C
    aput-char v2, v0, v3

    .line 2891
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1, v5}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 2892
    return v5

    .line 2895
    .end local v0    # "outputBuffer":[C
    :cond_4
    iget v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v7, v5

    iput v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2896
    const/4 v7, 0x1

    .line 2897
    .local v7, "count":I
    if-ne p1, v4, :cond_5

    goto :goto_0

    :cond_5
    const/16 v4, 0x8

    .line 2898
    .local v4, "max":I
    :goto_0
    if-gt v7, v4, :cond_8

    .line 2899
    iget v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v9, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v8, v9, :cond_6

    .line 2900
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2902
    :cond_6
    iget-object v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v9, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v8, v8, v9

    .line 2903
    .local v8, "c2":C
    if-eq v8, p1, :cond_7

    .line 2905
    if-ne v8, v6, :cond_8

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v6, v5

    iget v9, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-ge v6, v9, :cond_8

    iget-object v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v9, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v9, v5

    aget-char v6, v6, v9

    if-eq v6, v0, :cond_8

    .line 2907
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0, v7, p1}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithIndentation(IC)V

    .line 2908
    return v1

    .line 2912
    :cond_7
    iget v9, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v9, v5

    iput v9, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2913
    nop

    .end local v8    # "c2":C
    add-int/lit8 v7, v7, 0x1

    .line 2914
    goto :goto_0

    .line 2917
    :cond_8
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v0

    .line 2918
    .restart local v0    # "outputBuffer":[C
    aput-char v2, v0, v3

    .line 2919
    const/4 v1, 0x1

    .local v1, "i":I
    :goto_1
    if-gt v1, v7, :cond_9

    .line 2920
    aput-char p1, v0, v1

    .line 2919
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 2922
    .end local v1    # "i":I
    :cond_9
    add-int/2addr v7, v5

    .line 2923
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1, v7}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 2924
    return v7
.end method

.method protected final checkPrologIndentation(C)I
    .locals 8
    .param p1, "c"    # C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2934
    const/16 v0, 0xd

    const/16 v1, 0xa

    const/4 v2, -0x1

    const/4 v3, 0x0

    const/16 v4, 0x20

    const/4 v5, 0x1

    if-ne p1, v0, :cond_1

    .line 2936
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v0, v6, :cond_0

    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_0

    .line 2937
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0, v3, v4}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithIndentation(IC)V

    .line 2938
    return v2

    .line 2940
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v0, v6

    if-ne v0, v1, :cond_1

    .line 2941
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v0, v5

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2944
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 2946
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v0, v6, :cond_2

    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_2

    .line 2947
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0, v3, v4}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithIndentation(IC)V

    .line 2948
    return v2

    .line 2950
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char p1, v0, v6

    .line 2951
    if-eq p1, v4, :cond_4

    const/16 v0, 0x9

    if-eq p1, v0, :cond_4

    .line 2953
    const/16 v0, 0x3c

    if-ne p1, v0, :cond_3

    .line 2954
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0, v3, v4}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithIndentation(IC)V

    .line 2955
    return v2

    .line 2958
    :cond_3
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v0

    .line 2959
    .local v0, "outputBuffer":[C
    aput-char v1, v0, v3

    .line 2960
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1, v5}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 2961
    return v5

    .line 2964
    .end local v0    # "outputBuffer":[C
    :cond_4
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v0, v5

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2965
    const/4 v0, 0x1

    .line 2966
    .local v0, "count":I
    if-ne p1, v4, :cond_5

    goto :goto_0

    :cond_5
    const/16 v4, 0x8

    .line 2968
    .local v4, "max":I
    :cond_6
    :goto_0
    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v6, v7, :cond_7

    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMore()Z

    move-result v6

    if-nez v6, :cond_7

    .line 2969
    goto :goto_1

    .line 2971
    :cond_7
    iget-object v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v6, v6, v7

    if-eq v6, p1, :cond_8

    .line 2972
    nop

    .line 2989
    :goto_1
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1, v0, p1}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithIndentation(IC)V

    .line 2990
    return v2

    .line 2974
    :cond_8
    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v6, v5

    iput v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2975
    add-int/lit8 v0, v0, 0x1

    .line 2976
    if-lt v0, v4, :cond_6

    .line 2978
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v2

    .line 2979
    .local v2, "outputBuffer":[C
    aput-char v1, v2, v3

    .line 2980
    const/4 v1, 0x1

    .local v1, "i":I
    :goto_2
    if-gt v1, v0, :cond_9

    .line 2981
    aput-char p1, v2, v1

    .line 2980
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 2983
    .end local v1    # "i":I
    :cond_9
    add-int/2addr v0, v5

    .line 2984
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1, v0}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 2985
    return v0
.end method

.method protected final finishCData()V
    .locals 11
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1604
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderScanner;->sCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 1605
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    .line 1606
    .local v1, "inputBuffer":[C
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v2

    .line 1607
    .local v2, "outputBuffer":[C
    const/4 v3, 0x0

    .line 1618
    .local v3, "outPtr":I
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1619
    .local v4, "ptr":I
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v4, v5, :cond_0

    .line 1620
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1621
    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1623
    :cond_0
    array-length v5, v2

    if-lt v3, v5, :cond_1

    .line 1624
    iget-object v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v5}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 1625
    const/4 v3, 0x0

    .line 1627
    :cond_1
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    .line 1629
    .local v5, "max":I
    array-length v6, v2

    sub-int/2addr v6, v3

    add-int/2addr v6, v4

    .line 1630
    .local v6, "max2":I
    if-ge v6, v5, :cond_2

    .line 1631
    move v5, v6

    .line 1634
    .end local v6    # "max2":I
    :cond_2
    :goto_1
    if-ge v4, v5, :cond_14

    .line 1635
    add-int/lit8 v6, v4, 0x1

    .end local v4    # "ptr":I
    .local v6, "ptr":I
    aget-char v4, v1, v4

    .line 1636
    .local v4, "c":C
    const v7, 0xd800

    const/16 v8, 0xff

    if-gt v4, v8, :cond_3

    .line 1637
    aget v9, v0, v4

    if-eqz v9, :cond_13

    .line 1638
    iput v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1639
    goto :goto_2

    .line 1641
    :cond_3
    if-lt v4, v7, :cond_13

    .line 1642
    iput v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1643
    nop

    .line 1650
    .end local v5    # "max":I
    .end local v6    # "ptr":I
    :goto_2
    if-gt v4, v8, :cond_e

    .line 1651
    aget v5, v0, v4

    const/4 v6, 0x1

    sparse-switch v5, :sswitch_data_0

    goto/16 :goto_7

    .line 1675
    :sswitch_0
    const/4 v5, 0x0

    .line 1679
    .local v5, "count":I
    :goto_3
    iget v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v7, v8, :cond_4

    .line 1680
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1682
    :cond_4
    iget-object v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v7, v7, v8

    .line 1683
    .local v7, "d":C
    const/16 v8, 0x5d

    if-eq v7, v8, :cond_a

    .line 1684
    nop

    .line 1691
    const/16 v9, 0x3e

    if-ne v7, v9, :cond_5

    if-lt v5, v6, :cond_5

    move v9, v6

    goto :goto_4

    :cond_5
    const/4 v9, 0x0

    .line 1692
    .local v9, "ok":Z
    :goto_4
    if-eqz v9, :cond_6

    .line 1693
    add-int/lit8 v5, v5, -0x1

    .line 1696
    :cond_6
    :goto_5
    if-lez v5, :cond_8

    .line 1697
    add-int/lit8 v10, v3, 0x1

    .end local v3    # "outPtr":I
    .local v10, "outPtr":I
    aput-char v8, v2, v3

    .line 1698
    array-length v3, v2

    if-lt v10, v3, :cond_7

    .line 1699
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 1700
    const/4 v3, 0x0

    .end local v10    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_6

    .line 1698
    .end local v3    # "outPtr":I
    .restart local v10    # "outPtr":I
    :cond_7
    move v3, v10

    .line 1696
    .end local v10    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_6
    add-int/lit8 v5, v5, -0x1

    goto :goto_5

    .line 1703
    :cond_8
    if-eqz v9, :cond_d

    .line 1704
    iget v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v8, v6

    iput v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1705
    nop

    .line 1729
    .end local v4    # "c":C
    .end local v5    # "count":I
    .end local v7    # "d":C
    .end local v9    # "ok":Z
    iget-object v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 1733
    iget-boolean v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_cfgCoalescing:Z

    if-eqz v4, :cond_9

    iget-boolean v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_entityPending:Z

    if-nez v4, :cond_9

    .line 1734
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->finishCoalescedText()V

    .line 1736
    :cond_9
    return-void

    .line 1686
    .restart local v4    # "c":C
    .restart local v5    # "count":I
    .restart local v7    # "d":C
    :cond_a
    iget v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v8, v6

    iput v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1687
    add-int/lit8 v5, v5, 0x1

    .line 1688
    goto :goto_3

    .line 1667
    .end local v5    # "count":I
    .end local v7    # "d":C
    :sswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 1668
    goto :goto_7

    .line 1653
    :sswitch_2
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    move-result v4

    .line 1656
    :sswitch_3
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v5, v7, :cond_b

    .line 1657
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1659
    :cond_b
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v5, v1, v5

    const/16 v7, 0xa

    if-ne v5, v7, :cond_c

    .line 1660
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v5, v6

    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1662
    :cond_c
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 1664
    const/16 v4, 0xa

    .line 1665
    nop

    .line 1707
    :cond_d
    :goto_7
    goto :goto_9

    .line 1711
    :cond_e
    if-lt v4, v7, :cond_12

    .line 1712
    const v5, 0xe000

    if-ge v4, v5, :cond_11

    .line 1714
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->checkSurrogate(C)C

    move-result v5

    .line 1715
    .local v5, "d":C
    add-int/lit8 v6, v3, 0x1

    .end local v3    # "outPtr":I
    .local v6, "outPtr":I
    aput-char v4, v2, v3

    .line 1716
    array-length v3, v2

    if-lt v6, v3, :cond_f

    .line 1717
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 1718
    const/4 v3, 0x0

    .end local v6    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_8

    .line 1716
    .end local v3    # "outPtr":I
    .restart local v6    # "outPtr":I
    :cond_f
    move v3, v6

    .line 1720
    .end local v6    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_8
    move v4, v5

    .line 1721
    .end local v5    # "d":C
    :cond_10
    goto :goto_9

    :cond_11
    const v5, 0xfffe

    if-lt v4, v5, :cond_10

    .line 1722
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    move-result v4

    .line 1726
    :cond_12
    :goto_9
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .local v5, "outPtr":I
    aput-char v4, v2, v3

    .line 1727
    .end local v4    # "c":C
    move v3, v5

    goto/16 :goto_0

    .line 1645
    .restart local v3    # "outPtr":I
    .restart local v4    # "c":C
    .local v5, "max":I
    .local v6, "ptr":I
    :cond_13
    add-int/lit8 v7, v3, 0x1

    .end local v3    # "outPtr":I
    .local v7, "outPtr":I
    aput-char v4, v2, v3

    move v4, v6

    move v3, v7

    goto/16 :goto_1

    .line 1647
    .end local v6    # "ptr":I
    .end local v7    # "outPtr":I
    .restart local v3    # "outPtr":I
    .local v4, "ptr":I
    :cond_14
    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1648
    .end local v4    # "ptr":I
    .end local v5    # "max":I
    goto/16 :goto_0

    nop

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_2
        0x2 -> :sswitch_3
        0x3 -> :sswitch_1
        0xb -> :sswitch_0
    .end sparse-switch
.end method

.method protected final finishCharacters()V
    .locals 14
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1746
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->mTmpChar:I

    .line 1747
    .local v0, "c":I
    const v1, 0xdc00

    const/high16 v2, 0x10000

    const v3, 0xd800

    const/16 v4, 0xa

    const/4 v5, 0x1

    if-gez v0, :cond_1

    .line 1748
    neg-int v0, v0

    .line 1749
    iget-object v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v6}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v6

    .line 1750
    .local v6, "outputBuffer":[C
    const/4 v7, 0x0

    .line 1751
    .local v7, "outPtr":I
    shr-int/lit8 v8, v0, 0x10

    if-eqz v8, :cond_0

    .line 1752
    sub-int/2addr v0, v2

    .line 1756
    add-int/lit8 v8, v7, 0x1

    .end local v7    # "outPtr":I
    .local v8, "outPtr":I
    shr-int/lit8 v9, v0, 0xa

    or-int/2addr v9, v3

    int-to-char v9, v9

    aput-char v9, v6, v7

    .line 1757
    and-int/lit16 v7, v0, 0x3ff

    or-int v0, v7, v1

    move v7, v8

    .line 1759
    .end local v8    # "outPtr":I
    .restart local v7    # "outPtr":I
    :cond_0
    add-int/lit8 v8, v7, 0x1

    .end local v7    # "outPtr":I
    .restart local v8    # "outPtr":I
    int-to-char v9, v0

    aput-char v9, v6, v7

    goto :goto_1

    .line 1761
    .end local v6    # "outputBuffer":[C
    .end local v8    # "outPtr":I
    :cond_1
    const/16 v6, 0xd

    if-eq v0, v6, :cond_3

    if-ne v0, v4, :cond_2

    goto :goto_0

    .line 1770
    :cond_2
    iget-object v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v6}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v6

    .line 1771
    .restart local v6    # "outputBuffer":[C
    const/4 v8, 0x0

    .restart local v8    # "outPtr":I
    goto :goto_1

    .line 1762
    .end local v6    # "outputBuffer":[C
    .end local v8    # "outPtr":I
    :cond_3
    :goto_0
    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v6, v5

    iput v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1763
    int-to-char v6, v0

    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/in/ReaderScanner;->checkInTreeIndentation(C)I

    move-result v8

    .line 1764
    .restart local v8    # "outPtr":I
    if-gez v8, :cond_4

    .line 1765
    return-void

    .line 1768
    :cond_4
    iget-object v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v6}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v6

    .line 1776
    .end local v0    # "c":I
    .restart local v6    # "outputBuffer":[C
    :goto_1
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderScanner;->sCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    .line 1777
    .local v0, "TYPES":[I
    iget-object v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    .line 1786
    .local v7, "inputBuffer":[C
    :goto_2
    iget v9, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1787
    .local v9, "ptr":I
    iget v10, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v9, v10, :cond_5

    .line 1788
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1789
    iget v9, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1791
    :cond_5
    array-length v10, v6

    if-lt v8, v10, :cond_6

    .line 1792
    iget-object v10, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v10}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v6

    .line 1793
    const/4 v8, 0x0

    .line 1795
    :cond_6
    iget v10, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    .line 1797
    .local v10, "max":I
    array-length v11, v6

    sub-int/2addr v11, v8

    add-int/2addr v11, v9

    .line 1798
    .local v11, "max2":I
    if-ge v11, v10, :cond_7

    .line 1799
    move v10, v11

    .line 1802
    .end local v11    # "max2":I
    :cond_7
    :goto_3
    if-ge v9, v10, :cond_1a

    .line 1803
    add-int/lit8 v11, v9, 0x1

    .end local v9    # "ptr":I
    .local v11, "ptr":I
    aget-char v9, v7, v9

    .line 1804
    .local v9, "c":C
    const/16 v12, 0xff

    if-gt v9, v12, :cond_8

    .line 1805
    aget v13, v0, v9

    if-eqz v13, :cond_19

    .line 1806
    iput v11, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1807
    goto :goto_4

    .line 1809
    :cond_8
    if-lt v9, v3, :cond_19

    .line 1810
    iput v11, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1811
    nop

    .line 1818
    .end local v10    # "max":I
    .end local v11    # "ptr":I
    :goto_4
    if-gt v9, v12, :cond_14

    .line 1819
    aget v10, v0, v9

    packed-switch v10, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_a

    .line 1868
    :pswitch_1
    const/4 v10, 0x1

    .line 1870
    .local v10, "count":I
    :goto_5
    iget v11, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v12, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v11, v12, :cond_9

    .line 1871
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1873
    :cond_9
    iget v11, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v9, v7, v11

    .line 1874
    const/16 v11, 0x5d

    if-eq v9, v11, :cond_d

    .line 1875
    nop

    .line 1880
    const/16 v12, 0x3e

    if-ne v9, v12, :cond_a

    if-le v10, v5, :cond_a

    .line 1881
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportIllegalCDataEnd()V

    .line 1885
    :cond_a
    :goto_6
    if-le v10, v5, :cond_c

    .line 1886
    add-int/lit8 v12, v8, 0x1

    .end local v8    # "outPtr":I
    .local v12, "outPtr":I
    aput-char v11, v6, v8

    .line 1887
    array-length v8, v6

    if-lt v12, v8, :cond_b

    .line 1888
    iget-object v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v8}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v6

    .line 1889
    const/4 v8, 0x0

    .end local v12    # "outPtr":I
    .restart local v8    # "outPtr":I
    goto :goto_7

    .line 1887
    .end local v8    # "outPtr":I
    .restart local v12    # "outPtr":I
    :cond_b
    move v8, v12

    .line 1892
    .end local v12    # "outPtr":I
    .restart local v8    # "outPtr":I
    :goto_7
    add-int/lit8 v10, v10, -0x1

    goto :goto_6

    .line 1896
    .end local v10    # "count":I
    :cond_c
    const/16 v9, 0x5d

    goto/16 :goto_a

    .line 1877
    .restart local v10    # "count":I
    :cond_d
    iget v11, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v11, v5

    iput v11, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1878
    add-int/lit8 v10, v10, 0x1

    goto :goto_5

    .line 1844
    .end local v10    # "count":I
    :pswitch_2
    const/4 v10, 0x0

    invoke-virtual {p0, v10}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleEntityInText(Z)I

    move-result v10

    .line 1845
    .local v10, "d":I
    if-nez v10, :cond_e

    .line 1847
    iput-boolean v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_entityPending:Z

    .line 1848
    goto :goto_9

    .line 1851
    :cond_e
    shr-int/lit8 v11, v10, 0x10

    if-eqz v11, :cond_10

    .line 1852
    sub-int/2addr v10, v2

    .line 1853
    add-int/lit8 v11, v8, 0x1

    .end local v8    # "outPtr":I
    .local v11, "outPtr":I
    shr-int/lit8 v12, v10, 0xa

    or-int/2addr v12, v3

    int-to-char v12, v12

    aput-char v12, v6, v8

    .line 1855
    array-length v8, v6

    if-lt v11, v8, :cond_f

    .line 1856
    iget-object v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v8}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v6

    .line 1857
    const/4 v8, 0x0

    .end local v11    # "outPtr":I
    .restart local v8    # "outPtr":I
    goto :goto_8

    .line 1855
    .end local v8    # "outPtr":I
    .restart local v11    # "outPtr":I
    :cond_f
    move v8, v11

    .line 1859
    .end local v11    # "outPtr":I
    .restart local v8    # "outPtr":I
    :goto_8
    and-int/lit16 v11, v10, 0x3ff

    or-int v10, v11, v1

    .line 1861
    :cond_10
    int-to-char v9, v10

    .line 1863
    .end local v10    # "d":I
    goto :goto_a

    .line 1840
    :pswitch_3
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    sub-int/2addr v1, v5

    iput v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1841
    nop

    .line 1917
    .end local v9    # "c":C
    :goto_9
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1, v8}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 1920
    iget-boolean v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_cfgCoalescing:Z

    if-eqz v1, :cond_11

    iget-boolean v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_entityPending:Z

    if-nez v1, :cond_11

    .line 1921
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->finishCoalescedText()V

    .line 1923
    :cond_11
    return-void

    .line 1837
    .restart local v9    # "c":C
    :pswitch_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 1838
    goto :goto_a

    .line 1821
    :pswitch_5
    invoke-virtual {p0, v9}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    move-result v9

    .line 1824
    :pswitch_6
    iget v10, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1825
    .local v10, "ptr":I
    iget v11, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v10, v11, :cond_12

    .line 1826
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1827
    iget v10, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1829
    :cond_12
    aget-char v11, v7, v10

    if-ne v11, v4, :cond_13

    .line 1830
    iget v11, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v11, v5

    iput v11, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1832
    :cond_13
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 1834
    .end local v10    # "ptr":I
    const/16 v9, 0xa

    .line 1835
    nop

    .line 1897
    :goto_a
    goto :goto_c

    .line 1901
    :cond_14
    if-lt v9, v3, :cond_18

    .line 1902
    const v10, 0xe000

    if-ge v9, v10, :cond_17

    .line 1904
    invoke-direct {p0, v9}, Lcom/fasterxml/aalto/in/ReaderScanner;->checkSurrogate(C)C

    move-result v10

    .line 1905
    .local v10, "d":C
    add-int/lit8 v11, v8, 0x1

    .end local v8    # "outPtr":I
    .restart local v11    # "outPtr":I
    aput-char v9, v6, v8

    .line 1906
    array-length v8, v6

    if-lt v11, v8, :cond_15

    .line 1907
    iget-object v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v8}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v6

    .line 1908
    const/4 v8, 0x0

    .end local v11    # "outPtr":I
    .restart local v8    # "outPtr":I
    goto :goto_b

    .line 1906
    .end local v8    # "outPtr":I
    .restart local v11    # "outPtr":I
    :cond_15
    move v8, v11

    .line 1910
    .end local v11    # "outPtr":I
    .restart local v8    # "outPtr":I
    :goto_b
    move v9, v10

    .line 1911
    .end local v10    # "d":C
    :cond_16
    goto :goto_c

    :cond_17
    const v10, 0xfffe

    if-lt v9, v10, :cond_16

    .line 1912
    invoke-virtual {p0, v9}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    move-result v9

    .line 1915
    :cond_18
    :goto_c
    add-int/lit8 v10, v8, 0x1

    .end local v8    # "outPtr":I
    .local v10, "outPtr":I
    aput-char v9, v6, v8

    .line 1916
    .end local v9    # "c":C
    move v8, v10

    goto/16 :goto_2

    .line 1813
    .restart local v8    # "outPtr":I
    .restart local v9    # "c":C
    .local v10, "max":I
    .local v11, "ptr":I
    :cond_19
    add-int/lit8 v12, v8, 0x1

    .end local v8    # "outPtr":I
    .restart local v12    # "outPtr":I
    aput-char v9, v6, v8

    move v9, v11

    move v8, v12

    goto/16 :goto_3

    .line 1815
    .end local v11    # "ptr":I
    .end local v12    # "outPtr":I
    .restart local v8    # "outPtr":I
    .local v9, "ptr":I
    :cond_1a
    iput v9, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1816
    .end local v9    # "ptr":I
    .end local v10    # "max":I
    goto/16 :goto_2

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_5
        :pswitch_6
        :pswitch_4
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_3
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

    .line 2064
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderScanner;->sCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 2065
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    .line 2067
    .local v1, "inputBuffer":[C
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v2

    .line 2068
    .local v2, "outputBuffer":[C
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->getCurrentLength()I

    move-result v3

    .line 2079
    .local v3, "outPtr":I
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2080
    .local v4, "ptr":I
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v4, v5, :cond_0

    .line 2081
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2082
    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2084
    :cond_0
    array-length v5, v2

    if-lt v3, v5, :cond_1

    .line 2085
    iget-object v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v5}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2086
    const/4 v3, 0x0

    .line 2088
    :cond_1
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    .line 2090
    .local v5, "max":I
    array-length v6, v2

    sub-int/2addr v6, v3

    add-int/2addr v6, v4

    .line 2091
    .local v6, "max2":I
    if-ge v6, v5, :cond_2

    .line 2092
    move v5, v6

    .line 2095
    .end local v6    # "max2":I
    :cond_2
    :goto_1
    if-ge v4, v5, :cond_13

    .line 2096
    add-int/lit8 v6, v4, 0x1

    .end local v4    # "ptr":I
    .local v6, "ptr":I
    aget-char v4, v1, v4

    .line 2097
    .local v4, "c":C
    const v7, 0xd800

    const/16 v8, 0xff

    if-gt v4, v8, :cond_3

    .line 2098
    aget v9, v0, v4

    if-eqz v9, :cond_12

    .line 2099
    iput v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2100
    goto :goto_2

    .line 2102
    :cond_3
    if-lt v4, v7, :cond_12

    .line 2103
    iput v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2104
    nop

    .line 2111
    .end local v5    # "max":I
    .end local v6    # "ptr":I
    :goto_2
    if-gt v4, v8, :cond_d

    .line 2112
    aget v5, v0, v4

    const/4 v6, 0x1

    sparse-switch v5, :sswitch_data_0

    goto/16 :goto_7

    .line 2136
    :sswitch_0
    const/4 v5, 0x0

    .line 2140
    .local v5, "count":I
    :goto_3
    iget v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v7, v8, :cond_4

    .line 2141
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2143
    :cond_4
    iget-object v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v7, v7, v8

    .line 2144
    .local v7, "d":C
    const/16 v8, 0x5d

    if-eq v7, v8, :cond_9

    .line 2145
    nop

    .line 2152
    const/16 v9, 0x3e

    if-ne v7, v9, :cond_5

    if-lt v5, v6, :cond_5

    move v9, v6

    goto :goto_4

    :cond_5
    const/4 v9, 0x0

    .line 2153
    .local v9, "ok":Z
    :goto_4
    if-eqz v9, :cond_6

    .line 2154
    add-int/lit8 v5, v5, -0x1

    .line 2157
    :cond_6
    :goto_5
    if-lez v5, :cond_8

    .line 2158
    add-int/lit8 v10, v3, 0x1

    .end local v3    # "outPtr":I
    .local v10, "outPtr":I
    aput-char v8, v2, v3

    .line 2159
    array-length v3, v2

    if-lt v10, v3, :cond_7

    .line 2160
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2161
    const/4 v3, 0x0

    .end local v10    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_6

    .line 2159
    .end local v3    # "outPtr":I
    .restart local v10    # "outPtr":I
    :cond_7
    move v3, v10

    .line 2157
    .end local v10    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_6
    add-int/lit8 v5, v5, -0x1

    goto :goto_5

    .line 2164
    :cond_8
    if-eqz v9, :cond_c

    .line 2165
    iget v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v8, v6

    iput v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2166
    nop

    .line 2189
    .end local v4    # "c":C
    .end local v5    # "count":I
    .end local v7    # "d":C
    .end local v9    # "ok":Z
    iget-object v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 2190
    return-void

    .line 2147
    .restart local v4    # "c":C
    .restart local v5    # "count":I
    .restart local v7    # "d":C
    :cond_9
    iget v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v8, v6

    iput v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2148
    add-int/lit8 v5, v5, 0x1

    .line 2149
    goto :goto_3

    .line 2128
    .end local v5    # "count":I
    .end local v7    # "d":C
    :sswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 2129
    goto :goto_7

    .line 2114
    :sswitch_2
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    move-result v4

    .line 2117
    :sswitch_3
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v5, v7, :cond_a

    .line 2118
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2120
    :cond_a
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v5, v1, v5

    const/16 v7, 0xa

    if-ne v5, v7, :cond_b

    .line 2121
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v5, v6

    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2123
    :cond_b
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 2125
    const/16 v4, 0xa

    .line 2126
    nop

    .line 2168
    :cond_c
    :goto_7
    goto :goto_9

    .line 2172
    :cond_d
    if-lt v4, v7, :cond_11

    .line 2173
    const v5, 0xe000

    if-ge v4, v5, :cond_10

    .line 2175
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->checkSurrogate(C)C

    move-result v5

    .line 2176
    .local v5, "d":C
    add-int/lit8 v6, v3, 0x1

    .end local v3    # "outPtr":I
    .local v6, "outPtr":I
    aput-char v4, v2, v3

    .line 2177
    array-length v3, v2

    if-lt v6, v3, :cond_e

    .line 2178
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2179
    const/4 v3, 0x0

    .end local v6    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_8

    .line 2177
    .end local v3    # "outPtr":I
    .restart local v6    # "outPtr":I
    :cond_e
    move v3, v6

    .line 2181
    .end local v6    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_8
    move v4, v5

    .line 2182
    .end local v5    # "d":C
    :cond_f
    goto :goto_9

    :cond_10
    const v5, 0xfffe

    if-lt v4, v5, :cond_f

    .line 2183
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    move-result v4

    .line 2187
    :cond_11
    :goto_9
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .local v5, "outPtr":I
    aput-char v4, v2, v3

    .line 2188
    .end local v4    # "c":C
    move v3, v5

    goto/16 :goto_0

    .line 2106
    .restart local v3    # "outPtr":I
    .restart local v4    # "c":C
    .local v5, "max":I
    .local v6, "ptr":I
    :cond_12
    add-int/lit8 v7, v3, 0x1

    .end local v3    # "outPtr":I
    .local v7, "outPtr":I
    aput-char v4, v2, v3

    move v4, v6

    move v3, v7

    goto/16 :goto_1

    .line 2108
    .end local v6    # "ptr":I
    .end local v7    # "outPtr":I
    .restart local v3    # "outPtr":I
    .local v4, "ptr":I
    :cond_13
    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2109
    .end local v4    # "ptr":I
    .end local v5    # "max":I
    goto/16 :goto_0

    nop

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_2
        0x2 -> :sswitch_3
        0x3 -> :sswitch_1
        0xb -> :sswitch_0
    .end sparse-switch
.end method

.method protected final finishCoalescedCharacters()V
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2199
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderScanner;->sCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    .line 2200
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    .line 2202
    .local v1, "inputBuffer":[C
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v2

    .line 2203
    .local v2, "outputBuffer":[C
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->getCurrentLength()I

    move-result v3

    .line 2211
    .local v3, "outPtr":I
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2212
    .local v4, "ptr":I
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v4, v5, :cond_0

    .line 2213
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2214
    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2216
    :cond_0
    array-length v5, v2

    if-lt v3, v5, :cond_1

    .line 2217
    iget-object v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v5}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2218
    const/4 v3, 0x0

    .line 2220
    :cond_1
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    .line 2222
    .local v5, "max":I
    array-length v6, v2

    sub-int/2addr v6, v3

    add-int/2addr v6, v4

    .line 2223
    .local v6, "max2":I
    if-ge v6, v5, :cond_2

    .line 2224
    move v5, v6

    .line 2227
    .end local v6    # "max2":I
    :cond_2
    :goto_1
    if-ge v4, v5, :cond_14

    .line 2228
    add-int/lit8 v6, v4, 0x1

    .end local v4    # "ptr":I
    .local v6, "ptr":I
    aget-char v4, v1, v4

    .line 2229
    .local v4, "c":C
    const/16 v7, 0xff

    const v8, 0xd800

    if-gt v4, v7, :cond_3

    .line 2230
    aget v9, v0, v4

    if-eqz v9, :cond_13

    .line 2231
    iput v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2232
    goto :goto_2

    .line 2234
    :cond_3
    if-lt v4, v8, :cond_13

    .line 2235
    iput v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2236
    nop

    .line 2243
    .end local v5    # "max":I
    .end local v6    # "ptr":I
    :goto_2
    if-gt v4, v7, :cond_e

    .line 2244
    aget v5, v0, v4

    const/4 v6, 0x1

    packed-switch v5, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_8

    .line 2293
    :pswitch_1
    const/4 v5, 0x1

    .line 2295
    .local v5, "count":I
    :goto_3
    iget v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v7, v8, :cond_4

    .line 2296
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2298
    :cond_4
    iget v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v4, v1, v7

    .line 2299
    const/16 v7, 0x5d

    if-eq v4, v7, :cond_8

    .line 2300
    nop

    .line 2305
    const/16 v8, 0x3e

    if-ne v4, v8, :cond_5

    if-le v5, v6, :cond_5

    .line 2306
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportIllegalCDataEnd()V

    .line 2310
    :cond_5
    :goto_4
    if-le v5, v6, :cond_7

    .line 2311
    add-int/lit8 v8, v3, 0x1

    .end local v3    # "outPtr":I
    .local v8, "outPtr":I
    aput-char v7, v2, v3

    .line 2312
    array-length v3, v2

    if-lt v8, v3, :cond_6

    .line 2313
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2314
    const/4 v3, 0x0

    .end local v8    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_5

    .line 2312
    .end local v3    # "outPtr":I
    .restart local v8    # "outPtr":I
    :cond_6
    move v3, v8

    .line 2317
    .end local v8    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_5
    add-int/lit8 v5, v5, -0x1

    goto :goto_4

    .line 2321
    .end local v5    # "count":I
    :cond_7
    const/16 v4, 0x5d

    goto :goto_8

    .line 2302
    .restart local v5    # "count":I
    :cond_8
    iget v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v7, v6

    iput v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2303
    add-int/lit8 v5, v5, 0x1

    goto :goto_3

    .line 2269
    .end local v5    # "count":I
    :pswitch_2
    const/4 v5, 0x0

    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleEntityInText(Z)I

    move-result v5

    .line 2270
    .local v5, "d":I
    if-nez v5, :cond_9

    .line 2272
    iput-boolean v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_entityPending:Z

    .line 2273
    goto :goto_7

    .line 2276
    :cond_9
    shr-int/lit8 v6, v5, 0x10

    if-eqz v6, :cond_b

    .line 2277
    const/high16 v6, 0x10000

    sub-int/2addr v5, v6

    .line 2278
    add-int/lit8 v6, v3, 0x1

    .end local v3    # "outPtr":I
    .local v6, "outPtr":I
    shr-int/lit8 v7, v5, 0xa

    or-int/2addr v7, v8

    int-to-char v7, v7

    aput-char v7, v2, v3

    .line 2280
    array-length v3, v2

    if-lt v6, v3, :cond_a

    .line 2281
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2282
    const/4 v3, 0x0

    .end local v6    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_6

    .line 2280
    .end local v3    # "outPtr":I
    .restart local v6    # "outPtr":I
    :cond_a
    move v3, v6

    .line 2284
    .end local v6    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_6
    and-int/lit16 v6, v5, 0x3ff

    const v7, 0xdc00

    or-int v5, v6, v7

    .line 2286
    :cond_b
    int-to-char v4, v5

    .line 2288
    .end local v5    # "d":I
    goto :goto_8

    .line 2265
    :pswitch_3
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    sub-int/2addr v5, v6

    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2266
    nop

    .line 2342
    .end local v4    # "c":C
    :goto_7
    iget-object v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 2343
    return-void

    .line 2262
    .restart local v4    # "c":C
    :pswitch_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 2263
    goto :goto_8

    .line 2246
    :pswitch_5
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    move-result v4

    .line 2249
    :pswitch_6
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2250
    .local v5, "ptr":I
    iget v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v5, v7, :cond_c

    .line 2251
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2252
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2254
    :cond_c
    aget-char v7, v1, v5

    const/16 v8, 0xa

    if-ne v7, v8, :cond_d

    .line 2255
    iget v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v7, v6

    iput v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2257
    :cond_d
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 2259
    .end local v5    # "ptr":I
    const/16 v4, 0xa

    .line 2260
    nop

    .line 2322
    :goto_8
    goto :goto_a

    .line 2326
    :cond_e
    if-lt v4, v8, :cond_12

    .line 2327
    const v5, 0xe000

    if-ge v4, v5, :cond_11

    .line 2329
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->checkSurrogate(C)C

    move-result v5

    .line 2330
    .local v5, "d":C
    add-int/lit8 v6, v3, 0x1

    .end local v3    # "outPtr":I
    .restart local v6    # "outPtr":I
    aput-char v4, v2, v3

    .line 2331
    array-length v3, v2

    if-lt v6, v3, :cond_f

    .line 2332
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 2333
    const/4 v3, 0x0

    .end local v6    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_9

    .line 2331
    .end local v3    # "outPtr":I
    .restart local v6    # "outPtr":I
    :cond_f
    move v3, v6

    .line 2335
    .end local v6    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_9
    move v4, v5

    .line 2336
    .end local v5    # "d":C
    :cond_10
    goto :goto_a

    :cond_11
    const v5, 0xfffe

    if-lt v4, v5, :cond_10

    .line 2337
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    move-result v4

    .line 2340
    :cond_12
    :goto_a
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .local v5, "outPtr":I
    aput-char v4, v2, v3

    .line 2341
    .end local v4    # "c":C
    move v3, v5

    goto/16 :goto_0

    .line 2238
    .restart local v3    # "outPtr":I
    .restart local v4    # "c":C
    .local v5, "max":I
    .local v6, "ptr":I
    :cond_13
    add-int/lit8 v7, v3, 0x1

    .end local v3    # "outPtr":I
    .local v7, "outPtr":I
    aput-char v4, v2, v3

    move v4, v6

    move v3, v7

    goto/16 :goto_1

    .line 2240
    .end local v6    # "ptr":I
    .end local v7    # "outPtr":I
    .restart local v3    # "outPtr":I
    .local v4, "ptr":I
    :cond_14
    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2241
    .end local v4    # "ptr":I
    .end local v5    # "max":I
    goto/16 :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_5
        :pswitch_6
        :pswitch_4
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method protected final finishCoalescedText()V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2017
    nop

    :cond_0
    :goto_0
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v0, v1, :cond_1

    .line 2018
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_1

    .line 2019
    return-void

    .line 2023
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v0, v1

    const/16 v1, 0x3c

    if-ne v0, v1, :cond_8

    .line 2027
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    const/4 v1, 0x3

    add-int/2addr v0, v1

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v0, v2, :cond_2

    .line 2028
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadAndRetain(I)Z

    move-result v0

    if-nez v0, :cond_2

    .line 2030
    return-void

    .line 2033
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v2, v2, 0x1

    aget-char v0, v0, v2

    const/16 v2, 0x21

    if-ne v0, v2, :cond_7

    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v2, v2, 0x2

    aget-char v0, v0, v2

    const/16 v2, 0x5b

    if-eq v0, v2, :cond_3

    goto :goto_2

    .line 2039
    :cond_3
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2040
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    const/4 v1, 0x6

    if-ge v0, v1, :cond_6

    .line 2041
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v1, v2, :cond_4

    .line 2042
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2044
    :cond_4
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v1, v1, v2

    .line 2045
    .local v1, "c":C
    const-string v2, "CDATA["

    invoke-virtual {v2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    if-eq v1, v3, :cond_5

    .line 2046
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, " (expected \'"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\' for CDATA section)"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 2040
    .end local v1    # "c":C
    :cond_5
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 2049
    .end local v0    # "i":I
    :cond_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->finishCoalescedCData()V

    goto/16 :goto_0

    .line 2036
    :cond_7
    :goto_2
    return-void

    .line 2051
    :cond_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->finishCoalescedCharacters()V

    .line 2052
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_entityPending:Z

    if-eqz v0, :cond_0

    .line 2053
    nop

    .line 2057
    return-void
.end method

.method protected final finishComment()V
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1268
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderScanner;->sCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 1269
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    .line 1270
    .local v1, "inputBuffer":[C
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v2

    .line 1271
    .local v2, "outputBuffer":[C
    const/4 v3, 0x0

    .line 1280
    .local v3, "outPtr":I
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1281
    .local v4, "ptr":I
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v4, v5, :cond_0

    .line 1282
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1283
    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1285
    :cond_0
    array-length v5, v2

    if-lt v3, v5, :cond_1

    .line 1286
    iget-object v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v5}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 1287
    const/4 v3, 0x0

    .line 1289
    :cond_1
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    .line 1291
    .local v5, "max":I
    array-length v6, v2

    sub-int/2addr v6, v3

    add-int/2addr v6, v4

    .line 1292
    .local v6, "max2":I
    if-ge v6, v5, :cond_2

    .line 1293
    move v5, v6

    .line 1296
    .end local v6    # "max2":I
    :cond_2
    :goto_1
    if-ge v4, v5, :cond_10

    .line 1297
    add-int/lit8 v6, v4, 0x1

    .end local v4    # "ptr":I
    .local v6, "ptr":I
    aget-char v4, v1, v4

    .line 1298
    .local v4, "c":C
    const v7, 0xd800

    const/16 v8, 0xff

    if-gt v4, v8, :cond_3

    .line 1299
    aget v9, v0, v4

    if-eqz v9, :cond_f

    .line 1300
    iput v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1301
    goto :goto_2

    .line 1303
    :cond_3
    if-lt v4, v7, :cond_f

    .line 1304
    iput v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1305
    nop

    .line 1312
    .end local v5    # "max":I
    .end local v6    # "ptr":I
    :goto_2
    if-gt v4, v8, :cond_a

    .line 1313
    aget v5, v0, v4

    sparse-switch v5, :sswitch_data_0

    goto :goto_3

    .line 1332
    :sswitch_0
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v5, v6, :cond_4

    .line 1333
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1335
    :cond_4
    iget-object v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v5, v5, v6

    const/16 v6, 0x2d

    if-ne v5, v6, :cond_9

    .line 1336
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v5, v5, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1337
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v5, v6, :cond_5

    .line 1338
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1340
    :cond_5
    iget-object v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v5, v5, v6

    const/16 v6, 0x3e

    if-eq v5, v6, :cond_6

    .line 1341
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportDoubleHyphenInComments()V

    .line 1366
    .end local v4    # "c":C
    :cond_6
    iget-object v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 1367
    return-void

    .line 1329
    .restart local v4    # "c":C
    :sswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 1330
    goto :goto_3

    .line 1315
    :sswitch_2
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    move-result v4

    .line 1318
    :sswitch_3
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v5, v6, :cond_7

    .line 1319
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1321
    :cond_7
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v5, v1, v5

    const/16 v6, 0xa

    if-ne v5, v6, :cond_8

    .line 1322
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v5, v5, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1324
    :cond_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 1326
    const/16 v4, 0xa

    .line 1327
    nop

    .line 1345
    :cond_9
    :goto_3
    goto :goto_5

    .line 1349
    :cond_a
    if-lt v4, v7, :cond_e

    .line 1350
    const v5, 0xe000

    if-ge v4, v5, :cond_d

    .line 1352
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->checkSurrogate(C)C

    move-result v5

    .line 1353
    .local v5, "d":C
    add-int/lit8 v6, v3, 0x1

    .end local v3    # "outPtr":I
    .local v6, "outPtr":I
    aput-char v4, v2, v3

    .line 1354
    array-length v3, v2

    if-lt v6, v3, :cond_b

    .line 1355
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 1356
    const/4 v3, 0x0

    .end local v6    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_4

    .line 1354
    .end local v3    # "outPtr":I
    .restart local v6    # "outPtr":I
    :cond_b
    move v3, v6

    .line 1358
    .end local v6    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_4
    move v4, v5

    .line 1359
    .end local v5    # "d":C
    :cond_c
    goto :goto_5

    :cond_d
    const v5, 0xfffe

    if-lt v4, v5, :cond_c

    .line 1360
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    move-result v4

    .line 1364
    :cond_e
    :goto_5
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .local v5, "outPtr":I
    aput-char v4, v2, v3

    .line 1365
    .end local v4    # "c":C
    move v3, v5

    goto/16 :goto_0

    .line 1307
    .restart local v3    # "outPtr":I
    .restart local v4    # "c":C
    .local v5, "max":I
    .local v6, "ptr":I
    :cond_f
    add-int/lit8 v7, v3, 0x1

    .end local v3    # "outPtr":I
    .local v7, "outPtr":I
    aput-char v4, v2, v3

    move v4, v6

    move v3, v7

    goto/16 :goto_1

    .line 1309
    .end local v6    # "ptr":I
    .end local v7    # "outPtr":I
    .restart local v3    # "outPtr":I
    .local v4, "ptr":I
    :cond_10
    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1310
    .end local v4    # "ptr":I
    .end local v5    # "max":I
    goto/16 :goto_0

    nop

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_2
        0x2 -> :sswitch_3
        0x3 -> :sswitch_1
        0xd -> :sswitch_0
    .end sparse-switch
.end method

.method protected final finishDTD(Z)V
    .locals 12
    .param p1, "copyContents"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1468
    const/4 v0, 0x0

    if-eqz p1, :cond_0

    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    .line 1469
    invoke-virtual {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v1, v0

    .line 1470
    .local v1, "outputBuffer":[C
    :goto_0
    const/4 v2, 0x0

    .line 1472
    .local v2, "outPtr":I
    sget-object v3, Lcom/fasterxml/aalto/in/ReaderScanner;->sCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v3, v3, Lcom/fasterxml/aalto/util/XmlCharTypes;->DTD_CHARS:[I

    .line 1473
    .local v3, "TYPES":[I
    const/4 v4, 0x0

    .line 1474
    .local v4, "inDecl":Z
    const/4 v5, 0x0

    .line 1485
    .local v5, "quoteChar":I
    :goto_1
    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1486
    .local v6, "ptr":I
    iget v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v6, v7, :cond_1

    .line 1487
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1488
    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1490
    :cond_1
    iget v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    .line 1491
    .local v7, "max":I
    if-eqz v1, :cond_3

    .line 1492
    array-length v8, v1

    if-lt v2, v8, :cond_2

    .line 1493
    iget-object v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v8}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v1

    .line 1494
    const/4 v2, 0x0

    .line 1497
    :cond_2
    array-length v8, v1

    sub-int/2addr v8, v2

    add-int/2addr v8, v6

    .line 1498
    .local v8, "max2":I
    if-ge v8, v7, :cond_3

    .line 1499
    move v7, v8

    .line 1503
    .end local v8    # "max2":I
    :cond_3
    :goto_2
    if-ge v6, v7, :cond_14

    .line 1504
    iget-object v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    add-int/lit8 v9, v6, 0x1

    .end local v6    # "ptr":I
    .local v9, "ptr":I
    aget-char v6, v8, v6

    .line 1505
    .local v6, "c":C
    const v8, 0xd800

    const/16 v10, 0xff

    if-gt v6, v10, :cond_4

    .line 1506
    aget v11, v3, v6

    if-eqz v11, :cond_12

    .line 1507
    iput v9, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1508
    goto :goto_3

    .line 1510
    :cond_4
    if-lt v6, v8, :cond_12

    .line 1511
    iput v9, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1512
    nop

    .line 1521
    .end local v7    # "max":I
    .end local v9    # "ptr":I
    :goto_3
    if-gt v6, v10, :cond_b

    .line 1522
    aget v7, v3, v6

    packed-switch v7, :pswitch_data_0

    :pswitch_0
    goto :goto_4

    .line 1562
    :pswitch_1
    if-nez v4, :cond_a

    if-nez v5, :cond_a

    .line 1563
    nop

    .line 1590
    .end local v6    # "c":C
    if-eqz v1, :cond_5

    .line 1591
    iget-object v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v6, v2}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 1595
    :cond_5
    const/4 v6, 0x0

    invoke-virtual {p0, v6, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->skipInternalWs(ZLjava/lang/String;)C

    move-result v0

    .line 1596
    .local v0, "c":C
    const/16 v6, 0x3e

    if-eq v0, v6, :cond_6

    .line 1597
    const-string v6, " expected \'>\' after the internal subset"

    invoke-virtual {p0, v0, v6}, Lcom/fasterxml/aalto/in/ReaderScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1599
    :cond_6
    return-void

    .line 1557
    .end local v0    # "c":C
    .restart local v6    # "c":C
    :pswitch_2
    if-nez v5, :cond_a

    .line 1558
    const/4 v4, 0x0

    goto :goto_4

    .line 1552
    :pswitch_3
    if-nez v4, :cond_a

    .line 1553
    const/4 v4, 0x1

    goto :goto_4

    .line 1542
    :pswitch_4
    if-nez v5, :cond_7

    .line 1543
    move v5, v6

    goto :goto_4

    .line 1545
    :cond_7
    if-ne v5, v6, :cond_a

    .line 1546
    const/4 v5, 0x0

    goto :goto_4

    .line 1538
    :pswitch_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 1539
    goto :goto_4

    .line 1524
    :pswitch_6
    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    move-result v6

    .line 1527
    :pswitch_7
    iget v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v7, v8, :cond_8

    .line 1528
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1530
    :cond_8
    iget-object v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v7, v7, v8

    const/16 v8, 0xa

    if-ne v7, v8, :cond_9

    .line 1531
    iget v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v7, v7, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1533
    :cond_9
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 1535
    const/16 v6, 0xa

    .line 1536
    nop

    .line 1565
    :cond_a
    :goto_4
    goto :goto_6

    .line 1569
    :cond_b
    if-lt v6, v8, :cond_10

    .line 1570
    const v7, 0xe000

    if-ge v6, v7, :cond_f

    .line 1572
    invoke-direct {p0, v6}, Lcom/fasterxml/aalto/in/ReaderScanner;->checkSurrogate(C)C

    move-result v7

    .line 1573
    .local v7, "d":C
    if-eqz v1, :cond_d

    .line 1574
    add-int/lit8 v8, v2, 0x1

    .end local v2    # "outPtr":I
    .local v8, "outPtr":I
    aput-char v6, v1, v2

    .line 1575
    array-length v2, v1

    if-lt v8, v2, :cond_c

    .line 1576
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v1

    .line 1577
    const/4 v2, 0x0

    .end local v8    # "outPtr":I
    .restart local v2    # "outPtr":I
    goto :goto_5

    .line 1575
    .end local v2    # "outPtr":I
    .restart local v8    # "outPtr":I
    :cond_c
    move v2, v8

    .line 1580
    .end local v8    # "outPtr":I
    .restart local v2    # "outPtr":I
    :cond_d
    :goto_5
    move v6, v7

    .line 1581
    .end local v7    # "d":C
    :cond_e
    goto :goto_6

    :cond_f
    const v7, 0xfffe

    if-lt v6, v7, :cond_e

    .line 1582
    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    move-result v6

    .line 1586
    :cond_10
    :goto_6
    if-eqz v1, :cond_11

    .line 1587
    add-int/lit8 v7, v2, 0x1

    .end local v2    # "outPtr":I
    .local v7, "outPtr":I
    aput-char v6, v1, v2

    move v2, v7

    .line 1589
    .end local v6    # "c":C
    .end local v7    # "outPtr":I
    .restart local v2    # "outPtr":I
    :cond_11
    goto/16 :goto_1

    .line 1514
    .restart local v6    # "c":C
    .local v7, "max":I
    .restart local v9    # "ptr":I
    :cond_12
    if-eqz v1, :cond_13

    .line 1515
    add-int/lit8 v8, v2, 0x1

    .end local v2    # "outPtr":I
    .restart local v8    # "outPtr":I
    aput-char v6, v1, v2

    move v2, v8

    move v6, v9

    goto/16 :goto_2

    .line 1514
    .end local v8    # "outPtr":I
    .restart local v2    # "outPtr":I
    :cond_13
    move v6, v9

    goto/16 :goto_2

    .line 1518
    .end local v9    # "ptr":I
    .local v6, "ptr":I
    :cond_14
    iput v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1519
    .end local v6    # "ptr":I
    .end local v7    # "max":I
    goto/16 :goto_1

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_6
        :pswitch_7
        :pswitch_5
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method protected final finishPI()V
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1372
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderScanner;->sCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 1373
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    .line 1374
    .local v1, "inputBuffer":[C
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v2

    .line 1375
    .local v2, "outputBuffer":[C
    const/4 v3, 0x0

    .line 1384
    .local v3, "outPtr":I
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1385
    .local v4, "ptr":I
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v4, v5, :cond_0

    .line 1386
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1387
    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1389
    :cond_0
    array-length v5, v2

    if-lt v3, v5, :cond_1

    .line 1390
    iget-object v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v5}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 1391
    const/4 v3, 0x0

    .line 1393
    :cond_1
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    .line 1395
    .local v5, "max":I
    array-length v6, v2

    sub-int/2addr v6, v3

    add-int/2addr v6, v4

    .line 1396
    .local v6, "max2":I
    if-ge v6, v5, :cond_2

    .line 1397
    move v5, v6

    .line 1400
    .end local v6    # "max2":I
    :cond_2
    :goto_1
    if-ge v4, v5, :cond_e

    .line 1401
    add-int/lit8 v6, v4, 0x1

    .end local v4    # "ptr":I
    .local v6, "ptr":I
    aget-char v4, v1, v4

    .line 1402
    .local v4, "c":C
    const v7, 0xd800

    const/16 v8, 0xff

    if-gt v4, v8, :cond_3

    .line 1403
    aget v9, v0, v4

    if-eqz v9, :cond_d

    .line 1404
    iput v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1405
    goto :goto_2

    .line 1407
    :cond_3
    if-lt v4, v7, :cond_d

    .line 1408
    iput v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1409
    nop

    .line 1416
    .end local v5    # "max":I
    .end local v6    # "ptr":I
    :goto_2
    if-gt v4, v8, :cond_8

    .line 1417
    aget v5, v0, v4

    sparse-switch v5, :sswitch_data_0

    goto :goto_3

    .line 1434
    :sswitch_0
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v5, v6, :cond_4

    .line 1435
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1437
    :cond_4
    iget-object v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v5, v5, v6

    const/16 v6, 0x3e

    if-ne v5, v6, :cond_7

    .line 1438
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v5, v5, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1439
    nop

    .line 1462
    .end local v4    # "c":C
    iget-object v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v4, v3}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 1463
    return-void

    .line 1431
    .restart local v4    # "c":C
    :sswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 1432
    goto :goto_3

    .line 1420
    :sswitch_2
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v5, v6, :cond_5

    .line 1421
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1423
    :cond_5
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v5, v1, v5

    const/16 v6, 0xa

    if-ne v5, v6, :cond_6

    .line 1424
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v5, v5, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1426
    :cond_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 1427
    const/16 v4, 0xa

    .line 1429
    nop

    .line 1441
    :cond_7
    :goto_3
    goto :goto_5

    .line 1445
    :cond_8
    if-lt v4, v7, :cond_c

    .line 1446
    const v5, 0xe000

    if-ge v4, v5, :cond_b

    .line 1448
    invoke-direct {p0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->checkSurrogate(C)C

    move-result v5

    .line 1449
    .local v5, "d":C
    add-int/lit8 v6, v3, 0x1

    .end local v3    # "outPtr":I
    .local v6, "outPtr":I
    aput-char v4, v2, v3

    .line 1450
    array-length v3, v2

    if-lt v6, v3, :cond_9

    .line 1451
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 1452
    const/4 v3, 0x0

    .end local v6    # "outPtr":I
    .restart local v3    # "outPtr":I
    goto :goto_4

    .line 1450
    .end local v3    # "outPtr":I
    .restart local v6    # "outPtr":I
    :cond_9
    move v3, v6

    .line 1454
    .end local v6    # "outPtr":I
    .restart local v3    # "outPtr":I
    :goto_4
    move v4, v5

    .line 1455
    .end local v5    # "d":C
    :cond_a
    goto :goto_5

    :cond_b
    const v5, 0xfffe

    if-lt v4, v5, :cond_a

    .line 1456
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    move-result v4

    .line 1460
    :cond_c
    :goto_5
    add-int/lit8 v5, v3, 0x1

    .end local v3    # "outPtr":I
    .local v5, "outPtr":I
    aput-char v4, v2, v3

    .line 1461
    .end local v4    # "c":C
    move v3, v5

    goto/16 :goto_0

    .line 1411
    .restart local v3    # "outPtr":I
    .restart local v4    # "c":C
    .local v5, "max":I
    .local v6, "ptr":I
    :cond_d
    add-int/lit8 v7, v3, 0x1

    .end local v3    # "outPtr":I
    .local v7, "outPtr":I
    aput-char v4, v2, v3

    move v4, v6

    move v3, v7

    goto/16 :goto_1

    .line 1413
    .end local v6    # "ptr":I
    .end local v7    # "outPtr":I
    .restart local v3    # "outPtr":I
    .local v4, "ptr":I
    :cond_e
    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1414
    .end local v4    # "ptr":I
    .end local v5    # "max":I
    goto/16 :goto_0

    :sswitch_data_0
    .sparse-switch
        0x2 -> :sswitch_2
        0x3 -> :sswitch_1
        0xc -> :sswitch_0
    .end sparse-switch
.end method

.method protected final finishSpace()V
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1931
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->mTmpChar:I

    int-to-char v0, v0

    .line 1935
    .local v0, "tmp":C
    const/16 v1, 0xa

    const/16 v2, 0xd

    if-eq v0, v2, :cond_1

    if-ne v0, v1, :cond_0

    goto :goto_0

    .line 1943
    :cond_0
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    move-result-object v3

    .line 1944
    .local v3, "outputBuffer":[C
    const/4 v4, 0x0

    aput-char v0, v3, v4

    .line 1945
    const/4 v4, 0x1

    .local v4, "outPtr":I
    goto :goto_1

    .line 1936
    .end local v3    # "outputBuffer":[C
    .end local v4    # "outPtr":I
    :cond_1
    :goto_0
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->checkPrologIndentation(C)I

    move-result v4

    .line 1937
    .restart local v4    # "outPtr":I
    if-gez v4, :cond_2

    .line 1938
    return-void

    .line 1941
    :cond_2
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/util/TextBuilder;->getBufferWithoutReset()[C

    move-result-object v3

    .line 1948
    .restart local v3    # "outputBuffer":[C
    :goto_1
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1951
    .local v5, "ptr":I
    :goto_2
    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v5, v6, :cond_4

    .line 1952
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMore()Z

    move-result v6

    if-nez v6, :cond_3

    .line 1953
    goto :goto_3

    .line 1955
    :cond_3
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1957
    :cond_4
    iget-object v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    aget-char v6, v6, v5

    .line 1958
    .local v6, "c":C
    const/16 v7, 0x20

    if-le v6, v7, :cond_5

    .line 1959
    goto :goto_3

    .line 1961
    :cond_5
    add-int/lit8 v5, v5, 0x1

    .line 1963
    if-ne v6, v1, :cond_6

    .line 1964
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF(I)V

    goto :goto_4

    .line 1965
    :cond_6
    if-ne v6, v2, :cond_b

    .line 1966
    iget v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v5, v7, :cond_9

    .line 1967
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMore()Z

    move-result v7

    if-nez v7, :cond_8

    .line 1968
    array-length v2, v3

    if-lt v4, v2, :cond_7

    .line 1969
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v2

    .line 1970
    .end local v3    # "outputBuffer":[C
    .local v2, "outputBuffer":[C
    const/4 v4, 0x0

    move-object v3, v2

    .line 1972
    .end local v2    # "outputBuffer":[C
    .restart local v3    # "outputBuffer":[C
    :cond_7
    add-int/lit8 v2, v4, 0x1

    .end local v4    # "outPtr":I
    .local v2, "outPtr":I
    aput-char v1, v3, v4

    .line 1973
    move v4, v2

    .line 1995
    .end local v2    # "outPtr":I
    .end local v6    # "c":C
    .restart local v4    # "outPtr":I
    :goto_3
    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1996
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v1, v4}, Lcom/fasterxml/aalto/util/TextBuilder;->setCurrentLength(I)V

    .line 1997
    return-void

    .line 1975
    .restart local v6    # "c":C
    :cond_8
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1977
    :cond_9
    iget-object v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    aget-char v7, v7, v5

    if-ne v7, v1, :cond_a

    .line 1978
    add-int/lit8 v5, v5, 0x1

    .line 1980
    :cond_a
    invoke-virtual {p0, v5}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF(I)V

    .line 1981
    const/16 v6, 0xa

    goto :goto_4

    .line 1982
    :cond_b
    if-eq v6, v7, :cond_c

    const/16 v7, 0x9

    if-eq v6, v7, :cond_c

    .line 1983
    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 1984
    invoke-virtual {p0, v6}, Lcom/fasterxml/aalto/in/ReaderScanner;->throwInvalidSpace(I)V

    .line 1988
    :cond_c
    :goto_4
    array-length v7, v3

    if-lt v4, v7, :cond_d

    .line 1989
    iget-object v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v7}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v3

    .line 1990
    const/4 v4, 0x0

    .line 1992
    :cond_d
    add-int/lit8 v7, v4, 0x1

    .end local v4    # "outPtr":I
    .local v7, "outPtr":I
    aput-char v6, v3, v4

    .line 1993
    .end local v6    # "c":C
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

    .line 146
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenIncomplete:Z

    .line 147
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currToken:I

    packed-switch v0, :pswitch_data_0

    .line 167
    :pswitch_0
    invoke-static {}, Lcom/fasterxml/aalto/impl/ErrorConsts;->throwInternalError()V

    goto :goto_0

    .line 164
    :pswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->finishCData()V

    .line 165
    goto :goto_0

    .line 161
    :pswitch_2
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->finishDTD(Z)V

    .line 162
    goto :goto_0

    .line 158
    :pswitch_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->finishSpace()V

    .line 159
    goto :goto_0

    .line 155
    :pswitch_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->finishComment()V

    .line 156
    goto :goto_0

    .line 152
    :pswitch_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->finishCharacters()V

    .line 153
    goto :goto_0

    .line 149
    :pswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->finishPI()V

    .line 150
    nop

    .line 169
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

.method public getCurrentColumnNr()I
    .locals 2

    .line 3282
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_rowStartOffset:I

    sub-int/2addr v0, v1

    return v0
.end method

.method public getCurrentLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
    .locals 7

    .line 3275
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    .line 3276
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getPublicId()Ljava/lang/String;

    move-result-object v1

    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getSystemId()Ljava/lang/String;

    move-result-object v2

    iget-wide v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_pastBytesOrChars:J

    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    int-to-long v5, v0

    add-long/2addr v3, v5

    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currRow:I

    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_rowStartOffset:I

    sub-int v6, v0, v6

    invoke-static/range {v1 .. v6}, Lcom/fasterxml/aalto/impl/LocationImpl;->fromZeroBased(Ljava/lang/String;Ljava/lang/String;JII)Lcom/fasterxml/aalto/impl/LocationImpl;

    move-result-object v0

    .line 3275
    return-object v0
.end method

.method public getEndingByteOffset()J
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3299
    const-wide/16 v0, -0x1

    return-wide v0
.end method

.method public getEndingCharOffset()J
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3305
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenIncomplete:Z

    if-eqz v0, :cond_0

    .line 3306
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->finishToken()V

    .line 3308
    :cond_0
    iget-wide v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_pastBytesOrChars:J

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    int-to-long v2, v2

    add-long/2addr v0, v2

    return-wide v0
.end method

.method public getStartingByteOffset()J
    .locals 2

    .line 3288
    const-wide/16 v0, -0x1

    return-wide v0
.end method

.method public getStartingCharOffset()J
    .locals 2

    .line 3293
    iget-wide v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_startRawOffset:J

    return-wide v0
.end method

.method protected final handleCharEntity()I
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 570
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 571
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 573
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v0, v1

    .line 574
    .local v0, "c":C
    const/4 v1, 0x0

    .line 575
    .local v1, "value":I
    const/16 v2, 0x78

    const v3, 0x10ffff

    const/16 v4, 0x39

    const/16 v5, 0x3b

    const/16 v6, 0xa

    const/16 v7, 0x30

    if-ne v0, v2, :cond_7

    .line 577
    :cond_1
    :goto_0
    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v2, v8, :cond_2

    .line 578
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 580
    :cond_2
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v2, v8

    .line 581
    if-ne v0, v5, :cond_3

    .line 582
    goto :goto_4

    .line 584
    :cond_3
    shl-int/lit8 v1, v1, 0x4

    .line 585
    if-gt v0, v4, :cond_4

    if-lt v0, v7, :cond_4

    .line 586
    add-int/lit8 v2, v0, -0x30

    add-int/2addr v1, v2

    goto :goto_1

    .line 587
    :cond_4
    const/16 v2, 0x61

    if-lt v0, v2, :cond_5

    const/16 v2, 0x66

    if-gt v0, v2, :cond_5

    .line 588
    add-int/lit8 v2, v0, -0x61

    add-int/2addr v2, v6

    add-int/2addr v1, v2

    goto :goto_1

    .line 589
    :cond_5
    const/16 v2, 0x41

    if-lt v0, v2, :cond_6

    const/16 v2, 0x46

    if-gt v0, v2, :cond_6

    .line 590
    add-int/lit8 v2, v0, -0x41

    add-int/2addr v2, v6

    add-int/2addr v1, v2

    goto :goto_1

    .line 592
    :cond_6
    const-string v2, "; expected a hex digit (0-9a-fA-F)"

    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 594
    :goto_1
    if-le v1, v3, :cond_1

    .line 595
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportEntityOverflow()V

    goto :goto_0

    .line 599
    :cond_7
    :goto_2
    if-eq v0, v5, :cond_b

    .line 600
    if-gt v0, v4, :cond_9

    if-lt v0, v7, :cond_9

    .line 601
    mul-int/lit8 v2, v1, 0xa

    add-int/lit8 v8, v0, -0x30

    add-int/2addr v2, v8

    .line 602
    .end local v1    # "value":I
    .local v2, "value":I
    if-le v2, v3, :cond_8

    .line 603
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportEntityOverflow()V

    .line 608
    :cond_8
    move v1, v2

    goto :goto_3

    .line 606
    .end local v2    # "value":I
    .restart local v1    # "value":I
    :cond_9
    const-string v2, "; expected a decimal number"

    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 608
    :goto_3
    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v2, v8, :cond_a

    .line 609
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 611
    :cond_a
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v2, v8

    goto :goto_2

    .line 616
    :cond_b
    :goto_4
    const v2, 0xd800

    if-lt v1, v2, :cond_e

    .line 617
    const v2, 0xe000

    if-ge v1, v2, :cond_c

    .line 618
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInvalidXmlChar(I)V

    .line 620
    :cond_c
    const v2, 0xfffe

    if-eq v1, v2, :cond_d

    const v2, 0xffff

    if-ne v1, v2, :cond_10

    .line 621
    :cond_d
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInvalidXmlChar(I)V

    goto :goto_5

    .line 623
    :cond_e
    const/16 v2, 0x20

    if-ge v1, v2, :cond_10

    .line 625
    if-eq v1, v6, :cond_10

    const/16 v2, 0xd

    if-eq v1, v2, :cond_10

    const/16 v2, 0x9

    if-eq v1, v2, :cond_10

    .line 626
    iget-boolean v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_xml11:Z

    if-eqz v2, :cond_f

    if-nez v1, :cond_10

    .line 627
    :cond_f
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInvalidXmlChar(I)V

    .line 631
    :cond_10
    :goto_5
    return v1
.end method

.method protected final handleCommentOrCdataStart()I
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 440
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 441
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 443
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v0, v1

    .line 446
    .local v0, "c":C
    const/16 v1, 0x2d

    const/4 v2, 0x1

    if-ne v0, v1, :cond_4

    .line 447
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v3, v4, :cond_1

    .line 448
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 450
    :cond_1
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v3, v4

    .line 451
    if-eq v0, v1, :cond_2

    .line 452
    const-string v1, " (expected \'-\' for COMMENT)"

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 454
    :cond_2
    iget-boolean v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_cfgLazyParsing:Z

    if-eqz v1, :cond_3

    .line 455
    iput-boolean v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenIncomplete:Z

    goto :goto_0

    .line 457
    :cond_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->finishComment()V

    .line 459
    :goto_0
    const/4 v1, 0x5

    iput v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currToken:I

    return v1

    .line 463
    :cond_4
    const/16 v1, 0x5b

    if-ne v0, v1, :cond_9

    .line 464
    const/16 v1, 0xc

    iput v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currToken:I

    .line 465
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_1
    const/4 v4, 0x6

    if-ge v3, v4, :cond_7

    .line 466
    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v4, v5, :cond_5

    .line 467
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 469
    :cond_5
    iget-object v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v4, v5

    .line 470
    const-string v4, "CDATA["

    invoke-virtual {v4, v3}, Ljava/lang/String;->charAt(I)C

    move-result v5

    if-eq v0, v5, :cond_6

    .line 471
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, " (expected \'"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v4, v3}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "\' for CDATA section)"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 465
    :cond_6
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 474
    .end local v3    # "i":I
    :cond_7
    iget-boolean v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_cfgLazyParsing:Z

    if-eqz v3, :cond_8

    .line 475
    iput-boolean v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenIncomplete:Z

    goto :goto_2

    .line 477
    :cond_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->finishCData()V

    .line 479
    :goto_2
    return v1

    .line 481
    :cond_9
    const-string v1, " (expected either \'-\' for COMMENT or \'[CDATA[\' for CDATA section)"

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 482
    const/4 v1, -0x1

    return v1
.end method

.method protected final handleEndElement()I
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1020
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_depth:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_depth:I

    .line 1022
    const/4 v0, 0x2

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currToken:I

    .line 1024
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currElem:Lcom/fasterxml/aalto/in/ElementScope;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/ElementScope;->getName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 1025
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v1

    .line 1027
    .local v1, "pname":Ljava/lang/String;
    const/4 v2, 0x0

    .line 1028
    .local v2, "i":I
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v3

    .line 1030
    .local v3, "len":I
    :cond_0
    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v4, v5, :cond_1

    .line 1031
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1033
    :cond_1
    iget-object v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v4, v4, v5

    .line 1034
    .local v4, "c":C
    invoke-virtual {v1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v5

    if-eq v4, v5, :cond_2

    .line 1035
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportUnexpectedEndTag(Ljava/lang/String;)V

    .line 1037
    :cond_2
    add-int/lit8 v2, v2, 0x1

    if-lt v2, v3, :cond_0

    .line 1040
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v5, v6, :cond_3

    .line 1041
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1043
    :cond_3
    iget-object v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v4, v5, v6

    .line 1044
    const/16 v5, 0x20

    const/16 v6, 0x3e

    if-gt v4, v5, :cond_4

    .line 1045
    const/4 v5, 0x0

    const/4 v7, 0x0

    invoke-virtual {p0, v5, v7}, Lcom/fasterxml/aalto/in/ReaderScanner;->skipInternalWs(ZLjava/lang/String;)C

    move-result v4

    goto :goto_0

    .line 1046
    :cond_4
    if-eq v4, v6, :cond_6

    .line 1047
    const/16 v5, 0x3a

    if-eq v4, v5, :cond_5

    invoke-static {v4}, Lcom/fasterxml/aalto/util/XmlChars;->is10NameChar(I)Z

    move-result v5

    if-eqz v5, :cond_6

    .line 1048
    :cond_5
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportUnexpectedEndTag(Ljava/lang/String;)V

    .line 1051
    :cond_6
    :goto_0
    if-eq v4, v6, :cond_7

    .line 1052
    const-string v5, " expected space or closing \'>\'"

    invoke-virtual {p0, v4, v5}, Lcom/fasterxml/aalto/in/ReaderScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1054
    :cond_7
    return v0
.end method

.method protected final handleEntityInText(Z)I
    .locals 10
    .param p1, "inAttr"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1060
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 1061
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1063
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v0, v1

    .line 1064
    .local v0, "c":C
    const/16 v1, 0x23

    if-ne v0, v1, :cond_1

    .line 1065
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleCharEntity()I

    move-result v1

    return v1

    .line 1068
    :cond_1
    const/16 v1, 0x61

    const/16 v2, 0x6f

    const/16 v3, 0x3b

    if-ne v0, v1, :cond_f

    .line 1069
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v1, v4, :cond_2

    .line 1070
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1072
    :cond_2
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v1, v4

    .line 1073
    const/16 v1, 0x6d

    const/16 v4, 0x70

    if-ne v0, v1, :cond_7

    .line 1074
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v1, v2, :cond_3

    .line 1075
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1077
    :cond_3
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v5, v2, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v1, v2

    .line 1078
    if-ne v0, v4, :cond_6

    .line 1079
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v1, v2, :cond_4

    .line 1080
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1082
    :cond_4
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v1, v2

    .line 1083
    if-ne v0, v3, :cond_5

    .line 1084
    const/16 v1, 0x26

    return v1

    .line 1086
    :cond_5
    const-string v1, "amp"

    .local v1, "start":Ljava/lang/String;
    goto/16 :goto_0

    .line 1088
    .end local v1    # "start":Ljava/lang/String;
    :cond_6
    const-string v1, "am"

    .restart local v1    # "start":Ljava/lang/String;
    goto/16 :goto_0

    .line 1090
    .end local v1    # "start":Ljava/lang/String;
    :cond_7
    if-ne v0, v4, :cond_e

    .line 1091
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v1, v4, :cond_8

    .line 1092
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1094
    :cond_8
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v1, v4

    .line 1095
    if-ne v0, v2, :cond_d

    .line 1096
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v1, v2, :cond_9

    .line 1097
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1099
    :cond_9
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v1, v2

    .line 1100
    const/16 v1, 0x73

    if-ne v0, v1, :cond_c

    .line 1101
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v1, v2, :cond_a

    .line 1102
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1104
    :cond_a
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v1, v2

    .line 1105
    if-ne v0, v3, :cond_b

    .line 1106
    const/16 v1, 0x27

    return v1

    .line 1108
    :cond_b
    const-string v1, "apos"

    .restart local v1    # "start":Ljava/lang/String;
    goto/16 :goto_0

    .line 1110
    .end local v1    # "start":Ljava/lang/String;
    :cond_c
    const-string v1, "apo"

    .restart local v1    # "start":Ljava/lang/String;
    goto/16 :goto_0

    .line 1113
    .end local v1    # "start":Ljava/lang/String;
    :cond_d
    const-string v1, "ap"

    .restart local v1    # "start":Ljava/lang/String;
    goto/16 :goto_0

    .line 1116
    .end local v1    # "start":Ljava/lang/String;
    :cond_e
    const-string v1, "a"

    .restart local v1    # "start":Ljava/lang/String;
    goto/16 :goto_0

    .line 1118
    .end local v1    # "start":Ljava/lang/String;
    :cond_f
    const/16 v1, 0x6c

    const/16 v4, 0x74

    if-ne v0, v1, :cond_14

    .line 1119
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v1, v2, :cond_10

    .line 1120
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1122
    :cond_10
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v5, v2, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v1, v2

    .line 1123
    if-ne v0, v4, :cond_13

    .line 1124
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v1, v2, :cond_11

    .line 1125
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1127
    :cond_11
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v1, v2

    .line 1128
    if-ne v0, v3, :cond_12

    .line 1129
    const/16 v1, 0x3c

    return v1

    .line 1131
    :cond_12
    const-string v1, "lt"

    .restart local v1    # "start":Ljava/lang/String;
    goto/16 :goto_0

    .line 1133
    .end local v1    # "start":Ljava/lang/String;
    :cond_13
    const-string v1, "l"

    .restart local v1    # "start":Ljava/lang/String;
    goto/16 :goto_0

    .line 1135
    .end local v1    # "start":Ljava/lang/String;
    :cond_14
    const/16 v1, 0x67

    if-ne v0, v1, :cond_19

    .line 1136
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v1, v2, :cond_15

    .line 1137
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1139
    :cond_15
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v5, v2, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v1, v2

    .line 1140
    if-ne v0, v4, :cond_18

    .line 1141
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v1, v2, :cond_16

    .line 1142
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1144
    :cond_16
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v1, v2

    .line 1145
    if-ne v0, v3, :cond_17

    .line 1146
    const/16 v1, 0x3e

    return v1

    .line 1148
    :cond_17
    const-string v1, "gt"

    .restart local v1    # "start":Ljava/lang/String;
    goto/16 :goto_0

    .line 1150
    .end local v1    # "start":Ljava/lang/String;
    :cond_18
    const-string v1, "g"

    .restart local v1    # "start":Ljava/lang/String;
    goto :goto_0

    .line 1152
    .end local v1    # "start":Ljava/lang/String;
    :cond_19
    const/16 v1, 0x71

    if-ne v0, v1, :cond_22

    .line 1153
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v1, v5, :cond_1a

    .line 1154
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1156
    :cond_1a
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v1, v5

    .line 1157
    const/16 v1, 0x75

    if-ne v0, v1, :cond_21

    .line 1158
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v1, v5, :cond_1b

    .line 1159
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1161
    :cond_1b
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v1, v5

    .line 1162
    if-ne v0, v2, :cond_20

    .line 1163
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v1, v2, :cond_1c

    .line 1164
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1166
    :cond_1c
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v5, v2, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v1, v2

    .line 1167
    if-ne v0, v4, :cond_1f

    .line 1168
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v1, v2, :cond_1d

    .line 1169
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1171
    :cond_1d
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v4, v2, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v1, v2

    .line 1172
    if-ne v0, v3, :cond_1e

    .line 1173
    const/16 v1, 0x22

    return v1

    .line 1175
    :cond_1e
    const-string v1, "quot"

    .restart local v1    # "start":Ljava/lang/String;
    goto :goto_0

    .line 1177
    .end local v1    # "start":Ljava/lang/String;
    :cond_1f
    const-string v1, "quo"

    .restart local v1    # "start":Ljava/lang/String;
    goto :goto_0

    .line 1180
    .end local v1    # "start":Ljava/lang/String;
    :cond_20
    const-string v1, "qu"

    .restart local v1    # "start":Ljava/lang/String;
    goto :goto_0

    .line 1183
    .end local v1    # "start":Ljava/lang/String;
    :cond_21
    const-string v1, "q"

    .restart local v1    # "start":Ljava/lang/String;
    goto :goto_0

    .line 1186
    .end local v1    # "start":Ljava/lang/String;
    :cond_22
    const-string v1, ""

    .line 1189
    .restart local v1    # "start":Ljava/lang/String;
    :goto_0
    sget-object v2, Lcom/fasterxml/aalto/in/ReaderScanner;->sCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v2, v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->NAME_CHARS:[I

    .line 1194
    .local v2, "TYPES":[I
    iget-object v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_nameBuffer:[C

    .line 1195
    .local v4, "cbuf":[C
    const/4 v5, 0x0

    .line 1196
    .local v5, "cix":I
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v6

    .local v6, "len":I
    :goto_1
    if-ge v5, v6, :cond_23

    .line 1197
    invoke-virtual {v1, v5}, Ljava/lang/String;->charAt(I)C

    move-result v7

    aput-char v7, v4, v5

    .line 1196
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 1200
    .end local v6    # "len":I
    :cond_23
    :goto_2
    const/4 v6, 0x0

    if-eq v0, v3, :cond_2c

    .line 1204
    const/16 v7, 0xff

    const/4 v8, 0x1

    if-gt v0, v7, :cond_25

    .line 1205
    aget v7, v2, v0

    packed-switch v7, :pswitch_data_0

    .line 1215
    const/4 v6, 0x0

    .line 1216
    .local v6, "ok":Z
    goto :goto_3

    .line 1212
    .end local v6    # "ok":Z
    :pswitch_0
    const/4 v6, 0x1

    .line 1213
    .restart local v6    # "ok":Z
    goto :goto_3

    .line 1209
    .end local v6    # "ok":Z
    :pswitch_1
    if-lez v5, :cond_24

    move v6, v8

    .line 1210
    .restart local v6    # "ok":Z
    :cond_24
    goto :goto_3

    .line 1219
    .end local v6    # "ok":Z
    :cond_25
    const v6, 0xe000

    if-ge v0, v6, :cond_27

    .line 1221
    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->decodeSurrogate(C)I

    move-result v6

    .line 1222
    .local v6, "value":I
    array-length v7, v4

    if-lt v5, v7, :cond_26

    .line 1223
    array-length v7, v4

    invoke-static {v4, v7}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v7

    move-object v4, v7

    iput-object v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_nameBuffer:[C

    .line 1225
    :cond_26
    add-int/lit8 v7, v5, 0x1

    .end local v5    # "cix":I
    .local v7, "cix":I
    aput-char v0, v4, v5

    .line 1226
    iget-object v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v9, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    sub-int/2addr v9, v8

    aget-char v0, v5, v9

    .line 1227
    invoke-static {v6}, Lcom/fasterxml/aalto/util/XmlChars;->is10NameChar(I)Z

    move-result v6

    .line 1228
    .local v6, "ok":Z
    move v5, v7

    goto :goto_3

    .end local v6    # "ok":Z
    .end local v7    # "cix":I
    .restart local v5    # "cix":I
    :cond_27
    const v6, 0xfffe

    if-lt v0, v6, :cond_28

    .line 1229
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    move-result v0

    .line 1230
    const/4 v6, 0x0

    .restart local v6    # "ok":Z
    goto :goto_3

    .line 1232
    .end local v6    # "ok":Z
    :cond_28
    const/4 v6, 0x1

    .line 1235
    .restart local v6    # "ok":Z
    :goto_3
    if-nez v6, :cond_29

    .line 1236
    invoke-virtual {p0, v0, v5}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInvalidNameChar(II)V

    .line 1238
    :cond_29
    array-length v7, v4

    if-lt v5, v7, :cond_2a

    .line 1239
    array-length v7, v4

    invoke-static {v4, v7}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v7

    move-object v4, v7

    iput-object v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_nameBuffer:[C

    .line 1241
    :cond_2a
    add-int/lit8 v7, v5, 0x1

    .end local v5    # "cix":I
    .restart local v7    # "cix":I
    aput-char v0, v4, v5

    .line 1242
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v5, v8, :cond_2b

    .line 1243
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 1245
    :cond_2b
    iget-object v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v8, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v9, v8, 0x1

    iput v9, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v5, v8

    .line 1246
    .end local v6    # "ok":Z
    move v5, v7

    goto :goto_2

    .line 1249
    .end local v7    # "cix":I
    .restart local v5    # "cix":I
    :cond_2c
    new-instance v3, Ljava/lang/String;

    invoke-direct {v3, v4, v6, v5}, Ljava/lang/String;-><init>([CII)V

    .line 1251
    .local v3, "pname":Ljava/lang/String;
    new-instance v7, Lcom/fasterxml/aalto/in/PNameC;

    const/4 v8, 0x0

    invoke-direct {v7, v3, v8, v3, v6}, Lcom/fasterxml/aalto/in/PNameC;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    iput-object v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 1256
    iget-object v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v7}, Lcom/fasterxml/aalto/in/ReaderConfig;->willExpandEntities()Z

    move-result v7

    const-string v8, "General entity reference (&"

    if-eqz v7, :cond_2d

    .line 1257
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

    invoke-virtual {p0, v7}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1259
    :cond_2d
    if-eqz p1, :cond_2e

    .line 1260
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

    invoke-virtual {p0, v7}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1262
    :cond_2e
    return v6

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method protected final handlePIStart()I
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 488
    const/4 v0, 0x3

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currToken:I

    .line 491
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v1, v2, :cond_0

    .line 492
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 495
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v1, v1, v2

    .line 496
    .local v1, "c":C
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->parsePName(C)Lcom/fasterxml/aalto/in/PName;

    move-result-object v2

    iput-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 498
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/in/PName;->getLocalName()Ljava/lang/String;

    move-result-object v2

    .line 499
    .local v2, "ln":Ljava/lang/String;
    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v3

    if-ne v3, v0, :cond_1

    const-string/jumbo v3, "xml"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 500
    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/PName;->getPrefix()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    .line 501
    sget-object v3, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_WF_PI_XML_TARGET:Ljava/lang/String;

    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 509
    .end local v2    # "ln":Ljava/lang/String;
    :cond_1
    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v2, v3, :cond_2

    .line 510
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 512
    :cond_2
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v1, v2, v3

    .line 513
    const/16 v2, 0x20

    if-gt v1, v2, :cond_b

    .line 516
    :goto_0
    const/16 v3, 0xa

    const/4 v4, 0x1

    if-ne v1, v3, :cond_3

    .line 517
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    goto :goto_1

    .line 518
    :cond_3
    const/16 v5, 0xd

    if-ne v1, v5, :cond_6

    .line 519
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v5, v6, :cond_4

    .line 520
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 522
    :cond_4
    iget-object v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v5, v5, v6

    if-ne v5, v3, :cond_5

    .line 523
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v3, v4

    iput v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 525
    :cond_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    goto :goto_1

    .line 526
    :cond_6
    if-eq v1, v2, :cond_7

    const/16 v3, 0x9

    if-eq v1, v3, :cond_7

    .line 527
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->throwInvalidSpace(I)V

    .line 529
    :cond_7
    :goto_1
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v3, v5, :cond_8

    .line 530
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 532
    :cond_8
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v1, v3, v5

    .line 533
    if-le v1, v2, :cond_a

    .line 534
    nop

    .line 539
    iget-boolean v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_cfgLazyParsing:Z

    if-eqz v2, :cond_9

    .line 540
    iput-boolean v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenIncomplete:Z

    goto :goto_2

    .line 542
    :cond_9
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->finishPI()V

    goto :goto_2

    .line 536
    :cond_a
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v3, v4

    iput v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    goto :goto_0

    .line 545
    :cond_b
    const/16 v2, 0x3f

    if-eq v1, v2, :cond_c

    .line 546
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportMissingPISpace(I)V

    .line 548
    :cond_c
    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v2, v3, :cond_d

    .line 549
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 551
    :cond_d
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v1, v2, v3

    .line 552
    const/16 v2, 0x3e

    if-eq v1, v2, :cond_e

    .line 553
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportMissingPISpace(I)V

    .line 555
    :cond_e
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/util/TextBuilder;->resetWithEmpty()[C

    .line 556
    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenIncomplete:Z

    .line 559
    :goto_2
    return v0
.end method

.method protected final handlePrologDeclStart(Z)I
    .locals 6
    .param p1, "isProlog"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 347
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 348
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 350
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v0, v1

    .line 351
    .local v0, "c":C
    const/16 v1, 0x2d

    const/4 v2, 0x1

    if-ne v0, v1, :cond_3

    .line 352
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v3, v4, :cond_1

    .line 353
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 355
    :cond_1
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v3, v4

    .line 356
    if-ne v0, v1, :cond_5

    .line 357
    iget-boolean v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_cfgLazyParsing:Z

    if-eqz v1, :cond_2

    .line 358
    iput-boolean v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenIncomplete:Z

    goto :goto_0

    .line 360
    :cond_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->finishComment()V

    .line 362
    :goto_0
    const/4 v1, 0x5

    iput v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currToken:I

    return v1

    .line 364
    :cond_3
    const/16 v1, 0x44

    if-ne v0, v1, :cond_5

    .line 365
    if-eqz p1, :cond_5

    .line 366
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleDtdStart()I

    .line 368
    iget-boolean v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_cfgLazyParsing:Z

    if-nez v1, :cond_4

    .line 369
    iget-boolean v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenIncomplete:Z

    if-eqz v1, :cond_4

    .line 370
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->finishDTD(Z)V

    .line 371
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenIncomplete:Z

    .line 374
    :cond_4
    const/16 v1, 0xb

    return v1

    .line 381
    :cond_5
    iput-boolean v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenIncomplete:Z

    .line 382
    const/4 v1, 0x4

    iput v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currToken:I

    .line 383
    const-string v1, " (expected \'-\' for COMMENT)"

    invoke-virtual {p0, p1, v0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    .line 384
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currToken:I

    return v1
.end method

.method protected final handleStartElement(C)I
    .locals 16
    .param p1, "c"    # C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 637
    move-object/from16 v0, p0

    const/4 v1, 0x1

    iput v1, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currToken:I

    .line 638
    const/4 v2, 0x0

    iput v2, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currNsCount:I

    .line 639
    invoke-virtual/range {p0 .. p1}, Lcom/fasterxml/aalto/in/ReaderScanner;->parsePName(C)Lcom/fasterxml/aalto/in/PName;

    move-result-object v3

    .line 645
    .local v3, "elemName":Lcom/fasterxml/aalto/in/PName;
    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/PName;->getPrefix()Ljava/lang/String;

    move-result-object v4

    .line 648
    .local v4, "prefix":Ljava/lang/String;
    if-nez v4, :cond_0

    .line 649
    const/4 v5, 0x1

    .local v5, "allBound":Z
    goto :goto_0

    .line 651
    .end local v5    # "allBound":Z
    :cond_0
    invoke-virtual {v0, v3, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->bindName(Lcom/fasterxml/aalto/in/PName;Ljava/lang/String;)Lcom/fasterxml/aalto/in/PName;

    move-result-object v3

    .line 652
    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/PName;->isBound()Z

    move-result v5

    .line 655
    .restart local v5    # "allBound":Z
    :goto_0
    iput-object v3, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 656
    new-instance v6, Lcom/fasterxml/aalto/in/ElementScope;

    iget-object v7, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currElem:Lcom/fasterxml/aalto/in/ElementScope;

    invoke-direct {v6, v3, v7}, Lcom/fasterxml/aalto/in/ElementScope;-><init>(Lcom/fasterxml/aalto/in/PName;Lcom/fasterxml/aalto/in/ElementScope;)V

    iput-object v6, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currElem:Lcom/fasterxml/aalto/in/ElementScope;

    .line 659
    const/4 v6, 0x0

    move v7, v6

    move v6, v5

    move-object v5, v4

    move/from16 v4, p1

    .line 662
    .end local p1    # "c":C
    .local v4, "c":C
    .local v5, "prefix":Ljava/lang/String;
    .local v6, "allBound":Z
    .local v7, "attrPtr":I
    :goto_1
    iget v8, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v9, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v8, v9, :cond_1

    .line 663
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 665
    :cond_1
    iget-object v8, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v9, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v10, v9, 0x1

    iput v10, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v4, v8, v9

    .line 667
    const/16 v8, 0x2f

    const/16 v9, 0x9

    const/16 v10, 0x3e

    const/16 v11, 0xd

    const/16 v12, 0xa

    const/16 v13, 0x20

    if-gt v4, v13, :cond_9

    .line 669
    :goto_2
    if-ne v4, v12, :cond_2

    .line 670
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    goto :goto_3

    .line 671
    :cond_2
    if-ne v4, v11, :cond_5

    .line 672
    iget v14, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v15, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v14, v15, :cond_3

    .line 673
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 675
    :cond_3
    iget-object v14, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v15, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v14, v14, v15

    if-ne v14, v12, :cond_4

    .line 676
    iget v14, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v14, v1

    iput v14, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 678
    :cond_4
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    goto :goto_3

    .line 679
    :cond_5
    if-eq v4, v13, :cond_6

    if-eq v4, v9, :cond_6

    .line 680
    invoke-virtual {v0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->throwInvalidSpace(I)V

    .line 682
    :cond_6
    :goto_3
    iget v14, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v15, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v14, v15, :cond_7

    .line 683
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 685
    :cond_7
    iget-object v14, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v15, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v9, v15, 0x1

    iput v9, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v4, v14, v15

    .line 686
    if-le v4, v13, :cond_8

    goto :goto_4

    :cond_8
    const/16 v9, 0x9

    goto :goto_2

    .line 687
    :cond_9
    if-eq v4, v8, :cond_a

    if-eq v4, v10, :cond_a

    .line 688
    const-string v9, " expected space, or \'>\' or \"/>\""

    invoke-virtual {v0, v4, v9}, Lcom/fasterxml/aalto/in/ReaderScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 692
    :cond_a
    :goto_4
    if-ne v4, v8, :cond_d

    .line 693
    iget v8, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v9, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v8, v9, :cond_b

    .line 694
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 696
    :cond_b
    iget-object v8, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v9, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v11, v9, 0x1

    iput v11, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v4, v8, v9

    .line 697
    if-eq v4, v10, :cond_c

    .line 698
    const-string v8, " expected \'>\'"

    invoke-virtual {v0, v4, v8}, Lcom/fasterxml/aalto/in/ReaderScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 700
    :cond_c
    iput-boolean v1, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_isEmptyTag:Z

    .line 701
    goto :goto_5

    .line 702
    :cond_d
    if-ne v4, v10, :cond_12

    .line 703
    iput-boolean v2, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_isEmptyTag:Z

    .line 704
    nop

    .line 799
    :goto_5
    iget-object v8, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v8, v7}, Lcom/fasterxml/aalto/in/AttributeCollector;->finishLastValue(I)I

    move-result v8

    .line 800
    .local v8, "act":I
    if-gez v8, :cond_e

    .line 801
    iget-object v9, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v9}, Lcom/fasterxml/aalto/in/AttributeCollector;->getCount()I

    move-result v8

    .line 802
    iget-object v9, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v9}, Lcom/fasterxml/aalto/in/AttributeCollector;->getErrorMsg()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v0, v9}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 804
    :cond_e
    iput v8, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_attrCount:I

    .line 806
    .end local v8    # "act":I
    iget v8, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_depth:I

    add-int/2addr v8, v1

    iput v8, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_depth:I

    .line 812
    if-nez v6, :cond_11

    .line 813
    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/PName;->isBound()Z

    move-result v8

    if-nez v8, :cond_f

    .line 814
    iget-object v8, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v0, v8, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportUnboundPrefix(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 816
    :cond_f
    const/4 v2, 0x0

    .local v2, "i":I
    iget v8, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_attrCount:I

    .local v8, "len":I
    :goto_6
    if-ge v2, v8, :cond_11

    .line 817
    iget-object v9, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v9, v2}, Lcom/fasterxml/aalto/in/AttributeCollector;->getName(I)Lcom/fasterxml/aalto/in/PName;

    move-result-object v9

    .line 818
    .local v9, "attrName":Lcom/fasterxml/aalto/in/PName;
    invoke-virtual {v9}, Lcom/fasterxml/aalto/in/PName;->isBound()Z

    move-result v10

    if-nez v10, :cond_10

    .line 819
    invoke-virtual {v0, v9, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportUnboundPrefix(Lcom/fasterxml/aalto/in/PName;Z)V

    .line 816
    .end local v9    # "attrName":Lcom/fasterxml/aalto/in/PName;
    :cond_10
    add-int/lit8 v2, v2, 0x1

    goto :goto_6

    .line 824
    .end local v2    # "i":I
    .end local v8    # "len":I
    :cond_11
    return v1

    .line 705
    :cond_12
    const/16 v8, 0x3c

    if-ne v4, v8, :cond_13

    .line 706
    const-string v8, "Unexpected \'<\' character in element (missing closing \'>\'?)"

    invoke-virtual {v0, v8}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 710
    :cond_13
    invoke-virtual {v0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->parsePName(C)Lcom/fasterxml/aalto/in/PName;

    move-result-object v8

    .line 711
    .local v8, "attrName":Lcom/fasterxml/aalto/in/PName;
    invoke-virtual {v8}, Lcom/fasterxml/aalto/in/PName;->getPrefix()Ljava/lang/String;

    move-result-object v5

    .line 715
    const-string/jumbo v9, "xmlns"

    if-nez v5, :cond_15

    .line 716
    invoke-virtual {v8}, Lcom/fasterxml/aalto/in/PName;->getLocalName()Ljava/lang/String;

    move-result-object v10

    if-ne v10, v9, :cond_14

    move v9, v1

    goto :goto_7

    :cond_14
    move v9, v2

    .local v9, "isNsDecl":Z
    :goto_7
    goto :goto_8

    .line 719
    .end local v9    # "isNsDecl":Z
    :cond_15
    if-ne v5, v9, :cond_16

    .line 720
    const/4 v9, 0x1

    .restart local v9    # "isNsDecl":Z
    goto :goto_8

    .line 722
    .end local v9    # "isNsDecl":Z
    :cond_16
    invoke-virtual {v0, v8, v5}, Lcom/fasterxml/aalto/in/ReaderScanner;->bindName(Lcom/fasterxml/aalto/in/PName;Ljava/lang/String;)Lcom/fasterxml/aalto/in/PName;

    move-result-object v8

    .line 723
    if-eqz v6, :cond_17

    .line 724
    invoke-virtual {v8}, Lcom/fasterxml/aalto/in/PName;->isBound()Z

    move-result v6

    .line 726
    :cond_17
    const/4 v9, 0x0

    .line 732
    .restart local v9    # "isNsDecl":Z
    :cond_18
    :goto_8
    iget v10, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v14, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v10, v14, :cond_19

    .line 733
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 735
    :cond_19
    iget-object v10, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v14, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v15, v14, 0x1

    iput v15, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v4, v10, v14

    .line 736
    if-le v4, v13, :cond_23

    .line 737
    nop

    .line 754
    const/16 v10, 0x3d

    if-eq v4, v10, :cond_1a

    .line 755
    const-string v10, " expected \'=\'"

    invoke-virtual {v0, v4, v10}, Lcom/fasterxml/aalto/in/ReaderScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 760
    :cond_1a
    :goto_9
    iget v10, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v14, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v10, v14, :cond_1b

    .line 761
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 763
    :cond_1b
    iget-object v10, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v14, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v15, v14, 0x1

    iput v15, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v4, v10, v14

    .line 764
    if-le v4, v13, :cond_1e

    .line 765
    nop

    .line 782
    const/16 v10, 0x22

    if-eq v4, v10, :cond_1c

    const/16 v10, 0x27

    if-eq v4, v10, :cond_1c

    .line 783
    const-string v10, " Expected a quote"

    invoke-virtual {v0, v4, v10}, Lcom/fasterxml/aalto/in/ReaderScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 790
    :cond_1c
    if-eqz v9, :cond_1d

    .line 791
    invoke-direct {v0, v8, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleNsDeclaration(Lcom/fasterxml/aalto/in/PName;C)V

    .line 792
    iget v10, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currNsCount:I

    add-int/2addr v10, v1

    iput v10, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currNsCount:I

    goto :goto_a

    .line 794
    :cond_1d
    invoke-direct {v0, v7, v4, v8}, Lcom/fasterxml/aalto/in/ReaderScanner;->collectValue(ICLcom/fasterxml/aalto/in/PName;)I

    move-result v7

    .line 796
    .end local v8    # "attrName":Lcom/fasterxml/aalto/in/PName;
    .end local v9    # "isNsDecl":Z
    :goto_a
    goto/16 :goto_1

    .line 767
    .restart local v8    # "attrName":Lcom/fasterxml/aalto/in/PName;
    .restart local v9    # "isNsDecl":Z
    :cond_1e
    if-ne v4, v12, :cond_1f

    .line 768
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    goto :goto_9

    .line 769
    :cond_1f
    if-ne v4, v11, :cond_22

    .line 770
    iget v10, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v14, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v10, v14, :cond_20

    .line 771
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 773
    :cond_20
    iget-object v10, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v14, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v10, v10, v14

    if-ne v10, v12, :cond_21

    .line 774
    iget v10, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v10, v1

    iput v10, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 776
    :cond_21
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    goto :goto_9

    .line 777
    :cond_22
    if-eq v4, v13, :cond_1a

    const/16 v10, 0x9

    if-eq v4, v10, :cond_1a

    .line 778
    invoke-virtual {v0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->throwInvalidSpace(I)V

    goto :goto_9

    .line 739
    :cond_23
    if-ne v4, v12, :cond_24

    .line 740
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    const/16 v10, 0x9

    goto/16 :goto_8

    .line 741
    :cond_24
    if-ne v4, v11, :cond_27

    .line 742
    iget v10, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v14, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v10, v14, :cond_25

    .line 743
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 745
    :cond_25
    iget-object v10, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v14, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v10, v10, v14

    if-ne v10, v12, :cond_26

    .line 746
    iget v10, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v10, v1

    iput v10, v0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 748
    :cond_26
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    const/16 v10, 0x9

    goto/16 :goto_8

    .line 749
    :cond_27
    if-eq v4, v13, :cond_28

    const/16 v10, 0x9

    if-eq v4, v10, :cond_18

    .line 750
    invoke-virtual {v0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->throwInvalidSpace(I)V

    goto/16 :goto_8

    .line 749
    :cond_28
    const/16 v10, 0x9

    goto/16 :goto_8
.end method

.method protected final loadAndRetain(I)Z
    .locals 6
    .param p1, "nrOfChars"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3391
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_in:Ljava/io/Reader;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 3392
    return v1

    .line 3397
    :cond_0
    iget-wide v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_pastBytesOrChars:J

    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    int-to-long v4, v0

    add-long/2addr v2, v4

    iput-wide v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_pastBytesOrChars:J

    .line 3398
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_rowStartOffset:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    sub-int/2addr v0, v2

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_rowStartOffset:I

    .line 3400
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    sub-int/2addr v0, v2

    .line 3401
    .local v0, "remaining":I
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget-object v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    invoke-static {v2, v3, v4, v1, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 3402
    iput v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 3403
    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    .line 3407
    :cond_1
    :try_start_0
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    array-length v2, v2

    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    sub-int/2addr v2, v3

    .line 3408
    .local v2, "max":I
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_in:Ljava/io/Reader;

    iget-object v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    invoke-virtual {v3, v4, v5, v2}, Ljava/io/Reader;->read([CII)I

    move-result v3

    .line 3409
    .local v3, "count":I
    const/4 v4, 0x1

    if-ge v3, v4, :cond_3

    .line 3410
    if-nez v3, :cond_2

    .line 3412
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Reader returned 0 bytes, even when asked to read up to "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 3414
    :cond_2
    return v1

    .line 3416
    :cond_3
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    add-int/2addr v5, v3

    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    .line 3417
    .end local v2    # "max":I
    .end local v3    # "count":I
    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    if-lt v2, p1, :cond_1

    .line 3418
    return v4

    .line 3419
    :catch_0
    move-exception v1

    .line 3420
    .local v1, "ioe":Ljava/io/IOException;
    new-instance v2, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v2, v1}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v2
.end method

.method protected final loadMore()Z
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3339
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_in:Ljava/io/Reader;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 3340
    iput v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    .line 3341
    return v1

    .line 3345
    :cond_0
    iget-wide v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_pastBytesOrChars:J

    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    int-to-long v4, v0

    add-long/2addr v2, v4

    iput-wide v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_pastBytesOrChars:J

    .line 3346
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_rowStartOffset:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    sub-int/2addr v0, v2

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_rowStartOffset:I

    .line 3347
    iput v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 3350
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_in:Ljava/io/Reader;

    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    array-length v3, v3

    invoke-virtual {v0, v2, v1, v3}, Ljava/io/Reader;->read([CII)I

    move-result v0

    .line 3351
    .local v0, "count":I
    const/4 v2, 0x1

    if-ge v0, v2, :cond_2

    .line 3352
    iput v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    .line 3353
    if-nez v0, :cond_1

    .line 3357
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Reader returned 0 bytes, even when asked to read up to "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    array-length v3, v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 3359
    :cond_1
    return v1

    .line 3361
    :cond_2
    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 3362
    return v2

    .line 3363
    .end local v0    # "count":I
    :catch_0
    move-exception v0

    .line 3364
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method protected final loadOne()C
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3370
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_0

    .line 3371
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Unexpected end-of-input when trying to parse "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currToken:I

    invoke-static {v1}, Lcom/fasterxml/aalto/impl/ErrorConsts;->tokenTypeDesc(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 3373
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v0, v1

    return v0
.end method

.method protected final loadOne(I)C
    .locals 3
    .param p1, "type"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3379
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_0

    .line 3380
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

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 3382
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v0, v1

    return v0
.end method

.method protected final markLF()V
    .locals 1

    .line 3319
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_rowStartOffset:I

    .line 3320
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currRow:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currRow:I

    .line 3321
    return-void
.end method

.method protected final markLF(I)V
    .locals 1
    .param p1, "offset"    # I

    .line 3313
    iput p1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_rowStartOffset:I

    .line 3314
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currRow:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currRow:I

    .line 3315
    return-void
.end method

.method public final nextFromProlog(Z)I
    .locals 5
    .param p1, "isProlog"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 176
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenIncomplete:Z

    if-eqz v0, :cond_0

    .line 177
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->skipToken()Z

    .line 181
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->setStartLocation()V

    .line 186
    :goto_0
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    const/4 v2, -0x1

    if-lt v0, v1, :cond_1

    .line 187
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_1

    .line 188
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->setStartLocation()V

    .line 189
    return v2

    .line 192
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v3, v1, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v0, v1

    and-int/lit16 v0, v0, 0xff

    .line 195
    .local v0, "c":I
    const/16 v1, 0x3c

    if-ne v0, v1, :cond_7

    .line 196
    nop

    .line 220
    .end local v0    # "c":I
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v0, v1, :cond_2

    .line 221
    const/4 v0, 0x5

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed(I)V

    .line 223
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v0, v1

    .line 224
    .local v0, "c":C
    const/16 v1, 0x21

    if-ne v0, v1, :cond_3

    .line 225
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/in/ReaderScanner;->handlePrologDeclStart(Z)I

    move-result v1

    return v1

    .line 227
    :cond_3
    const/16 v1, 0x3f

    if-ne v0, v1, :cond_4

    .line 228
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->handlePIStart()I

    move-result v1

    return v1

    .line 233
    :cond_4
    const/16 v1, 0x2f

    if-eq v0, v1, :cond_5

    if-nez p1, :cond_6

    .line 234
    :cond_5
    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportPrologUnexpElement(ZI)V

    .line 236
    :cond_6
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleStartElement(C)I

    move-result v1

    return v1

    .line 198
    .local v0, "c":I
    :cond_7
    const/16 v1, 0x20

    if-eq v0, v1, :cond_c

    .line 199
    const/16 v1, 0xa

    if-ne v0, v1, :cond_8

    .line 200
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    goto :goto_1

    .line 201
    :cond_8
    const/16 v3, 0xd

    if-ne v0, v3, :cond_b

    .line 202
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v3, v4, :cond_9

    .line 203
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMore()Z

    move-result v3

    if-nez v3, :cond_9

    .line 204
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 205
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->setStartLocation()V

    .line 206
    return v2

    .line 209
    :cond_9
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v2, v2, v3

    if-ne v2, v1, :cond_a

    .line 210
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 212
    :cond_a
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    goto :goto_1

    .line 213
    :cond_b
    const/16 v1, 0x9

    if-eq v0, v1, :cond_c

    .line 214
    const/4 v1, 0x0

    invoke-virtual {p0, p1, v0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportPrologUnexpChar(ZILjava/lang/String;)V

    .line 217
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

    .line 242
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenIncomplete:Z

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    .line 243
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->skipToken()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 245
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->_nextEntity()I

    move-result v0

    return v0

    .line 248
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currToken:I

    const/4 v3, 0x2

    if-ne v0, v2, :cond_1

    .line 249
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_isEmptyTag:Z

    if-eqz v0, :cond_3

    .line 251
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_depth:I

    sub-int/2addr v0, v2

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_depth:I

    .line 252
    iput v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currToken:I

    return v3

    .line 254
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currToken:I

    if-ne v0, v3, :cond_2

    .line 255
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currElem:Lcom/fasterxml/aalto/in/ElementScope;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ElementScope;->getParent()Lcom/fasterxml/aalto/in/ElementScope;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currElem:Lcom/fasterxml/aalto/in/ElementScope;

    .line 257
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->getLevel()I

    move-result v0

    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_depth:I

    if-lt v0, v3, :cond_3

    .line 258
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->unbind()Lcom/fasterxml/aalto/in/NsDeclaration;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    goto :goto_0

    .line 262
    :cond_2
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_entityPending:Z

    if-eqz v0, :cond_3

    .line 263
    iput-boolean v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_entityPending:Z

    .line 264
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->_nextEntity()I

    move-result v0

    return v0

    .line 269
    :cond_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->setStartLocation()V

    .line 274
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v0, v3, :cond_4

    .line 275
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_4

    .line 276
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->setStartLocation()V

    .line 277
    const/4 v0, -0x1

    return v0

    .line 280
    :cond_4
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v0, v3

    .line 285
    .local v0, "c":C
    const/16 v3, 0x3c

    if-ne v0, v3, :cond_9

    .line 286
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v1, v2

    iput v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 287
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-ge v1, v2, :cond_5

    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v1, v1, v2

    goto :goto_1

    :cond_5
    const/4 v1, 0x5

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadOne(I)C

    move-result v1

    :goto_1
    move v0, v1

    .line 288
    const/16 v1, 0x21

    if-ne v0, v1, :cond_6

    .line 289
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleCommentOrCdataStart()I

    move-result v1

    return v1

    .line 291
    :cond_6
    const/16 v1, 0x3f

    if-ne v0, v1, :cond_7

    .line 292
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->handlePIStart()I

    move-result v1

    return v1

    .line 294
    :cond_7
    const/16 v1, 0x2f

    if-ne v0, v1, :cond_8

    .line 295
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleEndElement()I

    move-result v1

    return v1

    .line 297
    :cond_8
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleStartElement(C)I

    move-result v1

    return v1

    .line 299
    :cond_9
    const/16 v3, 0x26

    if-ne v0, v3, :cond_b

    .line 300
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v3, v2

    iput v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 304
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleEntityInText(Z)I

    move-result v1

    .line 305
    .local v1, "i":I
    if-nez v1, :cond_a

    .line 306
    const/16 v2, 0x9

    iput v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currToken:I

    return v2

    .line 312
    :cond_a
    neg-int v3, v1

    iput v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->mTmpChar:I

    .line 313
    .end local v1    # "i":I
    goto :goto_2

    .line 317
    :cond_b
    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->mTmpChar:I

    .line 320
    :goto_2
    iget-boolean v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_cfgLazyParsing:Z

    if-eqz v1, :cond_c

    .line 321
    iput-boolean v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_tokenIncomplete:Z

    goto :goto_3

    .line 323
    :cond_c
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->finishCharacters()V

    .line 325
    :goto_3
    const/4 v1, 0x4

    iput v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currToken:I

    return v1
.end method

.method protected parsePName(C)Lcom/fasterxml/aalto/in/PName;
    .locals 7
    .param p1, "c"    # C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2996
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_nameBuffer:[C

    .line 3002
    .local v0, "nameBuffer":[C
    const/16 v1, 0x41

    if-ge p1, v1, :cond_0

    .line 3003
    const-string v2, "; expected a name start character"

    invoke-virtual {p0, p1, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 3005
    :cond_0
    const/4 v2, 0x0

    aput-char p1, v0, v2

    .line 3006
    move v3, p1

    .line 3007
    .local v3, "hash":I
    const/4 v4, 0x1

    .line 3010
    .local v4, "ptr":I
    :goto_0
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v5, v6, :cond_1

    .line 3011
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 3013
    :cond_1
    iget-object v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char p1, v5, v6

    .line 3014
    move v5, p1

    .line 3015
    .local v5, "d":I
    if-ge v5, v1, :cond_4

    .line 3017
    const/16 v6, 0x2d

    if-lt v5, v6, :cond_2

    const/16 v6, 0x3a

    if-gt v5, v6, :cond_2

    const/16 v6, 0x2f

    if-ne v5, v6, :cond_4

    .line 3019
    :cond_2
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_symbols:Lcom/fasterxml/aalto/in/CharBasedPNameTable;

    invoke-virtual {v1, v0, v2, v4, v3}, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->findSymbol([CIII)Lcom/fasterxml/aalto/in/PNameC;

    move-result-object v1

    .line 3020
    .local v1, "n":Lcom/fasterxml/aalto/in/PName;
    if-nez v1, :cond_3

    .line 3021
    invoke-virtual {p0, v0, v4, v3}, Lcom/fasterxml/aalto/in/ReaderScanner;->addPName([CII)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    .line 3023
    :cond_3
    return-object v1

    .line 3026
    .end local v1    # "n":Lcom/fasterxml/aalto/in/PName;
    :cond_4
    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v6, v6, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 3027
    array-length v6, v0

    if-lt v4, v6, :cond_5

    .line 3028
    array-length v6, v0

    invoke-static {v0, v6}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v6

    move-object v0, v6

    iput-object v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_nameBuffer:[C

    .line 3030
    :cond_5
    add-int/lit8 v6, v4, 0x1

    .end local v4    # "ptr":I
    .local v6, "ptr":I
    aput-char p1, v0, v4

    .line 3031
    mul-int/lit8 v4, v3, 0x1f

    add-int v3, v4, v5

    .line 3032
    .end local v5    # "d":I
    move v4, v6

    goto :goto_0
.end method

.method protected parsePublicId(C)Ljava/lang/String;
    .locals 7
    .param p1, "quoteChar"    # C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3083
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_nameBuffer:[C

    .line 3084
    .local v0, "outputBuffer":[C
    const/4 v1, 0x0

    .line 3085
    .local v1, "outPtr":I
    sget-object v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->PUBID_CHARS:[I

    .line 3086
    .local v2, "TYPES":[I
    const/4 v3, 0x0

    .line 3090
    .local v3, "addSpace":Z
    :goto_0
    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v4, v5, :cond_0

    .line 3091
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 3094
    :cond_0
    iget-object v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v4, v4, v5

    .line 3095
    .local v4, "c":C
    if-ne v4, p1, :cond_1

    .line 3096
    nop

    .line 3121
    .end local v4    # "c":C
    new-instance v4, Ljava/lang/String;

    const/4 v5, 0x0

    invoke-direct {v4, v0, v5, v1}, Ljava/lang/String;-><init>([CII)V

    return-object v4

    .line 3098
    .restart local v4    # "c":C
    :cond_1
    const/16 v5, 0xff

    if-gt v4, v5, :cond_2

    aget v5, v2, v4

    const/4 v6, 0x1

    if-eq v5, v6, :cond_3

    .line 3099
    :cond_2
    const-string v5, " in public identifier"

    invoke-virtual {p0, v4, v5}, Lcom/fasterxml/aalto/in/ReaderScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 3103
    :cond_3
    const/16 v5, 0x20

    if-gt v4, v5, :cond_4

    .line 3104
    const/4 v3, 0x1

    .line 3105
    goto :goto_0

    .line 3107
    :cond_4
    if-eqz v3, :cond_6

    .line 3108
    array-length v6, v0

    if-lt v1, v6, :cond_5

    .line 3109
    iget-object v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v6}, Lcom/fasterxml/aalto/util/TextBuilder;->finishCurrentSegment()[C

    move-result-object v0

    .line 3110
    const/4 v1, 0x0

    .line 3112
    :cond_5
    add-int/lit8 v6, v1, 0x1

    .end local v1    # "outPtr":I
    .local v6, "outPtr":I
    aput-char v5, v0, v1

    .line 3113
    const/4 v1, 0x0

    move v3, v1

    move v1, v6

    .line 3115
    .end local v6    # "outPtr":I
    .restart local v1    # "outPtr":I
    :cond_6
    array-length v5, v0

    if-lt v1, v5, :cond_7

    .line 3116
    array-length v5, v0

    invoke-static {v0, v5}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v5

    move-object v0, v5

    iput-object v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_nameBuffer:[C

    .line 3117
    const/4 v1, 0x0

    .line 3119
    :cond_7
    add-int/lit8 v5, v1, 0x1

    .end local v1    # "outPtr":I
    .local v5, "outPtr":I
    aput-char v4, v0, v1

    .line 3120
    .end local v4    # "c":C
    move v1, v5

    goto :goto_0
.end method

.method protected parseSystemId(C)Ljava/lang/String;
    .locals 6
    .param p1, "quoteChar"    # C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 3127
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_nameBuffer:[C

    .line 3128
    .local v0, "outputBuffer":[C
    const/4 v1, 0x0

    .line 3130
    .local v1, "outPtr":I
    sget-object v2, Lcom/fasterxml/aalto/in/ReaderScanner;->sCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v2, v2, Lcom/fasterxml/aalto/util/XmlCharTypes;->ATTR_CHARS:[I

    .line 3135
    .local v2, "TYPES":[I
    :goto_0
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v3, v4, :cond_0

    .line 3136
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 3138
    :cond_0
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v3, v3, v4

    .line 3139
    .local v3, "c":C
    aget v4, v2, v3

    if-eqz v4, :cond_3

    .line 3140
    aget v4, v2, v3

    sparse-switch v4, :sswitch_data_0

    goto :goto_1

    .line 3160
    :sswitch_0
    if-ne v3, p1, :cond_3

    .line 3161
    nop

    .line 3171
    .end local v3    # "c":C
    new-instance v3, Ljava/lang/String;

    const/4 v4, 0x0

    invoke-direct {v3, v0, v4, v1}, Ljava/lang/String;-><init>([CII)V

    return-object v3

    .line 3156
    .restart local v3    # "c":C
    :sswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 3157
    goto :goto_1

    .line 3142
    :sswitch_2
    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    move-result v3

    .line 3145
    :sswitch_3
    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v4, v5, :cond_1

    .line 3146
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 3148
    :cond_1
    iget-object v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v4, v4, v5

    const/16 v5, 0xa

    if-ne v4, v5, :cond_2

    .line 3149
    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 3151
    :cond_2
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 3153
    const/16 v3, 0xa

    .line 3154
    nop

    .line 3165
    :cond_3
    :goto_1
    array-length v4, v0

    if-lt v1, v4, :cond_4

    .line 3166
    array-length v4, v0

    invoke-static {v0, v4}, Lcom/fasterxml/aalto/util/DataUtil;->growArrayBy([CI)[C

    move-result-object v4

    move-object v0, v4

    iput-object v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_nameBuffer:[C

    .line 3167
    const/4 v1, 0x0

    .line 3169
    :cond_4
    add-int/lit8 v4, v1, 0x1

    .end local v1    # "outPtr":I
    .local v4, "outPtr":I
    aput-char v3, v0, v1

    .line 3170
    .end local v3    # "c":C
    move v1, v4

    goto :goto_0

    nop

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_2
        0x2 -> :sswitch_3
        0x3 -> :sswitch_1
        0xe -> :sswitch_0
    .end sparse-switch
.end method

.method protected final setStartLocation()V
    .locals 4

    .line 3324
    iget-wide v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_pastBytesOrChars:J

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    int-to-long v2, v2

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_startRawOffset:J

    .line 3325
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_currRow:I

    int-to-long v0, v0

    iput-wide v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_startRow:J

    .line 3326
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_rowStartOffset:I

    sub-int/2addr v0, v1

    int-to-long v0, v0

    iput-wide v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_startColumn:J

    .line 3327
    return-void
.end method

.method protected final skipCData()V
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2659
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderScanner;->sCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 2660
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    .line 2668
    .local v1, "inputBuffer":[C
    :goto_0
    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2669
    .local v2, "ptr":I
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    .line 2670
    .local v3, "max":I
    if-lt v2, v3, :cond_0

    .line 2671
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2672
    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2673
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    .line 2675
    :cond_0
    :goto_1
    if-ge v2, v3, :cond_c

    .line 2676
    add-int/lit8 v4, v2, 0x1

    .end local v2    # "ptr":I
    .local v4, "ptr":I
    aget-char v2, v1, v2

    .line 2677
    .local v2, "c":C
    const v5, 0xd800

    const/16 v6, 0xff

    if-gt v2, v6, :cond_1

    .line 2678
    aget v7, v0, v2

    if-eqz v7, :cond_b

    .line 2679
    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2680
    goto :goto_2

    .line 2682
    :cond_1
    if-lt v2, v5, :cond_b

    .line 2683
    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2684
    nop

    .line 2690
    .end local v3    # "max":I
    .end local v4    # "ptr":I
    :goto_2
    if-gt v2, v6, :cond_8

    .line 2691
    aget v3, v0, v2

    const/4 v4, 0x1

    sparse-switch v3, :sswitch_data_0

    goto :goto_3

    .line 2714
    :sswitch_0
    const/4 v3, 0x0

    .line 2717
    .local v3, "count":I
    :cond_2
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v5, v6, :cond_3

    .line 2718
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2720
    :cond_3
    add-int/2addr v3, v4

    .line 2721
    iget-object v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v7, v6, 0x1

    iput v7, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v2, v5, v6

    .line 2722
    const/16 v5, 0x5d

    if-eq v2, v5, :cond_2

    .line 2724
    const/16 v5, 0x3e

    if-ne v2, v5, :cond_4

    .line 2725
    if-le v3, v4, :cond_7

    .line 2726
    return-void

    .line 2730
    :cond_4
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    sub-int/2addr v5, v4

    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    goto :goto_3

    .line 2709
    .end local v3    # "count":I
    :sswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 2710
    goto :goto_3

    .line 2693
    :sswitch_2
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    move-result v2

    .line 2696
    :sswitch_3
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2697
    .local v3, "ptr":I
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v3, v5, :cond_5

    .line 2698
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2699
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2701
    :cond_5
    aget-char v5, v1, v3

    const/16 v6, 0xa

    if-ne v5, v6, :cond_6

    .line 2702
    add-int/lit8 v3, v3, 0x1

    .line 2703
    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v5, v4

    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2705
    :cond_6
    invoke-virtual {p0, v3}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF(I)V

    .line 2707
    .end local v3    # "ptr":I
    nop

    .line 2733
    :cond_7
    :goto_3
    goto :goto_4

    .line 2738
    :cond_8
    if-lt v2, v5, :cond_a

    .line 2739
    const v3, 0xe000

    if-ge v2, v3, :cond_9

    .line 2741
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->checkSurrogate(C)C

    goto :goto_4

    .line 2742
    :cond_9
    const v3, 0xfffe

    if-lt v2, v3, :cond_a

    .line 2743
    .end local v2    # "c":C
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    .line 2746
    :cond_a
    :goto_4
    goto/16 :goto_0

    .line 2675
    .local v3, "max":I
    .restart local v4    # "ptr":I
    :cond_b
    move v2, v4

    goto/16 :goto_1

    .line 2687
    .end local v4    # "ptr":I
    .local v2, "ptr":I
    :cond_c
    iput v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2688
    .end local v2    # "ptr":I
    .end local v3    # "max":I
    goto/16 :goto_0

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_2
        0x2 -> :sswitch_3
        0x3 -> :sswitch_1
        0xb -> :sswitch_0
    .end sparse-switch
.end method

.method protected final skipCharacters()Z
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2559
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderScanner;->sCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->TEXT_CHARS:[I

    .line 2560
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    .line 2568
    .local v1, "inputBuffer":[C
    :goto_0
    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2569
    .local v2, "ptr":I
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    .line 2570
    .local v3, "max":I
    if-lt v2, v3, :cond_0

    .line 2571
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2572
    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2573
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    .line 2575
    :cond_0
    :goto_1
    if-ge v2, v3, :cond_c

    .line 2576
    add-int/lit8 v4, v2, 0x1

    .end local v2    # "ptr":I
    .local v4, "ptr":I
    aget-char v2, v1, v2

    .line 2577
    .local v2, "c":C
    const v5, 0xd800

    const/16 v6, 0xff

    if-gt v2, v6, :cond_1

    .line 2578
    aget v7, v0, v2

    if-eqz v7, :cond_b

    .line 2579
    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2580
    goto :goto_2

    .line 2582
    :cond_1
    if-lt v2, v5, :cond_b

    .line 2583
    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2584
    nop

    .line 2590
    .end local v3    # "max":I
    .end local v4    # "ptr":I
    :goto_2
    if-gt v2, v6, :cond_8

    .line 2591
    aget v3, v0, v2

    const/4 v4, 0x0

    const/4 v5, 0x1

    packed-switch v3, :pswitch_data_0

    :pswitch_0
    goto :goto_4

    .line 2623
    :pswitch_1
    const/4 v3, 0x1

    .line 2625
    .local v3, "count":I
    :goto_3
    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v4, v6, :cond_2

    .line 2626
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2628
    :cond_2
    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v2, v1, v4

    .line 2629
    const/16 v4, 0x5d

    if-eq v2, v4, :cond_3

    .line 2630
    nop

    .line 2635
    const/16 v4, 0x3e

    if-ne v2, v4, :cond_7

    if-le v3, v5, :cond_7

    .line 2636
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportIllegalCDataEnd()V

    goto :goto_4

    .line 2632
    :cond_3
    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v4, v5

    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2633
    add-int/lit8 v3, v3, 0x1

    goto :goto_3

    .line 2613
    .end local v3    # "count":I
    :pswitch_2
    invoke-virtual {p0, v4}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleEntityInText(Z)I

    move-result v3

    .line 2614
    .local v3, "d":I
    if-nez v3, :cond_4

    .line 2615
    return v5

    .line 2618
    .end local v3    # "d":I
    :cond_4
    goto :goto_4

    .line 2609
    :pswitch_3
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    sub-int/2addr v3, v5

    iput v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2610
    return v4

    .line 2606
    :pswitch_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 2607
    goto :goto_4

    .line 2593
    :pswitch_5
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    move-result v2

    .line 2596
    :pswitch_6
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v3, v4, :cond_5

    .line 2597
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2599
    :cond_5
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v3, v1, v3

    const/16 v4, 0xa

    if-ne v3, v4, :cond_6

    .line 2600
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v3, v5

    iput v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2602
    :cond_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 2604
    nop

    .line 2640
    :cond_7
    :goto_4
    goto :goto_5

    .line 2645
    :cond_8
    if-lt v2, v5, :cond_a

    .line 2646
    const v3, 0xe000

    if-ge v2, v3, :cond_9

    .line 2648
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->checkSurrogate(C)C

    goto :goto_5

    .line 2649
    :cond_9
    const v3, 0xfffe

    if-lt v2, v3, :cond_a

    .line 2650
    .end local v2    # "c":C
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    .line 2653
    :cond_a
    :goto_5
    goto/16 :goto_0

    .line 2575
    .local v3, "max":I
    .restart local v4    # "ptr":I
    :cond_b
    move v2, v4

    goto/16 :goto_1

    .line 2587
    .end local v4    # "ptr":I
    .local v2, "ptr":I
    :cond_c
    iput v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2588
    .end local v2    # "ptr":I
    .end local v3    # "max":I
    goto/16 :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_5
        :pswitch_6
        :pswitch_4
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method protected final skipCoalescedText()Z
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2360
    nop

    :cond_0
    :goto_0
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    const/4 v2, 0x0

    if-lt v0, v1, :cond_1

    .line 2361
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_1

    .line 2362
    return v2

    .line 2366
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v0, v1

    const/16 v1, 0x3c

    const/4 v3, 0x1

    if-ne v0, v1, :cond_8

    .line 2370
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    const/4 v1, 0x3

    add-int/2addr v0, v1

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v0, v4, :cond_2

    .line 2371
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadAndRetain(I)Z

    move-result v0

    if-nez v0, :cond_2

    .line 2372
    return v2

    .line 2375
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v4, v3

    aget-char v0, v0, v4

    const/16 v3, 0x21

    if-ne v0, v3, :cond_7

    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v3, v3, 0x2

    aget-char v0, v0, v3

    const/16 v3, 0x5b

    if-eq v0, v3, :cond_3

    goto :goto_2

    .line 2381
    :cond_3
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2382
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    const/4 v1, 0x6

    if-ge v0, v1, :cond_6

    .line 2383
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v1, v2, :cond_4

    .line 2384
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2386
    :cond_4
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v1, v1, v2

    .line 2387
    .local v1, "c":C
    const-string v2, "CDATA["

    invoke-virtual {v2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    if-eq v1, v3, :cond_5

    .line 2388
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, " (expected \'"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\' for CDATA section)"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 2382
    .end local v1    # "c":C
    :cond_5
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 2391
    .end local v0    # "i":I
    :cond_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->skipCData()V

    goto/16 :goto_0

    .line 2378
    :cond_7
    :goto_2
    return v2

    .line 2393
    :cond_8
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->skipCharacters()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 2394
    return v3
.end method

.method protected final skipComment()V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2410
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderScanner;->sCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 2411
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    .line 2419
    .local v1, "inputBuffer":[C
    :goto_0
    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2420
    .local v2, "ptr":I
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    .line 2421
    .local v3, "max":I
    if-lt v2, v3, :cond_0

    .line 2422
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2423
    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2424
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    .line 2426
    :cond_0
    :goto_1
    if-ge v2, v3, :cond_9

    .line 2427
    add-int/lit8 v4, v2, 0x1

    .end local v2    # "ptr":I
    .local v4, "ptr":I
    aget-char v2, v1, v2

    .line 2428
    .local v2, "c":C
    const/16 v5, 0xff

    if-gt v2, v5, :cond_1

    .line 2429
    aget v6, v0, v2

    if-eqz v6, :cond_8

    .line 2430
    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2431
    goto :goto_2

    .line 2433
    :cond_1
    const v6, 0xd800

    if-lt v2, v6, :cond_8

    .line 2434
    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2435
    nop

    .line 2441
    .end local v3    # "max":I
    .end local v4    # "ptr":I
    :goto_2
    if-gt v2, v5, :cond_7

    .line 2442
    aget v3, v0, v2

    sparse-switch v3, :sswitch_data_0

    goto :goto_3

    .line 2460
    :sswitch_0
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v3, v4, :cond_2

    .line 2461
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2463
    :cond_2
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v3, v3, v4

    const/16 v4, 0x2d

    if-ne v3, v4, :cond_7

    .line 2464
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2465
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v3, v4, :cond_3

    .line 2466
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2468
    :cond_3
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v3, v3, v4

    const/16 v4, 0x3e

    if-eq v3, v4, :cond_4

    .line 2469
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportDoubleHyphenInComments()V

    .line 2471
    :cond_4
    return-void

    .line 2457
    :sswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 2458
    goto :goto_3

    .line 2444
    :sswitch_2
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    move-result v2

    .line 2447
    :sswitch_3
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v3, v4, :cond_5

    .line 2448
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2450
    :cond_5
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v3, v1, v3

    const/16 v4, 0xa

    if-ne v3, v4, :cond_6

    .line 2451
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2453
    :cond_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 2455
    nop

    .line 2479
    .end local v2    # "c":C
    :cond_7
    :goto_3
    goto/16 :goto_0

    .line 2426
    .restart local v3    # "max":I
    .restart local v4    # "ptr":I
    :cond_8
    move v2, v4

    goto :goto_1

    .line 2438
    .end local v4    # "ptr":I
    .local v2, "ptr":I
    :cond_9
    iput v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2439
    .end local v2    # "ptr":I
    .end local v3    # "max":I
    goto/16 :goto_0

    nop

    :sswitch_data_0
    .sparse-switch
        0x1 -> :sswitch_2
        0x2 -> :sswitch_3
        0x3 -> :sswitch_1
        0xd -> :sswitch_0
    .end sparse-switch
.end method

.method protected skipInternalWs(ZLjava/lang/String;)C
    .locals 5
    .param p1, "reqd"    # Z
    .param p2, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2801
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 2802
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2804
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v0, v1

    .line 2805
    .local v0, "c":C
    const/16 v1, 0x20

    if-le v0, v1, :cond_2

    .line 2806
    if-nez p1, :cond_1

    .line 2807
    return v0

    .line 2809
    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, " (expected white space "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->reportTreeUnexpChar(ILjava/lang/String;)V

    .line 2813
    :cond_2
    const/16 v2, 0xa

    if-ne v0, v2, :cond_3

    .line 2814
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    goto :goto_0

    .line 2815
    :cond_3
    const/16 v3, 0xd

    if-ne v0, v3, :cond_6

    .line 2816
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v3, v4, :cond_4

    .line 2817
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2819
    :cond_4
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v3, v3, v4

    if-ne v3, v2, :cond_5

    .line 2820
    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2822
    :cond_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    goto :goto_0

    .line 2823
    :cond_6
    if-eq v0, v1, :cond_7

    const/16 v2, 0x9

    if-eq v0, v2, :cond_7

    .line 2824
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->throwInvalidSpace(I)V

    .line 2827
    :cond_7
    :goto_0
    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v2, v3, :cond_8

    .line 2828
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2830
    :cond_8
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v0, v2, v3

    .line 2831
    if-le v0, v1, :cond_2

    .line 2833
    return v0
.end method

.method protected final skipPI()V
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2485
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderScanner;->sCharTypes:Lcom/fasterxml/aalto/util/XmlCharTypes;

    iget-object v0, v0, Lcom/fasterxml/aalto/util/XmlCharTypes;->OTHER_CHARS:[I

    .line 2486
    .local v0, "TYPES":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    .line 2494
    .local v1, "inputBuffer":[C
    :goto_0
    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2495
    .local v2, "ptr":I
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    .line 2496
    .local v3, "max":I
    if-lt v2, v3, :cond_0

    .line 2497
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2498
    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2499
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    .line 2501
    :cond_0
    :goto_1
    if-ge v2, v3, :cond_a

    .line 2502
    add-int/lit8 v4, v2, 0x1

    .end local v2    # "ptr":I
    .local v4, "ptr":I
    aget-char v2, v1, v2

    .line 2503
    .local v2, "c":C
    const v5, 0xd800

    const/16 v6, 0xff

    if-gt v2, v6, :cond_1

    .line 2504
    aget v7, v0, v2

    if-eqz v7, :cond_9

    .line 2505
    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2506
    goto :goto_2

    .line 2508
    :cond_1
    if-lt v2, v5, :cond_9

    .line 2509
    iput v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2510
    nop

    .line 2516
    .end local v3    # "max":I
    .end local v4    # "ptr":I
    :goto_2
    if-gt v2, v6, :cond_6

    .line 2517
    aget v3, v0, v2

    sparse-switch v3, :sswitch_data_0

    goto :goto_3

    .line 2533
    :sswitch_0
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v3, v4, :cond_2

    .line 2534
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2536
    :cond_2
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v3, v3, v4

    const/16 v4, 0x3e

    if-ne v3, v4, :cond_5

    .line 2537
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2538
    return-void

    .line 2530
    :sswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 2531
    goto :goto_3

    .line 2520
    :sswitch_2
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v3, v4, :cond_3

    .line 2521
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMoreGuaranteed()V

    .line 2523
    :cond_3
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    aget-char v3, v1, v3

    const/16 v4, 0xa

    if-ne v3, v4, :cond_4

    .line 2524
    iget v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2526
    :cond_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF()V

    .line 2528
    nop

    .line 2540
    :cond_5
    :goto_3
    goto :goto_4

    .line 2544
    :cond_6
    if-lt v2, v5, :cond_8

    .line 2545
    const v3, 0xe000

    if-ge v2, v3, :cond_7

    .line 2547
    invoke-direct {p0, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->checkSurrogate(C)C

    goto :goto_4

    .line 2548
    :cond_7
    const v3, 0xfffe

    if-lt v2, v3, :cond_8

    .line 2549
    .end local v2    # "c":C
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/ReaderScanner;->handleInvalidXmlChar(I)C

    .line 2553
    :cond_8
    :goto_4
    goto :goto_0

    .line 2501
    .restart local v3    # "max":I
    .restart local v4    # "ptr":I
    :cond_9
    move v2, v4

    goto :goto_1

    .line 2513
    .end local v4    # "ptr":I
    .local v2, "ptr":I
    :cond_a
    iput v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2514
    .end local v2    # "ptr":I
    .end local v3    # "max":I
    goto/16 :goto_0

    :sswitch_data_0
    .sparse-switch
        0x2 -> :sswitch_2
        0x3 -> :sswitch_1
        0xc -> :sswitch_0
    .end sparse-switch
.end method

.method protected final skipSpace()V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 2753
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2756
    .local v0, "ptr":I
    :goto_0
    iget v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v0, v1, :cond_1

    .line 2757
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMore()Z

    move-result v1

    if-nez v1, :cond_0

    .line 2758
    goto :goto_1

    .line 2760
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2762
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    aget-char v1, v1, v0

    .line 2763
    .local v1, "c":C
    const/16 v2, 0x20

    if-le v1, v2, :cond_2

    .line 2764
    goto :goto_1

    .line 2766
    :cond_2
    add-int/lit8 v0, v0, 0x1

    .line 2768
    const/16 v3, 0xa

    if-ne v1, v3, :cond_3

    .line 2769
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF(I)V

    goto :goto_2

    .line 2770
    :cond_3
    const/16 v4, 0xd

    if-ne v1, v4, :cond_7

    .line 2771
    iget v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputEnd:I

    if-lt v0, v2, :cond_5

    .line 2772
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/ReaderScanner;->loadMore()Z

    move-result v2

    if-nez v2, :cond_4

    .line 2773
    nop

    .line 2786
    .end local v1    # "c":C
    :goto_1
    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2787
    return-void

    .line 2775
    .restart local v1    # "c":C
    :cond_4
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2777
    :cond_5
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputBuffer:[C

    aget-char v2, v2, v0

    if-ne v2, v3, :cond_6

    .line 2778
    add-int/lit8 v0, v0, 0x1

    .line 2780
    :cond_6
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderScanner;->markLF(I)V

    goto :goto_2

    .line 2781
    :cond_7
    if-eq v1, v2, :cond_8

    const/16 v2, 0x9

    if-eq v1, v2, :cond_8

    .line 2782
    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderScanner;->_inputPtr:I

    .line 2783
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/ReaderScanner;->throwInvalidSpace(I)V

    .line 2785
    .end local v1    # "c":C
    :cond_8
    :goto_2
    goto :goto_0
.end method
