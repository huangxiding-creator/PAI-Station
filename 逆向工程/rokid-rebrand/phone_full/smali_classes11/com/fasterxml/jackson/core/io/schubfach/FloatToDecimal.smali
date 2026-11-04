.class public final Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;
.super Ljava/lang/Object;
.source "FloatToDecimal.java"


# static fields
.field private static final BQ_MASK:I = 0xff

.field private static final C_MIN:I = 0x800000

.field static final C_TINY:I = 0x8

.field static final E_MAX:I = 0x27

.field static final E_MIN:I = -0x2c

.field static final H:I = 0x9

.field static final K_MAX:I = 0x1f

.field static final K_MIN:I = -0x2d

.field private static final MASK_28:I = 0xfffffff

.field private static final MASK_32:J = 0xffffffffL

.field public static final MAX_CHARS:I = 0xf

.field private static final MINUS_INF:I = 0x4

.field private static final MINUS_ZERO:I = 0x2

.field private static final NAN:I = 0x5

.field private static final NON_SPECIAL:I = 0x0

.field static final P:I = 0x18

.field private static final PLUS_INF:I = 0x3

.field private static final PLUS_ZERO:I = 0x1

.field static final Q_MAX:I = 0x68

.field static final Q_MIN:I = -0x95

.field private static final T_MASK:I = 0x7fffff

.field private static final W:I = 0x8


# instance fields
.field private final bytes:[B

.field private index:I


# direct methods
.method private constructor <init>()V
    .locals 1

    .line 117
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 112
    const/16 v0, 0xf

    new-array v0, v0, [B

    iput-object v0, p0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->bytes:[B

    .line 118
    return-void
.end method

.method private append(I)V
    .locals 3
    .param p1, "c"    # I

    .line 488
    iget-object v0, p0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->bytes:[B

    iget v1, p0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->index:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->index:I

    int-to-byte v2, p1

    aput-byte v2, v0, v1

    .line 489
    return-void
.end method

.method private append8Digits(I)V
    .locals 4
    .param p1, "m"    # I

    .line 436
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->y(I)I

    move-result v0

    .line 437
    .local v0, "y":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    const/16 v2, 0x8

    if-ge v1, v2, :cond_0

    .line 438
    mul-int/lit8 v2, v0, 0xa

    .line 439
    .local v2, "t":I
    ushr-int/lit8 v3, v2, 0x1c

    invoke-direct {p0, v3}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->appendDigit(I)V

    .line 440
    const v3, 0xfffffff

    and-int v0, v2, v3

    .line 437
    .end local v2    # "t":I
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 442
    .end local v1    # "i":I
    :cond_0
    return-void
.end method

.method private appendDecimalTo(FLjava/lang/Appendable;)Ljava/lang/Appendable;
    .locals 4
    .param p1, "v"    # F
    .param p2, "app"    # Ljava/lang/Appendable;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 161
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->toDecimal(F)I

    move-result v0

    packed-switch v0, :pswitch_data_0

    .line 181
    const-string v0, "NaN"

    invoke-interface {p2, v0}, Ljava/lang/Appendable;->append(Ljava/lang/CharSequence;)Ljava/lang/Appendable;

    move-result-object v0

    return-object v0

    .line 180
    :pswitch_0
    const-string v0, "-Infinity"

    invoke-interface {p2, v0}, Ljava/lang/Appendable;->append(Ljava/lang/CharSequence;)Ljava/lang/Appendable;

    move-result-object v0

    return-object v0

    .line 179
    :pswitch_1
    const-string v0, "Infinity"

    invoke-interface {p2, v0}, Ljava/lang/Appendable;->append(Ljava/lang/CharSequence;)Ljava/lang/Appendable;

    move-result-object v0

    return-object v0

    .line 178
    :pswitch_2
    const-string v0, "-0.0"

    invoke-interface {p2, v0}, Ljava/lang/Appendable;->append(Ljava/lang/CharSequence;)Ljava/lang/Appendable;

    move-result-object v0

    return-object v0

    .line 177
    :pswitch_3
    const-string v0, "0.0"

    invoke-interface {p2, v0}, Ljava/lang/Appendable;->append(Ljava/lang/CharSequence;)Ljava/lang/Appendable;

    move-result-object v0

    return-object v0

    .line 163
    :pswitch_4
    iget v0, p0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->index:I

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
    iget-object v2, p0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->bytes:[B

    aget-byte v2, v2, v1

    int-to-char v2, v2

    aput-char v2, v0, v1

    .line 164
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 167
    .end local v1    # "i":I
    :cond_0
    instance-of v1, p2, Ljava/lang/StringBuilder;

    if-eqz v1, :cond_1

    .line 168
    move-object v1, p2

    check-cast v1, Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append([C)Ljava/lang/StringBuilder;

    move-result-object v1

    return-object v1

    .line 170
    :cond_1
    instance-of v1, p2, Ljava/lang/StringBuffer;

    if-eqz v1, :cond_2

    .line 171
    move-object v1, p2

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
    invoke-interface {p2, v3}, Ljava/lang/Appendable;->append(C)Ljava/lang/Appendable;

    .line 173
    .end local v3    # "c":C
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 176
    :cond_3
    return-object p2

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

    .line 492
    iget-object v0, p0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->bytes:[B

    iget v1, p0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->index:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->index:I

    add-int/lit8 v2, p1, 0x30

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 493
    return-void
.end method

.method public static appendTo(FLjava/lang/Appendable;)Ljava/lang/Appendable;
    .locals 1
    .param p0, "v"    # F
    .param p1, "app"    # Ljava/lang/Appendable;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 145
    new-instance v0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;

    invoke-direct {v0}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;-><init>()V

    invoke-direct {v0, p0, p1}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->appendDecimalTo(FLjava/lang/Appendable;)Ljava/lang/Appendable;

    move-result-object v0

    return-object v0
.end method

.method private charsToString()Ljava/lang/String;
    .locals 4

    .line 498
    new-instance v0, Ljava/lang/String;

    iget-object v1, p0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->bytes:[B

    iget v2, p0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->index:I

    add-int/lit8 v2, v2, 0x1

    const/4 v3, 0x0

    invoke-direct {v0, v1, v3, v3, v2}, Ljava/lang/String;-><init>([BIII)V

    return-object v0
.end method

.method private exponent(I)V
    .locals 2
    .param p1, "e"    # I

    .line 469
    const/16 v0, 0x45

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->append(I)V

    .line 470
    if-gez p1, :cond_0

    .line 471
    const/16 v0, 0x2d

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->append(I)V

    .line 472
    neg-int p1, p1

    .line 474
    :cond_0
    const/16 v0, 0xa

    if-ge p1, v0, :cond_1

    .line 475
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->appendDigit(I)V

    .line 476
    return-void

    .line 482
    :cond_1
    mul-int/lit8 v1, p1, 0x67

    ushr-int/lit8 v0, v1, 0xa

    .line 483
    .local v0, "d":I
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->appendDigit(I)V

    .line 484
    mul-int/lit8 v1, v0, 0xa

    sub-int v1, p1, v1

    invoke-direct {p0, v1}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->appendDigit(I)V

    .line 485
    return-void
.end method

.method private removeTrailingZeroes()V
    .locals 2

    .line 445
    nop

    :goto_0
    iget-object v0, p0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->bytes:[B

    iget v1, p0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->index:I

    aget-byte v0, v0, v1

    const/16 v1, 0x30

    if-ne v0, v1, :cond_0

    .line 446
    iget v0, p0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->index:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->index:I

    goto :goto_0

    .line 449
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->bytes:[B

    iget v1, p0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->index:I

    aget-byte v0, v0, v1

    const/16 v1, 0x2e

    if-ne v0, v1, :cond_1

    .line 450
    iget v0, p0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->index:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->index:I

    .line 452
    :cond_1
    return-void
.end method

.method private static rop(JJ)I
    .locals 8
    .param p0, "g"    # J
    .param p2, "cp"    # J

    .line 332
    invoke-static {p0, p1, p2, p3}, Lcom/fasterxml/jackson/core/io/schubfach/MathUtils;->multiplyHigh(JJ)J

    move-result-wide v0

    .line 333
    .local v0, "x1":J
    const/16 v2, 0x1f

    ushr-long v2, v0, v2

    .line 334
    .local v2, "vbp":J
    const-wide v4, 0xffffffffL

    and-long v6, v0, v4

    add-long/2addr v6, v4

    const/16 v4, 0x20

    ushr-long v4, v6, v4

    or-long/2addr v4, v2

    long-to-int v4, v4

    return v4
.end method

.method private toChars(II)I
    .locals 5
    .param p1, "f"    # I
    .param p2, "e"    # I

    .line 347
    invoke-static {p1}, Ljava/lang/Integer;->numberOfLeadingZeros(I)I

    move-result v0

    rsub-int/lit8 v0, v0, 0x20

    invoke-static {v0}, Lcom/fasterxml/jackson/core/io/schubfach/MathUtils;->flog10pow2(I)I

    move-result v0

    .line 348
    .local v0, "len":I
    int-to-long v1, p1

    invoke-static {v0}, Lcom/fasterxml/jackson/core/io/schubfach/MathUtils;->pow10(I)J

    move-result-wide v3

    cmp-long v1, v1, v3

    if-ltz v1, :cond_0

    .line 349
    add-int/lit8 v0, v0, 0x1

    .line 358
    :cond_0
    rsub-int/lit8 v1, v0, 0x9

    invoke-static {v1}, Lcom/fasterxml/jackson/core/io/schubfach/MathUtils;->pow10(I)J

    move-result-wide v1

    long-to-int v1, v1

    mul-int/2addr p1, v1

    .line 359
    add-int/2addr p2, v0

    .line 371
    int-to-long v1, p1

    const-wide/32 v3, 0x55e63b89

    mul-long/2addr v1, v3

    const/16 v3, 0x39

    ushr-long/2addr v1, v3

    long-to-int v1, v1

    .line 372
    .local v1, "h":I
    const v2, 0x5f5e100

    mul-int/2addr v2, v1

    sub-int v2, p1, v2

    .line 374
    .local v2, "l":I
    if-lez p2, :cond_1

    const/4 v3, 0x7

    if-gt p2, v3, :cond_1

    .line 375
    invoke-direct {p0, v1, v2, p2}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->toChars1(III)I

    move-result v3

    return v3

    .line 377
    :cond_1
    const/4 v3, -0x3

    if-ge v3, p2, :cond_2

    if-gtz p2, :cond_2

    .line 378
    invoke-direct {p0, v1, v2, p2}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->toChars2(III)I

    move-result v3

    return v3

    .line 380
    :cond_2
    invoke-direct {p0, v1, v2, p2}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->toChars3(III)I

    move-result v3

    return v3
.end method

.method private toChars1(III)I
    .locals 5
    .param p1, "h"    # I
    .param p2, "l"    # I
    .param p3, "e"    # I

    .line 389
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->appendDigit(I)V

    .line 390
    invoke-direct {p0, p2}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->y(I)I

    move-result v0

    .line 392
    .local v0, "y":I
    const/4 v1, 0x1

    .line 393
    .local v1, "i":I
    :goto_0
    const v2, 0xfffffff

    if-ge v1, p3, :cond_0

    .line 394
    mul-int/lit8 v3, v0, 0xa

    .line 395
    .local v3, "t":I
    ushr-int/lit8 v4, v3, 0x1c

    invoke-direct {p0, v4}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->appendDigit(I)V

    .line 396
    and-int v0, v3, v2

    .line 393
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 398
    .end local v3    # "t":I
    :cond_0
    const/16 v3, 0x2e

    invoke-direct {p0, v3}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->append(I)V

    .line 399
    :goto_1
    const/16 v3, 0x8

    if-gt v1, v3, :cond_1

    .line 400
    mul-int/lit8 v3, v0, 0xa

    .line 401
    .restart local v3    # "t":I
    ushr-int/lit8 v4, v3, 0x1c

    invoke-direct {p0, v4}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->appendDigit(I)V

    .line 402
    and-int v0, v3, v2

    .line 399
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 404
    .end local v3    # "t":I
    :cond_1
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->removeTrailingZeroes()V

    .line 405
    const/4 v2, 0x0

    return v2
.end method

.method private toChars2(III)I
    .locals 2
    .param p1, "h"    # I
    .param p2, "l"    # I
    .param p3, "e"    # I

    .line 410
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->appendDigit(I)V

    .line 411
    const/16 v1, 0x2e

    invoke-direct {p0, v1}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->append(I)V

    .line 412
    :goto_0
    if-gez p3, :cond_0

    .line 413
    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->appendDigit(I)V

    .line 412
    add-int/lit8 p3, p3, 0x1

    goto :goto_0

    .line 415
    :cond_0
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->appendDigit(I)V

    .line 416
    invoke-direct {p0, p2}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->append8Digits(I)V

    .line 417
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->removeTrailingZeroes()V

    .line 418
    return v0
.end method

.method private toChars3(III)I
    .locals 1
    .param p1, "h"    # I
    .param p2, "l"    # I
    .param p3, "e"    # I

    .line 423
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->appendDigit(I)V

    .line 424
    const/16 v0, 0x2e

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->append(I)V

    .line 425
    invoke-direct {p0, p2}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->append8Digits(I)V

    .line 426
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->removeTrailingZeroes()V

    .line 427
    add-int/lit8 v0, p3, -0x1

    invoke-direct {p0, v0}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->exponent(I)V

    .line 428
    const/4 v0, 0x0

    return v0
.end method

.method private toDecimal(F)I
    .locals 9
    .param p1, "v"    # F

    .line 203
    invoke-static {p1}, Ljava/lang/Float;->floatToRawIntBits(F)I

    move-result v0

    .line 204
    .local v0, "bits":I
    const v1, 0x7fffff

    and-int/2addr v1, v0

    .line 205
    .local v1, "t":I
    ushr-int/lit8 v2, v0, 0x17

    const/16 v3, 0xff

    and-int/2addr v2, v3

    .line 206
    .local v2, "bq":I
    if-ge v2, v3, :cond_8

    .line 207
    const/4 v3, -0x1

    iput v3, p0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->index:I

    .line 208
    if-gez v0, :cond_0

    .line 209
    const/16 v4, 0x2d

    invoke-direct {p0, v4}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->append(I)V

    .line 211
    :cond_0
    const/4 v4, 0x1

    const/4 v5, 0x0

    if-eqz v2, :cond_4

    .line 213
    rsub-int v3, v2, 0x96

    .line 214
    .local v3, "mq":I
    const/high16 v6, 0x800000

    or-int/2addr v6, v1

    .line 216
    .local v6, "c":I
    if-lez v3, :cond_1

    move v7, v4

    goto :goto_0

    :cond_1
    move v7, v5

    :goto_0
    const/16 v8, 0x18

    if-ge v3, v8, :cond_2

    goto :goto_1

    :cond_2
    move v4, v5

    :goto_1
    and-int/2addr v4, v7

    if-eqz v4, :cond_3

    .line 217
    shr-int v4, v6, v3

    .line 218
    .local v4, "f":I
    shl-int v7, v4, v3

    if-ne v7, v6, :cond_3

    .line 219
    invoke-direct {p0, v4, v5}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->toChars(II)I

    move-result v5

    return v5

    .line 222
    .end local v4    # "f":I
    :cond_3
    neg-int v4, v3

    invoke-direct {p0, v4, v6, v5}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->toDecimal(III)I

    move-result v4

    return v4

    .line 224
    .end local v3    # "mq":I
    .end local v6    # "c":I
    :cond_4
    if-eqz v1, :cond_6

    .line 226
    const/16 v4, 0x8

    const/16 v6, -0x95

    if-ge v1, v4, :cond_5

    mul-int/lit8 v4, v1, 0xa

    .line 227
    invoke-direct {p0, v6, v4, v3}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->toDecimal(III)I

    move-result v3

    goto :goto_2

    :cond_5
    nop

    .line 228
    invoke-direct {p0, v6, v1, v5}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->toDecimal(III)I

    move-result v3

    .line 226
    :goto_2
    return v3

    .line 230
    :cond_6
    if-nez v0, :cond_7

    goto :goto_3

    :cond_7
    const/4 v4, 0x2

    :goto_3
    return v4

    .line 232
    :cond_8
    if-eqz v1, :cond_9

    .line 233
    const/4 v3, 0x5

    return v3

    .line 235
    :cond_9
    if-lez v0, :cond_a

    const/4 v3, 0x3

    goto :goto_4

    :cond_a
    const/4 v3, 0x4

    :goto_4
    return v3
.end method

.method private toDecimal(III)I
    .locals 24
    .param p1, "q"    # I
    .param p2, "c"    # I
    .param p3, "dk"    # I

    .line 257
    move-object/from16 v0, p0

    move/from16 v1, p1

    move/from16 v2, p2

    and-int/lit8 v3, v2, 0x1

    .line 258
    .local v3, "out":I
    shl-int/lit8 v4, v2, 0x2

    int-to-long v4, v4

    .line 259
    .local v4, "cb":J
    const-wide/16 v6, 0x2

    add-long v8, v4, v6

    .line 267
    .local v8, "cbr":J
    const/high16 v10, 0x800000

    if-eq v2, v10, :cond_0

    const/4 v10, 0x1

    goto :goto_0

    :cond_0
    const/4 v10, 0x0

    :goto_0
    const/16 v13, -0x95

    if-ne v1, v13, :cond_1

    const/4 v13, 0x1

    goto :goto_1

    :cond_1
    const/4 v13, 0x0

    :goto_1
    or-int/2addr v10, v13

    const-wide/16 v13, 0x1

    if-eqz v10, :cond_2

    .line 269
    sub-long v6, v4, v6

    .line 270
    .local v6, "cbl":J
    invoke-static/range {p1 .. p1}, Lcom/fasterxml/jackson/core/io/schubfach/MathUtils;->flog10pow2(I)I

    move-result v10

    .local v10, "k":I
    goto :goto_2

    .line 273
    .end local v6    # "cbl":J
    .end local v10    # "k":I
    :cond_2
    sub-long v6, v4, v13

    .line 274
    .restart local v6    # "cbl":J
    invoke-static/range {p1 .. p1}, Lcom/fasterxml/jackson/core/io/schubfach/MathUtils;->flog10threeQuartersPow2(I)I

    move-result v10

    .line 276
    .restart local v10    # "k":I
    :goto_2
    neg-int v15, v10

    invoke-static {v15}, Lcom/fasterxml/jackson/core/io/schubfach/MathUtils;->flog2pow10(I)I

    move-result v15

    add-int/2addr v15, v1

    add-int/lit8 v15, v15, 0x21

    .line 279
    .local v15, "h":I
    invoke-static {v10}, Lcom/fasterxml/jackson/core/io/schubfach/MathUtils;->g1(I)J

    move-result-wide v16

    add-long v13, v16, v13

    .line 281
    .local v13, "g":J
    shl-long v11, v4, v15

    invoke-static {v13, v14, v11, v12}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->rop(JJ)I

    move-result v11

    .line 282
    .local v11, "vb":I
    shl-long v1, v6, v15

    invoke-static {v13, v14, v1, v2}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->rop(JJ)I

    move-result v1

    .line 283
    .local v1, "vbl":I
    move-wide/from16 v18, v4

    .end local v4    # "cb":J
    .local v18, "cb":J
    shl-long v4, v8, v15

    invoke-static {v13, v14, v4, v5}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->rop(JJ)I

    move-result v2

    .line 285
    .local v2, "vbr":I
    shr-int/lit8 v4, v11, 0x2

    .line 286
    .local v4, "s":I
    const/16 v5, 0x64

    if-lt v4, v5, :cond_7

    .line 297
    move-wide/from16 v20, v6

    .end local v6    # "cbl":J
    .local v20, "cbl":J
    int-to-long v5, v4

    const-wide/32 v22, 0x66666667

    mul-long v5, v5, v22

    const/16 v7, 0x22

    ushr-long/2addr v5, v7

    long-to-int v5, v5

    mul-int/lit8 v5, v5, 0xa

    .line 298
    .local v5, "sp10":I
    add-int/lit8 v6, v5, 0xa

    .line 299
    .local v6, "tp10":I
    add-int v7, v1, v3

    shl-int/lit8 v12, v5, 0x2

    if-gt v7, v12, :cond_3

    const/4 v7, 0x1

    goto :goto_3

    :cond_3
    const/4 v7, 0x0

    .line 300
    .local v7, "upin":Z
    :goto_3
    shl-int/lit8 v12, v6, 0x2

    add-int/2addr v12, v3

    if-gt v12, v2, :cond_4

    const/4 v12, 0x1

    goto :goto_4

    :cond_4
    const/4 v12, 0x0

    .line 301
    .local v12, "wpin":Z
    :goto_4
    if-eq v7, v12, :cond_6

    .line 302
    move/from16 v22, v5

    if-eqz v7, :cond_5

    goto :goto_5

    :cond_5
    move v5, v6

    .end local v5    # "sp10":I
    .local v22, "sp10":I
    :goto_5
    invoke-direct {v0, v5, v10}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->toChars(II)I

    move-result v5

    return v5

    .line 301
    .end local v22    # "sp10":I
    .restart local v5    # "sp10":I
    :cond_6
    move/from16 v22, v5

    .end local v5    # "sp10":I
    .restart local v22    # "sp10":I
    goto :goto_6

    .line 286
    .end local v7    # "upin":Z
    .end local v12    # "wpin":Z
    .end local v20    # "cbl":J
    .end local v22    # "sp10":I
    .local v6, "cbl":J
    :cond_7
    move-wide/from16 v20, v6

    .line 312
    .end local v6    # "cbl":J
    .restart local v20    # "cbl":J
    :goto_6
    add-int/lit8 v5, v4, 0x1

    .line 313
    .local v5, "t":I
    add-int v6, v1, v3

    shl-int/lit8 v7, v4, 0x2

    if-gt v6, v7, :cond_8

    const/4 v6, 0x1

    goto :goto_7

    :cond_8
    const/4 v6, 0x0

    .line 314
    .local v6, "uin":Z
    :goto_7
    shl-int/lit8 v7, v5, 0x2

    add-int/2addr v7, v3

    if-gt v7, v2, :cond_9

    const/16 v16, 0x1

    goto :goto_8

    :cond_9
    const/16 v16, 0x0

    :goto_8
    move/from16 v7, v16

    .line 315
    .local v7, "win":Z
    if-eq v6, v7, :cond_b

    .line 317
    if-eqz v6, :cond_a

    move v12, v4

    goto :goto_9

    :cond_a
    move v12, v5

    :goto_9
    move/from16 v16, v1

    .end local v1    # "vbl":I
    .local v16, "vbl":I
    add-int v1, v10, p3

    invoke-direct {v0, v12, v1}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->toChars(II)I

    move-result v1

    return v1

    .line 323
    .end local v16    # "vbl":I
    .restart local v1    # "vbl":I
    :cond_b
    move/from16 v16, v1

    .end local v1    # "vbl":I
    .restart local v16    # "vbl":I
    add-int v1, v4, v5

    const/4 v12, 0x1

    shl-int/2addr v1, v12

    sub-int v1, v11, v1

    .line 324
    .local v1, "cmp":I
    if-ltz v1, :cond_d

    if-nez v1, :cond_c

    and-int/lit8 v12, v4, 0x1

    if-nez v12, :cond_c

    goto :goto_a

    :cond_c
    move v12, v5

    goto :goto_b

    :cond_d
    :goto_a
    move v12, v4

    :goto_b
    move/from16 v17, v1

    .end local v1    # "cmp":I
    .local v17, "cmp":I
    add-int v1, v10, p3

    invoke-direct {v0, v12, v1}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->toChars(II)I

    move-result v1

    return v1
.end method

.method private toDecimalString(F)Ljava/lang/String;
    .locals 1
    .param p1, "v"    # F

    .line 149
    invoke-direct {p0, p1}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->toDecimal(F)I

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
    invoke-direct {p0}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->charsToString()Ljava/lang/String;

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

.method public static toString(F)Ljava/lang/String;
    .locals 1
    .param p0, "v"    # F

    .line 129
    new-instance v0, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;

    invoke-direct {v0}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;-><init>()V

    invoke-direct {v0, p0}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->toDecimalString(F)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private y(I)I
    .locals 4
    .param p1, "a"    # I

    .line 463
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
