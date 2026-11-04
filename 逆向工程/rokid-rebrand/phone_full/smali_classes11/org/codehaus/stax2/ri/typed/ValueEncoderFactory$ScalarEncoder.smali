.class abstract Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ScalarEncoder;
.super Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;
.source "ValueEncoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x408
    name = "ScalarEncoder"
.end annotation


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 151
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;-><init>()V

    return-void
.end method
