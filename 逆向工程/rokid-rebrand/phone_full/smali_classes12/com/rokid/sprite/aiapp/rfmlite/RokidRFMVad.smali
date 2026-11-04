.class public final Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;
.super Ljava/lang/Object;
.source "RokidRFMVad.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadCallback;,
        Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadFinalResult;,
        Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;,
        Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nRokidRFMVad.kt\nKotlin\n*S Kotlin\n*F\n+ 1 RokidRFMVad.kt\ncom/rokid/sprite/aiapp/rfmlite/RokidRFMVad\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,281:1\n1#2:282\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000R\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u0008\n\u0002\u0008\u000c\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0008\u0008\u00c6\u0002\u0018\u00002\u00020\u0001:\u0004+,-.B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J \u0010\t\u001a\u00020\n2\u0006\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u00042\u0006\u0010\u000e\u001a\u00020\u000fH\u0002J \u0010\u0010\u001a\u00020\n2\u0006\u0010\u0011\u001a\u00020\u00122\u0006\u0010\u0013\u001a\u00020\u00042\u0006\u0010\u0014\u001a\u00020\u000fH\u0002J*\u0010\u0015\u001a\u00020\u00082\u0006\u0010\u0011\u001a\u00020\u00122\u0006\u0010\u0016\u001a\u00020\u00042\u0008\u0008\u0002\u0010\u0017\u001a\u00020\u00182\u0008\u0008\u0002\u0010\u0019\u001a\u00020\u0004J\u0016\u0010\u001a\u001a\u00020\u00082\u0006\u0010\u001b\u001a\u00020\u00042\u0006\u0010\u001c\u001a\u00020\u0004J\u0008\u0010\u001d\u001a\u00020\u0008H\u0007J)\u0010\u001e\u001a\u00020\u00062\u0006\u0010\u001f\u001a\u00020\u00042\u0006\u0010\u0016\u001a\u00020\u00042\u0006\u0010\u0017\u001a\u00020\u00182\u0006\u0010\u0019\u001a\u00020\u0004H\u0082 J\u0011\u0010 \u001a\u00020\n2\u0006\u0010!\u001a\u00020\u0006H\u0082 J!\u0010\"\u001a\u00020\u00082\u0006\u0010!\u001a\u00020\u00062\u0006\u0010\u001b\u001a\u00020\u00042\u0006\u0010\u001c\u001a\u00020\u0004H\u0082 J!\u0010#\u001a\u00020\u00082\u0006\u0010!\u001a\u00020\u00062\u0006\u0010\u001c\u001a\u00020\u00042\u0006\u0010$\u001a\u00020%H\u0082 J\u001b\u0010&\u001a\u0004\u0018\u00010\'2\u0006\u0010!\u001a\u00020\u00062\u0006\u0010\u001c\u001a\u00020\u0004H\u0082 J\u0006\u0010(\u001a\u00020\nJ\u0016\u0010)\u001a\u00020\u00082\u0006\u0010\u001c\u001a\u00020\u00042\u0006\u0010$\u001a\u00020%J\u0010\u0010*\u001a\u0004\u0018\u00010\'2\u0006\u0010\u001c\u001a\u00020\u0004R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0008X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006/"
    }
    d2 = {
        "Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;",
        "",
        "()V",
        "TAG",
        "",
        "nativeHandle",
        "",
        "nativeLibraryLoaded",
        "",
        "copyAssetFile",
        "",
        "assetManager",
        "Landroid/content/res/AssetManager;",
        "assetPath",
        "destFile",
        "Ljava/io/File;",
        "copyAssetsRecursively",
        "context",
        "Landroid/content/Context;",
        "assetDir",
        "destDir",
        "create",
        "deviceId",
        "timeoutMs",
        "",
        "terminalType",
        "feed",
        "text",
        "traceId",
        "isSupported",
        "nativeCreate",
        "configDir",
        "nativeDelete",
        "handle",
        "nativeFeed",
        "nativeStart",
        "callback",
        "Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadCallback;",
        "nativeStop",
        "Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadFinalResult;",
        "release",
        "start",
        "stop",
        "VadCallback",
        "VadFinalResult",
        "VadStatus",
        "VadTmpResult",
        "lib-rfmlite_release"
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
.field public static final INSTANCE:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;

.field private static final TAG:Ljava/lang/String; = "RokidRFMVad"

.field private static nativeHandle:J

.field private static final nativeLibraryLoaded:Z


# direct methods
.method static constructor <clinit>()V
    .locals 6

    new-instance v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;

    invoke-direct {v0}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;-><init>()V

    sput-object v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->INSTANCE:Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;

    .line 21
    invoke-static {}, Lcom/rokid/sprite/aiapp/rfmlite/NativeLibrarySupport;->isArm64Process()Z

    move-result v0

    const-string v1, "RokidRFMVad"

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    .line 22
    nop

    .line 23
    :try_start_0
    const-string/jumbo v0, "rokid_rfm_lite"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    .line 24
    const-string v0, "VAD native library loaded successfully"

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v1, v0, v3}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->dWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/UnsatisfiedLinkError; {:try_start_0 .. :try_end_0} :catch_0

    .line 25
    const/4 v0, 0x1

    move v2, v0

    goto :goto_0

    .line 26
    :catch_0
    move-exception v0

    .line 27
    .local v0, "e":Ljava/lang/UnsatisfiedLinkError;
    invoke-virtual {v0}, Ljava/lang/UnsatisfiedLinkError;->getMessage()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Failed to load VAD native library: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-array v4, v2, [Ljava/lang/Object;

    invoke-static {v1, v3, v4}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->eWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 28
    nop

    .end local v0    # "e":Ljava/lang/UnsatisfiedLinkError;
    :goto_0
    goto :goto_1

    .line 31
    :cond_0
    const-string v0, "VAD is disabled: current process is not arm64-v8a"

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v1, v0, v3}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->dWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 32
    nop

    .line 21
    :goto_1
    sput-boolean v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeLibraryLoaded:Z

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final copyAssetFile(Landroid/content/res/AssetManager;Ljava/lang/String;Ljava/io/File;)V
    .locals 11
    .param p1, "assetManager"    # Landroid/content/res/AssetManager;
    .param p2, "assetPath"    # Ljava/lang/String;
    .param p3, "destFile"    # Ljava/io/File;

    .line 248
    const-string v0, "Failed to close streams: "

    const-string v1, "RokidRFMVad"

    const/4 v2, 0x0

    .line 249
    .local v2, "inputStream":Ljava/io/InputStream;
    const/4 v3, 0x0

    .line 250
    .local v3, "outputStream":Ljava/io/FileOutputStream;
    nop

    .line 251
    const/4 v4, 0x0

    :try_start_0
    invoke-virtual {p1, p2}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v5

    move-object v2, v5

    .line 252
    invoke-virtual {p3}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v5

    .line 253
    .local v5, "parentDir":Ljava/io/File;
    if-eqz v5, :cond_0

    invoke-virtual {v5}, Ljava/io/File;->exists()Z

    move-result v6

    if-nez v6, :cond_0

    .line 254
    invoke-virtual {v5}, Ljava/io/File;->mkdirs()Z

    .line 256
    :cond_0
    new-instance v6, Ljava/io/FileOutputStream;

    invoke-direct {v6, p3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    move-object v3, v6

    .line 257
    const/16 v6, 0x400

    new-array v6, v6, [B

    .line 258
    .local v6, "buffer":[B
    const/4 v7, 0x0

    .line 259
    .local v7, "read":I
    :goto_0
    invoke-virtual {v2, v6}, Ljava/io/InputStream;->read([B)I

    move-result v8

    move v9, v8

    .line 282
    .local v9, "it":I
    const/4 v10, 0x0

    .line 259
    .local v10, "$i$a$-also-RokidRFMVad$copyAssetFile$1":I
    move v7, v9

    .end local v9    # "it":I
    .end local v10    # "$i$a$-also-RokidRFMVad$copyAssetFile$1":I
    const/4 v9, -0x1

    if-eq v8, v9, :cond_1

    .line 260
    invoke-virtual {v3, v6, v4, v7}, Ljava/io/FileOutputStream;->write([BII)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 265
    .end local v5    # "parentDir":Ljava/io/File;
    .end local v6    # "buffer":[B
    .end local v7    # "read":I
    :cond_1
    nop

    .line 266
    if-eqz v2, :cond_2

    :try_start_1
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    goto :goto_1

    .line 268
    :catch_0
    move-exception v5

    goto :goto_2

    .line 267
    :cond_2
    :goto_1
    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_3

    .line 269
    .local v5, "e":Ljava/io/IOException;
    :goto_2
    invoke-virtual {v5}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v6

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {v1, v0, v4}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->eWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 271
    .end local v5    # "e":Ljava/io/IOException;
    :cond_3
    :goto_3
    goto :goto_6

    .line 265
    :catchall_0
    move-exception v5

    goto :goto_7

    .line 262
    :catch_1
    move-exception v5

    .line 263
    .restart local v5    # "e":Ljava/io/IOException;
    :try_start_2
    invoke-virtual {v5}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v6

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Failed to copy asset file "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, ": "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    new-array v7, v4, [Ljava/lang/Object;

    invoke-static {v1, v6, v7}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->eWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 265
    .end local v5    # "e":Ljava/io/IOException;
    nop

    .line 266
    if-eqz v2, :cond_4

    :try_start_3
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    goto :goto_4

    .line 268
    :catch_2
    move-exception v5

    goto :goto_5

    .line 267
    :cond_4
    :goto_4
    if-eqz v3, :cond_3

    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_3

    .line 269
    .restart local v5    # "e":Ljava/io/IOException;
    :goto_5
    invoke-virtual {v5}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v6

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {v1, v0, v4}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->eWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_3

    .line 272
    .end local v5    # "e":Ljava/io/IOException;
    :goto_6
    return-void

    .line 266
    :goto_7
    if-eqz v2, :cond_5

    :try_start_4
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    goto :goto_8

    .line 268
    :catch_3
    move-exception v6

    goto :goto_9

    .line 267
    :cond_5
    :goto_8
    if-eqz v3, :cond_6

    invoke-virtual {v3}, Ljava/io/FileOutputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3

    goto :goto_a

    .line 269
    .local v6, "e":Ljava/io/IOException;
    :goto_9
    invoke-virtual {v6}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v7

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {v1, v0, v4}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->eWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .end local v6    # "e":Ljava/io/IOException;
    :cond_6
    :goto_a
    throw v5
.end method

.method private final copyAssetsRecursively(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)V
    .locals 9
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "assetDir"    # Ljava/lang/String;
    .param p3, "destDir"    # Ljava/io/File;

    .line 222
    invoke-virtual {p1}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v0

    .line 223
    .local v0, "assetManager":Landroid/content/res/AssetManager;
    nop

    .line 224
    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {v0, p2}, Landroid/content/res/AssetManager;->list(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    .line 225
    .local v2, "files":[Ljava/lang/String;
    if-eqz v2, :cond_5

    array-length v3, v2

    const/4 v4, 0x1

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    move v3, v1

    :goto_0
    if-eqz v3, :cond_1

    goto :goto_4

    .line 230
    :cond_1
    invoke-virtual {p3}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_2

    .line 231
    invoke-virtual {p3}, Ljava/io/File;->mkdirs()Z

    .line 233
    :cond_2
    invoke-static {v2}, Lkotlin/jvm/internal/ArrayIteratorKt;->iterator([Ljava/lang/Object;)Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_6

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .line 234
    .local v5, "fileName":Ljava/lang/String;
    move-object v6, p2

    check-cast v6, Ljava/lang/CharSequence;

    invoke-interface {v6}, Ljava/lang/CharSequence;->length()I

    move-result v6

    if-nez v6, :cond_3

    move v6, v4

    goto :goto_2

    :cond_3
    move v6, v1

    :goto_2
    if-eqz v6, :cond_4

    move-object v6, v5

    goto :goto_3

    :cond_4
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "/"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 235
    .local v6, "subAssetPath":Ljava/lang/String;
    :goto_3
    new-instance v7, Ljava/io/File;

    invoke-direct {v7, p3, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 236
    .local v7, "subDestPath":Ljava/io/File;
    const-string/jumbo v8, "subAssetPath"

    invoke-static {v6, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {p0, p1, v6, v7}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->copyAssetsRecursively(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)V

    .end local v5    # "fileName":Ljava/lang/String;
    .end local v6    # "subAssetPath":Ljava/lang/String;
    .end local v7    # "subDestPath":Ljava/io/File;
    goto :goto_1

    .line 227
    :cond_5
    :goto_4
    const-string v3, "assetManager"

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {p0, v0, p2, p3}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->copyAssetFile(Landroid/content/res/AssetManager;Ljava/lang/String;Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_5

    .line 239
    .end local v2    # "files":[Ljava/lang/String;
    :catch_0
    move-exception v2

    .line 240
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Failed to copy assets: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-array v1, v1, [Ljava/lang/Object;

    const-string v4, "RokidRFMVad"

    invoke-static {v4, v3, v1}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->eWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 242
    .end local v2    # "e":Ljava/io/IOException;
    :cond_6
    :goto_5
    return-void
.end method

.method public static synthetic create$default(Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;Landroid/content/Context;Ljava/lang/String;ILjava/lang/String;ILjava/lang/Object;)Z
    .locals 0

    .line 126
    and-int/lit8 p6, p5, 0x4

    if-eqz p6, :cond_0

    const/16 p3, 0x9c4

    :cond_0
    and-int/lit8 p5, p5, 0x8

    if-eqz p5, :cond_1

    const-string p4, "Android"

    :cond_1
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->create(Landroid/content/Context;Ljava/lang/String;ILjava/lang/String;)Z

    move-result p0

    return p0
.end method

.method public static final isSupported()Z
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    .line 37
    sget-boolean v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeLibraryLoaded:Z

    return v0
.end method

.method private final native nativeCreate(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)J
.end method

.method private final native nativeDelete(J)V
.end method

.method private final native nativeFeed(JLjava/lang/String;Ljava/lang/String;)Z
.end method

.method private final native nativeStart(JLjava/lang/String;Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadCallback;)Z
.end method

.method private final native nativeStop(JLjava/lang/String;)Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadFinalResult;
.end method


# virtual methods
.method public final create(Landroid/content/Context;Ljava/lang/String;ILjava/lang/String;)Z
    .locals 10
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "deviceId"    # Ljava/lang/String;
    .param p3, "timeoutMs"    # I
    .param p4, "terminalType"    # Ljava/lang/String;

    const-string v0, "rfmvad"

    const-string v1, "context"

    invoke-static {p1, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v1, "deviceId"

    invoke-static {p2, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v1, "terminalType"

    invoke-static {p4, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 127
    sget-boolean v1, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeLibraryLoaded:Z

    const-string v2, "RokidRFMVad"

    const/4 v3, 0x0

    if-nez v1, :cond_0

    .line 128
    const-string v0, "Skipping VAD initialization on an unsupported ABI"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-static {v2, v0, v1}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->wWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 129
    return v3

    .line 131
    :cond_0
    sget-wide v4, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeHandle:J

    const-wide/16 v6, 0x0

    cmp-long v1, v4, v6

    const/4 v4, 0x1

    if-eqz v1, :cond_1

    .line 132
    const-string v0, "VAD engine already created, skipping"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-static {v2, v0, v1}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->wWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 133
    return v4

    .line 136
    :cond_1
    nop

    .line 137
    :try_start_0
    sget-wide v8, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeHandle:J

    cmp-long v1, v8, v6

    if-eqz v1, :cond_2

    .line 138
    return v3

    .line 140
    :cond_2
    new-instance v1, Ljava/io/File;

    const/4 v5, 0x0

    invoke-virtual {p1, v5}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v5

    invoke-direct {v1, v5, v0}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 141
    .local v1, "destDir":Ljava/io/File;
    invoke-direct {p0, p1, v0, v1}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->copyAssetsRecursively(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)V

    .line 142
    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    const-string v5, "destDir.getAbsolutePath()"

    invoke-static {v0, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {p0, v0, p2, p3, p4}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeCreate(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;)J

    move-result-wide v8

    sput-wide v8, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeHandle:J

    .line 143
    sget-wide v8, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeHandle:J

    cmp-long v0, v8, v6

    if-eqz v0, :cond_3

    goto :goto_0

    :cond_3
    move v4, v3

    :goto_0
    move v0, v4

    .line 145
    .local v0, "success":Z
    if-eqz v0, :cond_4

    const-string/jumbo v4, "success"

    goto :goto_1

    :cond_4
    const-string v4, "failed"

    :goto_1
    sget-wide v5, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeHandle:J

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "VAD engine create "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v7, ", handle="

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", config="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", timeout="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "ms"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-array v5, v3, [Ljava/lang/Object;

    invoke-static {v2, v4, v5}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->dWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 146
    return v0

    .line 147
    .end local v0    # "success":Z
    .end local v1    # "destDir":Ljava/io/File;
    :catch_0
    move-exception v0

    .line 148
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v1

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Failed to create VAD engine: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-array v4, v3, [Ljava/lang/Object;

    invoke-static {v2, v1, v4}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->eWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 149
    return v3
.end method

.method public final feed(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 6
    .param p1, "text"    # Ljava/lang/String;
    .param p2, "traceId"    # Ljava/lang/String;

    const-string/jumbo v0, "text"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "traceId"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 177
    sget-wide v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeHandle:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    const-string v1, "RokidRFMVad"

    const/4 v2, 0x0

    if-nez v0, :cond_0

    .line 178
    const-string v0, "VAD engine not created, call create() first"

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v1, v0, v3}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->eWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 179
    return v2

    .line 182
    :cond_0
    sget-wide v3, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeHandle:J

    invoke-direct {p0, v3, v4, p1, p2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeFeed(JLjava/lang/String;Ljava/lang/String;)Z

    move-result v0

    .line 183
    .local v0, "success":Z
    if-eqz v0, :cond_1

    const-string/jumbo v3, "success"

    goto :goto_0

    :cond_1
    const-string v3, "failed"

    :goto_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "VAD feed "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", text=\'"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "\', traceId="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v1, v3, v2}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->dWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 184
    return v0
.end method

.method public final release()V
    .locals 4

    .line 211
    sget-wide v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeHandle:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    .line 212
    sget-wide v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeHandle:J

    invoke-direct {p0, v0, v1}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeDelete(J)V

    .line 213
    sput-wide v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeHandle:J

    .line 214
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, "RokidRFMVad"

    const-string v2, "VAD engine released"

    invoke-static {v1, v2, v0}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->dWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 216
    :cond_0
    return-void
.end method

.method public final start(Ljava/lang/String;Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadCallback;)Z
    .locals 6
    .param p1, "traceId"    # Ljava/lang/String;
    .param p2, "callback"    # Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadCallback;

    const-string/jumbo v0, "traceId"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "callback"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 160
    sget-wide v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeHandle:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    const-string v1, "RokidRFMVad"

    const/4 v2, 0x0

    if-nez v0, :cond_0

    .line 161
    const-string v0, "VAD engine not created, call create() first"

    new-array v3, v2, [Ljava/lang/Object;

    invoke-static {v1, v0, v3}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->eWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 162
    return v2

    .line 165
    :cond_0
    sget-wide v3, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeHandle:J

    invoke-direct {p0, v3, v4, p1, p2}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeStart(JLjava/lang/String;Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadCallback;)Z

    move-result v0

    .line 166
    .local v0, "success":Z
    if-eqz v0, :cond_1

    const-string/jumbo v3, "success"

    goto :goto_0

    :cond_1
    const-string v3, "failed"

    :goto_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "VAD start "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", traceId="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v1, v3, v2}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->dWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 167
    return v0
.end method

.method public final stop(Ljava/lang/String;)Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadFinalResult;
    .locals 5
    .param p1, "traceId"    # Ljava/lang/String;

    const-string/jumbo v0, "traceId"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 193
    sget-wide v0, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeHandle:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    const/4 v1, 0x0

    const-string v2, "RokidRFMVad"

    if-nez v0, :cond_0

    .line 194
    const-string v0, "VAD engine not created, call create() first"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v2, v0, v1}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->eWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 195
    const/4 v0, 0x0

    return-object v0

    .line 198
    :cond_0
    sget-wide v3, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeHandle:J

    invoke-direct {p0, v3, v4, p1}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad;->nativeStop(JLjava/lang/String;)Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadFinalResult;

    move-result-object v0

    .line 199
    .local v0, "result":Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadFinalResult;
    if-eqz v0, :cond_1

    .line 200
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "VAD stop success, traceId="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ", result="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v2, v3, v1}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->dWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    .line 202
    :cond_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "VAD stop failed, traceId="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v2, v3, v1}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->eWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 204
    :goto_0
    return-object v0
.end method
