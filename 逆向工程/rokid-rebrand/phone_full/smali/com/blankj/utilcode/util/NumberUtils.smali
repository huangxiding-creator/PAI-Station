.class public final Lcom/blankj/utilcode/util/NumberUtils;
.super Ljava/lang/Object;
.source "NumberUtils.java"


# static fields
.field private static final DF_THREAD_LOCAL:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/text/DecimalFormat;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 18
    new-instance v0, Lcom/blankj/utilcode/util/NumberUtils$1;

    invoke-direct {v0}, Lcom/blankj/utilcode/util/NumberUtils$1;-><init>()V

    sput-object v0, Lcom/blankj/utilcode/util/NumberUtils;->DF_THREAD_LOCAL:Ljava/lang/ThreadLocal;

    return-void
.end method

.method private constructor <init>()V
    .locals 2

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string/jumbo v1, "u can\'t instantiate me..."

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static float2Double(F)D
    .locals 2
    .param p0, "value"    # F

    .line 196
    new-instance v0, Ljava/math/BigDecimal;

    invoke-static {p0}, Ljava/lang/String;->valueOf(F)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/math/BigDecimal;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/math/BigDecimal;->doubleValue()D

    move-result-wide v0

    return-wide v0
.end method

.method public static format(DI)Ljava/lang/String;
    .locals 6
    .param p0, "value"    # D
    .param p2, "fractionDigits"    # I

    .line 116
    const/4 v3, 0x1

    const/4 v5, 0x1

    const/4 v2, 0x0

    move-wide v0, p0

    move v4, p2

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/NumberUtils;->format(DZIIZ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static format(DIIZ)Ljava/lang/String;
    .locals 6
    .param p0, "value"    # D
    .param p2, "minIntegerDigits"    # I
    .param p3, "fractionDigits"    # I
    .param p4, "isHalfUp"    # Z

    .line 141
    const/4 v2, 0x0

    move-wide v0, p0

    move v3, p2

    move v4, p3

    move v5, p4

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/NumberUtils;->format(DZIIZ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static format(DIZ)Ljava/lang/String;
    .locals 6
    .param p0, "value"    # D
    .param p2, "fractionDigits"    # I
    .param p3, "isHalfUp"    # Z

    .line 128
    const/4 v2, 0x0

    const/4 v3, 0x1

    move-wide v0, p0

    move v4, p2

    move v5, p3

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/NumberUtils;->format(DZIIZ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static format(DZI)Ljava/lang/String;
    .locals 6
    .param p0, "value"    # D
    .param p2, "isGrouping"    # Z
    .param p3, "fractionDigits"    # I

    .line 153
    const/4 v3, 0x1

    const/4 v5, 0x1

    move-wide v0, p0

    move v2, p2

    move v4, p3

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/NumberUtils;->format(DZIIZ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static format(DZIIZ)Ljava/lang/String;
    .locals 2
    .param p0, "value"    # D
    .param p2, "isGrouping"    # Z
    .param p3, "minIntegerDigits"    # I
    .param p4, "fractionDigits"    # I
    .param p5, "isHalfUp"    # Z

    .line 180
    invoke-static {}, Lcom/blankj/utilcode/util/NumberUtils;->getSafeDecimalFormat()Ljava/text/DecimalFormat;

    move-result-object v0

    .line 181
    .local v0, "nf":Ljava/text/DecimalFormat;
    invoke-virtual {v0, p2}, Ljava/text/DecimalFormat;->setGroupingUsed(Z)V

    .line 182
    if-eqz p5, :cond_0

    sget-object v1, Ljava/math/RoundingMode;->HALF_UP:Ljava/math/RoundingMode;

    goto :goto_0

    :cond_0
    sget-object v1, Ljava/math/RoundingMode;->DOWN:Ljava/math/RoundingMode;

    :goto_0
    invoke-virtual {v0, v1}, Ljava/text/DecimalFormat;->setRoundingMode(Ljava/math/RoundingMode;)V

    .line 183
    invoke-virtual {v0, p3}, Ljava/text/DecimalFormat;->setMinimumIntegerDigits(I)V

    .line 184
    invoke-virtual {v0, p4}, Ljava/text/DecimalFormat;->setMinimumFractionDigits(I)V

    .line 185
    invoke-virtual {v0, p4}, Ljava/text/DecimalFormat;->setMaximumFractionDigits(I)V

    .line 186
    invoke-virtual {v0, p0, p1}, Ljava/text/DecimalFormat;->format(D)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public static format(DZIZ)Ljava/lang/String;
    .locals 6
    .param p0, "value"    # D
    .param p2, "isGrouping"    # Z
    .param p3, "fractionDigits"    # I
    .param p4, "isHalfUp"    # Z

    .line 166
    const/4 v3, 0x1

    move-wide v0, p0

    move v2, p2

    move v4, p3

    move v5, p4

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/NumberUtils;->format(DZIIZ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static format(FI)Ljava/lang/String;
    .locals 2
    .param p0, "value"    # F
    .param p1, "fractionDigits"    # I

    .line 41
    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-static {p0, v0, v1, p1, v1}, Lcom/blankj/utilcode/util/NumberUtils;->format(FZIIZ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static format(FIIZ)Ljava/lang/String;
    .locals 1
    .param p0, "value"    # F
    .param p1, "minIntegerDigits"    # I
    .param p2, "fractionDigits"    # I
    .param p3, "isHalfUp"    # Z

    .line 66
    const/4 v0, 0x0

    invoke-static {p0, v0, p1, p2, p3}, Lcom/blankj/utilcode/util/NumberUtils;->format(FZIIZ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static format(FIZ)Ljava/lang/String;
    .locals 2
    .param p0, "value"    # F
    .param p1, "fractionDigits"    # I
    .param p2, "isHalfUp"    # Z

    .line 53
    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-static {p0, v0, v1, p1, p2}, Lcom/blankj/utilcode/util/NumberUtils;->format(FZIIZ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static format(FZI)Ljava/lang/String;
    .locals 1
    .param p0, "value"    # F
    .param p1, "isGrouping"    # Z
    .param p2, "fractionDigits"    # I

    .line 78
    const/4 v0, 0x1

    invoke-static {p0, p1, v0, p2, v0}, Lcom/blankj/utilcode/util/NumberUtils;->format(FZIIZ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static format(FZIIZ)Ljava/lang/String;
    .locals 6
    .param p0, "value"    # F
    .param p1, "isGrouping"    # Z
    .param p2, "minIntegerDigits"    # I
    .param p3, "fractionDigits"    # I
    .param p4, "isHalfUp"    # Z

    .line 105
    invoke-static {p0}, Lcom/blankj/utilcode/util/NumberUtils;->float2Double(F)D

    move-result-wide v0

    move v2, p1

    move v3, p2

    move v4, p3

    move v5, p4

    invoke-static/range {v0 .. v5}, Lcom/blankj/utilcode/util/NumberUtils;->format(DZIIZ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static format(FZIZ)Ljava/lang/String;
    .locals 1
    .param p0, "value"    # F
    .param p1, "isGrouping"    # Z
    .param p2, "fractionDigits"    # I
    .param p3, "isHalfUp"    # Z

    .line 91
    const/4 v0, 0x1

    invoke-static {p0, p1, v0, p2, p3}, Lcom/blankj/utilcode/util/NumberUtils;->format(FZIIZ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getSafeDecimalFormat()Ljava/text/DecimalFormat;
    .locals 1

    .line 26
    sget-object v0, Lcom/blankj/utilcode/util/NumberUtils;->DF_THREAD_LOCAL:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/text/DecimalFormat;

    return-object v0
.end method
