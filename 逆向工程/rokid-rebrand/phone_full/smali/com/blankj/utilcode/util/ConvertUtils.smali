.class public final Lcom/blankj/utilcode/util/ConvertUtils;
.super Ljava/lang/Object;
.source "ConvertUtils.java"


# static fields
.field private static final BUFFER_SIZE:I = 0x2000

.field private static final HEX_DIGITS_LOWER:[C

.field private static final HEX_DIGITS_UPPER:[C


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 42
    const/16 v0, 0x10

    new-array v1, v0, [C

    fill-array-data v1, :array_0

    sput-object v1, Lcom/blankj/utilcode/util/ConvertUtils;->HEX_DIGITS_UPPER:[C

    .line 44
    new-array v0, v0, [C

    fill-array-data v0, :array_1

    sput-object v0, Lcom/blankj/utilcode/util/ConvertUtils;->HEX_DIGITS_LOWER:[C

    return-void

    nop

    :array_0
    .array-data 2
        0x30s
        0x31s
        0x32s
        0x33s
        0x34s
        0x35s
        0x36s
        0x37s
        0x38s
        0x39s
        0x41s
        0x42s
        0x43s
        0x44s
        0x45s
        0x46s
    .end array-data

    :array_1
    .array-data 2
        0x30s
        0x31s
        0x32s
        0x33s
        0x34s
        0x35s
        0x36s
        0x37s
        0x38s
        0x39s
        0x61s
        0x62s
        0x63s
        0x64s
        0x65s
        0x66s
    .end array-data
.end method

.method private constructor <init>()V
    .locals 2

    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 48
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string/jumbo v1, "u can\'t instantiate me..."

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static bitmap2Bytes(Landroid/graphics/Bitmap;)[B
    .locals 1
    .param p0, "bitmap"    # Landroid/graphics/Bitmap;

    .line 378
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->bitmap2Bytes(Landroid/graphics/Bitmap;)[B

    move-result-object v0

    return-object v0
.end method

.method public static bitmap2Bytes(Landroid/graphics/Bitmap;Landroid/graphics/Bitmap$CompressFormat;I)[B
    .locals 1
    .param p0, "bitmap"    # Landroid/graphics/Bitmap;
    .param p1, "format"    # Landroid/graphics/Bitmap$CompressFormat;
    .param p2, "quality"    # I

    .line 385
    invoke-static {p0, p1, p2}, Lcom/blankj/utilcode/util/UtilsBridge;->bitmap2Bytes(Landroid/graphics/Bitmap;Landroid/graphics/Bitmap$CompressFormat;I)[B

    move-result-object v0

    return-object v0
.end method

.method public static bitmap2Drawable(Landroid/graphics/Bitmap;)Landroid/graphics/drawable/Drawable;
    .locals 1
    .param p0, "bitmap"    # Landroid/graphics/Bitmap;

    .line 716
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->bitmap2Drawable(Landroid/graphics/Bitmap;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static bits2Bytes(Ljava/lang/String;)[B
    .locals 8
    .param p0, "bits"    # Ljava/lang/String;

    .line 95
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0x8

    rem-int/2addr v0, v1

    .line 96
    .local v0, "lenMod":I
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    div-int/2addr v2, v1

    .line 98
    .local v2, "byteLen":I
    if-eqz v0, :cond_1

    .line 99
    move v3, v0

    .local v3, "i":I
    :goto_0
    if-ge v3, v1, :cond_0

    .line 100
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "0"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 99
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 102
    .end local v3    # "i":I
    :cond_0
    add-int/lit8 v2, v2, 0x1

    .line 104
    :cond_1
    new-array v3, v2, [B

    .line 105
    .local v3, "bytes":[B
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_1
    if-ge v4, v2, :cond_3

    .line 106
    const/4 v5, 0x0

    .local v5, "j":I
    :goto_2
    if-ge v5, v1, :cond_2

    .line 107
    aget-byte v6, v3, v4

    shl-int/lit8 v6, v6, 0x1

    int-to-byte v6, v6

    aput-byte v6, v3, v4

    .line 108
    aget-byte v6, v3, v4

    mul-int/lit8 v7, v4, 0x8

    add-int/2addr v7, v5

    invoke-virtual {p0, v7}, Ljava/lang/String;->charAt(I)C

    move-result v7

    add-int/lit8 v7, v7, -0x30

    or-int/2addr v6, v7

    int-to-byte v6, v6

    aput-byte v6, v3, v4

    .line 106
    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    .line 105
    .end local v5    # "j":I
    :cond_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 111
    .end local v4    # "i":I
    :cond_3
    return-object v3
.end method

.method public static byte2FitMemorySize(J)Ljava/lang/String;
    .locals 1
    .param p0, "byteSize"    # J

    .line 456
    const/4 v0, 0x3

    invoke-static {p0, p1, v0}, Lcom/blankj/utilcode/util/ConvertUtils;->byte2FitMemorySize(JI)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static byte2FitMemorySize(JI)Ljava/lang/String;
    .locals 5
    .param p0, "byteSize"    # J
    .param p2, "precision"    # I

    .line 469
    if-ltz p2, :cond_4

    .line 472
    const-wide/16 v0, 0x0

    cmp-long v0, p0, v0

    if-ltz v0, :cond_3

    .line 474
    const-wide/16 v0, 0x400

    cmp-long v0, p0, v0

    const-string v1, "%."

    if-gez v0, :cond_0

    .line 475
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "fB"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    long-to-double v1, p0

    invoke-static {v1, v2}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 476
    :cond_0
    const-wide/32 v2, 0x100000

    cmp-long v0, p0, v2

    if-gez v0, :cond_1

    .line 477
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "fKB"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    long-to-double v1, p0

    const-wide/high16 v3, 0x4090000000000000L    # 1024.0

    div-double/2addr v1, v3

    invoke-static {v1, v2}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 478
    :cond_1
    const-wide/32 v2, 0x40000000

    cmp-long v0, p0, v2

    if-gez v0, :cond_2

    .line 479
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "fMB"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    long-to-double v1, p0

    const-wide/high16 v3, 0x4130000000000000L    # 1048576.0

    div-double/2addr v1, v3

    invoke-static {v1, v2}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 481
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "fGB"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    long-to-double v1, p0

    const-wide/high16 v3, 0x41d0000000000000L    # 1.073741824E9

    div-double/2addr v1, v3

    invoke-static {v1, v2}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 473
    :cond_3
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "byteSize shouldn\'t be less than zero!"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 470
    :cond_4
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "precision shouldn\'t be less than zero!"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static byte2MemorySize(JI)D
    .locals 4
    .param p0, "byteSize"    # J
    .param p2, "unit"    # I

    .line 443
    const-wide/16 v0, 0x0

    cmp-long v0, p0, v0

    if-gez v0, :cond_0

    const-wide/high16 v0, -0x4010000000000000L    # -1.0

    return-wide v0

    .line 444
    :cond_0
    long-to-double v0, p0

    int-to-double v2, p2

    div-double/2addr v0, v2

    return-wide v0
.end method

.method public static bytes2Bitmap([B)Landroid/graphics/Bitmap;
    .locals 1
    .param p0, "bytes"    # [B

    .line 371
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2Bitmap([B)Landroid/graphics/Bitmap;

    move-result-object v0

    return-object v0
.end method

.method public static bytes2Bits([B)Ljava/lang/String;
    .locals 6
    .param p0, "bytes"    # [B

    .line 78
    if-eqz p0, :cond_4

    array-length v0, p0

    if-nez v0, :cond_0

    goto :goto_3

    .line 79
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 80
    .local v0, "sb":Ljava/lang/StringBuilder;
    array-length v1, p0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_3

    aget-byte v3, p0, v2

    .line 81
    .local v3, "aByte":B
    const/4 v4, 0x7

    .local v4, "j":I
    :goto_1
    if-ltz v4, :cond_2

    .line 82
    shr-int v5, v3, v4

    and-int/lit8 v5, v5, 0x1

    if-nez v5, :cond_1

    const/16 v5, 0x30

    goto :goto_2

    :cond_1
    const/16 v5, 0x31

    :goto_2
    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 81
    add-int/lit8 v4, v4, -0x1

    goto :goto_1

    .line 80
    .end local v3    # "aByte":B
    .end local v4    # "j":I
    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 85
    :cond_3
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 78
    .end local v0    # "sb":Ljava/lang/StringBuilder;
    :cond_4
    :goto_3
    const-string v0, ""

    return-object v0
.end method

.method public static bytes2Chars([B)[C
    .locals 4
    .param p0, "bytes"    # [B

    .line 121
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 122
    :cond_0
    array-length v1, p0

    .line 123
    .local v1, "len":I
    if-gtz v1, :cond_1

    return-object v0

    .line 124
    :cond_1
    new-array v0, v1, [C

    .line 125
    .local v0, "chars":[C
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, v1, :cond_2

    .line 126
    aget-byte v3, p0, v2

    and-int/lit16 v3, v3, 0xff

    int-to-char v3, v3

    aput-char v3, v0, v2

    .line 125
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 128
    .end local v2    # "i":I
    :cond_2
    return-object v0
.end method

.method public static bytes2Drawable([B)Landroid/graphics/drawable/Drawable;
    .locals 1
    .param p0, "bytes"    # [B

    .line 392
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->bytes2Drawable([B)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method public static bytes2HexString([B)Ljava/lang/String;
    .locals 1
    .param p0, "bytes"    # [B

    .line 155
    const/4 v0, 0x1

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/ConvertUtils;->bytes2HexString([BZ)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static bytes2HexString([BZ)Ljava/lang/String;
    .locals 7
    .param p0, "bytes"    # [B
    .param p1, "isUpperCase"    # Z

    .line 167
    const-string v0, ""

    if-nez p0, :cond_0

    return-object v0

    .line 168
    :cond_0
    if-eqz p1, :cond_1

    sget-object v1, Lcom/blankj/utilcode/util/ConvertUtils;->HEX_DIGITS_UPPER:[C

    goto :goto_0

    :cond_1
    sget-object v1, Lcom/blankj/utilcode/util/ConvertUtils;->HEX_DIGITS_LOWER:[C

    .line 169
    .local v1, "hexDigits":[C
    :goto_0
    array-length v2, p0

    .line 170
    .local v2, "len":I
    if-gtz v2, :cond_2

    return-object v0

    .line 171
    :cond_2
    shl-int/lit8 v0, v2, 0x1

    new-array v0, v0, [C

    .line 172
    .local v0, "ret":[C
    const/4 v3, 0x0

    .local v3, "i":I
    const/4 v4, 0x0

    .local v4, "j":I
    :goto_1
    if-ge v3, v2, :cond_3

    .line 173
    add-int/lit8 v5, v4, 0x1

    .end local v4    # "j":I
    .local v5, "j":I
    aget-byte v6, p0, v3

    shr-int/lit8 v6, v6, 0x4

    and-int/lit8 v6, v6, 0xf

    aget-char v6, v1, v6

    aput-char v6, v0, v4

    .line 174
    add-int/lit8 v4, v5, 0x1

    .end local v5    # "j":I
    .restart local v4    # "j":I
    aget-byte v6, p0, v3

    and-int/lit8 v6, v6, 0xf

    aget-char v6, v1, v6

    aput-char v6, v0, v5

    .line 172
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 176
    .end local v3    # "i":I
    .end local v4    # "j":I
    :cond_3
    new-instance v3, Ljava/lang/String;

    invoke-direct {v3, v0}, Ljava/lang/String;-><init>([C)V

    return-object v3
.end method

.method public static bytes2InputStream([B)Ljava/io/InputStream;
    .locals 1
    .param p0, "bytes"    # [B

    .line 586
    if-eqz p0, :cond_1

    array-length v0, p0

    if-gtz v0, :cond_0

    goto :goto_0

    .line 587
    :cond_0
    new-instance v0, Ljava/io/ByteArrayInputStream;

    invoke-direct {v0, p0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    return-object v0

    .line 586
    :cond_1
    :goto_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public static bytes2JSONArray([B)Lorg/json/JSONArray;
    .locals 3
    .param p0, "bytes"    # [B

    .line 276
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 278
    :cond_0
    :try_start_0
    new-instance v1, Lorg/json/JSONArray;

    new-instance v2, Ljava/lang/String;

    invoke-direct {v2, p0}, Ljava/lang/String;-><init>([B)V

    invoke-direct {v1, v2}, Lorg/json/JSONArray;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 279
    :catch_0
    move-exception v1

    .line 280
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 281
    return-object v0
.end method

.method public static bytes2JSONObject([B)Lorg/json/JSONObject;
    .locals 3
    .param p0, "bytes"    # [B

    .line 255
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 257
    :cond_0
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    new-instance v2, Ljava/lang/String;

    invoke-direct {v2, p0}, Ljava/lang/String;-><init>([B)V

    invoke-direct {v1, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 258
    :catch_0
    move-exception v1

    .line 259
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 260
    return-object v0
.end method

.method public static bytes2Object([B)Ljava/lang/Object;
    .locals 4
    .param p0, "bytes"    # [B

    .line 323
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 324
    :cond_0
    const/4 v1, 0x0

    .line 326
    .local v1, "ois":Ljava/io/ObjectInputStream;
    :try_start_0
    new-instance v2, Ljava/io/ObjectInputStream;

    new-instance v3, Ljava/io/ByteArrayInputStream;

    invoke-direct {v3, p0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-direct {v2, v3}, Ljava/io/ObjectInputStream;-><init>(Ljava/io/InputStream;)V

    move-object v1, v2

    .line 327
    invoke-virtual {v1}, Ljava/io/ObjectInputStream;->readObject()Ljava/lang/Object;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 333
    nop

    .line 334
    :try_start_1
    invoke-virtual {v1}, Ljava/io/ObjectInputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    .line 338
    goto :goto_0

    .line 336
    :catch_0
    move-exception v2

    .line 337
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    .line 327
    .end local v2    # "e":Ljava/io/IOException;
    :goto_0
    return-object v0

    .line 332
    :catchall_0
    move-exception v0

    goto :goto_3

    .line 328
    :catch_1
    move-exception v2

    .line 329
    .local v2, "e":Ljava/lang/Exception;
    :try_start_2
    invoke-virtual {v2}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 330
    nop

    .line 333
    if-eqz v1, :cond_1

    .line 334
    :try_start_3
    invoke-virtual {v1}, Ljava/io/ObjectInputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_1

    .line 336
    :catch_2
    move-exception v3

    .line 337
    .local v3, "e":Ljava/io/IOException;
    invoke-virtual {v3}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_2

    .line 338
    .end local v3    # "e":Ljava/io/IOException;
    :cond_1
    :goto_1
    nop

    .line 330
    :goto_2
    return-object v0

    .line 333
    .end local v2    # "e":Ljava/lang/Exception;
    :goto_3
    if-eqz v1, :cond_2

    .line 334
    :try_start_4
    invoke-virtual {v1}, Ljava/io/ObjectInputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3

    goto :goto_4

    .line 336
    :catch_3
    move-exception v2

    .line 337
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_5

    .line 338
    .end local v2    # "e":Ljava/io/IOException;
    :cond_2
    :goto_4
    nop

    .line 339
    :goto_5
    throw v0
.end method

.method public static bytes2OutputStream([B)Ljava/io/OutputStream;
    .locals 4
    .param p0, "bytes"    # [B

    .line 602
    const/4 v0, 0x0

    if-eqz p0, :cond_3

    array-length v1, p0

    if-gtz v1, :cond_0

    goto :goto_6

    .line 603
    :cond_0
    const/4 v1, 0x0

    .line 605
    .local v1, "os":Ljava/io/ByteArrayOutputStream;
    :try_start_0
    new-instance v2, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v2}, Ljava/io/ByteArrayOutputStream;-><init>()V

    move-object v1, v2

    .line 606
    invoke-virtual {v1, p0}, Ljava/io/ByteArrayOutputStream;->write([B)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 607
    nop

    .line 613
    nop

    .line 614
    :try_start_1
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    .line 618
    goto :goto_0

    .line 616
    :catch_0
    move-exception v0

    .line 617
    .local v0, "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 607
    .end local v0    # "e":Ljava/io/IOException;
    :goto_0
    return-object v1

    .line 612
    :catchall_0
    move-exception v0

    goto :goto_3

    .line 608
    :catch_1
    move-exception v2

    .line 609
    .local v2, "e":Ljava/io/IOException;
    :try_start_2
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 610
    nop

    .line 613
    if-eqz v1, :cond_1

    .line 614
    :try_start_3
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_1

    .line 616
    :catch_2
    move-exception v3

    .line 617
    .local v3, "e":Ljava/io/IOException;
    invoke-virtual {v3}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_2

    .line 618
    .end local v3    # "e":Ljava/io/IOException;
    :cond_1
    :goto_1
    nop

    .line 610
    :goto_2
    return-object v0

    .line 613
    .end local v2    # "e":Ljava/io/IOException;
    :goto_3
    if-eqz v1, :cond_2

    .line 614
    :try_start_4
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3

    goto :goto_4

    .line 616
    :catch_3
    move-exception v2

    .line 617
    .restart local v2    # "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_5

    .line 618
    .end local v2    # "e":Ljava/io/IOException;
    :cond_2
    :goto_4
    nop

    .line 619
    :goto_5
    throw v0

    .line 602
    .end local v1    # "os":Ljava/io/ByteArrayOutputStream;
    :cond_3
    :goto_6
    return-object v0
.end method

.method public static bytes2Parcelable([BLandroid/os/Parcelable$Creator;)Ljava/lang/Object;
    .locals 3
    .param p0, "bytes"    # [B
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">([B",
            "Landroid/os/Parcelable$Creator<",
            "TT;>;)TT;"
        }
    .end annotation

    .line 298
    .local p1, "creator":Landroid/os/Parcelable$Creator;, "Landroid/os/Parcelable$Creator<TT;>;"
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 299
    :cond_0
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v0

    .line 300
    .local v0, "parcel":Landroid/os/Parcel;
    array-length v1, p0

    const/4 v2, 0x0

    invoke-virtual {v0, p0, v2, v1}, Landroid/os/Parcel;->unmarshall([BII)V

    .line 301
    invoke-virtual {v0, v2}, Landroid/os/Parcel;->setDataPosition(I)V

    .line 302
    invoke-interface {p1, v0}, Landroid/os/Parcelable$Creator;->createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;

    move-result-object v1

    .line 303
    .local v1, "result":Ljava/lang/Object;, "TT;"
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V

    .line 304
    return-object v1
.end method

.method public static bytes2String([B)Ljava/lang/String;
    .locals 1
    .param p0, "bytes"    # [B

    .line 215
    const-string v0, ""

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/ConvertUtils;->bytes2String([BLjava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static bytes2String([BLjava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "bytes"    # [B
    .param p1, "charsetName"    # Ljava/lang/String;

    .line 222
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 224
    :cond_0
    :try_start_0
    new-instance v0, Ljava/lang/String;

    invoke-static {p1}, Lcom/blankj/utilcode/util/ConvertUtils;->getSafeCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, p0, v1}, Ljava/lang/String;-><init>([BLjava/lang/String;)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 225
    :catch_0
    move-exception v0

    .line 226
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    invoke-virtual {v0}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    .line 227
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, p0}, Ljava/lang/String;-><init>([B)V

    return-object v1
.end method

.method public static chars2Bytes([C)[B
    .locals 4
    .param p0, "chars"    # [C

    .line 138
    if-eqz p0, :cond_2

    array-length v0, p0

    if-gtz v0, :cond_0

    goto :goto_1

    .line 139
    :cond_0
    array-length v0, p0

    .line 140
    .local v0, "len":I
    new-array v1, v0, [B

    .line 141
    .local v1, "bytes":[B
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, v0, :cond_1

    .line 142
    aget-char v3, p0, v2

    int-to-byte v3, v3

    aput-byte v3, v1, v2

    .line 141
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 144
    .end local v2    # "i":I
    :cond_1
    return-object v1

    .line 138
    .end local v0    # "len":I
    .end local v1    # "bytes":[B
    :cond_2
    :goto_1
    const/4 v0, 0x0

    return-object v0
.end method

.method public static dp2px(F)I
    .locals 1
    .param p0, "dpValue"    # F

    .line 730
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->dp2px(F)I

    move-result v0

    return v0
.end method

.method public static drawable2Bitmap(Landroid/graphics/drawable/Drawable;)Landroid/graphics/Bitmap;
    .locals 1
    .param p0, "drawable"    # Landroid/graphics/drawable/Drawable;

    .line 709
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->drawable2Bitmap(Landroid/graphics/drawable/Drawable;)Landroid/graphics/Bitmap;

    move-result-object v0

    return-object v0
.end method

.method public static drawable2Bytes(Landroid/graphics/drawable/Drawable;)[B
    .locals 1
    .param p0, "drawable"    # Landroid/graphics/drawable/Drawable;

    .line 399
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->drawable2Bytes(Landroid/graphics/drawable/Drawable;)[B

    move-result-object v0

    return-object v0
.end method

.method public static drawable2Bytes(Landroid/graphics/drawable/Drawable;Landroid/graphics/Bitmap$CompressFormat;I)[B
    .locals 1
    .param p0, "drawable"    # Landroid/graphics/drawable/Drawable;
    .param p1, "format"    # Landroid/graphics/Bitmap$CompressFormat;
    .param p2, "quality"    # I

    .line 406
    invoke-static {p0, p1, p2}, Lcom/blankj/utilcode/util/UtilsBridge;->drawable2Bytes(Landroid/graphics/drawable/Drawable;Landroid/graphics/Bitmap$CompressFormat;I)[B

    move-result-object v0

    return-object v0
.end method

.method private static getSafeCharset(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "charsetName"    # Ljava/lang/String;

    .line 755
    move-object v0, p0

    .line 756
    .local v0, "cn":Ljava/lang/String;
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->isSpace(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-static {p0}, Ljava/nio/charset/Charset;->isSupported(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 757
    :cond_0
    const-string v0, "UTF-8"

    .line 759
    :cond_1
    return-object v0
.end method

.method private static hex2Dec(C)I
    .locals 1
    .param p0, "hexChar"    # C

    .line 202
    const/16 v0, 0x30

    if-lt p0, v0, :cond_0

    const/16 v0, 0x39

    if-gt p0, v0, :cond_0

    .line 203
    add-int/lit8 v0, p0, -0x30

    return v0

    .line 204
    :cond_0
    const/16 v0, 0x41

    if-lt p0, v0, :cond_1

    const/16 v0, 0x46

    if-gt p0, v0, :cond_1

    .line 205
    add-int/lit8 v0, p0, -0x41

    add-int/lit8 v0, v0, 0xa

    return v0

    .line 207
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw v0
.end method

.method public static hexString2Bytes(Ljava/lang/String;)[B
    .locals 7
    .param p0, "hexString"    # Ljava/lang/String;

    .line 187
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->isSpace(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    new-array v0, v0, [B

    return-object v0

    .line 188
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 189
    .local v0, "len":I
    rem-int/lit8 v1, v0, 0x2

    if-eqz v1, :cond_1

    .line 190
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "0"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 191
    add-int/lit8 v0, v0, 0x1

    .line 193
    :cond_1
    invoke-virtual {p0}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    .line 194
    .local v1, "hexBytes":[C
    shr-int/lit8 v2, v0, 0x1

    new-array v2, v2, [B

    .line 195
    .local v2, "ret":[B
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    if-ge v3, v0, :cond_2

    .line 196
    shr-int/lit8 v4, v3, 0x1

    aget-char v5, v1, v3

    invoke-static {v5}, Lcom/blankj/utilcode/util/ConvertUtils;->hex2Dec(C)I

    move-result v5

    shl-int/lit8 v5, v5, 0x4

    add-int/lit8 v6, v3, 0x1

    aget-char v6, v1, v6

    invoke-static {v6}, Lcom/blankj/utilcode/util/ConvertUtils;->hex2Dec(C)I

    move-result v6

    or-int/2addr v5, v6

    int-to-byte v5, v5

    aput-byte v5, v2, v4

    .line 195
    add-int/lit8 v3, v3, 0x2

    goto :goto_0

    .line 198
    .end local v3    # "i":I
    :cond_2
    return-object v2
.end method

.method public static hexString2Int(Ljava/lang/String;)I
    .locals 1
    .param p0, "hexString"    # Ljava/lang/String;

    .line 68
    const/16 v0, 0x10

    invoke-static {p0, v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method public static input2OutputStream(Ljava/io/InputStream;)Ljava/io/ByteArrayOutputStream;
    .locals 8
    .param p0, "is"    # Ljava/io/InputStream;

    .line 545
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 547
    :cond_0
    :try_start_0
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 548
    .local v1, "os":Ljava/io/ByteArrayOutputStream;
    const/16 v2, 0x2000

    new-array v3, v2, [B

    .line 550
    .local v3, "b":[B
    :goto_0
    const/4 v4, 0x0

    invoke-virtual {p0, v3, v4, v2}, Ljava/io/InputStream;->read([BII)I

    move-result v5

    move v6, v5

    .local v6, "len":I
    const/4 v7, -0x1

    if-eq v5, v7, :cond_1

    .line 551
    invoke-virtual {v1, v3, v4, v6}, Ljava/io/ByteArrayOutputStream;->write([BII)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 553
    :cond_1
    nop

    .line 559
    :try_start_1
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    .line 562
    goto :goto_1

    .line 560
    :catch_0
    move-exception v0

    .line 561
    .local v0, "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 553
    .end local v0    # "e":Ljava/io/IOException;
    :goto_1
    return-object v1

    .line 558
    .end local v1    # "os":Ljava/io/ByteArrayOutputStream;
    .end local v3    # "b":[B
    .end local v6    # "len":I
    :catchall_0
    move-exception v0

    goto :goto_3

    .line 554
    :catch_1
    move-exception v1

    .line 555
    .local v1, "e":Ljava/io/IOException;
    :try_start_2
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 556
    nop

    .line 559
    :try_start_3
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2

    .line 562
    goto :goto_2

    .line 560
    :catch_2
    move-exception v2

    .line 561
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    .line 556
    .end local v2    # "e":Ljava/io/IOException;
    :goto_2
    return-object v0

    .line 559
    .end local v1    # "e":Ljava/io/IOException;
    :goto_3
    :try_start_4
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3

    .line 562
    goto :goto_4

    .line 560
    :catch_3
    move-exception v1

    .line 561
    .restart local v1    # "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    .line 563
    .end local v1    # "e":Ljava/io/IOException;
    :goto_4
    throw v0
.end method

.method public static inputStream2Bytes(Ljava/io/InputStream;)[B
    .locals 1
    .param p0, "is"    # Ljava/io/InputStream;

    .line 578
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 579
    :cond_0
    invoke-static {p0}, Lcom/blankj/utilcode/util/ConvertUtils;->input2OutputStream(Ljava/io/InputStream;)Ljava/io/ByteArrayOutputStream;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    return-object v0
.end method

.method public static inputStream2Lines(Ljava/io/InputStream;)Ljava/util/List;
    .locals 1
    .param p0, "is"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/InputStream;",
            ")",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 677
    const-string v0, ""

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/ConvertUtils;->inputStream2Lines(Ljava/io/InputStream;Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public static inputStream2Lines(Ljava/io/InputStream;Ljava/lang/String;)Ljava/util/List;
    .locals 5
    .param p0, "is"    # Ljava/io/InputStream;
    .param p1, "charsetName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/InputStream;",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 682
    const/4 v0, 0x0

    .line 684
    .local v0, "reader":Ljava/io/BufferedReader;
    :try_start_0
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 685
    .local v1, "list":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    new-instance v2, Ljava/io/BufferedReader;

    new-instance v3, Ljava/io/InputStreamReader;

    invoke-static {p1}, Lcom/blankj/utilcode/util/ConvertUtils;->getSafeCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, p0, v4}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    invoke-direct {v2, v3}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    move-object v0, v2

    .line 687
    :goto_0
    invoke-virtual {v0}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v2

    move-object v3, v2

    .local v3, "line":Ljava/lang/String;
    if-eqz v2, :cond_0

    .line 688
    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 690
    :cond_0
    nop

    .line 696
    nop

    .line 697
    :try_start_1
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    .line 701
    goto :goto_1

    .line 699
    :catch_0
    move-exception v2

    .line 700
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    .line 690
    .end local v2    # "e":Ljava/io/IOException;
    :goto_1
    return-object v1

    .line 695
    .end local v1    # "list":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    .end local v3    # "line":Ljava/lang/String;
    :catchall_0
    move-exception v1

    goto :goto_4

    .line 691
    :catch_1
    move-exception v1

    .line 692
    .local v1, "e":Ljava/io/IOException;
    :try_start_2
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 693
    nop

    .line 696
    if-eqz v0, :cond_1

    .line 697
    :try_start_3
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_2

    .line 699
    :catch_2
    move-exception v2

    .line 700
    .restart local v2    # "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_3

    .line 701
    .end local v2    # "e":Ljava/io/IOException;
    :cond_1
    :goto_2
    nop

    .line 693
    :goto_3
    const/4 v2, 0x0

    return-object v2

    .line 696
    .end local v1    # "e":Ljava/io/IOException;
    :goto_4
    if-eqz v0, :cond_2

    .line 697
    :try_start_4
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3

    goto :goto_5

    .line 699
    :catch_3
    move-exception v2

    .line 700
    .restart local v2    # "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_6

    .line 701
    .end local v2    # "e":Ljava/io/IOException;
    :cond_2
    :goto_5
    nop

    .line 702
    :goto_6
    throw v1
.end method

.method public static inputStream2String(Ljava/io/InputStream;Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p0, "is"    # Ljava/io/InputStream;
    .param p1, "charsetName"    # Ljava/lang/String;

    .line 626
    const-string v0, ""

    if-nez p0, :cond_0

    return-object v0

    .line 628
    :cond_0
    :try_start_0
    invoke-static {p0}, Lcom/blankj/utilcode/util/ConvertUtils;->input2OutputStream(Ljava/io/InputStream;)Ljava/io/ByteArrayOutputStream;

    move-result-object v1

    .line 629
    .local v1, "baos":Ljava/io/ByteArrayOutputStream;
    if-nez v1, :cond_1

    return-object v0

    .line 630
    :cond_1
    invoke-static {p1}, Lcom/blankj/utilcode/util/ConvertUtils;->getSafeCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/ByteArrayOutputStream;->toString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 631
    .end local v1    # "baos":Ljava/io/ByteArrayOutputStream;
    :catch_0
    move-exception v1

    .line 632
    .local v1, "e":Ljava/io/UnsupportedEncodingException;
    invoke-virtual {v1}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    .line 633
    return-object v0
.end method

.method public static int2HexString(I)Ljava/lang/String;
    .locals 1
    .param p0, "num"    # I

    .line 58
    invoke-static {p0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static jsonArray2Bytes(Lorg/json/JSONArray;)[B
    .locals 1
    .param p0, "jsonArray"    # Lorg/json/JSONArray;

    .line 289
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 290
    :cond_0
    invoke-virtual {p0}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    return-object v0
.end method

.method public static jsonObject2Bytes(Lorg/json/JSONObject;)[B
    .locals 1
    .param p0, "jsonObject"    # Lorg/json/JSONObject;

    .line 268
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 269
    :cond_0
    invoke-virtual {p0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    return-object v0
.end method

.method public static memorySize2Byte(JI)J
    .locals 2
    .param p0, "memorySize"    # J
    .param p2, "unit"    # I

    .line 424
    const-wide/16 v0, 0x0

    cmp-long v0, p0, v0

    if-gez v0, :cond_0

    const-wide/16 v0, -0x1

    return-wide v0

    .line 425
    :cond_0
    int-to-long v0, p2

    mul-long/2addr v0, p0

    return-wide v0
.end method

.method public static millis2FitTimeSpan(JI)Ljava/lang/String;
    .locals 1
    .param p0, "millis"    # J
    .param p2, "precision"    # I

    .line 538
    invoke-static {p0, p1, p2}, Lcom/blankj/utilcode/util/UtilsBridge;->millis2FitTimeSpan(JI)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static millis2TimeSpan(JI)J
    .locals 2
    .param p0, "millis"    # J
    .param p2, "unit"    # I

    .line 518
    int-to-long v0, p2

    div-long v0, p0, v0

    return-wide v0
.end method

.method public static output2InputStream(Ljava/io/OutputStream;)Ljava/io/ByteArrayInputStream;
    .locals 2
    .param p0, "out"    # Ljava/io/OutputStream;

    .line 570
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 571
    :cond_0
    new-instance v0, Ljava/io/ByteArrayInputStream;

    move-object v1, p0

    check-cast v1, Ljava/io/ByteArrayOutputStream;

    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    return-object v0
.end method

.method public static outputStream2Bytes(Ljava/io/OutputStream;)[B
    .locals 1
    .param p0, "out"    # Ljava/io/OutputStream;

    .line 594
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 595
    :cond_0
    move-object v0, p0

    check-cast v0, Ljava/io/ByteArrayOutputStream;

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    return-object v0
.end method

.method public static outputStream2String(Ljava/io/OutputStream;Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p0, "out"    # Ljava/io/OutputStream;
    .param p1, "charsetName"    # Ljava/lang/String;

    .line 654
    const-string v0, ""

    if-nez p0, :cond_0

    return-object v0

    .line 656
    :cond_0
    :try_start_0
    new-instance v1, Ljava/lang/String;

    invoke-static {p0}, Lcom/blankj/utilcode/util/ConvertUtils;->outputStream2Bytes(Ljava/io/OutputStream;)[B

    move-result-object v2

    invoke-static {p1}, Lcom/blankj/utilcode/util/ConvertUtils;->getSafeCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v2, v3}, Ljava/lang/String;-><init>([BLjava/lang/String;)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 657
    :catch_0
    move-exception v1

    .line 658
    .local v1, "e":Ljava/io/UnsupportedEncodingException;
    invoke-virtual {v1}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    .line 659
    return-object v0
.end method

.method public static parcelable2Bytes(Landroid/os/Parcelable;)[B
    .locals 2
    .param p0, "parcelable"    # Landroid/os/Parcelable;

    .line 311
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 312
    :cond_0
    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v0

    .line 313
    .local v0, "parcel":Landroid/os/Parcel;
    const/4 v1, 0x0

    invoke-interface {p0, v0, v1}, Landroid/os/Parcelable;->writeToParcel(Landroid/os/Parcel;I)V

    .line 314
    invoke-virtual {v0}, Landroid/os/Parcel;->marshall()[B

    move-result-object v1

    .line 315
    .local v1, "bytes":[B
    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V

    .line 316
    return-object v1
.end method

.method public static px2dp(F)I
    .locals 1
    .param p0, "pxValue"    # F

    .line 737
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->px2dp(F)I

    move-result v0

    return v0
.end method

.method public static px2sp(F)I
    .locals 1
    .param p0, "pxValue"    # F

    .line 751
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->px2sp(F)I

    move-result v0

    return v0
.end method

.method public static serializable2Bytes(Ljava/io/Serializable;)[B
    .locals 5
    .param p0, "serializable"    # Ljava/io/Serializable;

    .line 346
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 348
    :cond_0
    const/4 v1, 0x0

    .line 350
    .local v1, "oos":Ljava/io/ObjectOutputStream;
    :try_start_0
    new-instance v2, Ljava/io/ObjectOutputStream;

    new-instance v3, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v3}, Ljava/io/ByteArrayOutputStream;-><init>()V

    move-object v4, v3

    .local v4, "baos":Ljava/io/ByteArrayOutputStream;
    invoke-direct {v2, v3}, Ljava/io/ObjectOutputStream;-><init>(Ljava/io/OutputStream;)V

    move-object v1, v2

    .line 351
    invoke-virtual {v1, p0}, Ljava/io/ObjectOutputStream;->writeObject(Ljava/lang/Object;)V

    .line 352
    invoke-virtual {v4}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 358
    nop

    .line 359
    :try_start_1
    invoke-virtual {v1}, Ljava/io/ObjectOutputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    .line 363
    goto :goto_0

    .line 361
    :catch_0
    move-exception v2

    .line 362
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    .line 352
    .end local v2    # "e":Ljava/io/IOException;
    :goto_0
    return-object v0

    .line 357
    .end local v4    # "baos":Ljava/io/ByteArrayOutputStream;
    :catchall_0
    move-exception v0

    goto :goto_3

    .line 353
    :catch_1
    move-exception v2

    .line 354
    .local v2, "e":Ljava/lang/Exception;
    :try_start_2
    invoke-virtual {v2}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 355
    nop

    .line 358
    if-eqz v1, :cond_1

    .line 359
    :try_start_3
    invoke-virtual {v1}, Ljava/io/ObjectOutputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_1

    .line 361
    :catch_2
    move-exception v3

    .line 362
    .local v3, "e":Ljava/io/IOException;
    invoke-virtual {v3}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_2

    .line 363
    .end local v3    # "e":Ljava/io/IOException;
    :cond_1
    :goto_1
    nop

    .line 355
    :goto_2
    return-object v0

    .line 358
    .end local v2    # "e":Ljava/lang/Exception;
    :goto_3
    if-eqz v1, :cond_2

    .line 359
    :try_start_4
    invoke-virtual {v1}, Ljava/io/ObjectOutputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3

    goto :goto_4

    .line 361
    :catch_3
    move-exception v2

    .line 362
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_5

    .line 363
    .end local v2    # "e":Ljava/io/IOException;
    :cond_2
    :goto_4
    nop

    .line 364
    :goto_5
    throw v0
.end method

.method public static sp2px(F)I
    .locals 1
    .param p0, "spValue"    # F

    .line 744
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->sp2px(F)I

    move-result v0

    return v0
.end method

.method public static string2Bytes(Ljava/lang/String;)[B
    .locals 1
    .param p0, "string"    # Ljava/lang/String;

    .line 235
    const-string v0, ""

    invoke-static {p0, v0}, Lcom/blankj/utilcode/util/ConvertUtils;->string2Bytes(Ljava/lang/String;Ljava/lang/String;)[B

    move-result-object v0

    return-object v0
.end method

.method public static string2Bytes(Ljava/lang/String;Ljava/lang/String;)[B
    .locals 2
    .param p0, "string"    # Ljava/lang/String;
    .param p1, "charsetName"    # Ljava/lang/String;

    .line 242
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 244
    :cond_0
    :try_start_0
    invoke-static {p1}, Lcom/blankj/utilcode/util/ConvertUtils;->getSafeCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 245
    :catch_0
    move-exception v0

    .line 246
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    invoke-virtual {v0}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    .line 247
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    return-object v1
.end method

.method public static string2InputStream(Ljava/lang/String;Ljava/lang/String;)Ljava/io/InputStream;
    .locals 3
    .param p0, "string"    # Ljava/lang/String;
    .param p1, "charsetName"    # Ljava/lang/String;

    .line 641
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 643
    :cond_0
    :try_start_0
    new-instance v1, Ljava/io/ByteArrayInputStream;

    invoke-static {p1}, Lcom/blankj/utilcode/util/ConvertUtils;->getSafeCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/ByteArrayInputStream;-><init>([B)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 644
    :catch_0
    move-exception v1

    .line 645
    .local v1, "e":Ljava/io/UnsupportedEncodingException;
    invoke-virtual {v1}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    .line 646
    return-object v0
.end method

.method public static string2OutputStream(Ljava/lang/String;Ljava/lang/String;)Ljava/io/OutputStream;
    .locals 2
    .param p0, "string"    # Ljava/lang/String;
    .param p1, "charsetName"    # Ljava/lang/String;

    .line 667
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 669
    :cond_0
    :try_start_0
    invoke-static {p1}, Lcom/blankj/utilcode/util/ConvertUtils;->getSafeCharset(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v1

    invoke-static {v1}, Lcom/blankj/utilcode/util/ConvertUtils;->bytes2OutputStream([B)Ljava/io/OutputStream;

    move-result-object v0
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 670
    :catch_0
    move-exception v1

    .line 671
    .local v1, "e":Ljava/io/UnsupportedEncodingException;
    invoke-virtual {v1}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    .line 672
    return-object v0
.end method

.method public static timeSpan2Millis(JI)J
    .locals 2
    .param p0, "timeSpan"    # J
    .param p2, "unit"    # I

    .line 500
    int-to-long v0, p2

    mul-long/2addr v0, p0

    return-wide v0
.end method

.method public static view2Bitmap(Landroid/view/View;)Landroid/graphics/Bitmap;
    .locals 1
    .param p0, "view"    # Landroid/view/View;

    .line 723
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->view2Bitmap(Landroid/view/View;)Landroid/graphics/Bitmap;

    move-result-object v0

    return-object v0
.end method
