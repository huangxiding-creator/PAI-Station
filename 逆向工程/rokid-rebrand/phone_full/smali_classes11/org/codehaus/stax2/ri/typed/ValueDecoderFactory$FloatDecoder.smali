.class public final Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;
.super Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;
.source "ValueDecoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "FloatDecoder"
.end annotation


# instance fields
.field protected mValue:F


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 831
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

    .line 845
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 846
    .local v0, "len":I
    const/16 v1, 0x46

    const/16 v2, 0x49

    const/4 v3, 0x0

    const/4 v4, 0x2

    const/4 v5, 0x1

    const/16 v6, 0x4e

    const/4 v7, 0x3

    if-ne v0, v7, :cond_1

    .line 847
    invoke-virtual {p1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 848
    .local v3, "c":C
    if-ne v3, v2, :cond_0

    .line 849
    invoke-virtual {p1, v5}, Ljava/lang/String;->charAt(I)C

    move-result v2

    if-ne v2, v6, :cond_2

    invoke-virtual {p1, v4}, Ljava/lang/String;->charAt(I)C

    move-result v2

    if-ne v2, v1, :cond_2

    .line 850
    const/high16 v1, 0x7f800000    # Float.POSITIVE_INFINITY

    iput v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;->mValue:F

    .line 851
    return-void

    .line 853
    :cond_0
    if-ne v3, v6, :cond_2

    .line 854
    invoke-virtual {p1, v5}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x61

    if-ne v1, v2, :cond_2

    invoke-virtual {p1, v4}, Ljava/lang/String;->charAt(I)C

    move-result v1

    if-ne v1, v6, :cond_2

    .line 855
    const/high16 v1, 0x7fc00000    # Float.NaN

    iput v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;->mValue:F

    .line 856
    return-void

    .line 859
    .end local v3    # "c":C
    :cond_1
    const/4 v8, 0x4

    if-ne v0, v8, :cond_2

    .line 860
    invoke-virtual {p1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 861
    .restart local v3    # "c":C
    const/16 v8, 0x2d

    if-ne v3, v8, :cond_3

    .line 862
    invoke-virtual {p1, v5}, Ljava/lang/String;->charAt(I)C

    move-result v5

    if-ne v5, v2, :cond_3

    .line 863
    invoke-virtual {p1, v4}, Ljava/lang/String;->charAt(I)C

    move-result v2

    if-ne v2, v6, :cond_3

    .line 864
    invoke-virtual {p1, v7}, Ljava/lang/String;->charAt(I)C

    move-result v2

    if-ne v2, v1, :cond_3

    .line 865
    const/high16 v1, -0x800000    # Float.NEGATIVE_INFINITY

    iput v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;->mValue:F

    .line 866
    return-void

    .line 859
    .end local v3    # "c":C
    :cond_2
    nop

    .line 872
    :cond_3
    :try_start_0
    invoke-static {p1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v1

    iput v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;->mValue:F
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 875
    nop

    .line 876
    return-void

    .line 873
    :catch_0
    move-exception v1

    .line 874
    .local v1, "nex":Ljava/lang/NumberFormatException;
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;->constructInvalidValue(Ljava/lang/String;)Ljava/lang/IllegalArgumentException;

    move-result-object v2

    throw v2
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

    .line 882
    sub-int v0, p3, p2

    .line 884
    .local v0, "len":I
    const/4 v1, 0x3

    const/16 v2, 0x46

    const/16 v3, 0x49

    const/16 v4, 0x4e

    if-ne v0, v1, :cond_1

    .line 885
    aget-char v1, p1, p2

    .line 886
    .local v1, "c":C
    if-ne v1, v3, :cond_0

    .line 887
    add-int/lit8 v3, p2, 0x1

    aget-char v3, p1, v3

    if-ne v3, v4, :cond_2

    add-int/lit8 v3, p2, 0x2

    aget-char v3, p1, v3

    if-ne v3, v2, :cond_2

    .line 888
    const/high16 v2, 0x7f800000    # Float.POSITIVE_INFINITY

    iput v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;->mValue:F

    .line 889
    return-void

    .line 891
    :cond_0
    if-ne v1, v4, :cond_2

    .line 892
    add-int/lit8 v2, p2, 0x1

    aget-char v2, p1, v2

    const/16 v3, 0x61

    if-ne v2, v3, :cond_2

    add-int/lit8 v2, p2, 0x2

    aget-char v2, p1, v2

    if-ne v2, v4, :cond_2

    .line 893
    const/high16 v2, 0x7fc00000    # Float.NaN

    iput v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;->mValue:F

    .line 894
    return-void

    .line 897
    .end local v1    # "c":C
    :cond_1
    const/4 v1, 0x4

    if-ne v0, v1, :cond_2

    .line 898
    aget-char v1, p1, p2

    .line 899
    .restart local v1    # "c":C
    const/16 v5, 0x2d

    if-ne v1, v5, :cond_3

    .line 900
    add-int/lit8 v5, p2, 0x1

    aget-char v5, p1, v5

    if-ne v5, v3, :cond_3

    add-int/lit8 v3, p2, 0x2

    aget-char v3, p1, v3

    if-ne v3, v4, :cond_3

    add-int/lit8 v3, p2, 0x3

    aget-char v3, p1, v3

    if-ne v3, v2, :cond_3

    .line 903
    const/high16 v2, -0x800000    # Float.NEGATIVE_INFINITY

    iput v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;->mValue:F

    .line 904
    return-void

    .line 897
    .end local v1    # "c":C
    :cond_2
    nop

    .line 909
    :cond_3
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, p1, p2, v0}, Ljava/lang/String;-><init>([CII)V

    .line 911
    .local v1, "lexicalStr":Ljava/lang/String;
    :try_start_0
    invoke-static {v1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v2

    iput v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;->mValue:F
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 914
    nop

    .line 915
    return-void

    .line 912
    :catch_0
    move-exception v2

    .line 913
    .local v2, "nex":Ljava/lang/NumberFormatException;
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;->constructInvalidValue(Ljava/lang/String;)Ljava/lang/IllegalArgumentException;

    move-result-object v3

    throw v3
.end method

.method public getType()Ljava/lang/String;
    .locals 1

    .line 834
    const-string v0, "float"

    return-object v0
.end method

.method public getValue()F
    .locals 1

    .line 836
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;->mValue:F

    return v0
.end method
