.class public final Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;
.super Ljava/lang/Object;
.source "PcmAudioRecorder.kt"

# interfaces
.implements Ljava/lang/AutoCloseable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder$Companion;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00008\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0007\n\u0002\u0010\u0012\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0003\u0018\u0000 \u001b2\u00020\u0001:\u0001\u001bB\u0005\u00a2\u0006\u0002\u0010\u0002J\u0008\u0010\u000e\u001a\u00020\u000fH\u0016J\u0008\u0010\u0010\u001a\u00020\u000fH\u0002J\u0008\u0010\u0011\u001a\u00020\u0004H\u0002J\u0008\u0010\u0012\u001a\u0004\u0018\u00010\u0004J\u0006\u0010\t\u001a\u00020\nJ\u0006\u0010\u0013\u001a\u00020\nJ\u0006\u0010\u0014\u001a\u00020\nJ\"\u0010\u0015\u001a\u00020\n2\u0006\u0010\u0016\u001a\u00020\u00172\u0008\u0008\u0002\u0010\u0018\u001a\u00020\u00192\u0008\u0008\u0002\u0010\u001a\u001a\u00020\u0019R\u001b\u0010\u0003\u001a\u00020\u00048BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u0007\u0010\u0008\u001a\u0004\u0008\u0005\u0010\u0006R\u000e\u0010\t\u001a\u00020\nX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000b\u001a\u0004\u0018\u00010\u000cX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\r\u001a\u0004\u0018\u00010\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u001c"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;",
        "Ljava/lang/AutoCloseable;",
        "()V",
        "baseDir",
        "Ljava/io/File;",
        "getBaseDir",
        "()Ljava/io/File;",
        "baseDir$delegate",
        "Lkotlin/Lazy;",
        "isRecording",
        "",
        "outputStream",
        "Ljava/io/FileOutputStream;",
        "pcmFile",
        "close",
        "",
        "closeResources",
        "createBaseDirectory",
        "getPcmFile",
        "startRecording",
        "stopRecording",
        "writePcmData",
        "data",
        "",
        "offset",
        "",
        "length",
        "Companion",
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
.field public static final Companion:Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder$Companion;

.field private static final DEFAULT_DIR_NAME:Ljava/lang/String; = "pcm_audio"

.field private static final FILE_EXTENSION:Ljava/lang/String; = ".pcm"

.field private static final FILE_PREFIX:Ljava/lang/String; = "audio_"


# instance fields
.field private final baseDir$delegate:Lkotlin/Lazy;

.field private isRecording:Z

.field private outputStream:Ljava/io/FileOutputStream;

.field private pcmFile:Ljava/io/File;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->Companion:Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder$Companion;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 25
    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder$baseDir$2;

    invoke-direct {v0, p0}, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder$baseDir$2;-><init>(Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;)V

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->baseDir$delegate:Lkotlin/Lazy;

    .line 15
    return-void
.end method

.method public static final synthetic access$createBaseDirectory(Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;)Ljava/io/File;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;

    .line 15
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->createBaseDirectory()Ljava/io/File;

    move-result-object v0

    return-object v0
.end method

.method private final closeResources()V
    .locals 7

    .line 146
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->outputStream:Ljava/io/FileOutputStream;

    if-eqz v0, :cond_0

    .local v0, "stream":Ljava/io/FileOutputStream;
    const/4 v1, 0x0

    .line 147
    .local v1, "$i$a$-let-PcmAudioRecorder$closeResources$1":I
    nop

    .line 148
    const/4 v2, 0x0

    :try_start_0
    invoke-virtual {v0}, Ljava/io/FileOutputStream;->flush()V

    .line 149
    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 154
    :goto_0
    iput-object v2, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->outputStream:Ljava/io/FileOutputStream;

    .line 155
    goto :goto_1

    .line 154
    :catchall_0
    move-exception v3

    goto :goto_2

    .line 150
    :catch_0
    move-exception v3

    .line 151
    .local v3, "e":Ljava/io/IOException;
    :try_start_1
    sget-object v4, Ljava/lang/System;->err:Ljava/io/PrintStream;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "\u5173\u95ed\u8f93\u51fa\u6d41\u5931\u8d25: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v3}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 152
    invoke-virtual {v3}, Ljava/io/IOException;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .end local v3    # "e":Ljava/io/IOException;
    goto :goto_0

    .line 156
    :goto_1
    nop

    .line 146
    .end local v0    # "stream":Ljava/io/FileOutputStream;
    .end local v1    # "$i$a$-let-PcmAudioRecorder$closeResources$1":I
    goto :goto_3

    .line 154
    .restart local v0    # "stream":Ljava/io/FileOutputStream;
    .restart local v1    # "$i$a$-let-PcmAudioRecorder$closeResources$1":I
    :goto_2
    iput-object v2, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->outputStream:Ljava/io/FileOutputStream;

    throw v3

    .line 157
    .end local v0    # "stream":Ljava/io/FileOutputStream;
    .end local v1    # "$i$a$-let-PcmAudioRecorder$closeResources$1":I
    :cond_0
    :goto_3
    return-void
.end method

.method private final createBaseDirectory()Ljava/io/File;
    .locals 9

    .line 31
    const-string v0, "java.io.tmpdir"

    const-string v1, "pcm_audio"

    .line 32
    :try_start_0
    const-string v2, "android.content.Context"

    invoke-static {v2}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    .line 33
    .local v2, "contextClass":Ljava/lang/Class;
    const-string v3, "android.app.Application"

    invoke-static {v3}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v3

    .line 34
    .local v3, "applicationClass":Ljava/lang/Class;
    const-string v4, "getApplication"

    const/4 v5, 0x0

    new-array v6, v5, [Ljava/lang/Class;

    invoke-virtual {v3, v4, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    .line 35
    .local v4, "getApplicationMethod":Ljava/lang/reflect/Method;
    new-array v6, v5, [Ljava/lang/Object;

    const/4 v7, 0x0

    invoke-virtual {v4, v7, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    .line 37
    .local v6, "application":Ljava/lang/Object;
    if-eqz v6, :cond_0

    .line 38
    const-string v7, "getCacheDir"

    new-array v8, v5, [Ljava/lang/Class;

    invoke-virtual {v2, v7, v8}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    .line 39
    .local v7, "getCacheDirMethod":Ljava/lang/reflect/Method;
    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v7, v6, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    const-string v8, "null cannot be cast to non-null type java.io.File"

    invoke-static {v5, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v5, Ljava/io/File;

    .line 40
    .local v5, "cacheDir":Ljava/io/File;
    new-instance v8, Ljava/io/File;

    invoke-direct {v8, v5, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .end local v5    # "cacheDir":Ljava/io/File;
    .end local v7    # "getCacheDirMethod":Ljava/lang/reflect/Method;
    goto :goto_0

    .line 42
    :cond_0
    new-instance v8, Ljava/io/File;

    invoke-static {v0}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v8, v5, v1}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v2    # "contextClass":Ljava/lang/Class;
    .end local v3    # "applicationClass":Ljava/lang/Class;
    .end local v4    # "getApplicationMethod":Ljava/lang/reflect/Method;
    .end local v6    # "application":Ljava/lang/Object;
    :goto_0
    goto :goto_1

    .line 44
    :catch_0
    move-exception v2

    .line 45
    .local v2, "e":Ljava/lang/Exception;
    new-instance v8, Ljava/io/File;

    invoke-static {v0}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {v8, v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 31
    .end local v2    # "e":Ljava/lang/Exception;
    :goto_1
    return-object v8
.end method

.method private final getBaseDir()Ljava/io/File;
    .locals 1

    .line 25
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->baseDir$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/File;

    return-object v0
.end method

.method public static synthetic writePcmData$default(Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;[BIIILjava/lang/Object;)Z
    .locals 0

    .line 98
    and-int/lit8 p5, p4, 0x2

    if-eqz p5, :cond_0

    const/4 p2, 0x0

    :cond_0
    and-int/lit8 p4, p4, 0x4

    if-eqz p4, :cond_1

    array-length p3, p1

    :cond_1
    invoke-virtual {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->writePcmData([BII)Z

    move-result p0

    return p0
.end method


# virtual methods
.method public close()V
    .locals 0

    .line 139
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->stopRecording()Z

    .line 140
    return-void
.end method

.method public final getPcmFile()Ljava/io/File;
    .locals 1

    .line 167
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->pcmFile:Ljava/io/File;

    return-object v0
.end method

.method public final isRecording()Z
    .locals 1

    .line 162
    iget-boolean v0, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->isRecording:Z

    return v0
.end method

.method public final declared-synchronized startRecording()Z
    .locals 7

    monitor-enter p0

    .line 55
    :try_start_0
    iget-boolean v0, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->isRecording:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 56
    sget-object v0, Ljava/lang/System;->err:Ljava/io/PrintStream;

    const-string/jumbo v2, "\u5df2\u7ecf\u5728\u5f55\u5236\u4e2d\uff0c\u65e0\u6cd5\u91cd\u590d\u5f00\u59cb"

    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 57
    monitor-exit p0

    return v1

    .line 60
    .end local p0    # "this":Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;
    :cond_0
    nop

    .line 61
    :try_start_1
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->getBaseDir()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_1

    .line 62
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->getBaseDir()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    move-result v0

    if-nez v0, :cond_1

    .line 63
    sget-object v0, Ljava/lang/System;->err:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "\u65e0\u6cd5\u521b\u5efa\u76ee\u5f55: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->getBaseDir()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 64
    monitor-exit p0

    return v1

    .line 68
    :cond_1
    :try_start_2
    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string/jumbo v2, "yyyyMMdd_HHmmss"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v3

    invoke-direct {v0, v2, v3}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v2, Ljava/util/Date;

    invoke-direct {v2}, Ljava/util/Date;-><init>()V

    invoke-virtual {v0, v2}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    .line 69
    .local v0, "timestamp":Ljava/lang/String;
    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "randomUUID().toString()"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v3, 0x8

    invoke-static {v2, v3}, Lkotlin/text/StringsKt;->take(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v2

    .line 70
    .local v2, "uuidPart":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "audio_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ".pcm"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 71
    .local v3, "fileName":Ljava/lang/String;
    new-instance v4, Ljava/io/File;

    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->getBaseDir()Ljava/io/File;

    move-result-object v5

    invoke-direct {v4, v5, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    iput-object v4, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->pcmFile:Ljava/io/File;

    .line 73
    iget-object v4, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->pcmFile:Ljava/io/File;

    invoke-static {v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v4}, Ljava/io/File;->createNewFile()Z

    move-result v4

    if-nez v4, :cond_2

    .line 74
    sget-object v4, Ljava/lang/System;->err:Ljava/io/PrintStream;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "\u65e0\u6cd5\u521b\u5efa\u6587\u4ef6: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->pcmFile:Ljava/io/File;

    invoke-static {v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v6}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 75
    monitor-exit p0

    return v1

    .line 78
    :cond_2
    :try_start_3
    new-instance v4, Ljava/io/FileOutputStream;

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->pcmFile:Ljava/io/File;

    invoke-direct {v4, v5}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    iput-object v4, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->outputStream:Ljava/io/FileOutputStream;

    .line 79
    const/4 v4, 0x1

    iput-boolean v4, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->isRecording:Z

    .line 80
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "\u5f00\u59cb\u5f55\u5236 PCM \u97f3\u9891: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->pcmFile:Ljava/io/File;

    invoke-static {v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v6}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    sget-object v6, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v6, v5}, Ljava/io/PrintStream;->println(Ljava/lang/Object;)V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 81
    nop

    .end local v0    # "timestamp":Ljava/lang/String;
    .end local v2    # "uuidPart":Ljava/lang/String;
    .end local v3    # "fileName":Ljava/lang/String;
    move v1, v4

    goto :goto_0

    .line 82
    :catch_0
    move-exception v0

    .line 83
    .local v0, "e":Ljava/io/IOException;
    :try_start_4
    sget-object v2, Ljava/lang/System;->err:Ljava/io/PrintStream;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u5f00\u59cb\u5f55\u5236\u5931\u8d25: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 84
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 85
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->closeResources()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 86
    nop

    .line 60
    .end local v0    # "e":Ljava/io/IOException;
    :goto_0
    monitor-exit p0

    return v1

    .line 54
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized stopRecording()Z
    .locals 4

    monitor-enter p0

    .line 121
    :try_start_0
    iget-boolean v0, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->isRecording:Z

    const/4 v1, 0x1

    if-nez v0, :cond_0

    .line 122
    const-string/jumbo v0, "\u672a\u5728\u5f55\u5236\u72b6\u6001\uff0c\u65e0\u9700\u505c\u6b62"

    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v2, v0}, Ljava/io/PrintStream;->println(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 123
    monitor-exit p0

    return v1

    .line 126
    .end local p0    # "this":Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;
    :cond_0
    nop

    .line 127
    const/4 v0, 0x0

    :try_start_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "\u7ed3\u675f\u5f55\u5236 PCM \u97f3\u9891: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->pcmFile:Ljava/io/File;

    if-eqz v3, :cond_1

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    goto :goto_0

    :cond_1
    const/4 v3, 0x0

    :goto_0
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    sget-object v3, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v3, v2}, Ljava/io/PrintStream;->println(Ljava/lang/Object;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 128
    nop

    .line 130
    :try_start_2
    iput-boolean v0, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->isRecording:Z

    .line 131
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->closeResources()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 132
    nop

    .line 126
    monitor-exit p0

    return v1

    .line 130
    :catchall_0
    move-exception v1

    :try_start_3
    iput-boolean v0, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->isRecording:Z

    .line 131
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->closeResources()V

    throw v1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 120
    :catchall_1
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized writePcmData([BII)Z
    .locals 5
    .param p1, "data"    # [B
    .param p2, "offset"    # I
    .param p3, "length"    # I

    monitor-enter p0

    :try_start_0
    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 99
    iget-boolean v0, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->isRecording:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->outputStream:Ljava/io/FileOutputStream;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_0

    goto :goto_1

    .line 104
    :cond_0
    nop

    .line 105
    :try_start_1
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->outputStream:Ljava/io/FileOutputStream;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    invoke-virtual {v0, p1, p2, p3}, Ljava/io/FileOutputStream;->write([BII)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 106
    const/4 v1, 0x1

    goto :goto_0

    .line 107
    .end local p0    # "this":Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;
    :catch_0
    move-exception v0

    .line 108
    .local v0, "e":Ljava/io/IOException;
    :try_start_2
    sget-object v2, Ljava/lang/System;->err:Ljava/io/PrintStream;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u5199\u5165 PCM \u6570\u636e\u5931\u8d25: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v0}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 109
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 110
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/base/utils/other/PcmAudioRecorder;->closeResources()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 111
    nop

    .line 104
    .end local v0    # "e":Ljava/io/IOException;
    :goto_0
    monitor-exit p0

    return v1

    .line 100
    :cond_1
    :goto_1
    :try_start_3
    sget-object v0, Ljava/lang/System;->err:Ljava/io/PrintStream;

    const-string/jumbo v2, "\u672a\u5728\u5f55\u5236\u72b6\u6001\uff0c\u65e0\u6cd5\u5199\u5165\u6570\u636e"

    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 101
    monitor-exit p0

    return v1

    .line 98
    .end local p1    # "data":[B
    .end local p2    # "offset":I
    .end local p3    # "length":I
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method
