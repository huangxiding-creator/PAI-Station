.class public Lorg/xerial/snappy/SnappyLoader;
.super Ljava/lang/Object;
.source "SnappyLoader.java"


# static fields
.field public static final KEY_SNAPPY_DISABLE_BUNDLED_LIBS:Ljava/lang/String; = "org.xerial.snappy.disable.bundled.libs"

.field public static final KEY_SNAPPY_LIB_NAME:Ljava/lang/String; = "org.xerial.snappy.lib.name"

.field public static final KEY_SNAPPY_LIB_PATH:Ljava/lang/String; = "org.xerial.snappy.lib.path"

.field public static final KEY_SNAPPY_TEMPDIR:Ljava/lang/String; = "org.xerial.snappy.tempdir"

.field public static final KEY_SNAPPY_USE_SYSTEMLIB:Ljava/lang/String; = "org.xerial.snappy.use.systemlib"

.field public static final SNAPPY_SYSTEM_PROPERTIES_FILE:Ljava/lang/String; = "org-xerial-snappy.properties"

.field private static volatile bitshuffleApi:Lorg/xerial/snappy/BitShuffleNative;

.field private static isLoaded:Z

.field private static nativeLibFile:Ljava/io/File;

.field private static volatile snappyApi:Lorg/xerial/snappy/SnappyNative;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 82
    const/4 v0, 0x0

    sput-boolean v0, Lorg/xerial/snappy/SnappyLoader;->isLoaded:Z

    .line 84
    const/4 v0, 0x0

    sput-object v0, Lorg/xerial/snappy/SnappyLoader;->snappyApi:Lorg/xerial/snappy/SnappyNative;

    .line 85
    sput-object v0, Lorg/xerial/snappy/SnappyLoader;->bitshuffleApi:Lorg/xerial/snappy/BitShuffleNative;

    .line 87
    sput-object v0, Lorg/xerial/snappy/SnappyLoader;->nativeLibFile:Ljava/io/File;

    .line 146
    invoke-static {}, Lorg/xerial/snappy/SnappyLoader;->loadSnappySystemProperties()V

    .line 147
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 73
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static cleanUpExtractedNativeLib()V
    .locals 1

    .line 91
    sget-object v0, Lorg/xerial/snappy/SnappyLoader;->nativeLibFile:Ljava/io/File;

    if-eqz v0, :cond_0

    sget-object v0, Lorg/xerial/snappy/SnappyLoader;->nativeLibFile:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 92
    sget-object v0, Lorg/xerial/snappy/SnappyLoader;->nativeLibFile:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    .line 93
    nop

    .line 96
    const/4 v0, 0x0

    sput-object v0, Lorg/xerial/snappy/SnappyLoader;->snappyApi:Lorg/xerial/snappy/SnappyNative;

    .line 97
    sput-object v0, Lorg/xerial/snappy/SnappyLoader;->bitshuffleApi:Lorg/xerial/snappy/BitShuffleNative;

    .line 99
    :cond_0
    return-void
.end method

.method private static contentsEquals(Ljava/io/InputStream;Ljava/io/InputStream;)Z
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 196
    instance-of v0, p0, Ljava/io/BufferedInputStream;

    if-nez v0, :cond_0

    .line 197
    new-instance v0, Ljava/io/BufferedInputStream;

    invoke-direct {v0, p0}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    move-object p0, v0

    .line 199
    :cond_0
    instance-of v0, p1, Ljava/io/BufferedInputStream;

    if-nez v0, :cond_1

    .line 200
    new-instance v0, Ljava/io/BufferedInputStream;

    invoke-direct {v0, p1}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    move-object p1, v0

    .line 203
    :cond_1
    invoke-virtual {p0}, Ljava/io/InputStream;->read()I

    move-result v0

    .line 204
    :goto_0
    const/4 v1, 0x0

    const/4 v2, -0x1

    if-eq v0, v2, :cond_3

    .line 205
    invoke-virtual {p1}, Ljava/io/InputStream;->read()I

    move-result v2

    .line 206
    if-eq v0, v2, :cond_2

    .line 207
    return v1

    .line 209
    :cond_2
    invoke-virtual {p0}, Ljava/io/InputStream;->read()I

    move-result v0

    .line 210
    goto :goto_0

    .line 211
    :cond_3
    invoke-virtual {p1}, Ljava/io/InputStream;->read()I

    move-result p0

    .line 212
    if-ne p0, v2, :cond_4

    const/4 v1, 0x1

    :cond_4
    return v1
.end method

.method private static extractLibraryFile(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;
    .locals 8

    .line 225
    const-class v0, Lorg/xerial/snappy/SnappyLoader;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v1, "/"

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 228
    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v1

    .line 229
    invoke-static {}, Lorg/xerial/snappy/SnappyLoader;->getVersion()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2, v1, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string v1, "snappy-%s-%s-%s"

    invoke-static {v1, p1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    .line 230
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p2, p1}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 234
    nop

    .line 235
    nop

    .line 237
    const/4 v2, 0x0

    :try_start_0
    invoke-virtual {v0, p0}, Ljava/lang/Class;->getResourceAsStream(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_6

    .line 239
    :try_start_1
    new-instance v4, Ljava/io/FileOutputStream;

    invoke-direct {v4, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_4

    .line 241
    const/16 v5, 0x2000

    :try_start_2
    new-array v5, v5, [B

    .line 242
    nop

    .line 243
    :goto_0
    invoke-virtual {v3, v5}, Ljava/io/InputStream;->read([B)I

    move-result v6

    const/4 v7, -0x1

    if-eq v6, v7, :cond_0

    .line 244
    const/4 v7, 0x0

    invoke-virtual {v4, v5, v7, v6}, Ljava/io/FileOutputStream;->write([BII)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_3

    goto :goto_0

    .line 248
    :cond_0
    nop

    .line 249
    :try_start_3
    invoke-virtual {v4}, Ljava/io/FileOutputStream;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_5

    .line 254
    if-eqz v3, :cond_1

    .line 255
    :try_start_4
    invoke-virtual {v3}, Ljava/io/InputStream;->close()V

    .line 259
    :cond_1
    invoke-virtual {v1}, Ljava/io/File;->deleteOnExit()V

    .line 260
    nop

    .line 263
    const/4 v3, 0x1

    invoke-virtual {v1, v3}, Ljava/io/File;->setReadable(Z)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 264
    invoke-virtual {v1, v3, v3}, Ljava/io/File;->setWritable(ZZ)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 265
    invoke-virtual {v1, v3}, Ljava/io/File;->setExecutable(Z)Z

    move-result v3
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_0

    if-eqz v3, :cond_2

    :cond_2
    nop

    .line 266
    nop

    .line 272
    nop

    .line 273
    nop

    .line 275
    :try_start_5
    invoke-virtual {v0, p0}, Ljava/lang/Class;->getResourceAsStream(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object p0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    .line 276
    :try_start_6
    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, v1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    .line 278
    :try_start_7
    invoke-static {p0, v0}, Lorg/xerial/snappy/SnappyLoader;->contentsEquals(Ljava/io/InputStream;Ljava/io/InputStream;)Z

    move-result v3
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    if-eqz v3, :cond_4

    .line 283
    if-eqz p0, :cond_3

    .line 284
    :try_start_8
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V

    .line 286
    :cond_3
    nop

    .line 287
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 292
    new-instance p0, Ljava/io/File;

    invoke-direct {p0, p2, p1}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_0

    return-object p0

    .line 279
    :cond_4
    :try_start_9
    new-instance p1, Lorg/xerial/snappy/SnappyError;

    sget-object p2, Lorg/xerial/snappy/SnappyErrorCode;->FAILED_TO_LOAD_NATIVE_LIBRARY:Lorg/xerial/snappy/SnappyErrorCode;

    const-string v3, "Failed to write a native library file at %s"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v3, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {p1, p2, v1}, Lorg/xerial/snappy/SnappyError;-><init>(Lorg/xerial/snappy/SnappyErrorCode;Ljava/lang/String;)V

    throw p1
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_0

    .line 283
    :catchall_0
    move-exception p1

    goto :goto_1

    :catchall_1
    move-exception p1

    move-object v0, v2

    goto :goto_1

    :catchall_2
    move-exception p1

    move-object p0, v2

    move-object v0, p0

    :goto_1
    if-eqz p0, :cond_5

    .line 284
    :try_start_a
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V

    .line 286
    :cond_5
    if-eqz v0, :cond_6

    .line 287
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 289
    :cond_6
    throw p1
    :try_end_a
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_0

    .line 248
    :catchall_3
    move-exception p0

    goto :goto_2

    :catchall_4
    move-exception p0

    move-object v4, v2

    :goto_2
    if-eqz v4, :cond_7

    .line 249
    :try_start_b
    invoke-virtual {v4}, Ljava/io/FileOutputStream;->close()V

    .line 251
    :cond_7
    throw p0
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_5

    .line 254
    :catchall_5
    move-exception p0

    goto :goto_3

    :catchall_6
    move-exception p0

    move-object v3, v2

    :goto_3
    if-eqz v3, :cond_8

    .line 255
    :try_start_c
    invoke-virtual {v3}, Ljava/io/InputStream;->close()V

    .line 259
    :cond_8
    invoke-virtual {v1}, Ljava/io/File;->deleteOnExit()V

    .line 260
    throw p0
    :try_end_c
    .catch Ljava/io/IOException; {:try_start_c .. :try_end_c} :catch_0

    .line 294
    :catch_0
    move-exception p0

    .line 295
    sget-object p1, Ljava/lang/System;->err:Ljava/io/PrintStream;

    invoke-virtual {p0, p1}, Ljava/io/IOException;->printStackTrace(Ljava/io/PrintStream;)V

    .line 296
    return-object v2
.end method

.method static findNativeLibrary()Ljava/io/File;
    .locals 6

    .line 303
    const-string v0, "org.xerial.snappy.use.systemlib"

    const-string v1, "false"

    invoke-static {v0, v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Boolean;->parseBoolean(Ljava/lang/String;)Z

    move-result v0

    .line 304
    nop

    .line 305
    const-string v2, "org.xerial.snappy.disable.bundled.libs"

    invoke-static {v2, v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Boolean;->parseBoolean(Ljava/lang/String;)Z

    move-result v1

    .line 306
    if-nez v0, :cond_6

    if-eqz v1, :cond_0

    goto/16 :goto_0

    .line 311
    :cond_0
    const-string v0, "org.xerial.snappy.lib.path"

    invoke-static {v0}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 312
    const-string v1, "org.xerial.snappy.lib.name"

    invoke-static {v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 315
    if-nez v1, :cond_1

    .line 316
    const-string v1, "snappyjava"

    invoke-static {v1}, Ljava/lang/System;->mapLibraryName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 319
    :cond_1
    if-eqz v0, :cond_2

    .line 320
    new-instance v2, Ljava/io/File;

    invoke-direct {v2, v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 321
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 322
    return-object v2

    .line 327
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "/org/xerial/snappy/native/"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lorg/xerial/snappy/OSInfo;->getNativeLibFolderPathForCurrentOS()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 328
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "/"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lorg/xerial/snappy/SnappyLoader;->hasResource(Ljava/lang/String;)Z

    move-result v2

    .line 329
    if-nez v2, :cond_3

    .line 330
    invoke-static {}, Lorg/xerial/snappy/OSInfo;->getOSName()Ljava/lang/String;

    move-result-object v4

    const-string v5, "Mac"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 332
    nop

    .line 333
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "libsnappyjava.jnilib"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lorg/xerial/snappy/SnappyLoader;->hasResource(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 334
    nop

    .line 335
    const/4 v2, 0x1

    move-object v1, v4

    .line 340
    :cond_3
    if-eqz v2, :cond_5

    .line 346
    new-instance v2, Ljava/io/File;

    const-string v3, "java.io.tmpdir"

    invoke-static {v3}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "org.xerial.snappy.tempdir"

    invoke-static {v4, v3}, Ljava/lang/System;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 347
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_4

    .line 348
    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    .line 349
    nop

    .line 355
    :cond_4
    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lorg/xerial/snappy/SnappyLoader;->extractLibraryFile(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    return-object v0

    .line 341
    :cond_5
    invoke-static {}, Lorg/xerial/snappy/OSInfo;->getOSName()Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lorg/xerial/snappy/OSInfo;->getArchName()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "no native library is found for os.name=%s and os.arch=%s"

    invoke-static {v1, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 342
    new-instance v1, Lorg/xerial/snappy/SnappyError;

    sget-object v2, Lorg/xerial/snappy/SnappyErrorCode;->FAILED_TO_LOAD_NATIVE_LIBRARY:Lorg/xerial/snappy/SnappyErrorCode;

    invoke-direct {v1, v2, v0}, Lorg/xerial/snappy/SnappyError;-><init>(Lorg/xerial/snappy/SnappyErrorCode;Ljava/lang/String;)V

    throw v1

    .line 307
    :cond_6
    :goto_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public static getVersion()Ljava/lang/String;
    .locals 5

    .line 373
    nop

    .line 374
    const-class v0, Lorg/xerial/snappy/SnappyLoader;

    const-string v1, "/META-INF/maven/org.xerial.snappy/snappy-java/pom.properties"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getResource(Ljava/lang/String;)Ljava/net/URL;

    move-result-object v1

    .line 375
    if-nez v1, :cond_0

    .line 376
    const-string v1, "/org/xerial/snappy/VERSION"

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getResource(Ljava/lang/String;)Ljava/net/URL;

    move-result-object v1

    .line 379
    :cond_0
    nop

    .line 381
    const-string v0, "unknown"

    if-eqz v1, :cond_2

    .line 382
    :try_start_0
    new-instance v2, Ljava/util/Properties;

    invoke-direct {v2}, Ljava/util/Properties;-><init>()V

    .line 383
    invoke-virtual {v1}, Ljava/net/URL;->openStream()Ljava/io/InputStream;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/util/Properties;->load(Ljava/io/InputStream;)V

    .line 384
    const-string v1, "version"

    invoke-virtual {v2, v1, v0}, Ljava/util/Properties;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    .line 385
    :try_start_1
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 386
    const-string v0, "SNAPPY_VERSION"

    invoke-virtual {v2, v0, v1}, Ljava/util/Properties;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .line 385
    :cond_1
    move-object v0, v1

    .line 388
    :goto_0
    :try_start_2
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    const-string v2, "[^0-9M\\.]"

    const-string v3, ""

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_2

    .line 391
    :catch_0
    move-exception v0

    goto :goto_1

    :catch_1
    move-exception v1

    move-object v4, v1

    move-object v1, v0

    move-object v0, v4

    .line 392
    :goto_1
    sget-object v2, Ljava/lang/System;->err:Ljava/io/PrintStream;

    invoke-virtual {v2, v0}, Ljava/io/PrintStream;->println(Ljava/lang/Object;)V

    goto :goto_3

    .line 393
    :cond_2
    :goto_2
    move-object v1, v0

    .line 394
    :goto_3
    return-object v1
.end method

.method private static hasResource(Ljava/lang/String;)Z
    .locals 1

    .line 360
    const-class v0, Lorg/xerial/snappy/SnappyLoader;

    invoke-virtual {v0, p0}, Ljava/lang/Class;->getResource(Ljava/lang/String;)Ljava/net/URL;

    move-result-object p0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method static declared-synchronized loadBitShuffleApi()Lorg/xerial/snappy/BitShuffleNative;
    .locals 2

    const-class v0, Lorg/xerial/snappy/SnappyLoader;

    monitor-enter v0

    .line 161
    :try_start_0
    sget-object v1, Lorg/xerial/snappy/SnappyLoader;->bitshuffleApi:Lorg/xerial/snappy/BitShuffleNative;

    if-eqz v1, :cond_0

    .line 162
    sget-object v1, Lorg/xerial/snappy/SnappyLoader;->bitshuffleApi:Lorg/xerial/snappy/BitShuffleNative;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    .line 164
    :cond_0
    :try_start_1
    invoke-static {}, Lorg/xerial/snappy/SnappyLoader;->loadNativeLibrary()V

    .line 165
    new-instance v1, Lorg/xerial/snappy/BitShuffleNative;

    invoke-direct {v1}, Lorg/xerial/snappy/BitShuffleNative;-><init>()V

    sput-object v1, Lorg/xerial/snappy/SnappyLoader;->bitshuffleApi:Lorg/xerial/snappy/BitShuffleNative;

    .line 166
    sget-object v1, Lorg/xerial/snappy/SnappyLoader;->bitshuffleApi:Lorg/xerial/snappy/BitShuffleNative;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit v0

    return-object v1

    .line 160
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private static declared-synchronized loadNativeLibrary()V
    .locals 4

    const-class v0, Lorg/xerial/snappy/SnappyLoader;

    monitor-enter v0

    .line 174
    :try_start_0
    sget-boolean v1, Lorg/xerial/snappy/SnappyLoader;->isLoaded:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v1, :cond_1

    .line 176
    :try_start_1
    invoke-static {}, Lorg/xerial/snappy/SnappyLoader;->findNativeLibrary()Ljava/io/File;

    move-result-object v1

    sput-object v1, Lorg/xerial/snappy/SnappyLoader;->nativeLibFile:Ljava/io/File;

    .line 177
    sget-object v1, Lorg/xerial/snappy/SnappyLoader;->nativeLibFile:Ljava/io/File;

    if-eqz v1, :cond_0

    .line 179
    sget-object v1, Lorg/xerial/snappy/SnappyLoader;->nativeLibFile:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/System;->load(Ljava/lang/String;)V

    goto :goto_0

    .line 182
    :cond_0
    const-string v1, "snappyjava"

    invoke-static {v1}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 188
    :goto_0
    nop

    .line 189
    const/4 v1, 0x1

    :try_start_2
    sput-boolean v1, Lorg/xerial/snappy/SnappyLoader;->isLoaded:Z

    goto :goto_1

    .line 185
    :catch_0
    move-exception v1

    .line 186
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 187
    new-instance v2, Lorg/xerial/snappy/SnappyError;

    sget-object v3, Lorg/xerial/snappy/SnappyErrorCode;->FAILED_TO_LOAD_NATIVE_LIBRARY:Lorg/xerial/snappy/SnappyErrorCode;

    invoke-virtual {v1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v3, v1}, Lorg/xerial/snappy/SnappyError;-><init>(Lorg/xerial/snappy/SnappyErrorCode;Ljava/lang/String;)V

    throw v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 191
    :cond_1
    :goto_1
    monitor-exit v0

    return-void

    .line 173
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method static declared-synchronized loadSnappyApi()Lorg/xerial/snappy/SnappyNative;
    .locals 2

    const-class v0, Lorg/xerial/snappy/SnappyLoader;

    monitor-enter v0

    .line 151
    :try_start_0
    sget-object v1, Lorg/xerial/snappy/SnappyLoader;->snappyApi:Lorg/xerial/snappy/SnappyNative;

    if-eqz v1, :cond_0

    .line 152
    sget-object v1, Lorg/xerial/snappy/SnappyLoader;->snappyApi:Lorg/xerial/snappy/SnappyNative;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    .line 154
    :cond_0
    :try_start_1
    invoke-static {}, Lorg/xerial/snappy/SnappyLoader;->loadNativeLibrary()V

    .line 155
    new-instance v1, Lorg/xerial/snappy/SnappyNative;

    invoke-direct {v1}, Lorg/xerial/snappy/SnappyNative;-><init>()V

    invoke-static {v1}, Lorg/xerial/snappy/SnappyLoader;->setSnappyApi(Lorg/xerial/snappy/SnappyNative;)V

    .line 156
    sget-object v1, Lorg/xerial/snappy/SnappyLoader;->snappyApi:Lorg/xerial/snappy/SnappyNative;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit v0

    return-object v1

    .line 150
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private static loadSnappySystemProperties()V
    .locals 4

    .line 118
    :try_start_0
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->getContextClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    const-string v1, "org-xerial-snappy.properties"

    .line 119
    invoke-virtual {v0, v1}, Ljava/lang/ClassLoader;->getResourceAsStream(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v0

    .line 121
    if-nez v0, :cond_0

    .line 122
    return-void

    .line 126
    :cond_0
    new-instance v1, Ljava/util/Properties;

    invoke-direct {v1}, Ljava/util/Properties;-><init>()V

    .line 127
    invoke-virtual {v1, v0}, Ljava/util/Properties;->load(Ljava/io/InputStream;)V

    .line 128
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 129
    invoke-virtual {v1}, Ljava/util/Properties;->propertyNames()Ljava/util/Enumeration;

    move-result-object v0

    .line 130
    :goto_0
    invoke-interface {v0}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 131
    invoke-interface {v0}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 132
    const-string v3, "org.xerial.snappy."

    invoke-virtual {v2, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 133
    invoke-static {v2}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    .line 134
    invoke-virtual {v1, v2}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Ljava/lang/System;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 137
    :cond_1
    goto :goto_0

    .line 142
    :cond_2
    goto :goto_1

    .line 139
    :catchall_0
    move-exception v0

    .line 140
    sget-object v1, Ljava/lang/System;->err:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Could not load \'org-xerial-snappy.properties\' from classpath: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 141
    invoke-virtual {v0}, Ljava/lang/Throwable;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 140
    invoke-virtual {v1, v0}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 143
    :goto_1
    return-void
.end method

.method static declared-synchronized setSnappyApi(Lorg/xerial/snappy/SnappyNative;)V
    .locals 1

    const-class v0, Lorg/xerial/snappy/SnappyLoader;

    monitor-enter v0

    .line 108
    :try_start_0
    sput-object p0, Lorg/xerial/snappy/SnappyLoader;->snappyApi:Lorg/xerial/snappy/SnappyNative;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 109
    monitor-exit v0

    return-void

    .line 107
    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method
