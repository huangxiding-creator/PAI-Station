.class public final Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;
.super Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;
.source "ValueDecoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "BooleanDecoder"
.end annotation


# instance fields
.field protected mValue:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 500
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;-><init>()V

    return-void
.end method


# virtual methods
.method public decode(Ljava/lang/String;)V
    .locals 9
    .param p1, "lexical"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 510
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 511
    .local v0, "len":I
    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 512
    .local v2, "c":C
    const/16 v3, 0x74

    const/16 v4, 0x65

    const/4 v5, 0x3

    const/4 v6, 0x2

    const/4 v7, 0x4

    const/4 v8, 0x1

    if-ne v2, v3, :cond_0

    .line 513
    if-ne v0, v7, :cond_3

    .line 514
    invoke-virtual {p1, v8}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v3, 0x72

    if-ne v1, v3, :cond_3

    .line 515
    invoke-virtual {p1, v6}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v3, 0x75

    if-ne v1, v3, :cond_3

    .line 516
    invoke-virtual {p1, v5}, Ljava/lang/String;->charAt(I)C

    move-result v1

    if-ne v1, v4, :cond_3

    .line 517
    iput-boolean v8, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;->mValue:Z

    .line 518
    return-void

    .line 520
    :cond_0
    const/16 v3, 0x66

    if-ne v2, v3, :cond_1

    .line 521
    const/4 v3, 0x5

    if-ne v0, v3, :cond_3

    .line 522
    invoke-virtual {p1, v8}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v8, 0x61

    if-ne v3, v8, :cond_3

    .line 523
    invoke-virtual {p1, v6}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v6, 0x6c

    if-ne v3, v6, :cond_3

    .line 524
    invoke-virtual {p1, v5}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v5, 0x73

    if-ne v3, v5, :cond_3

    .line 525
    invoke-virtual {p1, v7}, Ljava/lang/String;->charAt(I)C

    move-result v3

    if-ne v3, v4, :cond_3

    .line 526
    iput-boolean v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;->mValue:Z

    .line 527
    return-void

    .line 529
    :cond_1
    const/16 v3, 0x30

    if-ne v2, v3, :cond_2

    .line 530
    if-ne v0, v8, :cond_3

    .line 531
    iput-boolean v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;->mValue:Z

    .line 532
    return-void

    .line 534
    :cond_2
    const/16 v1, 0x31

    if-ne v2, v1, :cond_3

    .line 535
    if-ne v0, v8, :cond_3

    .line 536
    iput-boolean v8, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;->mValue:Z

    .line 537
    return-void

    .line 540
    :cond_3
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;->constructInvalidValue(Ljava/lang/String;)Ljava/lang/IllegalArgumentException;

    move-result-object v1

    throw v1
.end method

.method public decode([CII)V
    .locals 6
    .param p1, "lexical"    # [C
    .param p2, "start"    # I
    .param p3, "end"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 548
    sub-int v0, p3, p2

    .line 549
    .local v0, "len":I
    aget-char v1, p1, p2

    .line 550
    .local v1, "c":C
    const/16 v2, 0x74

    const/16 v3, 0x65

    const/4 v4, 0x1

    if-ne v1, v2, :cond_0

    .line 551
    const/4 v2, 0x4

    if-ne v0, v2, :cond_3

    add-int/lit8 v2, p2, 0x1

    aget-char v2, p1, v2

    const/16 v5, 0x72

    if-ne v2, v5, :cond_3

    add-int/lit8 v2, p2, 0x2

    aget-char v2, p1, v2

    const/16 v5, 0x75

    if-ne v2, v5, :cond_3

    add-int/lit8 v2, p2, 0x3

    aget-char v2, p1, v2

    if-ne v2, v3, :cond_3

    .line 555
    iput-boolean v4, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;->mValue:Z

    .line 556
    return-void

    .line 558
    :cond_0
    const/16 v2, 0x66

    const/4 v5, 0x0

    if-ne v1, v2, :cond_1

    .line 559
    const/4 v2, 0x5

    if-ne v0, v2, :cond_3

    add-int/lit8 v2, p2, 0x1

    aget-char v2, p1, v2

    const/16 v4, 0x61

    if-ne v2, v4, :cond_3

    add-int/lit8 v2, p2, 0x2

    aget-char v2, p1, v2

    const/16 v4, 0x6c

    if-ne v2, v4, :cond_3

    add-int/lit8 v2, p2, 0x3

    aget-char v2, p1, v2

    const/16 v4, 0x73

    if-ne v2, v4, :cond_3

    add-int/lit8 v2, p2, 0x4

    aget-char v2, p1, v2

    if-ne v2, v3, :cond_3

    .line 564
    iput-boolean v5, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;->mValue:Z

    .line 565
    return-void

    .line 567
    :cond_1
    const/16 v2, 0x30

    if-ne v1, v2, :cond_2

    .line 568
    if-ne v0, v4, :cond_3

    .line 569
    iput-boolean v5, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;->mValue:Z

    .line 570
    return-void

    .line 572
    :cond_2
    const/16 v2, 0x31

    if-ne v1, v2, :cond_3

    .line 573
    if-ne v0, v4, :cond_3

    .line 574
    iput-boolean v4, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;->mValue:Z

    .line 575
    return-void

    .line 578
    :cond_3
    invoke-virtual {p0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;->constructInvalidValue([CII)Ljava/lang/IllegalArgumentException;

    move-result-object v2

    throw v2
.end method

.method public getType()Ljava/lang/String;
    .locals 1

    .line 503
    const-string v0, "boolean"

    return-object v0
.end method

.method public getValue()Z
    .locals 1

    .line 505
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;->mValue:Z

    return v0
.end method
