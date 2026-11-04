.class public final Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;
.super Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;
.source "ValueDecoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "DecimalDecoder"
.end annotation


# instance fields
.field protected mValue:Ljava/math/BigDecimal;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 1055
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

    .line 1066
    :try_start_0
    new-instance v0, Ljava/math/BigDecimal;

    invoke-direct {v0, p1}, Ljava/math/BigDecimal;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;->mValue:Ljava/math/BigDecimal;
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1069
    nop

    .line 1070
    return-void

    .line 1067
    :catch_0
    move-exception v0

    .line 1068
    .local v0, "nex":Ljava/lang/NumberFormatException;
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;->constructInvalidValue(Ljava/lang/String;)Ljava/lang/IllegalArgumentException;

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

    .line 1075
    sub-int v0, p3, p2

    .line 1082
    .local v0, "len":I
    :try_start_0
    new-instance v1, Ljava/math/BigDecimal;

    new-instance v2, Ljava/lang/String;

    invoke-direct {v2, p1, p2, v0}, Ljava/lang/String;-><init>([CII)V

    invoke-direct {v1, v2}, Ljava/math/BigDecimal;-><init>(Ljava/lang/String;)V

    iput-object v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;->mValue:Ljava/math/BigDecimal;
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1085
    nop

    .line 1086
    return-void

    .line 1083
    :catch_0
    move-exception v1

    .line 1084
    .local v1, "nex":Ljava/lang/NumberFormatException;
    new-instance v2, Ljava/lang/String;

    invoke-direct {v2, p1, p2, v0}, Ljava/lang/String;-><init>([CII)V

    invoke-virtual {p0, v2}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;->constructInvalidValue(Ljava/lang/String;)Ljava/lang/IllegalArgumentException;

    move-result-object v2

    throw v2
.end method

.method public getType()Ljava/lang/String;
    .locals 1

    .line 1058
    const-string v0, "decimal"

    return-object v0
.end method

.method public getValue()Ljava/math/BigDecimal;
    .locals 1

    .line 1060
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;->mValue:Ljava/math/BigDecimal;

    return-object v0
.end method
