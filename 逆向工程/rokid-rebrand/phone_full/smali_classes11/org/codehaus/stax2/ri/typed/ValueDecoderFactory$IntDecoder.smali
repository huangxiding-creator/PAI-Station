.class public final Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;
.super Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;
.source "ValueDecoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "IntDecoder"
.end annotation


# instance fields
.field protected mValue:I


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 587
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;-><init>()V

    return-void
.end method


# virtual methods
.method public decode(Ljava/lang/String;)V
    .locals 13
    .param p1, "lexical"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 597
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 598
    .local v0, "end":I
    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 599
    .local v2, "ch":C
    const/16 v3, 0x2d

    const/4 v4, 0x1

    if-ne v2, v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    move v3, v1

    .line 602
    .local v3, "neg":Z
    :goto_0
    if-nez v3, :cond_2

    const/16 v5, 0x2b

    if-ne v2, v5, :cond_1

    goto :goto_1

    .line 605
    :cond_1
    invoke-virtual {p0, p1, v2, v1, v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->skipSignAndZeroes(Ljava/lang/String;CZI)I

    move-result v1

    .local v1, "nr":I
    goto :goto_2

    .line 603
    .end local v1    # "nr":I
    :cond_2
    :goto_1
    invoke-virtual {p0, p1, v2, v4, v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->skipSignAndZeroes(Ljava/lang/String;CZI)I

    move-result v1

    .line 607
    .restart local v1    # "nr":I
    :goto_2
    iget v4, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->mNextPtr:I

    .line 610
    .local v4, "ptr":I
    sub-int v5, v0, v4

    .line 611
    .local v5, "charsLeft":I
    if-nez v5, :cond_4

    .line 612
    if-eqz v3, :cond_3

    neg-int v6, v1

    goto :goto_3

    :cond_3
    move v6, v1

    :goto_3
    iput v6, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->mValue:I

    .line 613
    return-void

    .line 615
    :cond_4
    invoke-virtual {p0, p1, v4, v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->verifyDigits(Ljava/lang/String;II)V

    .line 617
    const/16 v6, 0x8

    if-gt v5, v6, :cond_6

    .line 618
    add-int v6, v4, v5

    invoke-static {v1, p1, v4, v6}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->parseInt(ILjava/lang/String;II)I

    move-result v6

    .line 619
    .local v6, "i":I
    if-eqz v3, :cond_5

    neg-int v7, v6

    goto :goto_4

    :cond_5
    move v7, v6

    :goto_4
    iput v7, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->mValue:I

    .line 620
    return-void

    .line 624
    .end local v6    # "i":I
    :cond_6
    const/16 v6, 0x9

    if-ne v5, v6, :cond_9

    const/4 v6, 0x3

    if-ge v1, v6, :cond_9

    .line 625
    const-wide/32 v6, 0x3b9aca00

    .line 626
    .local v6, "base":J
    const/4 v8, 0x2

    if-ne v1, v8, :cond_7

    .line 627
    const-wide/32 v8, 0x3b9aca00

    add-long/2addr v6, v8

    .line 629
    :cond_7
    add-int v8, v4, v5

    invoke-static {p1, v4, v8}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->parseInt(Ljava/lang/String;II)I

    move-result v8

    .line 630
    .local v8, "i":I
    int-to-long v9, v8

    add-long/2addr v9, v6

    .line 631
    .local v9, "l":J
    if-eqz v3, :cond_8

    .line 632
    neg-long v9, v9

    .line 633
    const-wide/32 v11, -0x80000000

    cmp-long v11, v9, v11

    if-ltz v11, :cond_9

    .line 634
    long-to-int v11, v9

    iput v11, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->mValue:I

    .line 635
    return-void

    .line 638
    :cond_8
    const-wide/32 v11, 0x7fffffff

    cmp-long v11, v9, v11

    if-gtz v11, :cond_9

    .line 639
    long-to-int v11, v9

    iput v11, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->mValue:I

    .line 640
    return-void

    .line 644
    .end local v6    # "base":J
    .end local v8    # "i":I
    .end local v9    # "l":J
    :cond_9
    new-instance v6, Ljava/lang/IllegalArgumentException;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "value \""

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->lexicalDesc(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "\" not a valid 32-bit integer: overflow."

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v6
.end method

.method public decode([CII)V
    .locals 12
    .param p1, "lexical"    # [C
    .param p2, "start"    # I
    .param p3, "end"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 652
    aget-char v6, p1, p2

    .line 653
    .local v6, "ch":C
    const/16 v0, 0x2d

    if-ne v6, v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    move v7, v0

    .line 656
    .local v7, "neg":Z
    if-nez v7, :cond_2

    const/16 v0, 0x2b

    if-ne v6, v0, :cond_1

    goto :goto_1

    .line 659
    :cond_1
    const/4 v3, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, v6

    move v4, p2

    move v5, p3

    invoke-virtual/range {v0 .. v5}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->skipSignAndZeroes([CCZII)I

    move-result v0

    .local v0, "nr":I
    goto :goto_2

    .line 657
    .end local v0    # "nr":I
    :cond_2
    :goto_1
    const/4 v3, 0x1

    move-object v0, p0

    move-object v1, p1

    move v2, v6

    move v4, p2

    move v5, p3

    invoke-virtual/range {v0 .. v5}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->skipSignAndZeroes([CCZII)I

    move-result v0

    .line 661
    .restart local v0    # "nr":I
    :goto_2
    iget v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->mNextPtr:I

    .line 664
    .local v1, "ptr":I
    sub-int v2, p3, v1

    .line 665
    .local v2, "charsLeft":I
    if-nez v2, :cond_4

    .line 666
    if-eqz v7, :cond_3

    neg-int v3, v0

    goto :goto_3

    :cond_3
    move v3, v0

    :goto_3
    iput v3, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->mValue:I

    .line 667
    return-void

    .line 669
    :cond_4
    invoke-virtual {p0, p1, p2, p3, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->verifyDigits([CIII)V

    .line 672
    const/16 v3, 0x8

    if-gt v2, v3, :cond_6

    .line 673
    add-int v3, v1, v2

    invoke-static {v0, p1, v1, v3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->parseInt(I[CII)I

    move-result v3

    .line 674
    .local v3, "i":I
    if-eqz v7, :cond_5

    neg-int v4, v3

    goto :goto_4

    :cond_5
    move v4, v3

    :goto_4
    iput v4, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->mValue:I

    .line 675
    return-void

    .line 679
    .end local v3    # "i":I
    :cond_6
    const/16 v3, 0x9

    if-ne v2, v3, :cond_9

    const/4 v3, 0x3

    if-ge v0, v3, :cond_9

    .line 680
    const-wide/32 v3, 0x3b9aca00

    .line 681
    .local v3, "base":J
    const/4 v5, 0x2

    if-ne v0, v5, :cond_7

    .line 682
    const-wide/32 v8, 0x3b9aca00

    add-long/2addr v3, v8

    .line 684
    :cond_7
    add-int v5, v1, v2

    invoke-static {p1, v1, v5}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->parseInt([CII)I

    move-result v5

    .line 685
    .local v5, "i":I
    int-to-long v8, v5

    add-long/2addr v8, v3

    .line 686
    .local v8, "l":J
    if-eqz v7, :cond_8

    .line 687
    neg-long v8, v8

    .line 688
    const-wide/32 v10, -0x80000000

    cmp-long v10, v8, v10

    if-ltz v10, :cond_9

    .line 689
    long-to-int v10, v8

    iput v10, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->mValue:I

    .line 690
    return-void

    .line 693
    :cond_8
    const-wide/32 v10, 0x7fffffff

    cmp-long v10, v8, v10

    if-gtz v10, :cond_9

    .line 694
    long-to-int v10, v8

    iput v10, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->mValue:I

    .line 695
    return-void

    .line 699
    .end local v3    # "base":J
    .end local v5    # "i":I
    .end local v8    # "l":J
    :cond_9
    new-instance v3, Ljava/lang/IllegalArgumentException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "value \""

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->lexicalDesc([CII)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "\" not a valid 32-bit integer: overflow."

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3
.end method

.method public getType()Ljava/lang/String;
    .locals 1

    .line 590
    const-string v0, "int"

    return-object v0
.end method

.method public getValue()I
    .locals 1

    .line 592
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->mValue:I

    return v0
.end method
