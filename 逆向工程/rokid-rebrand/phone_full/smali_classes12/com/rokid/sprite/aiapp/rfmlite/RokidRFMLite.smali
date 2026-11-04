.class public Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;
.super Ljava/lang/Object;
.source "RokidRFMLite.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;,
        Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$RokidRFMLiteCommond;,
        Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$SlotResult;,
        Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$IntentResult;,
        Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$Intent;
    }
.end annotation


# static fields
.field private static final NATIVE_LIBRARY_LOADED:Z

.field private static final TAG:Ljava/lang/String; = "RokidRFMLite"

.field private static instance:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;


# instance fields
.field private nativeHandle:J


# direct methods
.method static bridge synthetic -$$Nest$smformatFloat(F)Ljava/lang/String;
    .locals 0

    invoke-static {p0}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->formatFloat(F)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static constructor <clinit>()V
    .locals 4

    .line 26
    const/4 v0, 0x0

    .line 27
    .local v0, "loaded":Z
    invoke-static {}, Lcom/rokid/sprite/aiapp/rfmlite/NativeLibrarySupport;->isArm64Process()Z

    move-result v1

    const-string v2, "RokidRFMLite"

    if-eqz v1, :cond_0

    .line 29
    :try_start_0
    const-string/jumbo v1, "rokid_rfm_lite"

    invoke-static {v1}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/UnsatisfiedLinkError; {:try_start_0 .. :try_end_0} :catch_0

    .line 30
    const/4 v0, 0x1

    .line 33
    :goto_0
    goto :goto_1

    .line 31
    :catch_0
    move-exception v1

    .line 32
    .local v1, "error":Ljava/lang/UnsatisfiedLinkError;
    const-string v3, "Failed to load arm64 native library"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .end local v1    # "error":Ljava/lang/UnsatisfiedLinkError;
    goto :goto_0

    .line 35
    :cond_0
    const-string v1, "RFM Lite is disabled: current process is not arm64-v8a"

    invoke-static {v2, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 37
    :goto_1
    sput-boolean v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->NATIVE_LIBRARY_LOADED:Z

    .line 38
    .end local v0    # "loaded":Z
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 216
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private copyAssetFile(Landroid/content/res/AssetManager;Ljava/lang/String;Ljava/io/File;)V
    .locals 7
    .param p1, "assetManager"    # Landroid/content/res/AssetManager;
    .param p2, "assetPath"    # Ljava/lang/String;
    .param p3, "destFile"    # Ljava/io/File;

    .line 268
    const/4 v0, 0x0

    .line 269
    .local v0, "in":Ljava/io/InputStream;
    const/4 v1, 0x0

    .line 271
    .local v1, "out":Ljava/io/FileOutputStream;
    :try_start_0
    invoke-virtual {p1, p2}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v2

    move-object v0, v2

    .line 272
    invoke-virtual {p3}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v2

    .line 273
    .local v2, "parentDir":Ljava/io/File;
    if-eqz v2, :cond_0

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_0

    .line 274
    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    .line 276
    :cond_0
    new-instance v3, Ljava/io/FileOutputStream;

    invoke-direct {v3, p3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    move-object v1, v3

    .line 277
    const/16 v3, 0x400

    new-array v3, v3, [B

    .line 279
    .local v3, "buffer":[B
    :goto_0
    invoke-virtual {v0, v3}, Ljava/io/InputStream;->read([B)I

    move-result v4

    move v5, v4

    .local v5, "read":I
    const/4 v6, -0x1

    if-eq v4, v6, :cond_1

    .line 280
    const/4 v4, 0x0

    invoke-virtual {v1, v3, v4, v5}, Ljava/io/FileOutputStream;->write([BII)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 286
    .end local v2    # "parentDir":Ljava/io/File;
    .end local v3    # "buffer":[B
    .end local v5    # "read":I
    :cond_1
    if-eqz v0, :cond_2

    :try_start_1
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    goto :goto_1

    .line 288
    :catch_0
    move-exception v2

    goto :goto_3

    .line 287
    :cond_2
    :goto_1
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    .line 290
    :cond_3
    :goto_2
    goto :goto_4

    .line 289
    .local v2, "e":Ljava/io/IOException;
    :goto_3
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    .line 291
    .end local v2    # "e":Ljava/io/IOException;
    goto :goto_4

    .line 285
    :catchall_0
    move-exception v2

    goto :goto_5

    .line 282
    :catch_1
    move-exception v2

    .line 283
    .restart local v2    # "e":Ljava/io/IOException;
    :try_start_2
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 286
    .end local v2    # "e":Ljava/io/IOException;
    if-eqz v0, :cond_4

    :try_start_3
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 287
    :cond_4
    if-eqz v1, :cond_3

    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_2

    .line 292
    :goto_4
    return-void

    .line 286
    :goto_5
    if-eqz v0, :cond_5

    :try_start_4
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    goto :goto_6

    .line 288
    :catch_2
    move-exception v3

    goto :goto_7

    .line 287
    :cond_5
    :goto_6
    if-eqz v1, :cond_6

    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_8

    .line 289
    .local v3, "e":Ljava/io/IOException;
    :goto_7
    invoke-virtual {v3}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_9

    .line 290
    .end local v3    # "e":Ljava/io/IOException;
    :cond_6
    :goto_8
    nop

    .line 291
    :goto_9
    throw v2
.end method

.method private static formatFloat(F)Ljava/lang/String;
    .locals 2
    .param p0, "value"    # F

    .line 441
    invoke-static {p0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "%.2f"

    invoke-static {v1, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static declared-synchronized getInstance()Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;
    .locals 2

    const-class v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;

    monitor-enter v0

    .line 219
    :try_start_0
    sget-object v1, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->instance:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;

    if-nez v1, :cond_0

    .line 220
    new-instance v1, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;

    invoke-direct {v1}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;-><init>()V

    sput-object v1, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->instance:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;

    .line 222
    :cond_0
    sget-object v1, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->instance:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    .line 218
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public static isSupported()Z
    .locals 1

    .line 227
    sget-boolean v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->NATIVE_LIBRARY_LOADED:Z

    return v0
.end method

.method private static native nativeCreate(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)J
.end method

.method private static native nativeDelete(J)V
.end method

.method private static native nativePredict(JILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;
.end method


# virtual methods
.method public copyAssetsRecursively(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)V
    .locals 7
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "assetDir"    # Ljava/lang/String;
    .param p3, "destDir"    # Ljava/io/File;

    .line 245
    invoke-virtual {p1}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v0

    .line 247
    .local v0, "assetManager":Landroid/content/res/AssetManager;
    :try_start_0
    invoke-virtual {v0, p2}, Landroid/content/res/AssetManager;->list(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .line 248
    .local v1, "files":[Ljava/lang/String;
    if-eqz v1, :cond_3

    array-length v2, v1

    if-nez v2, :cond_0

    goto :goto_2

    .line 253
    :cond_0
    invoke-virtual {p3}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_1

    .line 254
    invoke-virtual {p3}, Ljava/io/File;->mkdirs()Z

    .line 256
    :cond_1
    array-length v2, v1

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_4

    aget-object v4, v1, v3

    .line 257
    .local v4, "fileName":Ljava/lang/String;
    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-eqz v5, :cond_2

    move-object v5, v4

    goto :goto_1

    :cond_2
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "/"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 258
    .local v5, "subAssetPath":Ljava/lang/String;
    :goto_1
    new-instance v6, Ljava/io/File;

    invoke-direct {v6, p3, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 259
    .local v6, "subDestPath":Ljava/io/File;
    invoke-virtual {p0, p1, v5, v6}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->copyAssetsRecursively(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)V

    .line 256
    .end local v4    # "fileName":Ljava/lang/String;
    .end local v5    # "subAssetPath":Ljava/lang/String;
    .end local v6    # "subDestPath":Ljava/io/File;
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 250
    :cond_3
    :goto_2
    invoke-direct {p0, v0, p2, p3}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->copyAssetFile(Landroid/content/res/AssetManager;Ljava/lang/String;Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 264
    .end local v1    # "files":[Ljava/lang/String;
    :cond_4
    goto :goto_3

    .line 262
    :catch_0
    move-exception v1

    .line 263
    .local v1, "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    .line 265
    .end local v1    # "e":Ljava/io/IOException;
    :goto_3
    return-void
.end method

.method public create(Landroid/content/Context;Ljava/lang/String;)Z
    .locals 6
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "deviceId"    # Ljava/lang/String;

    .line 231
    sget-boolean v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->NATIVE_LIBRARY_LOADED:Z

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 232
    const-string v0, "RokidRFMLite"

    const-string v2, "Skipping RFM Lite initialization on an unsupported ABI"

    invoke-static {v0, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 233
    return v1

    .line 235
    :cond_0
    iget-wide v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->nativeHandle:J

    const-wide/16 v4, 0x0

    cmp-long v0, v2, v4

    if-eqz v0, :cond_1

    .line 236
    return v1

    .line 238
    :cond_1
    new-instance v0, Ljava/io/File;

    const/4 v2, 0x0

    invoke-virtual {p1, v2}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    const-string v3, "rfmlite"

    invoke-direct {v0, v2, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 239
    .local v0, "destDir":Ljava/io/File;
    invoke-virtual {p0, p1, v3, v0}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->copyAssetsRecursively(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)V

    .line 240
    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    const-string v3, "Android"

    invoke-static {v2, p2, v3}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->nativeCreate(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)J

    move-result-wide v2

    iput-wide v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->nativeHandle:J

    .line 241
    iget-wide v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->nativeHandle:J

    cmp-long v2, v2, v4

    if-eqz v2, :cond_2

    const/4 v1, 0x1

    :cond_2
    return v1
.end method

.method protected finalize()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 315
    invoke-virtual {p0}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->release()V

    .line 316
    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    .line 317
    return-void
.end method

.method public predict(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;
    .locals 7
    .param p1, "text"    # Ljava/lang/String;
    .param p2, "scene"    # I
    .param p3, "sessionId"    # Ljava/lang/String;
    .param p4, "traceId"    # Ljava/lang/String;

    .line 299
    sget-boolean v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->NATIVE_LIBRARY_LOADED:Z

    if-eqz v0, :cond_1

    iget-wide v0, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->nativeHandle:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    goto :goto_0

    .line 302
    :cond_0
    iget-wide v1, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->nativeHandle:J

    move v3, p2

    move-object v4, p1

    move-object v5, p3

    move-object v6, p4

    invoke-static/range {v1 .. v6}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->nativePredict(JILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;

    move-result-object v0

    .line 303
    .local v0, "result":Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;
    return-object v0

    .line 300
    .end local v0    # "result":Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;
    :cond_1
    :goto_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public release()V
    .locals 4

    .line 307
    sget-boolean v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->NATIVE_LIBRARY_LOADED:Z

    if-eqz v0, :cond_0

    iget-wide v0, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->nativeHandle:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    .line 308
    iget-wide v0, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->nativeHandle:J

    invoke-static {v0, v1}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->nativeDelete(J)V

    .line 309
    iput-wide v2, p0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->nativeHandle:J

    .line 311
    :cond_0
    return-void
.end method
