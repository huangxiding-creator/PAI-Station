.class public final Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;
.super Ljava/lang/Object;
.source "ValueDecoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;,
        Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;,
        Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;,
        Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;,
        Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;,
        Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;,
        Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;,
        Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;,
        Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;,
        Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;,
        Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;,
        Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;,
        Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;,
        Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;
    }
.end annotation


# instance fields
.field protected mBooleanDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;

.field protected mDoubleDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

.field protected mFloatDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

.field protected mIntDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

.field protected mLongDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 52
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 46
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->mBooleanDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;

    .line 47
    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->mIntDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    .line 48
    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->mLongDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    .line 49
    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->mFloatDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    .line 50
    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->mDoubleDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    .line 52
    return-void
.end method


# virtual methods
.method public getBooleanDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;
    .locals 1

    .line 62
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->mBooleanDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;

    if-nez v0, :cond_0

    .line 63
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;-><init>()V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->mBooleanDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;

    .line 65
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->mBooleanDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BooleanDecoder;

    return-object v0
.end method

.method public getDecimalDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;
    .locals 1

    .line 104
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecimalDecoder;-><init>()V

    return-object v0
.end method

.method public getDoubleArrayDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;
    .locals 2

    .line 165
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDoubleDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    move-result-object v1

    invoke-direct {v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;-><init>(Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;)V

    return-object v0
.end method

.method public getDoubleArrayDecoder([DII)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;
    .locals 2
    .param p1, "result"    # [D
    .param p2, "offset"    # I
    .param p3, "len"    # I

    .line 160
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getDoubleDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    move-result-object v1

    invoke-direct {v0, p1, p2, p3, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;-><init>([DIILorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;)V

    return-object v0
.end method

.method public getDoubleDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;
    .locals 1

    .line 94
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->mDoubleDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    if-nez v0, :cond_0

    .line 95
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;-><init>()V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->mDoubleDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    .line 97
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->mDoubleDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    return-object v0
.end method

.method public getFloatArrayDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;
    .locals 2

    .line 155
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getFloatDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    move-result-object v1

    invoke-direct {v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;-><init>(Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;)V

    return-object v0
.end method

.method public getFloatArrayDecoder([FII)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;
    .locals 2
    .param p1, "result"    # [F
    .param p2, "offset"    # I
    .param p3, "len"    # I

    .line 149
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getFloatDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    move-result-object v1

    invoke-direct {v0, p1, p2, p3, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;-><init>([FIILorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;)V

    return-object v0
.end method

.method public getFloatDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;
    .locals 1

    .line 86
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->mFloatDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    if-nez v0, :cond_0

    .line 87
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;-><init>()V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->mFloatDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    .line 89
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->mFloatDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    return-object v0
.end method

.method public getIntArrayDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;
    .locals 2

    .line 133
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    move-result-object v1

    invoke-direct {v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;-><init>(Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;)V

    return-object v0
.end method

.method public getIntArrayDecoder([III)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;
    .locals 2
    .param p1, "result"    # [I
    .param p2, "offset"    # I
    .param p3, "len"    # I

    .line 123
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getIntDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    move-result-object v1

    invoke-direct {v0, p1, p2, p3, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;-><init>([IIILorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;)V

    return-object v0
.end method

.method public getIntDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;
    .locals 1

    .line 70
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->mIntDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    if-nez v0, :cond_0

    .line 71
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;-><init>()V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->mIntDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    .line 73
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->mIntDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    return-object v0
.end method

.method public getIntegerDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;
    .locals 1

    .line 102
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntegerDecoder;-><init>()V

    return-object v0
.end method

.method public getLongArrayDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;
    .locals 2

    .line 144
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getLongDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    move-result-object v1

    invoke-direct {v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;-><init>(Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;)V

    return-object v0
.end method

.method public getLongArrayDecoder([JII)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;
    .locals 2
    .param p1, "result"    # [J
    .param p2, "offset"    # I
    .param p3, "len"    # I

    .line 138
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->getLongDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    move-result-object v1

    invoke-direct {v0, p1, p2, p3, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;-><init>([JIILorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;)V

    return-object v0
.end method

.method public getLongDecoder()Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;
    .locals 1

    .line 78
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->mLongDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    if-nez v0, :cond_0

    .line 79
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;-><init>()V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->mLongDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    .line 81
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;->mLongDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    return-object v0
.end method

.method public getQNameDecoder(Ljavax/xml/namespace/NamespaceContext;)Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;
    .locals 1
    .param p1, "nsc"    # Ljavax/xml/namespace/NamespaceContext;

    .line 107
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;

    invoke-direct {v0, p1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$QNameDecoder;-><init>(Ljavax/xml/namespace/NamespaceContext;)V

    return-object v0
.end method
