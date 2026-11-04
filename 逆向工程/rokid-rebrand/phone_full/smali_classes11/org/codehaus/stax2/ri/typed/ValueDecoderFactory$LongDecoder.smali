.class public final Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;
.super Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;
.source "ValueDecoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "LongDecoder"
.end annotation


# instance fields
.field protected mValue:J


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 708
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;-><init>()V

    return-void
.end method

.method private parseUsingBD(Ljava/lang/String;Z)J
    .locals 4
    .param p1, "lexical"    # Ljava/lang/String;
    .param p2, "neg"    # Z

    .line 808
    new-instance v0, Ljava/math/BigInteger;

    invoke-direct {v0, p1}, Ljava/math/BigInteger;-><init>(Ljava/lang/String;)V

    .line 811
    .local v0, "bi":Ljava/math/BigInteger;
    if-eqz p2, :cond_0

    .line 812
    invoke-virtual {v0}, Ljava/math/BigInteger;->negate()Ljava/math/BigInteger;

    move-result-object v0

    .line 813
    sget-object v1, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->BD_MIN_LONG:Ljava/math/BigInteger;

    invoke-virtual {v0, v1}, Ljava/math/BigInteger;->compareTo(Ljava/math/BigInteger;)I

    move-result v1

    if-ltz v1, :cond_1

    .line 814
    invoke-virtual {v0}, Ljava/math/BigInteger;->longValue()J

    move-result-wide v1

    return-wide v1

    .line 817
    :cond_0
    sget-object v1, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->BD_MAX_LONG:Ljava/math/BigInteger;

    invoke-virtual {v0, v1}, Ljava/math/BigInteger;->compareTo(Ljava/math/BigInteger;)I

    move-result v1

    if-gtz v1, :cond_1

    .line 818
    invoke-virtual {v0}, Ljava/math/BigInteger;->longValue()J

    move-result-wide v1

    return-wide v1

    .line 822
    :cond_1
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "value \""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->lexicalDesc(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\" not a valid long: overflow."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method


# virtual methods
.method public decode(Ljava/lang/String;)V
    .locals 11
    .param p1, "lexical"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 719
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 720
    .local v0, "end":I
    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 721
    .local v2, "ch":C
    const/16 v3, 0x2d

    const/4 v4, 0x1

    if-ne v2, v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    move v3, v1

    .line 724
    .local v3, "neg":Z
    :goto_0
    if-nez v3, :cond_2

    const/16 v5, 0x2b

    if-ne v2, v5, :cond_1

    goto :goto_1

    .line 727
    :cond_1
    invoke-virtual {p0, p1, v2, v1, v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->skipSignAndZeroes(Ljava/lang/String;CZI)I

    move-result v1

    .local v1, "nr":I
    goto :goto_2

    .line 725
    .end local v1    # "nr":I
    :cond_2
    :goto_1
    invoke-virtual {p0, p1, v2, v4, v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->skipSignAndZeroes(Ljava/lang/String;CZI)I

    move-result v1

    .line 729
    .restart local v1    # "nr":I
    :goto_2
    iget v5, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->mNextPtr:I

    .line 732
    .local v5, "ptr":I
    sub-int v6, v0, v5

    .line 733
    .local v6, "charsLeft":I
    if-nez v6, :cond_4

    .line 734
    if-eqz v3, :cond_3

    neg-int v4, v1

    goto :goto_3

    :cond_3
    move v4, v1

    :goto_3
    int-to-long v7, v4

    iput-wide v7, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->mValue:J

    .line 735
    return-void

    .line 737
    :cond_4
    invoke-virtual {p0, p1, v5, v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->verifyDigits(Ljava/lang/String;II)V

    .line 740
    const/16 v7, 0x8

    if-gt v6, v7, :cond_6

    .line 741
    add-int v4, v5, v6

    invoke-static {v1, p1, v5, v4}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->parseInt(ILjava/lang/String;II)I

    move-result v4

    .line 742
    .local v4, "i":I
    if-eqz v3, :cond_5

    neg-int v7, v4

    goto :goto_4

    :cond_5
    move v7, v4

    :goto_4
    int-to-long v7, v7

    iput-wide v7, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->mValue:J

    .line 743
    return-void

    .line 746
    .end local v4    # "i":I
    :cond_6
    add-int/lit8 v5, v5, -0x1

    .line 747
    add-int/2addr v6, v4

    .line 750
    const/16 v4, 0x12

    if-gt v6, v4, :cond_8

    .line 751
    add-int v4, v5, v6

    invoke-static {p1, v5, v4}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->parseLong(Ljava/lang/String;II)J

    move-result-wide v7

    .line 752
    .local v7, "l":J
    if-eqz v3, :cond_7

    neg-long v9, v7

    goto :goto_5

    :cond_7
    move-wide v9, v7

    :goto_5
    iput-wide v9, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->mValue:J

    .line 753
    return-void

    .line 759
    .end local v7    # "l":J
    :cond_8
    add-int v4, v5, v6

    invoke-virtual {p1, v5, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v4, v3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->parseUsingBD(Ljava/lang/String;Z)J

    move-result-wide v7

    iput-wide v7, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->mValue:J

    .line 760
    return-void
.end method

.method public decode([CII)V
    .locals 11
    .param p1, "lexical"    # [C
    .param p2, "start"    # I
    .param p3, "end"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 766
    aget-char v6, p1, p2

    .line 767
    .local v6, "ch":C
    const/16 v0, 0x2d

    const/4 v7, 0x1

    if-ne v6, v0, :cond_0

    move v0, v7

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    move v8, v0

    .line 770
    .local v8, "neg":Z
    if-nez v8, :cond_2

    const/16 v0, 0x2b

    if-ne v6, v0, :cond_1

    goto :goto_1

    .line 773
    :cond_1
    const/4 v3, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, v6

    move v4, p2

    move v5, p3

    invoke-virtual/range {v0 .. v5}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->skipSignAndZeroes([CCZII)I

    move-result v0

    .local v0, "nr":I
    goto :goto_2

    .line 771
    .end local v0    # "nr":I
    :cond_2
    :goto_1
    const/4 v3, 0x1

    move-object v0, p0

    move-object v1, p1

    move v2, v6

    move v4, p2

    move v5, p3

    invoke-virtual/range {v0 .. v5}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->skipSignAndZeroes([CCZII)I

    move-result v0

    .line 775
    .restart local v0    # "nr":I
    :goto_2
    iget v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->mNextPtr:I

    .line 778
    .local v1, "ptr":I
    sub-int v2, p3, v1

    .line 779
    .local v2, "charsLeft":I
    if-nez v2, :cond_4

    .line 780
    if-eqz v8, :cond_3

    neg-int v3, v0

    goto :goto_3

    :cond_3
    move v3, v0

    :goto_3
    int-to-long v3, v3

    iput-wide v3, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->mValue:J

    .line 781
    return-void

    .line 783
    :cond_4
    invoke-virtual {p0, p1, p2, p3, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->verifyDigits([CIII)V

    .line 786
    const/16 v3, 0x8

    if-gt v2, v3, :cond_6

    .line 787
    add-int v3, v1, v2

    invoke-static {v0, p1, v1, v3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->parseInt(I[CII)I

    move-result v3

    .line 788
    .local v3, "i":I
    if-eqz v8, :cond_5

    neg-int v4, v3

    int-to-long v4, v4

    goto :goto_4

    :cond_5
    int-to-long v4, v3

    :goto_4
    iput-wide v4, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->mValue:J

    .line 789
    return-void

    .line 792
    .end local v3    # "i":I
    :cond_6
    add-int/lit8 v1, v1, -0x1

    .line 793
    add-int/2addr v2, v7

    .line 796
    const/16 v3, 0x12

    if-gt v2, v3, :cond_8

    .line 797
    add-int v3, v1, v2

    invoke-static {p1, v1, v3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->parseLong([CII)J

    move-result-wide v3

    .line 798
    .local v3, "l":J
    if-eqz v8, :cond_7

    neg-long v9, v3

    goto :goto_5

    :cond_7
    move-wide v9, v3

    :goto_5
    iput-wide v9, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->mValue:J

    .line 799
    return-void

    .line 803
    .end local v3    # "l":J
    :cond_8
    new-instance v3, Ljava/lang/String;

    invoke-direct {v3, p1, v1, v2}, Ljava/lang/String;-><init>([CII)V

    invoke-direct {p0, v3, v8}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->parseUsingBD(Ljava/lang/String;Z)J

    move-result-wide v3

    iput-wide v3, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->mValue:J

    .line 804
    return-void
.end method

.method public getType()Ljava/lang/String;
    .locals 1

    .line 711
    const-string v0, "long"

    return-object v0
.end method

.method public getValue()J
    .locals 2

    .line 713
    iget-wide v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->mValue:J

    return-wide v0
.end method
