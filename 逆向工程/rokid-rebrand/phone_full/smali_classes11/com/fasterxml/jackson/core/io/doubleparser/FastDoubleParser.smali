.class public Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleParser;
.super Ljava/lang/Object;
.source "FastDoubleParser.java"


# static fields
.field private static final CHAR_ARRAY_PARSER:Lcom/fasterxml/jackson/core/io/doubleparser/DoubleBitsFromCharArray;

.field private static final CHAR_SEQ_PARSER:Lcom/fasterxml/jackson/core/io/doubleparser/DoubleBitsFromCharSequence;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 18
    new-instance v0, Lcom/fasterxml/jackson/core/io/doubleparser/DoubleBitsFromCharArray;

    invoke-direct {v0}, Lcom/fasterxml/jackson/core/io/doubleparser/DoubleBitsFromCharArray;-><init>()V

    sput-object v0, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleParser;->CHAR_ARRAY_PARSER:Lcom/fasterxml/jackson/core/io/doubleparser/DoubleBitsFromCharArray;

    .line 19
    new-instance v0, Lcom/fasterxml/jackson/core/io/doubleparser/DoubleBitsFromCharSequence;

    invoke-direct {v0}, Lcom/fasterxml/jackson/core/io/doubleparser/DoubleBitsFromCharSequence;-><init>()V

    sput-object v0, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleParser;->CHAR_SEQ_PARSER:Lcom/fasterxml/jackson/core/io/doubleparser/DoubleBitsFromCharSequence;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 26
    return-void
.end method

.method public static parseDouble(Ljava/lang/CharSequence;)D
    .locals 2
    .param p0, "str"    # Ljava/lang/CharSequence;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NumberFormatException;
        }
    .end annotation

    .line 36
    const/4 v0, 0x0

    invoke-interface {p0}, Ljava/lang/CharSequence;->length()I

    move-result v1

    invoke-static {p0, v0, v1}, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleParser;->parseDouble(Ljava/lang/CharSequence;II)D

    move-result-wide v0

    return-wide v0
.end method

.method public static parseDouble(Ljava/lang/CharSequence;II)D
    .locals 4
    .param p0, "str"    # Ljava/lang/CharSequence;
    .param p1, "offset"    # I
    .param p2, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NumberFormatException;
        }
    .end annotation

    .line 52
    sget-object v0, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleParser;->CHAR_SEQ_PARSER:Lcom/fasterxml/jackson/core/io/doubleparser/DoubleBitsFromCharSequence;

    invoke-virtual {v0, p0, p1, p2}, Lcom/fasterxml/jackson/core/io/doubleparser/DoubleBitsFromCharSequence;->parseFloatingPointLiteral(Ljava/lang/CharSequence;II)J

    move-result-wide v0

    .line 53
    .local v0, "bitPattern":J
    const-wide/16 v2, -0x1

    cmp-long v2, v0, v2

    if-eqz v2, :cond_0

    .line 56
    invoke-static {v0, v1}, Ljava/lang/Double;->longBitsToDouble(J)D

    move-result-wide v2

    return-wide v2

    .line 54
    :cond_0
    new-instance v2, Ljava/lang/NumberFormatException;

    const-string v3, "Illegal input"

    invoke-direct {v2, v3}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method public static parseDouble([C)D
    .locals 2
    .param p0, "str"    # [C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NumberFormatException;
        }
    .end annotation

    .line 67
    const/4 v0, 0x0

    array-length v1, p0

    invoke-static {p0, v0, v1}, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleParser;->parseDouble([CII)D

    move-result-wide v0

    return-wide v0
.end method

.method public static parseDouble([CII)D
    .locals 4
    .param p0, "str"    # [C
    .param p1, "offset"    # I
    .param p2, "length"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NumberFormatException;
        }
    .end annotation

    .line 84
    sget-object v0, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleParser;->CHAR_ARRAY_PARSER:Lcom/fasterxml/jackson/core/io/doubleparser/DoubleBitsFromCharArray;

    invoke-virtual {v0, p0, p1, p2}, Lcom/fasterxml/jackson/core/io/doubleparser/DoubleBitsFromCharArray;->parseFloatingPointLiteral([CII)J

    move-result-wide v0

    .line 85
    .local v0, "bitPattern":J
    const-wide/16 v2, -0x1

    cmp-long v2, v0, v2

    if-eqz v2, :cond_0

    .line 88
    invoke-static {v0, v1}, Ljava/lang/Double;->longBitsToDouble(J)D

    move-result-wide v2

    return-wide v2

    .line 86
    :cond_0
    new-instance v2, Ljava/lang/NumberFormatException;

    const-string v3, "Illegal input"

    invoke-direct {v2, v3}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method public static parseDoubleBits(Ljava/lang/CharSequence;II)J
    .locals 2
    .param p0, "str"    # Ljava/lang/CharSequence;
    .param p1, "offset"    # I
    .param p2, "length"    # I

    .line 114
    sget-object v0, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleParser;->CHAR_SEQ_PARSER:Lcom/fasterxml/jackson/core/io/doubleparser/DoubleBitsFromCharSequence;

    invoke-virtual {v0, p0, p1, p2}, Lcom/fasterxml/jackson/core/io/doubleparser/DoubleBitsFromCharSequence;->parseFloatingPointLiteral(Ljava/lang/CharSequence;II)J

    move-result-wide v0

    return-wide v0
.end method

.method public static parseDoubleBits([CII)J
    .locals 2
    .param p0, "str"    # [C
    .param p1, "offset"    # I
    .param p2, "length"    # I

    .line 133
    sget-object v0, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleParser;->CHAR_ARRAY_PARSER:Lcom/fasterxml/jackson/core/io/doubleparser/DoubleBitsFromCharArray;

    invoke-virtual {v0, p0, p1, p2}, Lcom/fasterxml/jackson/core/io/doubleparser/DoubleBitsFromCharArray;->parseFloatingPointLiteral([CII)J

    move-result-wide v0

    return-wide v0
.end method
