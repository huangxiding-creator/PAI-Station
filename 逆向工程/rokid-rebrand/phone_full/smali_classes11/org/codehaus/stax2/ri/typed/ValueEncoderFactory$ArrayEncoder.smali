.class abstract Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ArrayEncoder;
.super Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;
.source "ValueEncoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x408
    name = "ArrayEncoder"
.end annotation


# instance fields
.field final _end:I

.field _ptr:I


# direct methods
.method protected constructor <init>(II)V
    .locals 0
    .param p1, "ptr"    # I
    .param p2, "end"    # I

    .line 380
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;-><init>()V

    .line 381
    iput p1, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ArrayEncoder;->_ptr:I

    .line 382
    iput p2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ArrayEncoder;->_end:I

    .line 383
    return-void
.end method


# virtual methods
.method public abstract encodeMore([CII)I
.end method

.method public final isCompleted()Z
    .locals 2

    .line 386
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ArrayEncoder;->_ptr:I

    iget v1, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ArrayEncoder;->_end:I

    if-lt v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method
