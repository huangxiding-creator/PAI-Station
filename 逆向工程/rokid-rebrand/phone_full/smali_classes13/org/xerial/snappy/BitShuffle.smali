.class public Lorg/xerial/snappy/BitShuffle;
.super Ljava/lang/Object;
.source "BitShuffle.java"


# static fields
.field static final synthetic $assertionsDisabled:Z

.field private static impl:Lorg/xerial/snappy/BitShuffleNative;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 30
    nop

    .line 34
    :try_start_0
    invoke-static {}, Lorg/xerial/snappy/SnappyLoader;->loadBitShuffleApi()Lorg/xerial/snappy/BitShuffleNative;

    move-result-object v0

    sput-object v0, Lorg/xerial/snappy/BitShuffle;->impl:Lorg/xerial/snappy/BitShuffleNative;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 38
    nop

    .line 39
    return-void

    .line 36
    :catch_0
    move-exception v0

    .line 37
    new-instance v1, Ljava/lang/ExceptionInInitializerError;

    invoke-direct {v1, v0}, Ljava/lang/ExceptionInInitializerError;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public constructor <init>()V
    .locals 0

    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static shuffle(Ljava/nio/ByteBuffer;Lorg/xerial/snappy/BitShuffleType;Ljava/nio/ByteBuffer;)I
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 59
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->isDirect()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 62
    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->isDirect()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 68
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->position()I

    move-result v3

    .line 69
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    .line 70
    invoke-virtual {p1}, Lorg/xerial/snappy/BitShuffleType;->getTypeSize()I

    move-result v4

    .line 71
    rem-int p1, v0, v4

    if-nez p1, :cond_2

    .line 74
    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->remaining()I

    move-result p1

    if-lt p1, v0, :cond_1

    .line 77
    sget-object v1, Lorg/xerial/snappy/BitShuffle;->impl:Lorg/xerial/snappy/BitShuffleNative;

    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->position()I

    move-result v7

    move-object v2, p0

    move v5, v0

    move-object v6, p2

    invoke-virtual/range {v1 .. v7}, Lorg/xerial/snappy/BitShuffleNative;->shuffleDirectBuffer(Ljava/nio/ByteBuffer;IIILjava/nio/ByteBuffer;I)I

    move-result p0

    .line 78
    if-ne p0, v0, :cond_0

    .line 82
    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->position()I

    move-result p1

    add-int/2addr p1, p0

    invoke-virtual {p2, p1}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object p1

    check-cast p1, Ljava/nio/ByteBuffer;

    .line 83
    return p0

    .line 78
    :cond_0
    new-instance p0, Ljava/lang/AssertionError;

    invoke-direct {p0}, Ljava/lang/AssertionError;-><init>()V

    throw p0

    .line 75
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "not enough space for output"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 72
    :cond_2
    new-instance p0, Ljava/lang/IllegalArgumentException;

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "input length must be a multiple of the given type size: "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 63
    :cond_3
    new-instance p0, Lorg/xerial/snappy/SnappyError;

    sget-object p1, Lorg/xerial/snappy/SnappyErrorCode;->NOT_A_DIRECT_BUFFER:Lorg/xerial/snappy/SnappyErrorCode;

    const-string p2, "destination is not a direct buffer"

    invoke-direct {p0, p1, p2}, Lorg/xerial/snappy/SnappyError;-><init>(Lorg/xerial/snappy/SnappyErrorCode;Ljava/lang/String;)V

    throw p0

    .line 60
    :cond_4
    new-instance p0, Lorg/xerial/snappy/SnappyError;

    sget-object p1, Lorg/xerial/snappy/SnappyErrorCode;->NOT_A_DIRECT_BUFFER:Lorg/xerial/snappy/SnappyErrorCode;

    const-string p2, "input is not a direct buffer"

    invoke-direct {p0, p1, p2}, Lorg/xerial/snappy/SnappyError;-><init>(Lorg/xerial/snappy/SnappyErrorCode;Ljava/lang/String;)V

    throw p0
.end method

.method public static shuffle([D)[B
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 150
    array-length v0, p0

    mul-int/lit8 v0, v0, 0x8

    new-array v0, v0, [B

    .line 151
    sget-object v1, Lorg/xerial/snappy/BitShuffle;->impl:Lorg/xerial/snappy/BitShuffleNative;

    array-length v2, p0

    mul-int/lit8 v5, v2, 0x8

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/16 v4, 0x8

    move-object v2, p0

    move-object v6, v0

    invoke-virtual/range {v1 .. v7}, Lorg/xerial/snappy/BitShuffleNative;->shuffle(Ljava/lang/Object;IIILjava/lang/Object;I)I

    move-result v1

    .line 152
    array-length p0, p0

    mul-int/lit8 p0, p0, 0x8

    if-ne v1, p0, :cond_0

    .line 153
    return-object v0

    .line 152
    :cond_0
    new-instance p0, Ljava/lang/AssertionError;

    invoke-direct {p0}, Ljava/lang/AssertionError;-><init>()V

    throw p0
.end method

.method public static shuffle([F)[B
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 136
    array-length v0, p0

    mul-int/lit8 v0, v0, 0x4

    new-array v0, v0, [B

    .line 137
    sget-object v1, Lorg/xerial/snappy/BitShuffle;->impl:Lorg/xerial/snappy/BitShuffleNative;

    array-length v2, p0

    mul-int/lit8 v5, v2, 0x4

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x4

    move-object v2, p0

    move-object v6, v0

    invoke-virtual/range {v1 .. v7}, Lorg/xerial/snappy/BitShuffleNative;->shuffle(Ljava/lang/Object;IIILjava/lang/Object;I)I

    move-result v1

    .line 138
    array-length p0, p0

    mul-int/lit8 p0, p0, 0x4

    if-ne v1, p0, :cond_0

    .line 139
    return-object v0

    .line 138
    :cond_0
    new-instance p0, Ljava/lang/AssertionError;

    invoke-direct {p0}, Ljava/lang/AssertionError;-><init>()V

    throw p0
.end method

.method public static shuffle([I)[B
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 108
    array-length v0, p0

    mul-int/lit8 v0, v0, 0x4

    new-array v0, v0, [B

    .line 109
    sget-object v1, Lorg/xerial/snappy/BitShuffle;->impl:Lorg/xerial/snappy/BitShuffleNative;

    array-length v2, p0

    mul-int/lit8 v5, v2, 0x4

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x4

    move-object v2, p0

    move-object v6, v0

    invoke-virtual/range {v1 .. v7}, Lorg/xerial/snappy/BitShuffleNative;->shuffle(Ljava/lang/Object;IIILjava/lang/Object;I)I

    move-result v1

    .line 110
    array-length p0, p0

    mul-int/lit8 p0, p0, 0x4

    if-ne v1, p0, :cond_0

    .line 111
    return-object v0

    .line 110
    :cond_0
    new-instance p0, Ljava/lang/AssertionError;

    invoke-direct {p0}, Ljava/lang/AssertionError;-><init>()V

    throw p0
.end method

.method public static shuffle([J)[B
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 122
    array-length v0, p0

    mul-int/lit8 v0, v0, 0x8

    new-array v0, v0, [B

    .line 123
    sget-object v1, Lorg/xerial/snappy/BitShuffle;->impl:Lorg/xerial/snappy/BitShuffleNative;

    array-length v2, p0

    mul-int/lit8 v5, v2, 0x8

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/16 v4, 0x8

    move-object v2, p0

    move-object v6, v0

    invoke-virtual/range {v1 .. v7}, Lorg/xerial/snappy/BitShuffleNative;->shuffle(Ljava/lang/Object;IIILjava/lang/Object;I)I

    move-result v1

    .line 124
    array-length p0, p0

    mul-int/lit8 p0, p0, 0x8

    if-ne v1, p0, :cond_0

    .line 125
    return-object v0

    .line 124
    :cond_0
    new-instance p0, Ljava/lang/AssertionError;

    invoke-direct {p0}, Ljava/lang/AssertionError;-><init>()V

    throw p0
.end method

.method public static shuffle([S)[B
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 94
    array-length v0, p0

    mul-int/lit8 v0, v0, 0x2

    new-array v0, v0, [B

    .line 95
    sget-object v1, Lorg/xerial/snappy/BitShuffle;->impl:Lorg/xerial/snappy/BitShuffleNative;

    array-length v2, p0

    mul-int/lit8 v5, v2, 0x2

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x2

    move-object v2, p0

    move-object v6, v0

    invoke-virtual/range {v1 .. v7}, Lorg/xerial/snappy/BitShuffleNative;->shuffle(Ljava/lang/Object;IIILjava/lang/Object;I)I

    move-result v1

    .line 96
    array-length p0, p0

    mul-int/lit8 p0, p0, 0x2

    if-ne v1, p0, :cond_0

    .line 97
    return-object v0

    .line 96
    :cond_0
    new-instance p0, Ljava/lang/AssertionError;

    invoke-direct {p0}, Ljava/lang/AssertionError;-><init>()V

    throw p0
.end method

.method public static unshuffle(Ljava/nio/ByteBuffer;Lorg/xerial/snappy/BitShuffleType;Ljava/nio/ByteBuffer;)I
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 169
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->isDirect()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 172
    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->isDirect()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 178
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->position()I

    move-result v3

    .line 179
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    .line 180
    invoke-virtual {p1}, Lorg/xerial/snappy/BitShuffleType;->getTypeSize()I

    move-result v4

    .line 181
    rem-int p1, v0, v4

    if-nez p1, :cond_2

    .line 184
    invoke-virtual {p2}, Ljava/nio/ByteBuffer;->remaining()I

    move-result p1

    if-lt p1, v0, :cond_1

    .line 187
    sget-object v1, Lorg/xerial/snappy/BitShuffle;->impl:Lorg/xerial/snappy/BitShuffleNative;

    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->position()I

    move-result v7

    move-object v2, p0

    move v5, v0

    move-object v6, p2

    invoke-virtual/range {v1 .. v7}, Lorg/xerial/snappy/BitShuffleNative;->unshuffleDirectBuffer(Ljava/nio/ByteBuffer;IIILjava/nio/ByteBuffer;I)I

    move-result p1

    .line 188
    if-ne p1, v0, :cond_0

    .line 192
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->position()I

    move-result p2

    add-int/2addr p2, p1

    invoke-virtual {p0, p2}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object p0

    check-cast p0, Ljava/nio/ByteBuffer;

    .line 193
    return p1

    .line 188
    :cond_0
    new-instance p0, Ljava/lang/AssertionError;

    invoke-direct {p0}, Ljava/lang/AssertionError;-><init>()V

    throw p0

    .line 185
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "not enough space for output"

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 182
    :cond_2
    new-instance p0, Ljava/lang/IllegalArgumentException;

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "length of input shuffled data must be a multiple of the given type size: "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 173
    :cond_3
    new-instance p0, Lorg/xerial/snappy/SnappyError;

    sget-object p1, Lorg/xerial/snappy/SnappyErrorCode;->NOT_A_DIRECT_BUFFER:Lorg/xerial/snappy/SnappyErrorCode;

    const-string p2, "destination is not a direct buffer"

    invoke-direct {p0, p1, p2}, Lorg/xerial/snappy/SnappyError;-><init>(Lorg/xerial/snappy/SnappyErrorCode;Ljava/lang/String;)V

    throw p0

    .line 170
    :cond_4
    new-instance p0, Lorg/xerial/snappy/SnappyError;

    sget-object p1, Lorg/xerial/snappy/SnappyErrorCode;->NOT_A_DIRECT_BUFFER:Lorg/xerial/snappy/SnappyErrorCode;

    const-string p2, "input is not a direct buffer"

    invoke-direct {p0, p1, p2}, Lorg/xerial/snappy/SnappyError;-><init>(Lorg/xerial/snappy/SnappyErrorCode;Ljava/lang/String;)V

    throw p0
.end method

.method public static unshuffleDoubleArray([B)[D
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 260
    array-length v0, p0

    div-int/lit8 v0, v0, 0x8

    new-array v0, v0, [D

    .line 261
    sget-object v1, Lorg/xerial/snappy/BitShuffle;->impl:Lorg/xerial/snappy/BitShuffleNative;

    array-length v5, p0

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/16 v4, 0x8

    move-object v2, p0

    move-object v6, v0

    invoke-virtual/range {v1 .. v7}, Lorg/xerial/snappy/BitShuffleNative;->unshuffle(Ljava/lang/Object;IIILjava/lang/Object;I)I

    move-result v1

    .line 262
    array-length p0, p0

    if-ne v1, p0, :cond_0

    .line 263
    return-object v0

    .line 262
    :cond_0
    new-instance p0, Ljava/lang/AssertionError;

    invoke-direct {p0}, Ljava/lang/AssertionError;-><init>()V

    throw p0
.end method

.method public static unshuffleFloatArray([B)[F
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 246
    array-length v0, p0

    div-int/lit8 v0, v0, 0x4

    new-array v0, v0, [F

    .line 247
    sget-object v1, Lorg/xerial/snappy/BitShuffle;->impl:Lorg/xerial/snappy/BitShuffleNative;

    array-length v5, p0

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x4

    move-object v2, p0

    move-object v6, v0

    invoke-virtual/range {v1 .. v7}, Lorg/xerial/snappy/BitShuffleNative;->unshuffle(Ljava/lang/Object;IIILjava/lang/Object;I)I

    move-result v1

    .line 248
    array-length p0, p0

    if-ne v1, p0, :cond_0

    .line 249
    return-object v0

    .line 248
    :cond_0
    new-instance p0, Ljava/lang/AssertionError;

    invoke-direct {p0}, Ljava/lang/AssertionError;-><init>()V

    throw p0
.end method

.method public static unshuffleIntArray([B)[I
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 218
    array-length v0, p0

    div-int/lit8 v0, v0, 0x4

    new-array v0, v0, [I

    .line 219
    sget-object v1, Lorg/xerial/snappy/BitShuffle;->impl:Lorg/xerial/snappy/BitShuffleNative;

    array-length v5, p0

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x4

    move-object v2, p0

    move-object v6, v0

    invoke-virtual/range {v1 .. v7}, Lorg/xerial/snappy/BitShuffleNative;->unshuffle(Ljava/lang/Object;IIILjava/lang/Object;I)I

    move-result v1

    .line 220
    array-length p0, p0

    if-ne v1, p0, :cond_0

    .line 221
    return-object v0

    .line 220
    :cond_0
    new-instance p0, Ljava/lang/AssertionError;

    invoke-direct {p0}, Ljava/lang/AssertionError;-><init>()V

    throw p0
.end method

.method public static unshuffleLongArray([B)[J
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 232
    array-length v0, p0

    div-int/lit8 v0, v0, 0x8

    new-array v0, v0, [J

    .line 233
    sget-object v1, Lorg/xerial/snappy/BitShuffle;->impl:Lorg/xerial/snappy/BitShuffleNative;

    array-length v5, p0

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/16 v4, 0x8

    move-object v2, p0

    move-object v6, v0

    invoke-virtual/range {v1 .. v7}, Lorg/xerial/snappy/BitShuffleNative;->unshuffle(Ljava/lang/Object;IIILjava/lang/Object;I)I

    move-result v1

    .line 234
    array-length p0, p0

    if-ne v1, p0, :cond_0

    .line 235
    return-object v0

    .line 234
    :cond_0
    new-instance p0, Ljava/lang/AssertionError;

    invoke-direct {p0}, Ljava/lang/AssertionError;-><init>()V

    throw p0
.end method

.method public static unshuffleShortArray([B)[S
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 204
    array-length v0, p0

    div-int/lit8 v0, v0, 0x2

    new-array v0, v0, [S

    .line 205
    sget-object v1, Lorg/xerial/snappy/BitShuffle;->impl:Lorg/xerial/snappy/BitShuffleNative;

    array-length v5, p0

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x2

    move-object v2, p0

    move-object v6, v0

    invoke-virtual/range {v1 .. v7}, Lorg/xerial/snappy/BitShuffleNative;->unshuffle(Ljava/lang/Object;IIILjava/lang/Object;I)I

    move-result v1

    .line 206
    array-length p0, p0

    if-ne v1, p0, :cond_0

    .line 207
    return-object v0

    .line 206
    :cond_0
    new-instance p0, Ljava/lang/AssertionError;

    invoke-direct {p0}, Ljava/lang/AssertionError;-><init>()V

    throw p0
.end method
