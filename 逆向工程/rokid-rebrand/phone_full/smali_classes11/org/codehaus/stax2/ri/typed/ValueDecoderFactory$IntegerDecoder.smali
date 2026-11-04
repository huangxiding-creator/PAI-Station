.class public final Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;
.super Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;
.source "ValueDecoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "IntegerDecoder"
.end annotation


# instance fields
.field protected mValue:Ljava/math/BigInteger;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 1021
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;-><init>()V

    return-void
.end method


# virtual methods
.method public decode(Ljava/lang/String;)V
    .locals 2
    .param p1, "lexical"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 1032
    :try_start_0
    new-instance v0, Ljava/math/BigInteger;

    invoke-direct {v0, p1}, Ljava/math/BigInteger;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;->mValue:Ljava/math/BigInteger;
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1035
    nop

    .line 1036
    return-void

    .line 1033
    :catch_0
    move-exception v0

    .line 1034
    .local v0, "nex":Ljava/lang/NumberFormatException;
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;->constructInvalidValue(Ljava/lang/String;)Ljava/lang/IllegalArgumentException;

    move-result-object v1

    throw v1
.end method

.method public decode([CII)V
    .locals 3
    .param p1, "lexical"    # [C
    .param p2, "start"    # I
    .param p3, "end"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 1041
    new-instance v0, Ljava/lang/String;

    sub-int v1, p3, p2

    invoke-direct {v0, p1, p2, v1}, Ljava/lang/String;-><init>([CII)V

    .line 1043
    .local v0, "lexicalStr":Ljava/lang/String;
    :try_start_0
    new-instance v1, Ljava/math/BigInteger;

    invoke-direct {v1, v0}, Ljava/math/BigInteger;-><init>(Ljava/lang/String;)V

    iput-object v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;->mValue:Ljava/math/BigInteger;
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1046
    nop

    .line 1047
    return-void

    .line 1044
    :catch_0
    move-exception v1

    .line 1045
    .local v1, "nex":Ljava/lang/NumberFormatException;
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;->constructInvalidValue(Ljava/lang/String;)Ljava/lang/IllegalArgumentException;

    move-result-object v2

    throw v2
.end method

.method public getType()Ljava/lang/String;
    .locals 1

    .line 1024
    const-string v0, "integer"

    return-object v0
.end method

.method public getValue()Ljava/math/BigInteger;
    .locals 1

    .line 1026
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;->mValue:Ljava/math/BigInteger;

    return-object v0
.end method
