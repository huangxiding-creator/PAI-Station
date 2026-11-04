.class public Lorg/apache/commons/compress/archivers/tar/TarUtils;
.super Ljava/lang/Object;
.source "TarUtils.java"


# static fields
.field private static final BYTE_MASK:I = 0xff

.field static final DEFAULT_ENCODING:Lorg/apache/commons/compress/archivers/zip/ZipEncoding;

.field static final FALLBACK_ENCODING:Lorg/apache/commons/compress/archivers/zip/ZipEncoding;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 53
    nop

    .line 54
    const/4 v0, 0x0

    invoke-static {v0}, Lorg/apache/commons/compress/archivers/zip/ZipEncodingHelper;->getZipEncoding(Ljava/lang/String;)Lorg/apache/commons/compress/archivers/zip/ZipEncoding;

    move-result-object v0

    sput-object v0, Lorg/apache/commons/compress/archivers/tar/TarUtils;->DEFAULT_ENCODING:Lorg/apache/commons/compress/archivers/zip/ZipEncoding;

    .line 60
    new-instance v0, Lorg/apache/commons/compress/archivers/tar/TarUtils$1;

    invoke-direct {v0}, Lorg/apache/commons/compress/archivers/tar/TarUtils$1;-><init>()V

    sput-object v0, Lorg/apache/commons/compress/archivers/tar/TarUtils;->FALLBACK_ENCODING:Lorg/apache/commons/compress/archivers/zip/ZipEncoding;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 93
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 94
    return-void
.end method

.method public static computeCheckSum([B)J
    .locals 7
    .param p0, "buf"    # [B

    .line 616
    const-wide/16 v0, 0x0

    .line 618
    .local v0, "sum":J
    array-length v2, p0

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_0

    aget-byte v4, p0, v3

    .line 619
    .local v4, "element":B
    and-int/lit16 v5, v4, 0xff

    int-to-long v5, v5

    add-long/2addr v0, v5

    .line 618
    .end local v4    # "element":B
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 622
    :cond_0
    return-wide v0
.end method

.method private static exceptionMessage([BIIIB)Ljava/lang/String;
    .locals 3
    .param p0, "buffer"    # [B
    .param p1, "offset"    # I
    .param p2, "length"    # I
    .param p3, "current"    # I
    .param p4, "currentByte"    # B

    .line 257
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p0, p1, p2}, Ljava/lang/String;-><init>([BII)V

    .line 259
    .local v0, "string":Ljava/lang/String;
    const-string v1, "\u0000"

    const-string/jumbo v2, "{NUL}"

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    .line 260
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid byte "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " at offset "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sub-int v2, p3, p1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " in \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\' len="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method private static formatBigIntegerBinary(J[BIIZ)V
    .locals 6
    .param p0, "value"    # J
    .param p2, "buf"    # [B
    .param p3, "offset"    # I
    .param p4, "length"    # I
    .param p5, "negative"    # Z

    .line 569
    invoke-static {p0, p1}, Ljava/math/BigInteger;->valueOf(J)Ljava/math/BigInteger;

    move-result-object v0

    .line 570
    .local v0, "val":Ljava/math/BigInteger;
    invoke-virtual {v0}, Ljava/math/BigInteger;->toByteArray()[B

    move-result-object v1

    .line 571
    .local v1, "b":[B
    array-length v2, v1

    .line 572
    .local v2, "len":I
    add-int/lit8 v3, p4, -0x1

    if-gt v2, v3, :cond_2

    .line 576
    add-int v3, p3, p4

    sub-int/2addr v3, v2

    .line 577
    .local v3, "off":I
    const/4 v4, 0x0

    invoke-static {v1, v4, p2, v3, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 578
    if-eqz p5, :cond_0

    const/16 v4, 0xff

    :cond_0
    int-to-byte v4, v4

    .line 579
    .local v4, "fill":B
    add-int/lit8 v5, p3, 0x1

    .local v5, "i":I
    :goto_0
    if-ge v5, v3, :cond_1

    .line 580
    aput-byte v4, p2, v5

    .line 579
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 582
    .end local v5    # "i":I
    :cond_1
    return-void

    .line 573
    .end local v3    # "off":I
    .end local v4    # "fill":B
    :cond_2
    new-instance v3, Ljava/lang/IllegalArgumentException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Value "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p0, p1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " is too large for "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " byte field."

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v3
.end method

.method public static formatCheckSumOctalBytes(J[BII)I
    .locals 3
    .param p0, "value"    # J
    .param p2, "buf"    # [B
    .param p3, "offset"    # I
    .param p4, "length"    # I

    .line 600
    add-int/lit8 v0, p4, -0x2

    .line 601
    .local v0, "idx":I
    invoke-static {p0, p1, p2, p3, v0}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->formatUnsignedOctalString(J[BII)V

    .line 603
    add-int/lit8 v1, v0, 0x1

    .end local v0    # "idx":I
    .local v1, "idx":I
    add-int/2addr v0, p3

    const/4 v2, 0x0

    aput-byte v2, p2, v0

    .line 604
    add-int v0, p3, v1

    const/16 v2, 0x20

    aput-byte v2, p2, v0

    .line 606
    add-int v0, p3, p4

    return v0
.end method

.method private static formatLongBinary(J[BIIZ)V
    .locals 10
    .param p0, "value"    # J
    .param p2, "buf"    # [B
    .param p3, "offset"    # I
    .param p4, "length"    # I
    .param p5, "negative"    # Z

    .line 547
    add-int/lit8 v0, p4, -0x1

    const/16 v1, 0x8

    mul-int/2addr v0, v1

    .line 548
    .local v0, "bits":I
    const-wide/16 v2, 0x1

    shl-long v4, v2, v0

    .line 549
    .local v4, "max":J
    invoke-static {p0, p1}, Ljava/lang/Math;->abs(J)J

    move-result-wide v6

    .line 550
    .local v6, "val":J
    const-wide/16 v8, 0x0

    cmp-long v8, v6, v8

    if-ltz v8, :cond_2

    cmp-long v8, v6, v4

    if-gez v8, :cond_2

    .line 554
    if-eqz p5, :cond_0

    .line 555
    sub-long v8, v4, v2

    xor-long/2addr v6, v8

    .line 556
    add-long/2addr v6, v2

    .line 557
    const-wide/16 v2, 0xff

    shl-long/2addr v2, v0

    or-long/2addr v6, v2

    .line 559
    :cond_0
    add-int v2, p3, p4

    add-int/lit8 v2, v2, -0x1

    .local v2, "i":I
    :goto_0
    if-lt v2, p3, :cond_1

    .line 560
    long-to-int v3, v6

    int-to-byte v3, v3

    aput-byte v3, p2, v2

    .line 561
    shr-long/2addr v6, v1

    .line 559
    add-int/lit8 v2, v2, -0x1

    goto :goto_0

    .line 563
    .end local v2    # "i":I
    :cond_1
    return-void

    .line 551
    :cond_2
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Value "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0, p1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " is too large for "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " byte field."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public static formatLongOctalBytes(J[BII)I
    .locals 3
    .param p0, "value"    # J
    .param p2, "buf"    # [B
    .param p3, "offset"    # I
    .param p4, "length"    # I

    .line 498
    add-int/lit8 v0, p4, -0x1

    .line 500
    .local v0, "idx":I
    invoke-static {p0, p1, p2, p3, v0}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->formatUnsignedOctalString(J[BII)V

    .line 501
    add-int v1, p3, v0

    const/16 v2, 0x20

    aput-byte v2, p2, v1

    .line 503
    add-int v1, p3, p4

    return v1
.end method

.method public static formatLongOctalOrBinaryBytes(J[BII)I
    .locals 9
    .param p0, "value"    # J
    .param p2, "buf"    # [B
    .param p3, "offset"    # I
    .param p4, "length"    # I

    .line 527
    const/16 v0, 0x8

    if-ne p4, v0, :cond_0

    const-wide/32 v0, 0x1fffff

    goto :goto_0

    :cond_0
    const-wide v0, 0x1ffffffffL

    .line 529
    .local v0, "maxAsOctalChar":J
    :goto_0
    const-wide/16 v2, 0x0

    cmp-long v2, p0, v2

    if-gez v2, :cond_1

    const/4 v2, 0x1

    goto :goto_1

    :cond_1
    const/4 v2, 0x0

    .line 530
    .local v2, "negative":Z
    :goto_1
    if-nez v2, :cond_2

    cmp-long v3, p0, v0

    if-gtz v3, :cond_2

    .line 531
    invoke-static {p0, p1, p2, p3, p4}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->formatLongOctalBytes(J[BII)I

    move-result v3

    return v3

    .line 534
    :cond_2
    const/16 v3, 0x9

    if-ge p4, v3, :cond_3

    .line 535
    move-wide v3, p0

    move-object v5, p2

    move v6, p3

    move v7, p4

    move v8, v2

    invoke-static/range {v3 .. v8}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->formatLongBinary(J[BIIZ)V

    goto :goto_2

    .line 537
    :cond_3
    move-wide v3, p0

    move-object v5, p2

    move v6, p3

    move v7, p4

    move v8, v2

    invoke-static/range {v3 .. v8}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->formatBigIntegerBinary(J[BIIZ)V

    .line 540
    :goto_2
    if-eqz v2, :cond_4

    const/16 v3, 0xff

    goto :goto_3

    :cond_4
    const/16 v3, 0x80

    :goto_3
    int-to-byte v3, v3

    aput-byte v3, p2, p3

    .line 541
    add-int v3, p3, p4

    return v3
.end method

.method public static formatNameBytes(Ljava/lang/String;[BII)I
    .locals 3
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "buf"    # [B
    .param p2, "offset"    # I
    .param p3, "length"    # I

    .line 373
    :try_start_0
    sget-object v0, Lorg/apache/commons/compress/archivers/tar/TarUtils;->DEFAULT_ENCODING:Lorg/apache/commons/compress/archivers/zip/ZipEncoding;

    invoke-static {p0, p1, p2, p3, v0}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->formatNameBytes(Ljava/lang/String;[BIILorg/apache/commons/compress/archivers/zip/ZipEncoding;)I

    move-result v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    .line 374
    :catch_0
    move-exception v0

    .line 376
    .local v0, "ex":Ljava/io/IOException;
    :try_start_1
    sget-object v1, Lorg/apache/commons/compress/archivers/tar/TarUtils;->FALLBACK_ENCODING:Lorg/apache/commons/compress/archivers/zip/ZipEncoding;

    invoke-static {p0, p1, p2, p3, v1}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->formatNameBytes(Ljava/lang/String;[BIILorg/apache/commons/compress/archivers/zip/ZipEncoding;)I

    move-result v1
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    return v1

    .line 378
    :catch_1
    move-exception v1

    .line 380
    .local v1, "ex2":Ljava/io/IOException;
    new-instance v2, Ljava/lang/RuntimeException;

    invoke-direct {v2, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v2
.end method

.method public static formatNameBytes(Ljava/lang/String;[BIILorg/apache/commons/compress/archivers/zip/ZipEncoding;)I
    .locals 6
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "buf"    # [B
    .param p2, "offset"    # I
    .param p3, "length"    # I
    .param p4, "encoding"    # Lorg/apache/commons/compress/archivers/zip/ZipEncoding;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 407
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 408
    .local v0, "len":I
    invoke-interface {p4, p0}, Lorg/apache/commons/compress/archivers/zip/ZipEncoding;->encode(Ljava/lang/String;)Ljava/nio/ByteBuffer;

    move-result-object v1

    .line 409
    .local v1, "b":Ljava/nio/ByteBuffer;
    :goto_0
    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->limit()I

    move-result v2

    const/4 v3, 0x0

    if-le v2, p3, :cond_0

    if-lez v0, :cond_0

    .line 410
    add-int/lit8 v0, v0, -0x1

    invoke-virtual {p0, v3, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-interface {p4, v2}, Lorg/apache/commons/compress/archivers/zip/ZipEncoding;->encode(Ljava/lang/String;)Ljava/nio/ByteBuffer;

    move-result-object v1

    goto :goto_0

    .line 412
    :cond_0
    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->limit()I

    move-result v2

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->position()I

    move-result v4

    sub-int/2addr v2, v4

    .line 413
    .local v2, "limit":I
    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v4

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->arrayOffset()I

    move-result v5

    invoke-static {v4, v5, p1, p2, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 416
    move v4, v2

    .local v4, "i":I
    :goto_1
    if-ge v4, p3, :cond_1

    .line 417
    add-int v5, p2, v4

    aput-byte v3, p1, v5

    .line 416
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 420
    .end local v4    # "i":I
    :cond_1
    add-int v3, p2, p3

    return v3
.end method

.method public static formatOctalBytes(J[BII)I
    .locals 3
    .param p0, "value"    # J
    .param p2, "buf"    # [B
    .param p3, "offset"    # I
    .param p4, "length"    # I

    .line 473
    add-int/lit8 v0, p4, -0x2

    .line 474
    .local v0, "idx":I
    invoke-static {p0, p1, p2, p3, v0}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->formatUnsignedOctalString(J[BII)V

    .line 476
    add-int/lit8 v1, v0, 0x1

    .end local v0    # "idx":I
    .local v1, "idx":I
    add-int/2addr v0, p3

    const/16 v2, 0x20

    aput-byte v2, p2, v0

    .line 477
    add-int v0, p3, v1

    const/4 v2, 0x0

    aput-byte v2, p2, v0

    .line 479
    add-int v0, p3, p4

    return v0
.end method

.method public static formatUnsignedOctalString(J[BII)V
    .locals 9
    .param p0, "value"    # J
    .param p2, "buffer"    # [B
    .param p3, "offset"    # I
    .param p4, "length"    # I

    .line 434
    move v0, p4

    .line 435
    .local v0, "remaining":I
    add-int/lit8 v0, v0, -0x1

    .line 436
    const-wide/16 v1, 0x0

    cmp-long v3, p0, v1

    const/16 v4, 0x30

    if-nez v3, :cond_0

    .line 437
    add-int/lit8 v1, v0, -0x1

    .end local v0    # "remaining":I
    .local v1, "remaining":I
    add-int/2addr v0, p3

    aput-byte v4, p2, v0

    goto :goto_1

    .line 439
    .end local v1    # "remaining":I
    .restart local v0    # "remaining":I
    :cond_0
    move-wide v5, p0

    .line 440
    .local v5, "val":J
    :goto_0
    if-ltz v0, :cond_1

    cmp-long v3, v5, v1

    if-eqz v3, :cond_1

    .line 442
    add-int v3, p3, v0

    const-wide/16 v7, 0x7

    and-long/2addr v7, v5

    long-to-int v7, v7

    int-to-byte v7, v7

    add-int/2addr v7, v4

    int-to-byte v7, v7

    aput-byte v7, p2, v3

    .line 443
    const/4 v3, 0x3

    ushr-long/2addr v5, v3

    .line 440
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 446
    :cond_1
    cmp-long v1, v5, v1

    if-nez v1, :cond_3

    move v1, v0

    .line 452
    .end local v0    # "remaining":I
    .end local v5    # "val":J
    .restart local v1    # "remaining":I
    :goto_1
    if-ltz v1, :cond_2

    .line 453
    add-int v0, p3, v1

    aput-byte v4, p2, v0

    .line 452
    add-int/lit8 v1, v1, -0x1

    goto :goto_1

    .line 455
    :cond_2
    return-void

    .line 447
    .end local v1    # "remaining":I
    .restart local v0    # "remaining":I
    .restart local v5    # "val":J
    :cond_3
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p0, p1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 448
    invoke-static {p0, p1}, Ljava/lang/Long;->toOctalString(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " will not fit in octal number buffer of length "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method private static parseBinaryBigInteger([BIIZ)J
    .locals 5
    .param p0, "buffer"    # [B
    .param p1, "offset"    # I
    .param p2, "length"    # I
    .param p3, "negative"    # Z

    .line 217
    add-int/lit8 v0, p2, -0x1

    new-array v0, v0, [B

    .line 218
    .local v0, "remainder":[B
    add-int/lit8 v1, p1, 0x1

    const/4 v2, 0x0

    add-int/lit8 v3, p2, -0x1

    invoke-static {p0, v1, v0, v2, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 219
    new-instance v1, Ljava/math/BigInteger;

    invoke-direct {v1, v0}, Ljava/math/BigInteger;-><init>([B)V

    .line 220
    .local v1, "val":Ljava/math/BigInteger;
    if-eqz p3, :cond_0

    .line 222
    const-wide/16 v2, -0x1

    invoke-static {v2, v3}, Ljava/math/BigInteger;->valueOf(J)Ljava/math/BigInteger;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/math/BigInteger;->add(Ljava/math/BigInteger;)Ljava/math/BigInteger;

    move-result-object v2

    invoke-virtual {v2}, Ljava/math/BigInteger;->not()Ljava/math/BigInteger;

    move-result-object v1

    .line 224
    :cond_0
    invoke-virtual {v1}, Ljava/math/BigInteger;->bitLength()I

    move-result v2

    const/16 v3, 0x3f

    if-gt v2, v3, :cond_2

    .line 230
    invoke-virtual {v1}, Ljava/math/BigInteger;->longValue()J

    move-result-wide v2

    if-eqz p3, :cond_1

    neg-long v2, v2

    :cond_1
    return-wide v2

    .line 225
    :cond_2
    new-instance v2, Ljava/lang/IllegalArgumentException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "At offset "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " byte binary number exceeds maximum signed long value"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method private static parseBinaryLong([BIIZ)J
    .locals 8
    .param p0, "buffer"    # [B
    .param p1, "offset"    # I
    .param p2, "length"    # I
    .param p3, "negative"    # Z

    .line 195
    const/16 v0, 0x9

    if-ge p2, v0, :cond_3

    .line 201
    const-wide/16 v0, 0x0

    .line 202
    .local v0, "val":J
    const/4 v2, 0x1

    .local v2, "i":I
    :goto_0
    if-ge v2, p2, :cond_0

    .line 203
    const/16 v3, 0x8

    shl-long v3, v0, v3

    add-int v5, p1, v2

    aget-byte v5, p0, v5

    and-int/lit16 v5, v5, 0xff

    int-to-long v5, v5

    add-long v0, v3, v5

    .line 202
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 205
    .end local v2    # "i":I
    :cond_0
    if-eqz p3, :cond_1

    .line 207
    const-wide/16 v2, 0x1

    sub-long/2addr v0, v2

    .line 208
    add-int/lit8 v4, p2, -0x1

    int-to-double v4, v4

    const-wide/high16 v6, 0x4020000000000000L    # 8.0

    mul-double/2addr v4, v6

    const-wide/high16 v6, 0x4000000000000000L    # 2.0

    invoke-static {v6, v7, v4, v5}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v4

    double-to-long v4, v4

    sub-long/2addr v4, v2

    xor-long/2addr v0, v4

    .line 210
    :cond_1
    if-eqz p3, :cond_2

    neg-long v2, v0

    goto :goto_1

    :cond_2
    move-wide v2, v0

    :goto_1
    return-wide v2

    .line 196
    .end local v0    # "val":J
    :cond_3
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "At offset "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " byte binary number exceeds maximum signed long value"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static parseBoolean([BI)Z
    .locals 2
    .param p0, "buffer"    # [B
    .param p1, "offset"    # I

    .line 244
    aget-byte v0, p0, p1

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method protected static parseFromPAX01SparseHeaders(Ljava/lang/String;)Ljava/util/List;
    .locals 9
    .param p0, "sparseMap"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 873
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 874
    .local v0, "sparseHeaders":Ljava/util/List;, "Ljava/util/List<Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;>;"
    const-string v1, ","

    invoke-virtual {p0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .line 875
    .local v1, "sparseHeaderStrings":[Ljava/lang/String;
    array-length v2, v1

    rem-int/lit8 v2, v2, 0x2

    const/4 v3, 0x1

    if-eq v2, v3, :cond_3

    .line 879
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    array-length v3, v1

    if-ge v2, v3, :cond_2

    .line 882
    :try_start_0
    aget-object v3, v1, v2

    invoke-static {v3}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v3
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_1

    .line 886
    .local v3, "sparseOffset":J
    nop

    .line 887
    const-wide/16 v5, 0x0

    cmp-long v7, v3, v5

    if-ltz v7, :cond_1

    .line 893
    add-int/lit8 v7, v2, 0x1

    :try_start_1
    aget-object v7, v1, v7

    invoke-static {v7}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v7
    :try_end_1
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_1} :catch_0

    .line 897
    .local v7, "sparseNumbytes":J
    nop

    .line 898
    cmp-long v5, v7, v5

    if-ltz v5, :cond_0

    .line 902
    new-instance v5, Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;

    invoke-direct {v5, v3, v4, v7, v8}, Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;-><init>(JJ)V

    invoke-interface {v0, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 879
    .end local v3    # "sparseOffset":J
    .end local v7    # "sparseNumbytes":J
    add-int/lit8 v2, v2, 0x2

    goto :goto_0

    .line 899
    .restart local v3    # "sparseOffset":J
    .restart local v7    # "sparseNumbytes":J
    :cond_0
    new-instance v5, Ljava/io/IOException;

    const-string v6, "Corrupted TAR archive. Sparse struct numbytes contains negative value"

    invoke-direct {v5, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 894
    .end local v7    # "sparseNumbytes":J
    :catch_0
    move-exception v5

    .line 895
    .local v5, "ex":Ljava/lang/NumberFormatException;
    new-instance v6, Ljava/io/IOException;

    const-string v7, "Corrupted TAR archive. Sparse struct numbytes contains a non-numeric value"

    invoke-direct {v6, v7}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v6

    .line 888
    .end local v5    # "ex":Ljava/lang/NumberFormatException;
    :cond_1
    new-instance v5, Ljava/io/IOException;

    const-string v6, "Corrupted TAR archive. Sparse struct offset contains negative value"

    invoke-direct {v5, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 883
    .end local v3    # "sparseOffset":J
    :catch_1
    move-exception v3

    .line 884
    .local v3, "ex":Ljava/lang/NumberFormatException;
    new-instance v4, Ljava/io/IOException;

    const-string v5, "Corrupted TAR archive. Sparse struct offset contains a non-numeric value"

    invoke-direct {v4, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 905
    .end local v2    # "i":I
    .end local v3    # "ex":Ljava/lang/NumberFormatException;
    :cond_2
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v2

    return-object v2

    .line 876
    :cond_3
    new-instance v2, Ljava/io/IOException;

    const-string v3, "Corrupted TAR archive. Bad format in GNU.sparse.map PAX Header"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method public static parseName([BII)Ljava/lang/String;
    .locals 3
    .param p0, "buffer"    # [B
    .param p1, "offset"    # I
    .param p2, "length"    # I

    .line 275
    :try_start_0
    sget-object v0, Lorg/apache/commons/compress/archivers/tar/TarUtils;->DEFAULT_ENCODING:Lorg/apache/commons/compress/archivers/zip/ZipEncoding;

    invoke-static {p0, p1, p2, v0}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->parseName([BIILorg/apache/commons/compress/archivers/zip/ZipEncoding;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 276
    :catch_0
    move-exception v0

    .line 278
    .local v0, "ex":Ljava/io/IOException;
    :try_start_1
    sget-object v1, Lorg/apache/commons/compress/archivers/tar/TarUtils;->FALLBACK_ENCODING:Lorg/apache/commons/compress/archivers/zip/ZipEncoding;

    invoke-static {p0, p1, p2, v1}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->parseName([BIILorg/apache/commons/compress/archivers/zip/ZipEncoding;)Ljava/lang/String;

    move-result-object v1
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    return-object v1

    .line 279
    :catch_1
    move-exception v1

    .line 281
    .local v1, "ex2":Ljava/io/IOException;
    new-instance v2, Ljava/lang/RuntimeException;

    invoke-direct {v2, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/Throwable;)V

    throw v2
.end method

.method public static parseName([BIILorg/apache/commons/compress/archivers/zip/ZipEncoding;)Ljava/lang/String;
    .locals 3
    .param p0, "buffer"    # [B
    .param p1, "offset"    # I
    .param p2, "length"    # I
    .param p3, "encoding"    # Lorg/apache/commons/compress/archivers/zip/ZipEncoding;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 304
    const/4 v0, 0x0

    .line 305
    .local v0, "len":I
    move v1, p1

    .local v1, "i":I
    :goto_0
    if-ge v0, p2, :cond_0

    aget-byte v2, p0, v1

    if-eqz v2, :cond_0

    .line 306
    add-int/lit8 v0, v0, 0x1

    .line 305
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 308
    .end local v1    # "i":I
    :cond_0
    if-lez v0, :cond_1

    .line 309
    new-array v1, v0, [B

    .line 310
    .local v1, "b":[B
    const/4 v2, 0x0

    invoke-static {p0, p1, v1, v2, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 311
    invoke-interface {p3, v1}, Lorg/apache/commons/compress/archivers/zip/ZipEncoding;->decode([B)Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 313
    .end local v1    # "b":[B
    :cond_1
    const-string v1, ""

    return-object v1
.end method

.method public static parseOctal([BII)J
    .locals 10
    .param p0, "buffer"    # [B
    .param p1, "offset"    # I
    .param p2, "length"    # I

    .line 118
    const-wide/16 v0, 0x0

    .line 119
    .local v0, "result":J
    add-int v2, p1, p2

    .line 120
    .local v2, "end":I
    move v3, p1

    .line 122
    .local v3, "start":I
    const/4 v4, 0x2

    if-lt p2, v4, :cond_7

    .line 126
    aget-byte v4, p0, v3

    if-nez v4, :cond_0

    .line 127
    const-wide/16 v4, 0x0

    return-wide v4

    .line 131
    :cond_0
    :goto_0
    const/16 v4, 0x20

    if-ge v3, v2, :cond_2

    .line 132
    aget-byte v5, p0, v3

    if-eq v5, v4, :cond_1

    .line 133
    goto :goto_1

    .line 135
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 142
    :cond_2
    :goto_1
    add-int/lit8 v5, v2, -0x1

    aget-byte v5, p0, v5

    .line 143
    .local v5, "trailer":B
    :goto_2
    if-ge v3, v2, :cond_4

    if-eqz v5, :cond_3

    if-ne v5, v4, :cond_4

    .line 144
    :cond_3
    add-int/lit8 v2, v2, -0x1

    .line 145
    add-int/lit8 v6, v2, -0x1

    aget-byte v5, p0, v6

    goto :goto_2

    .line 148
    :cond_4
    :goto_3
    if-ge v3, v2, :cond_6

    .line 149
    aget-byte v4, p0, v3

    .line 151
    .local v4, "currentByte":B
    const/16 v6, 0x30

    if-lt v4, v6, :cond_5

    const/16 v6, 0x37

    if-gt v4, v6, :cond_5

    .line 155
    const/4 v6, 0x3

    shl-long v6, v0, v6

    add-int/lit8 v8, v4, -0x30

    int-to-long v8, v8

    add-long v0, v6, v8

    .line 148
    .end local v4    # "currentByte":B
    add-int/lit8 v3, v3, 0x1

    goto :goto_3

    .line 152
    .restart local v4    # "currentByte":B
    :cond_5
    new-instance v6, Ljava/lang/IllegalArgumentException;

    .line 153
    invoke-static {p0, p1, p2, v3, v4}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->exceptionMessage([BIIIB)Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v6

    .line 159
    .end local v4    # "currentByte":B
    :cond_6
    return-wide v0

    .line 123
    .end local v5    # "trailer":B
    :cond_7
    new-instance v4, Ljava/lang/IllegalArgumentException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Length "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " must be at least 2"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v4
.end method

.method public static parseOctalOrBinary([BII)J
    .locals 3
    .param p0, "buffer"    # [B
    .param p1, "offset"    # I
    .param p2, "length"    # I

    .line 182
    aget-byte v0, p0, p1

    and-int/lit16 v0, v0, 0x80

    if-nez v0, :cond_0

    .line 183
    invoke-static {p0, p1, p2}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->parseOctal([BII)J

    move-result-wide v0

    return-wide v0

    .line 185
    :cond_0
    aget-byte v0, p0, p1

    const/4 v1, -0x1

    if-ne v0, v1, :cond_1

    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    .line 186
    .local v0, "negative":Z
    :goto_0
    const/16 v1, 0x9

    if-ge p2, v1, :cond_2

    .line 187
    invoke-static {p0, p1, p2, v0}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->parseBinaryLong([BIIZ)J

    move-result-wide v1

    return-wide v1

    .line 189
    :cond_2
    invoke-static {p0, p1, p2, v0}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->parseBinaryBigInteger([BIIZ)J

    move-result-wide v1

    return-wide v1
.end method

.method protected static parsePAX01SparseHeaders(Ljava/lang/String;)Ljava/util/List;
    .locals 3
    .param p0, "sparseMap"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;",
            ">;"
        }
    .end annotation

    .line 855
    :try_start_0
    invoke-static {p0}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->parseFromPAX01SparseHeaders(Ljava/lang/String;)Ljava/util/List;

    move-result-object v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 856
    :catch_0
    move-exception v0

    .line 857
    .local v0, "ex":Ljava/io/IOException;
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected static parsePAX1XSparseHeaders(Ljava/io/InputStream;I)Ljava/util/List;
    .locals 17
    .param p0, "inputStream"    # Ljava/io/InputStream;
    .param p1, "recordSize"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/InputStream;",
            "I)",
            "Ljava/util/List<",
            "Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 921
    move/from16 v0, p1

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 922
    .local v1, "sparseHeaders":Ljava/util/List;, "Ljava/util/List<Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;>;"
    const-wide/16 v2, 0x0

    .line 924
    .local v2, "bytesRead":J
    invoke-static/range {p0 .. p0}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->readLineOfNumberForPax1X(Ljava/io/InputStream;)[J

    move-result-object v4

    .line 925
    .local v4, "readResult":[J
    const/4 v5, 0x0

    aget-wide v6, v4, v5

    .line 926
    .local v6, "sparseHeadersCount":J
    const-wide/16 v8, 0x0

    cmp-long v10, v6, v8

    if-ltz v10, :cond_3

    .line 930
    const/4 v10, 0x1

    aget-wide v11, v4, v10

    add-long/2addr v2, v11

    .line 931
    :goto_0
    const-wide/16 v11, 0x1

    sub-long v11, v6, v11

    .end local v6    # "sparseHeadersCount":J
    .local v11, "sparseHeadersCount":J
    cmp-long v6, v6, v8

    if-lez v6, :cond_2

    .line 932
    invoke-static/range {p0 .. p0}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->readLineOfNumberForPax1X(Ljava/io/InputStream;)[J

    move-result-object v4

    .line 933
    aget-wide v6, v4, v5

    .line 934
    .local v6, "sparseOffset":J
    cmp-long v13, v6, v8

    if-ltz v13, :cond_1

    .line 938
    aget-wide v13, v4, v10

    add-long/2addr v2, v13

    .line 940
    invoke-static/range {p0 .. p0}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->readLineOfNumberForPax1X(Ljava/io/InputStream;)[J

    move-result-object v4

    .line 941
    aget-wide v13, v4, v5

    .line 942
    .local v13, "sparseNumbytes":J
    cmp-long v15, v13, v8

    if-ltz v15, :cond_0

    .line 946
    aget-wide v15, v4, v10

    add-long/2addr v2, v15

    .line 947
    new-instance v15, Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;

    invoke-direct {v15, v6, v7, v13, v14}, Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;-><init>(JJ)V

    invoke-interface {v1, v15}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 948
    .end local v6    # "sparseOffset":J
    .end local v13    # "sparseNumbytes":J
    move-wide v6, v11

    goto :goto_0

    .line 943
    .restart local v6    # "sparseOffset":J
    .restart local v13    # "sparseNumbytes":J
    :cond_0
    new-instance v5, Ljava/io/IOException;

    const-string v8, "Corrupted TAR archive. Sparse header block numbytes contains negative value"

    invoke-direct {v5, v8}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 935
    .end local v13    # "sparseNumbytes":J
    :cond_1
    new-instance v5, Ljava/io/IOException;

    const-string v8, "Corrupted TAR archive. Sparse header block offset contains negative value"

    invoke-direct {v5, v8}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 951
    .end local v6    # "sparseOffset":J
    :cond_2
    int-to-long v5, v0

    int-to-long v7, v0

    rem-long v7, v2, v7

    sub-long/2addr v5, v7

    .line 952
    .local v5, "bytesToSkip":J
    move-object/from16 v8, p0

    invoke-static {v8, v5, v6}, Lorg/apache/commons/compress/utils/IOUtils;->skip(Ljava/io/InputStream;J)J

    .line 953
    return-object v1

    .line 928
    .end local v5    # "bytesToSkip":J
    .end local v11    # "sparseHeadersCount":J
    .local v6, "sparseHeadersCount":J
    :cond_3
    move-object/from16 v8, p0

    new-instance v5, Ljava/io/IOException;

    const-string v9, "Corrupted TAR archive. Negative value in sparse headers block"

    invoke-direct {v5, v9}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v5
.end method

.method protected static parsePaxHeaders(Ljava/io/InputStream;Ljava/util/List;Ljava/util/Map;)Ljava/util/Map;
    .locals 2
    .param p0, "inputStream"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/InputStream;",
            "Ljava/util/List<",
            "Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 693
    .local p1, "sparseHeaders":Ljava/util/List;, "Ljava/util/List<Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;>;"
    .local p2, "globalPaxHeaders":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    const-wide/16 v0, -0x1

    invoke-static {p0, p1, p2, v0, v1}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->parsePaxHeaders(Ljava/io/InputStream;Ljava/util/List;Ljava/util/Map;J)Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method protected static parsePaxHeaders(Ljava/io/InputStream;Ljava/util/List;Ljava/util/Map;J)Ljava/util/Map;
    .locals 19
    .param p0, "inputStream"    # Ljava/io/InputStream;
    .param p3, "headerSize"    # J
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/InputStream;",
            "Ljava/util/List<",
            "Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;",
            ">;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;J)",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 724
    .local p1, "sparseHeaders":Ljava/util/List;, "Ljava/util/List<Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;>;"
    .local p2, "globalPaxHeaders":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    move-object/from16 v1, p1

    new-instance v0, Ljava/util/HashMap;

    move-object/from16 v2, p2

    invoke-direct {v0, v2}, Ljava/util/HashMap;-><init>(Ljava/util/Map;)V

    move-object v3, v0

    .line 725
    .local v3, "headers":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    const/4 v0, 0x0

    .line 727
    .local v0, "offset":Ljava/lang/Long;
    const/4 v4, 0x0

    move/from16 v18, v4

    move-object v4, v0

    move/from16 v0, v18

    .line 730
    .local v0, "totalRead":I
    .local v4, "offset":Ljava/lang/Long;
    :goto_0
    const/4 v5, 0x0

    .line 731
    .local v5, "len":I
    const/4 v6, 0x0

    .line 732
    .local v6, "read":I
    :goto_1
    invoke-virtual/range {p0 .. p0}, Ljava/io/InputStream;->read()I

    move-result v7

    move v8, v7

    .local v8, "ch":I
    const/4 v9, -0x1

    const-wide/16 v10, 0x0

    if-eq v7, v9, :cond_12

    .line 733
    add-int/lit8 v6, v6, 0x1

    .line 734
    add-int/lit8 v0, v0, 0x1

    .line 735
    const/16 v7, 0xa

    if-ne v8, v7, :cond_0

    .line 736
    goto/16 :goto_8

    .line 738
    :cond_0
    const/16 v12, 0x20

    if-ne v8, v12, :cond_10

    .line 740
    new-instance v12, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v12}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 741
    .local v12, "coll":Ljava/io/ByteArrayOutputStream;
    :goto_2
    invoke-virtual/range {p0 .. p0}, Ljava/io/InputStream;->read()I

    move-result v13

    move v8, v13

    if-eq v13, v9, :cond_f

    .line 742
    add-int/lit8 v6, v6, 0x1

    .line 743
    add-int/lit8 v0, v0, 0x1

    .line 744
    if-ltz v0, :cond_e

    cmp-long v13, p3, v10

    if-ltz v13, :cond_1

    int-to-long v13, v0

    cmp-long v13, v13, p3

    if-ltz v13, :cond_1

    .line 745
    move v15, v6

    move v2, v8

    goto/16 :goto_7

    .line 747
    :cond_1
    const/16 v13, 0x3d

    if-ne v8, v13, :cond_d

    .line 748
    const-string v13, "UTF-8"

    invoke-virtual {v12, v13}, Ljava/io/ByteArrayOutputStream;->toString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    .line 750
    .local v13, "keyword":Ljava/lang/String;
    sub-int v14, v5, v6

    .line 751
    .local v14, "restLen":I
    const/4 v15, 0x1

    if-gt v14, v15, :cond_2

    .line 752
    invoke-interface {v3, v13}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move v15, v6

    move v2, v8

    goto/16 :goto_7

    .line 753
    :cond_2
    cmp-long v15, p3, v10

    if-ltz v15, :cond_4

    int-to-long v9, v14

    move/from16 v16, v8

    .end local v8    # "ch":I
    .local v16, "ch":I
    int-to-long v7, v0

    sub-long v7, p3, v7

    cmp-long v7, v9, v7

    if-gtz v7, :cond_3

    goto :goto_3

    .line 754
    :cond_3
    new-instance v7, Ljava/io/IOException;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "Paxheader value size "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " exceeds size of header record"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v7

    .line 753
    .end local v16    # "ch":I
    .restart local v8    # "ch":I
    :cond_4
    move/from16 v16, v8

    .line 757
    .end local v8    # "ch":I
    .restart local v16    # "ch":I
    :goto_3
    move-object/from16 v7, p0

    invoke-static {v7, v14}, Lorg/apache/commons/compress/utils/IOUtils;->readRange(Ljava/io/InputStream;I)[B

    move-result-object v8

    .line 758
    .local v8, "rest":[B
    array-length v9, v8

    .line 759
    .local v9, "got":I
    if-ne v9, v14, :cond_c

    .line 766
    add-int v10, v0, v14

    .line 768
    .end local v0    # "totalRead":I
    .local v10, "totalRead":I
    add-int/lit8 v0, v14, -0x1

    aget-byte v0, v8, v0

    const/16 v11, 0xa

    if-ne v0, v11, :cond_b

    .line 772
    new-instance v0, Ljava/lang/String;

    add-int/lit8 v11, v14, -0x1

    sget-object v15, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    const/4 v2, 0x0

    invoke-direct {v0, v8, v2, v11, v15}, Ljava/lang/String;-><init>([BIILjava/nio/charset/Charset;)V

    move-object v2, v0

    .line 774
    .local v2, "value":Ljava/lang/String;
    invoke-interface {v3, v13, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 777
    const-string v0, "GNU.sparse.offset"

    invoke-virtual {v13, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_7

    .line 778
    if-eqz v4, :cond_5

    .line 780
    new-instance v0, Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;

    move v15, v6

    .end local v6    # "read":I
    .local v15, "read":I
    invoke-virtual {v4}, Ljava/lang/Long;->longValue()J

    move-result-wide v6

    move/from16 v17, v10

    const-wide/16 v10, 0x0

    .end local v10    # "totalRead":I
    .local v17, "totalRead":I
    invoke-direct {v0, v6, v7, v10, v11}, Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;-><init>(JJ)V

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_4

    .line 778
    .end local v15    # "read":I
    .end local v17    # "totalRead":I
    .restart local v6    # "read":I
    .restart local v10    # "totalRead":I
    :cond_5
    move v15, v6

    move/from16 v17, v10

    .line 783
    .end local v6    # "read":I
    .end local v10    # "totalRead":I
    .restart local v15    # "read":I
    .restart local v17    # "totalRead":I
    :goto_4
    :try_start_0
    invoke-static {v2}, Ljava/lang/Long;->valueOf(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v4, v0

    .line 787
    nop

    .line 788
    invoke-virtual {v4}, Ljava/lang/Long;->longValue()J

    move-result-wide v6

    const-wide/16 v10, 0x0

    cmp-long v0, v6, v10

    if-ltz v0, :cond_6

    goto :goto_5

    .line 789
    :cond_6
    new-instance v0, Ljava/io/IOException;

    const-string v6, "Failed to read Paxheader.GNU.sparse.offset contains negative value"

    invoke-direct {v0, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 784
    :catch_0
    move-exception v0

    move-object v6, v0

    move-object v0, v6

    .line 785
    .local v0, "ex":Ljava/lang/NumberFormatException;
    new-instance v6, Ljava/io/IOException;

    const-string v7, "Failed to read Paxheader.GNU.sparse.offset contains a non-numeric value"

    invoke-direct {v6, v7}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v6

    .line 777
    .end local v0    # "ex":Ljava/lang/NumberFormatException;
    .end local v15    # "read":I
    .end local v17    # "totalRead":I
    .restart local v6    # "read":I
    .restart local v10    # "totalRead":I
    :cond_7
    move v15, v6

    move/from16 v17, v10

    .line 795
    .end local v6    # "read":I
    .end local v10    # "totalRead":I
    .restart local v15    # "read":I
    .restart local v17    # "totalRead":I
    :goto_5
    const-string v0, "GNU.sparse.numbytes"

    invoke-virtual {v13, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_a

    .line 796
    if-eqz v4, :cond_9

    .line 802
    :try_start_1
    invoke-static {v2}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v6
    :try_end_1
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_1} :catch_1

    .line 806
    .local v6, "numbytes":J
    nop

    .line 807
    const-wide/16 v10, 0x0

    cmp-long v0, v6, v10

    if-ltz v0, :cond_8

    .line 811
    new-instance v0, Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;

    invoke-virtual {v4}, Ljava/lang/Long;->longValue()J

    move-result-wide v10

    invoke-direct {v0, v10, v11, v6, v7}, Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;-><init>(JJ)V

    invoke-interface {v1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 812
    const/4 v4, 0x0

    goto :goto_6

    .line 808
    :cond_8
    new-instance v0, Ljava/io/IOException;

    const-string v10, "Failed to read Paxheader.GNU.sparse.numbytes contains negative value"

    invoke-direct {v0, v10}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 803
    .end local v6    # "numbytes":J
    :catch_1
    move-exception v0

    move-object v6, v0

    move-object v0, v6

    .line 804
    .restart local v0    # "ex":Ljava/lang/NumberFormatException;
    new-instance v6, Ljava/io/IOException;

    const-string v7, "Failed to read Paxheader.GNU.sparse.numbytes contains a non-numeric value."

    invoke-direct {v6, v7}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v6

    .line 797
    .end local v0    # "ex":Ljava/lang/NumberFormatException;
    :cond_9
    new-instance v0, Ljava/io/IOException;

    const-string v6, "Failed to read Paxheader.GNU.sparse.offset is expected before GNU.sparse.numbytes shows up."

    invoke-direct {v0, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 815
    .end local v2    # "value":Ljava/lang/String;
    .end local v8    # "rest":[B
    .end local v9    # "got":I
    :cond_a
    :goto_6
    move v6, v15

    move/from16 v8, v16

    move/from16 v0, v17

    goto/16 :goto_8

    .line 769
    .end local v15    # "read":I
    .end local v17    # "totalRead":I
    .local v6, "read":I
    .restart local v8    # "rest":[B
    .restart local v9    # "got":I
    .restart local v10    # "totalRead":I
    :cond_b
    new-instance v0, Ljava/io/IOException;

    const-string v2, "Failed to read Paxheader.Value should end with a newline"

    invoke-direct {v0, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 760
    .end local v10    # "totalRead":I
    .local v0, "totalRead":I
    :cond_c
    move v15, v6

    .end local v6    # "read":I
    .restart local v15    # "read":I
    new-instance v2, Ljava/io/IOException;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Failed to read Paxheader. Expected "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " bytes, read "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v2, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 817
    .end local v9    # "got":I
    .end local v13    # "keyword":Ljava/lang/String;
    .end local v14    # "restLen":I
    .end local v15    # "read":I
    .end local v16    # "ch":I
    .restart local v6    # "read":I
    .local v8, "ch":I
    :cond_d
    move v15, v6

    move v11, v7

    move/from16 v16, v8

    .end local v6    # "read":I
    .end local v8    # "ch":I
    .restart local v15    # "read":I
    .restart local v16    # "ch":I
    move/from16 v2, v16

    .end local v16    # "ch":I
    .local v2, "ch":I
    int-to-byte v6, v2

    invoke-virtual {v12, v6}, Ljava/io/ByteArrayOutputStream;->write(I)V

    move v8, v2

    move v6, v15

    const/4 v9, -0x1

    const-wide/16 v10, 0x0

    move-object/from16 v2, p2

    goto/16 :goto_2

    .line 744
    .end local v2    # "ch":I
    .end local v15    # "read":I
    .restart local v6    # "read":I
    .restart local v8    # "ch":I
    :cond_e
    move v15, v6

    move v2, v8

    .line 830
    .end local v6    # "read":I
    .end local v8    # "ch":I
    .end local v12    # "coll":Ljava/io/ByteArrayOutputStream;
    .restart local v2    # "ch":I
    .restart local v15    # "read":I
    :goto_7
    move v8, v2

    move v6, v15

    goto :goto_8

    .line 741
    .end local v2    # "ch":I
    .end local v15    # "read":I
    .restart local v6    # "read":I
    .restart local v8    # "ch":I
    .restart local v12    # "coll":Ljava/io/ByteArrayOutputStream;
    :cond_f
    move v2, v8

    .end local v8    # "ch":I
    .restart local v2    # "ch":I
    goto :goto_8

    .line 823
    .end local v2    # "ch":I
    .end local v12    # "coll":Ljava/io/ByteArrayOutputStream;
    .restart local v8    # "ch":I
    :cond_10
    const/16 v2, 0x30

    if-lt v8, v2, :cond_11

    const/16 v2, 0x39

    if-gt v8, v2, :cond_11

    .line 827
    mul-int/lit8 v5, v5, 0xa

    .line 828
    add-int/lit8 v2, v8, -0x30

    add-int/2addr v5, v2

    move-object/from16 v2, p2

    goto/16 :goto_1

    .line 824
    :cond_11
    new-instance v2, Ljava/io/IOException;

    const-string v7, "Failed to read Paxheader. Encountered a non-number while reading length"

    invoke-direct {v2, v7}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 830
    :cond_12
    :goto_8
    const/4 v2, -0x1

    if-ne v8, v2, :cond_14

    .line 831
    nop

    .line 834
    .end local v5    # "len":I
    .end local v6    # "read":I
    .end local v8    # "ch":I
    if-eqz v4, :cond_13

    .line 836
    new-instance v2, Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;

    invoke-virtual {v4}, Ljava/lang/Long;->longValue()J

    move-result-wide v5

    const-wide/16 v7, 0x0

    invoke-direct {v2, v5, v6, v7, v8}, Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;-><init>(JJ)V

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 838
    :cond_13
    return-object v3

    .line 833
    :cond_14
    move-object/from16 v2, p2

    goto/16 :goto_0
.end method

.method public static parseSparse([BI)Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;
    .locals 5
    .param p0, "buffer"    # [B
    .param p1, "offset"    # I

    .line 324
    const/16 v0, 0xc

    invoke-static {p0, p1, v0}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->parseOctalOrBinary([BII)J

    move-result-wide v1

    .line 325
    .local v1, "sparseOffset":J
    add-int/lit8 v3, p1, 0xc

    invoke-static {p0, v3, v0}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->parseOctalOrBinary([BII)J

    move-result-wide v3

    .line 327
    .local v3, "sparseNumbytes":J
    new-instance v0, Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;

    invoke-direct {v0, v1, v2, v3, v4}, Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;-><init>(JJ)V

    return-object v0
.end method

.method private static readLineOfNumberForPax1X(Ljava/io/InputStream;)[J
    .locals 10
    .param p0, "inputStream"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 966
    const-wide/16 v0, 0x0

    .line 967
    .local v0, "result":J
    const-wide/16 v2, 0x0

    .line 969
    .local v2, "bytesRead":J
    :goto_0
    invoke-virtual {p0}, Ljava/io/InputStream;->read()I

    move-result v4

    move v5, v4

    .local v5, "number":I
    const/16 v6, 0xa

    const-wide/16 v7, 0x1

    if-eq v4, v6, :cond_2

    .line 970
    add-long/2addr v2, v7

    .line 971
    const/4 v4, -0x1

    if-eq v5, v4, :cond_1

    .line 974
    const/16 v4, 0x30

    if-lt v5, v4, :cond_0

    const/16 v4, 0x39

    if-gt v5, v4, :cond_0

    .line 977
    const-wide/16 v6, 0xa

    mul-long/2addr v6, v0

    add-int/lit8 v4, v5, -0x30

    int-to-long v8, v4

    add-long v0, v6, v8

    goto :goto_0

    .line 975
    :cond_0
    new-instance v4, Ljava/io/IOException;

    const-string v6, "Corrupted TAR archive. Non-numeric value in sparse headers block"

    invoke-direct {v4, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 972
    :cond_1
    new-instance v4, Ljava/io/IOException;

    const-string v6, "Unexpected EOF when reading parse information of 1.X PAX format"

    invoke-direct {v4, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 979
    :cond_2
    add-long/2addr v2, v7

    .line 981
    const/4 v4, 0x2

    new-array v4, v4, [J

    const/4 v6, 0x0

    aput-wide v0, v4, v6

    const/4 v6, 0x1

    aput-wide v2, v4, v6

    return-object v4
.end method

.method static readSparseStructs([BII)Ljava/util/List;
    .locals 7
    .param p0, "buffer"    # [B
    .param p1, "offset"    # I
    .param p2, "entries"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([BII)",
            "Ljava/util/List<",
            "Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 335
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 336
    .local v0, "sparseHeaders":Ljava/util/List;, "Ljava/util/List<Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;>;"
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    if-ge v1, p2, :cond_2

    .line 338
    mul-int/lit8 v2, v1, 0x18

    add-int/2addr v2, p1

    .line 339
    :try_start_0
    invoke-static {p0, v2}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->parseSparse([BI)Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;

    move-result-object v2

    .line 341
    .local v2, "sparseHeader":Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;
    invoke-virtual {v2}, Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;->getOffset()J

    move-result-wide v3

    const-wide/16 v5, 0x0

    cmp-long v3, v3, v5

    if-ltz v3, :cond_1

    .line 344
    invoke-virtual {v2}, Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;->getNumbytes()J

    move-result-wide v3

    cmp-long v3, v3, v5

    if-ltz v3, :cond_0

    .line 347
    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 351
    nop

    .line 336
    .end local v2    # "sparseHeader":Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 345
    .restart local v2    # "sparseHeader":Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;
    :cond_0
    new-instance v3, Ljava/io/IOException;

    const-string v4, "Corrupted TAR archive, sparse entry with negative numbytes"

    invoke-direct {v3, v4}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .end local v0    # "sparseHeaders":Ljava/util/List;, "Ljava/util/List<Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;>;"
    .end local v1    # "i":I
    .end local p0    # "buffer":[B
    .end local p1    # "offset":I
    .end local p2    # "entries":I
    throw v3

    .line 342
    .restart local v0    # "sparseHeaders":Ljava/util/List;, "Ljava/util/List<Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;>;"
    .restart local v1    # "i":I
    .restart local p0    # "buffer":[B
    .restart local p1    # "offset":I
    .restart local p2    # "entries":I
    :cond_1
    new-instance v3, Ljava/io/IOException;

    const-string v4, "Corrupted TAR archive, sparse entry with negative offset"

    invoke-direct {v3, v4}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .end local v0    # "sparseHeaders":Ljava/util/List;, "Ljava/util/List<Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;>;"
    .end local v1    # "i":I
    .end local p0    # "buffer":[B
    .end local p1    # "offset":I
    .end local p2    # "entries":I
    throw v3
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 348
    .end local v2    # "sparseHeader":Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;
    .restart local v0    # "sparseHeaders":Ljava/util/List;, "Ljava/util/List<Lorg/apache/commons/compress/archivers/tar/TarArchiveStructSparse;>;"
    .restart local v1    # "i":I
    .restart local p0    # "buffer":[B
    .restart local p1    # "offset":I
    .restart local p2    # "entries":I
    :catch_0
    move-exception v2

    .line 350
    .local v2, "ex":Ljava/lang/IllegalArgumentException;
    new-instance v3, Ljava/io/IOException;

    const-string v4, "Corrupted TAR archive, sparse entry is invalid"

    invoke-direct {v3, v4, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v3

    .line 353
    .end local v1    # "i":I
    .end local v2    # "ex":Ljava/lang/IllegalArgumentException;
    :cond_2
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    return-object v1
.end method

.method public static verifyCheckSum([B)Z
    .locals 11
    .param p0, "header"    # [B

    .line 651
    const/16 v0, 0x8

    const/16 v1, 0x94

    invoke-static {p0, v1, v0}, Lorg/apache/commons/compress/archivers/tar/TarUtils;->parseOctal([BII)J

    move-result-wide v2

    .line 652
    .local v2, "storedSum":J
    const-wide/16 v4, 0x0

    .line 653
    .local v4, "unsignedSum":J
    const-wide/16 v6, 0x0

    .line 655
    .local v6, "signedSum":J
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    array-length v8, p0

    if-ge v0, v8, :cond_1

    .line 656
    aget-byte v8, p0, v0

    .line 657
    .local v8, "b":B
    if-gt v1, v0, :cond_0

    const/16 v9, 0x9c

    if-ge v0, v9, :cond_0

    .line 658
    const/16 v8, 0x20

    .line 660
    :cond_0
    and-int/lit16 v9, v8, 0xff

    int-to-long v9, v9

    add-long/2addr v4, v9

    .line 661
    int-to-long v9, v8

    add-long/2addr v6, v9

    .line 655
    .end local v8    # "b":B
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 663
    .end local v0    # "i":I
    :cond_1
    cmp-long v0, v2, v4

    if-eqz v0, :cond_3

    cmp-long v0, v2, v6

    if-nez v0, :cond_2

    goto :goto_1

    :cond_2
    const/4 v0, 0x0

    goto :goto_2

    :cond_3
    :goto_1
    const/4 v0, 0x1

    :goto_2
    return v0
.end method
