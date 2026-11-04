.class public final Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;
.super Ljava/lang/Object;
.source "DoubleToDecimal.java"


# static fields
.field private static final BQ_MASK:I = 0x7ff

.field private static final C_MIN:J = 0x10000000000000L

.field static final C_TINY:J = 0x3L

.field static final E_MAX:I = 0x135

.field static final E_MIN:I = -0x143

.field static final H:I = 0x11

.field static final K_MAX:I = 0x124

.field static final K_MIN:I = -0x144

.field private static final MASK_28:I = 0xfffffff

.field private static final MASK_63:J = 0x7fffffffffffffffL

.field public static final MAX_CHARS:I = 0x18

.field private static final MINUS_INF:I = 0x4

.field private static final MINUS_ZERO:I = 0x2

.field private static final NAN:I = 0x5

.field private static final NON_SPECIAL:I = 0x0

.field static final P:I = 0x35

.field private static final PLUS_INF:I = 0x3

.field private static final PLUS_ZERO:I = 0x1

.field static final Q_MAX:I = 0x3cb

.field static final Q_MIN:I = -0x432

.field private static final T_MASK:J = 0xfffffffffffffL

.field private static final W:I = 0xb


# instance fields
.field private final bytes:[B

.field private index:I


# direct methods
.method private constructor <init>()V
    .locals 1

    .line 117
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 112
    const/16 v0, 0x18

    new-array v0, v0, [B

    iput-object v0, p0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->bytes:[B

    .line 118
    return-void
.end method

.method private append(I)V
    .locals 3
    .param p1, "c"    # I

    .line 515
    iget-object v0, p0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->bytes:[B

    iget v1, p0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->index:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->index:I

    int-to-byte v2, p1

    aput-byte v2, v0, v1

    .line 516
    return-void
.end method

.method private append8Digits(I)V
    .locals 4
    .param p1, "m"    # I

    .line 453
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->y(I)I

    move-result v0

    .line 454
    .local v0, "y":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    const/16 v2, 0x8

    if-ge v1, v2, :cond_0

    .line 455
    mul-int/lit8 v2, v0, 0xa

    .line 456
    .local v2, "t":I
    ushr-int/lit8 v3, v2, 0x1c

    invoke-direct {p0, v3}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->appendDigit(I)V

    .line 457
    const v3, 0xfffffff

    and-int v0, v2, v3

    .line 454
    .end local v2    # "t":I
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 459
    .end local v1    # "i":I
    :cond_0
    return-void
.end method

.method private appendDecimalTo(DLjava/lang/Appendable;)Ljava/lang/Appendable;
    .locals 4
    .param p1, "v"    # D
    .param p3, "app"    # Ljava/lang/Appendable;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 161
    invoke-direct {p0, p1, p2}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->toDecimal(D)I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 181
    const-string v0, "NaN"

    invoke-interface {p3, v0}, Ljava/lang/Appendable;->append(Ljava/lang/CharSequence;)Ljava/lang/Appendable;

    move-result-object v0

    return-object v0

    .line 180
    :pswitch_0
    const-string v0, "-Infinity"

    invoke-interface {p3, v0}, Ljava/lang/Appendable;->append(Ljava/lang/CharSequence;)Ljava/lang/Appendable;

    move-result-object v0

    return-object v0

    .line 179
    :pswitch_1
    const-string v0, "Infinity"

    invoke-interface {p3, v0}, Ljava/lang/Appendable;->append(Ljava/lang/CharSequence;)Ljava/lang/Appendable;

    move-result-object v0

    return-object v0

    .line 178
    :pswitch_2
    const-string v0, "-0.0"

    invoke-interface {p3, v0}, Ljava/lang/Appendable;->append(Ljava/lang/CharSequence;)Ljava/lang/Appendable;

    move-result-object v0

    return-object v0

    .line 177
    :pswitch_3
    const-string v0, "0.0"

    invoke-interface {p3, v0}, Ljava/lang/Appendable;->append(Ljava/lang/CharSequence;)Ljava/lang/Appendable;

    move-result-object v0

    return-object v0

    .line 163
    :pswitch_4
    iget v0, p0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->index:I

    add-int/lit8 v0, v0, 0x1

    new-array v0, v0, [C

    .line 164
    .local v0, "chars":[C
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, v0

    if-ge v1, v2, :cond_0

    .line 165
    iget-object v2, p0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->bytes:[B

    aget-byte v2, v2, v1

    int-to-char v2, v2

    aput-char v2, v0, v1

    .line 164
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 167
    .end local v1    # "i":I
    :cond_0
    instance-of v1, p3, Ljava/lang/StringBuilder;

    if-eqz v1, :cond_1

    .line 168
    move-object v1, p3

    check-cast v1, Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append([C)Ljava/lang/StringBuilder;

    move-result-object v1

    return-object v1

    .line 170
    :cond_1
    instance-of v1, p3, Ljava/lang/StringBuffer;

    if-eqz v1, :cond_2

    .line 171
    move-object v1, p3

    check-cast v1, Ljava/lang/StringBuffer;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuffer;->append([C)Ljava/lang/StringBuffer;

    move-result-object v1

    return-object v1

    .line 173
    :cond_2
    array-length v1, v0

    const/4 v2, 0x0

    :goto_1
    if-ge v2, v1, :cond_3

    aget-char v3, v0, v2

    .line 174
    .local v3, "c":C
    invoke-interface {p3, v3}, Ljava/lang/Appendable;->append(C)Ljava/lang/Appendable;

    .line 173
    .end local v3    # "c":C
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 176
    :cond_3
    return-object p3

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private appendDigit(I)V
    .locals 3
    .param p1, "d"    # I

    .line 519
    iget-object v0, p0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->bytes:[B

    iget v1, p0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->index:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->index:I

    add-int/lit8 v2, p1, 0x30

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 520
    return-void
.end method

.method public static appendTo(DLjava/lang/Appendable;)Ljava/lang/Appendable;
    .locals 1
    .param p0, "v"    # D
    .param p2, "app"    # Ljava/lang/Appendable;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 145
    new-instance v0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;

    invoke-direct {v0}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;-><init>()V

    invoke-direct {v0, p0, p1, p2}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->appendDecimalTo(DLjava/lang/Appendable;)Ljava/lang/Appendable;

    move-result-object v0

    return-object v0
.end method

.method private charsToString()Ljava/lang/String;
    .locals 4

    .line 525
    new-instance v0, Ljava/lang/String;

    iget-object v1, p0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->bytes:[B

    iget v2, p0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->index:I

    add-int/lit8 v2, v2, 0x1

    const/4 v3, 0x0

    invoke-direct {v0, v1, v3, v3, v2}, Ljava/lang/String;-><init>([BIII)V

    return-object v0
.end method

.method private exponent(I)V
    .locals 3
    .param p1, "e"    # I

    .line 486
    const/16 v0, 0x45

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->append(I)V

    .line 487
    if-gez p1, :cond_0

    .line 488
    const/16 v0, 0x2d

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->append(I)V

    .line 489
    neg-int p1, p1

    .line 491
    :cond_0
    const/16 v0, 0xa

    if-ge p1, v0, :cond_1

    .line 492
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->appendDigit(I)V

    .line 493
    return-void

    .line 496
    :cond_1
    const/16 v1, 0x64

    if-lt p1, v1, :cond_2

    .line 501
    mul-int/lit16 v1, p1, 0x51f

    ushr-int/lit8 v1, v1, 0x11

    .line 502
    .local v1, "d":I
    invoke-direct {p0, v1}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->appendDigit(I)V

    .line 503
    mul-int/lit8 v2, v1, 0x64

    sub-int/2addr p1, v2

    .line 509
    .end local v1    # "d":I
    :cond_2
    mul-int/lit8 v1, p1, 0x67

    ushr-int/lit8 v0, v1, 0xa

    .line 510
    .local v0, "d":I
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->appendDigit(I)V

    .line 511
    mul-int/lit8 v1, v0, 0xa

    sub-int v1, p1, v1

    invoke-direct {p0, v1}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->appendDigit(I)V

    .line 512
    return-void
.end method

.method private lowDigits(I)V
    .locals 0
    .param p1, "l"    # I

    .line 442
    if-eqz p1, :cond_0

    .line 443
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->append8Digits(I)V

    .line 445
    :cond_0
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->removeTrailingZeroes()V

    .line 446
    return-void
.end method

.method private removeTrailingZeroes()V
    .locals 2

    .line 462
    nop

    :goto_0
    iget-object v0, p0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->bytes:[B

    iget v1, p0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->index:I

    aget-byte v0, v0, v1

    const/16 v1, 0x30

    if-ne v0, v1, :cond_0

    .line 463
    iget v0, p0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->index:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->index:I

    goto :goto_0

    .line 466
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->bytes:[B

    iget v1, p0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->index:I

    aget-byte v0, v0, v1

    const/16 v1, 0x2e

    if-ne v0, v1, :cond_1

    .line 467
    iget v0, p0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->index:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->index:I

    .line 469
    :cond_1
    return-void
.end method

.method private static rop(JJJ)J
    .locals 19
    .param p0, "g1"    # J
    .param p2, "g0"    # J
    .param p4, "cp"    # J

    .line 333
    move-wide/from16 v0, p0

    move-wide/from16 v2, p4

    invoke-static/range {p2 .. p5}, Lcom/fasterxml/jackson/core/io/schubfach/MathUtils;->multiplyHigh(JJ)J

    move-result-wide v4

    .line 334
    .local v4, "x1":J
    mul-long v6, v0, v2

    .line 335
    .local v6, "y0":J
    invoke-static {v0, v1, v2, v3}, Lcom/fasterxml/jackson/core/io/schubfach/MathUtils;->multiplyHigh(JJ)J

    move-result-wide v8

    .line 336
    .local v8, "y1":J
    const/4 v10, 0x1

    ushr-long v10, v6, v10

    add-long/2addr v10, v4

    .line 337
    .local v10, "z":J
    const/16 v12, 0x3f

    ushr-long v13, v10, v12

    add-long/2addr v13, v8

    .line 338
    .local v13, "vbp":J
    const-wide v15, 0x7fffffffffffffffL

    and-long v17, v10, v15

    add-long v17, v17, v15

    ushr-long v15, v17, v12

    or-long/2addr v15, v13

    return-wide v15
.end method

.method private toChars(JI)I
    .locals 7
    .param p1, "f"    # J
    .param p3, "e"    # I

    .line 351
    invoke-static {p1, p2}, Ljava/lang/Long;->numberOfLeadingZeros(J)I

    move-result v0

    rsub-int/lit8 v0, v0, 0x40

    invoke-static {v0}, Lcom/fasterxml/jackson/core/io/schubfach/MathUtils;->flog10pow2(I)I

    move-result v0

    .line 352
    .local v0, "len":I
    invoke-static {v0}, Lcom/fasterxml/jackson/core/io/schubfach/MathUtils;->pow10(I)J

    move-result-wide v1

    cmp-long v1, p1, v1

    if-ltz v1, :cond_0

    .line 353
    add-int/lit8 v0, v0, 0x1

    .line 362
    :cond_0
    rsub-int/lit8 v1, v0, 0x11

    invoke-static {v1}, Lcom/fasterxml/jackson/core/io/schubfach/MathUtils;->pow10(I)J

    move-result-wide v1

    mul-long/2addr p1, v1

    .line 363
    add-int/2addr p3, v0

    .line 379
    const-wide v1, 0x2af31dc4611873cL    # 9.53972865917246E-296

    invoke-static {p1, p2, v1, v2}, Lcom/fasterxml/jackson/core/io/schubfach/MathUtils;->multiplyHigh(JJ)J

    move-result-wide v1

    const/16 v3, 0x14

    ushr-long/2addr v1, v3

    .line 380
    .local v1, "hm":J
    const-wide/32 v3, 0x5f5e100

    mul-long/2addr v3, v1

    sub-long v3, p1, v3

    long-to-int v3, v3

    .line 381
    .local v3, "l":I
    const-wide/32 v4, 0x55e63b89

    mul-long/2addr v4, v1

    const/16 v6, 0x39

    ushr-long/2addr v4, v6

    long-to-int v4, v4

    .line 382
    .local v4, "h":I
    const v5, 0x5f5e100

    mul-int/2addr v5, v4

    int-to-long v5, v5

    sub-long v5, v1, v5

    long-to-int v5, v5

    .line 384
    .local v5, "m":I
    if-lez p3, :cond_1

    const/4 v6, 0x7

    if-gt p3, v6, :cond_1

    .line 385
    invoke-direct {p0, v4, v5, v3, p3}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->toChars1(IIII)I

    move-result v6

    return v6

    .line 387
    :cond_1
    const/4 v6, -0x3

    if-ge v6, p3, :cond_2

    if-gtz p3, :cond_2

    .line 388
    invoke-direct {p0, v4, v5, v3, p3}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->toChars2(IIII)I

    move-result v6

    return v6

    .line 390
    :cond_2
    invoke-direct {p0, v4, v5, v3, p3}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->toChars3(IIII)I

    move-result v6

    return v6
.end method

.method private toChars1(IIII)I
    .locals 5
    .param p1, "h"    # I
    .param p2, "m"    # I
    .param p3, "l"    # I
    .param p4, "e"    # I

    .line 399
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->appendDigit(I)V

    .line 400
    invoke-direct {p0, p2}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->y(I)I

    move-result v0

    .line 402
    .local v0, "y":I
    const/4 v1, 0x1

    .line 403
    .local v1, "i":I
    :goto_0
    const v2, 0xfffffff

    if-ge v1, p4, :cond_0

    .line 404
    mul-int/lit8 v3, v0, 0xa

    .line 405
    .local v3, "t":I
    ushr-int/lit8 v4, v3, 0x1c

    invoke-direct {p0, v4}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->appendDigit(I)V

    .line 406
    and-int v0, v3, v2

    .line 403
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 408
    .end local v3    # "t":I
    :cond_0
    const/16 v3, 0x2e

    invoke-direct {p0, v3}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->append(I)V

    .line 409
    :goto_1
    const/16 v3, 0x8

    if-gt v1, v3, :cond_1

    .line 410
    mul-int/lit8 v3, v0, 0xa

    .line 411
    .restart local v3    # "t":I
    ushr-int/lit8 v4, v3, 0x1c

    invoke-direct {p0, v4}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->appendDigit(I)V

    .line 412
    and-int v0, v3, v2

    .line 409
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 414
    .end local v3    # "t":I
    :cond_1
    invoke-direct {p0, p3}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->lowDigits(I)V

    .line 415
    const/4 v2, 0x0

    return v2
.end method

.method private toChars2(IIII)I
    .locals 2
    .param p1, "h"    # I
    .param p2, "m"    # I
    .param p3, "l"    # I
    .param p4, "e"    # I

    .line 420
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->appendDigit(I)V

    .line 421
    const/16 v1, 0x2e

    invoke-direct {p0, v1}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->append(I)V

    .line 422
    :goto_0
    if-gez p4, :cond_0

    .line 423
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->appendDigit(I)V

    .line 422
    add-int/lit8 p4, p4, 0x1

    goto :goto_0

    .line 425
    :cond_0
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->appendDigit(I)V

    .line 426
    invoke-direct {p0, p2}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->append8Digits(I)V

    .line 427
    invoke-direct {p0, p3}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->lowDigits(I)V

    .line 428
    return v0
.end method

.method private toChars3(IIII)I
    .locals 1
    .param p1, "h"    # I
    .param p2, "m"    # I
    .param p3, "l"    # I
    .param p4, "e"    # I

    .line 433
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->appendDigit(I)V

    .line 434
    const/16 v0, 0x2e

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->append(I)V

    .line 435
    invoke-direct {p0, p2}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->append8Digits(I)V

    .line 436
    invoke-direct {p0, p3}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->lowDigits(I)V

    .line 437
    add-int/lit8 v0, p4, -0x1

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->exponent(I)V

    .line 438
    const/4 v0, 0x0

    return v0
.end method

.method private toDecimal(D)I
    .locals 15
    .param p1, "v"    # D

    .line 203
    move-object v0, p0

    invoke-static/range {p1 .. p2}, Ljava/lang/Double;->doubleToRawLongBits(D)J

    move-result-wide v1

    .line 204
    .local v1, "bits":J
    const-wide v3, 0xfffffffffffffL

    and-long/2addr v3, v1

    .line 205
    .local v3, "t":J
    const/16 v5, 0x34

    ushr-long v5, v1, v5

    long-to-int v5, v5

    const/16 v6, 0x7ff

    and-int/2addr v5, v6

    .line 206
    .local v5, "bq":I
    const-wide/16 v7, 0x0

    if-ge v5, v6, :cond_8

    .line 207
    const/4 v6, -0x1

    iput v6, v0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->index:I

    .line 208
    cmp-long v9, v1, v7

    if-gez v9, :cond_0

    .line 209
    const/16 v9, 0x2d

    invoke-direct {p0, v9}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->append(I)V

    .line 211
    :cond_0
    const/4 v9, 0x1

    const/4 v10, 0x0

    if-eqz v5, :cond_4

    .line 213
    rsub-int v6, v5, 0x433

    .line 214
    .local v6, "mq":I
    const-wide/high16 v7, 0x10000000000000L

    or-long/2addr v7, v3

    .line 216
    .local v7, "c":J
    if-lez v6, :cond_1

    move v11, v9

    goto :goto_0

    :cond_1
    move v11, v10

    :goto_0
    const/16 v12, 0x35

    if-ge v6, v12, :cond_2

    goto :goto_1

    :cond_2
    move v9, v10

    :goto_1
    and-int/2addr v9, v11

    if-eqz v9, :cond_3

    .line 217
    shr-long v11, v7, v6

    .line 218
    .local v11, "f":J
    shl-long v13, v11, v6

    cmp-long v9, v13, v7

    if-nez v9, :cond_3

    .line 219
    invoke-direct {p0, v11, v12, v10}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->toChars(JI)I

    move-result v9

    return v9

    .line 222
    .end local v11    # "f":J
    :cond_3
    neg-int v9, v6

    invoke-direct {p0, v9, v7, v8, v10}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->toDecimal(IJI)I

    move-result v9

    return v9

    .line 224
    .end local v6    # "mq":I
    .end local v7    # "c":J
    :cond_4
    cmp-long v11, v3, v7

    if-eqz v11, :cond_6

    .line 226
    const-wide/16 v7, 0x3

    cmp-long v7, v3, v7

    const/16 v8, -0x432

    if-gez v7, :cond_5

    const-wide/16 v9, 0xa

    mul-long/2addr v9, v3

    .line 227
    invoke-direct {p0, v8, v9, v10, v6}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->toDecimal(IJI)I

    move-result v6

    goto :goto_2

    :cond_5
    nop

    .line 228
    invoke-direct {p0, v8, v3, v4, v10}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->toDecimal(IJI)I

    move-result v6

    .line 226
    :goto_2
    return v6

    .line 230
    :cond_6
    cmp-long v6, v1, v7

    if-nez v6, :cond_7

    goto :goto_3

    :cond_7
    const/4 v9, 0x2

    :goto_3
    return v9

    .line 232
    :cond_8
    cmp-long v6, v3, v7

    if-eqz v6, :cond_9

    .line 233
    const/4 v6, 0x5

    return v6

    .line 235
    :cond_9
    cmp-long v6, v1, v7

    if-lez v6, :cond_a

    const/4 v6, 0x3

    goto :goto_4

    :cond_a
    const/4 v6, 0x4

    :goto_4
    return v6
.end method

.method private toDecimal(IJI)I
    .locals 38
    .param p1, "q"    # I
    .param p2, "c"    # J
    .param p4, "dk"    # I

    .line 256
    move-object/from16 v0, p0

    move/from16 v1, p1

    move-wide/from16 v2, p2

    long-to-int v4, v2

    const/4 v5, 0x1

    and-int/2addr v4, v5

    .line 257
    .local v4, "out":I
    const/4 v6, 0x2

    shl-long v7, v2, v6

    .line 258
    .local v7, "cb":J
    const-wide/16 v9, 0x2

    add-long v11, v7, v9

    .line 266
    .local v11, "cbr":J
    const-wide/high16 v13, 0x10000000000000L

    cmp-long v13, v2, v13

    if-eqz v13, :cond_0

    move v13, v5

    goto :goto_0

    :cond_0
    const/4 v13, 0x0

    :goto_0
    const/16 v15, -0x432

    if-ne v1, v15, :cond_1

    move v15, v5

    goto :goto_1

    :cond_1
    const/4 v15, 0x0

    :goto_1
    or-int/2addr v13, v15

    const-wide/16 v15, 0x1

    if-eqz v13, :cond_2

    .line 268
    sub-long v9, v7, v9

    .line 269
    .local v9, "cbl":J
    invoke-static/range {p1 .. p1}, Lcom/fasterxml/jackson/core/io/schubfach/MathUtils;->flog10pow2(I)I

    move-result v13

    .local v13, "k":I
    goto :goto_2

    .line 272
    .end local v9    # "cbl":J
    .end local v13    # "k":I
    :cond_2
    sub-long v9, v7, v15

    .line 273
    .restart local v9    # "cbl":J
    invoke-static/range {p1 .. p1}, Lcom/fasterxml/jackson/core/io/schubfach/MathUtils;->flog10threeQuartersPow2(I)I

    move-result v13

    .line 275
    .restart local v13    # "k":I
    :goto_2
    neg-int v14, v13

    invoke-static {v14}, Lcom/fasterxml/jackson/core/io/schubfach/MathUtils;->flog2pow10(I)I

    move-result v14

    add-int/2addr v14, v1

    add-int/2addr v14, v6

    .line 278
    .local v14, "h":I
    invoke-static {v13}, Lcom/fasterxml/jackson/core/io/schubfach/MathUtils;->g1(I)J

    move-result-wide v24

    .line 279
    .local v24, "g1":J
    invoke-static {v13}, Lcom/fasterxml/jackson/core/io/schubfach/MathUtils;->g0(I)J

    move-result-wide v26

    .line 281
    .local v26, "g0":J
    shl-long v22, v7, v14

    move-wide/from16 v18, v24

    move-wide/from16 v20, v26

    invoke-static/range {v18 .. v23}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->rop(JJJ)J

    move-result-wide v28

    .line 282
    .local v28, "vb":J
    shl-long v22, v9, v14

    invoke-static/range {v18 .. v23}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->rop(JJJ)J

    move-result-wide v30

    .line 283
    .local v30, "vbl":J
    shl-long v22, v11, v14

    invoke-static/range {v18 .. v23}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->rop(JJJ)J

    move-result-wide v18

    .line 285
    .local v18, "vbr":J
    shr-long v1, v28, v6

    .line 286
    .local v1, "s":J
    const-wide/16 v20, 0x64

    cmp-long v3, v1, v20

    if-ltz v3, :cond_7

    .line 298
    const-wide v5, 0x19999999999999a0L

    invoke-static {v1, v2, v5, v6}, Lcom/fasterxml/jackson/core/io/schubfach/MathUtils;->multiplyHigh(JJ)J

    move-result-wide v5

    const-wide/16 v21, 0xa

    mul-long v5, v5, v21

    .line 299
    .local v5, "sp10":J
    add-long v21, v5, v21

    .line 300
    .local v21, "tp10":J
    move-wide/from16 v32, v7

    .end local v7    # "cb":J
    .local v32, "cb":J
    int-to-long v7, v4

    add-long v7, v30, v7

    const/16 v20, 0x2

    shl-long v34, v5, v20

    cmp-long v7, v7, v34

    if-gtz v7, :cond_3

    const/4 v7, 0x1

    goto :goto_3

    :cond_3
    const/4 v7, 0x0

    .line 301
    .local v7, "upin":Z
    :goto_3
    shl-long v34, v21, v20

    move-wide/from16 v36, v5

    .end local v5    # "sp10":J
    .local v36, "sp10":J
    int-to-long v5, v4

    add-long v34, v34, v5

    cmp-long v5, v34, v18

    if-gtz v5, :cond_4

    const/4 v5, 0x1

    goto :goto_4

    :cond_4
    const/4 v5, 0x0

    .line 302
    .local v5, "wpin":Z
    :goto_4
    if-eq v7, v5, :cond_6

    .line 303
    move v8, v5

    if-eqz v7, :cond_5

    move-wide/from16 v5, v36

    goto :goto_5

    :cond_5
    move-wide/from16 v5, v21

    .end local v5    # "wpin":Z
    .local v8, "wpin":Z
    :goto_5
    invoke-direct {v0, v5, v6, v13}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->toChars(JI)I

    move-result v3

    return v3

    .line 302
    .end local v8    # "wpin":Z
    .restart local v5    # "wpin":Z
    :cond_6
    move v8, v5

    .end local v5    # "wpin":Z
    .restart local v8    # "wpin":Z
    goto :goto_6

    .line 286
    .end local v8    # "wpin":Z
    .end local v21    # "tp10":J
    .end local v32    # "cb":J
    .end local v36    # "sp10":J
    .local v7, "cb":J
    :cond_7
    move-wide/from16 v32, v7

    .line 313
    .end local v7    # "cb":J
    .restart local v32    # "cb":J
    :goto_6
    add-long v5, v1, v15

    .line 314
    .local v5, "t":J
    int-to-long v7, v4

    add-long v7, v30, v7

    const/16 v20, 0x2

    shl-long v21, v1, v20

    cmp-long v7, v7, v21

    if-gtz v7, :cond_8

    const/4 v7, 0x1

    goto :goto_7

    :cond_8
    const/4 v7, 0x0

    .line 315
    .local v7, "uin":Z
    :goto_7
    shl-long v20, v5, v20

    move-wide/from16 v22, v9

    .end local v9    # "cbl":J
    .local v22, "cbl":J
    int-to-long v8, v4

    add-long v20, v20, v8

    cmp-long v8, v20, v18

    if-gtz v8, :cond_9

    const/16 v17, 0x1

    goto :goto_8

    :cond_9
    const/16 v17, 0x0

    :goto_8
    move/from16 v8, v17

    .line 316
    .local v8, "win":Z
    if-eq v7, v8, :cond_b

    .line 318
    if-eqz v7, :cond_a

    move-wide v9, v1

    goto :goto_9

    :cond_a
    move-wide v9, v5

    :goto_9
    add-int v3, v13, p4

    invoke-direct {v0, v9, v10, v3}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->toChars(JI)I

    move-result v3

    return v3

    .line 324
    :cond_b
    add-long v9, v1, v5

    const/4 v3, 0x1

    shl-long/2addr v9, v3

    sub-long v9, v28, v9

    .line 325
    .local v9, "cmp":J
    const-wide/16 v20, 0x0

    cmp-long v3, v9, v20

    if-ltz v3, :cond_d

    cmp-long v3, v9, v20

    if-nez v3, :cond_c

    and-long/2addr v15, v1

    cmp-long v3, v15, v20

    if-nez v3, :cond_c

    goto :goto_a

    :cond_c
    move-wide v15, v1

    move-wide v1, v5

    goto :goto_b

    :cond_d
    :goto_a
    move-wide v15, v1

    .end local v1    # "s":J
    .local v15, "s":J
    :goto_b
    add-int v3, v13, p4

    invoke-direct {v0, v1, v2, v3}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->toChars(JI)I

    move-result v1

    return v1
.end method

.method private toDecimalString(D)Ljava/lang/String;
    .locals 1
    .param p1, "v"    # D

    .line 149
    invoke-direct {p0, p1, p2}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->toDecimal(D)I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 155
    const-string v0, "NaN"

    return-object v0

    .line 154
    :pswitch_0
    const-string v0, "-Infinity"

    return-object v0

    .line 153
    :pswitch_1
    const-string v0, "Infinity"

    return-object v0

    .line 152
    :pswitch_2
    const-string v0, "-0.0"

    return-object v0

    .line 151
    :pswitch_3
    const-string v0, "0.0"

    return-object v0

    .line 150
    :pswitch_4
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->charsToString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static toString(D)Ljava/lang/String;
    .locals 1
    .param p0, "v"    # D

    .line 129
    new-instance v0, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;

    invoke-direct {v0}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;-><init>()V

    invoke-direct {v0, p0, p1}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->toDecimalString(D)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private y(I)I
    .locals 4
    .param p1, "a"    # I

    .line 480
    add-int/lit8 v0, p1, 0x1

    int-to-long v0, v0

    const/16 v2, 0x1c

    shl-long/2addr v0, v2

    const-wide v2, 0x2af31dc4611873cL    # 9.53972865917246E-296

    invoke-static {v0, v1, v2, v3}, Lcom/fasterxml/jackson/core/io/schubfach/MathUtils;->multiplyHigh(JJ)J

    move-result-wide v0

    const/16 v2, 0x14

    ushr-long/2addr v0, v2

    long-to-int v0, v0

    add-int/lit8 v0, v0, -0x1

    return v0
.end method
