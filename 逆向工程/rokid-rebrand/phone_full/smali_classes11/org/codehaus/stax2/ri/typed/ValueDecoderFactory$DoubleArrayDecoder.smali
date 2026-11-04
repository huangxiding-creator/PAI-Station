.class public final Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;
.super Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;
.source "ValueDecoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "DoubleArrayDecoder"
.end annotation


# instance fields
.field final mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

.field mResult:[D


# direct methods
.method public constructor <init>(Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;)V
    .locals 2
    .param p1, "doubleDecoder"    # Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    .line 1427
    const/4 v0, 0x0

    const/16 v1, 0x28

    invoke-direct {p0, v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;-><init>(II)V

    .line 1428
    new-array v0, v1, [D

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mResult:[D

    .line 1429
    iput-object p1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    .line 1430
    return-void
.end method

.method public constructor <init>([DIILorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;)V
    .locals 0
    .param p1, "result"    # [D
    .param p2, "start"    # I
    .param p3, "maxCount"    # I
    .param p4, "doubleDecoder"    # Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    .line 1420
    invoke-direct {p0, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;-><init>(II)V

    .line 1421
    iput-object p1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mResult:[D

    .line 1422
    iput-object p4, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    .line 1423
    return-void
.end method


# virtual methods
.method public decodeValue(Ljava/lang/String;)Z
    .locals 4
    .param p1, "input"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 1454
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    invoke-virtual {v0, p1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;->decode(Ljava/lang/String;)V

    .line 1455
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mResult:[D

    iget v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mStart:I

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mCount:I

    add-int/2addr v1, v2

    iget-object v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    invoke-virtual {v2}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;->getValue()D

    move-result-wide v2

    aput-wide v2, v0, v1

    .line 1456
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mCount:I

    const/4 v1, 0x1

    add-int/2addr v0, v1

    iput v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mCount:I

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mEnd:I

    if-lt v0, v2, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method public decodeValue([CII)Z
    .locals 4
    .param p1, "buffer"    # [C
    .param p2, "start"    # I
    .param p3, "end"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 1462
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;->decode([CII)V

    .line 1463
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mResult:[D

    iget v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mStart:I

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mCount:I

    add-int/2addr v1, v2

    iget-object v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;

    invoke-virtual {v2}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleDecoder;->getValue()D

    move-result-wide v2

    aput-wide v2, v0, v1

    .line 1464
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mCount:I

    const/4 v1, 0x1

    add-int/2addr v0, v1

    iput v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mCount:I

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mEnd:I

    if-lt v0, v2, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method public expand()V
    .locals 6

    .line 1435
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mResult:[D

    .line 1436
    .local v0, "old":[D
    array-length v1, v0

    .line 1437
    .local v1, "oldLen":I
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->calcNewSize(I)I

    move-result v2

    .line 1438
    .local v2, "newSize":I
    new-array v3, v2, [D

    iput-object v3, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mResult:[D

    .line 1439
    iget v3, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mStart:I

    iget-object v4, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mResult:[D

    const/4 v5, 0x0

    invoke-static {v0, v3, v4, v5, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1440
    iput v5, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mStart:I

    .line 1441
    iput v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mEnd:I

    .line 1442
    return-void
.end method

.method public getValues()[D
    .locals 5

    .line 1446
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mCount:I

    new-array v0, v0, [D

    .line 1447
    .local v0, "result":[D
    iget-object v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mResult:[D

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mStart:I

    const/4 v3, 0x0

    iget v4, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DoubleArrayDecoder;->mCount:I

    invoke-static {v1, v2, v0, v3, v4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1448
    return-object v0
.end method
