.class public final Lcom/rokid/security/phone/sdk/base/utils/other/ImageThumbnailUtils;
.super Ljava/lang/Object;
.source "ImageThumbnailUtils.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000*\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0018\u0010\u0005\u001a\u00020\u00042\u0006\u0010\u0006\u001a\u00020\u00042\u0006\u0010\u0007\u001a\u00020\u0004H\u0002J*\u0010\u0008\u001a\u0004\u0018\u00010\t2\u0006\u0010\n\u001a\u00020\u000b2\u0006\u0010\u0006\u001a\u00020\u00042\u0006\u0010\u0007\u001a\u00020\u00042\u0006\u0010\u000c\u001a\u00020\u0004H\u0002J\u0018\u0010\r\u001a\u0004\u0018\u00010\u000b2\u0006\u0010\u000e\u001a\u00020\u000f2\u0006\u0010\u0010\u001a\u00020\u000bR\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0011"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/base/utils/other/ImageThumbnailUtils;",
        "",
        "()V",
        "MAX_THUMBNAIL_SIZE",
        "",
        "calculateScaleFactor",
        "originalWidth",
        "originalHeight",
        "decodeSampledBitmap",
        "Landroid/graphics/Bitmap;",
        "path",
        "",
        "scaleFactor",
        "generateThumbnail",
        "context",
        "Landroid/content/Context;",
        "originalPath",
        "base-utils_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/ImageThumbnailUtils;

.field private static final MAX_THUMBNAIL_SIZE:I = 0x200


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/other/ImageThumbnailUtils;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/base/utils/other/ImageThumbnailUtils;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/base/utils/other/ImageThumbnailUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/other/ImageThumbnailUtils;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final calculateScaleFactor(II)I
    .locals 3
    .param p1, "originalWidth"    # I
    .param p2, "originalHeight"    # I

    .line 85
    const/4 v0, 0x1

    .line 86
    .local v0, "scale":I
    :goto_0
    div-int v1, p1, v0

    const/16 v2, 0x200

    if-gt v1, v2, :cond_1

    div-int v1, p2, v0

    if-le v1, v2, :cond_0

    goto :goto_1

    .line 89
    :cond_0
    return v0

    .line 87
    :cond_1
    :goto_1
    mul-int/lit8 v0, v0, 0x2

    goto :goto_0
.end method

.method private final decodeSampledBitmap(Ljava/lang/String;III)Landroid/graphics/Bitmap;
    .locals 3
    .param p1, "path"    # Ljava/lang/String;
    .param p2, "originalWidth"    # I
    .param p3, "originalHeight"    # I
    .param p4, "scaleFactor"    # I

    .line 101
    new-instance v0, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v0}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    .local v0, "$this$decodeSampledBitmap_u24lambda_u242":Landroid/graphics/BitmapFactory$Options;
    const/4 v1, 0x0

    .line 102
    .local v1, "$i$a$-run-ImageThumbnailUtils$decodeSampledBitmap$1":I
    iput p4, v0, Landroid/graphics/BitmapFactory$Options;->inSampleSize:I

    .line 103
    const/4 v2, 0x0

    iput-boolean v2, v0, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    .line 104
    sget-object v2, Landroid/graphics/Bitmap$Config;->RGB_565:Landroid/graphics/Bitmap$Config;

    iput-object v2, v0, Landroid/graphics/BitmapFactory$Options;->inPreferredConfig:Landroid/graphics/Bitmap$Config;

    .line 105
    const/4 v2, 0x1

    iput-boolean v2, v0, Landroid/graphics/BitmapFactory$Options;->inPurgeable:Z

    .line 106
    invoke-static {p1, v0}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 101
    .end local v0    # "$this$decodeSampledBitmap_u24lambda_u242":Landroid/graphics/BitmapFactory$Options;
    .end local v1    # "$i$a$-run-ImageThumbnailUtils$decodeSampledBitmap$1":I
    return-object v0
.end method


# virtual methods
.method public final generateThumbnail(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 18
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "originalPath"    # Ljava/lang/String;

    move-object/from16 v1, p0

    move-object/from16 v2, p2

    const-string v0, "context"

    move-object/from16 v3, p1

    invoke-static {v3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "originalPath"

    invoke-static {v2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 27
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object v4, v0

    .line 28
    .local v4, "originalFile":Ljava/io/File;
    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v0

    const/4 v5, 0x0

    if-eqz v0, :cond_7

    invoke-virtual {v4}, Ljava/io/File;->isFile()Z

    move-result v0

    if-nez v0, :cond_0

    goto/16 :goto_2

    .line 33
    :cond_0
    new-instance v0, Ljava/io/File;

    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v6

    const-string/jumbo v7, "thumbnails"

    invoke-direct {v0, v6, v7}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    move-object v6, v0

    .line 34
    .local v6, "thumbnailDir":Ljava/io/File;
    invoke-virtual {v6}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_1

    .line 35
    invoke-virtual {v6}, Ljava/io/File;->mkdirs()Z

    .line 39
    :cond_1
    invoke-virtual {v4}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v7

    .line 40
    .local v7, "originalFileName":Ljava/lang/String;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v8, "thumb_"

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 41
    .local v8, "thumbnailFileName":Ljava/lang/String;
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v6, v8}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    move-object v9, v0

    .line 44
    .local v9, "thumbnailFile":Ljava/io/File;
    invoke-virtual {v9}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 45
    invoke-virtual {v9}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 49
    :cond_2
    new-instance v0, Landroid/graphics/BitmapFactory$Options;

    invoke-direct {v0}, Landroid/graphics/BitmapFactory$Options;-><init>()V

    move-object v10, v0

    .local v10, "$this$generateThumbnail_u24lambda_u240":Landroid/graphics/BitmapFactory$Options;
    const/4 v11, 0x0

    .line 50
    .local v11, "$i$a$-apply-ImageThumbnailUtils$generateThumbnail$options$1":I
    const/4 v12, 0x1

    iput-boolean v12, v10, Landroid/graphics/BitmapFactory$Options;->inJustDecodeBounds:Z

    .line 51
    nop

    .line 49
    .end local v10    # "$this$generateThumbnail_u24lambda_u240":Landroid/graphics/BitmapFactory$Options;
    .end local v11    # "$i$a$-apply-ImageThumbnailUtils$generateThumbnail$options$1":I
    nop

    .line 52
    .local v10, "options":Landroid/graphics/BitmapFactory$Options;
    invoke-static {v2, v10}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;Landroid/graphics/BitmapFactory$Options;)Landroid/graphics/Bitmap;

    .line 53
    iget v11, v10, Landroid/graphics/BitmapFactory$Options;->outWidth:I

    .line 54
    .local v11, "originalWidth":I
    iget v12, v10, Landroid/graphics/BitmapFactory$Options;->outHeight:I

    .line 57
    .local v12, "originalHeight":I
    invoke-direct {v1, v11, v12}, Lcom/rokid/security/phone/sdk/base/utils/other/ImageThumbnailUtils;->calculateScaleFactor(II)I

    move-result v13

    .line 60
    .local v13, "scaleFactor":I
    invoke-direct {v1, v2, v11, v12, v13}, Lcom/rokid/security/phone/sdk/base/utils/other/ImageThumbnailUtils;->decodeSampledBitmap(Ljava/lang/String;III)Landroid/graphics/Bitmap;

    move-result-object v0

    if-nez v0, :cond_3

    .line 61
    return-object v5

    .line 60
    :cond_3
    move-object v14, v0

    .line 64
    .local v14, "thumbnailBitmap":Landroid/graphics/Bitmap;
    nop

    .line 65
    :try_start_0
    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, v9}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    move-object v15, v0

    check-cast v15, Ljava/io/Closeable;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    :try_start_1
    move-object v0, v15

    check-cast v0, Ljava/io/FileOutputStream;

    .local v0, "outputStream":Ljava/io/FileOutputStream;
    const/16 v16, 0x0

    .line 67
    .local v16, "$i$a$-use-ImageThumbnailUtils$generateThumbnail$1":I
    sget-object v5, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    move-object v1, v0

    check-cast v1, Ljava/io/OutputStream;

    move-object/from16 v17, v0

    .end local v0    # "outputStream":Ljava/io/FileOutputStream;
    .local v17, "outputStream":Ljava/io/FileOutputStream;
    const/16 v0, 0x50

    invoke-virtual {v14, v5, v0, v1}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 65
    .end local v16    # "$i$a$-use-ImageThumbnailUtils$generateThumbnail$1":I
    .end local v17    # "outputStream":Ljava/io/FileOutputStream;
    const/4 v1, 0x0

    :try_start_2
    invoke-static {v15, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 69
    invoke-virtual {v9}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 75
    invoke-virtual {v14}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v0

    if-nez v0, :cond_4

    .line 76
    invoke-virtual {v14}, Landroid/graphics/Bitmap;->recycle()V

    .line 78
    :cond_4
    goto :goto_0

    .line 65
    :catchall_0
    move-exception v0

    move-object v1, v0

    .end local v4    # "originalFile":Ljava/io/File;
    .end local v6    # "thumbnailDir":Ljava/io/File;
    .end local v7    # "originalFileName":Ljava/lang/String;
    .end local v8    # "thumbnailFileName":Ljava/lang/String;
    .end local v9    # "thumbnailFile":Ljava/io/File;
    .end local v10    # "options":Landroid/graphics/BitmapFactory$Options;
    .end local v11    # "originalWidth":I
    .end local v12    # "originalHeight":I
    .end local v13    # "scaleFactor":I
    .end local v14    # "thumbnailBitmap":Landroid/graphics/Bitmap;
    .end local p1    # "context":Landroid/content/Context;
    .end local p2    # "originalPath":Ljava/lang/String;
    :try_start_3
    throw v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .restart local v4    # "originalFile":Ljava/io/File;
    .restart local v6    # "thumbnailDir":Ljava/io/File;
    .restart local v7    # "originalFileName":Ljava/lang/String;
    .restart local v8    # "thumbnailFileName":Ljava/lang/String;
    .restart local v9    # "thumbnailFile":Ljava/io/File;
    .restart local v10    # "options":Landroid/graphics/BitmapFactory$Options;
    .restart local v11    # "originalWidth":I
    .restart local v12    # "originalHeight":I
    .restart local v13    # "scaleFactor":I
    .restart local v14    # "thumbnailBitmap":Landroid/graphics/Bitmap;
    .restart local p1    # "context":Landroid/content/Context;
    .restart local p2    # "originalPath":Ljava/lang/String;
    :catchall_1
    move-exception v0

    move-object v5, v0

    :try_start_4
    invoke-static {v15, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local v4    # "originalFile":Ljava/io/File;
    .end local v6    # "thumbnailDir":Ljava/io/File;
    .end local v7    # "originalFileName":Ljava/lang/String;
    .end local v8    # "thumbnailFileName":Ljava/lang/String;
    .end local v9    # "thumbnailFile":Ljava/io/File;
    .end local v10    # "options":Landroid/graphics/BitmapFactory$Options;
    .end local v11    # "originalWidth":I
    .end local v12    # "originalHeight":I
    .end local v13    # "scaleFactor":I
    .end local v14    # "thumbnailBitmap":Landroid/graphics/Bitmap;
    .end local p1    # "context":Landroid/content/Context;
    .end local p2    # "originalPath":Ljava/lang/String;
    throw v5
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 75
    .restart local v4    # "originalFile":Ljava/io/File;
    .restart local v6    # "thumbnailDir":Ljava/io/File;
    .restart local v7    # "originalFileName":Ljava/lang/String;
    .restart local v8    # "thumbnailFileName":Ljava/lang/String;
    .restart local v9    # "thumbnailFile":Ljava/io/File;
    .restart local v10    # "options":Landroid/graphics/BitmapFactory$Options;
    .restart local v11    # "originalWidth":I
    .restart local v12    # "originalHeight":I
    .restart local v13    # "scaleFactor":I
    .restart local v14    # "thumbnailBitmap":Landroid/graphics/Bitmap;
    .restart local p1    # "context":Landroid/content/Context;
    .restart local p2    # "originalPath":Ljava/lang/String;
    :catchall_2
    move-exception v0

    goto :goto_1

    .line 70
    :catch_0
    move-exception v0

    .line 71
    .local v0, "e":Ljava/lang/Exception;
    :try_start_5
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    .line 72
    nop

    .line 75
    .end local v0    # "e":Ljava/lang/Exception;
    invoke-virtual {v14}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v0

    if-nez v0, :cond_5

    .line 76
    invoke-virtual {v14}, Landroid/graphics/Bitmap;->recycle()V

    .line 78
    :cond_5
    const/4 v5, 0x0

    .line 64
    :goto_0
    return-object v5

    .line 75
    :goto_1
    invoke-virtual {v14}, Landroid/graphics/Bitmap;->isRecycled()Z

    move-result v1

    if-nez v1, :cond_6

    .line 76
    invoke-virtual {v14}, Landroid/graphics/Bitmap;->recycle()V

    :cond_6
    throw v0

    .line 29
    .end local v6    # "thumbnailDir":Ljava/io/File;
    .end local v7    # "originalFileName":Ljava/lang/String;
    .end local v8    # "thumbnailFileName":Ljava/lang/String;
    .end local v9    # "thumbnailFile":Ljava/io/File;
    .end local v10    # "options":Landroid/graphics/BitmapFactory$Options;
    .end local v11    # "originalWidth":I
    .end local v12    # "originalHeight":I
    .end local v13    # "scaleFactor":I
    .end local v14    # "thumbnailBitmap":Landroid/graphics/Bitmap;
    :cond_7
    :goto_2
    const/4 v1, 0x0

    return-object v1
.end method
