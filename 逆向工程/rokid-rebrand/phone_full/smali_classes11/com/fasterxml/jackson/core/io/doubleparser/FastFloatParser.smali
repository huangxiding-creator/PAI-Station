.class public Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatParser;
.super Ljava/lang/Object;
.source "FastFloatParser.java"


# static fields
.field private static final CHAR_ARRAY_PARSER:Lcom/fasterxml/jackson/core/io/doubleparser/FloatBitsFromCharArray;

.field private static final CHAR_SEQ_PARSER:Lcom/fasterxml/jackson/core/io/doubleparser/FloatBitsFromCharSequence;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 18
    new-instance v0, Lcom/fasterxml/jackson/core/io/doubleparser/FloatBitsFromCharArray;

    invoke-direct {v0}, Lcom/fasterxml/jackson/core/io/doubleparser/FloatBitsFromCharArray;-><init>()V

    sput-object v0, Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatParser;->CHAR_ARRAY_PARSER:Lcom/fasterxml/jackson/core/io/doubleparser/FloatBitsFromCharArray;

    .line 19
    new-instance v0, Lcom/fasterxml/jackson/core/io/doubleparser/FloatBitsFromCharSequence;

    invoke-direct {v0}, Lcom/fasterxml/jackson/core/io/doubleparser/FloatBitsFromCharSequence;-><init>()V

    sput-object v0, Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatParser;->CHAR_SEQ_PARSER:Lcom/fasterxml/jackson/core/io/doubleparser/FloatBitsFromCharSequence;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 26
    return-void
.end method

.method public static parseFloat(Ljava/lang/CharSequence;)F
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

    invoke-static {p0, v0, v1}, Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatParser;->parseFloat(Ljava/lang/CharSequence;II)F

    move-result v0

    return v0
.end method

.method public static parseFloat(Ljava/lang/CharSequence;II)F
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
    sget-object v0, Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatParser;->CHAR_SEQ_PARSER:Lcom/fasterxml/jackson/core/io/doubleparser/FloatBitsFromCharSequence;

    invoke-virtual {v0, p0, p1, p2}, Lcom/fasterxml/jackson/core/io/doubleparser/FloatBitsFromCharSequence;->parseFloatingPointLiteral(Ljava/lang/CharSequence;II)J

    move-result-wide v0

    .line 53
    .local v0, "bitPattern":J
    const-wide/16 v2, -0x1

    cmp-long v2, v0, v2

    if-eqz v2, :cond_0

    .line 56
    long-to-int v2, v0

    invoke-static {v2}, Ljava/lang/Float;->intBitsToFloat(I)F

    move-result v2

    return v2

    .line 54
    :cond_0
    new-instance v2, Ljava/lang/NumberFormatException;

    const-string v3, "Illegal input"

    invoke-direct {v2, v3}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method public static parseFloat([C)F
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

    invoke-static {p0, v0, v1}, Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatParser;->parseFloat([CII)F

    move-result v0

    return v0
.end method

.method public static parseFloat([CII)F
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
    sget-object v0, Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatParser;->CHAR_ARRAY_PARSER:Lcom/fasterxml/jackson/core/io/doubleparser/FloatBitsFromCharArray;

    invoke-virtual {v0, p0, p1, p2}, Lcom/fasterxml/jackson/core/io/doubleparser/FloatBitsFromCharArray;->parseFloatingPointLiteral([CII)J

    move-result-wide v0

    .line 85
    .local v0, "bitPattern":J
    const-wide/16 v2, -0x1

    cmp-long v2, v0, v2

    if-eqz v2, :cond_0

    .line 88
    long-to-int v2, v0

    invoke-static {v2}, Ljava/lang/Float;->intBitsToFloat(I)F

    move-result v2

    return v2

    .line 86
    :cond_0
    new-instance v2, Ljava/lang/NumberFormatException;

    const-string v3, "Illegal input"

    invoke-direct {v2, v3}, Ljava/lang/NumberFormatException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method public static parseFloatBits(Ljava/lang/CharSequence;II)J
    .locals 2
    .param p0, "str"    # Ljava/lang/CharSequence;
    .param p1, "offset"    # I
    .param p2, "length"    # I

    .line 114
    sget-object v0, Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatParser;->CHAR_SEQ_PARSER:Lcom/fasterxml/jackson/core/io/doubleparser/FloatBitsFromCharSequence;

    invoke-virtual {v0, p0, p1, p2}, Lcom/fasterxml/jackson/core/io/doubleparser/FloatBitsFromCharSequence;->parseFloatingPointLiteral(Ljava/lang/CharSequence;II)J

    move-result-wide v0

    return-wide v0
.end method

.method public static parseFloatBits([CII)J
    .locals 2
    .param p0, "str"    # [C
    .param p1, "offset"    # I
    .param p2, "length"    # I

    .line 133
    sget-object v0, Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatParser;->CHAR_ARRAY_PARSER:Lcom/fasterxml/jackson/core/io/doubleparser/FloatBitsFromCharArray;

    invoke-virtual {v0, p0, p1, p2}, Lcom/fasterxml/jackson/core/io/doubleparser/FloatBitsFromCharArray;->parseFloatingPointLiteral([CII)J

    move-result-wide v0

    return-wide v0
.end method
