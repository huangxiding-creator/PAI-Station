.class public final Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;
.super Ljava/lang/Object;
.source "ValueEncoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;,
        Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleArrayEncoder;,
        Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatArrayEncoder;,
        Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$LongArrayEncoder;,
        Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntArrayEncoder;,
        Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ArrayEncoder;,
        Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleEncoder;,
        Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatEncoder;,
        Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$LongEncoder;,
        Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntEncoder;,
        Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TypedScalarEncoder;,
        Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;,
        Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TokenEncoder;,
        Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ScalarEncoder;
    }
.end annotation


# static fields
.field static final BYTE_SPACE:B = 0x20t


# instance fields
.field protected _doubleEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleEncoder;

.field protected _floatEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatEncoder;

.field protected _intEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntEncoder;

.field protected _longEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$LongEncoder;

.field protected _tokenEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TokenEncoder;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 39
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_tokenEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TokenEncoder;

    .line 40
    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_intEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntEncoder;

    .line 41
    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_longEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$LongEncoder;

    .line 42
    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_floatEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatEncoder;

    .line 43
    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_doubleEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleEncoder;

    .line 45
    return-void
.end method


# virtual methods
.method public getEncoder(Lorg/codehaus/stax2/typed/Base64Variant;[BII)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;
    .locals 2
    .param p1, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .param p2, "data"    # [B
    .param p3, "from"    # I
    .param p4, "length"    # I

    .line 131
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;

    add-int v1, p3, p4

    invoke-direct {v0, p1, p2, p3, v1}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;-><init>(Lorg/codehaus/stax2/typed/Base64Variant;[BII)V

    return-object v0
.end method

.method public getEncoder([DII)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleArrayEncoder;
    .locals 2
    .param p1, "values"    # [D
    .param p2, "from"    # I
    .param p3, "length"    # I

    .line 124
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleArrayEncoder;

    add-int v1, p2, p3

    invoke-direct {v0, p1, p2, v1}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleArrayEncoder;-><init>([DII)V

    return-object v0
.end method

.method public getEncoder(D)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleEncoder;
    .locals 1
    .param p1, "value"    # D

    .line 98
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_doubleEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleEncoder;

    if-nez v0, :cond_0

    .line 99
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleEncoder;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleEncoder;-><init>()V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_doubleEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleEncoder;

    .line 101
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_doubleEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleEncoder;

    invoke-virtual {v0, p1, p2}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleEncoder;->reset(D)V

    .line 102
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_doubleEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleEncoder;

    return-object v0
.end method

.method public getEncoder([FII)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatArrayEncoder;
    .locals 2
    .param p1, "values"    # [F
    .param p2, "from"    # I
    .param p3, "length"    # I

    .line 119
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatArrayEncoder;

    add-int v1, p2, p3

    invoke-direct {v0, p1, p2, v1}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatArrayEncoder;-><init>([FII)V

    return-object v0
.end method

.method public getEncoder(F)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatEncoder;
    .locals 1
    .param p1, "value"    # F

    .line 89
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_floatEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatEncoder;

    if-nez v0, :cond_0

    .line 90
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatEncoder;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatEncoder;-><init>()V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_floatEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatEncoder;

    .line 92
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_floatEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatEncoder;

    invoke-virtual {v0, p1}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatEncoder;->reset(F)V

    .line 93
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_floatEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatEncoder;

    return-object v0
.end method

.method public getEncoder([III)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntArrayEncoder;
    .locals 2
    .param p1, "values"    # [I
    .param p2, "from"    # I
    .param p3, "length"    # I

    .line 109
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntArrayEncoder;

    add-int v1, p2, p3

    invoke-direct {v0, p1, p2, v1}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntArrayEncoder;-><init>([III)V

    return-object v0
.end method

.method public getEncoder(I)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntEncoder;
    .locals 1
    .param p1, "value"    # I

    .line 71
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_intEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntEncoder;

    if-nez v0, :cond_0

    .line 72
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntEncoder;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntEncoder;-><init>()V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_intEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntEncoder;

    .line 74
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_intEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntEncoder;

    invoke-virtual {v0, p1}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntEncoder;->reset(I)V

    .line 75
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_intEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntEncoder;

    return-object v0
.end method

.method public getEncoder([JII)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$LongArrayEncoder;
    .locals 2
    .param p1, "values"    # [J
    .param p2, "from"    # I
    .param p3, "length"    # I

    .line 114
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$LongArrayEncoder;

    add-int v1, p2, p3

    invoke-direct {v0, p1, p2, v1}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$LongArrayEncoder;-><init>([JII)V

    return-object v0
.end method

.method public getEncoder(J)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$LongEncoder;
    .locals 1
    .param p1, "value"    # J

    .line 80
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_longEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$LongEncoder;

    if-nez v0, :cond_0

    .line 81
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$LongEncoder;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$LongEncoder;-><init>()V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_longEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$LongEncoder;

    .line 83
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_longEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$LongEncoder;

    invoke-virtual {v0, p1, p2}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$LongEncoder;->reset(J)V

    .line 84
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_longEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$LongEncoder;

    return-object v0
.end method

.method public getEncoder(Z)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ScalarEncoder;
    .locals 1
    .param p1, "value"    # Z

    .line 66
    if-eqz p1, :cond_0

    const-string v0, "true"

    goto :goto_0

    :cond_0
    const-string v0, "false"

    :goto_0
    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getScalarEncoder(Ljava/lang/String;)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ScalarEncoder;

    move-result-object v0

    return-object v0
.end method

.method public getScalarEncoder(Ljava/lang/String;)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ScalarEncoder;
    .locals 2
    .param p1, "value"    # Ljava/lang/String;

    .line 52
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0x40

    if-le v0, v1, :cond_1

    .line 53
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_tokenEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TokenEncoder;

    if-nez v0, :cond_0

    .line 54
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TokenEncoder;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TokenEncoder;-><init>()V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_tokenEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TokenEncoder;

    .line 56
    :cond_0
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_tokenEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TokenEncoder;

    invoke-virtual {v0, p1}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TokenEncoder;->reset(Ljava/lang/String;)V

    .line 57
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->_tokenEncoder:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TokenEncoder;

    return-object v0

    .line 60
    :cond_1
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;

    invoke-direct {v0, p1}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$StringEncoder;-><init>(Ljava/lang/String;)V

    return-object v0
.end method
