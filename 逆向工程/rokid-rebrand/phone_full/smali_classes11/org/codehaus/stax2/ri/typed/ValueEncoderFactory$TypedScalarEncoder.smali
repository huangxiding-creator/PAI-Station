.class abstract Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$TypedScalarEncoder;
.super Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ScalarEncoder;
.source "ValueEncoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x408
    name = "TypedScalarEncoder"
.end annotation


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 264
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$ScalarEncoder;-><init>()V

    return-void
.end method


# virtual methods
.method public final isCompleted()Z
    .locals 1

    .line 272
    const/4 v0, 0x1

    return v0
.end method
