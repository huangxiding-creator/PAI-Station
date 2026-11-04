.class final Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatArrayEncoder;
.super Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ArrayEncoder;
.source "ValueEncoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "FloatArrayEncoder"
.end annotation


# instance fields
.field final _values:[F


# direct methods
.method protected constructor <init>([FII)V
    .locals 0
    .param p1, "values"    # [F
    .param p2, "from"    # I
    .param p3, "length"    # I

    .line 470
    invoke-direct {p0, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ArrayEncoder;-><init>(II)V

    .line 471
    iput-object p1, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatArrayEncoder;->_values:[F

    .line 472
    return-void
.end method


# virtual methods
.method public encodeMore([BII)I
    .locals 4
    .param p1, "buffer"    # [B
    .param p2, "ptr"    # I
    .param p3, "end"    # I

    .line 488
    add-int/lit8 v0, p3, -0x21

    .line 489
    .local v0, "lastOk":I
    :goto_0
    if-gt p2, v0, :cond_0

    iget v1, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatArrayEncoder;->_ptr:I

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatArrayEncoder;->_end:I

    if-ge v1, v2, :cond_0

    .line 490
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "ptr":I
    .local v1, "ptr":I
    const/16 v2, 0x20

    aput-byte v2, p1, p2

    .line 491
    iget-object p2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatArrayEncoder;->_values:[F

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatArrayEncoder;->_ptr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatArrayEncoder;->_ptr:I

    aget p2, p2, v2

    invoke-static {p2, p1, v1}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeFloat(F[BI)I

    move-result p2

    .end local v1    # "ptr":I
    .restart local p2    # "ptr":I
    goto :goto_0

    .line 493
    :cond_0
    return p2
.end method

.method public encodeMore([CII)I
    .locals 4
    .param p1, "buffer"    # [C
    .param p2, "ptr"    # I
    .param p3, "end"    # I

    .line 477
    add-int/lit8 v0, p3, -0x21

    .line 478
    .local v0, "lastOk":I
    :goto_0
    if-gt p2, v0, :cond_0

    iget v1, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatArrayEncoder;->_ptr:I

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatArrayEncoder;->_end:I

    if-ge v1, v2, :cond_0

    .line 479
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "ptr":I
    .local v1, "ptr":I
    const/16 v2, 0x20

    aput-char v2, p1, p2

    .line 480
    iget-object p2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatArrayEncoder;->_values:[F

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatArrayEncoder;->_ptr:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$FloatArrayEncoder;->_ptr:I

    aget p2, p2, v2

    invoke-static {p2, p1, v1}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeFloat(F[CI)I

    move-result p2

    .end local v1    # "ptr":I
    .restart local p2    # "ptr":I
    goto :goto_0

    .line 482
    :cond_0
    return p2
.end method
