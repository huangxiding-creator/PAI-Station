.class public final Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;
.super Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;
.source "ValueDecoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "LongArrayDecoder"
.end annotation


# instance fields
.field final mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

.field mResult:[J


# direct methods
.method public constructor <init>(Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;)V
    .locals 2
    .param p1, "longDecoder"    # Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    .line 1311
    const/4 v0, 0x0

    const/16 v1, 0x28

    invoke-direct {p0, v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;-><init>(II)V

    .line 1312
    new-array v0, v1, [J

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mResult:[J

    .line 1313
    iput-object p1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    .line 1314
    return-void
.end method

.method public constructor <init>([JIILorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;)V
    .locals 0
    .param p1, "result"    # [J
    .param p2, "start"    # I
    .param p3, "maxCount"    # I
    .param p4, "longDecoder"    # Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    .line 1304
    invoke-direct {p0, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;-><init>(II)V

    .line 1305
    iput-object p1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mResult:[J

    .line 1306
    iput-object p4, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    .line 1307
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

    .line 1338
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    invoke-virtual {v0, p1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->decode(Ljava/lang/String;)V

    .line 1339
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mResult:[J

    iget v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mStart:I

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mCount:I

    add-int/2addr v1, v2

    iget-object v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    invoke-virtual {v2}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->getValue()J

    move-result-wide v2

    aput-wide v2, v0, v1

    .line 1340
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mCount:I

    const/4 v1, 0x1

    add-int/2addr v0, v1

    iput v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mCount:I

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mEnd:I

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

    .line 1346
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->decode([CII)V

    .line 1347
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mResult:[J

    iget v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mStart:I

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mCount:I

    add-int/2addr v1, v2

    iget-object v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;

    invoke-virtual {v2}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongDecoder;->getValue()J

    move-result-wide v2

    aput-wide v2, v0, v1

    .line 1348
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mCount:I

    const/4 v1, 0x1

    add-int/2addr v0, v1

    iput v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mCount:I

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mEnd:I

    if-lt v0, v2, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method public expand()V
    .locals 6

    .line 1319
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mResult:[J

    .line 1320
    .local v0, "old":[J
    array-length v1, v0

    .line 1321
    .local v1, "oldLen":I
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->calcNewSize(I)I

    move-result v2

    .line 1322
    .local v2, "newSize":I
    new-array v3, v2, [J

    iput-object v3, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mResult:[J

    .line 1323
    iget v3, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mStart:I

    iget-object v4, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mResult:[J

    const/4 v5, 0x0

    invoke-static {v0, v3, v4, v5, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1324
    iput v5, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mStart:I

    .line 1325
    iput v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mEnd:I

    .line 1326
    return-void
.end method

.method public getValues()[J
    .locals 5

    .line 1330
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mCount:I

    new-array v0, v0, [J

    .line 1331
    .local v0, "result":[J
    iget-object v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mResult:[J

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mStart:I

    const/4 v3, 0x0

    iget v4, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$LongArrayDecoder;->mCount:I

    invoke-static {v1, v2, v0, v3, v4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1332
    return-object v0
.end method
