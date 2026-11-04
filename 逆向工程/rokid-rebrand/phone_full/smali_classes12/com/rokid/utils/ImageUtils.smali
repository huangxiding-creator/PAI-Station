.class public final Lcom/rokid/utils/ImageUtils;
.super Ljava/lang/Object;
.source "ImageUtils.java"


# static fields
.field private static final IN_SAMPLE_SIZE:I = 0xa

.field private static final PREFER_HEIGHT:F = 128.0f

.field private static final PREFER_WIDTH:F = 72.0f


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static Bitmap2Bytes(Landroid/graphics/Bitmap;)[B
    .locals 4
    .param p0, "bm"    # Landroid/graphics/Bitmap;

    .line 37
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 39
    :cond_0
    invoke-static {p0}, Lcom/rokid/utils/ImageUtils;->compressScale(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 40
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 41
    .local v1, "baos":Ljava/io/ByteArrayOutputStream;
    sget-object v2, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v3, 0x32

    invoke-virtual {v0, v2, v3, v1}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 43
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v2

    .line 45
    .local v2, "bytes":[B
    :try_start_0
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 48
    goto :goto_0

    .line 46
    :catch_0
    move-exception v3

    .line 47
    .local v3, "e":Ljava/lang/Exception;
    invoke-virtual {v3}, Ljava/lang/Exception;->printStackTrace()V

    .line 49
    .end local v3    # "e":Ljava/lang/Exception;
    :goto_0
    return-object v2
.end method

.method public static Bytes2Bitmap([B)Landroid/graphics/Bitmap;
    .locals 3
    .param p0, "b"    # [B

    .line 53
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 54
    :cond_0
    array-length v1, p0

    if-eqz v1, :cond_1

    .line 57
    :try_start_0
    array-length v1, p0

    const/4 v2, 0x0

    invoke-static {p0, v2, v1}, Landroid/graphics/BitmapFactory;->decodeByteArray([BII)Landroid/graphics/Bitmap;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_0

    .line 60
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    nop

    .line 61
    return-object v0

    .line 58
    .end local v0    # "bitmap":Landroid/graphics/Bitmap;
    :catch_0
    move-exception v1

    .line 59
    .local v1, "e":Ljava/lang/OutOfMemoryError;
    return-object v0

    .line 63
    .end local v1    # "e":Ljava/lang/OutOfMemoryError;
    :cond_1
    return-object v0
.end method

.method public static base64ToBitmap(Ljava/lang/String;)Landroid/graphics/Bitmap;
    .locals 3
    .param p0, "base64"    # Ljava/lang/String;

    .line 488
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 489
    :cond_0
    invoke-static {p0}, Lcom/rokid/utils/ImageUtils;->base64ToByte(Ljava/lang/String;)[B

    move-result-object v0

    .line 490
    .local v0, "data":[B
    const/4 v1, 0x0

    array-length v2, v0

    invoke-static {v0, v1, v2}, Landroid/graphics/BitmapFactory;->decodeByteArray([BII)Landroid/graphics/Bitmap;

    move-result-object v1

    return-object v1
.end method

.method public static base64ToByte(Ljava/lang/String;)[B
    .locals 1
    .param p0, "data"    # Ljava/lang/String;

    .line 484
    const/4 v0, 0x2

    invoke-static {p0, v0}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object v0

    return-object v0
.end method

.method public static bitmap2Base64(Landroid/graphics/Bitmap;)Ljava/lang/String;
    .locals 4
    .param p0, "bitmap"    # Landroid/graphics/Bitmap;

    .line 31
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 32
    .local v0, "outputStream":Ljava/io/ByteArrayOutputStream;
    sget-object v1, Landroid/graphics/Bitmap$CompressFormat;->PNG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v2, 0x64

    invoke-virtual {p0, v1, v2, v0}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 33
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v1

    const/4 v2, 0x0

    invoke-static {v1, v2}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    const-string v2, "\n"

    const-string v3, ""

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "\r"

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public static bitmap2Bytes(Landroid/graphics/Bitmap;)[B
    .locals 3
    .param p0, "bm"    # Landroid/graphics/Bitmap;

    .line 100
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 101
    :cond_0
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 102
    .local v0, "baos":Ljava/io/ByteArrayOutputStream;
    sget-object v1, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v2, 0x50

    invoke-virtual {p0, v1, v2, v0}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 103
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v1

    return-object v1
.end method

.method public static byteToBase64([B)Ljava/lang/String;
    .locals 1
    .param p0, "data"    # [B

    .line 481
    const/4 v0, 0x2

    invoke-static {p0, v0}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private static compressImage(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;
    .locals 5
    .param p0, "image"    # Landroid/graphics/Bitmap;

    .line 73
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 74
    .local v0, "baos":Ljava/io/ByteArrayOutputStream;
    sget-object v1, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v2, 0x64

    invoke-virtual {p0, v1, v2, v0}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 75
    const/16 v1, 0x5a

    .line 76
    .local v1, "options":I
    :goto_0
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v3

    array-length v3, v3

    div-int/lit16 v3, v3, 0x400

    if-le v3, v2, :cond_0

    .line 77
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->reset()V

    .line 78
    sget-object v3, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    invoke-virtual {p0, v3, v1, v0}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 79
    add-int/lit8 v1, v1, -0xa

    goto :goto_0

    .line 81
    :cond_0
    new-instance v2, Ljava/io/ByteArrayInputStream;

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 82
    .local v2, "isBm":Ljava/io/ByteArrayInputStream;
    const/4 v3, 0x0

    invoke-static {v2, v3, v3}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;Landroid/graphics/Rect;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v3

    .line 84
    .local v3, "bitmap":Landroid/graphics/Bitmap;
    nop

    .line 85
    :try_start_0
    invoke-virtual {v2}, Ljava/io/ByteArrayInputStream;->close()V

    .line 87
    nop

    .line 88
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 92
    goto :goto_1

    .line 90
    :catch_0
    move-exception v4

    .line 91
    .local v4, "e":Ljava/lang/Exception;
    invoke-virtual {v4}, Ljava/lang/Exception;->printStackTrace()V

    .line 94
    .end local v4    # "e":Ljava/lang/Exception;
    :goto_1
    return-object v3
.end method

.method private static compressScale(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;
    .locals 12
    .param p0, "image"    # Landroid/graphics/Bitmap;

    .line 251
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 252
    .local v0, "baos":Ljava/io/ByteArrayOutputStream;
    sget-object v1, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v2, 0x64

    invoke-virtual {p0, v1, v2, v0}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 254
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v1

    array-length v1, v1

    const/16 v2, 0x400

    div-int/2addr v1, v2

    if-le v1, v2, :cond_0

    .line 255
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->reset()V

    .line 256
    sget-object v1, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v2, 0x50

    invoke-virtual {p0, v1, v2, v0}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 258
    :cond_0
    new-instance v1, Ljava/io/ByteArrayInputStream;

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 259
    .local v1, "isBm":Ljava/io/ByteArrayInputStream;
    new-instance v2, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v2}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 261
    .local v2, "newOpts":Landroid/graphics/BitmapFactory$Options;
    const/4 v3, 0x1

    iput-boolean v3, v2, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    .line 262
    const/4 v3, 0x0

    invoke-static {v1, v3, v2}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;Landroid/graphics/Rect;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v4

    .line 263
    .local v4, "bitmap":Landroid/graphics/Bitmap;
    const/4 v5, 0x0

    iput-boolean v5, v2, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    .line 264
    iget v5, v2, Landroid/graphics/BitmapFactory$Options;->outWidth:I

    .line 265
    .local v5, "w":I
    iget v6, v2, Landroid/graphics/BitmapFactory$Options;->outHeight:I

    .line 269
    .local v6, "h":I
    const/high16 v7, 0x43160000    # 150.0f

    .line 270
    .local v7, "hh":F
    const/high16 v8, 0x43160000    # 150.0f

    .line 272
    .local v8, "ww":F
    const/4 v9, 0x1

    .line 273
    .local v9, "be":I
    if-lt v5, v6, :cond_1

    int-to-float v10, v5

    cmpl-float v10, v10, v8

    if-lez v10, :cond_1

    .line 274
    iget v10, v2, Landroid/graphics/BitmapFactory$Options;->outWidth:I

    int-to-float v10, v10

    div-float/2addr v10, v8

    float-to-int v9, v10

    goto :goto_0

    .line 275
    :cond_1
    if-ge v5, v6, :cond_2

    int-to-float v10, v6

    cmpl-float v10, v10, v7

    if-lez v10, :cond_2

    .line 276
    iget v10, v2, Landroid/graphics/BitmapFactory$Options;->outHeight:I

    int-to-float v10, v10

    div-float/2addr v10, v7

    float-to-int v9, v10

    .line 278
    :cond_2
    :goto_0
    if-gtz v9, :cond_3

    .line 279
    const/4 v9, 0x1

    .line 280
    :cond_3
    iput v9, v2, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    .line 283
    new-instance v10, Ljava/io/ByteArrayInputStream;

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v11

    invoke-direct {v10, v11}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    move-object v1, v10

    .line 284
    invoke-static {v1, v3, v2}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;Landroid/graphics/Rect;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v3

    .line 285
    .end local v4    # "bitmap":Landroid/graphics/Bitmap;
    .local v3, "bitmap":Landroid/graphics/Bitmap;
    invoke-static {v3}, Lcom/rokid/utils/ImageUtils;->compressImage(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object v4

    return-object v4
.end method

.method public static getBitmapDegree(Ljava/lang/String;)I
    .locals 4
    .param p0, "path"    # Ljava/lang/String;

    .line 364
    const/4 v0, 0x0

    .line 367
    .local v0, "degree":I
    :try_start_0
    new-instance v1, Landroid/media/ExifInterface;

    invoke-direct {v1, p0}, Landroid/media/ExifInterface;-><init>(Ljava/lang/String;)V

    .line 369
    .local v1, "exifInterface":Landroid/media/ExifInterface;
    const-string v2, "Orientation"

    const/4 v3, 0x1

    invoke-virtual {v1, v2, v3}, Landroid/media/ExifInterface;->getAttributeInt(Ljava/lang/String;I)I

    move-result v2
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 371
    .local v2, "orientation":I
    sparse-switch v2, :sswitch_data_0

    goto :goto_0

    .line 379
    :sswitch_0
    const/16 v0, 0x10e

    goto :goto_0

    .line 373
    :sswitch_1
    const/16 v0, 0x5a

    .line 374
    goto :goto_0

    .line 376
    :sswitch_2
    const/16 v0, 0xb4

    .line 377
    nop

    .line 384
    .end local v1    # "exifInterface":Landroid/media/ExifInterface;
    .end local v2    # "orientation":I
    :goto_0
    goto :goto_1

    .line 382
    :catch_0
    move-exception v1

    .line 383
    .local v1, "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    .line 385
    .end local v1    # "e":Ljava/io/IOException;
    :goto_1
    return v0

    :sswitch_data_0
    .sparse-switch
        0x3 -> :sswitch_2
        0x6 -> :sswitch_1
        0x8 -> :sswitch_0
    .end sparse-switch
.end method

.method public static getBitmapFromFile(Ljava/lang/String;)Landroid/graphics/Bitmap;
    .locals 3
    .param p0, "path"    # Ljava/lang/String;

    .line 343
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 344
    .local v0, "file":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    const/4 v2, 0x0

    if-nez v1, :cond_0

    .line 345
    return-object v2

    .line 347
    :cond_0
    :try_start_0
    new-instance v1, Ljava/io/FileInputStream;

    invoke-direct {v1, v0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 348
    .local v1, "is":Ljava/io/InputStream;
    invoke-static {v1}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 349
    .local v2, "bitmap":Landroid/graphics/Bitmap;
    return-object v2

    .line 350
    .end local v1    # "is":Ljava/io/InputStream;
    .end local v2    # "bitmap":Landroid/graphics/Bitmap;
    :catch_0
    move-exception v1

    .line 351
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 353
    .end local v1    # "e":Ljava/lang/Exception;
    return-object v2
.end method

.method public static getPath(Landroid/net/Uri;Landroid/content/Context;)Ljava/lang/String;
    .locals 9
    .param p0, "uri"    # Landroid/net/Uri;
    .param p1, "context"    # Landroid/content/Context;

    .line 109
    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "_data"

    const/4 v2, 0x0

    aput-object v1, v0, v2

    .line 110
    .local v0, "filePathColumn":[Ljava/lang/String;
    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    .line 111
    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v4, p0

    move-object v5, v0

    invoke-virtual/range {v3 .. v8}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v1

    .line 112
    .local v1, "cursor":Landroid/database/Cursor;
    const/4 v3, 0x0

    .line 113
    .local v3, "path":Ljava/lang/String;
    if-eqz v1, :cond_0

    .line 114
    invoke-interface {v1}, Landroid/database/Cursor;->moveToFirst()Z

    .line 115
    aget-object v2, v0, v2

    invoke-interface {v1, v2}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v2

    .line 116
    .local v2, "columnIndex":I
    invoke-interface {v1, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v3

    .line 117
    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    .line 119
    .end local v2    # "columnIndex":I
    :cond_0
    return-object v3
.end method

.method public static getResizeRotateBitmap(Ljava/lang/String;)Landroid/graphics/Bitmap;
    .locals 8
    .param p0, "path"    # Ljava/lang/String;

    .line 156
    new-instance v0, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v0}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 157
    .local v0, "options":Landroid/graphics/BitmapFactory$Options;
    const/16 v1, 0xa

    iput v1, v0, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    .line 158
    invoke-static {p0}, Lcom/rokid/utils/ImageUtils;->getBitmapDegree(Ljava/lang/String;)I

    move-result v1

    .line 160
    .local v1, "rotation":I
    invoke-static {p0, v0}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v2

    .line 162
    .local v2, "bitmap":Landroid/graphics/Bitmap;
    invoke-virtual {v2}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v3

    .line 163
    .local v3, "width":I
    invoke-virtual {v2}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v4

    .line 165
    .local v4, "height":I
    const/16 v5, 0x5a

    if-eq v1, v5, :cond_0

    const/16 v5, 0x10e

    if-ne v1, v5, :cond_1

    .line 166
    :cond_0
    move v5, v3

    .line 167
    .local v5, "tmp":I
    move v3, v4

    .line 168
    move v4, v5

    .line 171
    .end local v5    # "tmp":I
    :cond_1
    invoke-virtual {v2}, Landroid/graphics/Bitmap;->recycle()V

    .line 173
    int-to-float v5, v3

    const/high16 v6, 0x42900000    # 72.0f

    cmpl-float v5, v5, v6

    const/high16 v7, 0x43000000    # 128.0f

    if-gtz v5, :cond_3

    int-to-float v5, v4

    cmpl-float v5, v5, v7

    if-lez v5, :cond_2

    goto :goto_0

    .line 180
    :cond_2
    invoke-static {p0}, Lcom/rokid/utils/ImageUtils;->getRotateBitmap(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v2

    goto :goto_1

    .line 174
    :cond_3
    :goto_0
    int-to-float v5, v3

    div-float/2addr v5, v6

    int-to-float v6, v4

    div-float/2addr v6, v7

    invoke-static {v5, v6}, Ljava/lang/Math;->max(FF)F

    move-result v5

    .line 175
    .local v5, "scale":F
    invoke-static {v5}, Ljava/lang/Math;->round(F)I

    move-result v6

    iput v6, v0, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    .line 176
    invoke-static {p0, v0}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v2

    .line 177
    const/4 v6, 0x0

    invoke-static {v2, v1, v6}, Lcom/rokid/utils/ImageUtils;->rotateBitmap(Landroid/graphics/Bitmap;IZ)Landroid/graphics/Bitmap;

    move-result-object v2

    .line 179
    .end local v5    # "scale":F
    nop

    .line 183
    :goto_1
    return-object v2
.end method

.method public static getRotateBitmap(Ljava/lang/String;)Landroid/graphics/Bitmap;
    .locals 10
    .param p0, "imagePath"    # Ljava/lang/String;

    .line 123
    invoke-static {p0}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v7

    .line 124
    .local v7, "photo":Landroid/graphics/Bitmap;
    const/4 v0, 0x0

    .line 126
    .local v0, "rotation":I
    :try_start_0
    new-instance v1, Landroid/media/ExifInterface;

    invoke-direct {v1, p0}, Landroid/media/ExifInterface;-><init>(Ljava/lang/String;)V

    .line 127
    .local v1, "exifInterface":Landroid/media/ExifInterface;
    const-string v2, "Orientation"

    const/4 v3, 0x1

    invoke-virtual {v1, v2, v3}, Landroid/media/ExifInterface;->getAttributeInt(Ljava/lang/String;I)I

    move-result v2
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 128
    .local v2, "orientation":I
    sparse-switch v2, :sswitch_data_0

    goto :goto_0

    .line 136
    :sswitch_0
    const/16 v0, 0x10e

    goto :goto_0

    .line 130
    :sswitch_1
    const/16 v0, 0x5a

    .line 131
    goto :goto_0

    .line 133
    :sswitch_2
    const/16 v0, 0xb4

    .line 134
    nop

    .line 141
    .end local v1    # "exifInterface":Landroid/media/ExifInterface;
    .end local v2    # "orientation":I
    :goto_0
    move v8, v0

    goto :goto_1

    .line 139
    :catch_0
    move-exception v1

    .line 140
    .local v1, "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    move v8, v0

    .line 142
    .end local v0    # "rotation":I
    .end local v1    # "e":Ljava/io/IOException;
    .local v8, "rotation":I
    :goto_1
    if-nez v8, :cond_0

    .line 143
    return-object v7

    .line 145
    :cond_0
    new-instance v0, Landroid/graphics/Matrix;

    invoke-direct {v0}, Landroid/graphics/Matrix;-><init>()V

    move-object v9, v0

    .line 146
    .local v9, "matrix":Landroid/graphics/Matrix;
    int-to-float v0, v8

    invoke-virtual {v9, v0}, Landroid/graphics/Matrix;->postRotate(F)Z

    .line 147
    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v3

    invoke-virtual {v7}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v4

    const/4 v6, 0x1

    const/4 v1, 0x0

    const/4 v2, 0x0

    move-object v0, v7

    move-object v5, v9

    invoke-static/range {v0 .. v6}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIIILandroid/graphics/Matrix;Z)Landroid/graphics/Bitmap;

    move-result-object v0

    return-object v0

    :sswitch_data_0
    .sparse-switch
        0x3 -> :sswitch_2
        0x6 -> :sswitch_1
        0x8 -> :sswitch_0
    .end sparse-switch
.end method

.method public static nv21ToBitmap([BIILandroid/graphics/Rect;)Landroid/graphics/Bitmap;
    .locals 8
    .param p0, "nv21"    # [B
    .param p1, "width"    # I
    .param p2, "height"    # I
    .param p3, "rect"    # Landroid/graphics/Rect;

    .line 391
    const/4 v0, 0x0

    .line 393
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    :try_start_0
    new-instance v7, Landroid/graphics/YuvImage;

    const/16 v3, 0x11

    const/4 v6, 0x0

    move-object v1, v7

    move-object v2, p0

    move v4, p1

    move v5, p2

    invoke-direct/range {v1 .. v6}, Landroid/graphics/YuvImage;-><init>([BIII[I)V

    move-object v1, v7

    .line 394
    .local v1, "image":Landroid/graphics/YuvImage;
    new-instance v2, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v2}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 395
    .local v2, "stream":Ljava/io/ByteArrayOutputStream;
    iget v3, p3, Landroid/graphics/Rect;->left:I

    const/4 v4, 0x0

    if-gez v3, :cond_0

    .line 396
    iput v4, p3, Landroid/graphics/Rect;->left:I

    .line 398
    :cond_0
    iget v3, p3, Landroid/graphics/Rect;->right:I

    if-le v3, p1, :cond_1

    .line 399
    iput p1, p3, Landroid/graphics/Rect;->right:I

    .line 401
    :cond_1
    iget v3, p3, Landroid/graphics/Rect;->top:I

    if-gez v3, :cond_2

    .line 402
    iput v4, p3, Landroid/graphics/Rect;->top:I

    .line 404
    :cond_2
    iget v3, p3, Landroid/graphics/Rect;->bottom:I

    if-le v3, p2, :cond_3

    .line 405
    iput p2, p3, Landroid/graphics/Rect;->bottom:I

    .line 408
    :cond_3
    const/16 v3, 0x64

    invoke-virtual {v1, p3, v3, v2}, Landroid/graphics/YuvImage;->compressToJpeg(Landroid/graphics/Rect;ILjava/io/OutputStream;)Z

    .line 409
    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v3

    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v5

    invoke-static {v3, v4, v5}, Landroid/graphics/BitmapFactory;->decodeByteArray([BII)Landroid/graphics/Bitmap;

    move-result-object v3

    move-object v0, v3

    .line 410
    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 413
    .end local v1    # "image":Landroid/graphics/YuvImage;
    .end local v2    # "stream":Ljava/io/ByteArrayOutputStream;
    goto :goto_0

    .line 411
    :catch_0
    move-exception v1

    .line 412
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 414
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return-object v0
.end method

.method public static nv21ToFile([BLjava/lang/String;IILandroid/graphics/Rect;)Ljava/lang/String;
    .locals 8
    .param p0, "nv21"    # [B
    .param p1, "path"    # Ljava/lang/String;
    .param p2, "width"    # I
    .param p3, "height"    # I
    .param p4, "rect"    # Landroid/graphics/Rect;

    .line 418
    const/4 v0, 0x0

    .line 420
    .local v0, "file":Ljava/io/File;
    :try_start_0
    new-instance v7, Landroid/graphics/YuvImage;

    const/16 v3, 0x11

    const/4 v6, 0x0

    move-object v1, v7

    move-object v2, p0

    move v4, p2

    move v5, p3

    invoke-direct/range {v1 .. v6}, Landroid/graphics/YuvImage;-><init>([BIII[I)V

    move-object v1, v7

    .line 421
    .local v1, "image":Landroid/graphics/YuvImage;
    new-instance v2, Ljava/io/FileOutputStream;

    new-instance v3, Ljava/io/File;

    invoke-direct {v3, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v2, v3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 422
    .local v2, "stream":Ljava/io/FileOutputStream;
    iget v3, p4, Landroid/graphics/Rect;->left:I

    const/4 v4, 0x0

    if-gez v3, :cond_0

    .line 423
    iput v4, p4, Landroid/graphics/Rect;->left:I

    .line 425
    :cond_0
    iget v3, p4, Landroid/graphics/Rect;->right:I

    if-le v3, p2, :cond_1

    .line 426
    iput p2, p4, Landroid/graphics/Rect;->right:I

    .line 428
    :cond_1
    iget v3, p4, Landroid/graphics/Rect;->top:I

    if-gez v3, :cond_2

    .line 429
    iput v4, p4, Landroid/graphics/Rect;->top:I

    .line 431
    :cond_2
    iget v3, p4, Landroid/graphics/Rect;->bottom:I

    if-le v3, p3, :cond_3

    .line 432
    iput p3, p4, Landroid/graphics/Rect;->bottom:I

    .line 435
    :cond_3
    const/16 v3, 0x64

    invoke-virtual {v1, p4, v3, v2}, Landroid/graphics/YuvImage;->compressToJpeg(Landroid/graphics/Rect;ILjava/io/OutputStream;)Z

    .line 437
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->flush()V

    .line 438
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 442
    .end local v1    # "image":Landroid/graphics/YuvImage;
    .end local v2    # "stream":Ljava/io/FileOutputStream;
    nop

    .line 443
    return-object p1

    .line 439
    :catch_0
    move-exception v1

    .line 440
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 441
    const/4 v2, 0x0

    return-object v2
.end method

.method public static nv21ToJpgString([BIILandroid/graphics/Rect;)Ljava/lang/String;
    .locals 8
    .param p0, "nv21"    # [B
    .param p1, "width"    # I
    .param p2, "height"    # I
    .param p3, "rect"    # Landroid/graphics/Rect;

    .line 449
    const/4 v0, 0x0

    .line 451
    .local v0, "bytes":[B
    :try_start_0
    new-instance v7, Landroid/graphics/YuvImage;

    const/16 v3, 0x11

    const/4 v6, 0x0

    move-object v1, v7

    move-object v2, p0

    move v4, p1

    move v5, p2

    invoke-direct/range {v1 .. v6}, Landroid/graphics/YuvImage;-><init>([BIII[I)V

    move-object v1, v7

    .line 452
    .local v1, "image":Landroid/graphics/YuvImage;
    new-instance v2, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v2}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 453
    .local v2, "baos":Ljava/io/ByteArrayOutputStream;
    iget v3, p3, Landroid/graphics/Rect;->left:I

    const/4 v4, 0x0

    if-gez v3, :cond_0

    .line 454
    iput v4, p3, Landroid/graphics/Rect;->left:I

    .line 456
    :cond_0
    iget v3, p3, Landroid/graphics/Rect;->right:I

    if-le v3, p1, :cond_1

    .line 457
    iput p1, p3, Landroid/graphics/Rect;->right:I

    .line 459
    :cond_1
    iget v3, p3, Landroid/graphics/Rect;->top:I

    if-gez v3, :cond_2

    .line 460
    iput v4, p3, Landroid/graphics/Rect;->top:I

    .line 462
    :cond_2
    iget v3, p3, Landroid/graphics/Rect;->bottom:I

    if-le v3, p2, :cond_3

    .line 463
    iput p2, p3, Landroid/graphics/Rect;->bottom:I

    .line 466
    :cond_3
    const/16 v3, 0x64

    invoke-virtual {v1, p3, v3, v2}, Landroid/graphics/YuvImage;->compressToJpeg(Landroid/graphics/Rect;ILjava/io/OutputStream;)Z

    .line 468
    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v3

    move-object v0, v3

    .line 470
    invoke-static {v0}, Lcom/rokid/utils/ImageUtils;->byteToBase64([B)Ljava/lang/String;

    move-result-object v3

    .line 472
    .local v3, "result":Ljava/lang/String;
    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 476
    .end local v1    # "image":Landroid/graphics/YuvImage;
    .end local v2    # "baos":Ljava/io/ByteArrayOutputStream;
    nop

    .line 477
    return-object v3

    .line 473
    .end local v3    # "result":Ljava/lang/String;
    :catch_0
    move-exception v1

    .line 474
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 475
    const/4 v2, 0x0

    return-object v2
.end method

.method public static resizeRotateBitmapFile(Ljava/io/File;)Ljava/io/File;
    .locals 9
    .param p0, "file"    # Ljava/io/File;

    .line 188
    const/4 v0, 0x0

    .line 190
    .local v0, "result":Ljava/io/File;
    :try_start_0
    const-string v1, ".tmp"

    const-string v2, ".jpeg"

    invoke-virtual {p0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v3

    invoke-static {v1, v2, v3}, Ljava/io/File;->createTempFile(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)Ljava/io/File;

    move-result-object v1

    move-object v0, v1

    .line 191
    invoke-virtual {v0}, Ljava/io/File;->deleteOnExit()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 195
    goto :goto_0

    .line 192
    :catch_0
    move-exception v1

    .line 193
    .local v1, "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    .line 194
    move-object v0, p0

    .line 196
    .end local v1    # "e":Ljava/io/IOException;
    :goto_0
    new-instance v1, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v1}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .line 197
    .local v1, "options":Landroid/graphics/BitmapFactory$Options;
    const/16 v2, 0xa

    iput v2, v1, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    .line 198
    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/rokid/utils/ImageUtils;->getBitmapDegree(Ljava/lang/String;)I

    move-result v2

    .line 200
    .local v2, "rotation":I
    const/4 v3, 0x0

    .line 202
    .local v3, "bitmap":Landroid/graphics/Bitmap;
    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v1}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v3

    .line 205
    if-nez v3, :cond_0

    .line 206
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    .line 207
    const/4 v4, 0x0

    return-object v4

    .line 210
    :cond_0
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v4

    .line 211
    .local v4, "width":I
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v5

    .line 213
    .local v5, "height":I
    const/16 v6, 0x5a

    if-eq v2, v6, :cond_1

    const/16 v6, 0x10e

    if-ne v2, v6, :cond_2

    .line 214
    :cond_1
    move v6, v4

    .line 215
    .local v6, "tmp":I
    move v4, v5

    .line 216
    move v5, v6

    .line 219
    .end local v6    # "tmp":I
    :cond_2
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    .line 221
    int-to-float v6, v4

    const/high16 v7, 0x42900000    # 72.0f

    cmpl-float v6, v6, v7

    const/high16 v8, 0x43000000    # 128.0f

    if-gtz v6, :cond_4

    int-to-float v6, v5

    cmpl-float v6, v6, v8

    if-lez v6, :cond_3

    goto :goto_1

    .line 228
    :cond_3
    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/rokid/utils/ImageUtils;->getRotateBitmap(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v3

    .line 229
    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    invoke-static {v3, v6}, Lcom/rokid/utils/ImageUtils;->saveBitmap2File(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    goto :goto_2

    .line 222
    :cond_4
    :goto_1
    int-to-float v6, v4

    div-float/2addr v6, v7

    int-to-float v7, v5

    div-float/2addr v7, v8

    invoke-static {v6, v7}, Ljava/lang/Math;->max(FF)F

    move-result v6

    .line 223
    .local v6, "scale":F
    invoke-static {v6}, Ljava/lang/Math;->round(F)I

    move-result v7

    iput v7, v1, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    .line 224
    invoke-virtual {p0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7, v1}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v3

    .line 225
    const/4 v7, 0x0

    invoke-static {v3, v2, v7}, Lcom/rokid/utils/ImageUtils;->rotateBitmap(Landroid/graphics/Bitmap;IZ)Landroid/graphics/Bitmap;

    move-result-object v3

    .line 226
    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    invoke-static {v3, v7}, Lcom/rokid/utils/ImageUtils;->saveBitmap2File(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    .line 227
    .end local v6    # "scale":F
    nop

    .line 232
    :goto_2
    if-eqz v3, :cond_5

    invoke-virtual {v3}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v6

    if-nez v6, :cond_5

    .line 233
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V

    .line 236
    :cond_5
    return-object v0
.end method

.method public static rotateBitmap(Landroid/graphics/Bitmap;IZ)Landroid/graphics/Bitmap;
    .locals 8
    .param p0, "bitmap"    # Landroid/graphics/Bitmap;
    .param p1, "rotation"    # I
    .param p2, "isMirror"    # Z

    .line 240
    if-eqz p0, :cond_2

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 242
    :cond_0
    new-instance v0, Landroid/graphics/Matrix;

    invoke-direct {v0}, Landroid/graphics/Matrix;-><init>()V

    .line 243
    .local v0, "matrix":Landroid/graphics/Matrix;
    int-to-float v1, p1

    invoke-virtual {v0, v1}, Landroid/graphics/Matrix;->postRotate(F)Z

    .line 244
    if-eqz p2, :cond_1

    .line 245
    const/high16 v1, -0x40800000    # -1.0f

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-virtual {v0, v1, v2}, Landroid/graphics/Matrix;->postScale(FF)Z

    .line 246
    :cond_1
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v4

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v5

    const/4 v7, 0x1

    const/4 v2, 0x0

    const/4 v3, 0x0

    move-object v1, p0

    move-object v6, v0

    invoke-static/range {v1 .. v7}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIIILandroid/graphics/Matrix;Z)Landroid/graphics/Bitmap;

    move-result-object v1

    return-object v1

    .line 240
    .end local v0    # "matrix":Landroid/graphics/Matrix;
    :cond_2
    :goto_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public static saveBitmap2File(Landroid/graphics/Bitmap;Ljava/lang/String;)V
    .locals 1
    .param p0, "bitmap"    # Landroid/graphics/Bitmap;
    .param p1, "path"    # Ljava/lang/String;

    .line 311
    const/16 v0, 0x64

    invoke-static {p0, p1, v0}, Lcom/rokid/utils/ImageUtils;->saveBitmap2File(Landroid/graphics/Bitmap;Ljava/lang/String;I)V

    .line 312
    return-void
.end method

.method public static saveBitmap2File(Landroid/graphics/Bitmap;Ljava/lang/String;I)V
    .locals 3
    .param p0, "bitmap"    # Landroid/graphics/Bitmap;
    .param p1, "path"    # Ljava/lang/String;
    .param p2, "quality"    # I

    .line 290
    if-eqz p0, :cond_3

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_5

    .line 291
    :cond_0
    const/4 v0, 0x0

    .line 294
    .local v0, "os":Ljava/io/OutputStream;
    :try_start_0
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 295
    .local v1, "tmpImgFile":Ljava/io/File;
    new-instance v2, Ljava/io/FileOutputStream;

    invoke-direct {v2, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    move-object v0, v2

    .line 296
    sget-object v2, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    invoke-virtual {p0, v2, p2, v0}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 297
    invoke-virtual {v0}, Ljava/io/OutputStream;->flush()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 302
    .end local v1    # "tmpImgFile":Ljava/io/File;
    nop

    .line 303
    :try_start_1
    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    .line 306
    :cond_1
    :goto_0
    goto :goto_1

    .line 304
    :catch_0
    move-exception v1

    .line 305
    .local v1, "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    .line 307
    .end local v1    # "e":Ljava/io/IOException;
    goto :goto_1

    .line 301
    :catchall_0
    move-exception v1

    goto :goto_2

    .line 298
    :catch_1
    move-exception v1

    .line 299
    .local v1, "e":Ljava/lang/Exception;
    :try_start_2
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 302
    .end local v1    # "e":Ljava/lang/Exception;
    if-eqz v0, :cond_1

    .line 303
    :try_start_3
    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_0

    .line 308
    :goto_1
    return-void

    .line 302
    :goto_2
    if-eqz v0, :cond_2

    .line 303
    :try_start_4
    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_3

    .line 304
    :catch_2
    move-exception v2

    .line 305
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_4

    .line 306
    .end local v2    # "e":Ljava/io/IOException;
    :cond_2
    :goto_3
    nop

    .line 307
    :goto_4
    throw v1

    .line 290
    .end local v0    # "os":Ljava/io/OutputStream;
    :cond_3
    :goto_5
    return-void
.end method

.method public static saveData2File([BLjava/lang/String;)V
    .locals 6
    .param p0, "data"    # [B
    .param p1, "path"    # Ljava/lang/String;

    .line 316
    const/4 v0, 0x0

    .line 317
    .local v0, "os":Ljava/io/OutputStream;
    const/4 v1, 0x0

    .line 320
    .local v1, "is":Ljava/io/InputStream;
    :try_start_0
    new-instance v2, Ljava/io/FileOutputStream;

    new-instance v3, Ljava/io/File;

    invoke-direct {v3, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v2, v3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    move-object v0, v2

    .line 321
    new-instance v2, Ljava/io/ByteArrayInputStream;

    invoke-direct {v2, p0}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    move-object v1, v2

    .line 322
    const/4 v2, 0x0

    .line 323
    .local v2, "len":I
    const/16 v3, 0x400

    new-array v3, v3, [B

    .line 324
    .local v3, "buff":[B
    :goto_0
    invoke-virtual {v1, v3}, Ljava/io/InputStream;->read([B)I

    move-result v4

    move v2, v4

    const/4 v5, -0x1

    if-eq v4, v5, :cond_0

    .line 325
    const/4 v4, 0x0

    invoke-virtual {v0, v3, v4, v2}, Ljava/io/OutputStream;->write([BII)V

    goto :goto_0

    .line 327
    :cond_0
    invoke-virtual {v0}, Ljava/io/OutputStream;->flush()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 332
    .end local v2    # "len":I
    .end local v3    # "buff":[B
    nop

    .line 333
    :try_start_1
    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V

    .line 334
    nop

    .line 335
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    .line 338
    :cond_1
    :goto_1
    goto :goto_2

    .line 336
    :catch_0
    move-exception v2

    .line 337
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    .line 339
    .end local v2    # "e":Ljava/io/IOException;
    goto :goto_2

    .line 331
    :catchall_0
    move-exception v2

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

    .line 332
    .end local v2    # "e":Ljava/lang/Exception;
    if-eqz v0, :cond_2

    .line 333
    :try_start_3
    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V

    .line 334
    :cond_2
    if-eqz v1, :cond_1

    .line 335
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_1

    .line 340
    :goto_2
    return-void

    .line 332
    :goto_3
    if-eqz v0, :cond_3

    .line 333
    :try_start_4
    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V

    goto :goto_4

    .line 336
    :catch_2
    move-exception v3

    goto :goto_5

    .line 334
    :cond_3
    :goto_4
    if-eqz v1, :cond_4

    .line 335
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_6

    .line 337
    .local v3, "e":Ljava/io/IOException;
    :goto_5
    invoke-virtual {v3}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_7

    .line 338
    .end local v3    # "e":Ljava/io/IOException;
    :cond_4
    :goto_6
    nop

    .line 339
    :goto_7
    throw v2
.end method
