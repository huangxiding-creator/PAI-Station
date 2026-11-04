.class public final Lcom/fasterxml/jackson/core/io/NumberOutput;
.super Ljava/lang/Object;
.source "NumberOutput.java"


# static fields
.field private static BILLION:I

.field private static BILLION_L:J

.field private static MAX_INT_AS_LONG:J

.field private static MILLION:I

.field private static MIN_INT_AS_LONG:J

.field static final SMALLEST_INT:Ljava/lang/String;

.field static final SMALLEST_LONG:Ljava/lang/String;

.field private static final TRIPLET_TO_CHARS:[I

.field private static final sSmallIntStrs:[Ljava/lang/String;

.field private static final sSmallIntStrs2:[Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 13

    .line 8
    const v0, 0xf4240

    sput v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->MILLION:I

    .line 9
    const v0, 0x3b9aca00

    sput v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->BILLION:I

    .line 10
    const-wide/32 v0, 0x3b9aca00

    sput-wide v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->BILLION_L:J

    .line 12
    const-wide/32 v0, -0x80000000

    sput-wide v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->MIN_INT_AS_LONG:J

    .line 13
    const-wide/32 v0, 0x7fffffff

    sput-wide v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->MAX_INT_AS_LONG:J

    .line 15
    const/high16 v0, -0x80000000

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->SMALLEST_INT:Ljava/lang/String;

    .line 16
    const-wide/high16 v0, -0x8000000000000000L

    invoke-static {v0, v1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->SMALLEST_LONG:Ljava/lang/String;

    .line 24
    const/16 v0, 0x3e8

    new-array v0, v0, [I

    sput-object v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->TRIPLET_TO_CHARS:[I

    .line 29
    const/4 v0, 0x0

    .line 30
    .local v0, "fullIx":I
    const/4 v1, 0x0

    .local v1, "i1":I
    :goto_0
    const/16 v2, 0x8

    const/16 v3, 0xa

    if-ge v1, v3, :cond_2

    .line 31
    const/4 v4, 0x0

    .local v4, "i2":I
    :goto_1
    if-ge v4, v3, :cond_1

    .line 32
    const/4 v5, 0x0

    .local v5, "i3":I
    :goto_2
    if-ge v5, v3, :cond_0

    .line 33
    add-int/lit8 v6, v1, 0x30

    shl-int/lit8 v6, v6, 0x10

    add-int/lit8 v7, v4, 0x30

    shl-int/2addr v7, v2

    or-int/2addr v6, v7

    add-int/lit8 v7, v5, 0x30

    or-int/2addr v6, v7

    .line 36
    .local v6, "enc":I
    sget-object v7, Lcom/fasterxml/jackson/core/io/NumberOutput;->TRIPLET_TO_CHARS:[I

    add-int/lit8 v8, v0, 0x1

    .end local v0    # "fullIx":I
    .local v8, "fullIx":I
    aput v6, v7, v0

    .line 32
    .end local v6    # "enc":I
    add-int/lit8 v5, v5, 0x1

    move v0, v8

    goto :goto_2

    .line 31
    .end local v5    # "i3":I
    .end local v8    # "fullIx":I
    .restart local v0    # "fullIx":I
    :cond_0
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 30
    .end local v4    # "i2":I
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 42
    .end local v0    # "fullIx":I
    .end local v1    # "i1":I
    :cond_2
    const/16 v0, 0xb

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "0"

    const/4 v4, 0x0

    aput-object v1, v0, v4

    const-string v1, "1"

    const/4 v5, 0x1

    aput-object v1, v0, v5

    const-string v1, "2"

    const/4 v6, 0x2

    aput-object v1, v0, v6

    const-string v1, "3"

    const/4 v7, 0x3

    aput-object v1, v0, v7

    const-string v1, "4"

    const/4 v8, 0x4

    aput-object v1, v0, v8

    const-string v1, "5"

    const/4 v9, 0x5

    aput-object v1, v0, v9

    const-string v1, "6"

    const/4 v10, 0x6

    aput-object v1, v0, v10

    const-string v1, "7"

    const/4 v11, 0x7

    aput-object v1, v0, v11

    const-string v1, "8"

    aput-object v1, v0, v2

    const-string v1, "9"

    const/16 v12, 0x9

    aput-object v1, v0, v12

    const-string v1, "10"

    aput-object v1, v0, v3

    sput-object v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->sSmallIntStrs:[Ljava/lang/String;

    .line 45
    new-array v0, v3, [Ljava/lang/String;

    const-string v1, "-1"

    aput-object v1, v0, v4

    const-string v1, "-2"

    aput-object v1, v0, v5

    const-string v1, "-3"

    aput-object v1, v0, v6

    const-string v1, "-4"

    aput-object v1, v0, v7

    const-string v1, "-5"

    aput-object v1, v0, v8

    const-string v1, "-6"

    aput-object v1, v0, v9

    const-string v1, "-7"

    aput-object v1, v0, v10

    const-string v1, "-8"

    aput-object v1, v0, v11

    const-string v1, "-9"

    aput-object v1, v0, v2

    const-string v1, "-10"

    aput-object v1, v0, v12

    sput-object v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->sSmallIntStrs2:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static _full3(I[BI)I
    .locals 3
    .param p0, "t"    # I
    .param p1, "b"    # [B
    .param p2, "off"    # I

    .line 541
    sget-object v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->TRIPLET_TO_CHARS:[I

    aget v0, v0, p0

    .line 542
    .local v0, "enc":I
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "off":I
    .local v1, "off":I
    shr-int/lit8 v2, v0, 0x10

    int-to-byte v2, v2

    aput-byte v2, p1, p2

    .line 543
    add-int/lit8 p2, v1, 0x1

    .end local v1    # "off":I
    .restart local p2    # "off":I
    shr-int/lit8 v2, v0, 0x8

    int-to-byte v2, v2

    aput-byte v2, p1, v1

    .line 544
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "off":I
    .restart local v1    # "off":I
    int-to-byte v2, v0

    aput-byte v2, p1, p2

    .line 545
    return v1
.end method

.method private static _full3(I[CI)I
    .locals 3
    .param p0, "t"    # I
    .param p1, "b"    # [C
    .param p2, "off"    # I

    .line 532
    sget-object v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->TRIPLET_TO_CHARS:[I

    aget v0, v0, p0

    .line 533
    .local v0, "enc":I
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "off":I
    .local v1, "off":I
    shr-int/lit8 v2, v0, 0x10

    int-to-char v2, v2

    aput-char v2, p1, p2

    .line 534
    add-int/lit8 p2, v1, 0x1

    .end local v1    # "off":I
    .restart local p2    # "off":I
    shr-int/lit8 v2, v0, 0x8

    and-int/lit8 v2, v2, 0x7f

    int-to-char v2, v2

    aput-char v2, p1, v1

    .line 535
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "off":I
    .restart local v1    # "off":I
    and-int/lit8 v2, v0, 0x7f

    int-to-char v2, v2

    aput-char v2, p1, p2

    .line 536
    return v1
.end method

.method private static _leading3(I[BI)I
    .locals 3
    .param p0, "t"    # I
    .param p1, "b"    # [B
    .param p2, "off"    # I

    .line 519
    sget-object v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->TRIPLET_TO_CHARS:[I

    aget v0, v0, p0

    .line 520
    .local v0, "enc":I
    const/16 v1, 0x9

    if-le p0, v1, :cond_1

    .line 521
    const/16 v1, 0x63

    if-le p0, v1, :cond_0

    .line 522
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "off":I
    .local v1, "off":I
    shr-int/lit8 v2, v0, 0x10

    int-to-byte v2, v2

    aput-byte v2, p1, p2

    move p2, v1

    .line 524
    .end local v1    # "off":I
    .restart local p2    # "off":I
    :cond_0
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "off":I
    .restart local v1    # "off":I
    shr-int/lit8 v2, v0, 0x8

    int-to-byte v2, v2

    aput-byte v2, p1, p2

    move p2, v1

    .line 526
    .end local v1    # "off":I
    .restart local p2    # "off":I
    :cond_1
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "off":I
    .restart local v1    # "off":I
    int-to-byte v2, v0

    aput-byte v2, p1, p2

    .line 527
    return v1
.end method

.method private static _leading3(I[CI)I
    .locals 3
    .param p0, "t"    # I
    .param p1, "b"    # [C
    .param p2, "off"    # I

    .line 506
    sget-object v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->TRIPLET_TO_CHARS:[I

    aget v0, v0, p0

    .line 507
    .local v0, "enc":I
    const/16 v1, 0x9

    if-le p0, v1, :cond_1

    .line 508
    const/16 v1, 0x63

    if-le p0, v1, :cond_0

    .line 509
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "off":I
    .local v1, "off":I
    shr-int/lit8 v2, v0, 0x10

    int-to-char v2, v2

    aput-char v2, p1, p2

    move p2, v1

    .line 511
    .end local v1    # "off":I
    .restart local p2    # "off":I
    :cond_0
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "off":I
    .restart local v1    # "off":I
    shr-int/lit8 v2, v0, 0x8

    and-int/lit8 v2, v2, 0x7f

    int-to-char v2, v2

    aput-char v2, p1, p2

    move p2, v1

    .line 513
    .end local v1    # "off":I
    .restart local p2    # "off":I
    :cond_1
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "off":I
    .restart local v1    # "off":I
    and-int/lit8 v2, v0, 0x7f

    int-to-char v2, v2

    aput-char v2, p1, p2

    .line 514
    return v1
.end method

.method private static _outputFullBillion(I[BI)I
    .locals 6
    .param p0, "v"    # I
    .param p1, "b"    # [B
    .param p2, "off"    # I

    .line 445
    div-int/lit16 v0, p0, 0x3e8

    .line 446
    .local v0, "thousands":I
    mul-int/lit16 v1, v0, 0x3e8

    sub-int v1, p0, v1

    .line 447
    .local v1, "ones":I
    div-int/lit16 v2, v0, 0x3e8

    .line 448
    .local v2, "millions":I
    mul-int/lit16 v3, v2, 0x3e8

    sub-int/2addr v0, v3

    .line 450
    sget-object v3, Lcom/fasterxml/jackson/core/io/NumberOutput;->TRIPLET_TO_CHARS:[I

    aget v3, v3, v2

    .line 451
    .local v3, "enc":I
    add-int/lit8 v4, p2, 0x1

    .end local p2    # "off":I
    .local v4, "off":I
    shr-int/lit8 v5, v3, 0x10

    int-to-byte v5, v5

    aput-byte v5, p1, p2

    .line 452
    add-int/lit8 p2, v4, 0x1

    .end local v4    # "off":I
    .restart local p2    # "off":I
    shr-int/lit8 v5, v3, 0x8

    int-to-byte v5, v5

    aput-byte v5, p1, v4

    .line 453
    add-int/lit8 v4, p2, 0x1

    .end local p2    # "off":I
    .restart local v4    # "off":I
    int-to-byte v5, v3

    aput-byte v5, p1, p2

    .line 455
    sget-object p2, Lcom/fasterxml/jackson/core/io/NumberOutput;->TRIPLET_TO_CHARS:[I

    aget p2, p2, v0

    .line 456
    .end local v3    # "enc":I
    .local p2, "enc":I
    add-int/lit8 v3, v4, 0x1

    .end local v4    # "off":I
    .local v3, "off":I
    shr-int/lit8 v5, p2, 0x10

    int-to-byte v5, v5

    aput-byte v5, p1, v4

    .line 457
    add-int/lit8 v4, v3, 0x1

    .end local v3    # "off":I
    .restart local v4    # "off":I
    shr-int/lit8 v5, p2, 0x8

    int-to-byte v5, v5

    aput-byte v5, p1, v3

    .line 458
    add-int/lit8 v3, v4, 0x1

    .end local v4    # "off":I
    .restart local v3    # "off":I
    int-to-byte v5, p2

    aput-byte v5, p1, v4

    .line 460
    sget-object v4, Lcom/fasterxml/jackson/core/io/NumberOutput;->TRIPLET_TO_CHARS:[I

    aget p2, v4, v1

    .line 461
    add-int/lit8 v4, v3, 0x1

    .end local v3    # "off":I
    .restart local v4    # "off":I
    shr-int/lit8 v5, p2, 0x10

    int-to-byte v5, v5

    aput-byte v5, p1, v3

    .line 462
    add-int/lit8 v3, v4, 0x1

    .end local v4    # "off":I
    .restart local v3    # "off":I
    shr-int/lit8 v5, p2, 0x8

    int-to-byte v5, v5

    aput-byte v5, p1, v4

    .line 463
    add-int/lit8 v4, v3, 0x1

    .end local v3    # "off":I
    .restart local v4    # "off":I
    int-to-byte v5, p2

    aput-byte v5, p1, v3

    .line 465
    return v4
.end method

.method private static _outputFullBillion(I[CI)I
    .locals 6
    .param p0, "v"    # I
    .param p1, "b"    # [C
    .param p2, "off"    # I

    .line 390
    div-int/lit16 v0, p0, 0x3e8

    .line 391
    .local v0, "thousands":I
    mul-int/lit16 v1, v0, 0x3e8

    sub-int v1, p0, v1

    .line 392
    .local v1, "ones":I
    div-int/lit16 v2, v0, 0x3e8

    .line 394
    .local v2, "millions":I
    sget-object v3, Lcom/fasterxml/jackson/core/io/NumberOutput;->TRIPLET_TO_CHARS:[I

    aget v3, v3, v2

    .line 395
    .local v3, "enc":I
    add-int/lit8 v4, p2, 0x1

    .end local p2    # "off":I
    .local v4, "off":I
    shr-int/lit8 v5, v3, 0x10

    int-to-char v5, v5

    aput-char v5, p1, p2

    .line 396
    add-int/lit8 p2, v4, 0x1

    .end local v4    # "off":I
    .restart local p2    # "off":I
    shr-int/lit8 v5, v3, 0x8

    and-int/lit8 v5, v5, 0x7f

    int-to-char v5, v5

    aput-char v5, p1, v4

    .line 397
    add-int/lit8 v4, p2, 0x1

    .end local p2    # "off":I
    .restart local v4    # "off":I
    and-int/lit8 v5, v3, 0x7f

    int-to-char v5, v5

    aput-char v5, p1, p2

    .line 399
    mul-int/lit16 p2, v2, 0x3e8

    sub-int/2addr v0, p2

    .line 400
    sget-object p2, Lcom/fasterxml/jackson/core/io/NumberOutput;->TRIPLET_TO_CHARS:[I

    aget p2, p2, v0

    .line 401
    .end local v3    # "enc":I
    .local p2, "enc":I
    add-int/lit8 v3, v4, 0x1

    .end local v4    # "off":I
    .local v3, "off":I
    shr-int/lit8 v5, p2, 0x10

    int-to-char v5, v5

    aput-char v5, p1, v4

    .line 402
    add-int/lit8 v4, v3, 0x1

    .end local v3    # "off":I
    .restart local v4    # "off":I
    shr-int/lit8 v5, p2, 0x8

    and-int/lit8 v5, v5, 0x7f

    int-to-char v5, v5

    aput-char v5, p1, v3

    .line 403
    add-int/lit8 v3, v4, 0x1

    .end local v4    # "off":I
    .restart local v3    # "off":I
    and-int/lit8 v5, p2, 0x7f

    int-to-char v5, v5

    aput-char v5, p1, v4

    .line 405
    sget-object v4, Lcom/fasterxml/jackson/core/io/NumberOutput;->TRIPLET_TO_CHARS:[I

    aget p2, v4, v1

    .line 406
    add-int/lit8 v4, v3, 0x1

    .end local v3    # "off":I
    .restart local v4    # "off":I
    shr-int/lit8 v5, p2, 0x10

    int-to-char v5, v5

    aput-char v5, p1, v3

    .line 407
    add-int/lit8 v3, v4, 0x1

    .end local v4    # "off":I
    .restart local v3    # "off":I
    shr-int/lit8 v5, p2, 0x8

    and-int/lit8 v5, v5, 0x7f

    int-to-char v5, v5

    aput-char v5, p1, v4

    .line 408
    add-int/lit8 v4, v3, 0x1

    .end local v3    # "off":I
    .restart local v4    # "off":I
    and-int/lit8 v5, p2, 0x7f

    int-to-char v5, v5

    aput-char v5, p1, v3

    .line 410
    return v4
.end method

.method private static _outputSmallestI([BI)I
    .locals 4
    .param p0, "b"    # [B
    .param p1, "off"    # I

    .line 575
    sget-object v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->SMALLEST_INT:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    .line 576
    .local v0, "len":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v0, :cond_0

    .line 577
    add-int/lit8 v2, p1, 0x1

    .end local p1    # "off":I
    .local v2, "off":I
    sget-object v3, Lcom/fasterxml/jackson/core/io/NumberOutput;->SMALLEST_INT:Ljava/lang/String;

    invoke-virtual {v3, v1}, Ljava/lang/String;->charAt(I)C

    move-result v3

    int-to-byte v3, v3

    aput-byte v3, p0, p1

    .line 576
    add-int/lit8 v1, v1, 0x1

    move p1, v2

    goto :goto_0

    .line 579
    .end local v1    # "i":I
    .end local v2    # "off":I
    .restart local p1    # "off":I
    :cond_0
    return p1
.end method

.method private static _outputSmallestI([CI)I
    .locals 3
    .param p0, "b"    # [C
    .param p1, "off"    # I

    .line 568
    sget-object v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->SMALLEST_INT:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    .line 569
    .local v0, "len":I
    sget-object v1, Lcom/fasterxml/jackson/core/io/NumberOutput;->SMALLEST_INT:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-virtual {v1, v2, v0, p0, p1}, Ljava/lang/String;->getChars(II[CI)V

    .line 570
    add-int v1, p1, v0

    return v1
.end method

.method private static _outputSmallestL([BI)I
    .locals 4
    .param p0, "b"    # [B
    .param p1, "off"    # I

    .line 559
    sget-object v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->SMALLEST_LONG:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    .line 560
    .local v0, "len":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, v0, :cond_0

    .line 561
    add-int/lit8 v2, p1, 0x1

    .end local p1    # "off":I
    .local v2, "off":I
    sget-object v3, Lcom/fasterxml/jackson/core/io/NumberOutput;->SMALLEST_LONG:Ljava/lang/String;

    invoke-virtual {v3, v1}, Ljava/lang/String;->charAt(I)C

    move-result v3

    int-to-byte v3, v3

    aput-byte v3, p0, p1

    .line 560
    add-int/lit8 v1, v1, 0x1

    move p1, v2

    goto :goto_0

    .line 563
    .end local v1    # "i":I
    .end local v2    # "off":I
    .restart local p1    # "off":I
    :cond_0
    return p1
.end method

.method private static _outputSmallestL([CI)I
    .locals 3
    .param p0, "b"    # [C
    .param p1, "off"    # I

    .line 552
    sget-object v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->SMALLEST_LONG:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    .line 553
    .local v0, "len":I
    sget-object v1, Lcom/fasterxml/jackson/core/io/NumberOutput;->SMALLEST_LONG:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-virtual {v1, v2, v0, p0, p1}, Ljava/lang/String;->getChars(II[CI)V

    .line 554
    add-int v1, p1, v0

    return v1
.end method

.method private static _outputUptoBillion(I[BI)I
    .locals 6
    .param p0, "v"    # I
    .param p1, "b"    # [B
    .param p2, "off"    # I

    .line 415
    sget v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->MILLION:I

    if-ge p0, v0, :cond_1

    .line 416
    const/16 v0, 0x3e8

    if-ge p0, v0, :cond_0

    .line 417
    invoke-static {p0, p1, p2}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_leading3(I[BI)I

    move-result v0

    return v0

    .line 419
    :cond_0
    div-int/lit16 v0, p0, 0x3e8

    .line 420
    .local v0, "thousands":I
    mul-int/lit16 v1, v0, 0x3e8

    sub-int v1, p0, v1

    .line 421
    .local v1, "ones":I
    invoke-static {p1, p2, v0, v1}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_outputUptoMillion([BIII)I

    move-result v2

    return v2

    .line 423
    .end local v0    # "thousands":I
    .end local v1    # "ones":I
    :cond_1
    div-int/lit16 v0, p0, 0x3e8

    .line 424
    .restart local v0    # "thousands":I
    mul-int/lit16 v1, v0, 0x3e8

    sub-int v1, p0, v1

    .line 425
    .restart local v1    # "ones":I
    div-int/lit16 v2, v0, 0x3e8

    .line 426
    .local v2, "millions":I
    mul-int/lit16 v3, v2, 0x3e8

    sub-int/2addr v0, v3

    .line 428
    invoke-static {v2, p1, p2}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_leading3(I[BI)I

    move-result p2

    .line 430
    sget-object v3, Lcom/fasterxml/jackson/core/io/NumberOutput;->TRIPLET_TO_CHARS:[I

    aget v3, v3, v0

    .line 431
    .local v3, "enc":I
    add-int/lit8 v4, p2, 0x1

    .end local p2    # "off":I
    .local v4, "off":I
    shr-int/lit8 v5, v3, 0x10

    int-to-byte v5, v5

    aput-byte v5, p1, p2

    .line 432
    add-int/lit8 p2, v4, 0x1

    .end local v4    # "off":I
    .restart local p2    # "off":I
    shr-int/lit8 v5, v3, 0x8

    int-to-byte v5, v5

    aput-byte v5, p1, v4

    .line 433
    add-int/lit8 v4, p2, 0x1

    .end local p2    # "off":I
    .restart local v4    # "off":I
    int-to-byte v5, v3

    aput-byte v5, p1, p2

    .line 435
    sget-object p2, Lcom/fasterxml/jackson/core/io/NumberOutput;->TRIPLET_TO_CHARS:[I

    aget p2, p2, v1

    .line 436
    .end local v3    # "enc":I
    .local p2, "enc":I
    add-int/lit8 v3, v4, 0x1

    .end local v4    # "off":I
    .local v3, "off":I
    shr-int/lit8 v5, p2, 0x10

    int-to-byte v5, v5

    aput-byte v5, p1, v4

    .line 437
    add-int/lit8 v4, v3, 0x1

    .end local v3    # "off":I
    .restart local v4    # "off":I
    shr-int/lit8 v5, p2, 0x8

    int-to-byte v5, v5

    aput-byte v5, p1, v3

    .line 438
    add-int/lit8 v3, v4, 0x1

    .end local v4    # "off":I
    .restart local v3    # "off":I
    int-to-byte v5, p2

    aput-byte v5, p1, v4

    .line 440
    return v3
.end method

.method private static _outputUptoBillion(I[CI)I
    .locals 6
    .param p0, "v"    # I
    .param p1, "b"    # [C
    .param p2, "off"    # I

    .line 360
    sget v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->MILLION:I

    if-ge p0, v0, :cond_1

    .line 361
    const/16 v0, 0x3e8

    if-ge p0, v0, :cond_0

    .line 362
    invoke-static {p0, p1, p2}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_leading3(I[CI)I

    move-result v0

    return v0

    .line 364
    :cond_0
    div-int/lit16 v0, p0, 0x3e8

    .line 365
    .local v0, "thousands":I
    mul-int/lit16 v1, v0, 0x3e8

    sub-int v1, p0, v1

    .line 366
    .local v1, "ones":I
    invoke-static {p1, p2, v0, v1}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_outputUptoMillion([CIII)I

    move-result v2

    return v2

    .line 368
    .end local v0    # "thousands":I
    .end local v1    # "ones":I
    :cond_1
    div-int/lit16 v0, p0, 0x3e8

    .line 369
    .restart local v0    # "thousands":I
    mul-int/lit16 v1, v0, 0x3e8

    sub-int v1, p0, v1

    .line 370
    .restart local v1    # "ones":I
    div-int/lit16 v2, v0, 0x3e8

    .line 371
    .local v2, "millions":I
    mul-int/lit16 v3, v2, 0x3e8

    sub-int/2addr v0, v3

    .line 373
    invoke-static {v2, p1, p2}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_leading3(I[CI)I

    move-result p2

    .line 375
    sget-object v3, Lcom/fasterxml/jackson/core/io/NumberOutput;->TRIPLET_TO_CHARS:[I

    aget v3, v3, v0

    .line 376
    .local v3, "enc":I
    add-int/lit8 v4, p2, 0x1

    .end local p2    # "off":I
    .local v4, "off":I
    shr-int/lit8 v5, v3, 0x10

    int-to-char v5, v5

    aput-char v5, p1, p2

    .line 377
    add-int/lit8 p2, v4, 0x1

    .end local v4    # "off":I
    .restart local p2    # "off":I
    shr-int/lit8 v5, v3, 0x8

    and-int/lit8 v5, v5, 0x7f

    int-to-char v5, v5

    aput-char v5, p1, v4

    .line 378
    add-int/lit8 v4, p2, 0x1

    .end local p2    # "off":I
    .restart local v4    # "off":I
    and-int/lit8 v5, v3, 0x7f

    int-to-char v5, v5

    aput-char v5, p1, p2

    .line 380
    sget-object p2, Lcom/fasterxml/jackson/core/io/NumberOutput;->TRIPLET_TO_CHARS:[I

    aget p2, p2, v1

    .line 381
    .end local v3    # "enc":I
    .local p2, "enc":I
    add-int/lit8 v3, v4, 0x1

    .end local v4    # "off":I
    .local v3, "off":I
    shr-int/lit8 v5, p2, 0x10

    int-to-char v5, v5

    aput-char v5, p1, v4

    .line 382
    add-int/lit8 v4, v3, 0x1

    .end local v3    # "off":I
    .restart local v4    # "off":I
    shr-int/lit8 v5, p2, 0x8

    and-int/lit8 v5, v5, 0x7f

    int-to-char v5, v5

    aput-char v5, p1, v3

    .line 383
    add-int/lit8 v3, v4, 0x1

    .end local v4    # "off":I
    .restart local v3    # "off":I
    and-int/lit8 v5, p2, 0x7f

    int-to-char v5, v5

    aput-char v5, p1, v4

    .line 385
    return v3
.end method

.method private static _outputUptoMillion([BIII)I
    .locals 3
    .param p0, "b"    # [B
    .param p1, "off"    # I
    .param p2, "thousands"    # I
    .param p3, "ones"    # I

    .line 488
    sget-object v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->TRIPLET_TO_CHARS:[I

    aget v0, v0, p2

    .line 489
    .local v0, "enc":I
    const/16 v1, 0x9

    if-le p2, v1, :cond_1

    .line 490
    const/16 v1, 0x63

    if-le p2, v1, :cond_0

    .line 491
    add-int/lit8 v1, p1, 0x1

    .end local p1    # "off":I
    .local v1, "off":I
    shr-int/lit8 v2, v0, 0x10

    int-to-byte v2, v2

    aput-byte v2, p0, p1

    move p1, v1

    .line 493
    .end local v1    # "off":I
    .restart local p1    # "off":I
    :cond_0
    add-int/lit8 v1, p1, 0x1

    .end local p1    # "off":I
    .restart local v1    # "off":I
    shr-int/lit8 v2, v0, 0x8

    int-to-byte v2, v2

    aput-byte v2, p0, p1

    move p1, v1

    .line 495
    .end local v1    # "off":I
    .restart local p1    # "off":I
    :cond_1
    add-int/lit8 v1, p1, 0x1

    .end local p1    # "off":I
    .restart local v1    # "off":I
    int-to-byte v2, v0

    aput-byte v2, p0, p1

    .line 497
    sget-object p1, Lcom/fasterxml/jackson/core/io/NumberOutput;->TRIPLET_TO_CHARS:[I

    aget p1, p1, p3

    .line 498
    .end local v0    # "enc":I
    .local p1, "enc":I
    add-int/lit8 v0, v1, 0x1

    .end local v1    # "off":I
    .local v0, "off":I
    shr-int/lit8 v2, p1, 0x10

    int-to-byte v2, v2

    aput-byte v2, p0, v1

    .line 499
    add-int/lit8 v1, v0, 0x1

    .end local v0    # "off":I
    .restart local v1    # "off":I
    shr-int/lit8 v2, p1, 0x8

    int-to-byte v2, v2

    aput-byte v2, p0, v0

    .line 500
    add-int/lit8 v0, v1, 0x1

    .end local v1    # "off":I
    .restart local v0    # "off":I
    int-to-byte v2, p1

    aput-byte v2, p0, v1

    .line 501
    return v0
.end method

.method private static _outputUptoMillion([CIII)I
    .locals 3
    .param p0, "b"    # [C
    .param p1, "off"    # I
    .param p2, "thousands"    # I
    .param p3, "ones"    # I

    .line 470
    sget-object v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->TRIPLET_TO_CHARS:[I

    aget v0, v0, p2

    .line 471
    .local v0, "enc":I
    const/16 v1, 0x9

    if-le p2, v1, :cond_1

    .line 472
    const/16 v1, 0x63

    if-le p2, v1, :cond_0

    .line 473
    add-int/lit8 v1, p1, 0x1

    .end local p1    # "off":I
    .local v1, "off":I
    shr-int/lit8 v2, v0, 0x10

    int-to-char v2, v2

    aput-char v2, p0, p1

    move p1, v1

    .line 475
    .end local v1    # "off":I
    .restart local p1    # "off":I
    :cond_0
    add-int/lit8 v1, p1, 0x1

    .end local p1    # "off":I
    .restart local v1    # "off":I
    shr-int/lit8 v2, v0, 0x8

    and-int/lit8 v2, v2, 0x7f

    int-to-char v2, v2

    aput-char v2, p0, p1

    move p1, v1

    .line 477
    .end local v1    # "off":I
    .restart local p1    # "off":I
    :cond_1
    add-int/lit8 v1, p1, 0x1

    .end local p1    # "off":I
    .restart local v1    # "off":I
    and-int/lit8 v2, v0, 0x7f

    int-to-char v2, v2

    aput-char v2, p0, p1

    .line 479
    sget-object p1, Lcom/fasterxml/jackson/core/io/NumberOutput;->TRIPLET_TO_CHARS:[I

    aget p1, p1, p3

    .line 480
    .end local v0    # "enc":I
    .local p1, "enc":I
    add-int/lit8 v0, v1, 0x1

    .end local v1    # "off":I
    .local v0, "off":I
    shr-int/lit8 v2, p1, 0x10

    int-to-char v2, v2

    aput-char v2, p0, v1

    .line 481
    add-int/lit8 v1, v0, 0x1

    .end local v0    # "off":I
    .restart local v1    # "off":I
    shr-int/lit8 v2, p1, 0x8

    and-int/lit8 v2, v2, 0x7f

    int-to-char v2, v2

    aput-char v2, p0, v0

    .line 482
    add-int/lit8 v0, v1, 0x1

    .end local v1    # "off":I
    .restart local v0    # "off":I
    and-int/lit8 v2, p1, 0x7f

    int-to-char v2, v2

    aput-char v2, p0, v1

    .line 483
    return v0
.end method

.method public static notFinite(D)Z
    .locals 1
    .param p0, "value"    # D

    .line 334
    invoke-static {p0, p1}, Ljava/lang/Double;->isNaN(D)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p0, p1}, Ljava/lang/Double;->isInfinite(D)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    return v0
.end method

.method public static notFinite(F)Z
    .locals 1
    .param p0, "value"    # F

    .line 349
    invoke-static {p0}, Ljava/lang/Float;->isNaN(F)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p0}, Ljava/lang/Float;->isInfinite(F)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    return v0
.end method

.method public static outputInt(I[BI)I
    .locals 4
    .param p0, "v"    # I
    .param p1, "b"    # [B
    .param p2, "off"    # I

    .line 123
    if-gez p0, :cond_1

    .line 124
    const/high16 v0, -0x80000000

    if-ne p0, v0, :cond_0

    .line 125
    invoke-static {p1, p2}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_outputSmallestI([BI)I

    move-result v0

    return v0

    .line 127
    :cond_0
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "off":I
    .local v0, "off":I
    const/16 v1, 0x2d

    aput-byte v1, p1, p2

    .line 128
    neg-int p0, p0

    move p2, v0

    .line 131
    .end local v0    # "off":I
    .restart local p2    # "off":I
    :cond_1
    sget v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->MILLION:I

    const/16 v1, 0x3e8

    if-ge p0, v0, :cond_4

    .line 132
    if-ge p0, v1, :cond_3

    .line 133
    const/16 v0, 0xa

    if-ge p0, v0, :cond_2

    .line 134
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "off":I
    .restart local v0    # "off":I
    add-int/lit8 v1, p0, 0x30

    int-to-byte v1, v1

    aput-byte v1, p1, p2

    goto :goto_0

    .line 136
    .end local v0    # "off":I
    .restart local p2    # "off":I
    :cond_2
    invoke-static {p0, p1, p2}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_leading3(I[BI)I

    move-result v0

    .end local p2    # "off":I
    .restart local v0    # "off":I
    goto :goto_0

    .line 139
    .end local v0    # "off":I
    .restart local p2    # "off":I
    :cond_3
    div-int/lit16 v0, p0, 0x3e8

    .line 140
    .local v0, "thousands":I
    mul-int/lit16 v1, v0, 0x3e8

    sub-int/2addr p0, v1

    .line 141
    invoke-static {v0, p1, p2}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_leading3(I[BI)I

    move-result p2

    .line 142
    invoke-static {p0, p1, p2}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_full3(I[BI)I

    move-result p2

    move v0, p2

    .line 144
    .end local p2    # "off":I
    .local v0, "off":I
    :goto_0
    return v0

    .line 146
    .end local v0    # "off":I
    .restart local p2    # "off":I
    :cond_4
    sget v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->BILLION:I

    if-lt p0, v0, :cond_6

    .line 147
    sget v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->BILLION:I

    sub-int/2addr p0, v0

    .line 148
    sget v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->BILLION:I

    if-lt p0, v0, :cond_5

    .line 149
    sget v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->BILLION:I

    sub-int/2addr p0, v0

    .line 150
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "off":I
    .restart local v0    # "off":I
    const/16 v1, 0x32

    aput-byte v1, p1, p2

    goto :goto_1

    .line 152
    .end local v0    # "off":I
    .restart local p2    # "off":I
    :cond_5
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "off":I
    .restart local v0    # "off":I
    const/16 v1, 0x31

    aput-byte v1, p1, p2

    .line 154
    :goto_1
    invoke-static {p0, p1, v0}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_outputFullBillion(I[BI)I

    move-result p2

    return p2

    .line 156
    .end local v0    # "off":I
    .restart local p2    # "off":I
    :cond_6
    div-int/lit16 v0, p0, 0x3e8

    .line 157
    .local v0, "newValue":I
    mul-int/lit16 v2, v0, 0x3e8

    sub-int v2, p0, v2

    .line 158
    .local v2, "ones":I
    move p0, v0

    .line 159
    div-int/2addr v0, v1

    .line 160
    mul-int/lit16 v1, v0, 0x3e8

    sub-int v1, p0, v1

    .line 161
    .local v1, "thousands":I
    invoke-static {v0, p1, p2}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_leading3(I[BI)I

    move-result p2

    .line 162
    invoke-static {v1, p1, p2}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_full3(I[BI)I

    move-result p2

    .line 163
    invoke-static {v2, p1, p2}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_full3(I[BI)I

    move-result v3

    return v3
.end method

.method public static outputInt(I[CI)I
    .locals 4
    .param p0, "v"    # I
    .param p1, "b"    # [C
    .param p2, "off"    # I

    .line 70
    if-gez p0, :cond_1

    .line 71
    const/high16 v0, -0x80000000

    if-ne p0, v0, :cond_0

    .line 74
    invoke-static {p1, p2}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_outputSmallestI([CI)I

    move-result v0

    return v0

    .line 76
    :cond_0
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "off":I
    .local v0, "off":I
    const/16 v1, 0x2d

    aput-char v1, p1, p2

    .line 77
    neg-int p0, p0

    move p2, v0

    .line 80
    .end local v0    # "off":I
    .restart local p2    # "off":I
    :cond_1
    sget v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->MILLION:I

    const/16 v1, 0x3e8

    if-ge p0, v0, :cond_4

    .line 81
    if-ge p0, v1, :cond_3

    .line 82
    const/16 v0, 0xa

    if-ge p0, v0, :cond_2

    .line 83
    add-int/lit8 v0, p0, 0x30

    int-to-char v0, v0

    aput-char v0, p1, p2

    .line 84
    add-int/lit8 v0, p2, 0x1

    return v0

    .line 86
    :cond_2
    invoke-static {p0, p1, p2}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_leading3(I[CI)I

    move-result v0

    return v0

    .line 88
    :cond_3
    div-int/lit16 v0, p0, 0x3e8

    .line 89
    .local v0, "thousands":I
    mul-int/lit16 v1, v0, 0x3e8

    sub-int/2addr p0, v1

    .line 90
    invoke-static {v0, p1, p2}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_leading3(I[CI)I

    move-result p2

    .line 91
    invoke-static {p0, p1, p2}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_full3(I[CI)I

    move-result p2

    .line 92
    return p2

    .line 100
    .end local v0    # "thousands":I
    :cond_4
    sget v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->BILLION:I

    if-lt p0, v0, :cond_6

    .line 101
    sget v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->BILLION:I

    sub-int/2addr p0, v0

    .line 102
    sget v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->BILLION:I

    if-lt p0, v0, :cond_5

    .line 103
    sget v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->BILLION:I

    sub-int/2addr p0, v0

    .line 104
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "off":I
    .local v0, "off":I
    const/16 v1, 0x32

    aput-char v1, p1, p2

    goto :goto_0

    .line 106
    .end local v0    # "off":I
    .restart local p2    # "off":I
    :cond_5
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "off":I
    .restart local v0    # "off":I
    const/16 v1, 0x31

    aput-char v1, p1, p2

    .line 108
    :goto_0
    invoke-static {p0, p1, v0}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_outputFullBillion(I[CI)I

    move-result p2

    return p2

    .line 110
    .end local v0    # "off":I
    .restart local p2    # "off":I
    :cond_6
    div-int/lit16 v0, p0, 0x3e8

    .line 111
    .local v0, "newValue":I
    mul-int/lit16 v2, v0, 0x3e8

    sub-int v2, p0, v2

    .line 112
    .local v2, "ones":I
    move p0, v0

    .line 113
    div-int/2addr v0, v1

    .line 114
    mul-int/lit16 v1, v0, 0x3e8

    sub-int v1, p0, v1

    .line 116
    .local v1, "thousands":I
    invoke-static {v0, p1, p2}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_leading3(I[CI)I

    move-result p2

    .line 117
    invoke-static {v1, p1, p2}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_full3(I[CI)I

    move-result p2

    .line 118
    invoke-static {v2, p1, p2}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_full3(I[CI)I

    move-result v3

    return v3
.end method

.method public static outputLong(J[BI)I
    .locals 6
    .param p0, "v"    # J
    .param p2, "b"    # [B
    .param p3, "off"    # I

    .line 216
    const-wide/16 v0, 0x0

    cmp-long v0, p0, v0

    if-gez v0, :cond_2

    .line 217
    sget-wide v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->MIN_INT_AS_LONG:J

    cmp-long v0, p0, v0

    if-lez v0, :cond_0

    .line 218
    long-to-int v0, p0

    invoke-static {v0, p2, p3}, Lcom/fasterxml/jackson/core/io/NumberOutput;->outputInt(I[BI)I

    move-result v0

    return v0

    .line 220
    :cond_0
    const-wide/high16 v0, -0x8000000000000000L

    cmp-long v0, p0, v0

    if-nez v0, :cond_1

    .line 221
    invoke-static {p2, p3}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_outputSmallestL([BI)I

    move-result v0

    return v0

    .line 223
    :cond_1
    add-int/lit8 v0, p3, 0x1

    .end local p3    # "off":I
    .local v0, "off":I
    const/16 v1, 0x2d

    aput-byte v1, p2, p3

    .line 224
    neg-long p0, p0

    move p3, v0

    goto :goto_0

    .line 226
    .end local v0    # "off":I
    .restart local p3    # "off":I
    :cond_2
    sget-wide v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->MAX_INT_AS_LONG:J

    cmp-long v0, p0, v0

    if-gtz v0, :cond_3

    .line 227
    long-to-int v0, p0

    invoke-static {v0, p2, p3}, Lcom/fasterxml/jackson/core/io/NumberOutput;->outputInt(I[BI)I

    move-result v0

    return v0

    .line 232
    :cond_3
    :goto_0
    sget-wide v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->BILLION_L:J

    div-long v0, p0, v0

    .line 233
    .local v0, "upper":J
    sget-wide v2, Lcom/fasterxml/jackson/core/io/NumberOutput;->BILLION_L:J

    mul-long/2addr v2, v0

    sub-long/2addr p0, v2

    .line 236
    sget-wide v2, Lcom/fasterxml/jackson/core/io/NumberOutput;->BILLION_L:J

    cmp-long v2, v0, v2

    if-gez v2, :cond_4

    .line 237
    long-to-int v2, v0

    invoke-static {v2, p2, p3}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_outputUptoBillion(I[BI)I

    move-result p3

    goto :goto_1

    .line 240
    :cond_4
    sget-wide v2, Lcom/fasterxml/jackson/core/io/NumberOutput;->BILLION_L:J

    div-long v2, v0, v2

    .line 241
    .local v2, "hi":J
    sget-wide v4, Lcom/fasterxml/jackson/core/io/NumberOutput;->BILLION_L:J

    mul-long/2addr v4, v2

    sub-long/2addr v0, v4

    .line 242
    long-to-int v4, v2

    invoke-static {v4, p2, p3}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_leading3(I[BI)I

    move-result p3

    .line 243
    long-to-int v4, v0

    invoke-static {v4, p2, p3}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_outputFullBillion(I[BI)I

    move-result p3

    .line 245
    .end local v2    # "hi":J
    :goto_1
    long-to-int v2, p0

    invoke-static {v2, p2, p3}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_outputFullBillion(I[BI)I

    move-result v2

    return v2
.end method

.method public static outputLong(J[CI)I
    .locals 6
    .param p0, "v"    # J
    .param p2, "b"    # [C
    .param p3, "off"    # I

    .line 182
    const-wide/16 v0, 0x0

    cmp-long v0, p0, v0

    if-gez v0, :cond_2

    .line 183
    sget-wide v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->MIN_INT_AS_LONG:J

    cmp-long v0, p0, v0

    if-lez v0, :cond_0

    .line 184
    long-to-int v0, p0

    invoke-static {v0, p2, p3}, Lcom/fasterxml/jackson/core/io/NumberOutput;->outputInt(I[CI)I

    move-result v0

    return v0

    .line 186
    :cond_0
    const-wide/high16 v0, -0x8000000000000000L

    cmp-long v0, p0, v0

    if-nez v0, :cond_1

    .line 187
    invoke-static {p2, p3}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_outputSmallestL([CI)I

    move-result v0

    return v0

    .line 189
    :cond_1
    add-int/lit8 v0, p3, 0x1

    .end local p3    # "off":I
    .local v0, "off":I
    const/16 v1, 0x2d

    aput-char v1, p2, p3

    .line 190
    neg-long p0, p0

    move p3, v0

    goto :goto_0

    .line 192
    .end local v0    # "off":I
    .restart local p3    # "off":I
    :cond_2
    sget-wide v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->MAX_INT_AS_LONG:J

    cmp-long v0, p0, v0

    if-gtz v0, :cond_3

    .line 193
    long-to-int v0, p0

    invoke-static {v0, p2, p3}, Lcom/fasterxml/jackson/core/io/NumberOutput;->outputInt(I[CI)I

    move-result v0

    return v0

    .line 198
    :cond_3
    :goto_0
    sget-wide v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->BILLION_L:J

    div-long v0, p0, v0

    .line 199
    .local v0, "upper":J
    sget-wide v2, Lcom/fasterxml/jackson/core/io/NumberOutput;->BILLION_L:J

    mul-long/2addr v2, v0

    sub-long/2addr p0, v2

    .line 202
    sget-wide v2, Lcom/fasterxml/jackson/core/io/NumberOutput;->BILLION_L:J

    cmp-long v2, v0, v2

    if-gez v2, :cond_4

    .line 203
    long-to-int v2, v0

    invoke-static {v2, p2, p3}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_outputUptoBillion(I[CI)I

    move-result p3

    goto :goto_1

    .line 206
    :cond_4
    sget-wide v2, Lcom/fasterxml/jackson/core/io/NumberOutput;->BILLION_L:J

    div-long v2, v0, v2

    .line 207
    .local v2, "hi":J
    sget-wide v4, Lcom/fasterxml/jackson/core/io/NumberOutput;->BILLION_L:J

    mul-long/2addr v4, v2

    sub-long/2addr v0, v4

    .line 208
    long-to-int v4, v2

    invoke-static {v4, p2, p3}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_leading3(I[CI)I

    move-result p3

    .line 209
    long-to-int v4, v0

    invoke-static {v4, p2, p3}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_outputFullBillion(I[CI)I

    move-result p3

    .line 211
    .end local v2    # "hi":J
    :goto_1
    long-to-int v2, p0

    invoke-static {v2, p2, p3}, Lcom/fasterxml/jackson/core/io/NumberOutput;->_outputFullBillion(I[CI)I

    move-result v2

    return v2
.end method

.method public static toString(D)Ljava/lang/String;
    .locals 1
    .param p0, "v"    # D

    .line 284
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lcom/fasterxml/jackson/core/io/NumberOutput;->toString(DZ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static toString(DZ)Ljava/lang/String;
    .locals 1
    .param p0, "v"    # D
    .param p2, "useFastWriter"    # Z

    .line 294
    if-eqz p2, :cond_0

    invoke-static {p0, p1}, Lcom/fasterxml/jackson/core/io/schubfach/DoubleToDecimal;->toString(D)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    invoke-static {p0, p1}, Ljava/lang/Double;->toString(D)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0
.end method

.method public static toString(F)Ljava/lang/String;
    .locals 1
    .param p0, "v"    # F

    .line 303
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lcom/fasterxml/jackson/core/io/NumberOutput;->toString(FZ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static toString(FZ)Ljava/lang/String;
    .locals 1
    .param p0, "v"    # F
    .param p1, "useFastWriter"    # Z

    .line 313
    if-eqz p1, :cond_0

    invoke-static {p0}, Lcom/fasterxml/jackson/core/io/schubfach/FloatToDecimal;->toString(F)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    invoke-static {p0}, Ljava/lang/Float;->toString(F)Ljava/lang/String;

    move-result-object v0

    :goto_0
    return-object v0
.end method

.method public static toString(I)Ljava/lang/String;
    .locals 2
    .param p0, "v"    # I

    .line 260
    sget-object v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->sSmallIntStrs:[Ljava/lang/String;

    array-length v0, v0

    if-ge p0, v0, :cond_1

    .line 261
    if-ltz p0, :cond_0

    .line 262
    sget-object v0, Lcom/fasterxml/jackson/core/io/NumberOutput;->sSmallIntStrs:[Ljava/lang/String;

    aget-object v0, v0, p0

    return-object v0

    .line 264
    :cond_0
    neg-int v0, p0

    add-int/lit8 v0, v0, -0x1

    .line 265
    .local v0, "v2":I
    sget-object v1, Lcom/fasterxml/jackson/core/io/NumberOutput;->sSmallIntStrs2:[Ljava/lang/String;

    array-length v1, v1

    if-ge v0, v1, :cond_1

    .line 266
    sget-object v1, Lcom/fasterxml/jackson/core/io/NumberOutput;->sSmallIntStrs2:[Ljava/lang/String;

    aget-object v1, v1, v0

    return-object v1

    .line 269
    .end local v0    # "v2":I
    :cond_1
    invoke-static {p0}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static toString(J)Ljava/lang/String;
    .locals 2
    .param p0, "v"    # J

    .line 273
    const-wide/32 v0, 0x7fffffff

    cmp-long v0, p0, v0

    if-gtz v0, :cond_0

    const-wide/32 v0, -0x80000000

    cmp-long v0, p0, v0

    if-ltz v0, :cond_0

    .line 274
    long-to-int v0, p0

    invoke-static {v0}, Lcom/fasterxml/jackson/core/io/NumberOutput;->toString(I)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 276
    :cond_0
    invoke-static {p0, p1}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
