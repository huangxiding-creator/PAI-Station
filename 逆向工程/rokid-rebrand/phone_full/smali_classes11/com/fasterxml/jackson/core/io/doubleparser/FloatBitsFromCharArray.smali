.class Lcom/fasterxml/jackson/core/io/doubleparser/FloatBitsFromCharArray;
.super Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;
.source "FloatBitsFromCharArray.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 21
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;-><init>()V

    .line 23
    return-void
.end method


# virtual methods
.method nan()J
    .locals 2

    .line 27
    const/high16 v0, 0x7fc00000    # Float.NaN

    invoke-static {v0}, Ljava/lang/Float;->floatToRawIntBits(F)I

    move-result v0

    int-to-long v0, v0

    return-wide v0
.end method

.method negativeInfinity()J
    .locals 2

    .line 32
    const/high16 v0, -0x800000    # Float.NEGATIVE_INFINITY

    invoke-static {v0}, Ljava/lang/Float;->floatToRawIntBits(F)I

    move-result v0

    int-to-long v0, v0

    return-wide v0
.end method

.method positiveInfinity()J
    .locals 2

    .line 37
    const/high16 v0, 0x7f800000    # Float.POSITIVE_INFINITY

    invoke-static {v0}, Ljava/lang/Float;->floatToRawIntBits(F)I

    move-result v0

    int-to-long v0, v0

    return-wide v0
.end method

.method valueOfFloatLiteral([CIIZJIZI)J
    .locals 3
    .param p1, "str"    # [C
    .param p2, "startIndex"    # I
    .param p3, "endIndex"    # I
    .param p4, "isNegative"    # Z
    .param p5, "significand"    # J
    .param p7, "exponent"    # I
    .param p8, "isSignificandTruncated"    # Z
    .param p9, "exponentOfTruncatedSignificand"    # I

    .line 44
    invoke-static/range {p4 .. p9}, Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatMath;->decFloatLiteralToFloat(ZJIZI)F

    move-result v0

    .line 45
    .local v0, "result":F
    invoke-static {v0}, Ljava/lang/Float;->isNaN(F)Z

    move-result v1

    if-eqz v1, :cond_0

    new-instance v1, Ljava/lang/String;

    sub-int v2, p3, p2

    invoke-direct {v1, p1, p2, v2}, Ljava/lang/String;-><init>([CII)V

    invoke-static {v1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v1

    invoke-static {v1}, Ljava/lang/Float;->floatToRawIntBits(F)I

    move-result v1

    goto :goto_0

    :cond_0
    invoke-static {v0}, Ljava/lang/Float;->floatToRawIntBits(F)I

    move-result v1

    :goto_0
    int-to-long v1, v1

    return-wide v1
.end method

.method valueOfHexLiteral([CIIZJIZI)J
    .locals 3
    .param p1, "str"    # [C
    .param p2, "startIndex"    # I
    .param p3, "endIndex"    # I
    .param p4, "isNegative"    # Z
    .param p5, "significand"    # J
    .param p7, "exponent"    # I
    .param p8, "isSignificandTruncated"    # Z
    .param p9, "exponentOfTruncatedSignificand"    # I

    .line 52
    invoke-static/range {p4 .. p9}, Lcom/fasterxml/jackson/core/io/doubleparser/FastFloatMath;->hexFloatLiteralToFloat(ZJIZI)F

    move-result v0

    .line 53
    .local v0, "d":F
    invoke-static {v0}, Ljava/lang/Float;->isNaN(F)Z

    move-result v1

    if-eqz v1, :cond_0

    new-instance v1, Ljava/lang/String;

    sub-int v2, p3, p2

    invoke-direct {v1, p1, p2, v2}, Ljava/lang/String;-><init>([CII)V

    invoke-static {v1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v1

    goto :goto_0

    :cond_0
    move v1, v0

    :goto_0
    invoke-static {v1}, Ljava/lang/Float;->floatToRawIntBits(F)I

    move-result v1

    int-to-long v1, v1

    return-wide v1
.end method
