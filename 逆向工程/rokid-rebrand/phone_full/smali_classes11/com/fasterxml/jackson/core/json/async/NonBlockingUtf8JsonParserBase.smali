.class public abstract Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;
.super Lcom/fasterxml/jackson/core/json/async/NonBlockingJsonParserBase;
.source "NonBlockingUtf8JsonParserBase.java"


# static fields
.field private static final FEAT_MASK_ALLOW_JAVA_COMMENTS:I

.field private static final FEAT_MASK_ALLOW_MISSING:I

.field private static final FEAT_MASK_ALLOW_SINGLE_QUOTES:I

.field private static final FEAT_MASK_ALLOW_UNQUOTED_NAMES:I

.field private static final FEAT_MASK_ALLOW_YAML_COMMENTS:I

.field private static final FEAT_MASK_LEADING_ZEROS:I

.field private static final FEAT_MASK_TRAILING_COMMA:I

.field protected static final _icLatin1:[I

.field private static final _icUTF8:[I


# instance fields
.field protected _origBufferLen:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 25
    sget-object v0, Lcom/fasterxml/jackson/core/JsonParser$Feature;->ALLOW_TRAILING_COMMA:Lcom/fasterxml/jackson/core/JsonParser$Feature;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/JsonParser$Feature;->getMask()I

    move-result v0

    sput v0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->FEAT_MASK_TRAILING_COMMA:I

    .line 27
    sget-object v0, Lcom/fasterxml/jackson/core/JsonParser$Feature;->ALLOW_NUMERIC_LEADING_ZEROS:Lcom/fasterxml/jackson/core/JsonParser$Feature;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/JsonParser$Feature;->getMask()I

    move-result v0

    sput v0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->FEAT_MASK_LEADING_ZEROS:I

    .line 29
    sget-object v0, Lcom/fasterxml/jackson/core/JsonParser$Feature;->ALLOW_MISSING_VALUES:Lcom/fasterxml/jackson/core/JsonParser$Feature;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/JsonParser$Feature;->getMask()I

    move-result v0

    sput v0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->FEAT_MASK_ALLOW_MISSING:I

    .line 30
    sget-object v0, Lcom/fasterxml/jackson/core/JsonParser$Feature;->ALLOW_SINGLE_QUOTES:Lcom/fasterxml/jackson/core/JsonParser$Feature;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/JsonParser$Feature;->getMask()I

    move-result v0

    sput v0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->FEAT_MASK_ALLOW_SINGLE_QUOTES:I

    .line 31
    sget-object v0, Lcom/fasterxml/jackson/core/JsonParser$Feature;->ALLOW_UNQUOTED_FIELD_NAMES:Lcom/fasterxml/jackson/core/JsonParser$Feature;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/JsonParser$Feature;->getMask()I

    move-result v0

    sput v0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->FEAT_MASK_ALLOW_UNQUOTED_NAMES:I

    .line 32
    sget-object v0, Lcom/fasterxml/jackson/core/JsonParser$Feature;->ALLOW_COMMENTS:Lcom/fasterxml/jackson/core/JsonParser$Feature;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/JsonParser$Feature;->getMask()I

    move-result v0

    sput v0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->FEAT_MASK_ALLOW_JAVA_COMMENTS:I

    .line 33
    sget-object v0, Lcom/fasterxml/jackson/core/JsonParser$Feature;->ALLOW_YAML_COMMENTS:Lcom/fasterxml/jackson/core/JsonParser$Feature;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/JsonParser$Feature;->getMask()I

    move-result v0

    sput v0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->FEAT_MASK_ALLOW_YAML_COMMENTS:I

    .line 36
    invoke-static {}, Lcom/fasterxml/jackson/core/io/CharTypes;->getInputCodeUtf8()[I

    move-result-object v0

    sput-object v0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_icUTF8:[I

    .line 40
    invoke-static {}, Lcom/fasterxml/jackson/core/io/CharTypes;->getInputCodeLatin1()[I

    move-result-object v0

    sput-object v0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_icLatin1:[I

    return-void
.end method

.method protected constructor <init>(Lcom/fasterxml/jackson/core/io/IOContext;ILcom/fasterxml/jackson/core/sym/ByteQuadsCanonicalizer;)V
    .locals 0
    .param p1, "ctxt"    # Lcom/fasterxml/jackson/core/io/IOContext;
    .param p2, "parserFeatures"    # I
    .param p3, "sym"    # Lcom/fasterxml/jackson/core/sym/ByteQuadsCanonicalizer;

    .line 65
    invoke-direct {p0, p1, p2, p3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingJsonParserBase;-><init>(Lcom/fasterxml/jackson/core/io/IOContext;ILcom/fasterxml/jackson/core/sym/ByteQuadsCanonicalizer;)V

    .line 66
    return-void
.end method

.method private final _decodeCharEscape()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2880
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    sub-int/2addr v0, v1

    .line 2881
    .local v0, "left":I
    const/4 v1, 0x5

    if-ge v0, v1, :cond_0

    .line 2882
    const/4 v1, 0x0

    const/4 v2, -0x1

    invoke-direct {p0, v1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeSplitEscaped(II)I

    move-result v1

    return v1

    .line 2884
    :cond_0
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeFastCharEscape()I

    move-result v1

    return v1
.end method

.method private final _decodeFastCharEscape()I
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2889
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result v0

    .line 2890
    .local v0, "c":I
    sparse-switch v0, :sswitch_data_0

    .line 2916
    int-to-char v1, v0

    .line 2917
    .local v1, "ch":C
    invoke-virtual {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_handleUnrecognizedCharacterEscape(C)C

    move-result v2

    return v2

    .line 2910
    .end local v1    # "ch":C
    :sswitch_0
    nop

    .line 2921
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result v1

    .line 2922
    .local v1, "ch":I
    invoke-static {v1}, Lcom/fasterxml/jackson/core/io/CharTypes;->charToHex(I)I

    move-result v2

    .line 2923
    .local v2, "digit":I
    move v3, v2

    .line 2925
    .local v3, "result":I
    if-ltz v2, :cond_0

    .line 2926
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result v1

    .line 2927
    invoke-static {v1}, Lcom/fasterxml/jackson/core/io/CharTypes;->charToHex(I)I

    move-result v2

    .line 2928
    if-ltz v2, :cond_0

    .line 2929
    shl-int/lit8 v4, v3, 0x4

    or-int v3, v4, v2

    .line 2930
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result v1

    .line 2931
    invoke-static {v1}, Lcom/fasterxml/jackson/core/io/CharTypes;->charToHex(I)I

    move-result v2

    .line 2932
    if-ltz v2, :cond_0

    .line 2933
    shl-int/lit8 v4, v3, 0x4

    or-int v3, v4, v2

    .line 2934
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result v1

    .line 2935
    invoke-static {v1}, Lcom/fasterxml/jackson/core/io/CharTypes;->charToHex(I)I

    move-result v2

    .line 2936
    if-ltz v2, :cond_0

    .line 2937
    shl-int/lit8 v4, v3, 0x4

    or-int/2addr v4, v2

    return v4

    .line 2942
    :cond_0
    and-int/lit16 v4, v1, 0xff

    const-string v5, "expected a hex-digit for character escape sequence"

    invoke-virtual {p0, v4, v5}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedChar(ILjava/lang/String;)V

    .line 2943
    const/4 v4, -0x1

    return v4

    .line 2895
    .end local v1    # "ch":I
    .end local v2    # "digit":I
    .end local v3    # "result":I
    :sswitch_1
    const/16 v1, 0x9

    return v1

    .line 2901
    :sswitch_2
    const/16 v1, 0xd

    return v1

    .line 2897
    :sswitch_3
    const/16 v1, 0xa

    return v1

    .line 2899
    :sswitch_4
    const/16 v1, 0xc

    return v1

    .line 2893
    :sswitch_5
    const/16 v1, 0x8

    return v1

    .line 2907
    :sswitch_6
    int-to-char v1, v0

    return v1

    nop

    :sswitch_data_0
    .sparse-switch
        0x22 -> :sswitch_6
        0x2f -> :sswitch_6
        0x5c -> :sswitch_6
        0x62 -> :sswitch_5
        0x66 -> :sswitch_4
        0x6e -> :sswitch_3
        0x72 -> :sswitch_2
        0x74 -> :sswitch_1
        0x75 -> :sswitch_0
    .end sparse-switch
.end method

.method private _decodeSplitEscaped(II)I
    .locals 5
    .param p1, "value"    # I
    .param p2, "bytesRead"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2434
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    const/4 v2, -0x1

    if-lt v0, v1, :cond_0

    .line 2435
    iput p1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quoted32:I

    .line 2436
    iput p2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quotedDigits:I

    .line 2437
    return v2

    .line 2439
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result v0

    .line 2440
    .local v0, "c":I
    if-ne p2, v2, :cond_2

    .line 2441
    sparse-switch v0, :sswitch_data_0

    .line 2467
    int-to-char v1, v0

    .line 2468
    .local v1, "ch":C
    invoke-virtual {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_handleUnrecognizedCharacterEscape(C)C

    move-result v2

    return v2

    .line 2461
    .end local v1    # "ch":C
    :sswitch_0
    nop

    .line 2471
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v1, v3, :cond_1

    .line 2472
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quotedDigits:I

    .line 2473
    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quoted32:I

    .line 2474
    return v2

    .line 2476
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result v0

    .line 2477
    const/4 p2, 0x0

    goto :goto_0

    .line 2446
    :sswitch_1
    const/16 v1, 0x9

    return v1

    .line 2452
    :sswitch_2
    const/16 v1, 0xd

    return v1

    .line 2448
    :sswitch_3
    const/16 v1, 0xa

    return v1

    .line 2450
    :sswitch_4
    const/16 v1, 0xc

    return v1

    .line 2444
    :sswitch_5
    const/16 v1, 0x8

    return v1

    .line 2458
    :sswitch_6
    return v0

    .line 2479
    :cond_2
    :goto_0
    and-int/lit16 v0, v0, 0xff

    .line 2481
    :goto_1
    invoke-static {v0}, Lcom/fasterxml/jackson/core/io/CharTypes;->charToHex(I)I

    move-result v1

    .line 2482
    .local v1, "digit":I
    if-gez v1, :cond_3

    .line 2483
    and-int/lit16 v3, v0, 0xff

    const-string v4, "expected a hex-digit for character escape sequence"

    invoke-virtual {p0, v3, v4}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedChar(ILjava/lang/String;)V

    .line 2485
    :cond_3
    shl-int/lit8 v3, p1, 0x4

    or-int p1, v3, v1

    .line 2486
    add-int/lit8 p2, p2, 0x1

    const/4 v3, 0x4

    if-ne p2, v3, :cond_4

    .line 2487
    return p1

    .line 2489
    :cond_4
    iget v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v3, v4, :cond_5

    .line 2490
    iput p2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quotedDigits:I

    .line 2491
    iput p1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quoted32:I

    .line 2492
    return v2

    .line 2494
    :cond_5
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v0

    .line 2495
    .end local v1    # "digit":I
    goto :goto_1

    nop

    :sswitch_data_0
    .sparse-switch
        0x22 -> :sswitch_6
        0x2f -> :sswitch_6
        0x5c -> :sswitch_6
        0x62 -> :sswitch_5
        0x66 -> :sswitch_4
        0x6e -> :sswitch_3
        0x72 -> :sswitch_2
        0x74 -> :sswitch_1
        0x75 -> :sswitch_0
    .end sparse-switch
.end method

.method private final _decodeSplitMultiByte(IIZ)Z
    .locals 3
    .param p1, "c"    # I
    .param p2, "type"    # I
    .param p3, "gotNext"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2755
    const/4 v0, 0x0

    const/4 v1, 0x1

    packed-switch p2, :pswitch_data_0

    .line 2793
    const/16 v0, 0x20

    if-ge p1, v0, :cond_4

    .line 2795
    const-string v0, "string value"

    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_throwUnquotedSpace(ILjava/lang/String;)V

    goto :goto_0

    .line 2784
    :pswitch_0
    and-int/lit8 p1, p1, 0x7

    .line 2785
    if-eqz p3, :cond_0

    .line 2786
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result v0

    invoke-direct {p0, p1, v1, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeSplitUTF8_4(III)Z

    move-result v0

    return v0

    .line 2788
    :cond_0
    iput p1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    .line 2789
    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pendingBytes:I

    .line 2790
    const/16 v1, 0x2c

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 2791
    return v0

    .line 2775
    :pswitch_1
    and-int/lit8 p1, p1, 0xf

    .line 2776
    if-eqz p3, :cond_1

    .line 2777
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result v0

    invoke-direct {p0, p1, v1, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeSplitUTF8_3(III)Z

    move-result v0

    return v0

    .line 2779
    :cond_1
    const/16 v2, 0x2b

    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 2780
    iput p1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    .line 2781
    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pendingBytes:I

    .line 2782
    return v0

    .line 2765
    :pswitch_2
    if-eqz p3, :cond_2

    .line 2767
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result v0

    invoke-direct {p0, p1, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeUTF8_2(II)I

    move-result p1

    .line 2768
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    int-to-char v2, p1

    invoke-virtual {v0, v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->append(C)V

    .line 2769
    return v1

    .line 2771
    :cond_2
    const/16 v1, 0x2a

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 2772
    iput p1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    .line 2773
    return v0

    .line 2757
    :pswitch_3
    const/4 v2, -0x1

    invoke-direct {p0, v0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeSplitEscaped(II)I

    move-result p1

    .line 2758
    if-gez p1, :cond_3

    .line 2759
    const/16 v1, 0x29

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 2760
    return v0

    .line 2762
    :cond_3
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    int-to-char v2, p1

    invoke-virtual {v0, v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->append(C)V

    .line 2763
    return v1

    .line 2798
    :cond_4
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportInvalidChar(I)V

    .line 2800
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    int-to-char v2, p1

    invoke-virtual {v0, v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->append(C)V

    .line 2801
    return v1

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private final _decodeSplitUTF8_3(III)Z
    .locals 4
    .param p1, "prev"    # I
    .param p2, "prevCount"    # I
    .param p3, "next"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2808
    const/16 v0, 0x80

    const/4 v1, 0x1

    if-ne p2, v1, :cond_2

    .line 2809
    and-int/lit16 v2, p3, 0xc0

    if-eq v2, v0, :cond_0

    .line 2810
    and-int/lit16 v2, p3, 0xff

    iget v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportInvalidOther(II)V

    .line 2812
    :cond_0
    shl-int/lit8 v2, p1, 0x6

    and-int/lit8 v3, p3, 0x3f

    or-int p1, v2, v3

    .line 2813
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v2, v3, :cond_1

    .line 2814
    const/16 v0, 0x2b

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 2815
    iput p1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    .line 2816
    const/4 v0, 0x2

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pendingBytes:I

    .line 2817
    const/4 v0, 0x0

    return v0

    .line 2819
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result p3

    .line 2821
    :cond_2
    and-int/lit16 v2, p3, 0xc0

    if-eq v2, v0, :cond_3

    .line 2822
    and-int/lit16 v0, p3, 0xff

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportInvalidOther(II)V

    .line 2824
    :cond_3
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    shl-int/lit8 v2, p1, 0x6

    and-int/lit8 v3, p3, 0x3f

    or-int/2addr v2, v3

    int-to-char v2, v2

    invoke-virtual {v0, v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->append(C)V

    .line 2825
    return v1
.end method

.method private final _decodeSplitUTF8_4(III)Z
    .locals 7
    .param p1, "prev"    # I
    .param p2, "prevCount"    # I
    .param p3, "next"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2833
    const/4 v0, 0x0

    const/16 v1, 0x2c

    const/4 v2, 0x2

    const/16 v3, 0x80

    const/4 v4, 0x1

    if-ne p2, v4, :cond_2

    .line 2834
    and-int/lit16 v5, p3, 0xc0

    if-eq v5, v3, :cond_0

    .line 2835
    and-int/lit16 v5, p3, 0xff

    iget v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    invoke-virtual {p0, v5, v6}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportInvalidOther(II)V

    .line 2837
    :cond_0
    shl-int/lit8 v5, p1, 0x6

    and-int/lit8 v6, p3, 0x3f

    or-int p1, v5, v6

    .line 2838
    iget v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v5, v6, :cond_1

    .line 2839
    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 2840
    iput p1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    .line 2841
    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pendingBytes:I

    .line 2842
    return v0

    .line 2844
    :cond_1
    const/4 p2, 0x2

    .line 2845
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result p3

    .line 2847
    :cond_2
    if-ne p2, v2, :cond_5

    .line 2848
    and-int/lit16 v2, p3, 0xc0

    if-eq v2, v3, :cond_3

    .line 2849
    and-int/lit16 v2, p3, 0xff

    iget v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    invoke-virtual {p0, v2, v5}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportInvalidOther(II)V

    .line 2851
    :cond_3
    shl-int/lit8 v2, p1, 0x6

    and-int/lit8 v5, p3, 0x3f

    or-int p1, v2, v5

    .line 2852
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v2, v5, :cond_4

    .line 2853
    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 2854
    iput p1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    .line 2855
    const/4 v1, 0x3

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pendingBytes:I

    .line 2856
    return v0

    .line 2858
    :cond_4
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result p3

    .line 2860
    :cond_5
    and-int/lit16 v0, p3, 0xc0

    if-eq v0, v3, :cond_6

    .line 2861
    and-int/lit16 v0, p3, 0xff

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportInvalidOther(II)V

    .line 2863
    :cond_6
    shl-int/lit8 v0, p1, 0x6

    and-int/lit8 v1, p3, 0x3f

    or-int/2addr v0, v1

    const/high16 v1, 0x10000

    sub-int/2addr v0, v1

    .line 2865
    .local v0, "c":I
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    shr-int/lit8 v2, v0, 0xa

    const v3, 0xd800

    or-int/2addr v2, v3

    int-to-char v2, v2

    invoke-virtual {v1, v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->append(C)V

    .line 2866
    and-int/lit16 v1, v0, 0x3ff

    const v2, 0xdc00

    or-int v0, v1, v2

    .line 2868
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    int-to-char v2, v0

    invoke-virtual {v1, v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->append(C)V

    .line 2869
    return v4
.end method

.method private final _decodeUTF8_2(II)I
    .locals 2
    .param p1, "c"    # I
    .param p2, "d"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2954
    and-int/lit16 v0, p2, 0xc0

    const/16 v1, 0x80

    if-eq v0, v1, :cond_0

    .line 2955
    and-int/lit16 v0, p2, 0xff

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportInvalidOther(II)V

    .line 2957
    :cond_0
    and-int/lit8 v0, p1, 0x1f

    shl-int/lit8 v0, v0, 0x6

    and-int/lit8 v1, p2, 0x3f

    or-int/2addr v0, v1

    return v0
.end method

.method private final _decodeUTF8_3(III)I
    .locals 3
    .param p1, "c"    # I
    .param p2, "d"    # I
    .param p3, "e"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2962
    and-int/lit8 p1, p1, 0xf

    .line 2963
    and-int/lit16 v0, p2, 0xc0

    const/16 v1, 0x80

    if-eq v0, v1, :cond_0

    .line 2964
    and-int/lit16 v0, p2, 0xff

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportInvalidOther(II)V

    .line 2966
    :cond_0
    shl-int/lit8 v0, p1, 0x6

    and-int/lit8 v2, p2, 0x3f

    or-int p1, v0, v2

    .line 2967
    and-int/lit16 v0, p3, 0xc0

    if-eq v0, v1, :cond_1

    .line 2968
    and-int/lit16 v0, p3, 0xff

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportInvalidOther(II)V

    .line 2970
    :cond_1
    shl-int/lit8 v0, p1, 0x6

    and-int/lit8 v1, p3, 0x3f

    or-int/2addr v0, v1

    return v0
.end method

.method private final _decodeUTF8_4(IIII)I
    .locals 3
    .param p1, "c"    # I
    .param p2, "d"    # I
    .param p3, "e"    # I
    .param p4, "f"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2977
    and-int/lit16 v0, p2, 0xc0

    const/16 v1, 0x80

    if-eq v0, v1, :cond_0

    .line 2978
    and-int/lit16 v0, p2, 0xff

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportInvalidOther(II)V

    .line 2980
    :cond_0
    and-int/lit8 v0, p1, 0x7

    shl-int/lit8 v0, v0, 0x6

    and-int/lit8 v2, p2, 0x3f

    or-int p1, v0, v2

    .line 2981
    and-int/lit16 v0, p3, 0xc0

    if-eq v0, v1, :cond_1

    .line 2982
    and-int/lit16 v0, p3, 0xff

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportInvalidOther(II)V

    .line 2984
    :cond_1
    shl-int/lit8 v0, p1, 0x6

    and-int/lit8 v2, p3, 0x3f

    or-int p1, v0, v2

    .line 2985
    and-int/lit16 v0, p4, 0xc0

    if-eq v0, v1, :cond_2

    .line 2986
    and-int/lit16 v0, p4, 0xff

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportInvalidOther(II)V

    .line 2988
    :cond_2
    shl-int/lit8 v0, p1, 0x6

    and-int/lit8 v1, p4, 0x3f

    or-int/2addr v0, v1

    const/high16 v1, 0x10000

    sub-int/2addr v0, v1

    return v0
.end method

.method private final _fastParseName()Ljava/lang/String;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1933
    sget-object v0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_icLatin1:[I

    .line 1934
    .local v0, "codes":[I
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1936
    .local v1, "ptr":I
    add-int/lit8 v2, v1, 0x1

    .end local v1    # "ptr":I
    .local v2, "ptr":I
    invoke-virtual {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 1937
    .local v1, "q0":I
    aget v3, v0, v1

    const/4 v4, 0x0

    const/16 v5, 0x22

    if-nez v3, :cond_8

    .line 1938
    add-int/lit8 v3, v2, 0x1

    .end local v2    # "ptr":I
    .local v3, "ptr":I
    invoke-virtual {p0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v2

    and-int/lit16 v2, v2, 0xff

    .line 1939
    .local v2, "i":I
    aget v6, v0, v2

    if-nez v6, :cond_6

    .line 1940
    shl-int/lit8 v6, v1, 0x8

    or-int/2addr v6, v2

    .line 1941
    .local v6, "q":I
    add-int/lit8 v7, v3, 0x1

    .end local v3    # "ptr":I
    .local v7, "ptr":I
    invoke-virtual {p0, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v3

    and-int/lit16 v2, v3, 0xff

    .line 1942
    aget v3, v0, v2

    if-nez v3, :cond_4

    .line 1943
    shl-int/lit8 v3, v6, 0x8

    or-int/2addr v3, v2

    .line 1944
    .end local v6    # "q":I
    .local v3, "q":I
    add-int/lit8 v6, v7, 0x1

    .end local v7    # "ptr":I
    .local v6, "ptr":I
    invoke-virtual {p0, v7}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v7

    and-int/lit16 v2, v7, 0xff

    .line 1945
    aget v7, v0, v2

    if-nez v7, :cond_2

    .line 1946
    shl-int/lit8 v7, v3, 0x8

    or-int v3, v7, v2

    .line 1947
    add-int/lit8 v7, v6, 0x1

    .end local v6    # "ptr":I
    .restart local v7    # "ptr":I
    invoke-virtual {p0, v6}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v6

    and-int/lit16 v2, v6, 0xff

    .line 1948
    aget v6, v0, v2

    if-nez v6, :cond_0

    .line 1949
    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quad1:I

    .line 1950
    invoke-direct {p0, v7, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_parseMediumName(II)Ljava/lang/String;

    move-result-object v4

    return-object v4

    .line 1952
    :cond_0
    if-ne v2, v5, :cond_1

    .line 1953
    iput v7, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1954
    const/4 v4, 0x4

    invoke-virtual {p0, v3, v4}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_findName(II)Ljava/lang/String;

    move-result-object v4

    return-object v4

    .line 1956
    :cond_1
    return-object v4

    .line 1958
    .end local v7    # "ptr":I
    .restart local v6    # "ptr":I
    :cond_2
    if-ne v2, v5, :cond_3

    .line 1959
    iput v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1960
    const/4 v4, 0x3

    invoke-virtual {p0, v3, v4}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_findName(II)Ljava/lang/String;

    move-result-object v4

    return-object v4

    .line 1962
    :cond_3
    return-object v4

    .line 1964
    .end local v3    # "q":I
    .local v6, "q":I
    .restart local v7    # "ptr":I
    :cond_4
    if-ne v2, v5, :cond_5

    .line 1965
    iput v7, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1966
    const/4 v3, 0x2

    invoke-virtual {p0, v6, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_findName(II)Ljava/lang/String;

    move-result-object v3

    return-object v3

    .line 1968
    :cond_5
    return-object v4

    .line 1970
    .end local v6    # "q":I
    .end local v7    # "ptr":I
    .local v3, "ptr":I
    :cond_6
    if-ne v2, v5, :cond_7

    .line 1971
    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1972
    const/4 v4, 0x1

    invoke-virtual {p0, v1, v4}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_findName(II)Ljava/lang/String;

    move-result-object v4

    return-object v4

    .line 1974
    :cond_7
    return-object v4

    .line 1976
    .end local v3    # "ptr":I
    .local v2, "ptr":I
    :cond_8
    if-ne v1, v5, :cond_9

    .line 1977
    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1978
    const-string v3, ""

    return-object v3

    .line 1980
    :cond_9
    return-object v4
.end method

.method private _finishAposName(III)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 6
    .param p1, "qlen"    # I
    .param p2, "currQuad"    # I
    .param p3, "currQuadBytes"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2286
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadBuffer:[I

    .line 2287
    .local v0, "quads":[I
    sget-object v1, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_icLatin1:[I

    .line 2290
    .local v1, "codes":[I
    :goto_0
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    const/16 v4, 0x9

    if-lt v2, v3, :cond_0

    .line 2291
    iput p1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadLength:I

    .line 2292
    iput p2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    .line 2293
    iput p3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pendingBytes:I

    .line 2294
    iput v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 2295
    sget-object v2, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v2

    .line 2297
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v2

    .line 2298
    .local v2, "ch":I
    const/16 v3, 0x27

    if-ne v2, v3, :cond_5

    .line 2299
    nop

    .line 2365
    .end local v2    # "ch":I
    if-lez p3, :cond_2

    .line 2366
    array-length v2, v0

    if-lt p1, v2, :cond_1

    .line 2367
    array-length v2, v0

    invoke-static {v0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->growArrayBy([II)[I

    move-result-object v2

    move-object v0, v2

    iput-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadBuffer:[I

    .line 2369
    :cond_1
    add-int/lit8 v2, p1, 0x1

    .end local p1    # "qlen":I
    .local v2, "qlen":I
    invoke-static {p2, p3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_padLastQuad(II)I

    move-result v3

    aput v3, v0, p1

    move p1, v2

    goto :goto_1

    .line 2370
    .end local v2    # "qlen":I
    .restart local p1    # "qlen":I
    :cond_2
    if-nez p1, :cond_3

    .line 2371
    const-string v2, ""

    invoke-virtual {p0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_fieldComplete(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v2

    return-object v2

    .line 2373
    :cond_3
    :goto_1
    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_symbols:Lcom/fasterxml/jackson/core/sym/ByteQuadsCanonicalizer;

    invoke-virtual {v2, v0, p1}, Lcom/fasterxml/jackson/core/sym/ByteQuadsCanonicalizer;->findName([II)Ljava/lang/String;

    move-result-object v2

    .line 2374
    .local v2, "name":Ljava/lang/String;
    if-nez v2, :cond_4

    .line 2375
    invoke-virtual {p0, v0, p1, p3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_addName([III)Ljava/lang/String;

    move-result-object v2

    .line 2377
    :cond_4
    invoke-virtual {p0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_fieldComplete(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v3

    return-object v3

    .line 2302
    .local v2, "ch":I
    :cond_5
    const/16 v3, 0x22

    const/4 v5, 0x4

    if-eq v2, v3, :cond_d

    aget v3, v1, v2

    if-eqz v3, :cond_d

    .line 2303
    const/16 v3, 0x5c

    if-eq v2, v3, :cond_6

    .line 2305
    const-string v3, "name"

    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_throwUnquotedSpace(ILjava/lang/String;)V

    goto :goto_2

    .line 2308
    :cond_6
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeCharEscape()I

    move-result v2

    .line 2309
    if-gez v2, :cond_7

    .line 2310
    const/16 v3, 0x8

    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 2311
    iput v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorStateAfterSplit:I

    .line 2312
    iput p1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadLength:I

    .line 2313
    iput p2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    .line 2314
    iput p3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pendingBytes:I

    .line 2315
    sget-object v3, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v3

    .line 2318
    :cond_7
    :goto_2
    const/16 v3, 0x7f

    if-le v2, v3, :cond_d

    .line 2320
    if-lt p3, v5, :cond_9

    .line 2321
    array-length v3, v0

    if-lt p1, v3, :cond_8

    .line 2322
    array-length v3, v0

    invoke-static {v0, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->growArrayBy([II)[I

    move-result-object v3

    move-object v0, v3

    iput-object v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadBuffer:[I

    .line 2324
    :cond_8
    add-int/lit8 v3, p1, 0x1

    .end local p1    # "qlen":I
    .local v3, "qlen":I
    aput p2, v0, p1

    .line 2325
    const/4 p2, 0x0

    .line 2326
    const/4 p3, 0x0

    move p1, v3

    .line 2328
    .end local v3    # "qlen":I
    .restart local p1    # "qlen":I
    :cond_9
    const/16 v3, 0x800

    if-ge v2, v3, :cond_a

    .line 2329
    shl-int/lit8 v3, p2, 0x8

    shr-int/lit8 v4, v2, 0x6

    or-int/lit16 v4, v4, 0xc0

    or-int p2, v3, v4

    .line 2330
    add-int/lit8 p3, p3, 0x1

    goto :goto_3

    .line 2333
    :cond_a
    shl-int/lit8 v3, p2, 0x8

    shr-int/lit8 v4, v2, 0xc

    or-int/lit16 v4, v4, 0xe0

    or-int p2, v3, v4

    .line 2334
    add-int/lit8 p3, p3, 0x1

    .line 2336
    if-lt p3, v5, :cond_c

    .line 2337
    array-length v3, v0

    if-lt p1, v3, :cond_b

    .line 2338
    array-length v3, v0

    invoke-static {v0, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->growArrayBy([II)[I

    move-result-object v3

    move-object v0, v3

    iput-object v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadBuffer:[I

    .line 2340
    :cond_b
    add-int/lit8 v3, p1, 0x1

    .end local p1    # "qlen":I
    .restart local v3    # "qlen":I
    aput p2, v0, p1

    .line 2341
    const/4 p2, 0x0

    .line 2342
    const/4 p3, 0x0

    move p1, v3

    .line 2344
    .end local v3    # "qlen":I
    .restart local p1    # "qlen":I
    :cond_c
    shl-int/lit8 v3, p2, 0x8

    shr-int/lit8 v4, v2, 0x6

    and-int/lit8 v4, v4, 0x3f

    or-int/lit16 v4, v4, 0x80

    or-int p2, v3, v4

    .line 2345
    add-int/lit8 p3, p3, 0x1

    .line 2348
    :goto_3
    and-int/lit8 v3, v2, 0x3f

    or-int/lit16 v2, v3, 0x80

    .line 2352
    :cond_d
    if-ge p3, v5, :cond_e

    .line 2353
    add-int/lit8 p3, p3, 0x1

    .line 2354
    shl-int/lit8 v3, p2, 0x8

    or-int p2, v3, v2

    goto :goto_4

    .line 2356
    :cond_e
    array-length v3, v0

    if-lt p1, v3, :cond_f

    .line 2357
    array-length v3, v0

    invoke-static {v0, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->growArrayBy([II)[I

    move-result-object v3

    move-object v0, v3

    iput-object v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadBuffer:[I

    .line 2359
    :cond_f
    add-int/lit8 v3, p1, 0x1

    .end local p1    # "qlen":I
    .restart local v3    # "qlen":I
    aput p2, v0, p1

    .line 2360
    move p1, v2

    .line 2361
    .end local p2    # "currQuad":I
    .local p1, "currQuad":I
    const/4 p2, 0x1

    move p3, p2

    move p2, p1

    move p1, v3

    .line 2363
    .end local v2    # "ch":I
    .end local v3    # "qlen":I
    .local p1, "qlen":I
    .restart local p2    # "currQuad":I
    :goto_4
    goto/16 :goto_0
.end method

.method private final _finishAposString()Lcom/fasterxml/jackson/core/JsonToken;
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2659
    sget-object v0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_icUTF8:[I

    .line 2661
    .local v0, "codes":[I
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v1}, Lcom/fasterxml/jackson/core/util/TextBuffer;->getBufferWithoutReset()[C

    move-result-object v1

    .line 2662
    .local v1, "outBuf":[C
    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->getCurrentSegmentSize()I

    move-result v2

    .line 2663
    .local v2, "outPtr":I
    iget v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2664
    .local v3, "ptr":I
    iget v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    add-int/lit8 v4, v4, -0x5

    .line 2670
    .local v4, "safeEnd":I
    :goto_0
    iget v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    const/16 v6, 0x2d

    if-lt v3, v5, :cond_0

    .line 2671
    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2672
    iput v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 2673
    iget-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v5, v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 2674
    sget-object v5, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v5

    .line 2676
    :cond_0
    array-length v5, v1

    if-lt v2, v5, :cond_1

    .line 2677
    iget-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v5}, Lcom/fasterxml/jackson/core/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v1

    .line 2678
    const/4 v2, 0x0

    .line 2680
    :cond_1
    iget v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    array-length v7, v1

    sub-int/2addr v7, v2

    add-int/2addr v7, v3

    invoke-static {v5, v7}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 2681
    .local v5, "max":I
    :goto_1
    if-ge v3, v5, :cond_a

    .line 2682
    add-int/lit8 v7, v3, 0x1

    .end local v3    # "ptr":I
    .local v7, "ptr":I
    invoke-virtual {p0, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v3

    and-int/lit16 v3, v3, 0xff

    .line 2683
    .local v3, "c":I
    aget v8, v0, v3

    if-eqz v8, :cond_8

    const/16 v8, 0x22

    if-eq v3, v8, :cond_8

    .line 2684
    nop

    .line 2696
    .end local v5    # "max":I
    if-lt v7, v4, :cond_4

    .line 2697
    iput v7, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2698
    iget-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v5, v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 2699
    aget v5, v0, v3

    iget v8, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-ge v7, v8, :cond_2

    const/4 v8, 0x1

    goto :goto_2

    :cond_2
    const/4 v8, 0x0

    :goto_2
    invoke-direct {p0, v3, v5, v8}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeSplitMultiByte(IIZ)Z

    move-result v5

    if-nez v5, :cond_3

    .line 2700
    iput v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorStateAfterSplit:I

    .line 2701
    sget-object v5, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v5

    .line 2703
    :cond_3
    iget-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v5}, Lcom/fasterxml/jackson/core/util/TextBuffer;->getBufferWithoutReset()[C

    move-result-object v1

    .line 2704
    iget-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v5}, Lcom/fasterxml/jackson/core/util/TextBuffer;->getCurrentSegmentSize()I

    move-result v2

    .line 2705
    iget v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2706
    .end local v7    # "ptr":I
    .local v5, "ptr":I
    move v3, v5

    goto :goto_0

    .line 2709
    .end local v5    # "ptr":I
    .restart local v7    # "ptr":I
    :cond_4
    aget v5, v0, v3

    packed-switch v5, :pswitch_data_0

    .line 2734
    const/16 v5, 0x20

    if-ge v3, v5, :cond_6

    .line 2736
    const-string v5, "string value"

    invoke-virtual {p0, v3, v5}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_throwUnquotedSpace(ILjava/lang/String;)V

    goto :goto_4

    .line 2722
    :pswitch_0
    add-int/lit8 v5, v7, 0x1

    .end local v7    # "ptr":I
    .restart local v5    # "ptr":I
    invoke-virtual {p0, v7}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v6

    add-int/lit8 v7, v5, 0x1

    .end local v5    # "ptr":I
    .restart local v7    # "ptr":I
    invoke-virtual {p0, v5}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v5

    add-int/lit8 v8, v7, 0x1

    .line 2723
    .end local v7    # "ptr":I
    .local v8, "ptr":I
    invoke-virtual {p0, v7}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v7

    .line 2722
    invoke-direct {p0, v3, v6, v5, v7}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeUTF8_4(IIII)I

    move-result v3

    .line 2725
    add-int/lit8 v5, v2, 0x1

    .end local v2    # "outPtr":I
    .local v5, "outPtr":I
    shr-int/lit8 v6, v3, 0xa

    const v7, 0xd800

    or-int/2addr v6, v7

    int-to-char v6, v6

    aput-char v6, v1, v2

    .line 2726
    array-length v2, v1

    if-lt v5, v2, :cond_5

    .line 2727
    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v1

    .line 2728
    const/4 v2, 0x0

    .end local v5    # "outPtr":I
    .restart local v2    # "outPtr":I
    goto :goto_3

    .line 2726
    .end local v2    # "outPtr":I
    .restart local v5    # "outPtr":I
    :cond_5
    move v2, v5

    .line 2730
    .end local v5    # "outPtr":I
    .restart local v2    # "outPtr":I
    :goto_3
    and-int/lit16 v5, v3, 0x3ff

    const v6, 0xdc00

    or-int v3, v5, v6

    .line 2732
    move v5, v8

    goto :goto_5

    .line 2719
    .end local v8    # "ptr":I
    .restart local v7    # "ptr":I
    :pswitch_1
    add-int/lit8 v5, v7, 0x1

    .end local v7    # "ptr":I
    .local v5, "ptr":I
    invoke-virtual {p0, v7}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v6

    add-int/lit8 v7, v5, 0x1

    .end local v5    # "ptr":I
    .restart local v7    # "ptr":I
    invoke-virtual {p0, v5}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v5

    invoke-direct {p0, v3, v6, v5}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeUTF8_3(III)I

    move-result v3

    .line 2720
    move v5, v7

    goto :goto_5

    .line 2716
    :pswitch_2
    add-int/lit8 v5, v7, 0x1

    .end local v7    # "ptr":I
    .restart local v5    # "ptr":I
    invoke-virtual {p0, v7}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v6

    invoke-direct {p0, v3, v6}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeUTF8_2(II)I

    move-result v3

    .line 2717
    goto :goto_5

    .line 2711
    .end local v5    # "ptr":I
    .restart local v7    # "ptr":I
    :pswitch_3
    iput v7, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2712
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeFastCharEscape()I

    move-result v3

    .line 2713
    iget v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2714
    .end local v7    # "ptr":I
    .restart local v5    # "ptr":I
    goto :goto_5

    .line 2739
    .end local v5    # "ptr":I
    .restart local v7    # "ptr":I
    :cond_6
    invoke-virtual {p0, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportInvalidChar(I)V

    .line 2743
    :goto_4
    move v5, v7

    .end local v7    # "ptr":I
    .restart local v5    # "ptr":I
    :goto_5
    array-length v6, v1

    if-lt v2, v6, :cond_7

    .line 2744
    iget-object v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v6}, Lcom/fasterxml/jackson/core/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v1

    .line 2745
    const/4 v2, 0x0

    .line 2748
    :cond_7
    add-int/lit8 v6, v2, 0x1

    .end local v2    # "outPtr":I
    .local v6, "outPtr":I
    int-to-char v7, v3

    aput-char v7, v1, v2

    move v3, v5

    move v2, v6

    goto/16 :goto_0

    .line 2686
    .end local v6    # "outPtr":I
    .restart local v2    # "outPtr":I
    .local v5, "max":I
    .restart local v7    # "ptr":I
    :cond_8
    const/16 v8, 0x27

    if-ne v3, v8, :cond_9

    .line 2687
    iput v7, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2688
    iget-object v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v6, v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 2689
    sget-object v6, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_STRING:Lcom/fasterxml/jackson/core/JsonToken;

    invoke-virtual {p0, v6}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueComplete(Lcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v6

    return-object v6

    .line 2691
    :cond_9
    add-int/lit8 v8, v2, 0x1

    .end local v2    # "outPtr":I
    .local v8, "outPtr":I
    int-to-char v9, v3

    aput-char v9, v1, v2

    move v3, v7

    move v2, v8

    goto/16 :goto_1

    .line 2693
    .end local v5    # "max":I
    .end local v7    # "ptr":I
    .end local v8    # "outPtr":I
    .restart local v2    # "outPtr":I
    .local v3, "ptr":I
    :cond_a
    goto/16 :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private final _finishBOM(I)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 5
    .param p1, "bytesHandled"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 447
    nop

    :goto_0
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-ge v0, v1, :cond_1

    .line 448
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v0

    .line 449
    .local v0, "ch":I
    packed-switch p1, :pswitch_data_0

    goto :goto_1

    .line 453
    :pswitch_0
    iget-wide v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputProcessed:J

    const-wide/16 v3, 0x3

    sub-long/2addr v1, v3

    iput-wide v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputProcessed:J

    .line 454
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startDocument(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 456
    :pswitch_1
    const/16 v1, 0xbf

    if-eq v0, v1, :cond_0

    .line 457
    const-string v1, "Unexpected byte 0x%02x following 0xEF 0xBB; should get 0xBF as third byte of UTF-8 BOM"

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportError(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_1

    .line 461
    :pswitch_2
    const/16 v1, 0xbb

    if-eq v0, v1, :cond_0

    .line 462
    const-string v1, "Unexpected byte 0x%02x following 0xEF; should get 0xBB as second byte UTF-8 BOM"

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportError(Ljava/lang/String;Ljava/lang/Object;)V

    .line 466
    :cond_0
    :goto_1
    nop

    .end local v0    # "ch":I
    add-int/lit8 p1, p1, 0x1

    .line 467
    goto :goto_0

    .line 468
    :cond_1
    iput p1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    .line 469
    const/4 v0, 0x1

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 470
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private final _finishCComment(IZ)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 2
    .param p1, "fromMinorState"    # I
    .param p2, "gotStar"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1039
    nop

    :goto_0
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v0, v1, :cond_1

    .line 1040
    if-eqz p2, :cond_0

    const/16 v0, 0x34

    goto :goto_1

    :cond_0
    const/16 v0, 0x35

    :goto_1
    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1041
    iput p1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    .line 1042
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 1044
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v0

    .line 1045
    .local v0, "ch":I
    const/16 v1, 0x20

    if-ge v0, v1, :cond_4

    .line 1046
    const/16 v1, 0xa

    if-ne v0, v1, :cond_2

    .line 1047
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRow:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRow:I

    .line 1048
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRowStart:I

    goto :goto_2

    .line 1049
    :cond_2
    const/16 v1, 0xd

    if-ne v0, v1, :cond_3

    .line 1050
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRowAlt:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRowAlt:I

    .line 1051
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRowStart:I

    goto :goto_2

    .line 1052
    :cond_3
    const/16 v1, 0x9

    if-eq v0, v1, :cond_6

    .line 1053
    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_throwInvalidSpace(I)V

    goto :goto_2

    .line 1055
    :cond_4
    const/16 v1, 0x2a

    if-ne v0, v1, :cond_5

    .line 1056
    const/4 p2, 0x1

    .line 1057
    goto :goto_0

    .line 1058
    :cond_5
    const/16 v1, 0x2f

    if-ne v0, v1, :cond_6

    .line 1059
    if-eqz p2, :cond_6

    .line 1060
    nop

    .line 1065
    .end local v0    # "ch":I
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startAfterComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 1063
    .restart local v0    # "ch":I
    :cond_6
    :goto_2
    const/4 p2, 0x0

    .line 1064
    .end local v0    # "ch":I
    goto :goto_0
.end method

.method private final _finishCppComment(I)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 2
    .param p1, "fromMinorState"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1013
    nop

    :goto_0
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 1014
    const/16 v0, 0x36

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1015
    iput p1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    .line 1016
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 1018
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v0

    .line 1019
    .local v0, "ch":I
    const/16 v1, 0x20

    if-ge v0, v1, :cond_3

    .line 1020
    const/16 v1, 0xa

    if-ne v0, v1, :cond_1

    .line 1021
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRow:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRow:I

    .line 1022
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRowStart:I

    .line 1023
    goto :goto_1

    .line 1024
    :cond_1
    const/16 v1, 0xd

    if-ne v0, v1, :cond_2

    .line 1025
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRowAlt:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRowAlt:I

    .line 1026
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRowStart:I

    .line 1027
    nop

    .line 1033
    .end local v0    # "ch":I
    :goto_1
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startAfterComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 1028
    .restart local v0    # "ch":I
    :cond_2
    const/16 v1, 0x9

    if-eq v0, v1, :cond_3

    .line 1029
    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_throwInvalidSpace(I)V

    .line 1032
    .end local v0    # "ch":I
    :cond_3
    goto :goto_0
.end method

.method private final _finishHashComment(I)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 2
    .param p1, "fromMinorState"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 983
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_features:I

    sget v1, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->FEAT_MASK_ALLOW_YAML_COMMENTS:I

    and-int/2addr v0, v1

    if-nez v0, :cond_0

    .line 984
    const/16 v0, 0x23

    const-string v1, "maybe a (non-standard) comment? (not recognized as one since Feature \'ALLOW_YAML_COMMENTS\' not enabled for parser)"

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedChar(ILjava/lang/String;)V

    .line 987
    :cond_0
    :goto_0
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v0, v1, :cond_1

    .line 988
    const/16 v0, 0x37

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 989
    iput p1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    .line 990
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 992
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v0

    .line 993
    .local v0, "ch":I
    const/16 v1, 0x20

    if-ge v0, v1, :cond_4

    .line 994
    const/16 v1, 0xa

    if-ne v0, v1, :cond_2

    .line 995
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRow:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRow:I

    .line 996
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRowStart:I

    .line 997
    goto :goto_1

    .line 998
    :cond_2
    const/16 v1, 0xd

    if-ne v0, v1, :cond_3

    .line 999
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRowAlt:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRowAlt:I

    .line 1000
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRowStart:I

    .line 1001
    nop

    .line 1007
    .end local v0    # "ch":I
    :goto_1
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startAfterComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 1002
    .restart local v0    # "ch":I
    :cond_3
    const/16 v1, 0x9

    if-eq v0, v1, :cond_4

    .line 1003
    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_throwInvalidSpace(I)V

    .line 1006
    .end local v0    # "ch":I
    :cond_4
    goto :goto_0
.end method

.method private final _finishRegularString()Lcom/fasterxml/jackson/core/JsonToken;
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2535
    sget-object v0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_icUTF8:[I

    .line 2537
    .local v0, "codes":[I
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v1}, Lcom/fasterxml/jackson/core/util/TextBuffer;->getBufferWithoutReset()[C

    move-result-object v1

    .line 2538
    .local v1, "outBuf":[C
    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->getCurrentSegmentSize()I

    move-result v2

    .line 2539
    .local v2, "outPtr":I
    iget v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2540
    .local v3, "ptr":I
    iget v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    add-int/lit8 v4, v4, -0x5

    .line 2547
    .local v4, "safeEnd":I
    :goto_0
    iget v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    const/16 v6, 0x28

    if-lt v3, v5, :cond_0

    .line 2548
    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2549
    iput v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 2550
    iget-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v5, v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 2551
    sget-object v5, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v5

    .line 2553
    :cond_0
    array-length v5, v1

    if-lt v2, v5, :cond_1

    .line 2554
    iget-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v5}, Lcom/fasterxml/jackson/core/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v1

    .line 2555
    const/4 v2, 0x0

    .line 2557
    :cond_1
    iget v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    array-length v7, v1

    sub-int/2addr v7, v2

    add-int/2addr v7, v3

    invoke-static {v5, v7}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 2558
    .local v5, "max":I
    :goto_1
    if-ge v3, v5, :cond_a

    .line 2559
    add-int/lit8 v7, v3, 0x1

    .end local v3    # "ptr":I
    .local v7, "ptr":I
    invoke-virtual {p0, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v3

    and-int/lit16 v3, v3, 0xff

    .line 2560
    .local v3, "c":I
    aget v8, v0, v3

    if-eqz v8, :cond_9

    .line 2561
    nop

    .line 2567
    .end local v5    # "max":I
    const/16 v5, 0x22

    if-ne v3, v5, :cond_2

    .line 2568
    iput v7, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2569
    iget-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v5, v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 2570
    sget-object v5, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_STRING:Lcom/fasterxml/jackson/core/JsonToken;

    invoke-virtual {p0, v5}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueComplete(Lcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v5

    return-object v5

    .line 2573
    :cond_2
    if-lt v7, v4, :cond_5

    .line 2574
    iput v7, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2575
    iget-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v5, v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 2576
    aget v5, v0, v3

    iget v8, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-ge v7, v8, :cond_3

    const/4 v8, 0x1

    goto :goto_2

    :cond_3
    const/4 v8, 0x0

    :goto_2
    invoke-direct {p0, v3, v5, v8}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeSplitMultiByte(IIZ)Z

    move-result v5

    if-nez v5, :cond_4

    .line 2577
    iput v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorStateAfterSplit:I

    .line 2578
    sget-object v5, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v5

    .line 2580
    :cond_4
    iget-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v5}, Lcom/fasterxml/jackson/core/util/TextBuffer;->getBufferWithoutReset()[C

    move-result-object v1

    .line 2581
    iget-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v5}, Lcom/fasterxml/jackson/core/util/TextBuffer;->getCurrentSegmentSize()I

    move-result v2

    .line 2582
    iget v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2583
    .end local v7    # "ptr":I
    .local v5, "ptr":I
    move v3, v5

    goto :goto_0

    .line 2586
    .end local v5    # "ptr":I
    .restart local v7    # "ptr":I
    :cond_5
    aget v5, v0, v3

    packed-switch v5, :pswitch_data_0

    .line 2611
    const/16 v5, 0x20

    if-ge v3, v5, :cond_7

    .line 2613
    const-string v5, "string value"

    invoke-virtual {p0, v3, v5}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_throwUnquotedSpace(ILjava/lang/String;)V

    goto :goto_4

    .line 2599
    :pswitch_0
    add-int/lit8 v5, v7, 0x1

    .end local v7    # "ptr":I
    .restart local v5    # "ptr":I
    invoke-virtual {p0, v7}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v6

    add-int/lit8 v7, v5, 0x1

    .end local v5    # "ptr":I
    .restart local v7    # "ptr":I
    invoke-virtual {p0, v5}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v5

    add-int/lit8 v8, v7, 0x1

    .line 2600
    .end local v7    # "ptr":I
    .local v8, "ptr":I
    invoke-virtual {p0, v7}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v7

    .line 2599
    invoke-direct {p0, v3, v6, v5, v7}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeUTF8_4(IIII)I

    move-result v3

    .line 2602
    add-int/lit8 v5, v2, 0x1

    .end local v2    # "outPtr":I
    .local v5, "outPtr":I
    shr-int/lit8 v6, v3, 0xa

    const v7, 0xd800

    or-int/2addr v6, v7

    int-to-char v6, v6

    aput-char v6, v1, v2

    .line 2603
    array-length v2, v1

    if-lt v5, v2, :cond_6

    .line 2604
    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v1

    .line 2605
    const/4 v2, 0x0

    .end local v5    # "outPtr":I
    .restart local v2    # "outPtr":I
    goto :goto_3

    .line 2603
    .end local v2    # "outPtr":I
    .restart local v5    # "outPtr":I
    :cond_6
    move v2, v5

    .line 2607
    .end local v5    # "outPtr":I
    .restart local v2    # "outPtr":I
    :goto_3
    and-int/lit16 v5, v3, 0x3ff

    const v6, 0xdc00

    or-int v3, v5, v6

    .line 2609
    move v5, v8

    goto :goto_5

    .line 2596
    .end local v8    # "ptr":I
    .restart local v7    # "ptr":I
    :pswitch_1
    add-int/lit8 v5, v7, 0x1

    .end local v7    # "ptr":I
    .local v5, "ptr":I
    invoke-virtual {p0, v7}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v6

    add-int/lit8 v7, v5, 0x1

    .end local v5    # "ptr":I
    .restart local v7    # "ptr":I
    invoke-virtual {p0, v5}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v5

    invoke-direct {p0, v3, v6, v5}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeUTF8_3(III)I

    move-result v3

    .line 2597
    move v5, v7

    goto :goto_5

    .line 2593
    :pswitch_2
    add-int/lit8 v5, v7, 0x1

    .end local v7    # "ptr":I
    .restart local v5    # "ptr":I
    invoke-virtual {p0, v7}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v6

    invoke-direct {p0, v3, v6}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeUTF8_2(II)I

    move-result v3

    .line 2594
    goto :goto_5

    .line 2588
    .end local v5    # "ptr":I
    .restart local v7    # "ptr":I
    :pswitch_3
    iput v7, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2589
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeFastCharEscape()I

    move-result v3

    .line 2590
    iget v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2591
    .end local v7    # "ptr":I
    .restart local v5    # "ptr":I
    goto :goto_5

    .line 2616
    .end local v5    # "ptr":I
    .restart local v7    # "ptr":I
    :cond_7
    invoke-virtual {p0, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportInvalidChar(I)V

    .line 2620
    :goto_4
    move v5, v7

    .end local v7    # "ptr":I
    .restart local v5    # "ptr":I
    :goto_5
    array-length v6, v1

    if-lt v2, v6, :cond_8

    .line 2621
    iget-object v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v6}, Lcom/fasterxml/jackson/core/util/TextBuffer;->finishCurrentSegment()[C

    move-result-object v1

    .line 2622
    const/4 v2, 0x0

    .line 2625
    :cond_8
    add-int/lit8 v6, v2, 0x1

    .end local v2    # "outPtr":I
    .local v6, "outPtr":I
    int-to-char v7, v3

    aput-char v7, v1, v2

    move v3, v5

    move v2, v6

    goto/16 :goto_0

    .line 2563
    .end local v6    # "outPtr":I
    .restart local v2    # "outPtr":I
    .local v5, "max":I
    .restart local v7    # "ptr":I
    :cond_9
    add-int/lit8 v8, v2, 0x1

    .end local v2    # "outPtr":I
    .local v8, "outPtr":I
    int-to-char v9, v3

    aput-char v9, v1, v2

    move v3, v7

    move v2, v8

    goto/16 :goto_1

    .line 2565
    .end local v5    # "max":I
    .end local v7    # "ptr":I
    .end local v8    # "outPtr":I
    .restart local v2    # "outPtr":I
    .local v3, "ptr":I
    :cond_a
    goto/16 :goto_0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private _finishUnquotedName(III)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 4
    .param p1, "qlen"    # I
    .param p2, "currQuad"    # I
    .param p3, "currQuadBytes"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2238
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadBuffer:[I

    .line 2239
    .local v0, "quads":[I
    invoke-static {}, Lcom/fasterxml/jackson/core/io/CharTypes;->getInputCodeUtf8JsNames()[I

    move-result-object v1

    .line 2244
    .local v1, "codes":[I
    :goto_0
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v2, v3, :cond_0

    .line 2245
    iput p1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadLength:I

    .line 2246
    iput p2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    .line 2247
    iput p3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pendingBytes:I

    .line 2248
    const/16 v2, 0xa

    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 2249
    sget-object v2, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v2

    .line 2251
    :cond_0
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    invoke-virtual {p0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v2

    and-int/lit16 v2, v2, 0xff

    .line 2252
    .local v2, "ch":I
    aget v3, v1, v2

    if-eqz v3, :cond_4

    .line 2253
    nop

    .line 2270
    .end local v2    # "ch":I
    if-lez p3, :cond_2

    .line 2271
    array-length v2, v0

    if-lt p1, v2, :cond_1

    .line 2272
    array-length v2, v0

    invoke-static {v0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->growArrayBy([II)[I

    move-result-object v2

    move-object v0, v2

    iput-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadBuffer:[I

    .line 2274
    :cond_1
    add-int/lit8 v2, p1, 0x1

    .end local p1    # "qlen":I
    .local v2, "qlen":I
    aput p2, v0, p1

    move p1, v2

    .line 2276
    .end local v2    # "qlen":I
    .restart local p1    # "qlen":I
    :cond_2
    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_symbols:Lcom/fasterxml/jackson/core/sym/ByteQuadsCanonicalizer;

    invoke-virtual {v2, v0, p1}, Lcom/fasterxml/jackson/core/sym/ByteQuadsCanonicalizer;->findName([II)Ljava/lang/String;

    move-result-object v2

    .line 2277
    .local v2, "name":Ljava/lang/String;
    if-nez v2, :cond_3

    .line 2278
    invoke-virtual {p0, v0, p1, p3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_addName([III)Ljava/lang/String;

    move-result-object v2

    .line 2280
    :cond_3
    invoke-virtual {p0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_fieldComplete(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v3

    return-object v3

    .line 2255
    .local v2, "ch":I
    :cond_4
    iget v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2257
    const/4 v3, 0x4

    if-ge p3, v3, :cond_5

    .line 2258
    add-int/lit8 p3, p3, 0x1

    .line 2259
    shl-int/lit8 v3, p2, 0x8

    or-int p2, v3, v2

    goto :goto_1

    .line 2261
    :cond_5
    array-length v3, v0

    if-lt p1, v3, :cond_6

    .line 2262
    array-length v3, v0

    invoke-static {v0, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->growArrayBy([II)[I

    move-result-object v3

    move-object v0, v3

    iput-object v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadBuffer:[I

    .line 2264
    :cond_6
    add-int/lit8 v3, p1, 0x1

    .end local p1    # "qlen":I
    .local v3, "qlen":I
    aput p2, v0, p1

    .line 2265
    move p1, v2

    .line 2266
    .end local p2    # "currQuad":I
    .local p1, "currQuad":I
    const/4 p2, 0x1

    move p3, p2

    move p2, p1

    move p1, v3

    .line 2268
    .end local v2    # "ch":I
    .end local v3    # "qlen":I
    .local p1, "qlen":I
    .restart local p2    # "currQuad":I
    :goto_1
    goto :goto_0
.end method

.method private _handleOddName(I)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 4
    .param p1, "ch"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2194
    const/4 v0, 0x4

    const/4 v1, 0x0

    sparse-switch p1, :sswitch_data_0

    goto :goto_0

    .line 2210
    :sswitch_0
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_closeArrayScope()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 2203
    :sswitch_1
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startSlashComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 2205
    :sswitch_2
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_features:I

    sget v2, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->FEAT_MASK_ALLOW_SINGLE_QUOTES:I

    and-int/2addr v0, v2

    if-eqz v0, :cond_0

    .line 2206
    invoke-direct {p0, v1, v1, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishAposName(III)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 2198
    :sswitch_3
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_features:I

    sget v3, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->FEAT_MASK_ALLOW_YAML_COMMENTS:I

    and-int/2addr v2, v3

    if-eqz v2, :cond_0

    .line 2199
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishHashComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 2213
    :cond_0
    :goto_0
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_features:I

    sget v2, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->FEAT_MASK_ALLOW_UNQUOTED_NAMES:I

    and-int/2addr v0, v2

    if-nez v0, :cond_1

    .line 2216
    int-to-char v0, p1

    .line 2217
    .local v0, "c":C
    const-string v2, "was expecting double-quote to start field name"

    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedChar(ILjava/lang/String;)V

    .line 2221
    .end local v0    # "c":C
    :cond_1
    invoke-static {}, Lcom/fasterxml/jackson/core/io/CharTypes;->getInputCodeUtf8JsNames()[I

    move-result-object v0

    .line 2223
    .local v0, "codes":[I
    aget v2, v0, p1

    if-eqz v2, :cond_2

    .line 2224
    const-string v2, "was expecting either valid name character (for unquoted name) or double-quote (for quoted) to start field name"

    invoke-virtual {p0, p1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedChar(ILjava/lang/String;)V

    .line 2227
    :cond_2
    const/4 v2, 0x1

    invoke-direct {p0, v1, p1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishUnquotedName(III)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    :sswitch_data_0
    .sparse-switch
        0x23 -> :sswitch_3
        0x27 -> :sswitch_2
        0x2f -> :sswitch_1
        0x5d -> :sswitch_0
    .end sparse-switch
.end method

.method private final _parseEscapedName(III)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 6
    .param p1, "qlen"    # I
    .param p2, "currQuad"    # I
    .param p3, "currQuadBytes"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2080
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadBuffer:[I

    .line 2081
    .local v0, "quads":[I
    sget-object v1, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_icLatin1:[I

    .line 2084
    .local v1, "codes":[I
    :goto_0
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    const/4 v4, 0x7

    if-lt v2, v3, :cond_0

    .line 2085
    iput p1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadLength:I

    .line 2086
    iput p2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    .line 2087
    iput p3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pendingBytes:I

    .line 2088
    iput v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 2089
    sget-object v2, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v2

    .line 2091
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v2

    .line 2092
    .local v2, "ch":I
    aget v3, v1, v2

    const/4 v5, 0x4

    if-nez v3, :cond_3

    .line 2093
    if-ge p3, v5, :cond_1

    .line 2094
    add-int/lit8 p3, p3, 0x1

    .line 2095
    shl-int/lit8 v3, p2, 0x8

    or-int p2, v3, v2

    .line 2096
    goto :goto_0

    .line 2098
    :cond_1
    array-length v3, v0

    if-lt p1, v3, :cond_2

    .line 2099
    array-length v3, v0

    invoke-static {v0, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->growArrayBy([II)[I

    move-result-object v3

    move-object v0, v3

    iput-object v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadBuffer:[I

    .line 2101
    :cond_2
    add-int/lit8 v3, p1, 0x1

    .end local p1    # "qlen":I
    .local v3, "qlen":I
    aput p2, v0, p1

    .line 2102
    move p2, v2

    .line 2103
    const/4 p3, 0x1

    .line 2104
    move p1, v3

    goto :goto_0

    .line 2108
    .end local v3    # "qlen":I
    .restart local p1    # "qlen":I
    :cond_3
    const/16 v3, 0x22

    if-ne v2, v3, :cond_8

    .line 2109
    nop

    .line 2170
    .end local v2    # "ch":I
    if-lez p3, :cond_5

    .line 2171
    array-length v2, v0

    if-lt p1, v2, :cond_4

    .line 2172
    array-length v2, v0

    invoke-static {v0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->growArrayBy([II)[I

    move-result-object v2

    move-object v0, v2

    iput-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadBuffer:[I

    .line 2174
    :cond_4
    add-int/lit8 v2, p1, 0x1

    .end local p1    # "qlen":I
    .local v2, "qlen":I
    invoke-static {p2, p3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_padLastQuad(II)I

    move-result v3

    aput v3, v0, p1

    move p1, v2

    goto :goto_1

    .line 2175
    .end local v2    # "qlen":I
    .restart local p1    # "qlen":I
    :cond_5
    if-nez p1, :cond_6

    .line 2176
    const-string v2, ""

    invoke-virtual {p0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_fieldComplete(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v2

    return-object v2

    .line 2178
    :cond_6
    :goto_1
    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_symbols:Lcom/fasterxml/jackson/core/sym/ByteQuadsCanonicalizer;

    invoke-virtual {v2, v0, p1}, Lcom/fasterxml/jackson/core/sym/ByteQuadsCanonicalizer;->findName([II)Ljava/lang/String;

    move-result-object v2

    .line 2179
    .local v2, "name":Ljava/lang/String;
    if-nez v2, :cond_7

    .line 2180
    invoke-virtual {p0, v0, p1, p3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_addName([III)Ljava/lang/String;

    move-result-object v2

    .line 2182
    :cond_7
    invoke-virtual {p0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_fieldComplete(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v3

    return-object v3

    .line 2112
    .local v2, "ch":I
    :cond_8
    const/16 v3, 0x5c

    if-eq v2, v3, :cond_9

    .line 2114
    const-string v3, "name"

    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_throwUnquotedSpace(ILjava/lang/String;)V

    goto :goto_2

    .line 2117
    :cond_9
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeCharEscape()I

    move-result v2

    .line 2118
    if-gez v2, :cond_a

    .line 2119
    const/16 v3, 0x8

    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 2120
    iput v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorStateAfterSplit:I

    .line 2121
    iput p1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadLength:I

    .line 2122
    iput p2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    .line 2123
    iput p3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pendingBytes:I

    .line 2124
    sget-object v3, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v3

    .line 2131
    :cond_a
    :goto_2
    array-length v3, v0

    if-lt p1, v3, :cond_b

    .line 2132
    array-length v3, v0

    invoke-static {v0, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->growArrayBy([II)[I

    move-result-object v3

    move-object v0, v3

    iput-object v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadBuffer:[I

    .line 2134
    :cond_b
    const/16 v3, 0x7f

    if-le v2, v3, :cond_f

    .line 2136
    if-lt p3, v5, :cond_c

    .line 2137
    add-int/lit8 v3, p1, 0x1

    .end local p1    # "qlen":I
    .restart local v3    # "qlen":I
    aput p2, v0, p1

    .line 2138
    const/4 p2, 0x0

    .line 2139
    const/4 p3, 0x0

    move p1, v3

    .line 2141
    .end local v3    # "qlen":I
    .restart local p1    # "qlen":I
    :cond_c
    const/16 v3, 0x800

    if-ge v2, v3, :cond_d

    .line 2142
    shl-int/lit8 v3, p2, 0x8

    shr-int/lit8 v4, v2, 0x6

    or-int/lit16 v4, v4, 0xc0

    or-int p2, v3, v4

    .line 2143
    add-int/lit8 p3, p3, 0x1

    goto :goto_3

    .line 2146
    :cond_d
    shl-int/lit8 v3, p2, 0x8

    shr-int/lit8 v4, v2, 0xc

    or-int/lit16 v4, v4, 0xe0

    or-int p2, v3, v4

    .line 2147
    add-int/lit8 p3, p3, 0x1

    .line 2149
    if-lt p3, v5, :cond_e

    .line 2150
    add-int/lit8 v3, p1, 0x1

    .end local p1    # "qlen":I
    .restart local v3    # "qlen":I
    aput p2, v0, p1

    .line 2151
    const/4 p2, 0x0

    .line 2152
    const/4 p3, 0x0

    move p1, v3

    .line 2154
    .end local v3    # "qlen":I
    .restart local p1    # "qlen":I
    :cond_e
    shl-int/lit8 v3, p2, 0x8

    shr-int/lit8 v4, v2, 0x6

    and-int/lit8 v4, v4, 0x3f

    or-int/lit16 v4, v4, 0x80

    or-int p2, v3, v4

    .line 2155
    add-int/lit8 p3, p3, 0x1

    .line 2158
    :goto_3
    and-int/lit8 v3, v2, 0x3f

    or-int/lit16 v2, v3, 0x80

    .line 2160
    :cond_f
    if-ge p3, v5, :cond_10

    .line 2161
    add-int/lit8 p3, p3, 0x1

    .line 2162
    shl-int/lit8 v3, p2, 0x8

    or-int p2, v3, v2

    .line 2163
    goto/16 :goto_0

    .line 2165
    :cond_10
    add-int/lit8 v3, p1, 0x1

    .end local p1    # "qlen":I
    .restart local v3    # "qlen":I
    aput p2, v0, p1

    .line 2166
    move p2, v2

    .line 2167
    const/4 p3, 0x1

    .line 2168
    .end local v2    # "ch":I
    move p1, v3

    goto/16 :goto_0
.end method

.method private final _parseMediumName(II)Ljava/lang/String;
    .locals 5
    .param p1, "ptr"    # I
    .param p2, "q2"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1985
    sget-object v0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_icLatin1:[I

    .line 1988
    .local v0, "codes":[I
    add-int/lit8 v1, p1, 0x1

    .end local p1    # "ptr":I
    .local v1, "ptr":I
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result p1

    and-int/lit16 p1, p1, 0xff

    .line 1989
    .local p1, "i":I
    aget v2, v0, p1

    const/4 v3, 0x0

    const/16 v4, 0x22

    if-nez v2, :cond_6

    .line 1990
    shl-int/lit8 v2, p2, 0x8

    or-int p2, v2, p1

    .line 1991
    add-int/lit8 v2, v1, 0x1

    .end local v1    # "ptr":I
    .local v2, "ptr":I
    invoke-virtual {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v1

    and-int/lit16 p1, v1, 0xff

    .line 1992
    aget v1, v0, p1

    if-nez v1, :cond_4

    .line 1993
    shl-int/lit8 v1, p2, 0x8

    or-int p2, v1, p1

    .line 1994
    add-int/lit8 v1, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v1    # "ptr":I
    invoke-virtual {p0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v2

    and-int/lit16 p1, v2, 0xff

    .line 1995
    aget v2, v0, p1

    if-nez v2, :cond_2

    .line 1996
    shl-int/lit8 v2, p2, 0x8

    or-int p2, v2, p1

    .line 1997
    add-int/lit8 v2, v1, 0x1

    .end local v1    # "ptr":I
    .restart local v2    # "ptr":I
    invoke-virtual {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v1

    and-int/lit16 p1, v1, 0xff

    .line 1998
    aget v1, v0, p1

    if-nez v1, :cond_0

    .line 1999
    invoke-direct {p0, v2, p1, p2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_parseMediumName2(III)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 2001
    :cond_0
    if-ne p1, v4, :cond_1

    .line 2002
    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2003
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quad1:I

    const/4 v3, 0x4

    invoke-virtual {p0, v1, p2, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_findName(III)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 2005
    :cond_1
    return-object v3

    .line 2007
    .end local v2    # "ptr":I
    .restart local v1    # "ptr":I
    :cond_2
    if-ne p1, v4, :cond_3

    .line 2008
    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2009
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quad1:I

    const/4 v3, 0x3

    invoke-virtual {p0, v2, p2, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_findName(III)Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 2011
    :cond_3
    return-object v3

    .line 2013
    .end local v1    # "ptr":I
    .restart local v2    # "ptr":I
    :cond_4
    if-ne p1, v4, :cond_5

    .line 2014
    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2015
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quad1:I

    const/4 v3, 0x2

    invoke-virtual {p0, v1, p2, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_findName(III)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 2017
    :cond_5
    return-object v3

    .line 2019
    .end local v2    # "ptr":I
    .restart local v1    # "ptr":I
    :cond_6
    if-ne p1, v4, :cond_7

    .line 2020
    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2021
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quad1:I

    const/4 v3, 0x1

    invoke-virtual {p0, v2, p2, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_findName(III)Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 2023
    :cond_7
    return-object v3
.end method

.method private final _parseMediumName2(III)Ljava/lang/String;
    .locals 5
    .param p1, "ptr"    # I
    .param p2, "q3"    # I
    .param p3, "q2"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2028
    sget-object v0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_icLatin1:[I

    .line 2031
    .local v0, "codes":[I
    add-int/lit8 v1, p1, 0x1

    .end local p1    # "ptr":I
    .local v1, "ptr":I
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result p1

    and-int/lit16 p1, p1, 0xff

    .line 2032
    .local p1, "i":I
    aget v2, v0, p1

    const/4 v3, 0x0

    const/16 v4, 0x22

    if-eqz v2, :cond_1

    .line 2033
    if-ne p1, v4, :cond_0

    .line 2034
    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2035
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quad1:I

    const/4 v3, 0x1

    invoke-virtual {p0, v2, p3, p2, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_findName(IIII)Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 2037
    :cond_0
    return-object v3

    .line 2039
    :cond_1
    shl-int/lit8 v2, p2, 0x8

    or-int p2, v2, p1

    .line 2040
    add-int/lit8 v2, v1, 0x1

    .end local v1    # "ptr":I
    .local v2, "ptr":I
    invoke-virtual {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v1

    and-int/lit16 p1, v1, 0xff

    .line 2041
    aget v1, v0, p1

    if-eqz v1, :cond_3

    .line 2042
    if-ne p1, v4, :cond_2

    .line 2043
    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2044
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quad1:I

    const/4 v3, 0x2

    invoke-virtual {p0, v1, p3, p2, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_findName(IIII)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 2046
    :cond_2
    return-object v3

    .line 2048
    :cond_3
    shl-int/lit8 v1, p2, 0x8

    or-int p2, v1, p1

    .line 2049
    add-int/lit8 v1, v2, 0x1

    .end local v2    # "ptr":I
    .restart local v1    # "ptr":I
    invoke-virtual {p0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v2

    and-int/lit16 p1, v2, 0xff

    .line 2050
    aget v2, v0, p1

    if-eqz v2, :cond_5

    .line 2051
    if-ne p1, v4, :cond_4

    .line 2052
    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2053
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quad1:I

    const/4 v3, 0x3

    invoke-virtual {p0, v2, p3, p2, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_findName(IIII)Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 2055
    :cond_4
    return-object v3

    .line 2057
    :cond_5
    shl-int/lit8 v2, p2, 0x8

    or-int p2, v2, p1

    .line 2058
    add-int/lit8 v2, v1, 0x1

    .end local v1    # "ptr":I
    .restart local v2    # "ptr":I
    invoke-virtual {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v1

    and-int/lit16 p1, v1, 0xff

    .line 2059
    if-ne p1, v4, :cond_6

    .line 2060
    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2061
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quad1:I

    const/4 v3, 0x4

    invoke-virtual {p0, v1, p3, p2, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_findName(IIII)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 2064
    :cond_6
    return-object v3
.end method

.method private final _skipWS(I)I
    .locals 3
    .param p1, "ch"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 937
    nop

    :cond_0
    const/16 v0, 0x20

    if-eq p1, v0, :cond_3

    .line 938
    const/16 v1, 0xa

    if-ne p1, v1, :cond_1

    .line 939
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRow:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRow:I

    .line 940
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRowStart:I

    goto :goto_0

    .line 941
    :cond_1
    const/16 v1, 0xd

    if-ne p1, v1, :cond_2

    .line 942
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRowAlt:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRowAlt:I

    .line 943
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRowStart:I

    goto :goto_0

    .line 944
    :cond_2
    const/16 v1, 0x9

    if-eq p1, v1, :cond_3

    .line 945
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_throwInvalidSpace(I)V

    .line 948
    :cond_3
    :goto_0
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v1, v2, :cond_4

    .line 949
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    .line 950
    const/4 v0, 0x0

    return v0

    .line 952
    :cond_4
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result p1

    .line 953
    if-le p1, v0, :cond_0

    .line 954
    return p1
.end method

.method private final _startAfterComment(I)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 2
    .param p1, "fromMinorState"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1071
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 1072
    iput p1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1073
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 1075
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v0

    .line 1076
    .local v0, "ch":I
    sparse-switch p1, :sswitch_data_0

    .line 1091
    invoke-static {}, Lcom/fasterxml/jackson/core/util/VersionUtil;->throwInternal()V

    .line 1092
    const/4 v1, 0x0

    return-object v1

    .line 1088
    :sswitch_0
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startValueAfterComma(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 1086
    :sswitch_1
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startValueExpectColon(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 1084
    :sswitch_2
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startValueExpectComma(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 1082
    :sswitch_3
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startValue(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 1080
    :sswitch_4
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFieldNameAfterComma(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 1078
    :sswitch_5
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFieldName(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    nop

    :sswitch_data_0
    .sparse-switch
        0x4 -> :sswitch_5
        0x5 -> :sswitch_4
        0xc -> :sswitch_3
        0xd -> :sswitch_2
        0xe -> :sswitch_1
        0xf -> :sswitch_0
    .end sparse-switch
.end method

.method private final _startDocument(I)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 3
    .param p1, "ch"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 405
    and-int/lit16 p1, p1, 0xff

    .line 408
    const/16 v0, 0xef

    const/4 v1, 0x1

    if-ne p1, v0, :cond_0

    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    if-eq v0, v1, :cond_0

    .line 409
    invoke-direct {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishBOM(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 413
    :cond_0
    :goto_0
    const/16 v0, 0x20

    if-gt p1, v0, :cond_7

    .line 414
    if-eq p1, v0, :cond_3

    .line 415
    const/16 v0, 0xa

    if-ne p1, v0, :cond_1

    .line 416
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRow:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRow:I

    .line 417
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRowStart:I

    goto :goto_1

    .line 418
    :cond_1
    const/16 v0, 0xd

    if-ne p1, v0, :cond_2

    .line 419
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRowAlt:I

    add-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRowAlt:I

    .line 420
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputRowStart:I

    goto :goto_1

    .line 421
    :cond_2
    const/16 v0, 0x9

    if-eq p1, v0, :cond_3

    .line 422
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_throwInvalidSpace(I)V

    .line 425
    :cond_3
    :goto_1
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v0, v2, :cond_6

    .line 426
    const/4 v0, 0x3

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 427
    iget-boolean v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_closed:Z

    if-eqz v0, :cond_4

    .line 428
    const/4 v0, 0x0

    return-object v0

    .line 431
    :cond_4
    iget-boolean v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_endOfInput:Z

    if-eqz v0, :cond_5

    .line 432
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_eofAsNextToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 434
    :cond_5
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 436
    :cond_6
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result p1

    goto :goto_0

    .line 438
    :cond_7
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startValue(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0
.end method

.method private final _startFieldName(I)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 2
    .param p1, "ch"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 486
    const/16 v0, 0x20

    if-gt p1, v0, :cond_0

    .line 487
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_skipWS(I)I

    move-result p1

    .line 488
    if-gtz p1, :cond_0

    .line 489
    const/4 v0, 0x4

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 490
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 493
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_updateTokenLocation()V

    .line 494
    const/16 v0, 0x22

    if-eq p1, v0, :cond_2

    .line 495
    const/16 v0, 0x7d

    if-ne p1, v0, :cond_1

    .line 496
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_closeObjectScope()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 498
    :cond_1
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_handleOddName(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 501
    :cond_2
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    add-int/lit8 v0, v0, 0xd

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-gt v0, v1, :cond_3

    .line 502
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_fastParseName()Ljava/lang/String;

    move-result-object v0

    .line 503
    .local v0, "n":Ljava/lang/String;
    if-eqz v0, :cond_3

    .line 504
    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_fieldComplete(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 507
    .end local v0    # "n":Ljava/lang/String;
    :cond_3
    const/4 v0, 0x0

    invoke-direct {p0, v0, v0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_parseEscapedName(III)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0
.end method

.method private final _startFieldNameAfterComma(I)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 5
    .param p1, "ch"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 513
    const/4 v0, 0x5

    const/16 v1, 0x20

    if-gt p1, v1, :cond_0

    .line 514
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_skipWS(I)I

    move-result p1

    .line 515
    if-gtz p1, :cond_0

    .line 516
    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 517
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 520
    :cond_0
    const/16 v2, 0x2c

    const/16 v3, 0x7d

    if-eq p1, v2, :cond_4

    .line 521
    if-ne p1, v3, :cond_1

    .line 522
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_closeObjectScope()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 524
    :cond_1
    const/16 v2, 0x23

    if-ne p1, v2, :cond_2

    .line 525
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishHashComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 527
    :cond_2
    const/16 v2, 0x2f

    if-ne p1, v2, :cond_3

    .line 528
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startSlashComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 530
    :cond_3
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "was expecting comma to separate "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_parsingContext:Lcom/fasterxml/jackson/core/json/JsonReadContext;

    invoke-virtual {v2}, Lcom/fasterxml/jackson/core/json/JsonReadContext;->typeDesc()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " entries"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedChar(ILjava/lang/String;)V

    .line 532
    :cond_4
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 533
    .local v0, "ptr":I
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    const/4 v4, 0x4

    if-lt v0, v2, :cond_5

    .line 534
    iput v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 535
    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v1

    .line 537
    :cond_5
    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result p1

    .line 538
    add-int/lit8 v2, v0, 0x1

    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 539
    if-gt p1, v1, :cond_6

    .line 540
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_skipWS(I)I

    move-result p1

    .line 541
    if-gtz p1, :cond_6

    .line 542
    iput v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 543
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v1

    .line 546
    :cond_6
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_updateTokenLocation()V

    .line 547
    const/16 v1, 0x22

    if-eq p1, v1, :cond_8

    .line 548
    if-ne p1, v3, :cond_7

    .line 549
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_features:I

    sget v2, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->FEAT_MASK_TRAILING_COMMA:I

    and-int/2addr v1, v2

    if-eqz v1, :cond_7

    .line 550
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_closeObjectScope()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 553
    :cond_7
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_handleOddName(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 556
    :cond_8
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    add-int/lit8 v1, v1, 0xd

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-gt v1, v2, :cond_9

    .line 557
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_fastParseName()Ljava/lang/String;

    move-result-object v1

    .line 558
    .local v1, "n":Ljava/lang/String;
    if-eqz v1, :cond_9

    .line 559
    invoke-virtual {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_fieldComplete(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v2

    return-object v2

    .line 562
    .end local v1    # "n":Ljava/lang/String;
    :cond_9
    const/4 v1, 0x0

    invoke-direct {p0, v1, v1, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_parseEscapedName(III)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1
.end method

.method private final _startSlashComment(I)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 3
    .param p1, "fromMinorState"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 959
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_features:I

    sget v1, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->FEAT_MASK_ALLOW_JAVA_COMMENTS:I

    and-int/2addr v0, v1

    const/16 v1, 0x2f

    if-nez v0, :cond_0

    .line 960
    const-string v0, "maybe a (non-standard) comment? (not recognized as one since Feature \'ALLOW_COMMENTS\' not enabled for parser)"

    invoke-virtual {p0, v1, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedChar(ILjava/lang/String;)V

    .line 964
    :cond_0
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v0, v2, :cond_1

    .line 965
    iput p1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    .line 966
    const/16 v0, 0x33

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 967
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 969
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result v0

    .line 970
    .local v0, "ch":I
    const/16 v2, 0x2a

    if-ne v0, v2, :cond_2

    .line 971
    const/4 v1, 0x0

    invoke-direct {p0, p1, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishCComment(IZ)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 973
    :cond_2
    if-ne v0, v1, :cond_3

    .line 974
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishCppComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 976
    :cond_3
    and-int/lit16 v1, v0, 0xff

    const-string v2, "was expecting either \'*\' or \'/\' for a comment"

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedChar(ILjava/lang/String;)V

    .line 977
    const/4 v1, 0x0

    return-object v1
.end method

.method private final _startValue(I)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 2
    .param p1, "ch"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 579
    const/16 v0, 0x20

    const/16 v1, 0xc

    if-gt p1, v0, :cond_0

    .line 580
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_skipWS(I)I

    move-result p1

    .line 581
    if-gtz p1, :cond_0

    .line 582
    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 583
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 586
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_updateTokenLocation()V

    .line 588
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_parsingContext:Lcom/fasterxml/jackson/core/json/JsonReadContext;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/json/JsonReadContext;->expectComma()Z

    .line 590
    const/16 v0, 0x22

    if-ne p1, v0, :cond_1

    .line 591
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startString()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 593
    :cond_1
    sparse-switch p1, :sswitch_data_0

    goto :goto_0

    .line 638
    :sswitch_0
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_closeObjectScope()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 636
    :sswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startObjectScope()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 630
    :sswitch_2
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startTrueToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 628
    :sswitch_3
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startNullToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 626
    :sswitch_4
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFalseToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 634
    :sswitch_5
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_closeArrayScope()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 632
    :sswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startArrayScope()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 624
    :sswitch_7
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startPositiveNumber(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 614
    :sswitch_8
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startNumberLeadingZero()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 601
    :sswitch_9
    invoke-direct {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startSlashComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 608
    :sswitch_a
    sget-object v0, Lcom/fasterxml/jackson/core/json/JsonReadFeature;->ALLOW_LEADING_DECIMAL_POINT_FOR_NUMBERS:Lcom/fasterxml/jackson/core/json/JsonReadFeature;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/json/JsonReadFeature;->mappedFeature()Lcom/fasterxml/jackson/core/JsonParser$Feature;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->isEnabled(Lcom/fasterxml/jackson/core/JsonParser$Feature;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 609
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFloatThatStartsWithPeriod()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 599
    :sswitch_b
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startNegativeNumber()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 597
    :sswitch_c
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startPositiveNumber()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 595
    :sswitch_d
    invoke-direct {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishHashComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 641
    :cond_2
    :goto_0
    const/4 v0, 0x0

    invoke-virtual {p0, v0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startUnexpectedValue(ZI)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    :sswitch_data_0
    .sparse-switch
        0x23 -> :sswitch_d
        0x2b -> :sswitch_c
        0x2d -> :sswitch_b
        0x2e -> :sswitch_a
        0x2f -> :sswitch_9
        0x30 -> :sswitch_8
        0x31 -> :sswitch_7
        0x32 -> :sswitch_7
        0x33 -> :sswitch_7
        0x34 -> :sswitch_7
        0x35 -> :sswitch_7
        0x36 -> :sswitch_7
        0x37 -> :sswitch_7
        0x38 -> :sswitch_7
        0x39 -> :sswitch_7
        0x5b -> :sswitch_6
        0x5d -> :sswitch_5
        0x66 -> :sswitch_4
        0x6e -> :sswitch_3
        0x74 -> :sswitch_2
        0x7b -> :sswitch_1
        0x7d -> :sswitch_0
    .end sparse-switch
.end method

.method private final _startValueAfterComma(I)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 2
    .param p1, "ch"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 824
    const/16 v0, 0x20

    const/16 v1, 0xf

    if-gt p1, v0, :cond_0

    .line 825
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_skipWS(I)I

    move-result p1

    .line 826
    if-gtz p1, :cond_0

    .line 827
    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 828
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 831
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_updateTokenLocation()V

    .line 832
    const/16 v0, 0x22

    if-ne p1, v0, :cond_1

    .line 833
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startString()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 835
    :cond_1
    sparse-switch p1, :sswitch_data_0

    goto :goto_0

    .line 878
    :sswitch_0
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_features:I

    sget v1, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->FEAT_MASK_TRAILING_COMMA:I

    and-int/2addr v0, v1

    if-eqz v0, :cond_2

    .line 879
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_closeObjectScope()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 875
    :sswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startObjectScope()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 865
    :sswitch_2
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startTrueToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 863
    :sswitch_3
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startNullToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 861
    :sswitch_4
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFalseToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 870
    :sswitch_5
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_features:I

    sget v1, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->FEAT_MASK_TRAILING_COMMA:I

    and-int/2addr v0, v1

    if-eqz v0, :cond_2

    .line 871
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_closeArrayScope()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 867
    :sswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startArrayScope()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 859
    :sswitch_7
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startPositiveNumber(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 849
    :sswitch_8
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startNumberLeadingZero()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 843
    :sswitch_9
    invoke-direct {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startSlashComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 841
    :sswitch_a
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startNegativeNumber()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 839
    :sswitch_b
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startPositiveNumber()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 837
    :sswitch_c
    invoke-direct {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishHashComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 884
    :cond_2
    :goto_0
    const/4 v0, 0x1

    invoke-virtual {p0, v0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startUnexpectedValue(ZI)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    :sswitch_data_0
    .sparse-switch
        0x23 -> :sswitch_c
        0x2b -> :sswitch_b
        0x2d -> :sswitch_a
        0x2f -> :sswitch_9
        0x30 -> :sswitch_8
        0x31 -> :sswitch_7
        0x32 -> :sswitch_7
        0x33 -> :sswitch_7
        0x34 -> :sswitch_7
        0x35 -> :sswitch_7
        0x36 -> :sswitch_7
        0x37 -> :sswitch_7
        0x38 -> :sswitch_7
        0x39 -> :sswitch_7
        0x5b -> :sswitch_6
        0x5d -> :sswitch_5
        0x66 -> :sswitch_4
        0x6e -> :sswitch_3
        0x74 -> :sswitch_2
        0x7b -> :sswitch_1
        0x7d -> :sswitch_0
    .end sparse-switch
.end method

.method private final _startValueExpectColon(I)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 4
    .param p1, "ch"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 748
    const/16 v0, 0xe

    const/16 v1, 0x20

    if-gt p1, v1, :cond_0

    .line 749
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_skipWS(I)I

    move-result p1

    .line 750
    if-gtz p1, :cond_0

    .line 751
    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 752
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 755
    :cond_0
    const/16 v2, 0x3a

    if-eq p1, v2, :cond_3

    .line 756
    const/16 v2, 0x2f

    if-ne p1, v2, :cond_1

    .line 757
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startSlashComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 759
    :cond_1
    const/16 v2, 0x23

    if-ne p1, v2, :cond_2

    .line 760
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishHashComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 763
    :cond_2
    const-string v0, "was expecting a colon to separate field name and value"

    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedChar(ILjava/lang/String;)V

    .line 765
    :cond_3
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 766
    .local v0, "ptr":I
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    const/16 v3, 0xc

    if-lt v0, v2, :cond_4

    .line 767
    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 768
    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v1

    .line 770
    :cond_4
    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result p1

    .line 771
    add-int/lit8 v2, v0, 0x1

    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 772
    if-gt p1, v1, :cond_5

    .line 773
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_skipWS(I)I

    move-result p1

    .line 774
    if-gtz p1, :cond_5

    .line 775
    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 776
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v1

    .line 779
    :cond_5
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_updateTokenLocation()V

    .line 780
    const/16 v1, 0x22

    if-ne p1, v1, :cond_6

    .line 781
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startString()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 783
    :cond_6
    sparse-switch p1, :sswitch_data_0

    .line 817
    const/4 v1, 0x0

    invoke-virtual {p0, v1, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startUnexpectedValue(ZI)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 814
    :sswitch_0
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startObjectScope()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 810
    :sswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startTrueToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 808
    :sswitch_2
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startNullToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 806
    :sswitch_3
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFalseToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 812
    :sswitch_4
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startArrayScope()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 804
    :sswitch_5
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startPositiveNumber(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 797
    :sswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startNumberLeadingZero()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 791
    :sswitch_7
    invoke-direct {p0, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startSlashComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 789
    :sswitch_8
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startNegativeNumber()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 787
    :sswitch_9
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startPositiveNumber()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 785
    :sswitch_a
    invoke-direct {p0, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishHashComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    :sswitch_data_0
    .sparse-switch
        0x23 -> :sswitch_a
        0x2b -> :sswitch_9
        0x2d -> :sswitch_8
        0x2f -> :sswitch_7
        0x30 -> :sswitch_6
        0x31 -> :sswitch_5
        0x32 -> :sswitch_5
        0x33 -> :sswitch_5
        0x34 -> :sswitch_5
        0x35 -> :sswitch_5
        0x36 -> :sswitch_5
        0x37 -> :sswitch_5
        0x38 -> :sswitch_5
        0x39 -> :sswitch_5
        0x5b -> :sswitch_4
        0x66 -> :sswitch_3
        0x6e -> :sswitch_2
        0x74 -> :sswitch_1
        0x7b -> :sswitch_0
    .end sparse-switch
.end method

.method private final _startValueExpectComma(I)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 4
    .param p1, "ch"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 649
    const/16 v0, 0xd

    const/16 v1, 0x20

    if-gt p1, v1, :cond_0

    .line 650
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_skipWS(I)I

    move-result p1

    .line 651
    if-gtz p1, :cond_0

    .line 652
    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 653
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 656
    :cond_0
    const/16 v2, 0x2c

    if-eq p1, v2, :cond_5

    .line 657
    const/16 v2, 0x5d

    if-ne p1, v2, :cond_1

    .line 658
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_closeArrayScope()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 660
    :cond_1
    const/16 v2, 0x7d

    if-ne p1, v2, :cond_2

    .line 661
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_closeObjectScope()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 663
    :cond_2
    const/16 v2, 0x2f

    if-ne p1, v2, :cond_3

    .line 664
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startSlashComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 666
    :cond_3
    const/16 v2, 0x23

    if-ne p1, v2, :cond_4

    .line 667
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishHashComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 669
    :cond_4
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "was expecting comma to separate "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_parsingContext:Lcom/fasterxml/jackson/core/json/JsonReadContext;

    invoke-virtual {v2}, Lcom/fasterxml/jackson/core/json/JsonReadContext;->typeDesc()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " entries"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedChar(ILjava/lang/String;)V

    .line 673
    :cond_5
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_parsingContext:Lcom/fasterxml/jackson/core/json/JsonReadContext;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/json/JsonReadContext;->expectComma()Z

    .line 675
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 676
    .local v0, "ptr":I
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    const/16 v3, 0xf

    if-lt v0, v2, :cond_6

    .line 677
    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 678
    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v1

    .line 680
    :cond_6
    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result p1

    .line 681
    add-int/lit8 v2, v0, 0x1

    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 682
    if-gt p1, v1, :cond_7

    .line 683
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_skipWS(I)I

    move-result p1

    .line 684
    if-gtz p1, :cond_7

    .line 685
    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 686
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v1

    .line 689
    :cond_7
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_updateTokenLocation()V

    .line 690
    const/16 v1, 0x22

    if-ne p1, v1, :cond_8

    .line 691
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startString()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 693
    :cond_8
    sparse-switch p1, :sswitch_data_0

    goto :goto_0

    .line 733
    :sswitch_0
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_features:I

    sget v2, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->FEAT_MASK_TRAILING_COMMA:I

    and-int/2addr v1, v2

    if-eqz v1, :cond_9

    .line 734
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_closeObjectScope()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 730
    :sswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startObjectScope()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 720
    :sswitch_2
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startTrueToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 718
    :sswitch_3
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startNullToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 716
    :sswitch_4
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFalseToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 725
    :sswitch_5
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_features:I

    sget v2, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->FEAT_MASK_TRAILING_COMMA:I

    and-int/2addr v1, v2

    if-eqz v1, :cond_9

    .line 726
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_closeArrayScope()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 722
    :sswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startArrayScope()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 714
    :sswitch_7
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startPositiveNumber(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 707
    :sswitch_8
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startNumberLeadingZero()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 701
    :sswitch_9
    invoke-direct {p0, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startSlashComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 699
    :sswitch_a
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startNegativeNumber()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 697
    :sswitch_b
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startPositiveNumber()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 695
    :sswitch_c
    invoke-direct {p0, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishHashComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 739
    :cond_9
    :goto_0
    const/4 v1, 0x1

    invoke-virtual {p0, v1, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startUnexpectedValue(ZI)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    nop

    :sswitch_data_0
    .sparse-switch
        0x23 -> :sswitch_c
        0x2b -> :sswitch_b
        0x2d -> :sswitch_a
        0x2f -> :sswitch_9
        0x30 -> :sswitch_8
        0x31 -> :sswitch_7
        0x32 -> :sswitch_7
        0x33 -> :sswitch_7
        0x34 -> :sswitch_7
        0x35 -> :sswitch_7
        0x36 -> :sswitch_7
        0x37 -> :sswitch_7
        0x38 -> :sswitch_7
        0x39 -> :sswitch_7
        0x5b -> :sswitch_6
        0x5d -> :sswitch_5
        0x66 -> :sswitch_4
        0x6e -> :sswitch_3
        0x74 -> :sswitch_2
        0x7b -> :sswitch_1
        0x7d -> :sswitch_0
    .end sparse-switch
.end method


# virtual methods
.method protected _decodeEscaped()C
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 103
    invoke-static {}, Lcom/fasterxml/jackson/core/util/VersionUtil;->throwInternal()V

    .line 104
    const/16 v0, 0x20

    return v0
.end method

.method protected _finishErrorToken()Lcom/fasterxml/jackson/core/JsonToken;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1236
    nop

    :goto_0
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-ge v0, v1, :cond_1

    .line 1237
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result v0

    .line 1242
    .local v0, "i":I
    int-to-char v1, v0

    .line 1243
    .local v1, "ch":C
    invoke-static {v1}, Ljava/lang/Character;->isJavaIdentifierPart(C)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 1246
    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v2, v1}, Lcom/fasterxml/jackson/core/util/TextBuffer;->append(C)V

    .line 1247
    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->size()I

    move-result v2

    const/16 v3, 0x100

    if-ge v2, v3, :cond_0

    .line 1248
    goto :goto_0

    .line 1251
    :cond_0
    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->contentsAsString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportErrorToken(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v2

    return-object v2

    .line 1253
    .end local v0    # "i":I
    .end local v1    # "ch":C
    :cond_1
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0
.end method

.method protected _finishErrorTokenWithEOF()Lcom/fasterxml/jackson/core/JsonToken;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1258
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/util/TextBuffer;->contentsAsString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportErrorToken(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0
.end method

.method protected final _finishFieldWithEscape()Lcom/fasterxml/jackson/core/JsonToken;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2383
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quoted32:I

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quotedDigits:I

    invoke-direct {p0, v0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeSplitEscaped(II)I

    move-result v0

    .line 2384
    .local v0, "ch":I
    if-gez v0, :cond_0

    .line 2385
    const/16 v1, 0x8

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 2386
    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v1

    .line 2388
    :cond_0
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadLength:I

    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadBuffer:[I

    array-length v2, v2

    if-lt v1, v2, :cond_1

    .line 2389
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadBuffer:[I

    const/16 v2, 0x20

    invoke-static {v1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->growArrayBy([II)[I

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadBuffer:[I

    .line 2391
    :cond_1
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    .line 2392
    .local v1, "currQuad":I
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pendingBytes:I

    .line 2393
    .local v2, "currQuadBytes":I
    const/16 v3, 0x7f

    const/4 v4, 0x4

    if-le v0, v3, :cond_5

    .line 2395
    if-lt v2, v4, :cond_2

    .line 2396
    iget-object v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadBuffer:[I

    iget v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadLength:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadLength:I

    aput v1, v3, v5

    .line 2397
    const/4 v1, 0x0

    .line 2398
    const/4 v2, 0x0

    .line 2400
    :cond_2
    const/16 v3, 0x800

    if-ge v0, v3, :cond_3

    .line 2401
    shl-int/lit8 v3, v1, 0x8

    shr-int/lit8 v5, v0, 0x6

    or-int/lit16 v5, v5, 0xc0

    or-int v1, v3, v5

    .line 2402
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 2405
    :cond_3
    shl-int/lit8 v3, v1, 0x8

    shr-int/lit8 v5, v0, 0xc

    or-int/lit16 v5, v5, 0xe0

    or-int v1, v3, v5

    .line 2407
    add-int/lit8 v2, v2, 0x1

    if-lt v2, v4, :cond_4

    .line 2408
    iget-object v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadBuffer:[I

    iget v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadLength:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadLength:I

    aput v1, v3, v5

    .line 2409
    const/4 v1, 0x0

    .line 2410
    const/4 v2, 0x0

    .line 2412
    :cond_4
    shl-int/lit8 v3, v1, 0x8

    shr-int/lit8 v5, v0, 0x6

    and-int/lit8 v5, v5, 0x3f

    or-int/lit16 v5, v5, 0x80

    or-int v1, v3, v5

    .line 2413
    add-int/lit8 v2, v2, 0x1

    .line 2416
    :goto_0
    and-int/lit8 v3, v0, 0x3f

    or-int/lit16 v0, v3, 0x80

    .line 2418
    :cond_5
    if-ge v2, v4, :cond_6

    .line 2419
    add-int/lit8 v2, v2, 0x1

    .line 2420
    shl-int/lit8 v3, v1, 0x8

    or-int v1, v3, v0

    goto :goto_1

    .line 2422
    :cond_6
    iget-object v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadBuffer:[I

    iget v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadLength:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadLength:I

    aput v1, v3, v4

    .line 2423
    move v1, v0

    .line 2424
    const/4 v2, 0x1

    .line 2426
    :goto_1
    iget v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorStateAfterSplit:I

    const/16 v4, 0x9

    if-ne v3, v4, :cond_7

    .line 2427
    iget v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadLength:I

    invoke-direct {p0, v3, v1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishAposName(III)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v3

    return-object v3

    .line 2429
    :cond_7
    iget v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadLength:I

    invoke-direct {p0, v3, v1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_parseEscapedName(III)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v3

    return-object v3
.end method

.method protected _finishFloatExponent(ZI)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 5
    .param p1, "checkSign"    # Z
    .param p2, "ch"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1877
    if-eqz p1, :cond_2

    .line 1878
    const/16 v0, 0x20

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1879
    const/16 v1, 0x2d

    if-eq p2, v1, :cond_0

    const/16 v1, 0x2b

    if-ne p2, v1, :cond_2

    .line 1880
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    int-to-char v2, p2

    invoke-virtual {v1, v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->append(C)V

    .line 1881
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v1, v2, :cond_1

    .line 1882
    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1883
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_expLength:I

    .line 1884
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 1886
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result p2

    .line 1890
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/util/TextBuffer;->getBufferWithoutReset()[C

    move-result-object v0

    .line 1891
    .local v0, "outBuf":[C
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v1}, Lcom/fasterxml/jackson/core/util/TextBuffer;->getCurrentSegmentSize()I

    move-result v1

    .line 1892
    .local v1, "outPtr":I
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_expLength:I

    .line 1894
    .local v2, "expLen":I
    :goto_0
    const/16 v3, 0x30

    if-lt p2, v3, :cond_5

    const/16 v3, 0x39

    if-gt p2, v3, :cond_5

    .line 1895
    add-int/lit8 v2, v2, 0x1

    .line 1896
    array-length v3, v0

    if-lt v1, v3, :cond_3

    .line 1897
    iget-object v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v3}, Lcom/fasterxml/jackson/core/util/TextBuffer;->expandCurrentSegment()[C

    move-result-object v0

    .line 1899
    :cond_3
    add-int/lit8 v3, v1, 0x1

    .end local v1    # "outPtr":I
    .local v3, "outPtr":I
    int-to-char v4, p2

    aput-char v4, v0, v1

    .line 1900
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v1, v4, :cond_4

    .line 1901
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v1, v3}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 1902
    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_expLength:I

    .line 1903
    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v1

    .line 1905
    :cond_4
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result p2

    move v1, v3

    goto :goto_0

    .line 1908
    .end local v3    # "outPtr":I
    .restart local v1    # "outPtr":I
    :cond_5
    and-int/lit16 p2, p2, 0xff

    .line 1909
    if-nez v2, :cond_6

    .line 1910
    const-string v3, "Exponent indicator not followed by a digit"

    invoke-virtual {p0, p2, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedNumberChar(ILjava/lang/String;)Ljava/lang/Object;

    .line 1913
    :cond_6
    iget v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    add-int/lit8 v3, v3, -0x1

    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1914
    iget-object v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v3, v1}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 1916
    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_expLength:I

    .line 1917
    sget-object v3, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_NUMBER_FLOAT:Lcom/fasterxml/jackson/core/JsonToken;

    invoke-virtual {p0, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueComplete(Lcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v3

    return-object v3
.end method

.method protected _finishFloatFraction()Lcom/fasterxml/jackson/core/JsonToken;
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1816
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_fractLength:I

    .line 1817
    .local v0, "fractLen":I
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v1}, Lcom/fasterxml/jackson/core/util/TextBuffer;->getBufferWithoutReset()[C

    move-result-object v1

    .line 1818
    .local v1, "outBuf":[C
    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->getCurrentSegmentSize()I

    move-result v2

    .line 1821
    .local v2, "outPtr":I
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result v3

    .line 1822
    .local v3, "ch":I
    const/4 v4, 0x1

    .line 1823
    .local v4, "loop":Z
    :goto_0
    if-eqz v4, :cond_6

    .line 1824
    const/16 v5, 0x30

    if-lt v3, v5, :cond_2

    const/16 v5, 0x39

    if-gt v3, v5, :cond_2

    .line 1825
    add-int/lit8 v0, v0, 0x1

    .line 1826
    array-length v5, v1

    if-lt v2, v5, :cond_0

    .line 1827
    iget-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v5}, Lcom/fasterxml/jackson/core/util/TextBuffer;->expandCurrentSegment()[C

    move-result-object v1

    .line 1829
    :cond_0
    add-int/lit8 v5, v2, 0x1

    .end local v2    # "outPtr":I
    .local v5, "outPtr":I
    int-to-char v6, v3

    aput-char v6, v1, v2

    .line 1830
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v2, v6, :cond_1

    .line 1831
    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v2, v5}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 1832
    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_fractLength:I

    .line 1833
    sget-object v2, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v2

    .line 1835
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result v3

    move v2, v5

    goto :goto_0

    .line 1836
    .end local v5    # "outPtr":I
    .restart local v2    # "outPtr":I
    :cond_2
    const/16 v5, 0x66

    if-eq v3, v5, :cond_5

    const/16 v5, 0x64

    if-eq v3, v5, :cond_5

    const/16 v5, 0x46

    if-eq v3, v5, :cond_5

    const/16 v5, 0x44

    if-ne v3, v5, :cond_3

    goto :goto_1

    .line 1838
    :cond_3
    const/16 v5, 0x2e

    if-ne v3, v5, :cond_4

    .line 1839
    const-string v5, "Cannot parse number with more than one decimal point"

    invoke-virtual {p0, v3, v5}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedNumberChar(ILjava/lang/String;)Ljava/lang/Object;

    goto :goto_0

    .line 1841
    :cond_4
    const/4 v4, 0x0

    goto :goto_0

    .line 1837
    :cond_5
    :goto_1
    const-string v5, "JSON does not support parsing numbers that have \'f\' or \'d\' suffixes"

    invoke-virtual {p0, v3, v5}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedNumberChar(ILjava/lang/String;)Ljava/lang/Object;

    goto :goto_0

    .line 1847
    :cond_6
    if-nez v0, :cond_7

    .line 1848
    sget-object v5, Lcom/fasterxml/jackson/core/json/JsonReadFeature;->ALLOW_TRAILING_DECIMAL_POINT_FOR_NUMBERS:Lcom/fasterxml/jackson/core/json/JsonReadFeature;

    invoke-virtual {v5}, Lcom/fasterxml/jackson/core/json/JsonReadFeature;->mappedFeature()Lcom/fasterxml/jackson/core/JsonParser$Feature;

    move-result-object v5

    invoke-virtual {p0, v5}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->isEnabled(Lcom/fasterxml/jackson/core/JsonParser$Feature;)Z

    move-result v5

    if-nez v5, :cond_7

    .line 1849
    const-string v5, "Decimal point not followed by a digit"

    invoke-virtual {p0, v3, v5}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedNumberChar(ILjava/lang/String;)Ljava/lang/Object;

    .line 1852
    :cond_7
    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_fractLength:I

    .line 1853
    iget-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v5, v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 1856
    const/16 v5, 0x65

    const/4 v6, 0x0

    const/4 v7, 0x1

    if-eq v3, v5, :cond_9

    const/16 v5, 0x45

    if-ne v3, v5, :cond_8

    goto :goto_2

    .line 1868
    :cond_8
    iget v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    sub-int/2addr v5, v7

    iput v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1869
    iget-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v5, v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 1871
    iput v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_expLength:I

    .line 1872
    sget-object v5, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_NUMBER_FLOAT:Lcom/fasterxml/jackson/core/JsonToken;

    invoke-virtual {p0, v5}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueComplete(Lcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v5

    return-object v5

    .line 1857
    :cond_9
    :goto_2
    iget-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    int-to-char v8, v3

    invoke-virtual {v5, v8}, Lcom/fasterxml/jackson/core/util/TextBuffer;->append(C)V

    .line 1858
    iput v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_expLength:I

    .line 1859
    iget v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v5, v6, :cond_a

    .line 1860
    const/16 v5, 0x1f

    iput v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1861
    sget-object v5, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v5

    .line 1863
    :cond_a
    const/16 v5, 0x20

    iput v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1864
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v5

    invoke-virtual {p0, v7, v5}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishFloatExponent(ZI)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v5

    return-object v5
.end method

.method protected _finishKeywordToken(Ljava/lang/String;ILcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 3
    .param p1, "expToken"    # Ljava/lang/String;
    .param p2, "matched"    # I
    .param p3, "result"    # Lcom/fasterxml/jackson/core/JsonToken;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1159
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 1162
    .local v0, "end":I
    :goto_0
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v1, v2, :cond_0

    .line 1163
    iput p2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    .line 1164
    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v1

    .line 1166
    :cond_0
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    invoke-virtual {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v1

    .line 1167
    .local v1, "ch":I
    if-ne p2, v0, :cond_2

    .line 1168
    const/16 v2, 0x30

    if-lt v1, v2, :cond_1

    const/16 v2, 0x5d

    if-eq v1, v2, :cond_1

    const/16 v2, 0x7d

    if-ne v1, v2, :cond_3

    .line 1169
    :cond_1
    invoke-virtual {p0, p3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueComplete(Lcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v2

    return-object v2

    .line 1173
    :cond_2
    invoke-virtual {p1, p2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    if-eq v1, v2, :cond_4

    .line 1174
    nop

    .line 1179
    .end local v1    # "ch":I
    :cond_3
    const/16 v1, 0x32

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1180
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    const/4 v2, 0x0

    invoke-virtual {v1, p1, v2, p2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->resetWithCopy(Ljava/lang/String;II)V

    .line 1181
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishErrorToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 1176
    .restart local v1    # "ch":I
    :cond_4
    add-int/lit8 p2, p2, 0x1

    .line 1177
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1178
    .end local v1    # "ch":I
    goto :goto_0
.end method

.method protected _finishKeywordTokenWithEOF(Ljava/lang/String;ILcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 2
    .param p1, "expToken"    # Ljava/lang/String;
    .param p2, "matched"    # I
    .param p3, "result"    # Lcom/fasterxml/jackson/core/JsonToken;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1187
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-ne p2, v0, :cond_0

    .line 1188
    iput-object p3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object p3

    .line 1190
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1, p2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->resetWithCopy(Ljava/lang/String;II)V

    .line 1191
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishErrorTokenWithEOF()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0
.end method

.method protected _finishNonStdToken(II)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 4
    .param p1, "type"    # I
    .param p2, "matched"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1196
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_nonStdToken(I)Ljava/lang/String;

    move-result-object v0

    .line 1197
    .local v0, "expToken":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    .line 1200
    .local v1, "end":I
    :goto_0
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v2, v3, :cond_0

    .line 1201
    iput p1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_nonStdTokenType:I

    .line 1202
    iput p2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    .line 1203
    const/16 v2, 0x13

    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1204
    sget-object v2, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v2

    .line 1206
    :cond_0
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    invoke-virtual {p0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v2

    .line 1207
    .local v2, "ch":I
    if-ne p2, v1, :cond_2

    .line 1208
    const/16 v3, 0x30

    if-lt v2, v3, :cond_1

    const/16 v3, 0x5d

    if-eq v2, v3, :cond_1

    const/16 v3, 0x7d

    if-ne v2, v3, :cond_3

    .line 1209
    :cond_1
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueNonStdNumberComplete(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v3

    return-object v3

    .line 1213
    :cond_2
    invoke-virtual {v0, p2}, Ljava/lang/String;->charAt(I)C

    move-result v3

    if-eq v2, v3, :cond_4

    .line 1214
    nop

    .line 1219
    .end local v2    # "ch":I
    :cond_3
    const/16 v2, 0x32

    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1220
    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    const/4 v3, 0x0

    invoke-virtual {v2, v0, v3, p2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->resetWithCopy(Ljava/lang/String;II)V

    .line 1221
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishErrorToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v2

    return-object v2

    .line 1216
    .restart local v2    # "ch":I
    :cond_4
    add-int/lit8 p2, p2, 0x1

    .line 1217
    iget v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1218
    .end local v2    # "ch":I
    goto :goto_0
.end method

.method protected _finishNonStdTokenWithEOF(II)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 3
    .param p1, "type"    # I
    .param p2, "matched"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1226
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_nonStdToken(I)Ljava/lang/String;

    move-result-object v0

    .line 1227
    .local v0, "expToken":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-ne p2, v1, :cond_0

    .line 1228
    invoke-virtual {p0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueNonStdNumberComplete(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 1230
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2, p2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->resetWithCopy(Ljava/lang/String;II)V

    .line 1231
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishErrorTokenWithEOF()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1
.end method

.method protected _finishNumberIntegralPart([CI)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 4
    .param p1, "outBuf"    # [C
    .param p2, "outPtr"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1688
    iget-boolean v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_numberNegative:Z

    if-eqz v0, :cond_0

    const/4 v0, -0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 1691
    .local v0, "negMod":I
    :goto_0
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v1, v2, :cond_1

    .line 1692
    const/16 v1, 0x1a

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1693
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v1, p2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 1694
    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v1

    .line 1696
    :cond_1
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    invoke-virtual {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 1697
    .local v1, "ch":I
    const/16 v2, 0x30

    if-ge v1, v2, :cond_2

    .line 1698
    const/16 v2, 0x2e

    if-ne v1, v2, :cond_3

    .line 1699
    add-int v2, p2, v0

    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1700
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1701
    invoke-virtual {p0, p1, p2, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFloat([CII)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v2

    return-object v2

    .line 1705
    :cond_2
    const/16 v2, 0x39

    if-le v1, v2, :cond_5

    .line 1706
    const/16 v2, 0x65

    if-eq v1, v2, :cond_4

    const/16 v2, 0x45

    if-ne v1, v2, :cond_3

    goto :goto_1

    .line 1721
    .end local v1    # "ch":I
    :cond_3
    add-int v1, p2, v0

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1722
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v1, p2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 1723
    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_NUMBER_INT:Lcom/fasterxml/jackson/core/JsonToken;

    invoke-virtual {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueComplete(Lcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 1707
    .restart local v1    # "ch":I
    :cond_4
    :goto_1
    add-int v2, p2, v0

    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1708
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1709
    invoke-virtual {p0, p1, p2, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFloat([CII)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v2

    return-object v2

    .line 1713
    :cond_5
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1714
    array-length v2, p1

    if-lt p2, v2, :cond_6

    .line 1717
    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->expandCurrentSegment()[C

    move-result-object p1

    .line 1719
    :cond_6
    add-int/lit8 v2, p2, 0x1

    .end local p2    # "outPtr":I
    .local v2, "outPtr":I
    int-to-char v3, v1

    aput-char v3, p1, p2

    .line 1720
    .end local v1    # "ch":I
    move p2, v2

    goto :goto_0
.end method

.method protected _finishNumberLeadingNegZeroes()Lcom/fasterxml/jackson/core/JsonToken;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1627
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNumberLeadingPosNegZeroes(Z)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0
.end method

.method protected _finishNumberLeadingPosNegZeroes(Z)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 9
    .param p1, "negative"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1638
    nop

    :goto_0
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v0, v1, :cond_1

    .line 1639
    if-eqz p1, :cond_0

    const/16 v0, 0x19

    goto :goto_1

    :cond_0
    const/16 v0, 0x18

    :goto_1
    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1640
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 1642
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v0

    .line 1643
    .local v0, "ch":I
    const/4 v1, 0x2

    const/16 v2, 0x2d

    const/16 v3, 0x2b

    const/4 v4, 0x0

    const/16 v5, 0x30

    const/4 v6, 0x1

    if-ge v0, v5, :cond_3

    .line 1644
    const/16 v7, 0x2e

    if-ne v0, v7, :cond_5

    .line 1645
    iget-object v7, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v7}, Lcom/fasterxml/jackson/core/util/TextBuffer;->emptyAndGetCurrentSegment()[C

    move-result-object v7

    .line 1646
    .local v7, "outBuf":[C
    if-eqz p1, :cond_2

    goto :goto_2

    :cond_2
    move v2, v3

    :goto_2
    aput-char v2, v7, v4

    .line 1647
    aput-char v5, v7, v6

    .line 1648
    iput v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1649
    invoke-virtual {p0, v7, v1, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFloat([CII)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 1651
    .end local v7    # "outBuf":[C
    :cond_3
    const/16 v7, 0x39

    if-le v0, v7, :cond_8

    .line 1652
    const/16 v7, 0x65

    if-eq v0, v7, :cond_6

    const/16 v7, 0x45

    if-ne v0, v7, :cond_4

    goto :goto_3

    .line 1662
    :cond_4
    const/16 v1, 0x5d

    if-eq v0, v1, :cond_5

    const/16 v1, 0x7d

    if-eq v0, v1, :cond_5

    .line 1663
    const-string v1, "expected digit (0-9), decimal point (.) or exponent indicator (e/E) to follow \'0\'"

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedNumberChar(ILjava/lang/String;)Ljava/lang/Object;

    .line 1682
    :cond_5
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    sub-int/2addr v1, v6

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1683
    const-string v1, "0"

    invoke-virtual {p0, v4, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueCompleteInt(ILjava/lang/String;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 1653
    :cond_6
    :goto_3
    iget-object v7, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v7}, Lcom/fasterxml/jackson/core/util/TextBuffer;->emptyAndGetCurrentSegment()[C

    move-result-object v7

    .line 1654
    .restart local v7    # "outBuf":[C
    if-eqz p1, :cond_7

    goto :goto_4

    :cond_7
    move v2, v3

    :goto_4
    aput-char v2, v7, v4

    .line 1655
    aput-char v5, v7, v6

    .line 1656
    iput v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1657
    invoke-virtual {p0, v7, v1, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFloat([CII)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 1669
    .end local v7    # "outBuf":[C
    :cond_8
    iget v7, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_features:I

    sget v8, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->FEAT_MASK_LEADING_ZEROS:I

    and-int/2addr v7, v8

    if-nez v7, :cond_9

    .line 1670
    const-string v7, "Leading zeroes not allowed"

    invoke-virtual {p0, v7}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->reportInvalidNumber(Ljava/lang/String;)V

    .line 1672
    :cond_9
    if-ne v0, v5, :cond_a

    .line 1673
    goto/16 :goto_0

    .line 1675
    :cond_a
    iget-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v5}, Lcom/fasterxml/jackson/core/util/TextBuffer;->emptyAndGetCurrentSegment()[C

    move-result-object v5

    .line 1677
    .local v5, "outBuf":[C
    if-eqz p1, :cond_b

    goto :goto_5

    :cond_b
    move v2, v3

    :goto_5
    aput-char v2, v5, v4

    .line 1678
    int-to-char v2, v0

    aput-char v2, v5, v6

    .line 1679
    iput v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1680
    invoke-virtual {p0, v5, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNumberIntegralPart([CI)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1
.end method

.method protected _finishNumberLeadingPosZeroes()Lcom/fasterxml/jackson/core/JsonToken;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1631
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNumberLeadingPosNegZeroes(Z)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0
.end method

.method protected _finishNumberLeadingZeroes()Lcom/fasterxml/jackson/core/JsonToken;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1580
    nop

    :goto_0
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 1581
    const/16 v0, 0x18

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1582
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 1584
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v0

    .line 1585
    .local v0, "ch":I
    const/4 v1, 0x0

    const/16 v2, 0x30

    const/4 v3, 0x1

    if-ge v0, v2, :cond_1

    .line 1586
    const/16 v4, 0x2e

    if-ne v0, v4, :cond_3

    .line 1587
    iget-object v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v4}, Lcom/fasterxml/jackson/core/util/TextBuffer;->emptyAndGetCurrentSegment()[C

    move-result-object v4

    .line 1588
    .local v4, "outBuf":[C
    aput-char v2, v4, v1

    .line 1589
    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1590
    invoke-virtual {p0, v4, v3, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFloat([CII)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 1592
    .end local v4    # "outBuf":[C
    :cond_1
    const/16 v4, 0x39

    if-le v0, v4, :cond_5

    .line 1593
    const/16 v4, 0x65

    if-eq v0, v4, :cond_4

    const/16 v4, 0x45

    if-ne v0, v4, :cond_2

    goto :goto_1

    .line 1602
    :cond_2
    const/16 v2, 0x5d

    if-eq v0, v2, :cond_3

    const/16 v2, 0x7d

    if-eq v0, v2, :cond_3

    .line 1603
    const-string v2, "expected digit (0-9), decimal point (.) or exponent indicator (e/E) to follow \'0\'"

    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedNumberChar(ILjava/lang/String;)Ljava/lang/Object;

    .line 1621
    :cond_3
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    sub-int/2addr v2, v3

    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1622
    const-string v2, "0"

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueCompleteInt(ILjava/lang/String;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 1594
    :cond_4
    :goto_1
    iget-object v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v4}, Lcom/fasterxml/jackson/core/util/TextBuffer;->emptyAndGetCurrentSegment()[C

    move-result-object v4

    .line 1595
    .restart local v4    # "outBuf":[C
    aput-char v2, v4, v1

    .line 1596
    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1597
    invoke-virtual {p0, v4, v3, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFloat([CII)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 1609
    .end local v4    # "outBuf":[C
    :cond_5
    iget v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_features:I

    sget v5, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->FEAT_MASK_LEADING_ZEROS:I

    and-int/2addr v4, v5

    if-nez v4, :cond_6

    .line 1610
    const-string v4, "Leading zeroes not allowed"

    invoke-virtual {p0, v4}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->reportInvalidNumber(Ljava/lang/String;)V

    .line 1612
    :cond_6
    if-ne v0, v2, :cond_7

    .line 1613
    goto :goto_0

    .line 1615
    :cond_7
    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->emptyAndGetCurrentSegment()[C

    move-result-object v2

    .line 1617
    .local v2, "outBuf":[C
    int-to-char v4, v0

    aput-char v4, v2, v1

    .line 1618
    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1619
    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNumberIntegralPart([CI)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1
.end method

.method protected _finishNumberMinus(I)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 1
    .param p1, "ch"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1519
    const/4 v0, 0x1

    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNumberPlusMinus(IZ)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0
.end method

.method protected _finishNumberPlus(I)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 1
    .param p1, "ch"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1524
    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNumberPlusMinus(IZ)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0
.end method

.method protected _finishNumberPlusMinus(IZ)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 7
    .param p1, "ch"    # I
    .param p2, "negative"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1529
    const-string v0, "expected digit (0-9) to follow minus sign, for valid numeric value"

    const-string v1, "expected digit (0-9) for valid numeric value"

    const/4 v2, 0x2

    const-string v3, "JSON spec does not allow numbers to have plus signs: enable `JsonReadFeature.ALLOW_LEADING_PLUS_SIGN_FOR_NUMBERS` to allow"

    const/4 v4, 0x1

    const/16 v5, 0x2b

    const/16 v6, 0x30

    if-gt p1, v6, :cond_7

    .line 1530
    if-ne p1, v6, :cond_2

    .line 1531
    if-eqz p2, :cond_0

    .line 1532
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNumberLeadingNegZeroes()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 1534
    :cond_0
    sget-object v0, Lcom/fasterxml/jackson/core/json/JsonReadFeature;->ALLOW_LEADING_PLUS_SIGN_FOR_NUMBERS:Lcom/fasterxml/jackson/core/json/JsonReadFeature;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/json/JsonReadFeature;->mappedFeature()Lcom/fasterxml/jackson/core/JsonParser$Feature;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->isEnabled(Lcom/fasterxml/jackson/core/JsonParser$Feature;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 1535
    invoke-virtual {p0, v5, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedNumberChar(ILjava/lang/String;)Ljava/lang/Object;

    .line 1537
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNumberLeadingPosZeroes()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 1539
    :cond_2
    const/16 v6, 0x2e

    if-ne p1, v6, :cond_5

    sget-object v6, Lcom/fasterxml/jackson/core/json/JsonReadFeature;->ALLOW_LEADING_DECIMAL_POINT_FOR_NUMBERS:Lcom/fasterxml/jackson/core/json/JsonReadFeature;

    invoke-virtual {v6}, Lcom/fasterxml/jackson/core/json/JsonReadFeature;->mappedFeature()Lcom/fasterxml/jackson/core/JsonParser$Feature;

    move-result-object v6

    invoke-virtual {p0, v6}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->isEnabled(Lcom/fasterxml/jackson/core/JsonParser$Feature;)Z

    move-result v6

    if-eqz v6, :cond_5

    .line 1540
    if-eqz p2, :cond_3

    .line 1541
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    sub-int/2addr v0, v4

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1542
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNumberLeadingNegZeroes()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 1544
    :cond_3
    sget-object v0, Lcom/fasterxml/jackson/core/json/JsonReadFeature;->ALLOW_LEADING_PLUS_SIGN_FOR_NUMBERS:Lcom/fasterxml/jackson/core/json/JsonReadFeature;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/json/JsonReadFeature;->mappedFeature()Lcom/fasterxml/jackson/core/JsonParser$Feature;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->isEnabled(Lcom/fasterxml/jackson/core/JsonParser$Feature;)Z

    move-result v0

    if-nez v0, :cond_4

    .line 1545
    invoke-virtual {p0, v5, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedNumberChar(ILjava/lang/String;)Ljava/lang/Object;

    .line 1547
    :cond_4
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    sub-int/2addr v0, v4

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1548
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNumberLeadingPosZeroes()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 1551
    :cond_5
    if-eqz p2, :cond_6

    goto :goto_0

    :cond_6
    move-object v0, v1

    .line 1554
    .local v0, "message":Ljava/lang/String;
    :goto_0
    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedNumberChar(ILjava/lang/String;)Ljava/lang/Object;

    .end local v0    # "message":Ljava/lang/String;
    goto :goto_3

    .line 1555
    :cond_7
    const/16 v6, 0x39

    if-le p1, v6, :cond_b

    .line 1556
    const/16 v6, 0x49

    if-ne p1, v6, :cond_9

    .line 1557
    if-eqz p2, :cond_8

    const/4 v0, 0x3

    goto :goto_1

    :cond_8
    move v0, v2

    .line 1558
    .local v0, "token":I
    :goto_1
    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNonStdToken(II)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 1560
    .end local v0    # "token":I
    :cond_9
    if-eqz p2, :cond_a

    goto :goto_2

    :cond_a
    move-object v0, v1

    .line 1563
    .local v0, "message":Ljava/lang/String;
    :goto_2
    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedNumberChar(ILjava/lang/String;)Ljava/lang/Object;

    goto :goto_4

    .line 1555
    .end local v0    # "message":Ljava/lang/String;
    :cond_b
    :goto_3
    nop

    .line 1565
    :goto_4
    if-nez p2, :cond_c

    sget-object v0, Lcom/fasterxml/jackson/core/json/JsonReadFeature;->ALLOW_LEADING_PLUS_SIGN_FOR_NUMBERS:Lcom/fasterxml/jackson/core/json/JsonReadFeature;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/json/JsonReadFeature;->mappedFeature()Lcom/fasterxml/jackson/core/JsonParser$Feature;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->isEnabled(Lcom/fasterxml/jackson/core/JsonParser$Feature;)Z

    move-result v0

    if-nez v0, :cond_c

    .line 1566
    invoke-virtual {p0, v5, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedNumberChar(ILjava/lang/String;)Ljava/lang/Object;

    .line 1568
    :cond_c
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/util/TextBuffer;->emptyAndGetCurrentSegment()[C

    move-result-object v0

    .line 1569
    .local v0, "outBuf":[C
    if-eqz p2, :cond_d

    const/16 v5, 0x2d

    :cond_d
    const/4 v1, 0x0

    aput-char v5, v0, v1

    .line 1570
    int-to-char v1, p1

    aput-char v1, v0, v4

    .line 1571
    iput v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1572
    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNumberIntegralPart([CI)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1
.end method

.method protected final _finishToken()Lcom/fasterxml/jackson/core/JsonToken;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 203
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    const/4 v1, 0x0

    const/4 v2, 0x1

    const/16 v3, 0x2d

    packed-switch v0, :pswitch_data_0

    .line 316
    :pswitch_0
    invoke-static {}, Lcom/fasterxml/jackson/core/util/VersionUtil;->throwInternal()V

    .line 317
    const/4 v0, 0x0

    return-object v0

    .line 314
    :pswitch_1
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishHashComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 312
    :pswitch_2
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishCppComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 310
    :pswitch_3
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    invoke-direct {p0, v0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishCComment(IZ)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 308
    :pswitch_4
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    invoke-direct {p0, v0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishCComment(IZ)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 306
    :pswitch_5
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startSlashComment(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 301
    :pswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishErrorToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 298
    :pswitch_7
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishAposString()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 276
    :pswitch_8
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pendingBytes:I

    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result v2

    invoke-direct {p0, v0, v1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeSplitUTF8_4(III)Z

    move-result v0

    if-nez v0, :cond_0

    .line 277
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 279
    :cond_0
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorStateAfterSplit:I

    if-ne v0, v3, :cond_1

    .line 280
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishAposString()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 282
    :cond_1
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishRegularString()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 268
    :pswitch_9
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pendingBytes:I

    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result v2

    invoke-direct {p0, v0, v1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeSplitUTF8_3(III)Z

    move-result v0

    if-nez v0, :cond_2

    .line 269
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 271
    :cond_2
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorStateAfterSplit:I

    if-ne v0, v3, :cond_3

    .line 272
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishAposString()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 274
    :cond_3
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishRegularString()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 262
    :pswitch_a
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result v2

    invoke-direct {p0, v1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeUTF8_2(II)I

    move-result v1

    int-to-char v1, v1

    invoke-virtual {v0, v1}, Lcom/fasterxml/jackson/core/util/TextBuffer;->append(C)V

    .line 263
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorStateAfterSplit:I

    if-ne v0, v3, :cond_4

    .line 264
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishAposString()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 266
    :cond_4
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishRegularString()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 286
    :pswitch_b
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quoted32:I

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quotedDigits:I

    invoke-direct {p0, v0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_decodeSplitEscaped(II)I

    move-result v0

    .line 287
    .local v0, "c":I
    if-gez v0, :cond_5

    .line 288
    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v1

    .line 290
    :cond_5
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    int-to-char v2, v0

    invoke-virtual {v1, v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->append(C)V

    .line 292
    .end local v0    # "c":I
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorStateAfterSplit:I

    if-ne v0, v3, :cond_6

    .line 293
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishAposString()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 295
    :cond_6
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishRegularString()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 260
    :pswitch_c
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishRegularString()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 257
    :pswitch_d
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v0

    invoke-virtual {p0, v1, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishFloatExponent(ZI)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 255
    :pswitch_e
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v0

    invoke-virtual {p0, v2, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishFloatExponent(ZI)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 253
    :pswitch_f
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishFloatFraction()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 250
    :pswitch_10
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/util/TextBuffer;->getBufferWithoutReset()[C

    move-result-object v0

    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    .line 251
    invoke-virtual {v1}, Lcom/fasterxml/jackson/core/util/TextBuffer;->getCurrentSegmentSize()I

    move-result v1

    .line 250
    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNumberIntegralPart([CI)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 248
    :pswitch_11
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNumberLeadingNegZeroes()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 246
    :pswitch_12
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNumberLeadingZeroes()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 244
    :pswitch_13
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNumberMinus(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 242
    :pswitch_14
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNumberPlus(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 239
    :pswitch_15
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_nonStdTokenType:I

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    invoke-virtual {p0, v0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNonStdToken(II)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 237
    :pswitch_16
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_FALSE:Lcom/fasterxml/jackson/core/JsonToken;

    const-string v2, "false"

    invoke-virtual {p0, v2, v0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishKeywordToken(Ljava/lang/String;ILcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 235
    :pswitch_17
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_TRUE:Lcom/fasterxml/jackson/core/JsonToken;

    const-string v2, "true"

    invoke-virtual {p0, v2, v0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishKeywordToken(Ljava/lang/String;ILcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 233
    :pswitch_18
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_NULL:Lcom/fasterxml/jackson/core/JsonToken;

    const-string v2, "null"

    invoke-virtual {p0, v2, v0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishKeywordToken(Ljava/lang/String;ILcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 226
    :pswitch_19
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v0

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startValueAfterComma(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 230
    :pswitch_1a
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v0

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startValueExpectColon(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 228
    :pswitch_1b
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v0

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startValueExpectComma(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 224
    :pswitch_1c
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v0

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startValue(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 219
    :pswitch_1d
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadLength:I

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pendingBytes:I

    invoke-direct {p0, v0, v1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishUnquotedName(III)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 217
    :pswitch_1e
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadLength:I

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pendingBytes:I

    invoke-direct {p0, v0, v1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishAposName(III)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 215
    :pswitch_1f
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishFieldWithEscape()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 213
    :pswitch_20
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_quadLength:I

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pendingBytes:I

    invoke-direct {p0, v0, v1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_parseEscapedName(III)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 209
    :pswitch_21
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v0

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFieldNameAfterComma(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 207
    :pswitch_22
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v0

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFieldName(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 205
    :pswitch_23
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishBOM(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_23
        :pswitch_0
        :pswitch_0
        :pswitch_22
        :pswitch_21
        :pswitch_0
        :pswitch_20
        :pswitch_1f
        :pswitch_1e
        :pswitch_1d
        :pswitch_0
        :pswitch_1c
        :pswitch_1b
        :pswitch_1a
        :pswitch_19
        :pswitch_18
        :pswitch_17
        :pswitch_16
        :pswitch_15
        :pswitch_0
        :pswitch_0
        :pswitch_14
        :pswitch_13
        :pswitch_12
        :pswitch_11
        :pswitch_10
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_f
        :pswitch_e
        :pswitch_d
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_c
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method protected final _finishTokenWithEOF()Lcom/fasterxml/jackson/core/JsonToken;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 333
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    .line 334
    .local v0, "t":Lcom/fasterxml/jackson/core/JsonToken;
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    const/4 v2, 0x0

    sparse-switch v1, :sswitch_data_0

    .line 393
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ": was expecting rest of token (internal state: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportInvalidEOF(Ljava/lang/String;Lcom/fasterxml/jackson/core/JsonToken;)V

    .line 394
    return-object v0

    .line 350
    :sswitch_0
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishErrorTokenWithEOF()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 376
    :sswitch_1
    const-string v1, ": was expecting fraction after exponent marker"

    sget-object v2, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_NUMBER_FLOAT:Lcom/fasterxml/jackson/core/JsonToken;

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportInvalidEOF(Ljava/lang/String;Lcom/fasterxml/jackson/core/JsonToken;)V

    .line 384
    :sswitch_2
    const-string v1, ": was expecting closing \'*/\' for comment"

    sget-object v2, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportInvalidEOF(Ljava/lang/String;Lcom/fasterxml/jackson/core/JsonToken;)V

    .line 389
    :sswitch_3
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_eofAsNextToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 370
    :sswitch_4
    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_expLength:I

    .line 373
    :sswitch_5
    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_NUMBER_FLOAT:Lcom/fasterxml/jackson/core/JsonToken;

    invoke-virtual {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueComplete(Lcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 361
    :sswitch_6
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v1}, Lcom/fasterxml/jackson/core/util/TextBuffer;->getCurrentSegmentSize()I

    move-result v1

    .line 362
    .local v1, "len":I
    iget-boolean v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_numberNegative:Z

    if-eqz v2, :cond_0

    .line 363
    add-int/lit8 v1, v1, -0x1

    .line 365
    :cond_0
    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 367
    .end local v1    # "len":I
    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_NUMBER_INT:Lcom/fasterxml/jackson/core/JsonToken;

    invoke-virtual {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueComplete(Lcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 357
    :sswitch_7
    const-string v1, "0"

    invoke-virtual {p0, v2, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueCompleteInt(ILjava/lang/String;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 348
    :sswitch_8
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_nonStdTokenType:I

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNonStdTokenWithEOF(II)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 346
    :sswitch_9
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    sget-object v2, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_FALSE:Lcom/fasterxml/jackson/core/JsonToken;

    const-string v3, "false"

    invoke-virtual {p0, v3, v1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishKeywordTokenWithEOF(Ljava/lang/String;ILcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 344
    :sswitch_a
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    sget-object v2, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_TRUE:Lcom/fasterxml/jackson/core/JsonToken;

    const-string v3, "true"

    invoke-virtual {p0, v3, v1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishKeywordTokenWithEOF(Ljava/lang/String;ILcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 342
    :sswitch_b
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_pending32:I

    sget-object v2, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_NULL:Lcom/fasterxml/jackson/core/JsonToken;

    const-string v3, "null"

    invoke-virtual {p0, v3, v1, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishKeywordTokenWithEOF(Ljava/lang/String;ILcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 338
    :sswitch_c
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_eofAsNextToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 336
    :sswitch_d
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_eofAsNextToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    :sswitch_data_0
    .sparse-switch
        0x3 -> :sswitch_d
        0xc -> :sswitch_c
        0x10 -> :sswitch_b
        0x11 -> :sswitch_a
        0x12 -> :sswitch_9
        0x13 -> :sswitch_8
        0x18 -> :sswitch_7
        0x19 -> :sswitch_7
        0x1a -> :sswitch_6
        0x1e -> :sswitch_4
        0x1f -> :sswitch_1
        0x20 -> :sswitch_5
        0x32 -> :sswitch_0
        0x34 -> :sswitch_2
        0x35 -> :sswitch_2
        0x36 -> :sswitch_3
        0x37 -> :sswitch_3
    .end sparse-switch
.end method

.method protected _reportErrorToken(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 3
    .param p1, "actualToken"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1264
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/util/TextBuffer;->contentsAsString()Ljava/lang/String;

    move-result-object v0

    .line 1265
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_validJsonTokenList()Ljava/lang/String;

    move-result-object v1

    .line 1264
    const-string v2, "Unrecognized token \'%s\': was expecting %s"

    invoke-virtual {p0, v2, v0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportError(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 1266
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0
.end method

.method protected _startAposString()Lcom/fasterxml/jackson/core/JsonToken;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2631
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2632
    .local v0, "ptr":I
    const/4 v1, 0x0

    .line 2633
    .local v1, "outPtr":I
    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->emptyAndGetCurrentSegment()[C

    move-result-object v2

    .line 2634
    .local v2, "outBuf":[C
    sget-object v3, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_icUTF8:[I

    .line 2636
    .local v3, "codes":[I
    iget v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    array-length v5, v2

    add-int/2addr v5, v0

    invoke-static {v4, v5}, Ljava/lang/Math;->min(II)I

    move-result v4

    .line 2637
    .local v4, "max":I
    :goto_0
    if-ge v0, v4, :cond_2

    .line 2638
    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 2639
    .local v5, "c":I
    const/16 v6, 0x27

    if-ne v5, v6, :cond_0

    .line 2640
    add-int/lit8 v6, v0, 0x1

    iput v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2641
    iget-object v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v6, v1}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 2642
    sget-object v6, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_STRING:Lcom/fasterxml/jackson/core/JsonToken;

    invoke-virtual {p0, v6}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueComplete(Lcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v6

    return-object v6

    .line 2645
    :cond_0
    aget v6, v3, v5

    if-eqz v6, :cond_1

    .line 2646
    goto :goto_1

    .line 2648
    :cond_1
    add-int/lit8 v0, v0, 0x1

    .line 2649
    add-int/lit8 v6, v1, 0x1

    .end local v1    # "outPtr":I
    .local v6, "outPtr":I
    int-to-char v7, v5

    aput-char v7, v2, v1

    .line 2650
    .end local v5    # "c":I
    move v1, v6

    goto :goto_0

    .line 2651
    .end local v6    # "outPtr":I
    .restart local v1    # "outPtr":I
    :cond_2
    :goto_1
    iget-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v5, v1}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 2652
    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2653
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishAposString()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v5

    return-object v5
.end method

.method protected _startFalseToken()Lcom/fasterxml/jackson/core/JsonToken;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1103
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1104
    .local v0, "ptr":I
    add-int/lit8 v1, v0, 0x4

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-ge v1, v2, :cond_3

    .line 1105
    add-int/lit8 v1, v0, 0x1

    .end local v0    # "ptr":I
    .local v1, "ptr":I
    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v0

    const/16 v2, 0x61

    if-ne v0, v2, :cond_2

    add-int/lit8 v0, v1, 0x1

    .line 1106
    .end local v1    # "ptr":I
    .restart local v0    # "ptr":I
    invoke-virtual {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v1

    const/16 v2, 0x6c

    if-ne v1, v2, :cond_3

    add-int/lit8 v1, v0, 0x1

    .line 1107
    .end local v0    # "ptr":I
    .restart local v1    # "ptr":I
    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v0

    const/16 v2, 0x73

    if-ne v0, v2, :cond_1

    add-int/lit8 v0, v1, 0x1

    .line 1108
    .end local v1    # "ptr":I
    .restart local v0    # "ptr":I
    invoke-virtual {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v1

    const/16 v2, 0x65

    if-ne v1, v2, :cond_3

    .line 1109
    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v1

    and-int/lit16 v1, v1, 0xff

    .line 1110
    .local v1, "ch":I
    const/16 v2, 0x30

    if-lt v1, v2, :cond_0

    const/16 v2, 0x5d

    if-eq v1, v2, :cond_0

    const/16 v2, 0x7d

    if-ne v1, v2, :cond_3

    .line 1111
    :cond_0
    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1112
    sget-object v2, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_FALSE:Lcom/fasterxml/jackson/core/JsonToken;

    invoke-virtual {p0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueComplete(Lcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v2

    return-object v2

    .line 1107
    .end local v0    # "ptr":I
    .local v1, "ptr":I
    :cond_1
    move v0, v1

    goto :goto_0

    .line 1105
    :cond_2
    move v0, v1

    .line 1116
    .end local v1    # "ptr":I
    .restart local v0    # "ptr":I
    :cond_3
    :goto_0
    const/16 v1, 0x12

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1117
    const-string v1, "false"

    sget-object v2, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_FALSE:Lcom/fasterxml/jackson/core/JsonToken;

    const/4 v3, 0x1

    invoke-virtual {p0, v1, v3, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishKeywordToken(Ljava/lang/String;ILcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1
.end method

.method protected _startFloat([CII)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 9
    .param p1, "outBuf"    # [C
    .param p2, "outPtr"    # I
    .param p3, "ch"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1728
    const/4 v0, 0x0

    .line 1729
    .local v0, "fractLen":I
    const/16 v1, 0x39

    const/16 v2, 0x30

    const/16 v3, 0x2e

    if-ne p3, v3, :cond_5

    .line 1730
    array-length v4, p1

    if-lt p2, v4, :cond_0

    .line 1731
    iget-object v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v4}, Lcom/fasterxml/jackson/core/util/TextBuffer;->expandCurrentSegment()[C

    move-result-object p1

    .line 1733
    :cond_0
    add-int/lit8 v4, p2, 0x1

    .end local p2    # "outPtr":I
    .local v4, "outPtr":I
    aput-char v3, p1, p2

    move p2, v4

    .line 1735
    .end local v4    # "outPtr":I
    .restart local p2    # "outPtr":I
    :goto_0
    iget v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v3, v4, :cond_1

    .line 1736
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v1, p2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 1737
    const/16 v1, 0x1e

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1738
    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_fractLength:I

    .line 1739
    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v1

    .line 1741
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result p3

    .line 1742
    if-lt p3, v2, :cond_4

    if-le p3, v1, :cond_2

    goto :goto_1

    .line 1752
    :cond_2
    array-length v3, p1

    if-lt p2, v3, :cond_3

    .line 1753
    iget-object v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v3}, Lcom/fasterxml/jackson/core/util/TextBuffer;->expandCurrentSegment()[C

    move-result-object p1

    .line 1755
    :cond_3
    add-int/lit8 v3, p2, 0x1

    .end local p2    # "outPtr":I
    .local v3, "outPtr":I
    int-to-char v4, p3

    aput-char v4, p1, p2

    .line 1756
    add-int/lit8 v0, v0, 0x1

    move p2, v3

    goto :goto_0

    .line 1743
    .end local v3    # "outPtr":I
    .restart local p2    # "outPtr":I
    :cond_4
    :goto_1
    and-int/lit16 p3, p3, 0xff

    .line 1745
    if-nez v0, :cond_5

    .line 1746
    sget-object v3, Lcom/fasterxml/jackson/core/json/JsonReadFeature;->ALLOW_TRAILING_DECIMAL_POINT_FOR_NUMBERS:Lcom/fasterxml/jackson/core/json/JsonReadFeature;

    invoke-virtual {v3}, Lcom/fasterxml/jackson/core/json/JsonReadFeature;->mappedFeature()Lcom/fasterxml/jackson/core/JsonParser$Feature;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->isEnabled(Lcom/fasterxml/jackson/core/JsonParser$Feature;)Z

    move-result v3

    if-nez v3, :cond_5

    .line 1747
    const-string v3, "Decimal point not followed by a digit"

    invoke-virtual {p0, p3, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedNumberChar(ILjava/lang/String;)Ljava/lang/Object;

    .line 1759
    :cond_5
    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_fractLength:I

    .line 1760
    const/4 v3, 0x0

    .line 1761
    .local v3, "expLen":I
    const/16 v4, 0x65

    if-eq p3, v4, :cond_6

    const/16 v4, 0x45

    if-ne p3, v4, :cond_11

    .line 1762
    :cond_6
    array-length v4, p1

    if-lt p2, v4, :cond_7

    .line 1763
    iget-object v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v4}, Lcom/fasterxml/jackson/core/util/TextBuffer;->expandCurrentSegment()[C

    move-result-object p1

    .line 1765
    :cond_7
    add-int/lit8 v4, p2, 0x1

    .end local p2    # "outPtr":I
    .restart local v4    # "outPtr":I
    int-to-char v5, p3

    aput-char v5, p1, p2

    .line 1766
    iget p2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    const/4 v6, 0x0

    if-lt p2, v5, :cond_8

    .line 1767
    iget-object p2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {p2, v4}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 1768
    const/16 p2, 0x1f

    iput p2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1769
    iput v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_expLength:I

    .line 1770
    sget-object p2, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object p2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object p2

    .line 1772
    :cond_8
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result p2

    .line 1773
    .end local p3    # "ch":I
    .local p2, "ch":I
    const/16 p3, 0x2d

    const/16 v5, 0x20

    if-eq p2, p3, :cond_a

    const/16 p3, 0x2b

    if-ne p2, p3, :cond_9

    goto :goto_2

    :cond_9
    move p3, v4

    goto :goto_3

    .line 1774
    :cond_a
    :goto_2
    array-length p3, p1

    if-lt v4, p3, :cond_b

    .line 1775
    iget-object p3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {p3}, Lcom/fasterxml/jackson/core/util/TextBuffer;->expandCurrentSegment()[C

    move-result-object p1

    .line 1777
    :cond_b
    add-int/lit8 p3, v4, 0x1

    .end local v4    # "outPtr":I
    .local p3, "outPtr":I
    int-to-char v7, p2

    aput-char v7, p1, v4

    .line 1778
    iget v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v4, v7, :cond_c

    .line 1779
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v1, p3}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 1780
    iput v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1781
    iput v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_expLength:I

    .line 1782
    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v1

    .line 1784
    :cond_c
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result p2

    .line 1786
    :goto_3
    if-lt p2, v2, :cond_f

    if-gt p2, v1, :cond_f

    .line 1787
    add-int/lit8 v3, v3, 0x1

    .line 1788
    array-length v4, p1

    if-lt p3, v4, :cond_d

    .line 1789
    iget-object v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v4}, Lcom/fasterxml/jackson/core/util/TextBuffer;->expandCurrentSegment()[C

    move-result-object p1

    .line 1791
    :cond_d
    add-int/lit8 v4, p3, 0x1

    .end local p3    # "outPtr":I
    .restart local v4    # "outPtr":I
    int-to-char v6, p2

    aput-char v6, p1, p3

    .line 1792
    iget p3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt p3, v6, :cond_e

    .line 1793
    iget-object p3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {p3, v4}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 1794
    iput v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1795
    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_expLength:I

    .line 1796
    sget-object p3, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object p3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object p3

    .line 1798
    :cond_e
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextSignedByteFromBuffer()B

    move-result p2

    move p3, v4

    goto :goto_3

    .line 1801
    .end local v4    # "outPtr":I
    .restart local p3    # "outPtr":I
    :cond_f
    and-int/lit16 p2, p2, 0xff

    .line 1802
    if-nez v3, :cond_10

    .line 1803
    const-string v1, "Exponent indicator not followed by a digit"

    invoke-virtual {p0, p2, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedNumberChar(ILjava/lang/String;)Ljava/lang/Object;

    .line 1807
    :cond_10
    move v8, p3

    move p3, p2

    move p2, v8

    .local p2, "outPtr":I
    .local p3, "ch":I
    :cond_11
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    add-int/lit8 v1, v1, -0x1

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1808
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v1, p2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 1810
    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_expLength:I

    .line 1811
    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_NUMBER_FLOAT:Lcom/fasterxml/jackson/core/JsonToken;

    invoke-virtual {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueComplete(Lcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1
.end method

.method protected _startFloatThatStartsWithPeriod()Lcom/fasterxml/jackson/core/JsonToken;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1278
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_numberNegative:Z

    .line 1279
    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1280
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v1}, Lcom/fasterxml/jackson/core/util/TextBuffer;->emptyAndGetCurrentSegment()[C

    move-result-object v1

    .line 1281
    .local v1, "outBuf":[C
    const/16 v2, 0x2e

    invoke-virtual {p0, v1, v0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFloat([CII)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0
.end method

.method protected _startNegativeNumber()Lcom/fasterxml/jackson/core/JsonToken;
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1336
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_numberNegative:Z

    .line 1337
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v1, v2, :cond_0

    .line 1338
    const/16 v0, 0x17

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1339
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 1341
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v1

    .line 1342
    .local v1, "ch":I
    const/4 v2, 0x2

    const-string v3, "expected digit (0-9) to follow minus sign, for valid numeric value"

    const/16 v4, 0x39

    const/16 v5, 0x30

    if-gt v1, v5, :cond_2

    .line 1343
    if-ne v1, v5, :cond_1

    .line 1344
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNumberLeadingNegZeroes()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 1347
    :cond_1
    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedNumberChar(ILjava/lang/String;)Ljava/lang/Object;

    goto :goto_0

    .line 1348
    :cond_2
    if-le v1, v4, :cond_4

    .line 1349
    const/16 v6, 0x49

    if-ne v1, v6, :cond_3

    .line 1350
    const/4 v0, 0x3

    invoke-virtual {p0, v0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNonStdToken(II)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 1352
    :cond_3
    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedNumberChar(ILjava/lang/String;)Ljava/lang/Object;

    .line 1354
    :cond_4
    :goto_0
    iget-object v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v3}, Lcom/fasterxml/jackson/core/util/TextBuffer;->emptyAndGetCurrentSegment()[C

    move-result-object v3

    .line 1355
    .local v3, "outBuf":[C
    const/4 v6, 0x0

    const/16 v7, 0x2d

    aput-char v7, v3, v6

    .line 1356
    int-to-char v6, v1

    aput-char v6, v3, v0

    .line 1357
    iget v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    const/16 v8, 0x1a

    if-lt v6, v7, :cond_5

    .line 1358
    iput v8, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1359
    iget-object v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v4, v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 1360
    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1361
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 1363
    :cond_5
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    invoke-virtual {p0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v1

    .line 1364
    const/4 v2, 0x2

    .line 1367
    .local v2, "outPtr":I
    :goto_1
    if-ge v1, v5, :cond_6

    .line 1368
    const/16 v4, 0x2e

    if-ne v1, v4, :cond_7

    .line 1369
    add-int/lit8 v4, v2, -0x1

    iput v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1370
    iget v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    add-int/2addr v4, v0

    iput v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1371
    invoke-virtual {p0, v3, v2, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFloat([CII)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 1375
    :cond_6
    if-le v1, v4, :cond_9

    .line 1376
    const/16 v4, 0x65

    if-eq v1, v4, :cond_8

    const/16 v4, 0x45

    if-ne v1, v4, :cond_7

    goto :goto_2

    .line 1395
    :cond_7
    add-int/lit8 v0, v2, -0x1

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1396
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v0, v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 1397
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_NUMBER_INT:Lcom/fasterxml/jackson/core/JsonToken;

    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueComplete(Lcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 1377
    :cond_8
    :goto_2
    add-int/lit8 v4, v2, -0x1

    iput v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1378
    iget v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    add-int/2addr v4, v0

    iput v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1379
    invoke-virtual {p0, v3, v2, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFloat([CII)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 1383
    :cond_9
    array-length v6, v3

    if-lt v2, v6, :cond_a

    .line 1385
    iget-object v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v6}, Lcom/fasterxml/jackson/core/util/TextBuffer;->expandCurrentSegment()[C

    move-result-object v3

    .line 1387
    :cond_a
    add-int/lit8 v6, v2, 0x1

    .end local v2    # "outPtr":I
    .local v6, "outPtr":I
    int-to-char v7, v1

    aput-char v7, v3, v2

    .line 1388
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    add-int/2addr v2, v0

    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v7, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v2, v7, :cond_b

    .line 1389
    iput v8, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1390
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v0, v6}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 1391
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 1393
    :cond_b
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    invoke-virtual {p0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v2

    and-int/lit16 v1, v2, 0xff

    move v2, v6

    goto :goto_1
.end method

.method protected _startNullToken()Lcom/fasterxml/jackson/core/JsonToken;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1140
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1141
    .local v0, "ptr":I
    add-int/lit8 v1, v0, 0x3

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-ge v1, v2, :cond_3

    .line 1142
    add-int/lit8 v1, v0, 0x1

    .end local v0    # "ptr":I
    .local v1, "ptr":I
    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v0

    const/16 v2, 0x75

    if-ne v0, v2, :cond_2

    add-int/lit8 v0, v1, 0x1

    .line 1143
    .end local v1    # "ptr":I
    .restart local v0    # "ptr":I
    invoke-virtual {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v1

    const/16 v2, 0x6c

    if-ne v1, v2, :cond_3

    add-int/lit8 v1, v0, 0x1

    .line 1144
    .end local v0    # "ptr":I
    .restart local v1    # "ptr":I
    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v0

    if-ne v0, v2, :cond_1

    .line 1145
    invoke-virtual {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 1146
    .local v0, "ch":I
    const/16 v2, 0x30

    if-lt v0, v2, :cond_0

    const/16 v2, 0x5d

    if-eq v0, v2, :cond_0

    const/16 v2, 0x7d

    if-ne v0, v2, :cond_1

    .line 1147
    :cond_0
    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1148
    sget-object v2, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_NULL:Lcom/fasterxml/jackson/core/JsonToken;

    invoke-virtual {p0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueComplete(Lcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v2

    return-object v2

    .line 1152
    .end local v0    # "ch":I
    :cond_1
    move v0, v1

    goto :goto_0

    .line 1142
    :cond_2
    move v0, v1

    .line 1152
    .end local v1    # "ptr":I
    .local v0, "ptr":I
    :cond_3
    :goto_0
    const/16 v1, 0x10

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1153
    const-string v1, "null"

    sget-object v2, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_NULL:Lcom/fasterxml/jackson/core/JsonToken;

    const/4 v3, 0x1

    invoke-virtual {p0, v1, v3, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishKeywordToken(Ljava/lang/String;ILcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1
.end method

.method protected _startNumberLeadingZero()Lcom/fasterxml/jackson/core/JsonToken;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1474
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1475
    .local v0, "ptr":I
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v0, v1, :cond_0

    .line 1476
    const/16 v1, 0x18

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1477
    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v1

    .line 1484
    :cond_0
    add-int/lit8 v1, v0, 0x1

    .end local v0    # "ptr":I
    .local v1, "ptr":I
    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 1486
    .local v0, "ch":I
    const/4 v2, 0x0

    const/16 v3, 0x30

    const/4 v4, 0x1

    if-ge v0, v3, :cond_1

    .line 1487
    const/16 v5, 0x2e

    if-ne v0, v5, :cond_3

    .line 1488
    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1489
    iput v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1490
    iget-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v5}, Lcom/fasterxml/jackson/core/util/TextBuffer;->emptyAndGetCurrentSegment()[C

    move-result-object v5

    .line 1491
    .local v5, "outBuf":[C
    aput-char v3, v5, v2

    .line 1492
    invoke-virtual {p0, v5, v4, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFloat([CII)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v2

    return-object v2

    .line 1494
    .end local v5    # "outBuf":[C
    :cond_1
    const/16 v5, 0x39

    if-le v0, v5, :cond_5

    .line 1495
    const/16 v5, 0x65

    if-eq v0, v5, :cond_4

    const/16 v5, 0x45

    if-ne v0, v5, :cond_2

    goto :goto_0

    .line 1505
    :cond_2
    const/16 v3, 0x5d

    if-eq v0, v3, :cond_3

    const/16 v3, 0x7d

    if-eq v0, v3, :cond_3

    .line 1506
    const-string v3, "expected digit (0-9), decimal point (.) or exponent indicator (e/E) to follow \'0\'"

    invoke-virtual {p0, v0, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedNumberChar(ILjava/lang/String;)Ljava/lang/Object;

    .line 1514
    :cond_3
    const-string v3, "0"

    invoke-virtual {p0, v2, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueCompleteInt(ILjava/lang/String;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v2

    return-object v2

    .line 1496
    :cond_4
    :goto_0
    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1497
    iput v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1498
    iget-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v5}, Lcom/fasterxml/jackson/core/util/TextBuffer;->emptyAndGetCurrentSegment()[C

    move-result-object v5

    .line 1499
    .restart local v5    # "outBuf":[C
    aput-char v3, v5, v2

    .line 1500
    invoke-virtual {p0, v5, v4, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFloat([CII)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v2

    return-object v2

    .line 1511
    .end local v5    # "outBuf":[C
    :cond_5
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNumberLeadingZeroes()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v2

    return-object v2
.end method

.method protected _startPositiveNumber()Lcom/fasterxml/jackson/core/JsonToken;
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1402
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_numberNegative:Z

    .line 1403
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v1, v2, :cond_0

    .line 1404
    const/16 v0, 0x16

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1405
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 1407
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v1

    .line 1408
    .local v1, "ch":I
    const-string v2, "JSON spec does not allow numbers to have plus signs: enable `JsonReadFeature.ALLOW_LEADING_PLUS_SIGN_FOR_NUMBERS` to allow"

    const-string v3, "expected digit (0-9) to follow plus sign, for valid numeric value"

    const/16 v4, 0x39

    const/4 v5, 0x2

    const/16 v6, 0x2b

    const/16 v7, 0x30

    if-gt v1, v7, :cond_3

    .line 1409
    if-ne v1, v7, :cond_2

    .line 1410
    sget-object v0, Lcom/fasterxml/jackson/core/json/JsonReadFeature;->ALLOW_LEADING_PLUS_SIGN_FOR_NUMBERS:Lcom/fasterxml/jackson/core/json/JsonReadFeature;

    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/json/JsonReadFeature;->mappedFeature()Lcom/fasterxml/jackson/core/JsonParser$Feature;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->isEnabled(Lcom/fasterxml/jackson/core/JsonParser$Feature;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 1411
    invoke-virtual {p0, v6, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedNumberChar(ILjava/lang/String;)Ljava/lang/Object;

    .line 1413
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNumberLeadingPosZeroes()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 1416
    :cond_2
    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedNumberChar(ILjava/lang/String;)Ljava/lang/Object;

    goto :goto_0

    .line 1417
    :cond_3
    if-le v1, v4, :cond_5

    .line 1418
    const/16 v8, 0x49

    if-ne v1, v8, :cond_4

    .line 1419
    invoke-virtual {p0, v5, v5}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNonStdToken(II)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 1421
    :cond_4
    invoke-virtual {p0, v1, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedNumberChar(ILjava/lang/String;)Ljava/lang/Object;

    .line 1423
    :cond_5
    :goto_0
    sget-object v3, Lcom/fasterxml/jackson/core/json/JsonReadFeature;->ALLOW_LEADING_PLUS_SIGN_FOR_NUMBERS:Lcom/fasterxml/jackson/core/json/JsonReadFeature;

    invoke-virtual {v3}, Lcom/fasterxml/jackson/core/json/JsonReadFeature;->mappedFeature()Lcom/fasterxml/jackson/core/JsonParser$Feature;

    move-result-object v3

    invoke-virtual {p0, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->isEnabled(Lcom/fasterxml/jackson/core/JsonParser$Feature;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 1424
    invoke-virtual {p0, v6, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedNumberChar(ILjava/lang/String;)Ljava/lang/Object;

    .line 1426
    :cond_6
    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->emptyAndGetCurrentSegment()[C

    move-result-object v2

    .line 1427
    .local v2, "outBuf":[C
    aput-char v6, v2, v0

    .line 1428
    int-to-char v0, v1

    const/4 v3, 0x1

    aput-char v0, v2, v3

    .line 1429
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    const/16 v8, 0x1a

    if-lt v0, v6, :cond_7

    .line 1430
    iput v8, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1431
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v0, v5}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 1432
    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1433
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 1435
    :cond_7
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v0

    .line 1436
    .end local v1    # "ch":I
    .local v0, "ch":I
    const/4 v1, 0x2

    .line 1439
    .local v1, "outPtr":I
    :goto_1
    if-ge v0, v7, :cond_8

    .line 1440
    const/16 v4, 0x2e

    if-ne v0, v4, :cond_9

    .line 1441
    add-int/lit8 v4, v1, -0x1

    iput v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1442
    iget v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    add-int/2addr v4, v3

    iput v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1443
    invoke-virtual {p0, v2, v1, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFloat([CII)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v3

    return-object v3

    .line 1447
    :cond_8
    if-le v0, v4, :cond_b

    .line 1448
    const/16 v4, 0x65

    if-eq v0, v4, :cond_a

    const/16 v4, 0x45

    if-ne v0, v4, :cond_9

    goto :goto_2

    .line 1467
    :cond_9
    add-int/lit8 v3, v1, -0x1

    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1468
    iget-object v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v3, v1}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 1469
    sget-object v3, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_NUMBER_INT:Lcom/fasterxml/jackson/core/JsonToken;

    invoke-virtual {p0, v3}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueComplete(Lcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v3

    return-object v3

    .line 1449
    :cond_a
    :goto_2
    add-int/lit8 v4, v1, -0x1

    iput v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1450
    iget v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    add-int/2addr v4, v3

    iput v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1451
    invoke-virtual {p0, v2, v1, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFloat([CII)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v3

    return-object v3

    .line 1455
    :cond_b
    array-length v5, v2

    if-lt v1, v5, :cond_c

    .line 1457
    iget-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v5}, Lcom/fasterxml/jackson/core/util/TextBuffer;->expandCurrentSegment()[C

    move-result-object v2

    .line 1459
    :cond_c
    add-int/lit8 v5, v1, 0x1

    .end local v1    # "outPtr":I
    .local v5, "outPtr":I
    int-to-char v6, v0

    aput-char v6, v2, v1

    .line 1460
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    add-int/2addr v1, v3

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v1, v6, :cond_d

    .line 1461
    iput v8, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1462
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v1, v5}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 1463
    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v1

    .line 1465
    :cond_d
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    invoke-virtual {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v1

    and-int/lit16 v0, v1, 0xff

    move v1, v5

    goto :goto_1
.end method

.method protected _startPositiveNumber(I)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 6
    .param p1, "ch"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1286
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_numberNegative:Z

    .line 1287
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v1}, Lcom/fasterxml/jackson/core/util/TextBuffer;->emptyAndGetCurrentSegment()[C

    move-result-object v1

    .line 1288
    .local v1, "outBuf":[C
    int-to-char v2, p1

    aput-char v2, v1, v0

    .line 1290
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    const/16 v3, 0x1a

    const/4 v4, 0x1

    if-lt v0, v2, :cond_0

    .line 1291
    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1292
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v0, v4}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 1293
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 1296
    :cond_0
    const/4 v0, 0x1

    .line 1298
    .local v0, "outPtr":I
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    invoke-virtual {p0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v2

    and-int/lit16 p1, v2, 0xff

    .line 1300
    :goto_0
    const/16 v2, 0x30

    if-ge p1, v2, :cond_1

    .line 1301
    const/16 v2, 0x2e

    if-ne p1, v2, :cond_2

    .line 1302
    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1303
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    add-int/2addr v2, v4

    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1304
    invoke-virtual {p0, v1, v0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFloat([CII)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v2

    return-object v2

    .line 1308
    :cond_1
    const/16 v2, 0x39

    if-le p1, v2, :cond_4

    .line 1309
    const/16 v2, 0x65

    if-eq p1, v2, :cond_3

    const/16 v2, 0x45

    if-ne p1, v2, :cond_2

    goto :goto_1

    .line 1329
    :cond_2
    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1330
    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v2, v0}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 1331
    sget-object v2, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_NUMBER_INT:Lcom/fasterxml/jackson/core/JsonToken;

    invoke-virtual {p0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueComplete(Lcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v2

    return-object v2

    .line 1310
    :cond_3
    :goto_1
    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_intLength:I

    .line 1311
    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    add-int/2addr v2, v4

    iput v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1312
    invoke-virtual {p0, v1, v0, p1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFloat([CII)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v2

    return-object v2

    .line 1316
    :cond_4
    array-length v2, v1

    if-lt v0, v2, :cond_5

    .line 1319
    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->expandCurrentSegment()[C

    move-result-object v1

    .line 1321
    :cond_5
    add-int/lit8 v2, v0, 0x1

    .end local v0    # "outPtr":I
    .local v2, "outPtr":I
    int-to-char v5, p1

    aput-char v5, v1, v0

    .line 1322
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    add-int/2addr v0, v4

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v0, v5, :cond_6

    .line 1323
    iput v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1324
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v0, v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 1325
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    iput-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 1327
    :cond_6
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v0

    and-int/lit16 p1, v0, 0xff

    move v0, v2

    goto :goto_0
.end method

.method protected _startString()Lcom/fasterxml/jackson/core/JsonToken;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2506
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2507
    .local v0, "ptr":I
    const/4 v1, 0x0

    .line 2508
    .local v1, "outPtr":I
    iget-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v2}, Lcom/fasterxml/jackson/core/util/TextBuffer;->emptyAndGetCurrentSegment()[C

    move-result-object v2

    .line 2509
    .local v2, "outBuf":[C
    sget-object v3, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_icUTF8:[I

    .line 2511
    .local v3, "codes":[I
    iget v4, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    array-length v5, v2

    add-int/2addr v5, v0

    invoke-static {v4, v5}, Ljava/lang/Math;->min(II)I

    move-result v4

    .line 2512
    .local v4, "max":I
    :goto_0
    if-ge v0, v4, :cond_1

    .line 2513
    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v5

    and-int/lit16 v5, v5, 0xff

    .line 2514
    .local v5, "c":I
    aget v6, v3, v5

    if-eqz v6, :cond_0

    .line 2515
    const/16 v6, 0x22

    if-ne v5, v6, :cond_1

    .line 2516
    add-int/lit8 v6, v0, 0x1

    iput v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2517
    iget-object v6, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v6, v1}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 2518
    sget-object v6, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_STRING:Lcom/fasterxml/jackson/core/JsonToken;

    invoke-virtual {p0, v6}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueComplete(Lcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v6

    return-object v6

    .line 2522
    :cond_0
    add-int/lit8 v0, v0, 0x1

    .line 2523
    add-int/lit8 v6, v1, 0x1

    .end local v1    # "outPtr":I
    .local v6, "outPtr":I
    int-to-char v7, v5

    aput-char v7, v2, v1

    .line 2524
    .end local v5    # "c":I
    move v1, v6

    goto :goto_0

    .line 2525
    .end local v6    # "outPtr":I
    .restart local v1    # "outPtr":I
    :cond_1
    iget-object v5, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_textBuffer:Lcom/fasterxml/jackson/core/util/TextBuffer;

    invoke-virtual {v5, v1}, Lcom/fasterxml/jackson/core/util/TextBuffer;->setCurrentLength(I)V

    .line 2526
    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 2527
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishRegularString()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v5

    return-object v5
.end method

.method protected _startTrueToken()Lcom/fasterxml/jackson/core/JsonToken;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1122
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1123
    .local v0, "ptr":I
    add-int/lit8 v1, v0, 0x3

    iget v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-ge v1, v2, :cond_3

    .line 1124
    add-int/lit8 v1, v0, 0x1

    .end local v0    # "ptr":I
    .local v1, "ptr":I
    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v0

    const/16 v2, 0x72

    if-ne v0, v2, :cond_2

    add-int/lit8 v0, v1, 0x1

    .line 1125
    .end local v1    # "ptr":I
    .restart local v0    # "ptr":I
    invoke-virtual {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v1

    const/16 v2, 0x75

    if-ne v1, v2, :cond_3

    add-int/lit8 v1, v0, 0x1

    .line 1126
    .end local v0    # "ptr":I
    .restart local v1    # "ptr":I
    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v0

    const/16 v2, 0x65

    if-ne v0, v2, :cond_1

    .line 1127
    invoke-virtual {p0, v1}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getByteFromBuffer(I)B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    .line 1128
    .local v0, "ch":I
    const/16 v2, 0x30

    if-lt v0, v2, :cond_0

    const/16 v2, 0x5d

    if-eq v0, v2, :cond_0

    const/16 v2, 0x7d

    if-ne v0, v2, :cond_1

    .line 1129
    :cond_0
    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 1130
    sget-object v2, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_TRUE:Lcom/fasterxml/jackson/core/JsonToken;

    invoke-virtual {p0, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueComplete(Lcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v2

    return-object v2

    .line 1134
    .end local v0    # "ch":I
    :cond_1
    move v0, v1

    goto :goto_0

    .line 1124
    :cond_2
    move v0, v1

    .line 1134
    .end local v1    # "ptr":I
    .local v0, "ptr":I
    :cond_3
    :goto_0
    const/16 v1, 0x11

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_minorState:I

    .line 1135
    const-string v1, "true"

    sget-object v2, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_TRUE:Lcom/fasterxml/jackson/core/JsonToken;

    const/4 v3, 0x1

    invoke-virtual {p0, v1, v3, v2}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishKeywordToken(Ljava/lang/String;ILcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1
.end method

.method protected _startUnexpectedValue(ZI)Lcom/fasterxml/jackson/core/JsonToken;
    .locals 3
    .param p1, "leadingComma"    # Z
    .param p2, "ch"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 889
    const/4 v0, 0x1

    sparse-switch p2, :sswitch_data_0

    goto :goto_0

    .line 891
    :sswitch_0
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_parsingContext:Lcom/fasterxml/jackson/core/json/JsonReadContext;

    invoke-virtual {v1}, Lcom/fasterxml/jackson/core/json/JsonReadContext;->inArray()Z

    move-result v1

    if-nez v1, :cond_0

    .line 892
    goto :goto_0

    .line 919
    :sswitch_1
    const/4 v1, 0x0

    invoke-virtual {p0, v1, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNonStdToken(II)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 921
    :sswitch_2
    invoke-virtual {p0, v0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNonStdToken(II)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 900
    :cond_0
    :sswitch_3
    iget-object v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_parsingContext:Lcom/fasterxml/jackson/core/json/JsonReadContext;

    invoke-virtual {v1}, Lcom/fasterxml/jackson/core/json/JsonReadContext;->inRoot()Z

    move-result v1

    if-nez v1, :cond_1

    .line 901
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_features:I

    sget v2, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->FEAT_MASK_ALLOW_MISSING:I

    and-int/2addr v1, v2

    if-eqz v1, :cond_1

    .line 902
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    sub-int/2addr v1, v0

    iput v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    .line 903
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->VALUE_NULL:Lcom/fasterxml/jackson/core/JsonToken;

    invoke-virtual {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_valueComplete(Lcom/fasterxml/jackson/core/JsonToken;)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 910
    :cond_1
    :sswitch_4
    goto :goto_0

    .line 917
    :sswitch_5
    const/4 v1, 0x2

    invoke-virtual {p0, v1, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishNonStdToken(II)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 912
    :sswitch_6
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_features:I

    sget v1, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->FEAT_MASK_ALLOW_SINGLE_QUOTES:I

    and-int/2addr v0, v1

    if-eqz v0, :cond_2

    .line 913
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startAposString()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 924
    :cond_2
    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "expected a valid value "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_validJsonValueList()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, p2, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_reportUnexpectedChar(ILjava/lang/String;)V

    .line 925
    const/4 v0, 0x0

    return-object v0

    nop

    :sswitch_data_0
    .sparse-switch
        0x27 -> :sswitch_6
        0x2b -> :sswitch_5
        0x2c -> :sswitch_3
        0x49 -> :sswitch_2
        0x4e -> :sswitch_1
        0x5d -> :sswitch_0
        0x7d -> :sswitch_4
    .end sparse-switch
.end method

.method public endOfInput()V
    .locals 1

    .line 79
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_endOfInput:Z

    .line 80
    return-void
.end method

.method protected abstract getByteFromBuffer(I)B
.end method

.method protected abstract getNextSignedByteFromBuffer()B
.end method

.method protected abstract getNextUnsignedByteFromBuffer()I
.end method

.method public final needMoreInput()Z
    .locals 2

    .line 75
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    if-lt v0, v1, :cond_0

    iget-boolean v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_endOfInput:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public nextToken()Lcom/fasterxml/jackson/core/JsonToken;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 118
    iget v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputEnd:I

    const/4 v2, 0x0

    if-lt v0, v1, :cond_3

    .line 119
    iget-boolean v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_closed:Z

    if-eqz v0, :cond_0

    .line 120
    return-object v2

    .line 123
    :cond_0
    iget-boolean v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_endOfInput:Z

    if-eqz v0, :cond_2

    .line 126
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    if-ne v0, v1, :cond_1

    .line 127
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishTokenWithEOF()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 129
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_eofAsNextToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 131
    :cond_2
    sget-object v0, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    return-object v0

    .line 134
    :cond_3
    iget-object v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currToken:Lcom/fasterxml/jackson/core/JsonToken;

    sget-object v1, Lcom/fasterxml/jackson/core/JsonToken;->NOT_AVAILABLE:Lcom/fasterxml/jackson/core/JsonToken;

    if-ne v0, v1, :cond_4

    .line 135
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_finishToken()Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v0

    return-object v0

    .line 139
    :cond_4
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_numTypesValid:I

    .line 140
    iget-wide v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_currInputProcessed:J

    iget v3, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_inputPtr:I

    int-to-long v3, v3

    add-long/2addr v0, v3

    iput-wide v0, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_tokenInputTotal:J

    .line 142
    iput-object v2, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_binaryValue:[B

    .line 143
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->getNextUnsignedByteFromBuffer()I

    move-result v0

    .line 145
    .local v0, "ch":I
    iget v1, p0, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_majorState:I

    packed-switch v1, :pswitch_data_0

    .line 168
    invoke-static {}, Lcom/fasterxml/jackson/core/util/VersionUtil;->throwInternal()V

    .line 169
    return-object v2

    .line 164
    :pswitch_0
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startValueExpectComma(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 161
    :pswitch_1
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startValue(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 158
    :pswitch_2
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startValueExpectColon(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 155
    :pswitch_3
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFieldNameAfterComma(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 153
    :pswitch_4
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startFieldName(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 150
    :pswitch_5
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startValue(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    .line 147
    :pswitch_6
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/json/async/NonBlockingUtf8JsonParserBase;->_startDocument(I)Lcom/fasterxml/jackson/core/JsonToken;

    move-result-object v1

    return-object v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
