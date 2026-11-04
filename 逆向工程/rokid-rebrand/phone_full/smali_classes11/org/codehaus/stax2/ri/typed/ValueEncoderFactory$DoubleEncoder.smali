.class final Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleEncoder;
.super Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TypedScalarEncoder;
.source "ValueEncoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "DoubleEncoder"
.end annotation


# instance fields
.field _value:D


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 346
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TypedScalarEncoder;-><init>()V

    return-void
.end method


# virtual methods
.method public encodeMore([BII)I
    .locals 2
    .param p1, "buffer"    # [B
    .param p2, "ptr"    # I
    .param p3, "end"    # I

    .line 359
    iget-wide v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleEncoder;->_value:D

    invoke-static {v0, v1, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeDouble(D[BI)I

    move-result v0

    return v0
.end method

.method public encodeMore([CII)I
    .locals 2
    .param p1, "buffer"    # [C
    .param p2, "ptr"    # I
    .param p3, "end"    # I

    .line 354
    iget-wide v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleEncoder;->_value:D

    invoke-static {v0, v1, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeDouble(D[CI)I

    move-result v0

    return v0
.end method

.method protected reset(D)V
    .locals 0
    .param p1, "value"    # D

    .line 349
    iput-wide p1, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$DoubleEncoder;->_value:D

    .line 350
    return-void
.end method
