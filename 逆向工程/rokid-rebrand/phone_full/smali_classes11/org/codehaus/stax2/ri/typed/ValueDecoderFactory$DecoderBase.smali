.class public abstract Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;
.super Lorg/codehaus/stax2/typed/TypedValueDecoder;
.source "ValueDecoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "DecoderBase"
.end annotation


# static fields
.field static final BD_MAX_LONG:Ljava/math/BigInteger;

.field static final BD_MIN_LONG:Ljava/math/BigInteger;

.field static final L_BILLION:J = 0x3b9aca00L

.field static final L_MAX_INT:J = 0x7fffffffL

.field static final L_MIN_INT:J = -0x80000000L


# instance fields
.field protected mNextPtr:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 187
    const-wide/high16 v0, -0x8000000000000000L

    invoke-static {v0, v1}, Ljava/math/BigInteger;->valueOf(J)Ljava/math/BigInteger;

    move-result-object v0

    sput-object v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;->BD_MIN_LONG:Ljava/math/BigInteger;

    .line 188
    const-wide v0, 0x7fffffffffffffffL

    invoke-static {v0, v1}, Ljava/math/BigInteger;->valueOf(J)Ljava/math/BigInteger;

    move-result-object v0

    sput-object v0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;->BD_MAX_LONG:Ljava/math/BigInteger;

    return-void
.end method

.method protected constructor <init>()V
    .locals 0

    .line 195
    invoke-direct {p0}, Lorg/codehaus/stax2/typed/TypedValueDecoder;-><init>()V

    return-void
.end method

.method protected static final parseInt(ILjava/lang/String;II)I
    .locals 2
    .param p0, "num"    # I
    .param p1, "digitChars"    # Ljava/lang/String;
    .param p2, "start"    # I
    .param p3, "end"    # I

    .line 414
    mul-int/lit8 v0, p0, 0xa

    invoke-virtual {p1, p2}, Ljava/lang/String;->charAt(I)C

    move-result v1

    add-int/lit8 v1, v1, -0x30

    add-int/2addr v0, v1

    .line 415
    .end local p0    # "num":I
    .local v0, "num":I
    add-int/lit8 p2, p2, 0x1

    if-ge p2, p3, :cond_0

    .line 416
    mul-int/lit8 p0, v0, 0xa

    invoke-virtual {p1, p2}, Ljava/lang/String;->charAt(I)C

    move-result v1

    add-int/lit8 v1, v1, -0x30

    add-int v0, p0, v1

    .line 417
    add-int/lit8 p2, p2, 0x1

    if-ge p2, p3, :cond_0

    .line 418
    mul-int/lit8 p0, v0, 0xa

    invoke-virtual {p1, p2}, Ljava/lang/String;->charAt(I)C

    move-result v1

    add-int/lit8 v1, v1, -0x30

    add-int v0, p0, v1

    .line 419
    add-int/lit8 p2, p2, 0x1

    if-ge p2, p3, :cond_0

    .line 420
    mul-int/lit8 p0, v0, 0xa

    invoke-virtual {p1, p2}, Ljava/lang/String;->charAt(I)C

    move-result v1

    add-int/lit8 v1, v1, -0x30

    add-int v0, p0, v1

    .line 421
    add-int/lit8 p2, p2, 0x1

    if-ge p2, p3, :cond_0

    .line 422
    mul-int/lit8 p0, v0, 0xa

    invoke-virtual {p1, p2}, Ljava/lang/String;->charAt(I)C

    move-result v1

    add-int/lit8 v1, v1, -0x30

    add-int v0, p0, v1

    .line 423
    add-int/lit8 p2, p2, 0x1

    if-ge p2, p3, :cond_0

    .line 424
    mul-int/lit8 p0, v0, 0xa

    invoke-virtual {p1, p2}, Ljava/lang/String;->charAt(I)C

    move-result v1

    add-int/lit8 v1, v1, -0x30

    add-int v0, p0, v1

    .line 425
    add-int/lit8 p2, p2, 0x1

    if-ge p2, p3, :cond_0

    .line 426
    mul-int/lit8 p0, v0, 0xa

    invoke-virtual {p1, p2}, Ljava/lang/String;->charAt(I)C

    move-result v1

    add-int/lit8 v1, v1, -0x30

    add-int v0, p0, v1

    .line 427
    add-int/lit8 p2, p2, 0x1

    if-ge p2, p3, :cond_0

    .line 428
    mul-int/lit8 p0, v0, 0xa

    invoke-virtual {p1, p2}, Ljava/lang/String;->charAt(I)C

    move-result v1

    add-int/lit8 v1, v1, -0x30

    add-int v0, p0, v1

    .line 436
    :cond_0
    return v0
.end method

.method protected static final parseInt(I[CII)I
    .locals 2
    .param p0, "num"    # I
    .param p1, "digitChars"    # [C
    .param p2, "start"    # I
    .param p3, "end"    # I

    .line 357
    mul-int/lit8 v0, p0, 0xa

    aget-char v1, p1, p2

    add-int/lit8 v1, v1, -0x30

    add-int/2addr v0, v1

    .line 358
    .end local p0    # "num":I
    .local v0, "num":I
    add-int/lit8 p2, p2, 0x1

    if-ge p2, p3, :cond_0

    .line 359
    mul-int/lit8 p0, v0, 0xa

    aget-char v1, p1, p2

    add-int/lit8 v1, v1, -0x30

    add-int v0, p0, v1

    .line 360
    add-int/lit8 p2, p2, 0x1

    if-ge p2, p3, :cond_0

    .line 361
    mul-int/lit8 p0, v0, 0xa

    aget-char v1, p1, p2

    add-int/lit8 v1, v1, -0x30

    add-int v0, p0, v1

    .line 362
    add-int/lit8 p2, p2, 0x1

    if-ge p2, p3, :cond_0

    .line 363
    mul-int/lit8 p0, v0, 0xa

    aget-char v1, p1, p2

    add-int/lit8 v1, v1, -0x30

    add-int v0, p0, v1

    .line 364
    add-int/lit8 p2, p2, 0x1

    if-ge p2, p3, :cond_0

    .line 365
    mul-int/lit8 p0, v0, 0xa

    aget-char v1, p1, p2

    add-int/lit8 v1, v1, -0x30

    add-int v0, p0, v1

    .line 366
    add-int/lit8 p2, p2, 0x1

    if-ge p2, p3, :cond_0

    .line 367
    mul-int/lit8 p0, v0, 0xa

    aget-char v1, p1, p2

    add-int/lit8 v1, v1, -0x30

    add-int v0, p0, v1

    .line 368
    add-int/lit8 p2, p2, 0x1

    if-ge p2, p3, :cond_0

    .line 369
    mul-int/lit8 p0, v0, 0xa

    aget-char v1, p1, p2

    add-int/lit8 v1, v1, -0x30

    add-int v0, p0, v1

    .line 370
    add-int/lit8 p2, p2, 0x1

    if-ge p2, p3, :cond_0

    .line 371
    mul-int/lit8 p0, v0, 0xa

    aget-char v1, p1, p2

    add-int/lit8 v1, v1, -0x30

    add-int v0, p0, v1

    .line 379
    :cond_0
    return v0
.end method

.method protected static final parseInt(Ljava/lang/String;II)I
    .locals 3
    .param p0, "digitChars"    # Ljava/lang/String;
    .param p1, "start"    # I
    .param p2, "end"    # I

    .line 384
    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    add-int/lit8 v0, v0, -0x30

    .line 385
    .local v0, "num":I
    add-int/lit8 p1, p1, 0x1

    if-ge p1, p2, :cond_0

    .line 386
    mul-int/lit8 v1, v0, 0xa

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    add-int/lit8 v2, v2, -0x30

    add-int v0, v1, v2

    .line 387
    add-int/lit8 p1, p1, 0x1

    if-ge p1, p2, :cond_0

    .line 388
    mul-int/lit8 v1, v0, 0xa

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    add-int/lit8 v2, v2, -0x30

    add-int v0, v1, v2

    .line 389
    add-int/lit8 p1, p1, 0x1

    if-ge p1, p2, :cond_0

    .line 390
    mul-int/lit8 v1, v0, 0xa

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    add-int/lit8 v2, v2, -0x30

    add-int v0, v1, v2

    .line 391
    add-int/lit8 p1, p1, 0x1

    if-ge p1, p2, :cond_0

    .line 392
    mul-int/lit8 v1, v0, 0xa

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    add-int/lit8 v2, v2, -0x30

    add-int v0, v1, v2

    .line 393
    add-int/lit8 p1, p1, 0x1

    if-ge p1, p2, :cond_0

    .line 394
    mul-int/lit8 v1, v0, 0xa

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    add-int/lit8 v2, v2, -0x30

    add-int v0, v1, v2

    .line 395
    add-int/lit8 p1, p1, 0x1

    if-ge p1, p2, :cond_0

    .line 396
    mul-int/lit8 v1, v0, 0xa

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    add-int/lit8 v2, v2, -0x30

    add-int v0, v1, v2

    .line 397
    add-int/lit8 p1, p1, 0x1

    if-ge p1, p2, :cond_0

    .line 398
    mul-int/lit8 v1, v0, 0xa

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    add-int/lit8 v2, v2, -0x30

    add-int v0, v1, v2

    .line 399
    add-int/lit8 p1, p1, 0x1

    if-ge p1, p2, :cond_0

    .line 400
    mul-int/lit8 v1, v0, 0xa

    invoke-virtual {p0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    add-int/lit8 v2, v2, -0x30

    add-int v0, v1, v2

    .line 409
    :cond_0
    return v0
.end method

.method protected static final parseInt([CII)I
    .locals 3
    .param p0, "digitChars"    # [C
    .param p1, "start"    # I
    .param p2, "end"    # I

    .line 327
    aget-char v0, p0, p1

    add-int/lit8 v0, v0, -0x30

    .line 328
    .local v0, "num":I
    add-int/lit8 p1, p1, 0x1

    if-ge p1, p2, :cond_0

    .line 329
    mul-int/lit8 v1, v0, 0xa

    aget-char v2, p0, p1

    add-int/lit8 v2, v2, -0x30

    add-int v0, v1, v2

    .line 330
    add-int/lit8 p1, p1, 0x1

    if-ge p1, p2, :cond_0

    .line 331
    mul-int/lit8 v1, v0, 0xa

    aget-char v2, p0, p1

    add-int/lit8 v2, v2, -0x30

    add-int v0, v1, v2

    .line 332
    add-int/lit8 p1, p1, 0x1

    if-ge p1, p2, :cond_0

    .line 333
    mul-int/lit8 v1, v0, 0xa

    aget-char v2, p0, p1

    add-int/lit8 v2, v2, -0x30

    add-int v0, v1, v2

    .line 334
    add-int/lit8 p1, p1, 0x1

    if-ge p1, p2, :cond_0

    .line 335
    mul-int/lit8 v1, v0, 0xa

    aget-char v2, p0, p1

    add-int/lit8 v2, v2, -0x30

    add-int v0, v1, v2

    .line 336
    add-int/lit8 p1, p1, 0x1

    if-ge p1, p2, :cond_0

    .line 337
    mul-int/lit8 v1, v0, 0xa

    aget-char v2, p0, p1

    add-int/lit8 v2, v2, -0x30

    add-int v0, v1, v2

    .line 338
    add-int/lit8 p1, p1, 0x1

    if-ge p1, p2, :cond_0

    .line 339
    mul-int/lit8 v1, v0, 0xa

    aget-char v2, p0, p1

    add-int/lit8 v2, v2, -0x30

    add-int v0, v1, v2

    .line 340
    add-int/lit8 p1, p1, 0x1

    if-ge p1, p2, :cond_0

    .line 341
    mul-int/lit8 v1, v0, 0xa

    aget-char v2, p0, p1

    add-int/lit8 v2, v2, -0x30

    add-int v0, v1, v2

    .line 342
    add-int/lit8 p1, p1, 0x1

    if-ge p1, p2, :cond_0

    .line 343
    mul-int/lit8 v1, v0, 0xa

    aget-char v2, p0, p1

    add-int/lit8 v2, v2, -0x30

    add-int v0, v1, v2

    .line 352
    :cond_0
    return v0
.end method

.method protected static final parseLong(Ljava/lang/String;II)J
    .locals 5
    .param p0, "digitChars"    # Ljava/lang/String;
    .param p1, "start"    # I
    .param p2, "end"    # I

    .line 450
    add-int/lit8 v0, p2, -0x9

    .line 451
    .local v0, "start2":I
    invoke-static {p0, p1, v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;->parseInt(Ljava/lang/String;II)I

    move-result v1

    int-to-long v1, v1

    const-wide/32 v3, 0x3b9aca00

    mul-long/2addr v1, v3

    .line 452
    .local v1, "val":J
    invoke-static {p0, v0, p2}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;->parseInt(Ljava/lang/String;II)I

    move-result v3

    int-to-long v3, v3

    add-long/2addr v3, v1

    return-wide v3
.end method

.method protected static final parseLong([CII)J
    .locals 5
    .param p0, "digitChars"    # [C
    .param p1, "start"    # I
    .param p2, "end"    # I

    .line 442
    add-int/lit8 v0, p2, -0x9

    .line 443
    .local v0, "start2":I
    invoke-static {p0, p1, v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;->parseInt([CII)I

    move-result v1

    int-to-long v1, v1

    const-wide/32 v3, 0x3b9aca00

    mul-long/2addr v1, v3

    .line 444
    .local v1, "val":J
    invoke-static {p0, v0, p2}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;->parseInt([CII)I

    move-result v3

    int-to-long v3, v3

    add-long/2addr v3, v1

    return-wide v3
.end method


# virtual methods
.method protected _clean(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "str"    # Ljava/lang/String;

    .line 485
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected constructInvalidValue(Ljava/lang/String;)Ljava/lang/IllegalArgumentException;
    .locals 3
    .param p1, "lexical"    # Ljava/lang/String;

    .line 464
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Value \""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\" not a valid lexical representation of "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;->getType()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    return-object v0
.end method

.method protected constructInvalidValue([CII)Ljava/lang/IllegalArgumentException;
    .locals 3
    .param p1, "lexical"    # [C
    .param p2, "startOffset"    # I
    .param p3, "end"    # I

    .line 469
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Value \""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;->lexicalDesc([CII)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\" not a valid lexical representation of "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;->getType()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    return-object v0
.end method

.method public abstract getType()Ljava/lang/String;
.end method

.method public handleEmptyValue()V
    .locals 3

    .line 210
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Empty value (all white space) not a valid lexical representation of "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;->getType()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected lexicalDesc(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "lexical"    # Ljava/lang/String;

    .line 479
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;->_clean(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected lexicalDesc([CII)Ljava/lang/String;
    .locals 2
    .param p1, "lexical"    # [C
    .param p2, "startOffset"    # I
    .param p3, "end"    # I

    .line 474
    new-instance v0, Ljava/lang/String;

    sub-int v1, p3, p2

    invoke-direct {v0, p1, p2, v1}, Ljava/lang/String;-><init>([CII)V

    invoke-virtual {p0, v0}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;->_clean(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected skipSignAndZeroes(Ljava/lang/String;CZI)I
    .locals 4
    .param p1, "lexical"    # Ljava/lang/String;
    .param p2, "ch"    # C
    .param p3, "hasSign"    # Z
    .param p4, "end"    # I

    .line 251
    if-eqz p3, :cond_1

    .line 252
    const/4 v0, 0x1

    .line 253
    .local v0, "ptr":I
    if-ge v0, p4, :cond_0

    .line 256
    add-int/lit8 v1, v0, 0x1

    .end local v0    # "ptr":I
    .local v1, "ptr":I
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result p2

    goto :goto_0

    .line 254
    .end local v1    # "ptr":I
    .restart local v0    # "ptr":I
    :cond_0
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;->constructInvalidValue(Ljava/lang/String;)Ljava/lang/IllegalArgumentException;

    move-result-object v1

    throw v1

    .line 258
    .end local v0    # "ptr":I
    :cond_1
    const/4 v1, 0x1

    .line 262
    .restart local v1    # "ptr":I
    :goto_0
    add-int/lit8 v0, p2, -0x30

    .line 263
    .local v0, "value":I
    if-ltz v0, :cond_4

    const/16 v2, 0x9

    if-gt v0, v2, :cond_4

    .line 268
    :goto_1
    if-nez v0, :cond_3

    if-ge v1, p4, :cond_3

    .line 269
    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v3

    add-int/lit8 v3, v3, -0x30

    .line 270
    .local v3, "v2":I
    if-ltz v3, :cond_3

    if-le v3, v2, :cond_2

    .line 271
    goto :goto_2

    .line 273
    :cond_2
    add-int/lit8 v1, v1, 0x1

    .line 274
    move v0, v3

    .line 275
    .end local v3    # "v2":I
    goto :goto_1

    .line 276
    :cond_3
    :goto_2
    iput v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;->mNextPtr:I

    .line 277
    return v0

    .line 264
    :cond_4
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;->constructInvalidValue(Ljava/lang/String;)Ljava/lang/IllegalArgumentException;

    move-result-object v2

    throw v2
.end method

.method protected skipSignAndZeroes([CCZII)I
    .locals 4
    .param p1, "lexical"    # [C
    .param p2, "ch"    # C
    .param p3, "hasSign"    # Z
    .param p4, "start"    # I
    .param p5, "end"    # I

    .line 282
    add-int/lit8 v0, p4, 0x1

    .line 283
    .local v0, "ptr":I
    if-eqz p3, :cond_1

    .line 284
    if-ge v0, p5, :cond_0

    .line 287
    add-int/lit8 v1, v0, 0x1

    .end local v0    # "ptr":I
    .local v1, "ptr":I
    aget-char p2, p1, v0

    move v0, v1

    goto :goto_0

    .line 285
    .end local v1    # "ptr":I
    .restart local v0    # "ptr":I
    :cond_0
    invoke-virtual {p0, p1, p4, p5}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;->constructInvalidValue([CII)Ljava/lang/IllegalArgumentException;

    move-result-object v1

    throw v1

    .line 291
    :cond_1
    :goto_0
    add-int/lit8 v1, p2, -0x30

    .line 292
    .local v1, "value":I
    if-ltz v1, :cond_4

    const/16 v2, 0x9

    if-gt v1, v2, :cond_4

    .line 297
    :goto_1
    if-nez v1, :cond_3

    if-ge v0, p5, :cond_3

    .line 298
    aget-char v3, p1, v0

    add-int/lit8 v3, v3, -0x30

    .line 299
    .local v3, "v2":I
    if-ltz v3, :cond_3

    if-le v3, v2, :cond_2

    .line 300
    goto :goto_2

    .line 302
    :cond_2
    add-int/lit8 v0, v0, 0x1

    .line 303
    move v1, v3

    .line 304
    .end local v3    # "v2":I
    goto :goto_1

    .line 305
    :cond_3
    :goto_2
    iput v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;->mNextPtr:I

    .line 306
    return v1

    .line 293
    :cond_4
    invoke-virtual {p0, p1, p4, p5}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;->constructInvalidValue([CII)Ljava/lang/IllegalArgumentException;

    move-result-object v2

    throw v2
.end method

.method protected verifyDigits(Ljava/lang/String;II)V
    .locals 2
    .param p1, "lexical"    # Ljava/lang/String;
    .param p2, "start"    # I
    .param p3, "end"    # I

    .line 225
    nop

    :goto_0
    if-ge p2, p3, :cond_1

    .line 226
    invoke-virtual {p1, p2}, Ljava/lang/String;->charAt(I)C

    move-result v0

    .line 227
    .local v0, "ch":C
    const/16 v1, 0x39

    if-gt v0, v1, :cond_0

    const/16 v1, 0x30

    if-lt v0, v1, :cond_0

    .line 225
    .end local v0    # "ch":C
    add-int/lit8 p2, p2, 0x1

    goto :goto_0

    .line 228
    .restart local v0    # "ch":C
    :cond_0
    invoke-virtual {p0, p1}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;->constructInvalidValue(Ljava/lang/String;)Ljava/lang/IllegalArgumentException;

    move-result-object v1

    throw v1

    .line 231
    .end local v0    # "ch":C
    :cond_1
    return-void
.end method

.method protected verifyDigits([CIII)V
    .locals 2
    .param p1, "lexical"    # [C
    .param p2, "start"    # I
    .param p3, "end"    # I
    .param p4, "ptr"    # I

    .line 235
    nop

    :goto_0
    if-ge p4, p3, :cond_1

    .line 236
    aget-char v0, p1, p4

    .line 237
    .local v0, "ch":C
    const/16 v1, 0x39

    if-gt v0, v1, :cond_0

    const/16 v1, 0x30

    if-lt v0, v1, :cond_0

    .line 235
    .end local v0    # "ch":C
    add-int/lit8 p4, p4, 0x1

    goto :goto_0

    .line 238
    .restart local v0    # "ch":C
    :cond_0
    invoke-virtual {p0, p1, p2, p3}, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$DecoderBase;->constructInvalidValue([CII)Ljava/lang/IllegalArgumentException;

    move-result-object v1

    throw v1

    .line 241
    .end local v0    # "ch":C
    :cond_1
    return-void
.end method
