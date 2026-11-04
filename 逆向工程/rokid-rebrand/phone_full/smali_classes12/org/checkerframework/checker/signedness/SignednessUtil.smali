.class public final Lorg/checkerframework/checker/signedness/SignednessUtil;
.super Ljava/lang/Object;
.source "SignednessUtil.java"


# static fields
.field static final synthetic $assertionsDisabled:Z


# direct methods
.method static constructor <clinit>()V
    .locals 0

    .line 19
    return-void
.end method

.method private constructor <init>()V
    .locals 2

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 23
    new-instance v0, Ljava/lang/Error;

    const-string v1, "Do not instantiate"

    invoke-direct {v0, v1}, Ljava/lang/Error;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static byteFromDouble(D)B
    .locals 2
    .param p0, "d"    # D

    .line 499
    const-wide/16 v0, 0x0

    cmpl-double v0, p0, v0

    if-ltz v0, :cond_0

    .line 500
    double-to-int v0, p0

    int-to-byte v0, v0

    return v0

    .line 499
    :cond_0
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
.end method

.method public static byteFromFloat(F)B
    .locals 1
    .param p0, "f"    # F

    .line 471
    const/4 v0, 0x0

    cmpl-float v0, p0, v0

    if-ltz v0, :cond_0

    .line 472
    float-to-int v0, p0

    int-to-byte v0, v0

    return v0

    .line 471
    :cond_0
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
.end method

.method public static compareUnsigned(BB)I
    .locals 2
    .param p0, "x"    # B
    .param p1, "y"    # B

    .line 359
    invoke-static {p0}, Lorg/checkerframework/checker/signedness/SignednessUtil$$ExternalSyntheticBackport2;->m(B)I

    move-result v0

    invoke-static {p1}, Lorg/checkerframework/checker/signedness/SignednessUtil$$ExternalSyntheticBackport2;->m(B)I

    move-result v1

    invoke-static {v0, v1}, Lkotlin/UByte$$ExternalSyntheticBackport4;->m(II)I

    move-result v0

    return v0
.end method

.method public static compareUnsigned(SS)I
    .locals 2
    .param p0, "x"    # S
    .param p1, "y"    # S

    .line 348
    invoke-static {p0}, Lorg/checkerframework/checker/signedness/SignednessUtil$$ExternalSyntheticBackport4;->m(S)I

    move-result v0

    invoke-static {p1}, Lorg/checkerframework/checker/signedness/SignednessUtil$$ExternalSyntheticBackport4;->m(S)I

    move-result v1

    invoke-static {v0, v1}, Lkotlin/UByte$$ExternalSyntheticBackport4;->m(II)I

    move-result v0

    return v0
.end method

.method public static getUnsigned(Ljava/nio/ByteBuffer;)B
    .locals 1
    .param p0, "b"    # Ljava/nio/ByteBuffer;

    .line 73
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->get()B

    move-result v0

    return v0
.end method

.method public static getUnsigned(Ljava/nio/ByteBuffer;I)B
    .locals 1
    .param p0, "b"    # Ljava/nio/ByteBuffer;
    .param p1, "i"    # I

    .line 83
    invoke-virtual {p0, p1}, Ljava/nio/ByteBuffer;->get(I)B

    move-result v0

    return v0
.end method

.method public static getUnsigned(Ljava/nio/IntBuffer;I)I
    .locals 1
    .param p0, "b"    # Ljava/nio/IntBuffer;
    .param p1, "i"    # I

    .line 163
    invoke-virtual {p0, p1}, Ljava/nio/IntBuffer;->get(I)I

    move-result v0

    return v0
.end method

.method public static getUnsigned(Ljava/nio/ByteBuffer;[BII)Ljava/nio/ByteBuffer;
    .locals 1
    .param p0, "b"    # Ljava/nio/ByteBuffer;
    .param p1, "bs"    # [B
    .param p2, "i"    # I
    .param p3, "l"    # I

    .line 93
    invoke-virtual {p0, p1, p2, p3}, Ljava/nio/ByteBuffer;->get([BII)Ljava/nio/ByteBuffer;

    move-result-object v0

    return-object v0
.end method

.method public static getUnsigned(Ljava/nio/ByteBuffer;[B)V
    .locals 0
    .param p0, "b"    # Ljava/nio/ByteBuffer;
    .param p1, "bs"    # [B

    .line 337
    invoke-virtual {p0, p1}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 338
    return-void
.end method

.method public static getUnsignedInt(Ljava/nio/ByteBuffer;)I
    .locals 1
    .param p0, "b"    # Ljava/nio/ByteBuffer;

    .line 53
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v0

    return v0
.end method

.method public static getUnsignedShort(Ljava/nio/ByteBuffer;)S
    .locals 1
    .param p0, "b"    # Ljava/nio/ByteBuffer;

    .line 63
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->getShort()S

    move-result v0

    return v0
.end method

.method public static intFromDouble(D)I
    .locals 2
    .param p0, "d"    # D

    .line 513
    const-wide/16 v0, 0x0

    cmpl-double v0, p0, v0

    if-ltz v0, :cond_0

    .line 514
    double-to-int v0, p0

    return v0

    .line 513
    :cond_0
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
.end method

.method public static intFromFloat(F)I
    .locals 1
    .param p0, "f"    # F

    .line 485
    const/4 v0, 0x0

    cmpl-float v0, p0, v0

    if-ltz v0, :cond_0

    .line 486
    float-to-int v0, p0

    return v0

    .line 485
    :cond_0
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
.end method

.method public static longFromDouble(D)J
    .locals 2
    .param p0, "d"    # D

    .line 520
    const-wide/16 v0, 0x0

    cmpl-double v0, p0, v0

    if-ltz v0, :cond_0

    .line 521
    double-to-long v0, p0

    return-wide v0

    .line 520
    :cond_0
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
.end method

.method public static longFromFloat(F)J
    .locals 2
    .param p0, "f"    # F

    .line 492
    const/4 v0, 0x0

    cmpl-float v0, p0, v0

    if-ltz v0, :cond_0

    .line 493
    float-to-long v0, p0

    return-wide v0

    .line 492
    :cond_0
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
.end method

.method public static putUnsigned(Ljava/nio/ByteBuffer;B)Ljava/nio/ByteBuffer;
    .locals 1
    .param p0, "b"    # Ljava/nio/ByteBuffer;
    .param p1, "ubyte"    # B

    .line 103
    invoke-virtual {p0, p1}, Ljava/nio/ByteBuffer;->put(B)Ljava/nio/ByteBuffer;

    move-result-object v0

    return-object v0
.end method

.method public static putUnsigned(Ljava/nio/ByteBuffer;IB)Ljava/nio/ByteBuffer;
    .locals 1
    .param p0, "b"    # Ljava/nio/ByteBuffer;
    .param p1, "i"    # I
    .param p2, "ubyte"    # B

    .line 113
    invoke-virtual {p0, p1, p2}, Ljava/nio/ByteBuffer;->put(IB)Ljava/nio/ByteBuffer;

    move-result-object v0

    return-object v0
.end method

.method public static putUnsigned(Ljava/nio/IntBuffer;I)Ljava/nio/IntBuffer;
    .locals 1
    .param p0, "b"    # Ljava/nio/IntBuffer;
    .param p1, "uint"    # I

    .line 123
    invoke-virtual {p0, p1}, Ljava/nio/IntBuffer;->put(I)Ljava/nio/IntBuffer;

    move-result-object v0

    return-object v0
.end method

.method public static putUnsigned(Ljava/nio/IntBuffer;II)Ljava/nio/IntBuffer;
    .locals 1
    .param p0, "b"    # Ljava/nio/IntBuffer;
    .param p1, "i"    # I
    .param p2, "uint"    # I

    .line 133
    invoke-virtual {p0, p1, p2}, Ljava/nio/IntBuffer;->put(II)Ljava/nio/IntBuffer;

    move-result-object v0

    return-object v0
.end method

.method public static putUnsigned(Ljava/nio/IntBuffer;[I)Ljava/nio/IntBuffer;
    .locals 1
    .param p0, "b"    # Ljava/nio/IntBuffer;
    .param p1, "uints"    # [I

    .line 143
    invoke-virtual {p0, p1}, Ljava/nio/IntBuffer;->put([I)Ljava/nio/IntBuffer;

    move-result-object v0

    return-object v0
.end method

.method public static putUnsigned(Ljava/nio/IntBuffer;[III)Ljava/nio/IntBuffer;
    .locals 1
    .param p0, "b"    # Ljava/nio/IntBuffer;
    .param p1, "uints"    # [I
    .param p2, "i"    # I
    .param p3, "l"    # I

    .line 153
    invoke-virtual {p0, p1, p2, p3}, Ljava/nio/IntBuffer;->put([III)Ljava/nio/IntBuffer;

    move-result-object v0

    return-object v0
.end method

.method public static putUnsignedInt(Ljava/nio/ByteBuffer;I)Ljava/nio/ByteBuffer;
    .locals 1
    .param p0, "b"    # Ljava/nio/ByteBuffer;
    .param p1, "uint"    # I

    .line 193
    invoke-virtual {p0, p1}, Ljava/nio/ByteBuffer;->putInt(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    return-object v0
.end method

.method public static putUnsignedInt(Ljava/nio/ByteBuffer;II)Ljava/nio/ByteBuffer;
    .locals 1
    .param p0, "b"    # Ljava/nio/ByteBuffer;
    .param p1, "i"    # I
    .param p2, "uint"    # I

    .line 203
    invoke-virtual {p0, p1, p2}, Ljava/nio/ByteBuffer;->putInt(II)Ljava/nio/ByteBuffer;

    move-result-object v0

    return-object v0
.end method

.method public static putUnsignedLong(Ljava/nio/ByteBuffer;IJ)Ljava/nio/ByteBuffer;
    .locals 1
    .param p0, "b"    # Ljava/nio/ByteBuffer;
    .param p1, "i"    # I
    .param p2, "ulong"    # J

    .line 213
    invoke-virtual {p0, p1, p2, p3}, Ljava/nio/ByteBuffer;->putLong(IJ)Ljava/nio/ByteBuffer;

    move-result-object v0

    return-object v0
.end method

.method public static putUnsignedShort(Ljava/nio/ByteBuffer;IS)Ljava/nio/ByteBuffer;
    .locals 1
    .param p0, "b"    # Ljava/nio/ByteBuffer;
    .param p1, "i"    # I
    .param p2, "ushort"    # S

    .line 183
    invoke-virtual {p0, p1, p2}, Ljava/nio/ByteBuffer;->putShort(IS)Ljava/nio/ByteBuffer;

    move-result-object v0

    return-object v0
.end method

.method public static putUnsignedShort(Ljava/nio/ByteBuffer;S)Ljava/nio/ByteBuffer;
    .locals 1
    .param p0, "b"    # Ljava/nio/ByteBuffer;
    .param p1, "ushort"    # S

    .line 173
    invoke-virtual {p0, p1}, Ljava/nio/ByteBuffer;->putShort(S)Ljava/nio/ByteBuffer;

    move-result-object v0

    return-object v0
.end method

.method public static readFullyUnsigned(Ljava/io/RandomAccessFile;[B)V
    .locals 0
    .param p0, "f"    # Ljava/io/RandomAccessFile;
    .param p1, "b"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 265
    invoke-virtual {p0, p1}, Ljava/io/RandomAccessFile;->readFully([B)V

    .line 266
    return-void
.end method

.method public static readUnsigned(Ljava/io/RandomAccessFile;[BII)I
    .locals 1
    .param p0, "f"    # Ljava/io/RandomAccessFile;
    .param p1, "b"    # [B
    .param p2, "off"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 254
    invoke-virtual {p0, p1, p2, p3}, Ljava/io/RandomAccessFile;->read([BII)I

    move-result v0

    return v0
.end method

.method public static readUnsignedChar(Ljava/io/RandomAccessFile;)C
    .locals 1
    .param p0, "f"    # Ljava/io/RandomAccessFile;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 223
    invoke-virtual {p0}, Ljava/io/RandomAccessFile;->readChar()C

    move-result v0

    return v0
.end method

.method public static readUnsignedInt(Ljava/io/RandomAccessFile;)I
    .locals 1
    .param p0, "f"    # Ljava/io/RandomAccessFile;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 233
    invoke-virtual {p0}, Ljava/io/RandomAccessFile;->readInt()I

    move-result v0

    return v0
.end method

.method public static readUnsignedLong(Ljava/io/RandomAccessFile;)J
    .locals 2
    .param p0, "f"    # Ljava/io/RandomAccessFile;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 243
    invoke-virtual {p0}, Ljava/io/RandomAccessFile;->readLong()J

    move-result-wide v0

    return-wide v0
.end method

.method public static shortFromDouble(D)S
    .locals 2
    .param p0, "d"    # D

    .line 506
    const-wide/16 v0, 0x0

    cmpl-double v0, p0, v0

    if-ltz v0, :cond_0

    .line 507
    double-to-int v0, p0

    int-to-short v0, v0

    return v0

    .line 506
    :cond_0
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
.end method

.method public static shortFromFloat(F)S
    .locals 1
    .param p0, "f"    # F

    .line 478
    const/4 v0, 0x0

    cmpl-float v0, p0, v0

    if-ltz v0, :cond_0

    .line 479
    float-to-int v0, p0

    int-to-short v0, v0

    return v0

    .line 478
    :cond_0
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
.end method

.method public static toDouble(B)D
    .locals 2
    .param p0, "b"    # B

    .line 450
    invoke-static {p0}, Lorg/checkerframework/checker/signedness/SignednessUtil$$ExternalSyntheticBackport0;->m(B)J

    move-result-wide v0

    invoke-static {v0, v1}, Lorg/checkerframework/checker/signedness/SignednessUtil;->toUnsignedBigInteger(J)Ljava/math/BigInteger;

    move-result-object v0

    invoke-virtual {v0}, Ljava/math/BigInteger;->doubleValue()D

    move-result-wide v0

    return-wide v0
.end method

.method public static toDouble(I)D
    .locals 2
    .param p0, "i"    # I

    .line 460
    invoke-static {p0}, Lorg/checkerframework/checker/signedness/SignednessUtil$$ExternalSyntheticBackport5;->m(I)J

    move-result-wide v0

    invoke-static {v0, v1}, Lorg/checkerframework/checker/signedness/SignednessUtil;->toUnsignedBigInteger(J)Ljava/math/BigInteger;

    move-result-object v0

    invoke-virtual {v0}, Ljava/math/BigInteger;->doubleValue()D

    move-result-wide v0

    return-wide v0
.end method

.method public static toDouble(J)D
    .locals 2
    .param p0, "l"    # J

    .line 465
    invoke-static {p0, p1}, Lorg/checkerframework/checker/signedness/SignednessUtil;->toUnsignedBigInteger(J)Ljava/math/BigInteger;

    move-result-object v0

    invoke-virtual {v0}, Ljava/math/BigInteger;->doubleValue()D

    move-result-wide v0

    return-wide v0
.end method

.method public static toDouble(S)D
    .locals 2
    .param p0, "s"    # S

    .line 455
    invoke-static {p0}, Lorg/checkerframework/checker/signedness/SignednessUtil$$ExternalSyntheticBackport1;->m(S)J

    move-result-wide v0

    invoke-static {v0, v1}, Lorg/checkerframework/checker/signedness/SignednessUtil;->toUnsignedBigInteger(J)Ljava/math/BigInteger;

    move-result-object v0

    invoke-virtual {v0}, Ljava/math/BigInteger;->doubleValue()D

    move-result-wide v0

    return-wide v0
.end method

.method public static toFloat(B)F
    .locals 2
    .param p0, "b"    # B

    .line 430
    invoke-static {p0}, Lorg/checkerframework/checker/signedness/SignednessUtil$$ExternalSyntheticBackport0;->m(B)J

    move-result-wide v0

    invoke-static {v0, v1}, Lorg/checkerframework/checker/signedness/SignednessUtil;->toUnsignedBigInteger(J)Ljava/math/BigInteger;

    move-result-object v0

    invoke-virtual {v0}, Ljava/math/BigInteger;->floatValue()F

    move-result v0

    return v0
.end method

.method public static toFloat(I)F
    .locals 2
    .param p0, "i"    # I

    .line 440
    invoke-static {p0}, Lorg/checkerframework/checker/signedness/SignednessUtil$$ExternalSyntheticBackport5;->m(I)J

    move-result-wide v0

    invoke-static {v0, v1}, Lorg/checkerframework/checker/signedness/SignednessUtil;->toUnsignedBigInteger(J)Ljava/math/BigInteger;

    move-result-object v0

    invoke-virtual {v0}, Ljava/math/BigInteger;->floatValue()F

    move-result v0

    return v0
.end method

.method public static toFloat(J)F
    .locals 1
    .param p0, "l"    # J

    .line 445
    invoke-static {p0, p1}, Lorg/checkerframework/checker/signedness/SignednessUtil;->toUnsignedBigInteger(J)Ljava/math/BigInteger;

    move-result-object v0

    invoke-virtual {v0}, Ljava/math/BigInteger;->floatValue()F

    move-result v0

    return v0
.end method

.method public static toFloat(S)F
    .locals 2
    .param p0, "s"    # S

    .line 435
    invoke-static {p0}, Lorg/checkerframework/checker/signedness/SignednessUtil$$ExternalSyntheticBackport1;->m(S)J

    move-result-wide v0

    invoke-static {v0, v1}, Lorg/checkerframework/checker/signedness/SignednessUtil;->toUnsignedBigInteger(J)Ljava/math/BigInteger;

    move-result-object v0

    invoke-virtual {v0}, Ljava/math/BigInteger;->floatValue()F

    move-result v0

    return v0
.end method

.method private static toUnsignedBigInteger(J)Ljava/math/BigInteger;
    .locals 5
    .param p0, "l"    # J

    .line 395
    const-wide/16 v0, 0x0

    cmp-long v0, p0, v0

    if-ltz v0, :cond_0

    .line 396
    invoke-static {p0, p1}, Ljava/math/BigInteger;->valueOf(J)Ljava/math/BigInteger;

    move-result-object v0

    return-object v0

    .line 398
    :cond_0
    const/16 v0, 0x20

    ushr-long v1, p0, v0

    long-to-int v1, v1

    .line 399
    .local v1, "upper":I
    long-to-int v2, p0

    .line 402
    .local v2, "lower":I
    invoke-static {v1}, Lorg/checkerframework/checker/signedness/SignednessUtil$$ExternalSyntheticBackport5;->m(I)J

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/math/BigInteger;->valueOf(J)Ljava/math/BigInteger;

    move-result-object v3

    .line 403
    invoke-virtual {v3, v0}, Ljava/math/BigInteger;->shiftLeft(I)Ljava/math/BigInteger;

    move-result-object v0

    .line 404
    invoke-static {v2}, Lorg/checkerframework/checker/signedness/SignednessUtil$$ExternalSyntheticBackport5;->m(I)J

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/math/BigInteger;->valueOf(J)Ljava/math/BigInteger;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/math/BigInteger;->add(Ljava/math/BigInteger;)Ljava/math/BigInteger;

    move-result-object v0

    .line 402
    return-object v0
.end method

.method public static toUnsignedInt(C)I
    .locals 1
    .param p0, "c"    # C

    .line 420
    and-int/lit16 v0, p0, 0xff

    return v0
.end method

.method public static toUnsignedLong(C)J
    .locals 4
    .param p0, "c"    # C

    .line 415
    int-to-long v0, p0

    const-wide/16 v2, 0xff

    and-long/2addr v0, v2

    return-wide v0
.end method

.method public static toUnsignedShort(B)S
    .locals 1
    .param p0, "b"    # B

    .line 410
    and-int/lit16 v0, p0, 0xff

    int-to-short v0, v0

    return v0
.end method

.method public static toUnsignedShort(C)S
    .locals 1
    .param p0, "c"    # C

    .line 425
    and-int/lit16 v0, p0, 0xff

    int-to-short v0, v0

    return v0
.end method

.method public static toUnsignedString(B)Ljava/lang/String;
    .locals 1
    .param p0, "b"    # B

    .line 377
    invoke-static {p0}, Lorg/checkerframework/checker/signedness/SignednessUtil$$ExternalSyntheticBackport2;->m(B)I

    move-result v0

    invoke-static {v0}, Lorg/checkerframework/checker/signedness/SignednessUtil$$ExternalSyntheticBackport6;->m(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static toUnsignedString(BI)Ljava/lang/String;
    .locals 1
    .param p0, "b"    # B
    .param p1, "radix"    # I

    .line 383
    invoke-static {p0}, Lorg/checkerframework/checker/signedness/SignednessUtil$$ExternalSyntheticBackport2;->m(B)I

    move-result v0

    invoke-static {v0, p1}, Lorg/checkerframework/checker/signedness/SignednessUtil$$ExternalSyntheticBackport3;->m(II)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static toUnsignedString(S)Ljava/lang/String;
    .locals 2
    .param p0, "s"    # S

    .line 365
    invoke-static {p0}, Lorg/checkerframework/checker/signedness/SignednessUtil$$ExternalSyntheticBackport1;->m(S)J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static toUnsignedString(SI)Ljava/lang/String;
    .locals 1
    .param p0, "s"    # S
    .param p1, "radix"    # I

    .line 371
    invoke-static {p0}, Lorg/checkerframework/checker/signedness/SignednessUtil$$ExternalSyntheticBackport4;->m(S)I

    move-result v0

    invoke-static {v0, p1}, Lorg/checkerframework/checker/signedness/SignednessUtil$$ExternalSyntheticBackport3;->m(II)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static wrapUnsigned([B)Ljava/nio/ByteBuffer;
    .locals 1
    .param p0, "array"    # [B

    .line 33
    invoke-static {p0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    return-object v0
.end method

.method public static wrapUnsigned([BII)Ljava/nio/ByteBuffer;
    .locals 1
    .param p0, "array"    # [B
    .param p1, "offset"    # I
    .param p2, "length"    # I

    .line 43
    invoke-static {p0, p1, p2}, Ljava/nio/ByteBuffer;->wrap([BII)Ljava/nio/ByteBuffer;

    move-result-object v0

    return-object v0
.end method

.method public static writeUnsigned(Ljava/io/RandomAccessFile;[BII)V
    .locals 0
    .param p0, "f"    # Ljava/io/RandomAccessFile;
    .param p1, "bs"    # [B
    .param p2, "off"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 276
    invoke-virtual {p0, p1, p2, p3}, Ljava/io/RandomAccessFile;->write([BII)V

    .line 277
    return-void
.end method

.method public static writeUnsignedByte(Ljava/io/RandomAccessFile;B)V
    .locals 1
    .param p0, "f"    # Ljava/io/RandomAccessFile;
    .param p1, "b"    # B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 286
    invoke-static {p1}, Lorg/checkerframework/checker/signedness/SignednessUtil$$ExternalSyntheticBackport2;->m(B)I

    move-result v0

    invoke-virtual {p0, v0}, Ljava/io/RandomAccessFile;->writeByte(I)V

    .line 287
    return-void
.end method

.method public static writeUnsignedChar(Ljava/io/RandomAccessFile;C)V
    .locals 1
    .param p0, "f"    # Ljava/io/RandomAccessFile;
    .param p1, "c"    # C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 296
    invoke-static {p1}, Lorg/checkerframework/checker/signedness/SignednessUtil;->toUnsignedInt(C)I

    move-result v0

    invoke-virtual {p0, v0}, Ljava/io/RandomAccessFile;->writeChar(I)V

    .line 297
    return-void
.end method

.method public static writeUnsignedInt(Ljava/io/RandomAccessFile;I)V
    .locals 0
    .param p0, "f"    # Ljava/io/RandomAccessFile;
    .param p1, "i"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 317
    invoke-virtual {p0, p1}, Ljava/io/RandomAccessFile;->writeInt(I)V

    .line 318
    return-void
.end method

.method public static writeUnsignedLong(Ljava/io/RandomAccessFile;J)V
    .locals 0
    .param p0, "f"    # Ljava/io/RandomAccessFile;
    .param p1, "l"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 327
    invoke-virtual {p0, p1, p2}, Ljava/io/RandomAccessFile;->writeLong(J)V

    .line 328
    return-void
.end method

.method public static writeUnsignedShort(Ljava/io/RandomAccessFile;S)V
    .locals 1
    .param p0, "f"    # Ljava/io/RandomAccessFile;
    .param p1, "s"    # S
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 307
    invoke-static {p1}, Lorg/checkerframework/checker/signedness/SignednessUtil$$ExternalSyntheticBackport4;->m(S)I

    move-result v0

    invoke-virtual {p0, v0}, Ljava/io/RandomAccessFile;->writeShort(I)V

    .line 308
    return-void
.end method
