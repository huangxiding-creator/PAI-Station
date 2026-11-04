.class public Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;
.super Ljava/lang/Object;
.source "SimpleValueEncoder.java"


# instance fields
.field protected final mBuffer:[C

.field protected final mEncoderFactory:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 17
    const/16 v0, 0x1f4

    new-array v0, v0, [C

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->mBuffer:[C

    .line 23
    new-instance v0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;-><init>()V

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->mEncoderFactory:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    .line 24
    return-void
.end method


# virtual methods
.method protected encode(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)Ljava/lang/String;
    .locals 5
    .param p1, "enc"    # Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;

    .line 60
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->mBuffer:[C

    iget-object v1, p0, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->mBuffer:[C

    array-length v1, v1

    const/4 v2, 0x0

    invoke-virtual {p1, v0, v2, v1}, Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;->encodeMore([CII)I

    move-result v0

    .line 61
    .local v0, "last":I
    invoke-virtual {p1}, Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;->isCompleted()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 62
    new-instance v1, Ljava/lang/String;

    iget-object v3, p0, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->mBuffer:[C

    invoke-direct {v1, v3, v2, v0}, Ljava/lang/String;-><init>([CII)V

    return-object v1

    .line 65
    :cond_0
    new-instance v1, Ljava/lang/StringBuffer;

    iget-object v3, p0, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->mBuffer:[C

    array-length v3, v3

    shl-int/lit8 v3, v3, 0x1

    invoke-direct {v1, v3}, Ljava/lang/StringBuffer;-><init>(I)V

    .line 66
    .local v1, "sb":Ljava/lang/StringBuffer;
    iget-object v3, p0, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->mBuffer:[C

    invoke-virtual {v1, v3, v2, v0}, Ljava/lang/StringBuffer;->append([CII)Ljava/lang/StringBuffer;

    .line 68
    :cond_1
    iget-object v3, p0, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->mBuffer:[C

    iget-object v4, p0, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->mBuffer:[C

    array-length v4, v4

    invoke-virtual {p1, v3, v2, v4}, Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;->encodeMore([CII)I

    move-result v0

    .line 69
    iget-object v3, p0, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->mBuffer:[C

    invoke-virtual {v1, v3, v2, v0}, Ljava/lang/StringBuffer;->append([CII)Ljava/lang/StringBuffer;

    .line 70
    invoke-virtual {p1}, Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;->isCompleted()Z

    move-result v3

    if-eqz v3, :cond_1

    .line 71
    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method public encodeAsString(Lorg/codehaus/stax2/typed/Base64Variant;[BII)Ljava/lang/String;
    .locals 1
    .param p1, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .param p2, "value"    # [B
    .param p3, "from"    # I
    .param p4, "length"    # I

    .line 48
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->mEncoderFactory:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    invoke-virtual {v0, p1, p2, p3, p4}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder(Lorg/codehaus/stax2/typed/Base64Variant;[BII)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encode(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public encodeAsString([DII)Ljava/lang/String;
    .locals 1
    .param p1, "value"    # [D
    .param p2, "from"    # I
    .param p3, "length"    # I

    .line 43
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->mEncoderFactory:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder([DII)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleArrayEncoder;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encode(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public encodeAsString([FII)Ljava/lang/String;
    .locals 1
    .param p1, "value"    # [F
    .param p2, "from"    # I
    .param p3, "length"    # I

    .line 38
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->mEncoderFactory:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder([FII)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatArrayEncoder;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encode(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public encodeAsString([III)Ljava/lang/String;
    .locals 1
    .param p1, "value"    # [I
    .param p2, "from"    # I
    .param p3, "length"    # I

    .line 28
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->mEncoderFactory:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder([III)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntArrayEncoder;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encode(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public encodeAsString([JII)Ljava/lang/String;
    .locals 1
    .param p1, "value"    # [J
    .param p2, "from"    # I
    .param p3, "length"    # I

    .line 33
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->mEncoderFactory:Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;->getEncoder([JII)Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$LongArrayEncoder;

    move-result-object v0

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/typed/SimpleValueEncoder;->encode(Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
