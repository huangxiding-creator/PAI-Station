.class public final Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;
.super Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;
.source "ValueDecoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "DoubleDecoder"
.end annotation


# instance fields
.field protected mValue:D


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 923
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

    .line 937
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 938
    .local v0, "len":I
    const/16 v1, 0x46

    const/16 v2, 0x49

    const/4 v3, 0x0

    const/4 v4, 0x2

    const/4 v5, 0x1

    const/16 v6, 0x4e

    const/4 v7, 0x3

    if-ne v0, v7, :cond_1

    .line 939
    invoke-virtual {p1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 940
    .local v3, "c":C
    if-ne v3, v2, :cond_0

    .line 941
    invoke-virtual {p1, v5}, Ljava/lang/String;->charAt(I)C

    move-result v2

    if-ne v2, v6, :cond_2

    invoke-virtual {p1, v4}, Ljava/lang/String;->charAt(I)C

    move-result v2

    if-ne v2, v1, :cond_2

    .line 942
    const-wide/high16 v1, 0x7ff0000000000000L    # Double.POSITIVE_INFINITY

    iput-wide v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;->mValue:D

    .line 943
    return-void

    .line 945
    :cond_0
    if-ne v3, v6, :cond_2

    .line 946
    invoke-virtual {p1, v5}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x61

    if-ne v1, v2, :cond_2

    invoke-virtual {p1, v4}, Ljava/lang/String;->charAt(I)C

    move-result v1

    if-ne v1, v6, :cond_2

    .line 947
    const-wide/high16 v1, 0x7ff8000000000000L    # Double.NaN

    iput-wide v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;->mValue:D

    .line 948
    return-void

    .line 951
    .end local v3    # "c":C
    :cond_1
    const/4 v8, 0x4

    if-ne v0, v8, :cond_2

    .line 952
    invoke-virtual {p1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 953
    .restart local v3    # "c":C
    const/16 v8, 0x2d

    if-ne v3, v8, :cond_3

    .line 954
    invoke-virtual {p1, v5}, Ljava/lang/String;->charAt(I)C

    move-result v5

    if-ne v5, v2, :cond_3

    .line 955
    invoke-virtual {p1, v4}, Ljava/lang/String;->charAt(I)C

    move-result v2

    if-ne v2, v6, :cond_3

    .line 956
    invoke-virtual {p1, v7}, Ljava/lang/String;->charAt(I)C

    move-result v2

    if-ne v2, v1, :cond_3

    .line 957
    const-wide/high16 v1, -0x10000000000000L    # Double.NEGATIVE_INFINITY

    iput-wide v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;->mValue:D

    .line 958
    return-void

    .line 951
    .end local v3    # "c":C
    :cond_2
    nop

    .line 964
    :cond_3
    :try_start_0
    invoke-static {p1}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v1

    iput-wide v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;->mValue:D
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 967
    nop

    .line 968
    return-void

    .line 965
    :catch_0
    move-exception v1

    .line 966
    .local v1, "nex":Ljava/lang/NumberFormatException;
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;->constructInvalidValue(Ljava/lang/String;)Ljava/lang/IllegalArgumentException;

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

    .line 974
    sub-int v0, p3, p2

    .line 976
    .local v0, "len":I
    const/4 v1, 0x3

    const/16 v2, 0x46

    const/16 v3, 0x49

    const/16 v4, 0x4e

    if-ne v0, v1, :cond_1

    .line 977
    aget-char v1, p1, p2

    .line 978
    .local v1, "c":C
    if-ne v1, v3, :cond_0

    .line 979
    add-int/lit8 v3, p2, 0x1

    aget-char v3, p1, v3

    if-ne v3, v4, :cond_2

    add-int/lit8 v3, p2, 0x2

    aget-char v3, p1, v3

    if-ne v3, v2, :cond_2

    .line 980
    const-wide/high16 v2, 0x7ff0000000000000L    # Double.POSITIVE_INFINITY

    iput-wide v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;->mValue:D

    .line 981
    return-void

    .line 983
    :cond_0
    if-ne v1, v4, :cond_2

    .line 984
    add-int/lit8 v2, p2, 0x1

    aget-char v2, p1, v2

    const/16 v3, 0x61

    if-ne v2, v3, :cond_2

    add-int/lit8 v2, p2, 0x2

    aget-char v2, p1, v2

    if-ne v2, v4, :cond_2

    .line 985
    const-wide/high16 v2, 0x7ff8000000000000L    # Double.NaN

    iput-wide v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;->mValue:D

    .line 986
    return-void

    .line 989
    .end local v1    # "c":C
    :cond_1
    const/4 v1, 0x4

    if-ne v0, v1, :cond_2

    .line 990
    aget-char v1, p1, p2

    .line 991
    .restart local v1    # "c":C
    const/16 v5, 0x2d

    if-ne v1, v5, :cond_3

    .line 992
    add-int/lit8 v5, p2, 0x1

    aget-char v5, p1, v5

    if-ne v5, v3, :cond_3

    add-int/lit8 v3, p2, 0x2

    aget-char v3, p1, v3

    if-ne v3, v4, :cond_3

    add-int/lit8 v3, p2, 0x3

    aget-char v3, p1, v3

    if-ne v3, v2, :cond_3

    .line 995
    const-wide/high16 v2, -0x10000000000000L    # Double.NEGATIVE_INFINITY

    iput-wide v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;->mValue:D

    .line 996
    return-void

    .line 989
    .end local v1    # "c":C
    :cond_2
    nop

    .line 1001
    :cond_3
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, p1, p2, v0}, Ljava/lang/String;-><init>([CII)V

    .line 1003
    .local v1, "lexicalStr":Ljava/lang/String;
    :try_start_0
    invoke-static {v1}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v2

    iput-wide v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;->mValue:D
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1006
    nop

    .line 1007
    return-void

    .line 1004
    :catch_0
    move-exception v2

    .line 1005
    .local v2, "nex":Ljava/lang/NumberFormatException;
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;->constructInvalidValue(Ljava/lang/String;)Ljava/lang/IllegalArgumentException;

    move-result-object v3

    throw v3
.end method

.method public getType()Ljava/lang/String;
    .locals 1

    .line 926
    const-string v0, "double"

    return-object v0
.end method

.method public getValue()D
    .locals 2

    .line 928
    iget-wide v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;->mValue:D

    return-wide v0
.end method
