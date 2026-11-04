.class public final Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;
.super Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;
.source "ValueDecoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "IntArrayDecoder"
.end annotation


# instance fields
.field final mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

.field mResult:[I


# direct methods
.method public constructor <init>(Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;)V
    .locals 2
    .param p1, "intDecoder"    # Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    .line 1251
    const/4 v0, 0x0

    const/16 v1, 0x28

    invoke-direct {p0, v0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;-><init>(II)V

    .line 1252
    new-array v0, v1, [I

    iput-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mResult:[I

    .line 1253
    iput-object p1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    .line 1254
    return-void
.end method

.method public constructor <init>([IIILorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;)V
    .locals 0
    .param p1, "result"    # [I
    .param p2, "start"    # I
    .param p3, "maxCount"    # I
    .param p4, "intDecoder"    # Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    .line 1240
    invoke-direct {p0, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;-><init>(II)V

    .line 1241
    iput-object p1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mResult:[I

    .line 1242
    iput-object p4, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    .line 1243
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

    .line 1279
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    invoke-virtual {v0, p1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->decode(Ljava/lang/String;)V

    .line 1280
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mResult:[I

    iget v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mStart:I

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mCount:I

    add-int/2addr v1, v2

    iget-object v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    invoke-virtual {v2}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->getValue()I

    move-result v2

    aput v2, v0, v1

    .line 1281
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mCount:I

    const/4 v1, 0x1

    add-int/2addr v0, v1

    iput v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mCount:I

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mEnd:I

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

    .line 1287
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    invoke-virtual {v0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->decode([CII)V

    .line 1288
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mResult:[I

    iget v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mStart:I

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mCount:I

    add-int/2addr v1, v2

    iget-object v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mDecoder:Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;

    invoke-virtual {v2}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntDecoder;->getValue()I

    move-result v2

    aput v2, v0, v1

    .line 1289
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mCount:I

    const/4 v1, 0x1

    add-int/2addr v0, v1

    iput v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mCount:I

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mEnd:I

    if-lt v0, v2, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method public expand()V
    .locals 6

    .line 1259
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mResult:[I

    .line 1260
    .local v0, "old":[I
    array-length v1, v0

    .line 1261
    .local v1, "oldLen":I
    invoke-virtual {p0, v1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->calcNewSize(I)I

    move-result v2

    .line 1262
    .local v2, "newSize":I
    new-array v3, v2, [I

    iput-object v3, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mResult:[I

    .line 1263
    iget v3, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mStart:I

    iget-object v4, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mResult:[I

    const/4 v5, 0x0

    invoke-static {v0, v3, v4, v5, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1264
    iput v5, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mStart:I

    .line 1265
    iput v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mEnd:I

    .line 1266
    return-void
.end method

.method public getValues()[I
    .locals 5

    .line 1270
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mCount:I

    new-array v0, v0, [I

    .line 1272
    .local v0, "result":[I
    iget-object v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mResult:[I

    iget v2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mStart:I

    const/4 v3, 0x0

    iget v4, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$IntArrayDecoder;->mCount:I

    invoke-static {v1, v2, v0, v3, v4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 1273
    return-object v0
.end method
