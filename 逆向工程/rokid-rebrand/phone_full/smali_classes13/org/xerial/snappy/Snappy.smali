.class public Lorg/xerial/snappy/Snappy;
.super Ljava/lang/Object;
.source "Snappy.java"


# static fields
.field private static impl:Lorg/xerial/snappy/SnappyNative;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 47
    :try_start_0
    invoke-static {}, Lorg/xerial/snappy/SnappyLoader;->loadSnappyApi()Lorg/xerial/snappy/SnappyNative;

    move-result-object v0

    sput-object v0, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 51
    nop

    .line 52
    return-void

    .line 49
    :catch_0
    move-exception v0

    .line 50
    new-instance v1, Ljava/lang/ExceptionInInitializerError;

    invoke-direct {v1, v0}, Ljava/lang/ExceptionInInitializerError;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method public constructor <init>()V
    .locals 0

    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static arrayCopy(Ljava/lang/Object;IILjava/lang/Object;I)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 85
    sget-object v0, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    move-object v1, p0

    move v2, p1

    move v3, p2

    move-object v4, p3

    move v5, p4

    invoke-virtual/range {v0 .. v5}, Lorg/xerial/snappy/SnappyNative;->arrayCopy(Ljava/lang/Object;IILjava/lang/Object;I)V

    .line 86
    return-void
.end method

.method public static cleanUp()V
    .locals 1

    .line 68
    invoke-static {}, Lorg/xerial/snappy/SnappyLoader;->cleanUpExtractedNativeLib()V

    .line 69
    const/4 v0, 0x0

    invoke-static {v0}, Lorg/xerial/snappy/SnappyLoader;->setSnappyApi(Lorg/xerial/snappy/SnappyNative;)V

    .line 70
    return-void
.end method

.method public static compress(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;)I
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 136
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->isDirect()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 139
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->isDirect()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 145
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->position()I

    move-result v3

    .line 146
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v4

    .line 147
    sget-object v1, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    .line 148
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v6

    .line 147
    move-object v2, p0

    move-object v5, p1

    invoke-virtual/range {v1 .. v6}, Lorg/xerial/snappy/SnappyNative;->rawCompress(Ljava/nio/ByteBuffer;IILjava/nio/ByteBuffer;I)I

    move-result p0

    .line 152
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v0

    add-int/2addr v0, p0

    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object p1

    check-cast p1, Ljava/nio/ByteBuffer;

    .line 154
    return p0

    .line 140
    :cond_0
    new-instance p0, Lorg/xerial/snappy/SnappyError;

    sget-object p1, Lorg/xerial/snappy/SnappyErrorCode;->NOT_A_DIRECT_BUFFER:Lorg/xerial/snappy/SnappyErrorCode;

    const-string v0, "destination is not a direct buffer"

    invoke-direct {p0, p1, v0}, Lorg/xerial/snappy/SnappyError;-><init>(Lorg/xerial/snappy/SnappyErrorCode;Ljava/lang/String;)V

    throw p0

    .line 137
    :cond_1
    new-instance p0, Lorg/xerial/snappy/SnappyError;

    sget-object p1, Lorg/xerial/snappy/SnappyErrorCode;->NOT_A_DIRECT_BUFFER:Lorg/xerial/snappy/SnappyErrorCode;

    const-string v0, "input is not a direct buffer"

    invoke-direct {p0, p1, v0}, Lorg/xerial/snappy/SnappyError;-><init>(Lorg/xerial/snappy/SnappyErrorCode;Ljava/lang/String;)V

    throw p0
.end method

.method public static compress([BII[BI)I
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 119
    invoke-static {p0, p1, p2, p3, p4}, Lorg/xerial/snappy/Snappy;->rawCompress(Ljava/lang/Object;II[BI)I

    move-result p0

    return p0
.end method

.method public static compress(Ljava/lang/String;)[B
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 240
    :try_start_0
    const-string v0, "UTF-8"

    invoke-static {p0, v0}, Lorg/xerial/snappy/Snappy;->compress(Ljava/lang/String;Ljava/lang/String;)[B

    move-result-object p0
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    .line 242
    :catch_0
    move-exception p0

    .line 243
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string v0, "UTF-8 encoder is not found"

    invoke-direct {p0, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static compress(Ljava/lang/String;Ljava/lang/String;)[B
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/UnsupportedEncodingException;,
            Ljava/io/IOException;
        }
    .end annotation

    .line 259
    invoke-virtual {p0, p1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object p0

    .line 260
    invoke-static {p0}, Lorg/xerial/snappy/Snappy;->compress([B)[B

    move-result-object p0

    return-object p0
.end method

.method public static compress(Ljava/lang/String;Ljava/nio/charset/Charset;)[B
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 275
    invoke-virtual {p0, p1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p0

    .line 276
    invoke-static {p0}, Lorg/xerial/snappy/Snappy;->compress([B)[B

    move-result-object p0

    return-object p0
.end method

.method public static compress([B)[B
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 101
    array-length v0, p0

    invoke-static {p0, v0}, Lorg/xerial/snappy/Snappy;->rawCompress(Ljava/lang/Object;I)[B

    move-result-object p0

    return-object p0
.end method

.method public static compress([C)[B
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 166
    array-length v0, p0

    mul-int/lit8 v0, v0, 0x2

    invoke-static {p0, v0}, Lorg/xerial/snappy/Snappy;->rawCompress(Ljava/lang/Object;I)[B

    move-result-object p0

    return-object p0
.end method

.method public static compress([D)[B
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 178
    array-length v0, p0

    mul-int/lit8 v0, v0, 0x8

    invoke-static {p0, v0}, Lorg/xerial/snappy/Snappy;->rawCompress(Ljava/lang/Object;I)[B

    move-result-object p0

    return-object p0
.end method

.method public static compress([F)[B
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 190
    array-length v0, p0

    mul-int/lit8 v0, v0, 0x4

    invoke-static {p0, v0}, Lorg/xerial/snappy/Snappy;->rawCompress(Ljava/lang/Object;I)[B

    move-result-object p0

    return-object p0
.end method

.method public static compress([I)[B
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 202
    array-length v0, p0

    mul-int/lit8 v0, v0, 0x4

    invoke-static {p0, v0}, Lorg/xerial/snappy/Snappy;->rawCompress(Ljava/lang/Object;I)[B

    move-result-object p0

    return-object p0
.end method

.method public static compress([J)[B
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 214
    array-length v0, p0

    mul-int/lit8 v0, v0, 0x8

    invoke-static {p0, v0}, Lorg/xerial/snappy/Snappy;->rawCompress(Ljava/lang/Object;I)[B

    move-result-object p0

    return-object p0
.end method

.method public static compress([S)[B
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 226
    array-length v0, p0

    mul-int/lit8 v0, v0, 0x2

    invoke-static {p0, v0}, Lorg/xerial/snappy/Snappy;->rawCompress(Ljava/lang/Object;I)[B

    move-result-object p0

    return-object p0
.end method

.method public static getNativeLibraryVersion()Ljava/lang/String;
    .locals 6

    .line 286
    const-class v0, Lorg/xerial/snappy/SnappyLoader;

    const-string v1, "/org/xerial/snappy/VERSION"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getResource(Ljava/lang/String;)Ljava/net/URL;

    move-result-object v0

    .line 288
    nop

    .line 290
    const-string v1, "unknown"

    if-eqz v0, :cond_2

    .line 291
    nop

    .line 293
    const/4 v2, 0x0

    :try_start_0
    new-instance v3, Ljava/util/Properties;

    invoke-direct {v3}, Ljava/util/Properties;-><init>()V

    .line 294
    invoke-virtual {v0}, Ljava/net/URL;->openStream()Ljava/io/InputStream;

    move-result-object v2

    .line 295
    invoke-virtual {v3, v2}, Ljava/util/Properties;->load(Ljava/io/InputStream;)V

    .line 296
    const-string v0, "version"

    invoke-virtual {v3, v0, v1}, Ljava/util/Properties;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 297
    :try_start_1
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 298
    const-string v1, "SNAPPY_VERSION"

    invoke-virtual {v3, v1, v0}, Ljava/util/Properties;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-object v1, v0

    goto :goto_0

    .line 297
    :cond_0
    move-object v1, v0

    .line 300
    :goto_0
    :try_start_2
    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    const-string v3, "[^0-9\\.]"

    const-string v4, ""

    invoke-virtual {v0, v3, v4}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 303
    if-eqz v2, :cond_2

    .line 304
    :try_start_3
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_3

    .line 309
    :catch_0
    move-exception v0

    goto :goto_2

    .line 303
    :catchall_0
    move-exception v1

    goto :goto_1

    :catchall_1
    move-exception v0

    move-object v5, v1

    move-object v1, v0

    move-object v0, v5

    :goto_1
    if-eqz v2, :cond_1

    .line 304
    :try_start_4
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    .line 306
    :cond_1
    throw v1
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1

    .line 309
    :catch_1
    move-exception v1

    move-object v5, v1

    move-object v1, v0

    move-object v0, v5

    .line 310
    :goto_2
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_4

    .line 311
    :cond_2
    :goto_3
    nop

    .line 312
    :goto_4
    return-object v1
.end method

.method public static isValidCompressedBuffer(JJJ)Z
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 364
    sget-object v0, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    move-wide v1, p0

    move-wide v3, p2

    move-wide v5, p4

    invoke-virtual/range {v0 .. v6}, Lorg/xerial/snappy/SnappyNative;->isValidCompressedBuffer(JJJ)Z

    move-result p0

    return p0
.end method

.method public static isValidCompressedBuffer(Ljava/nio/ByteBuffer;)Z
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 351
    sget-object v0, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->position()I

    move-result v1

    .line 352
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v2

    .line 351
    invoke-virtual {v0, p0, v1, v2}, Lorg/xerial/snappy/SnappyNative;->isValidCompressedBuffer(Ljava/nio/ByteBuffer;II)Z

    move-result p0

    return p0
.end method

.method public static isValidCompressedBuffer([B)Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 339
    const/4 v0, 0x0

    array-length v1, p0

    invoke-static {p0, v0, v1}, Lorg/xerial/snappy/Snappy;->isValidCompressedBuffer([BII)Z

    move-result p0

    return p0
.end method

.method public static isValidCompressedBuffer([BII)Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 324
    if-eqz p0, :cond_0

    .line 327
    sget-object v0, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    invoke-virtual {v0, p0, p1, p2}, Lorg/xerial/snappy/SnappyNative;->isValidCompressedBuffer(Ljava/lang/Object;II)Z

    move-result p0

    return p0

    .line 325
    :cond_0
    new-instance p0, Ljava/lang/NullPointerException;

    const-string p1, "input is null"

    invoke-direct {p0, p1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static maxCompressedLength(I)I
    .locals 1

    .line 376
    sget-object v0, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    invoke-virtual {v0, p0}, Lorg/xerial/snappy/SnappyNative;->maxCompressedLength(I)I

    move-result p0

    return p0
.end method

.method public static rawCompress(Ljava/lang/Object;II[BI)I
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 441
    if-eqz p0, :cond_0

    if-eqz p3, :cond_0

    .line 445
    sget-object v0, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    .line 446
    move-object v1, p0

    move v2, p1

    move v3, p2

    move-object v4, p3

    move v5, p4

    invoke-virtual/range {v0 .. v5}, Lorg/xerial/snappy/SnappyNative;->rawCompress(Ljava/lang/Object;IILjava/lang/Object;I)I

    move-result p0

    .line 447
    return p0

    .line 442
    :cond_0
    new-instance p0, Ljava/lang/NullPointerException;

    const-string p1, "input or output is null"

    invoke-direct {p0, p1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static rawCompress(JJJ)J
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 391
    sget-object v0, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    move-wide v1, p0

    move-wide v3, p2

    move-wide v5, p4

    invoke-virtual/range {v0 .. v6}, Lorg/xerial/snappy/SnappyNative;->rawCompress(JJJ)J

    move-result-wide p0

    return-wide p0
.end method

.method public static rawCompress(Ljava/lang/Object;I)[B
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 419
    invoke-static {p1}, Lorg/xerial/snappy/Snappy;->maxCompressedLength(I)I

    move-result v0

    new-array v0, v0, [B

    .line 420
    sget-object v1, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    const/4 v3, 0x0

    const/4 v6, 0x0

    move-object v2, p0

    move v4, p1

    move-object v5, v0

    invoke-virtual/range {v1 .. v6}, Lorg/xerial/snappy/SnappyNative;->rawCompress(Ljava/lang/Object;IILjava/lang/Object;I)I

    move-result p0

    .line 421
    new-array p1, p0, [B

    .line 422
    const/4 v1, 0x0

    invoke-static {v0, v1, p1, v1, p0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 423
    return-object p1
.end method

.method public static rawUncompress([BIILjava/lang/Object;I)I
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 471
    if-eqz p0, :cond_0

    if-eqz p3, :cond_0

    .line 474
    sget-object v0, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    move-object v1, p0

    move v2, p1

    move v3, p2

    move-object v4, p3

    move v5, p4

    invoke-virtual/range {v0 .. v5}, Lorg/xerial/snappy/SnappyNative;->rawUncompress(Ljava/lang/Object;IILjava/lang/Object;I)I

    move-result p0

    return p0

    .line 472
    :cond_0
    new-instance p0, Ljava/lang/NullPointerException;

    const-string p1, "input or output is null"

    invoke-direct {p0, p1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static rawUncompress(JJJ)J
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 406
    sget-object v0, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    move-wide v1, p0

    move-wide v3, p2

    move-wide v5, p4

    invoke-virtual/range {v0 .. v6}, Lorg/xerial/snappy/SnappyNative;->rawUncompress(JJJ)J

    move-result-wide p0

    return-wide p0
.end method

.method public static uncompress(Ljava/nio/ByteBuffer;Ljava/nio/ByteBuffer;)I
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 535
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->isDirect()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 538
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->isDirect()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 542
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->position()I

    move-result v3

    .line 543
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v4

    .line 547
    sget-object v1, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    .line 548
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v6

    .line 547
    move-object v2, p0

    move-object v5, p1

    invoke-virtual/range {v1 .. v6}, Lorg/xerial/snappy/SnappyNative;->rawUncompress(Ljava/nio/ByteBuffer;IILjava/nio/ByteBuffer;I)I

    move-result p0

    .line 549
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v0

    add-int/2addr v0, p0

    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    move-result-object p1

    check-cast p1, Ljava/nio/ByteBuffer;

    .line 551
    return p0

    .line 539
    :cond_0
    new-instance p0, Lorg/xerial/snappy/SnappyError;

    sget-object p1, Lorg/xerial/snappy/SnappyErrorCode;->NOT_A_DIRECT_BUFFER:Lorg/xerial/snappy/SnappyErrorCode;

    const-string v0, "destination is not a direct buffer"

    invoke-direct {p0, p1, v0}, Lorg/xerial/snappy/SnappyError;-><init>(Lorg/xerial/snappy/SnappyErrorCode;Ljava/lang/String;)V

    throw p0

    .line 536
    :cond_1
    new-instance p0, Lorg/xerial/snappy/SnappyError;

    sget-object p1, Lorg/xerial/snappy/SnappyErrorCode;->NOT_A_DIRECT_BUFFER:Lorg/xerial/snappy/SnappyErrorCode;

    const-string v0, "input is not a direct buffer"

    invoke-direct {p0, p1, v0}, Lorg/xerial/snappy/SnappyError;-><init>(Lorg/xerial/snappy/SnappyErrorCode;Ljava/lang/String;)V

    throw p0
.end method

.method public static uncompress([BII[BI)I
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 513
    invoke-static {p0, p1, p2, p3, p4}, Lorg/xerial/snappy/Snappy;->rawUncompress([BIILjava/lang/Object;I)I

    move-result p0

    return p0
.end method

.method public static uncompress([B)[B
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 487
    invoke-static {p0}, Lorg/xerial/snappy/Snappy;->uncompressedLength([B)I

    move-result v0

    new-array v0, v0, [B

    .line 488
    const/4 v1, 0x0

    array-length v2, p0

    invoke-static {p0, v1, v2, v0, v1}, Lorg/xerial/snappy/Snappy;->uncompress([BII[BI)I

    .line 489
    return-object v0
.end method

.method public static uncompressCharArray([B)[C
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 564
    const/4 v0, 0x0

    array-length v1, p0

    invoke-static {p0, v0, v1}, Lorg/xerial/snappy/Snappy;->uncompressCharArray([BII)[C

    move-result-object p0

    return-object p0
.end method

.method public static uncompressCharArray([BII)[C
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 579
    invoke-static {p0, p1, p2}, Lorg/xerial/snappy/Snappy;->uncompressedLength([BII)I

    move-result v0

    .line 580
    div-int/lit8 v0, v0, 0x2

    new-array v0, v0, [C

    .line 581
    sget-object v1, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    const/4 v6, 0x0

    move-object v2, p0

    move v3, p1

    move v4, p2

    move-object v5, v0

    invoke-virtual/range {v1 .. v6}, Lorg/xerial/snappy/SnappyNative;->rawUncompress(Ljava/lang/Object;IILjava/lang/Object;I)I

    .line 582
    return-object v0
.end method

.method public static uncompressDoubleArray([B)[D
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 595
    const/4 v0, 0x0

    array-length v1, p0

    invoke-static {p0, v0, v1}, Lorg/xerial/snappy/Snappy;->uncompressedLength([BII)I

    move-result v0

    .line 596
    div-int/lit8 v0, v0, 0x8

    new-array v0, v0, [D

    .line 597
    sget-object v1, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    array-length v4, p0

    const/4 v6, 0x0

    const/4 v3, 0x0

    move-object v2, p0

    move-object v5, v0

    invoke-virtual/range {v1 .. v6}, Lorg/xerial/snappy/SnappyNative;->rawUncompress(Ljava/lang/Object;IILjava/lang/Object;I)I

    .line 598
    return-object v0
.end method

.method public static uncompressFloatArray([B)[F
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 682
    const/4 v0, 0x0

    array-length v1, p0

    invoke-static {p0, v0, v1}, Lorg/xerial/snappy/Snappy;->uncompressFloatArray([BII)[F

    move-result-object p0

    return-object p0
.end method

.method public static uncompressFloatArray([BII)[F
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 697
    invoke-static {p0, p1, p2}, Lorg/xerial/snappy/Snappy;->uncompressedLength([BII)I

    move-result v0

    .line 698
    div-int/lit8 v0, v0, 0x4

    new-array v0, v0, [F

    .line 699
    sget-object v1, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    const/4 v6, 0x0

    move-object v2, p0

    move v3, p1

    move v4, p2

    move-object v5, v0

    invoke-virtual/range {v1 .. v6}, Lorg/xerial/snappy/SnappyNative;->rawUncompress(Ljava/lang/Object;IILjava/lang/Object;I)I

    .line 700
    return-object v0
.end method

.method public static uncompressIntArray([B)[I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 713
    const/4 v0, 0x0

    array-length v1, p0

    invoke-static {p0, v0, v1}, Lorg/xerial/snappy/Snappy;->uncompressIntArray([BII)[I

    move-result-object p0

    return-object p0
.end method

.method public static uncompressIntArray([BII)[I
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 728
    invoke-static {p0, p1, p2}, Lorg/xerial/snappy/Snappy;->uncompressedLength([BII)I

    move-result v0

    .line 729
    div-int/lit8 v0, v0, 0x4

    new-array v0, v0, [I

    .line 730
    sget-object v1, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    const/4 v6, 0x0

    move-object v2, p0

    move v3, p1

    move v4, p2

    move-object v5, v0

    invoke-virtual/range {v1 .. v6}, Lorg/xerial/snappy/SnappyNative;->rawUncompress(Ljava/lang/Object;IILjava/lang/Object;I)I

    .line 731
    return-object v0
.end method

.method public static uncompressLongArray([B)[J
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 744
    const/4 v0, 0x0

    array-length v1, p0

    invoke-static {p0, v0, v1}, Lorg/xerial/snappy/Snappy;->uncompressLongArray([BII)[J

    move-result-object p0

    return-object p0
.end method

.method public static uncompressLongArray([BII)[J
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 759
    invoke-static {p0, p1, p2}, Lorg/xerial/snappy/Snappy;->uncompressedLength([BII)I

    move-result v0

    .line 760
    div-int/lit8 v0, v0, 0x8

    new-array v0, v0, [J

    .line 761
    sget-object v1, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    const/4 v6, 0x0

    move-object v2, p0

    move v3, p1

    move v4, p2

    move-object v5, v0

    invoke-virtual/range {v1 .. v6}, Lorg/xerial/snappy/SnappyNative;->rawUncompress(Ljava/lang/Object;IILjava/lang/Object;I)I

    .line 762
    return-object v0
.end method

.method public static uncompressShortArray([B)[S
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 775
    const/4 v0, 0x0

    array-length v1, p0

    invoke-static {p0, v0, v1}, Lorg/xerial/snappy/Snappy;->uncompressShortArray([BII)[S

    move-result-object p0

    return-object p0
.end method

.method public static uncompressShortArray([BII)[S
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 790
    invoke-static {p0, p1, p2}, Lorg/xerial/snappy/Snappy;->uncompressedLength([BII)I

    move-result v0

    .line 791
    div-int/lit8 v0, v0, 0x2

    new-array v0, v0, [S

    .line 792
    sget-object v1, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    const/4 v6, 0x0

    move-object v2, p0

    move v3, p1

    move v4, p2

    move-object v5, v0

    invoke-virtual/range {v1 .. v6}, Lorg/xerial/snappy/SnappyNative;->rawUncompress(Ljava/lang/Object;IILjava/lang/Object;I)I

    .line 793
    return-object v0
.end method

.method public static uncompressString([B)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 807
    :try_start_0
    const-string v0, "UTF-8"

    invoke-static {p0, v0}, Lorg/xerial/snappy/Snappy;->uncompressString([BLjava/lang/String;)Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    .line 809
    :catch_0
    move-exception p0

    .line 810
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string v0, "UTF-8 decoder is not found"

    invoke-direct {p0, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static uncompressString([BII)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 827
    :try_start_0
    const-string v0, "UTF-8"

    invoke-static {p0, p1, p2, v0}, Lorg/xerial/snappy/Snappy;->uncompressString([BIILjava/lang/String;)Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    .line 829
    :catch_0
    move-exception p0

    .line 830
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "UTF-8 decoder is not found"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static uncompressString([BIILjava/lang/String;)Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .line 849
    invoke-static {p0, p1, p2}, Lorg/xerial/snappy/Snappy;->uncompressedLength([BII)I

    move-result v0

    new-array v0, v0, [B

    .line 850
    const/4 v1, 0x0

    invoke-static {p0, p1, p2, v0, v1}, Lorg/xerial/snappy/Snappy;->uncompress([BII[BI)I

    .line 851
    new-instance p0, Ljava/lang/String;

    invoke-direct {p0, v0, p3}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    return-object p0
.end method

.method public static uncompressString([BIILjava/nio/charset/Charset;)Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .line 869
    invoke-static {p0, p1, p2}, Lorg/xerial/snappy/Snappy;->uncompressedLength([BII)I

    move-result v0

    new-array v0, v0, [B

    .line 870
    const/4 v1, 0x0

    invoke-static {p0, p1, p2, v0, v1}, Lorg/xerial/snappy/Snappy;->uncompress([BII[BI)I

    .line 871
    new-instance p0, Ljava/lang/String;

    invoke-direct {p0, v0, p3}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    return-object p0
.end method

.method public static uncompressString([BLjava/lang/String;)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .line 887
    invoke-static {p0}, Lorg/xerial/snappy/Snappy;->uncompress([B)[B

    move-result-object p0

    .line 888
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p0, p1}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    return-object v0
.end method

.method public static uncompressString([BLjava/nio/charset/Charset;)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljava/io/UnsupportedEncodingException;
        }
    .end annotation

    .line 903
    invoke-static {p0}, Lorg/xerial/snappy/Snappy;->uncompress([B)[B

    move-result-object p0

    .line 904
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p0, p1}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    return-object v0
.end method

.method public static uncompressedLength(Ljava/nio/ByteBuffer;)I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 650
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->isDirect()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 654
    sget-object v0, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->position()I

    move-result v1

    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v2

    invoke-virtual {v0, p0, v1, v2}, Lorg/xerial/snappy/SnappyNative;->uncompressedLength(Ljava/nio/ByteBuffer;II)I

    move-result p0

    return p0

    .line 651
    :cond_0
    new-instance p0, Lorg/xerial/snappy/SnappyError;

    sget-object v0, Lorg/xerial/snappy/SnappyErrorCode;->NOT_A_DIRECT_BUFFER:Lorg/xerial/snappy/SnappyErrorCode;

    const-string v1, "input is not a direct buffer"

    invoke-direct {p0, v0, v1}, Lorg/xerial/snappy/SnappyError;-><init>(Lorg/xerial/snappy/SnappyErrorCode;Ljava/lang/String;)V

    throw p0
.end method

.method public static uncompressedLength([B)I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 613
    sget-object v0, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    const/4 v1, 0x0

    array-length v2, p0

    invoke-virtual {v0, p0, v1, v2}, Lorg/xerial/snappy/SnappyNative;->uncompressedLength(Ljava/lang/Object;II)I

    move-result p0

    return p0
.end method

.method public static uncompressedLength([BII)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 630
    if-eqz p0, :cond_0

    .line 634
    sget-object v0, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    invoke-virtual {v0, p0, p1, p2}, Lorg/xerial/snappy/SnappyNative;->uncompressedLength(Ljava/lang/Object;II)I

    move-result p0

    return p0

    .line 631
    :cond_0
    new-instance p0, Ljava/lang/NullPointerException;

    const-string p1, "input is null"

    invoke-direct {p0, p1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static uncompressedLength(JJ)J
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 669
    sget-object v0, Lorg/xerial/snappy/Snappy;->impl:Lorg/xerial/snappy/SnappyNative;

    invoke-virtual {v0, p0, p1, p2, p3}, Lorg/xerial/snappy/SnappyNative;->uncompressedLength(JJ)J

    move-result-wide p0

    return-wide p0
.end method
