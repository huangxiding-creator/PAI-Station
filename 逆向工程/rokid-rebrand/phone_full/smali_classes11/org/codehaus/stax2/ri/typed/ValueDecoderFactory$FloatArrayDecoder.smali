.class public final Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;
.super Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;
.source "ValueDecoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "FloatArrayDecoder"
.end annotation


# instance fields
.field final mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

.field mResult:[F


# direct methods
.method public constructor <init>(Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;)V
    .locals 2
    .param p1, "floatDecoder"    # Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    .line 1369
    const/4 v0, 0x0

    const/16 v1, 0x28

    invoke-direct {p0, v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;-><init>(II)V

    .line 1370
    new-array v0, v1, [F

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mResult:[F

    .line 1371
    iput-object p1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    .line 1372
    return-void
.end method

.method public constructor <init>([FIILorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;)V
    .locals 0
    .param p1, "result"    # [F
    .param p2, "start"    # I
    .param p3, "maxCount"    # I
    .param p4, "floatDecoder"    # Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    .line 1362
    invoke-direct {p0, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;-><init>(II)V

    .line 1363
    iput-object p1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mResult:[F

    .line 1364
    iput-object p4, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    .line 1365
    return-void
.end method


# virtual methods
.method public decodeValue(Ljava/lang/String;)Z
    .locals 3
    .param p1, "input"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 1396
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    invoke-virtual {v0, p1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;->decode(Ljava/lang/String;)V

    .line 1397
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mResult:[F

    iget v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mStart:I

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mCount:I

    add-int/2addr v1, v2

    iget-object v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    invoke-virtual {v2}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;->getValue()F

    move-result v2

    aput v2, v0, v1

    .line 1398
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mCount:I

    const/4 v1, 0x1

    add-int/2addr v0, v1

    iput v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mCount:I

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mEnd:I

    if-lt v0, v2, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method public decodeValue([CII)Z
    .locals 3
    .param p1, "buffer"    # [C
    .param p2, "start"    # I
    .param p3, "end"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 1404
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;->decode([CII)V

    .line 1405
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mResult:[F

    iget v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mStart:I

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mCount:I

    add-int/2addr v1, v2

    iget-object v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;

    invoke-virtual {v2}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatDecoder;->getValue()F

    move-result v2

    aput v2, v0, v1

    .line 1406
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mCount:I

    const/4 v1, 0x1

    add-int/2addr v0, v1

    iput v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mCount:I

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mEnd:I

    if-lt v0, v2, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method public expand()V
    .locals 6

    .line 1377
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mResult:[F

    .line 1378
    .local v0, "old":[F
    array-length v1, v0

    .line 1379
    .local v1, "oldLen":I
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->calcNewSize(I)I

    move-result v2

    .line 1380
    .local v2, "newSize":I
    new-array v3, v2, [F

    iput-object v3, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mResult:[F

    .line 1381
    iget v3, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mStart:I

    iget-object v4, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mResult:[F

    const/4 v5, 0x0

    invoke-static {v0, v3, v4, v5, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1382
    iput v5, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mStart:I

    .line 1383
    iput v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mEnd:I

    .line 1384
    return-void
.end method

.method public getValues()[F
    .locals 5

    .line 1388
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mCount:I

    new-array v0, v0, [F

    .line 1389
    .local v0, "result":[F
    iget-object v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mResult:[F

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mStart:I

    const/4 v3, 0x0

    iget v4, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$FloatArrayDecoder;->mCount:I

    invoke-static {v1, v2, v0, v3, v4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1390
    return-object v0
.end method
