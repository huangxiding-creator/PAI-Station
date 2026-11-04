.class final Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntEncoder;
.super Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TypedScalarEncoder;
.source "ValueEncoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "IntEncoder"
.end annotation


# instance fields
.field _value:I


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 280
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TypedScalarEncoder;-><init>()V

    return-void
.end method


# virtual methods
.method public encodeMore([BII)I
    .locals 1
    .param p1, "buffer"    # [B
    .param p2, "ptr"    # I
    .param p3, "end"    # I

    .line 293
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntEncoder;->_value:I

    invoke-static {v0, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeInt(I[BI)I

    move-result v0

    return v0
.end method

.method public encodeMore([CII)I
    .locals 1
    .param p1, "buffer"    # [C
    .param p2, "ptr"    # I
    .param p3, "end"    # I

    .line 288
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntEncoder;->_value:I

    invoke-static {v0, p1, p2}, Lorg/codehaus/stax2/ri/typed/NumberUtil;->writeInt(I[CI)I

    move-result v0

    return v0
.end method

.method protected reset(I)V
    .locals 0
    .param p1, "value"    # I

    .line 283
    iput p1, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$IntEncoder;->_value:I

    .line 284
    return-void
.end method
