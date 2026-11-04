.class public final Lcom/blankj/utilcode/util/UriUtils;
.super Ljava/lang/Object;
.source "UriUtils.java"


# direct methods
.method private constructor <init>()V
    .locals 2

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string/jumbo v1, "u can\'t instantiate me..."

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static copyUri2Cache(Landroid/net/Uri;)Ljava/io/File;
    .locals 6
    .param p0, "uri"    # Landroid/net/Uri;

    .line 309
    const-string v0, "UriUtils"

    const-string v1, "copyUri2Cache() called"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 310
    const/4 v0, 0x0

    .line 312
    .local v0, "is":Ljava/io/InputStream;
    :try_start_0
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/Application;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    invoke-virtual {v1, p0}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v1

    move-object v0, v1

    .line 313
    new-instance v1, Ljava/io/File;

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v2

    invoke-virtual {v2}, Landroid/app/Application;->getCacheDir()Ljava/io/File;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, ""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v2, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 314
    .local v1, "file":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2, v0}, Lcom/blankj/utilcode/util/UtilsBridge;->writeFileFromIS(Ljava/lang/String;Ljava/io/InputStream;)Z
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 315
    nop

    .line 320
    if-eqz v0, :cond_0

    .line 322
    :try_start_1
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    .line 325
    goto :goto_0

    .line 323
    :catch_0
    move-exception v2

    .line 324
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    .line 315
    .end local v2    # "e":Ljava/io/IOException;
    :cond_0
    :goto_0
    return-object v1

    .line 320
    .end local v1    # "file":Ljava/io/File;
    :catchall_0
    move-exception v1

    goto :goto_2

    .line 316
    :catch_1
    move-exception v1

    .line 317
    .local v1, "e":Ljava/io/FileNotFoundException;
    :try_start_2
    invoke-virtual {v1}, Ljava/io/FileNotFoundException;->printStackTrace()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 318
    nop

    .line 320
    if-eqz v0, :cond_1

    .line 322
    :try_start_3
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2

    .line 325
    goto :goto_1

    .line 323
    :catch_2
    move-exception v2

    .line 324
    .restart local v2    # "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    .line 318
    .end local v2    # "e":Ljava/io/IOException;
    :cond_1
    :goto_1
    const/4 v2, 0x0

    return-object v2

    .line 320
    .end local v1    # "e":Ljava/io/FileNotFoundException;
    :goto_2
    if-eqz v0, :cond_2

    .line 322
    :try_start_4
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3

    .line 325
    goto :goto_3

    .line 323
    :catch_3
    move-exception v2

    .line 324
    .restart local v2    # "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    .line 327
    .end local v2    # "e":Ljava/io/IOException;
    :cond_2
    :goto_3
    throw v1
.end method

.method public static file2Uri(Ljava/io/File;)Landroid/net/Uri;
    .locals 2
    .param p0, "file"    # Ljava/io/File;

    .line 58
    invoke-static {p0}, Lcom/blankj/utilcode/util/UtilsBridge;->isFileExists(Ljava/io/File;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 59
    :cond_0
    nop

    .line 60
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/Application;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ".utilcode.fileprovider"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 61
    .local v0, "authority":Ljava/lang/String;
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v1

    invoke-static {v1, v0, p0}, Landroidx/core/content/FileProvider;->getUriForFile(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;

    move-result-object v1

    return-object v1
.end method

.method private static getFileFromUri(Landroid/net/Uri;Ljava/lang/String;)Ljava/io/File;
    .locals 1
    .param p0, "uri"    # Landroid/net/Uri;
    .param p1, "code"    # Ljava/lang/String;

    .line 257
    const/4 v0, 0x0

    invoke-static {p0, v0, v0, p1}, Lcom/blankj/utilcode/util/UriUtils;->getFileFromUri(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    return-object v0
.end method

.method private static getFileFromUri(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;
    .locals 8
    .param p0, "uri"    # Landroid/net/Uri;
    .param p1, "selection"    # Ljava/lang/String;
    .param p2, "selectionArgs"    # [Ljava/lang/String;
    .param p3, "code"    # Ljava/lang/String;

    .line 264
    const-string v0, "com.google.android.apps.photos.content"

    invoke-virtual {p0}, Landroid/net/Uri;->getAuthority()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 265
    invoke-virtual {p0}, Landroid/net/Uri;->getLastPathSegment()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_4

    .line 266
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Landroid/net/Uri;->getLastPathSegment()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    return-object v0

    .line 268
    :cond_0
    const-string v0, "com.tencent.mtt.fileprovider"

    invoke-virtual {p0}, Landroid/net/Uri;->getAuthority()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 269
    invoke-virtual {p0}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v0

    .line 270
    .local v0, "path":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 271
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v1

    .line 272
    .local v1, "fileDir":Ljava/io/File;
    new-instance v2, Ljava/io/File;

    const-string v3, "/QQBrowser"

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v4

    invoke-virtual {v0, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v1, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v2

    .line 270
    .end local v0    # "path":Ljava/lang/String;
    .end local v1    # "fileDir":Ljava/io/File;
    :cond_1
    goto :goto_0

    .line 274
    :cond_2
    const-string v0, "com.huawei.hidisk.fileprovider"

    invoke-virtual {p0}, Landroid/net/Uri;->getAuthority()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 275
    invoke-virtual {p0}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v0

    .line 276
    .restart local v0    # "path":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_4

    .line 277
    new-instance v1, Ljava/io/File;

    const-string v2, "/root"

    const-string v3, ""

    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    return-object v1

    .line 274
    .end local v0    # "path":Ljava/lang/String;
    :cond_3
    :goto_0
    nop

    .line 281
    :cond_4
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Application;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const/4 v0, 0x1

    new-array v3, v0, [Ljava/lang/String;

    const/4 v0, 0x0

    const-string v7, "_data"

    aput-object v7, v3, v0

    const/4 v6, 0x0

    move-object v2, p0

    move-object v4, p1

    move-object v5, p2

    invoke-virtual/range {v1 .. v6}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v0

    .line 283
    .local v0, "cursor":Landroid/database/Cursor;
    const/4 v1, 0x0

    const-string v2, "UriUtils"

    if-nez v0, :cond_5

    .line 284
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " parse failed(cursor is null). -> "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 285
    return-object v1

    .line 288
    :cond_5
    :try_start_0
    invoke-interface {v0}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v3

    if-eqz v3, :cond_7

    .line 289
    invoke-interface {v0, v7}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v3

    .line 290
    .local v3, "columnIndex":I
    const/4 v4, -0x1

    if-le v3, v4, :cond_6

    .line 291
    new-instance v4, Ljava/io/File;

    invoke-interface {v0, v3}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 304
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 291
    return-object v4

    .line 293
    :cond_6
    :try_start_1
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " parse failed(columnIndex: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " is wrong). -> "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 294
    nop

    .line 304
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 294
    return-object v1

    .line 297
    .end local v3    # "columnIndex":I
    :cond_7
    :try_start_2
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " parse failed(moveToFirst return false). -> "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 298
    nop

    .line 304
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 298
    return-object v1

    .line 304
    :catchall_0
    move-exception v1

    goto :goto_1

    .line 300
    :catch_0
    move-exception v3

    .line 301
    .local v3, "e":Ljava/lang/Exception;
    :try_start_3
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " parse failed. -> "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v2, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 302
    nop

    .line 304
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 302
    return-object v1

    .line 304
    .end local v3    # "e":Ljava/lang/Exception;
    :goto_1
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 305
    throw v1
.end method

.method public static res2Uri(Ljava/lang/String;)Landroid/net/Uri;
    .locals 2
    .param p0, "resPath"    # Ljava/lang/String;

    .line 48
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "android.resource://"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/Application;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    return-object v0
.end method

.method public static uri2Bytes(Landroid/net/Uri;)[B
    .locals 5
    .param p0, "uri"    # Landroid/net/Uri;

    .line 337
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    .line 338
    :cond_0
    const/4 v1, 0x0

    .line 340
    .local v1, "is":Ljava/io/InputStream;
    :try_start_0
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v2

    invoke-virtual {v2}, Landroid/app/Application;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    invoke-virtual {v2, p0}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v2

    move-object v1, v2

    .line 341
    invoke-static {v1}, Lcom/blankj/utilcode/util/UtilsBridge;->inputStream2Bytes(Ljava/io/InputStream;)[B

    move-result-object v0
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 347
    if-eqz v1, :cond_1

    .line 349
    :try_start_1
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    .line 352
    goto :goto_0

    .line 350
    :catch_0
    move-exception v2

    .line 351
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    .line 341
    .end local v2    # "e":Ljava/io/IOException;
    :cond_1
    :goto_0
    return-object v0

    .line 347
    :catchall_0
    move-exception v0

    goto :goto_2

    .line 342
    :catch_1
    move-exception v2

    .line 343
    .local v2, "e":Ljava/io/FileNotFoundException;
    :try_start_2
    invoke-virtual {v2}, Ljava/io/FileNotFoundException;->printStackTrace()V

    .line 344
    const-string v3, "UriUtils"

    const-string/jumbo v4, "uri to bytes failed."

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 345
    nop

    .line 347
    if-eqz v1, :cond_2

    .line 349
    :try_start_3
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2

    .line 352
    goto :goto_1

    .line 350
    :catch_2
    move-exception v3

    .line 351
    .local v3, "e":Ljava/io/IOException;
    invoke-virtual {v3}, Ljava/io/IOException;->printStackTrace()V

    .line 345
    .end local v3    # "e":Ljava/io/IOException;
    :cond_2
    :goto_1
    return-object v0

    .line 347
    .end local v2    # "e":Ljava/io/FileNotFoundException;
    :goto_2
    if-eqz v1, :cond_3

    .line 349
    :try_start_4
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3

    .line 352
    goto :goto_3

    .line 350
    :catch_3
    move-exception v2

    .line 351
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    .line 354
    .end local v2    # "e":Ljava/io/IOException;
    :cond_3
    :goto_3
    throw v0
.end method

.method public static uri2File(Landroid/net/Uri;)Ljava/io/File;
    .locals 2
    .param p0, "uri"    # Landroid/net/Uri;

    .line 74
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return-object v0

    .line 75
    :cond_0
    invoke-static {p0}, Lcom/blankj/utilcode/util/UriUtils;->uri2FileReal(Landroid/net/Uri;)Ljava/io/File;

    move-result-object v0

    .line 76
    .local v0, "file":Ljava/io/File;
    if-eqz v0, :cond_1

    return-object v0

    .line 77
    :cond_1
    invoke-static {p0}, Lcom/blankj/utilcode/util/UriUtils;->copyUri2Cache(Landroid/net/Uri;)Ljava/io/File;

    move-result-object v1

    return-object v1
.end method

.method private static uri2FileReal(Landroid/net/Uri;)Ljava/io/File;
    .locals 26
    .param p0, "uri"    # Landroid/net/Uri;

    .line 87
    move-object/from16 v1, p0

    invoke-virtual/range {p0 .. p0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v2, "UriUtils"

    invoke-static {v2, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 88
    invoke-virtual/range {p0 .. p0}, Landroid/net/Uri;->getAuthority()Ljava/lang/String;

    move-result-object v3

    .line 89
    .local v3, "authority":Ljava/lang/String;
    invoke-virtual/range {p0 .. p0}, Landroid/net/Uri;->getScheme()Ljava/lang/String;

    move-result-object v4

    .line 90
    .local v4, "scheme":Ljava/lang/String;
    invoke-virtual/range {p0 .. p0}, Landroid/net/Uri;->getPath()Ljava/lang/String;

    move-result-object v5

    .line 91
    .local v5, "path":Ljava/lang/String;
    const/4 v0, 0x2

    const-string v6, "/"

    const/4 v7, 0x0

    const/4 v8, 0x1

    const/4 v9, 0x0

    if-eqz v5, :cond_7

    .line 92
    new-array v10, v0, [Ljava/lang/String;

    const-string v11, "/external/"

    aput-object v11, v10, v9

    const-string v11, "/external_path/"

    aput-object v11, v10, v8

    .line 93
    .local v10, "externals":[Ljava/lang/String;
    const/4 v11, 0x0

    .line 94
    .local v11, "file":Ljava/io/File;
    array-length v12, v10

    move v13, v9

    :goto_0
    const-string v14, " -> "

    if-ge v13, v12, :cond_2

    aget-object v15, v10, v13

    .line 95
    .local v15, "external":Ljava/lang/String;
    invoke-virtual {v5, v15}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v16

    if-eqz v16, :cond_1

    .line 96
    new-instance v0, Ljava/io/File;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v17

    invoke-virtual/range {v17 .. v17}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    .line 97
    invoke-virtual {v5, v15, v6}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v0, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 98
    .end local v11    # "file":Ljava/io/File;
    .local v0, "file":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v8

    if-eqz v8, :cond_0

    .line 99
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual/range {p0 .. p0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v2, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 100
    return-object v0

    .line 98
    :cond_0
    move-object v11, v0

    .line 94
    .end local v0    # "file":Ljava/io/File;
    .end local v15    # "external":Ljava/lang/String;
    .restart local v11    # "file":Ljava/io/File;
    :cond_1
    add-int/lit8 v13, v13, 0x1

    const/4 v0, 0x2

    const/4 v8, 0x1

    const/4 v9, 0x0

    goto :goto_0

    .line 104
    :cond_2
    const/4 v0, 0x0

    .line 105
    .end local v11    # "file":Ljava/io/File;
    .restart local v0    # "file":Ljava/io/File;
    const-string v8, "/files_path/"

    invoke-virtual {v5, v8}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_3

    .line 106
    new-instance v9, Ljava/io/File;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v12

    invoke-virtual {v12}, Landroid/app/Application;->getFilesDir()Ljava/io/File;

    move-result-object v12

    invoke-virtual {v12}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    .line 107
    invoke-virtual {v5, v8, v6}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v11, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v9, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object v0, v9

    goto/16 :goto_1

    .line 108
    :cond_3
    const-string v8, "/cache_path/"

    invoke-virtual {v5, v8}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_4

    .line 109
    new-instance v9, Ljava/io/File;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v12

    invoke-virtual {v12}, Landroid/app/Application;->getCacheDir()Ljava/io/File;

    move-result-object v12

    invoke-virtual {v12}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    .line 110
    invoke-virtual {v5, v8, v6}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v11, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v9, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object v0, v9

    goto :goto_1

    .line 111
    :cond_4
    const-string v8, "/external_files_path/"

    invoke-virtual {v5, v8}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_5

    .line 112
    new-instance v9, Ljava/io/File;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v12

    invoke-virtual {v12, v7}, Landroid/app/Application;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v12

    invoke-virtual {v12}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    .line 113
    invoke-virtual {v5, v8, v6}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v11, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v9, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object v0, v9

    goto :goto_1

    .line 114
    :cond_5
    const-string v8, "/external_cache_path/"

    invoke-virtual {v5, v8}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_6

    .line 115
    new-instance v9, Ljava/io/File;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v12

    invoke-virtual {v12}, Landroid/app/Application;->getExternalCacheDir()Ljava/io/File;

    move-result-object v12

    invoke-virtual {v12}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    .line 116
    invoke-virtual {v5, v8, v6}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v11, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v9, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object v0, v9

    .line 118
    :cond_6
    :goto_1
    if-eqz v0, :cond_7

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v8

    if-eqz v8, :cond_7

    .line 119
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual/range {p0 .. p0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v2, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 120
    return-object v0

    .line 123
    .end local v0    # "file":Ljava/io/File;
    .end local v10    # "externals":[Ljava/lang/String;
    :cond_7
    const-string v0, "file"

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_9

    .line 124
    if-eqz v5, :cond_8

    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    return-object v0

    .line 125
    :cond_8
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual/range {p0 .. p0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v6, " parse failed. -> 0"

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 126
    return-object v7

    .line 128
    :cond_9
    nop

    .line 129
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v0

    invoke-static {v0, v1}, Landroid/provider/DocumentsContract;->isDocumentUri(Landroid/content/Context;Landroid/net/Uri;)Z

    move-result v0

    const-string v8, "content"

    if-eqz v0, :cond_1d

    .line 130
    const-string v0, "com.android.externalstorage.documents"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const-string v9, ":"

    if-eqz v0, :cond_11

    .line 131
    invoke-static/range {p0 .. p0}, Landroid/provider/DocumentsContract;->getDocumentId(Landroid/net/Uri;)Ljava/lang/String;

    move-result-object v8

    .line 132
    .local v8, "docId":Ljava/lang/String;
    invoke-virtual {v8, v9}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v9

    .line 133
    .local v9, "split":[Ljava/lang/String;
    const/4 v0, 0x0

    aget-object v10, v9, v0

    .line 134
    .local v10, "type":Ljava/lang/String;
    const-string v0, "primary"

    invoke-virtual {v0, v10}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_a

    .line 135
    new-instance v0, Ljava/io/File;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v7

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/4 v6, 0x1

    aget-object v6, v9, v6

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    return-object v0

    .line 139
    :cond_a
    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v0

    const-string/jumbo v11, "storage"

    invoke-virtual {v0, v11}, Landroid/app/Application;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    move-object v11, v0

    check-cast v11, Landroid/os/storage/StorageManager;

    .line 141
    .local v11, "mStorageManager":Landroid/os/storage/StorageManager;
    :try_start_0
    const-string v0, "android.os.storage.StorageVolume"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 142
    .local v0, "storageVolumeClazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    invoke-virtual {v11}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v12

    const-string v13, "getVolumeList"

    const/4 v14, 0x0

    new-array v15, v14, [Ljava/lang/Class;

    invoke-virtual {v12, v13, v15}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v12

    .line 143
    .local v12, "getVolumeList":Ljava/lang/reflect/Method;
    const-string v13, "getUuid"

    new-array v15, v14, [Ljava/lang/Class;

    invoke-virtual {v0, v13, v15}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v13

    .line 144
    .local v13, "getUuid":Ljava/lang/reflect/Method;
    const-string v15, "getState"

    new-array v7, v14, [Ljava/lang/Class;

    invoke-virtual {v0, v15, v7}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    .line 145
    .local v7, "getState":Ljava/lang/reflect/Method;
    const-string v15, "getPath"
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_3

    move-object/from16 v18, v5

    .end local v5    # "path":Ljava/lang/String;
    .local v18, "path":Ljava/lang/String;
    :try_start_1
    new-array v5, v14, [Ljava/lang/Class;

    invoke-virtual {v0, v15, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v5

    .line 146
    .local v5, "getPath":Ljava/lang/reflect/Method;
    const-string v15, "isPrimary"
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2

    move-object/from16 v16, v8

    .end local v8    # "docId":Ljava/lang/String;
    .local v16, "docId":Ljava/lang/String;
    :try_start_2
    new-array v8, v14, [Ljava/lang/Class;

    invoke-virtual {v0, v15, v8}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v8

    .line 147
    .local v8, "isPrimary":Ljava/lang/reflect/Method;
    const-string v15, "isEmulated"

    new-array v1, v14, [Ljava/lang/Class;

    invoke-virtual {v0, v15, v1}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 149
    .local v1, "isEmulated":Ljava/lang/reflect/Method;
    new-array v15, v14, [Ljava/lang/Object;

    invoke-virtual {v12, v11, v15}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v14

    .line 151
    .local v14, "result":Ljava/lang/Object;
    invoke-static {v14}, Ljava/lang/reflect/Array;->getLength(Ljava/lang/Object;)I

    move-result v15

    .line 152
    .local v15, "length":I
    const/16 v19, 0x0

    move-object/from16 v20, v0

    move/from16 v0, v19

    .local v0, "i":I
    .local v20, "storageVolumeClazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :goto_2
    if-ge v0, v15, :cond_10

    .line 153
    invoke-static {v14, v0}, Ljava/lang/reflect/Array;->get(Ljava/lang/Object;I)Ljava/lang/Object;

    move-result-object v19
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    move-object/from16 v21, v19

    .line 156
    .local v21, "storageVolumeElement":Ljava/lang/Object;
    move-object/from16 v19, v11

    .end local v11    # "mStorageManager":Landroid/os/storage/StorageManager;
    .local v19, "mStorageManager":Landroid/os/storage/StorageManager;
    :try_start_3
    const-string v11, "mounted"

    move-object/from16 v22, v12

    move-object/from16 v23, v14

    const/4 v12, 0x0

    .end local v12    # "getVolumeList":Ljava/lang/reflect/Method;
    .end local v14    # "result":Ljava/lang/Object;
    .local v22, "getVolumeList":Ljava/lang/reflect/Method;
    .local v23, "result":Ljava/lang/Object;
    new-array v14, v12, [Ljava/lang/Object;

    move-object/from16 v12, v21

    .end local v21    # "storageVolumeElement":Ljava/lang/Object;
    .local v12, "storageVolumeElement":Ljava/lang/Object;
    invoke-virtual {v7, v12, v14}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v14

    invoke-virtual {v11, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-nez v11, :cond_c

    const-string v11, "mounted_ro"

    move/from16 v21, v15

    const/4 v14, 0x0

    .end local v15    # "length":I
    .local v21, "length":I
    new-array v15, v14, [Ljava/lang/Object;

    .line 157
    invoke-virtual {v7, v12, v15}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v14

    invoke-virtual {v11, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_b

    goto :goto_3

    :cond_b
    const/4 v11, 0x0

    goto :goto_4

    .line 156
    .end local v21    # "length":I
    .restart local v15    # "length":I
    :cond_c
    move/from16 v21, v15

    .line 157
    .end local v15    # "length":I
    .restart local v21    # "length":I
    :goto_3
    const/4 v11, 0x1

    .line 160
    .local v11, "mounted":Z
    :goto_4
    if-nez v11, :cond_d

    move-object/from16 v24, v1

    move-object/from16 v25, v7

    goto :goto_5

    .line 163
    :cond_d
    const/4 v14, 0x0

    new-array v15, v14, [Ljava/lang/Object;

    invoke-virtual {v8, v12, v15}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Ljava/lang/Boolean;

    invoke-virtual {v14}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v14

    if-eqz v14, :cond_e

    const/4 v14, 0x0

    new-array v15, v14, [Ljava/lang/Object;

    .line 164
    invoke-virtual {v1, v12, v15}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Ljava/lang/Boolean;

    invoke-virtual {v14}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v14

    if-eqz v14, :cond_e

    .line 165
    move-object/from16 v24, v1

    move-object/from16 v25, v7

    goto :goto_5

    .line 168
    :cond_e
    const/4 v14, 0x0

    new-array v15, v14, [Ljava/lang/Object;

    invoke-virtual {v13, v12, v15}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Ljava/lang/String;

    .line 170
    .local v14, "uuid":Ljava/lang/String;
    if-eqz v14, :cond_f

    invoke-virtual {v14, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v15

    if-eqz v15, :cond_f

    .line 171
    new-instance v15, Ljava/io/File;

    move-object/from16 v24, v1

    .end local v1    # "isEmulated":Ljava/lang/reflect/Method;
    .local v24, "isEmulated":Ljava/lang/reflect/Method;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v25, v7

    const/4 v7, 0x0

    .end local v7    # "getState":Ljava/lang/reflect/Method;
    .local v25, "getState":Ljava/lang/reflect/Method;
    new-array v7, v7, [Ljava/lang/Object;

    invoke-virtual {v5, v12, v7}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/4 v6, 0x1

    aget-object v6, v9, v6

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v15, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    return-object v15

    .line 170
    .end local v24    # "isEmulated":Ljava/lang/reflect/Method;
    .end local v25    # "getState":Ljava/lang/reflect/Method;
    .restart local v1    # "isEmulated":Ljava/lang/reflect/Method;
    .restart local v7    # "getState":Ljava/lang/reflect/Method;
    :cond_f
    move-object/from16 v24, v1

    move-object/from16 v25, v7

    .line 152
    .end local v1    # "isEmulated":Ljava/lang/reflect/Method;
    .end local v7    # "getState":Ljava/lang/reflect/Method;
    .end local v11    # "mounted":Z
    .end local v12    # "storageVolumeElement":Ljava/lang/Object;
    .end local v14    # "uuid":Ljava/lang/String;
    .restart local v24    # "isEmulated":Ljava/lang/reflect/Method;
    .restart local v25    # "getState":Ljava/lang/reflect/Method;
    :goto_5
    add-int/lit8 v0, v0, 0x1

    move-object/from16 v11, v19

    move/from16 v15, v21

    move-object/from16 v12, v22

    move-object/from16 v14, v23

    move-object/from16 v1, v24

    move-object/from16 v7, v25

    goto/16 :goto_2

    .line 174
    .end local v0    # "i":I
    .end local v5    # "getPath":Ljava/lang/reflect/Method;
    .end local v8    # "isPrimary":Ljava/lang/reflect/Method;
    .end local v13    # "getUuid":Ljava/lang/reflect/Method;
    .end local v20    # "storageVolumeClazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v21    # "length":I
    .end local v22    # "getVolumeList":Ljava/lang/reflect/Method;
    .end local v23    # "result":Ljava/lang/Object;
    .end local v24    # "isEmulated":Ljava/lang/reflect/Method;
    .end local v25    # "getState":Ljava/lang/reflect/Method;
    :catch_0
    move-exception v0

    goto :goto_6

    .line 152
    .end local v19    # "mStorageManager":Landroid/os/storage/StorageManager;
    .restart local v0    # "i":I
    .restart local v1    # "isEmulated":Ljava/lang/reflect/Method;
    .restart local v5    # "getPath":Ljava/lang/reflect/Method;
    .restart local v7    # "getState":Ljava/lang/reflect/Method;
    .restart local v8    # "isPrimary":Ljava/lang/reflect/Method;
    .local v11, "mStorageManager":Landroid/os/storage/StorageManager;
    .local v12, "getVolumeList":Ljava/lang/reflect/Method;
    .restart local v13    # "getUuid":Ljava/lang/reflect/Method;
    .local v14, "result":Ljava/lang/Object;
    .restart local v15    # "length":I
    .restart local v20    # "storageVolumeClazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :cond_10
    move-object/from16 v24, v1

    move-object/from16 v25, v7

    move-object/from16 v19, v11

    move-object/from16 v22, v12

    move-object/from16 v23, v14

    move/from16 v21, v15

    .line 176
    .end local v0    # "i":I
    .end local v1    # "isEmulated":Ljava/lang/reflect/Method;
    .end local v5    # "getPath":Ljava/lang/reflect/Method;
    .end local v7    # "getState":Ljava/lang/reflect/Method;
    .end local v8    # "isPrimary":Ljava/lang/reflect/Method;
    .end local v11    # "mStorageManager":Landroid/os/storage/StorageManager;
    .end local v12    # "getVolumeList":Ljava/lang/reflect/Method;
    .end local v13    # "getUuid":Ljava/lang/reflect/Method;
    .end local v14    # "result":Ljava/lang/Object;
    .end local v15    # "length":I
    .end local v20    # "storageVolumeClazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .restart local v19    # "mStorageManager":Landroid/os/storage/StorageManager;
    goto :goto_7

    .line 174
    .end local v19    # "mStorageManager":Landroid/os/storage/StorageManager;
    .restart local v11    # "mStorageManager":Landroid/os/storage/StorageManager;
    :catch_1
    move-exception v0

    move-object/from16 v19, v11

    .end local v11    # "mStorageManager":Landroid/os/storage/StorageManager;
    .restart local v19    # "mStorageManager":Landroid/os/storage/StorageManager;
    goto :goto_6

    .end local v16    # "docId":Ljava/lang/String;
    .end local v19    # "mStorageManager":Landroid/os/storage/StorageManager;
    .local v8, "docId":Ljava/lang/String;
    .restart local v11    # "mStorageManager":Landroid/os/storage/StorageManager;
    :catch_2
    move-exception v0

    move-object/from16 v16, v8

    move-object/from16 v19, v11

    .end local v8    # "docId":Ljava/lang/String;
    .end local v11    # "mStorageManager":Landroid/os/storage/StorageManager;
    .restart local v16    # "docId":Ljava/lang/String;
    .restart local v19    # "mStorageManager":Landroid/os/storage/StorageManager;
    goto :goto_6

    .end local v16    # "docId":Ljava/lang/String;
    .end local v18    # "path":Ljava/lang/String;
    .end local v19    # "mStorageManager":Landroid/os/storage/StorageManager;
    .local v5, "path":Ljava/lang/String;
    .restart local v8    # "docId":Ljava/lang/String;
    .restart local v11    # "mStorageManager":Landroid/os/storage/StorageManager;
    :catch_3
    move-exception v0

    move-object/from16 v18, v5

    move-object/from16 v16, v8

    move-object/from16 v19, v11

    .line 175
    .end local v5    # "path":Ljava/lang/String;
    .end local v8    # "docId":Ljava/lang/String;
    .end local v11    # "mStorageManager":Landroid/os/storage/StorageManager;
    .local v0, "ex":Ljava/lang/Exception;
    .restart local v16    # "docId":Ljava/lang/String;
    .restart local v18    # "path":Ljava/lang/String;
    .restart local v19    # "mStorageManager":Landroid/os/storage/StorageManager;
    :goto_6
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual/range {p0 .. p0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v5, " parse failed. "

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v5, " -> 1_0"

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 178
    .end local v0    # "ex":Ljava/lang/Exception;
    .end local v19    # "mStorageManager":Landroid/os/storage/StorageManager;
    :goto_7
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual/range {p0 .. p0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " parse failed. -> 1_0"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 179
    const/4 v1, 0x0

    return-object v1

    .line 181
    .end local v9    # "split":[Ljava/lang/String;
    .end local v10    # "type":Ljava/lang/String;
    .end local v16    # "docId":Ljava/lang/String;
    .end local v18    # "path":Ljava/lang/String;
    .restart local v5    # "path":Ljava/lang/String;
    :cond_11
    move-object/from16 v18, v5

    .end local v5    # "path":Ljava/lang/String;
    .restart local v18    # "path":Ljava/lang/String;
    const-string v0, "com.android.providers.downloads.documents"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_17

    .line 182
    invoke-static/range {p0 .. p0}, Landroid/provider/DocumentsContract;->getDocumentId(Landroid/net/Uri;)Ljava/lang/String;

    move-result-object v0

    .line 183
    .local v0, "id":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_12

    .line 184
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual/range {p0 .. p0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v5, " parse failed(id is null). -> 1_1"

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 185
    const/4 v1, 0x0

    return-object v1

    .line 187
    :cond_12
    const-string v1, "raw:"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_13

    .line 188
    new-instance v1, Ljava/io/File;

    const/4 v2, 0x4

    invoke-virtual {v0, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    return-object v1

    .line 189
    :cond_13
    const-string v1, "msf:"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_14

    .line 190
    invoke-virtual {v0, v9}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    const/4 v5, 0x1

    aget-object v0, v1, v5

    move-object v1, v0

    goto :goto_8

    .line 189
    :cond_14
    move-object v1, v0

    .line 193
    .end local v0    # "id":Ljava/lang/String;
    .local v1, "id":Ljava/lang/String;
    :goto_8
    const-wide/16 v5, 0x0

    .line 195
    .local v5, "availableId":J
    :try_start_4
    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v7
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_5

    move-wide v5, v7

    .line 198
    nop

    .line 200
    const/4 v0, 0x3

    new-array v0, v0, [Ljava/lang/String;

    const-string v7, "content://downloads/public_downloads"

    const/4 v8, 0x0

    aput-object v7, v0, v8

    const-string v7, "content://downloads/all_downloads"

    const/4 v8, 0x1

    aput-object v7, v0, v8

    const-string v7, "content://downloads/my_downloads"

    const/4 v8, 0x2

    aput-object v7, v0, v8

    move-object v7, v0

    .line 206
    .local v7, "contentUriPrefixesToTry":[Ljava/lang/String;
    array-length v8, v7

    const/4 v9, 0x0

    :goto_9
    if-ge v9, v8, :cond_16

    aget-object v10, v7, v9

    .line 207
    .local v10, "contentUriPrefix":Ljava/lang/String;
    invoke-static {v10}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    invoke-static {v0, v5, v6}, Landroid/content/ContentUris;->withAppendedId(Landroid/net/Uri;J)Landroid/net/Uri;

    move-result-object v11

    .line 209
    .local v11, "contentUri":Landroid/net/Uri;
    :try_start_5
    const-string v0, "1_1"

    invoke-static {v11, v0}, Lcom/blankj/utilcode/util/UriUtils;->getFileFromUri(Landroid/net/Uri;Ljava/lang/String;)Ljava/io/File;

    move-result-object v0
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_4

    .line 210
    .local v0, "file":Ljava/io/File;
    if-eqz v0, :cond_15

    .line 211
    return-object v0

    .line 214
    .end local v0    # "file":Ljava/io/File;
    :cond_15
    goto :goto_a

    .line 213
    :catch_4
    move-exception v0

    .line 206
    .end local v10    # "contentUriPrefix":Ljava/lang/String;
    .end local v11    # "contentUri":Landroid/net/Uri;
    :goto_a
    add-int/lit8 v9, v9, 0x1

    goto :goto_9

    .line 217
    :cond_16
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual/range {p0 .. p0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v8, " parse failed. -> 1_1"

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 218
    const/4 v2, 0x0

    return-object v2

    .line 196
    .end local v7    # "contentUriPrefixesToTry":[Ljava/lang/String;
    :catch_5
    move-exception v0

    const/4 v2, 0x0

    move-object v7, v0

    move-object v0, v7

    .line 197
    .local v0, "e":Ljava/lang/Exception;
    return-object v2

    .line 220
    .end local v0    # "e":Ljava/lang/Exception;
    .end local v1    # "id":Ljava/lang/String;
    .end local v5    # "availableId":J
    :cond_17
    const-string v0, "com.android.providers.media.documents"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1b

    .line 221
    invoke-static/range {p0 .. p0}, Landroid/provider/DocumentsContract;->getDocumentId(Landroid/net/Uri;)Ljava/lang/String;

    move-result-object v0

    .line 222
    .local v0, "docId":Ljava/lang/String;
    invoke-virtual {v0, v9}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .line 223
    .local v1, "split":[Ljava/lang/String;
    const/4 v5, 0x0

    aget-object v6, v1, v5

    .line 225
    .local v6, "type":Ljava/lang/String;
    const-string v5, "image"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_18

    .line 226
    sget-object v2, Landroid/provider/MediaStore$Images$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    .local v2, "contentUri":Landroid/net/Uri;
    goto :goto_b

    .line 227
    .end local v2    # "contentUri":Landroid/net/Uri;
    :cond_18
    const-string/jumbo v5, "video"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_19

    .line 228
    sget-object v2, Landroid/provider/MediaStore$Video$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    .restart local v2    # "contentUri":Landroid/net/Uri;
    goto :goto_b

    .line 229
    .end local v2    # "contentUri":Landroid/net/Uri;
    :cond_19
    const-string v5, "audio"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1a

    .line 230
    sget-object v2, Landroid/provider/MediaStore$Audio$Media;->EXTERNAL_CONTENT_URI:Landroid/net/Uri;

    .line 235
    .restart local v2    # "contentUri":Landroid/net/Uri;
    :goto_b
    const-string v5, "_id=?"

    .line 236
    .local v5, "selection":Ljava/lang/String;
    const/4 v7, 0x1

    new-array v8, v7, [Ljava/lang/String;

    aget-object v7, v1, v7

    const/4 v9, 0x0

    aput-object v7, v8, v9

    move-object v7, v8

    .line 237
    .local v7, "selectionArgs":[Ljava/lang/String;
    const-string v8, "_id=?"

    const-string v9, "1_2"

    invoke-static {v2, v8, v7, v9}, Lcom/blankj/utilcode/util/UriUtils;->getFileFromUri(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v8

    return-object v8

    .line 232
    .end local v2    # "contentUri":Landroid/net/Uri;
    .end local v5    # "selection":Ljava/lang/String;
    .end local v7    # "selectionArgs":[Ljava/lang/String;
    :cond_1a
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual/range {p0 .. p0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v7, " parse failed. -> 1_2"

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v2, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 233
    const/4 v2, 0x0

    return-object v2

    .line 239
    .end local v0    # "docId":Ljava/lang/String;
    .end local v1    # "split":[Ljava/lang/String;
    .end local v6    # "type":Ljava/lang/String;
    :cond_1b
    invoke-virtual {v8, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1c

    .line 240
    const-string v0, "1_3"

    move-object/from16 v1, p0

    invoke-static {v1, v0}, Lcom/blankj/utilcode/util/UriUtils;->getFileFromUri(Landroid/net/Uri;Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    return-object v0

    .line 243
    :cond_1c
    move-object/from16 v1, p0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual/range {p0 .. p0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v5, " parse failed. -> 1_4"

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 244
    const/4 v2, 0x0

    return-object v2

    .line 129
    .end local v18    # "path":Ljava/lang/String;
    .local v5, "path":Ljava/lang/String;
    :cond_1d
    move-object/from16 v18, v5

    .line 247
    .end local v5    # "path":Ljava/lang/String;
    .restart local v18    # "path":Ljava/lang/String;
    invoke-virtual {v8, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1e

    .line 248
    const-string v0, "2"

    invoke-static {v1, v0}, Lcom/blankj/utilcode/util/UriUtils;->getFileFromUri(Landroid/net/Uri;Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    return-object v0

    .line 251
    :cond_1e
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual/range {p0 .. p0}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v5, " parse failed. -> 3"

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 252
    const/4 v2, 0x0

    return-object v2
.end method
