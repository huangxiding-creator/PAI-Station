.class final Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;
.super Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;
.source "ValueEncoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "Base64Encoder"
.end annotation


# static fields
.field static final LF_BYTE:B = 0xat

.field static final LF_CHAR:B = 0xat

.field static final PAD_BYTE:B = 0x3dt

.field static final PAD_CHAR:C = '='


# instance fields
.field _chunksBeforeLf:I

.field final _input:[B

.field final _inputEnd:I

.field _inputPtr:I

.field final _variant:Lorg/codehaus/stax2/typed/Base64Variant;


# direct methods
.method protected constructor <init>(Lorg/codehaus/stax2/typed/Base64Variant;[BII)V
    .locals 1
    .param p1, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .param p2, "values"    # [B
    .param p3, "from"    # I
    .param p4, "end"    # I

    .line 564
    invoke-direct {p0}, Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;-><init>()V

    .line 565
    iput-object p1, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    .line 566
    iput-object p2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_input:[B

    .line 567
    iput p3, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    .line 568
    iput p4, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputEnd:I

    .line 569
    iget-object v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {v0}, Lorg/codehaus/stax2/typed/Base64Variant;->getMaxLineLength()I

    move-result v0

    shr-int/lit8 v0, v0, 0x2

    iput v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_chunksBeforeLf:I

    .line 570
    return-void
.end method


# virtual methods
.method public encodeMore([BII)I
    .locals 7
    .param p1, "buffer"    # [B
    .param p2, "outPtr"    # I
    .param p3, "outEnd"    # I

    .line 615
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputEnd:I

    add-int/lit8 v0, v0, -0x3

    .line 616
    .local v0, "inEnd":I
    add-int/lit8 p3, p3, -0x5

    .line 618
    :goto_0
    iget v1, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    const/4 v2, 0x2

    if-gt v1, v0, :cond_2

    .line 619
    if-le p2, p3, :cond_0

    .line 620
    return p2

    .line 623
    :cond_0
    iget-object v1, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_input:[B

    iget v3, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    aget-byte v1, v1, v3

    shl-int/lit8 v1, v1, 0x8

    .line 624
    .local v1, "b24":I
    iget-object v3, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_input:[B

    iget v4, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    aget-byte v3, v3, v4

    and-int/lit16 v3, v3, 0xff

    or-int/2addr v1, v3

    .line 625
    shl-int/lit8 v3, v1, 0x8

    iget-object v4, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_input:[B

    iget v5, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    aget-byte v4, v4, v5

    and-int/lit16 v4, v4, 0xff

    or-int v1, v3, v4

    .line 626
    iget-object v3, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {v3, v1, p1, p2}, Lorg/codehaus/stax2/typed/Base64Variant;->encodeBase64Chunk(I[BI)I

    move-result p2

    .line 628
    iget v3, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_chunksBeforeLf:I

    add-int/lit8 v3, v3, -0x1

    iput v3, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_chunksBeforeLf:I

    if-gtz v3, :cond_1

    .line 629
    add-int/lit8 v3, p2, 0x1

    .end local p2    # "outPtr":I
    .local v3, "outPtr":I
    const/16 v4, 0xa

    aput-byte v4, p1, p2

    .line 630
    iget-object p2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {p2}, Lorg/codehaus/stax2/typed/Base64Variant;->getMaxLineLength()I

    move-result p2

    shr-int/2addr p2, v2

    iput p2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_chunksBeforeLf:I

    move p2, v3

    .line 632
    .end local v1    # "b24":I
    .end local v3    # "outPtr":I
    .restart local p2    # "outPtr":I
    :cond_1
    goto :goto_0

    .line 634
    :cond_2
    iget v1, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputEnd:I

    iget v3, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    sub-int/2addr v1, v3

    .line 635
    .local v1, "inputLeft":I
    if-lez v1, :cond_4

    .line 636
    if-gt p2, p3, :cond_4

    .line 637
    iget-object v3, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_input:[B

    iget v4, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    aget-byte v3, v3, v4

    shl-int/lit8 v3, v3, 0x10

    .line 638
    .local v3, "b24":I
    if-ne v1, v2, :cond_3

    .line 639
    iget-object v2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_input:[B

    iget v4, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    aget-byte v2, v2, v4

    and-int/lit16 v2, v2, 0xff

    shl-int/lit8 v2, v2, 0x8

    or-int/2addr v3, v2

    .line 641
    :cond_3
    iget-object v2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {v2, v3, v1, p1, p2}, Lorg/codehaus/stax2/typed/Base64Variant;->encodeBase64Partial(II[BI)I

    move-result p2

    .line 644
    .end local v3    # "b24":I
    :cond_4
    return p2
.end method

.method public encodeMore([CII)I
    .locals 7
    .param p1, "buffer"    # [C
    .param p2, "outPtr"    # I
    .param p3, "outEnd"    # I

    .line 579
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputEnd:I

    add-int/lit8 v0, v0, -0x3

    .line 581
    .local v0, "inEnd":I
    add-int/lit8 p3, p3, -0x5

    .line 583
    :goto_0
    iget v1, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    const/4 v2, 0x2

    if-gt v1, v0, :cond_2

    .line 584
    if-le p2, p3, :cond_0

    .line 585
    return p2

    .line 588
    :cond_0
    iget-object v1, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_input:[B

    iget v3, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    add-int/lit8 v4, v3, 0x1

    iput v4, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    aget-byte v1, v1, v3

    shl-int/lit8 v1, v1, 0x8

    .line 589
    .local v1, "b24":I
    iget-object v3, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_input:[B

    iget v4, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    aget-byte v3, v3, v4

    and-int/lit16 v3, v3, 0xff

    or-int/2addr v1, v3

    .line 590
    shl-int/lit8 v3, v1, 0x8

    iget-object v4, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_input:[B

    iget v5, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    aget-byte v4, v4, v5

    and-int/lit16 v4, v4, 0xff

    or-int v1, v3, v4

    .line 591
    iget-object v3, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {v3, v1, p1, p2}, Lorg/codehaus/stax2/typed/Base64Variant;->encodeBase64Chunk(I[CI)I

    move-result p2

    .line 593
    iget v3, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_chunksBeforeLf:I

    add-int/lit8 v3, v3, -0x1

    iput v3, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_chunksBeforeLf:I

    if-gtz v3, :cond_1

    .line 594
    add-int/lit8 v3, p2, 0x1

    .end local p2    # "outPtr":I
    .local v3, "outPtr":I
    const/16 v4, 0xa

    aput-char v4, p1, p2

    .line 595
    iget-object p2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {p2}, Lorg/codehaus/stax2/typed/Base64Variant;->getMaxLineLength()I

    move-result p2

    shr-int/2addr p2, v2

    iput p2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_chunksBeforeLf:I

    move p2, v3

    .line 597
    .end local v1    # "b24":I
    .end local v3    # "outPtr":I
    .restart local p2    # "outPtr":I
    :cond_1
    goto :goto_0

    .line 599
    :cond_2
    iget v1, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputEnd:I

    iget v3, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    sub-int/2addr v1, v3

    .line 600
    .local v1, "inputLeft":I
    if-lez v1, :cond_4

    .line 601
    if-gt p2, p3, :cond_4

    .line 602
    iget-object v3, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_input:[B

    iget v4, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    aget-byte v3, v3, v4

    shl-int/lit8 v3, v3, 0x10

    .line 603
    .local v3, "b24":I
    if-ne v1, v2, :cond_3

    .line 604
    iget-object v2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_input:[B

    iget v4, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    add-int/lit8 v5, v4, 0x1

    iput v5, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    aget-byte v2, v2, v4

    and-int/lit16 v2, v2, 0xff

    shl-int/lit8 v2, v2, 0x8

    or-int/2addr v3, v2

    .line 606
    :cond_3
    iget-object v2, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_variant:Lorg/codehaus/stax2/typed/Base64Variant;

    invoke-virtual {v2, v3, v1, p1, p2}, Lorg/codehaus/stax2/typed/Base64Variant;->encodeBase64Partial(II[CI)I

    move-result p2

    .line 609
    .end local v3    # "b24":I
    :cond_4
    return p2
.end method

.method public isCompleted()Z
    .locals 2

    .line 573
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputPtr:I

    iget v1, p0, Lorg/codehaus/stax2/ri/typed/ValueEncoderFactory$Base64Encoder;->_inputEnd:I

    if-lt v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method
