.class final Lcom/fasterxml/jackson/core/io/doubleparser/DoubleBitsFromCharArray;
.super Lcom/fasterxml/jackson/core/io/doubleparser/AbstractFloatingPointBitsFromCharArray;
.source "DoubleBitsFromCharArray.java"


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
    const-wide/high16 v0, 0x7ff8000000000000L    # Double.NaN

    invoke-static {v0, v1}, Ljava/lang/Double;->doubleToRawLongBits(D)J

    move-result-wide v0

    return-wide v0
.end method

.method negativeInfinity()J
    .locals 2

    .line 32
    const-wide/high16 v0, -0x10000000000000L    # Double.NEGATIVE_INFINITY

    invoke-static {v0, v1}, Ljava/lang/Double;->doubleToRawLongBits(D)J

    move-result-wide v0

    return-wide v0
.end method

.method positiveInfinity()J
    .locals 2

    .line 37
    const-wide/high16 v0, 0x7ff0000000000000L    # Double.POSITIVE_INFINITY

    invoke-static {v0, v1}, Ljava/lang/Double;->doubleToRawLongBits(D)J

    move-result-wide v0

    return-wide v0
.end method

.method valueOfFloatLiteral([CIIZJIZI)J
    .locals 4
    .param p1, "str"    # [C
    .param p2, "startIndex"    # I
    .param p3, "endIndex"    # I
    .param p4, "isNegative"    # Z
    .param p5, "significand"    # J
    .param p7, "exponent"    # I
    .param p8, "isSignificandTruncated"    # Z
    .param p9, "exponentOfTruncatedSignificand"    # I

    .line 44
    invoke-static/range {p4 .. p9}, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath;->tryDecFloatToDoubleTruncated(ZJIZI)D

    move-result-wide v0

    .line 46
    .local v0, "d":D
    invoke-static {v0, v1}, Ljava/lang/Double;->isNaN(D)Z

    move-result v2

    if-eqz v2, :cond_0

    new-instance v2, Ljava/lang/String;

    sub-int v3, p3, p2

    invoke-direct {v2, p1, p2, v3}, Ljava/lang/String;-><init>([CII)V

    invoke-static {v2}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v2

    goto :goto_0

    :cond_0
    move-wide v2, v0

    :goto_0
    invoke-static {v2, v3}, Ljava/lang/Double;->doubleToRawLongBits(D)J

    move-result-wide v2

    return-wide v2
.end method

.method valueOfHexLiteral([CIIZJIZI)J
    .locals 11
    .param p1, "str"    # [C
    .param p2, "startIndex"    # I
    .param p3, "endIndex"    # I
    .param p4, "isNegative"    # Z
    .param p5, "significand"    # J
    .param p7, "exponent"    # I
    .param p8, "isSignificandTruncated"    # Z
    .param p9, "exponentOfTruncatedSignificand"    # I

    .line 53
    move v0, p2

    move/from16 v1, p7

    int-to-long v5, v1

    move/from16 v10, p9

    int-to-long v8, v10

    move v2, p4

    move-wide/from16 v3, p5

    move/from16 v7, p8

    invoke-static/range {v2 .. v9}, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath;->tryHexFloatToDoubleTruncated(ZJJZJ)D

    move-result-wide v2

    .line 55
    .local v2, "d":D
    invoke-static {v2, v3}, Ljava/lang/Double;->isNaN(D)Z

    move-result v4

    if-eqz v4, :cond_0

    new-instance v4, Ljava/lang/String;

    sub-int v5, p3, v0

    move-object v6, p1

    invoke-direct {v4, p1, p2, v5}, Ljava/lang/String;-><init>([CII)V

    invoke-static {v4}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v4

    goto :goto_0

    :cond_0
    move-object v6, p1

    move-wide v4, v2

    :goto_0
    invoke-static {v4, v5}, Ljava/lang/Double;->doubleToRawLongBits(D)J

    move-result-wide v4

    return-wide v4
.end method
