.class public Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;
.super Ljava/lang/Object;
.source "SevenZFile.java"

# interfaces
.implements Ljava/io/Closeable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;
    }
.end annotation


# static fields
.field private static final DEFAULT_FILE_NAME:Ljava/lang/String; = "unknown archive"

.field private static final PASSWORD_ENCODER:Ljava/nio/charset/CharsetEncoder;

.field static final SIGNATURE_HEADER_SIZE:I = 0x20

.field static final sevenZSignature:[B


# instance fields
.field private final archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

.field private channel:Ljava/nio/channels/SeekableByteChannel;

.field private compressedBytesReadFromCurrentEntry:J

.field private currentEntryIndex:I

.field private currentFolderIndex:I

.field private currentFolderInputStream:Ljava/io/InputStream;

.field private final deferredBlockStreams:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/io/InputStream;",
            ">;"
        }
    .end annotation
.end field

.field private final fileName:Ljava/lang/String;

.field private final options:Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;

.field private password:[B

.field private uncompressedBytesReadFromCurrentEntry:J


# direct methods
.method public static synthetic $r8$lambda$cOGEan9qYZ2WnG4ze1FuzNShUbE(Ljava/lang/Integer;)J
    .locals 2

    invoke-virtual {p0}, Ljava/lang/Integer;->longValue()J

    move-result-wide v0

    return-wide v0
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 109
    const/4 v0, 0x6

    new-array v0, v0, [B

    fill-array-data v0, :array_0

    sput-object v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->sevenZSignature:[B

    .line 2059
    sget-object v0, Ljava/nio/charset/StandardCharsets;->UTF_16LE:Ljava/nio/charset/Charset;

    invoke-virtual {v0}, Ljava/nio/charset/Charset;->newEncoder()Ljava/nio/charset/CharsetEncoder;

    move-result-object v0

    sput-object v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->PASSWORD_ENCODER:Ljava/nio/charset/CharsetEncoder;

    return-void

    nop

    :array_0
    .array-data 1
        0x37t
        0x7at
        -0x44t
        -0x51t
        0x27t
        0x1ct
    .end array-data
.end method

.method public constructor <init>(Ljava/io/File;)V
    .locals 1
    .param p1, "fileName"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 364
    sget-object v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;->DEFAULT:Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;

    invoke-direct {p0, p1, v0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;-><init>(Ljava/io/File;Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;)V

    .line 365
    return-void
.end method

.method public constructor <init>(Ljava/io/File;Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;)V
    .locals 1
    .param p1, "fileName"    # Ljava/io/File;
    .param p2, "options"    # Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 376
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0, p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;-><init>(Ljava/io/File;[CLorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;)V

    .line 377
    return-void
.end method

.method public constructor <init>(Ljava/io/File;[B)V
    .locals 9
    .param p1, "fileName"    # Ljava/io/File;
    .param p2, "password"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 151
    invoke-virtual {p1}, Ljava/io/File;->toPath()Ljava/nio/file/Path;

    move-result-object v0

    sget-object v1, Ljava/nio/file/StandardOpenOption;->READ:Ljava/nio/file/StandardOpenOption;

    invoke-static {v1}, Ljava/util/EnumSet;->of(Ljava/lang/Enum;)Ljava/util/EnumSet;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/nio/file/attribute/FileAttribute;

    invoke-static {v0, v1, v2}, Ljava/nio/file/Files;->newByteChannel(Ljava/nio/file/Path;Ljava/util/Set;[Ljava/nio/file/attribute/FileAttribute;)Ljava/nio/channels/SeekableByteChannel;

    move-result-object v4

    .line 152
    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5

    sget-object v8, Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;->DEFAULT:Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;

    .line 151
    const/4 v7, 0x1

    move-object v3, p0

    move-object v6, p2

    invoke-direct/range {v3 .. v8}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;-><init>(Ljava/nio/channels/SeekableByteChannel;Ljava/lang/String;[BZLorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;)V

    .line 153
    return-void
.end method

.method public constructor <init>(Ljava/io/File;[C)V
    .locals 1
    .param p1, "fileName"    # Ljava/io/File;
    .param p2, "password"    # [C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 122
    sget-object v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;->DEFAULT:Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;

    invoke-direct {p0, p1, p2, v0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;-><init>(Ljava/io/File;[CLorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;)V

    .line 123
    return-void
.end method

.method public constructor <init>(Ljava/io/File;[CLorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;)V
    .locals 9
    .param p1, "fileName"    # Ljava/io/File;
    .param p2, "password"    # [C
    .param p3, "options"    # Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 135
    invoke-virtual {p1}, Ljava/io/File;->toPath()Ljava/nio/file/Path;

    move-result-object v0

    sget-object v1, Ljava/nio/file/StandardOpenOption;->READ:Ljava/nio/file/StandardOpenOption;

    invoke-static {v1}, Ljava/util/EnumSet;->of(Ljava/lang/Enum;)Ljava/util/EnumSet;

    move-result-object v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/nio/file/attribute/FileAttribute;

    invoke-static {v0, v1, v2}, Ljava/nio/file/Files;->newByteChannel(Ljava/nio/file/Path;Ljava/util/Set;[Ljava/nio/file/attribute/FileAttribute;)Ljava/nio/channels/SeekableByteChannel;

    move-result-object v4

    .line 136
    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5

    invoke-static {p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->utf16Decode([C)[B

    move-result-object v6

    .line 135
    const/4 v7, 0x1

    move-object v3, p0

    move-object v8, p3

    invoke-direct/range {v3 .. v8}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;-><init>(Ljava/nio/channels/SeekableByteChannel;Ljava/lang/String;[BZLorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;)V

    .line 137
    return-void
.end method

.method public constructor <init>(Ljava/nio/channels/SeekableByteChannel;)V
    .locals 1
    .param p1, "channel"    # Ljava/nio/channels/SeekableByteChannel;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 167
    sget-object v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;->DEFAULT:Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;

    invoke-direct {p0, p1, v0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;-><init>(Ljava/nio/channels/SeekableByteChannel;Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;)V

    .line 168
    return-void
.end method

.method public constructor <init>(Ljava/nio/channels/SeekableByteChannel;Ljava/lang/String;)V
    .locals 1
    .param p1, "channel"    # Ljava/nio/channels/SeekableByteChannel;
    .param p2, "fileName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 272
    sget-object v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;->DEFAULT:Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;

    invoke-direct {p0, p1, p2, v0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;-><init>(Ljava/nio/channels/SeekableByteChannel;Ljava/lang/String;Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;)V

    .line 273
    return-void
.end method

.method public constructor <init>(Ljava/nio/channels/SeekableByteChannel;Ljava/lang/String;Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;)V
    .locals 6
    .param p1, "channel"    # Ljava/nio/channels/SeekableByteChannel;
    .param p2, "fileName"    # Ljava/lang/String;
    .param p3, "options"    # Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 290
    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;-><init>(Ljava/nio/channels/SeekableByteChannel;Ljava/lang/String;[BZLorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;)V

    .line 291
    return-void
.end method

.method public constructor <init>(Ljava/nio/channels/SeekableByteChannel;Ljava/lang/String;[B)V
    .locals 6
    .param p1, "channel"    # Ljava/nio/channels/SeekableByteChannel;
    .param p2, "fileName"    # Ljava/lang/String;
    .param p3, "password"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 333
    const/4 v4, 0x0

    sget-object v5, Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;->DEFAULT:Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    invoke-direct/range {v0 .. v5}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;-><init>(Ljava/nio/channels/SeekableByteChannel;Ljava/lang/String;[BZLorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;)V

    .line 334
    return-void
.end method

.method private constructor <init>(Ljava/nio/channels/SeekableByteChannel;Ljava/lang/String;[BZLorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;)V
    .locals 3
    .param p1, "channel"    # Ljava/nio/channels/SeekableByteChannel;
    .param p2, "filename"    # Ljava/lang/String;
    .param p3, "password"    # [B
    .param p4, "closeOnError"    # Z
    .param p5, "options"    # Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 337
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 97
    const/4 v0, -0x1

    iput v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentEntryIndex:I

    .line 98
    iput v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentFolderIndex:I

    .line 106
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->deferredBlockStreams:Ljava/util/ArrayList;

    .line 338
    const/4 v0, 0x0

    .line 339
    .local v0, "succeeded":Z
    iput-object p1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    .line 340
    iput-object p2, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->fileName:Ljava/lang/String;

    .line 341
    iput-object p5, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->options:Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;

    .line 343
    :try_start_0
    invoke-direct {p0, p3}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readHeaders([B)Lorg/apache/commons/compress/archivers/sevenz/Archive;

    move-result-object v1

    iput-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    .line 344
    if-eqz p3, :cond_0

    .line 345
    array-length v1, p3

    invoke-static {p3, v1}, Ljava/util/Arrays;->copyOf([BI)[B

    move-result-object v1

    iput-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->password:[B

    goto :goto_0

    .line 347
    :cond_0
    const/4 v1, 0x0

    iput-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->password:[B
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 349
    :goto_0
    const/4 v0, 0x1

    .line 351
    if-nez v0, :cond_1

    if-eqz p4, :cond_1

    .line 352
    iget-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    invoke-interface {v1}, Ljava/nio/channels/SeekableByteChannel;->close()V

    .line 355
    :cond_1
    return-void

    .line 351
    :catchall_0
    move-exception v1

    if-nez v0, :cond_2

    if-eqz p4, :cond_2

    .line 352
    iget-object v2, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    invoke-interface {v2}, Ljava/nio/channels/SeekableByteChannel;->close()V

    .line 354
    :cond_2
    throw v1
.end method

.method public constructor <init>(Ljava/nio/channels/SeekableByteChannel;Ljava/lang/String;[C)V
    .locals 1
    .param p1, "channel"    # Ljava/nio/channels/SeekableByteChannel;
    .param p2, "fileName"    # Ljava/lang/String;
    .param p3, "password"    # [C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 236
    sget-object v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;->DEFAULT:Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;

    invoke-direct {p0, p1, p2, p3, v0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;-><init>(Ljava/nio/channels/SeekableByteChannel;Ljava/lang/String;[CLorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;)V

    .line 237
    return-void
.end method

.method public constructor <init>(Ljava/nio/channels/SeekableByteChannel;Ljava/lang/String;[CLorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;)V
    .locals 6
    .param p1, "channel"    # Ljava/nio/channels/SeekableByteChannel;
    .param p2, "fileName"    # Ljava/lang/String;
    .param p3, "password"    # [C
    .param p4, "options"    # Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 255
    invoke-static {p3}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->utf16Decode([C)[B

    move-result-object v3

    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v5, p4

    invoke-direct/range {v0 .. v5}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;-><init>(Ljava/nio/channels/SeekableByteChannel;Ljava/lang/String;[BZLorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;)V

    .line 256
    return-void
.end method

.method public constructor <init>(Ljava/nio/channels/SeekableByteChannel;Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;)V
    .locals 2
    .param p1, "channel"    # Ljava/nio/channels/SeekableByteChannel;
    .param p2, "options"    # Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 183
    const-string/jumbo v0, "unknown archive"

    const/4 v1, 0x0

    invoke-direct {p0, p1, v0, v1, p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;-><init>(Ljava/nio/channels/SeekableByteChannel;Ljava/lang/String;[CLorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;)V

    .line 184
    return-void
.end method

.method public constructor <init>(Ljava/nio/channels/SeekableByteChannel;[B)V
    .locals 1
    .param p1, "channel"    # Ljava/nio/channels/SeekableByteChannel;
    .param p2, "password"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 311
    const-string/jumbo v0, "unknown archive"

    invoke-direct {p0, p1, v0, p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;-><init>(Ljava/nio/channels/SeekableByteChannel;Ljava/lang/String;[B)V

    .line 312
    return-void
.end method

.method public constructor <init>(Ljava/nio/channels/SeekableByteChannel;[C)V
    .locals 1
    .param p1, "channel"    # Ljava/nio/channels/SeekableByteChannel;
    .param p2, "password"    # [C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 200
    sget-object v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;->DEFAULT:Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;

    invoke-direct {p0, p1, p2, v0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;-><init>(Ljava/nio/channels/SeekableByteChannel;[CLorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;)V

    .line 201
    return-void
.end method

.method public constructor <init>(Ljava/nio/channels/SeekableByteChannel;[CLorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;)V
    .locals 1
    .param p1, "channel"    # Ljava/nio/channels/SeekableByteChannel;
    .param p2, "password"    # [C
    .param p3, "options"    # Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 218
    const-string/jumbo v0, "unknown archive"

    invoke-direct {p0, p1, v0, p2, p3}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;-><init>(Ljava/nio/channels/SeekableByteChannel;Ljava/lang/String;[CLorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;)V

    .line 219
    return-void
.end method

.method static synthetic access$1000(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;)J
    .locals 2
    .param p0, "x0"    # Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;

    .line 89
    iget-wide v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->compressedBytesReadFromCurrentEntry:J

    return-wide v0
.end method

.method static synthetic access$1002(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;J)J
    .locals 0
    .param p0, "x0"    # Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;
    .param p1, "x1"    # J

    .line 89
    iput-wide p1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->compressedBytesReadFromCurrentEntry:J

    return-wide p1
.end method

.method static synthetic access$1100(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;)J
    .locals 2
    .param p0, "x0"    # Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;

    .line 89
    iget-wide v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->uncompressedBytesReadFromCurrentEntry:J

    return-wide v0
.end method

.method private static assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I
    .locals 3
    .param p0, "what"    # Ljava/lang/String;
    .param p1, "value"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2075
    const-wide/32 v0, 0x7fffffff

    cmp-long v0, p1, v0

    if-gtz v0, :cond_0

    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-ltz v0, :cond_0

    .line 2078
    long-to-int v0, p1

    return v0

    .line 2076
    :cond_0
    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Cannot handle "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1, p2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private buildDecoderStack(Lorg/apache/commons/compress/archivers/sevenz/Folder;JILorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;)Ljava/io/InputStream;
    .locals 16
    .param p1, "folder"    # Lorg/apache/commons/compress/archivers/sevenz/Folder;
    .param p2, "folderOffset"    # J
    .param p4, "firstPackStreamIndex"    # I
    .param p5, "entry"    # Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1762
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    iget-object v2, v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    move-wide/from16 v3, p2

    invoke-interface {v2, v3, v4}, Ljava/nio/channels/SeekableByteChannel;->position(J)Ljava/nio/channels/SeekableByteChannel;

    .line 1763
    new-instance v2, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$1;

    new-instance v5, Ljava/io/BufferedInputStream;

    new-instance v6, Lorg/apache/commons/compress/archivers/sevenz/BoundedSeekableByteChannelInputStream;

    iget-object v7, v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    iget-object v8, v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v8, v8, Lorg/apache/commons/compress/archivers/sevenz/Archive;->packSizes:[J

    aget-wide v9, v8, p4

    invoke-direct {v6, v7, v9, v10}, Lorg/apache/commons/compress/archivers/sevenz/BoundedSeekableByteChannelInputStream;-><init>(Ljava/nio/channels/SeekableByteChannel;J)V

    invoke-direct {v5, v6}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v2, v0, v5}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$1;-><init>(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;Ljava/io/InputStream;)V

    .line 1793
    .local v2, "inputStreamStack":Ljava/io/InputStream;
    new-instance v5, Ljava/util/LinkedList;

    invoke-direct {v5}, Ljava/util/LinkedList;-><init>()V

    .line 1794
    .local v5, "methods":Ljava/util/LinkedList;, "Ljava/util/LinkedList<Lorg/apache/commons/compress/archivers/sevenz/SevenZMethodConfiguration;>;"
    invoke-virtual/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/Folder;->getOrderedCoders()Ljava/lang/Iterable;

    move-result-object v6

    invoke-interface {v6}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_0
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_1

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    move-object v14, v7

    check-cast v14, Lorg/apache/commons/compress/archivers/sevenz/Coder;

    .line 1795
    .local v14, "coder":Lorg/apache/commons/compress/archivers/sevenz/Coder;
    iget-wide v7, v14, Lorg/apache/commons/compress/archivers/sevenz/Coder;->numInStreams:J

    const-wide/16 v9, 0x1

    cmp-long v7, v7, v9

    if-nez v7, :cond_0

    iget-wide v7, v14, Lorg/apache/commons/compress/archivers/sevenz/Coder;->numOutStreams:J

    cmp-long v7, v7, v9

    if-nez v7, :cond_0

    .line 1798
    iget-object v7, v14, Lorg/apache/commons/compress/archivers/sevenz/Coder;->decompressionMethodId:[B

    invoke-static {v7}, Lorg/apache/commons/compress/archivers/sevenz/SevenZMethod;->byId([B)Lorg/apache/commons/compress/archivers/sevenz/SevenZMethod;

    move-result-object v15

    .line 1799
    .local v15, "method":Lorg/apache/commons/compress/archivers/sevenz/SevenZMethod;
    iget-object v7, v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->fileName:Ljava/lang/String;

    .line 1800
    invoke-virtual {v1, v14}, Lorg/apache/commons/compress/archivers/sevenz/Folder;->getUnpackSizeForCoder(Lorg/apache/commons/compress/archivers/sevenz/Coder;)J

    move-result-wide v9

    iget-object v12, v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->password:[B

    iget-object v8, v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->options:Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;

    invoke-virtual {v8}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;->getMaxMemoryLimitInKb()I

    move-result v13

    .line 1799
    move-object v8, v2

    move-object v11, v14

    invoke-static/range {v7 .. v13}, Lorg/apache/commons/compress/archivers/sevenz/Coders;->addDecoder(Ljava/lang/String;Ljava/io/InputStream;JLorg/apache/commons/compress/archivers/sevenz/Coder;[BI)Ljava/io/InputStream;

    move-result-object v2

    .line 1801
    new-instance v7, Lorg/apache/commons/compress/archivers/sevenz/SevenZMethodConfiguration;

    .line 1802
    invoke-static {v15}, Lorg/apache/commons/compress/archivers/sevenz/Coders;->findByMethod(Lorg/apache/commons/compress/archivers/sevenz/SevenZMethod;)Lorg/apache/commons/compress/archivers/sevenz/CoderBase;

    move-result-object v8

    invoke-virtual {v8, v14, v2}, Lorg/apache/commons/compress/archivers/sevenz/CoderBase;->getOptionsFromCoder(Lorg/apache/commons/compress/archivers/sevenz/Coder;Ljava/io/InputStream;)Ljava/lang/Object;

    move-result-object v8

    invoke-direct {v7, v15, v8}, Lorg/apache/commons/compress/archivers/sevenz/SevenZMethodConfiguration;-><init>(Lorg/apache/commons/compress/archivers/sevenz/SevenZMethod;Ljava/lang/Object;)V

    .line 1801
    invoke-virtual {v5, v7}, Ljava/util/LinkedList;->addFirst(Ljava/lang/Object;)V

    .line 1803
    .end local v14    # "coder":Lorg/apache/commons/compress/archivers/sevenz/Coder;
    .end local v15    # "method":Lorg/apache/commons/compress/archivers/sevenz/SevenZMethod;
    goto :goto_0

    .line 1796
    .restart local v14    # "coder":Lorg/apache/commons/compress/archivers/sevenz/Coder;
    :cond_0
    new-instance v6, Ljava/io/IOException;

    const-string v7, "Multi input/output stream coders are not yet supported"

    invoke-direct {v6, v7}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v6

    .line 1804
    .end local v14    # "coder":Lorg/apache/commons/compress/archivers/sevenz/Coder;
    :cond_1
    move-object/from16 v6, p5

    invoke-virtual {v6, v5}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setContentMethods(Ljava/lang/Iterable;)V

    .line 1805
    iget-boolean v7, v1, Lorg/apache/commons/compress/archivers/sevenz/Folder;->hasCrc:Z

    if-eqz v7, :cond_2

    .line 1806
    new-instance v13, Lorg/apache/commons/compress/utils/CRC32VerifyingInputStream;

    .line 1807
    invoke-virtual/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/Folder;->getUnpackSize()J

    move-result-wide v9

    iget-wide v11, v1, Lorg/apache/commons/compress/archivers/sevenz/Folder;->crc:J

    move-object v7, v13

    move-object v8, v2

    invoke-direct/range {v7 .. v12}, Lorg/apache/commons/compress/utils/CRC32VerifyingInputStream;-><init>(Ljava/io/InputStream;JJ)V

    .line 1806
    return-object v13

    .line 1809
    :cond_2
    return-object v2
.end method

.method private buildDecodingStream(IZ)V
    .locals 11
    .param p1, "entryIndex"    # I
    .param p2, "isRandomAccess"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1591
    iget-object v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v0, v0, Lorg/apache/commons/compress/archivers/sevenz/Archive;->streamMap:Lorg/apache/commons/compress/archivers/sevenz/StreamMap;

    if-eqz v0, :cond_7

    .line 1594
    iget-object v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v0, v0, Lorg/apache/commons/compress/archivers/sevenz/Archive;->streamMap:Lorg/apache/commons/compress/archivers/sevenz/StreamMap;

    iget-object v0, v0, Lorg/apache/commons/compress/archivers/sevenz/StreamMap;->fileFolderIndex:[I

    aget v0, v0, p1

    .line 1595
    .local v0, "folderIndex":I
    if-gez v0, :cond_0

    .line 1596
    iget-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->deferredBlockStreams:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->clear()V

    .line 1599
    return-void

    .line 1601
    :cond_0
    iget-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v1, v1, Lorg/apache/commons/compress/archivers/sevenz/Archive;->files:[Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    aget-object v1, v1, p1

    .line 1602
    .local v1, "file":Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    const/4 v2, 0x0

    .line 1603
    .local v2, "isInSameFolder":Z
    iget v3, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentFolderIndex:I

    if-ne v3, v0, :cond_3

    .line 1609
    if-lez p1, :cond_1

    .line 1610
    iget-object v3, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v3, v3, Lorg/apache/commons/compress/archivers/sevenz/Archive;->files:[Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    add-int/lit8 v4, p1, -0x1

    aget-object v3, v3, v4

    invoke-virtual {v3}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getContentMethods()Ljava/lang/Iterable;

    move-result-object v3

    invoke-virtual {v1, v3}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setContentMethods(Ljava/lang/Iterable;)V

    .line 1616
    :cond_1
    if-eqz p2, :cond_2

    invoke-virtual {v1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getContentMethods()Ljava/lang/Iterable;

    move-result-object v3

    if-nez v3, :cond_2

    .line 1617
    iget-object v3, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v3, v3, Lorg/apache/commons/compress/archivers/sevenz/Archive;->streamMap:Lorg/apache/commons/compress/archivers/sevenz/StreamMap;

    iget-object v3, v3, Lorg/apache/commons/compress/archivers/sevenz/StreamMap;->folderFirstFileIndex:[I

    aget v3, v3, v0

    .line 1618
    .local v3, "folderFirstFileIndex":I
    iget-object v4, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v4, v4, Lorg/apache/commons/compress/archivers/sevenz/Archive;->files:[Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    aget-object v4, v4, v3

    .line 1619
    .local v4, "folderFirstFile":Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    invoke-virtual {v4}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getContentMethods()Ljava/lang/Iterable;

    move-result-object v5

    invoke-virtual {v1, v5}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setContentMethods(Ljava/lang/Iterable;)V

    .line 1621
    .end local v3    # "folderFirstFileIndex":I
    .end local v4    # "folderFirstFile":Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    :cond_2
    const/4 v2, 0x1

    goto :goto_0

    .line 1623
    :cond_3
    iput v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentFolderIndex:I

    .line 1625
    invoke-direct {p0, v0, v1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->reopenFolderInputStream(ILorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;)V

    .line 1628
    :goto_0
    const/4 v3, 0x0

    .line 1629
    .local v3, "haveSkippedEntries":Z
    if-eqz p2, :cond_4

    .line 1631
    invoke-direct {p0, p1, v2, v0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->skipEntriesWhenNeeded(IZI)Z

    move-result v3

    .line 1634
    :cond_4
    if-eqz p2, :cond_5

    iget v4, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentEntryIndex:I

    if-ne v4, p1, :cond_5

    if-nez v3, :cond_5

    .line 1640
    return-void

    .line 1643
    :cond_5
    new-instance v6, Lorg/apache/commons/compress/utils/BoundedInputStream;

    iget-object v4, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentFolderInputStream:Ljava/io/InputStream;

    invoke-virtual {v1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getSize()J

    move-result-wide v7

    invoke-direct {v6, v4, v7, v8}, Lorg/apache/commons/compress/utils/BoundedInputStream;-><init>(Ljava/io/InputStream;J)V

    .line 1644
    .local v6, "fileStream":Ljava/io/InputStream;
    invoke-virtual {v1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getHasCrc()Z

    move-result v4

    if-eqz v4, :cond_6

    .line 1645
    new-instance v4, Lorg/apache/commons/compress/utils/CRC32VerifyingInputStream;

    invoke-virtual {v1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getSize()J

    move-result-wide v7

    invoke-virtual {v1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getCrcValue()J

    move-result-wide v9

    move-object v5, v4

    invoke-direct/range {v5 .. v10}, Lorg/apache/commons/compress/utils/CRC32VerifyingInputStream;-><init>(Ljava/io/InputStream;JJ)V

    .end local v6    # "fileStream":Ljava/io/InputStream;
    .local v4, "fileStream":Ljava/io/InputStream;
    goto :goto_1

    .line 1644
    .end local v4    # "fileStream":Ljava/io/InputStream;
    .restart local v6    # "fileStream":Ljava/io/InputStream;
    :cond_6
    move-object v4, v6

    .line 1648
    .end local v6    # "fileStream":Ljava/io/InputStream;
    .restart local v4    # "fileStream":Ljava/io/InputStream;
    :goto_1
    iget-object v5, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->deferredBlockStreams:Ljava/util/ArrayList;

    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 1649
    return-void

    .line 1592
    .end local v0    # "folderIndex":I
    .end local v1    # "file":Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    .end local v2    # "isInSameFolder":Z
    .end local v3    # "haveSkippedEntries":Z
    .end local v4    # "fileStream":Ljava/io/InputStream;
    :cond_7
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Archive doesn\'t contain stream information to read entries"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private calculateStreamMap(Lorg/apache/commons/compress/archivers/sevenz/Archive;)V
    .locals 11
    .param p1, "archive"    # Lorg/apache/commons/compress/archivers/sevenz/Archive;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1526
    new-instance v0, Lorg/apache/commons/compress/archivers/sevenz/StreamMap;

    invoke-direct {v0}, Lorg/apache/commons/compress/archivers/sevenz/StreamMap;-><init>()V

    .line 1528
    .local v0, "streamMap":Lorg/apache/commons/compress/archivers/sevenz/StreamMap;
    const/4 v1, 0x0

    .line 1529
    .local v1, "nextFolderPackStreamIndex":I
    iget-object v2, p1, Lorg/apache/commons/compress/archivers/sevenz/Archive;->folders:[Lorg/apache/commons/compress/archivers/sevenz/Folder;

    if-eqz v2, :cond_0

    iget-object v2, p1, Lorg/apache/commons/compress/archivers/sevenz/Archive;->folders:[Lorg/apache/commons/compress/archivers/sevenz/Folder;

    array-length v2, v2

    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    .line 1530
    .local v2, "numFolders":I
    :goto_0
    new-array v3, v2, [I

    iput-object v3, v0, Lorg/apache/commons/compress/archivers/sevenz/StreamMap;->folderFirstPackStreamIndex:[I

    .line 1531
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_1
    if-ge v3, v2, :cond_1

    .line 1532
    iget-object v4, v0, Lorg/apache/commons/compress/archivers/sevenz/StreamMap;->folderFirstPackStreamIndex:[I

    aput v1, v4, v3

    .line 1533
    iget-object v4, p1, Lorg/apache/commons/compress/archivers/sevenz/Archive;->folders:[Lorg/apache/commons/compress/archivers/sevenz/Folder;

    aget-object v4, v4, v3

    iget-object v4, v4, Lorg/apache/commons/compress/archivers/sevenz/Folder;->packedStreams:[J

    array-length v4, v4

    add-int/2addr v1, v4

    .line 1531
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 1536
    .end local v3    # "i":I
    :cond_1
    const-wide/16 v3, 0x0

    .line 1537
    .local v3, "nextPackStreamOffset":J
    iget-object v5, p1, Lorg/apache/commons/compress/archivers/sevenz/Archive;->packSizes:[J

    array-length v5, v5

    .line 1538
    .local v5, "numPackSizes":I
    new-array v6, v5, [J

    iput-object v6, v0, Lorg/apache/commons/compress/archivers/sevenz/StreamMap;->packStreamOffsets:[J

    .line 1539
    const/4 v6, 0x0

    .local v6, "i":I
    :goto_2
    if-ge v6, v5, :cond_2

    .line 1540
    iget-object v7, v0, Lorg/apache/commons/compress/archivers/sevenz/StreamMap;->packStreamOffsets:[J

    aput-wide v3, v7, v6

    .line 1541
    iget-object v7, p1, Lorg/apache/commons/compress/archivers/sevenz/Archive;->packSizes:[J

    aget-wide v8, v7, v6

    add-long/2addr v3, v8

    .line 1539
    add-int/lit8 v6, v6, 0x1

    goto :goto_2

    .line 1544
    .end local v6    # "i":I
    :cond_2
    new-array v6, v2, [I

    iput-object v6, v0, Lorg/apache/commons/compress/archivers/sevenz/StreamMap;->folderFirstFileIndex:[I

    .line 1545
    iget-object v6, p1, Lorg/apache/commons/compress/archivers/sevenz/Archive;->files:[Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    array-length v6, v6

    new-array v6, v6, [I

    iput-object v6, v0, Lorg/apache/commons/compress/archivers/sevenz/StreamMap;->fileFolderIndex:[I

    .line 1546
    const/4 v6, 0x0

    .line 1547
    .local v6, "nextFolderIndex":I
    const/4 v7, 0x0

    .line 1548
    .local v7, "nextFolderUnpackStreamIndex":I
    const/4 v8, 0x0

    .local v8, "i":I
    :goto_3
    iget-object v9, p1, Lorg/apache/commons/compress/archivers/sevenz/Archive;->files:[Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    array-length v9, v9

    if-ge v8, v9, :cond_a

    .line 1549
    iget-object v9, p1, Lorg/apache/commons/compress/archivers/sevenz/Archive;->files:[Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    aget-object v9, v9, v8

    invoke-virtual {v9}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->hasStream()Z

    move-result v9

    if-nez v9, :cond_3

    if-nez v7, :cond_3

    .line 1550
    iget-object v9, v0, Lorg/apache/commons/compress/archivers/sevenz/StreamMap;->fileFolderIndex:[I

    const/4 v10, -0x1

    aput v10, v9, v8

    .line 1551
    goto :goto_7

    .line 1553
    :cond_3
    if-nez v7, :cond_7

    .line 1554
    :goto_4
    iget-object v9, p1, Lorg/apache/commons/compress/archivers/sevenz/Archive;->folders:[Lorg/apache/commons/compress/archivers/sevenz/Folder;

    array-length v9, v9

    if-ge v6, v9, :cond_5

    .line 1555
    iget-object v9, v0, Lorg/apache/commons/compress/archivers/sevenz/StreamMap;->folderFirstFileIndex:[I

    aput v8, v9, v6

    .line 1556
    iget-object v9, p1, Lorg/apache/commons/compress/archivers/sevenz/Archive;->folders:[Lorg/apache/commons/compress/archivers/sevenz/Folder;

    aget-object v9, v9, v6

    iget v9, v9, Lorg/apache/commons/compress/archivers/sevenz/Folder;->numUnpackSubStreams:I

    if-lez v9, :cond_4

    .line 1557
    goto :goto_5

    .line 1554
    :cond_4
    add-int/lit8 v6, v6, 0x1

    goto :goto_4

    .line 1560
    :cond_5
    :goto_5
    iget-object v9, p1, Lorg/apache/commons/compress/archivers/sevenz/Archive;->folders:[Lorg/apache/commons/compress/archivers/sevenz/Folder;

    array-length v9, v9

    if-ge v6, v9, :cond_6

    goto :goto_6

    .line 1561
    :cond_6
    new-instance v9, Ljava/io/IOException;

    const-string v10, "Too few folders in archive"

    invoke-direct {v9, v10}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v9

    .line 1564
    :cond_7
    :goto_6
    iget-object v9, v0, Lorg/apache/commons/compress/archivers/sevenz/StreamMap;->fileFolderIndex:[I

    aput v6, v9, v8

    .line 1565
    iget-object v9, p1, Lorg/apache/commons/compress/archivers/sevenz/Archive;->files:[Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    aget-object v9, v9, v8

    invoke-virtual {v9}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->hasStream()Z

    move-result v9

    if-nez v9, :cond_8

    .line 1566
    goto :goto_7

    .line 1568
    :cond_8
    add-int/lit8 v7, v7, 0x1

    .line 1569
    iget-object v9, p1, Lorg/apache/commons/compress/archivers/sevenz/Archive;->folders:[Lorg/apache/commons/compress/archivers/sevenz/Folder;

    aget-object v9, v9, v6

    iget v9, v9, Lorg/apache/commons/compress/archivers/sevenz/Folder;->numUnpackSubStreams:I

    if-lt v7, v9, :cond_9

    .line 1570
    add-int/lit8 v6, v6, 0x1

    .line 1571
    const/4 v7, 0x0

    .line 1548
    :cond_9
    :goto_7
    add-int/lit8 v8, v8, 0x1

    goto :goto_3

    .line 1575
    .end local v8    # "i":I
    :cond_a
    iput-object v0, p1, Lorg/apache/commons/compress/archivers/sevenz/Archive;->streamMap:Lorg/apache/commons/compress/archivers/sevenz/StreamMap;

    .line 1576
    return-void
.end method

.method private checkEntryIsInitialized(Ljava/util/Map;I)V
    .locals 2
    .param p2, "index"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;",
            ">;I)V"
        }
    .end annotation

    .line 1520
    .local p1, "archiveEntries":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_0

    .line 1521
    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    new-instance v1, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    invoke-direct {v1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;-><init>()V

    invoke-interface {p1, v0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1523
    :cond_0
    return-void
.end method

.method private static get(Ljava/nio/ByteBuffer;[B)V
    .locals 2
    .param p0, "buf"    # Ljava/nio/ByteBuffer;
    .param p1, "to"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1969
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    array-length v1, p1

    if-lt v0, v1, :cond_0

    .line 1972
    invoke-virtual {p0, p1}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 1973
    return-void

    .line 1970
    :cond_0
    new-instance v0, Ljava/io/EOFException;

    invoke-direct {v0}, Ljava/io/EOFException;-><init>()V

    throw v0
.end method

.method private static getChar(Ljava/nio/ByteBuffer;)C
    .locals 2
    .param p0, "buf"    # Ljava/nio/ByteBuffer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1948
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    const/4 v1, 0x2

    if-lt v0, v1, :cond_0

    .line 1951
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->getChar()C

    move-result v0

    return v0

    .line 1949
    :cond_0
    new-instance v0, Ljava/io/EOFException;

    invoke-direct {v0}, Ljava/io/EOFException;-><init>()V

    throw v0
.end method

.method private getCurrentStream()Ljava/io/InputStream;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1828
    iget-object v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v0, v0, Lorg/apache/commons/compress/archivers/sevenz/Archive;->files:[Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    iget v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentEntryIndex:I

    aget-object v0, v0, v1

    invoke-virtual {v0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getSize()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    .line 1829
    new-instance v0, Ljava/io/ByteArrayInputStream;

    sget-object v1, Lorg/apache/commons/compress/utils/ByteUtils;->EMPTY_BYTE_ARRAY:[B

    invoke-direct {v0, v1}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    return-object v0

    .line 1831
    :cond_0
    iget-object v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->deferredBlockStreams:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_4

    .line 1835
    :goto_0
    iget-object v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->deferredBlockStreams:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x1

    const/4 v4, 0x0

    if-le v0, v1, :cond_3

    .line 1839
    iget-object v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->deferredBlockStreams:Ljava/util/ArrayList;

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/InputStream;

    .line 1840
    .local v0, "stream":Ljava/io/InputStream;
    const-wide v4, 0x7fffffffffffffffL

    :try_start_0
    invoke-static {v0, v4, v5}, Lorg/apache/commons/compress/utils/IOUtils;->skip(Ljava/io/InputStream;J)J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1841
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 1842
    .end local v0    # "stream":Ljava/io/InputStream;
    :cond_1
    iput-wide v2, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->compressedBytesReadFromCurrentEntry:J

    goto :goto_0

    .line 1839
    .restart local v0    # "stream":Ljava/io/InputStream;
    :catchall_0
    move-exception v1

    .end local v0    # "stream":Ljava/io/InputStream;
    :try_start_1
    throw v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1841
    .restart local v0    # "stream":Ljava/io/InputStream;
    :catchall_1
    move-exception v2

    if-eqz v0, :cond_2

    :try_start_2
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    goto :goto_1

    :catchall_2
    move-exception v3

    invoke-virtual {v1, v3}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_2
    :goto_1
    throw v2

    .line 1845
    .end local v0    # "stream":Ljava/io/InputStream;
    :cond_3
    iget-object v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->deferredBlockStreams:Ljava/util/ArrayList;

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/InputStream;

    return-object v0

    .line 1832
    :cond_4
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "No current 7z entry (call getNextEntry() first)."

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static getInt(Ljava/nio/ByteBuffer;)I
    .locals 2
    .param p0, "buf"    # Ljava/nio/ByteBuffer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1955
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    const/4 v1, 0x4

    if-lt v0, v1, :cond_0

    .line 1958
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v0

    return v0

    .line 1956
    :cond_0
    new-instance v0, Ljava/io/EOFException;

    invoke-direct {v0}, Ljava/io/EOFException;-><init>()V

    throw v0
.end method

.method private static getLong(Ljava/nio/ByteBuffer;)J
    .locals 2
    .param p0, "buf"    # Ljava/nio/ByteBuffer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1962
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v0

    const/16 v1, 0x8

    if-lt v0, v1, :cond_0

    .line 1965
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->getLong()J

    move-result-wide v0

    return-wide v0

    .line 1963
    :cond_0
    new-instance v0, Ljava/io/EOFException;

    invoke-direct {v0}, Ljava/io/EOFException;-><init>()V

    throw v0
.end method

.method private static getUnsignedByte(Ljava/nio/ByteBuffer;)I
    .locals 1
    .param p0, "buf"    # Ljava/nio/ByteBuffer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1976
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->hasRemaining()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1979
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->get()B

    move-result v0

    and-int/lit16 v0, v0, 0xff

    return v0

    .line 1977
    :cond_0
    new-instance v0, Ljava/io/EOFException;

    invoke-direct {v0}, Ljava/io/EOFException;-><init>()V

    throw v0
.end method

.method private hasCurrentEntryBeenRead()Z
    .locals 9

    .line 1744
    const/4 v0, 0x0

    .line 1745
    .local v0, "hasCurrentEntryBeenRead":Z
    iget-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->deferredBlockStreams:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_3

    .line 1746
    iget-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->deferredBlockStreams:Ljava/util/ArrayList;

    iget-object v2, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->deferredBlockStreams:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/4 v3, 0x1

    sub-int/2addr v2, v3

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/io/InputStream;

    .line 1749
    .local v1, "currentEntryInputStream":Ljava/io/InputStream;
    instance-of v2, v1, Lorg/apache/commons/compress/utils/CRC32VerifyingInputStream;

    const/4 v4, 0x0

    if-eqz v2, :cond_1

    .line 1750
    move-object v2, v1

    check-cast v2, Lorg/apache/commons/compress/utils/CRC32VerifyingInputStream;

    invoke-virtual {v2}, Lorg/apache/commons/compress/utils/CRC32VerifyingInputStream;->getBytesRemaining()J

    move-result-wide v5

    iget-object v2, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v2, v2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->files:[Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    iget v7, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentEntryIndex:I

    aget-object v2, v2, v7

    invoke-virtual {v2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getSize()J

    move-result-wide v7

    cmp-long v2, v5, v7

    if-eqz v2, :cond_0

    move v2, v3

    goto :goto_0

    :cond_0
    move v2, v4

    :goto_0
    move v0, v2

    .line 1753
    :cond_1
    instance-of v2, v1, Lorg/apache/commons/compress/utils/BoundedInputStream;

    if-eqz v2, :cond_3

    .line 1754
    move-object v2, v1

    check-cast v2, Lorg/apache/commons/compress/utils/BoundedInputStream;

    invoke-virtual {v2}, Lorg/apache/commons/compress/utils/BoundedInputStream;->getBytesRemaining()J

    move-result-wide v5

    iget-object v2, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v2, v2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->files:[Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    iget v7, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentEntryIndex:I

    aget-object v2, v2, v7

    invoke-virtual {v2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getSize()J

    move-result-wide v7

    cmp-long v2, v5, v7

    if-eqz v2, :cond_2

    goto :goto_1

    :cond_2
    move v3, v4

    :goto_1
    move v0, v3

    .line 1757
    .end local v1    # "currentEntryInputStream":Ljava/io/InputStream;
    :cond_3
    return v0
.end method

.method private initializeArchive(Lorg/apache/commons/compress/archivers/sevenz/StartHeader;[BZ)Lorg/apache/commons/compress/archivers/sevenz/Archive;
    .locals 7
    .param p1, "startHeader"    # Lorg/apache/commons/compress/archivers/sevenz/StartHeader;
    .param p2, "password"    # [B
    .param p3, "verifyCrc"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 528
    const-string v0, "nextHeaderSize"

    iget-wide v1, p1, Lorg/apache/commons/compress/archivers/sevenz/StartHeader;->nextHeaderSize:J

    invoke-static {v0, v1, v2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    .line 529
    iget-wide v0, p1, Lorg/apache/commons/compress/archivers/sevenz/StartHeader;->nextHeaderSize:J

    long-to-int v0, v0

    .line 530
    .local v0, "nextHeaderSizeInt":I
    iget-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    const-wide/16 v2, 0x20

    iget-wide v4, p1, Lorg/apache/commons/compress/archivers/sevenz/StartHeader;->nextHeaderOffset:J

    add-long/2addr v4, v2

    invoke-interface {v1, v4, v5}, Ljava/nio/channels/SeekableByteChannel;->position(J)Ljava/nio/channels/SeekableByteChannel;

    .line 531
    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v1

    sget-object v2, Ljava/nio/ByteOrder;->LITTLE_ENDIAN:Ljava/nio/ByteOrder;

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v1

    .line 532
    .local v1, "buf":Ljava/nio/ByteBuffer;
    invoke-direct {p0, v1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readFully(Ljava/nio/ByteBuffer;)V

    .line 533
    if-eqz p3, :cond_1

    .line 534
    new-instance v2, Ljava/util/zip/CRC32;

    invoke-direct {v2}, Ljava/util/zip/CRC32;-><init>()V

    .line 535
    .local v2, "crc":Ljava/util/zip/CRC32;
    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/util/zip/CRC32;->update([B)V

    .line 536
    iget-wide v3, p1, Lorg/apache/commons/compress/archivers/sevenz/StartHeader;->nextHeaderCrc:J

    invoke-virtual {v2}, Ljava/util/zip/CRC32;->getValue()J

    move-result-wide v5

    cmp-long v3, v3, v5

    if-nez v3, :cond_0

    goto :goto_0

    .line 537
    :cond_0
    new-instance v3, Ljava/io/IOException;

    const-string v4, "NextHeader CRC mismatch"

    invoke-direct {v3, v4}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 541
    .end local v2    # "crc":Ljava/util/zip/CRC32;
    :cond_1
    :goto_0
    new-instance v2, Lorg/apache/commons/compress/archivers/sevenz/Archive;

    invoke-direct {v2}, Lorg/apache/commons/compress/archivers/sevenz/Archive;-><init>()V

    .line 542
    .local v2, "archive":Lorg/apache/commons/compress/archivers/sevenz/Archive;
    invoke-static {v1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v3

    .line 543
    .local v3, "nid":I
    const/16 v4, 0x17

    if-ne v3, v4, :cond_2

    .line 544
    invoke-direct {p0, v1, v2, p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readEncodedHeader(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/Archive;[B)Ljava/nio/ByteBuffer;

    move-result-object v1

    .line 546
    new-instance v4, Lorg/apache/commons/compress/archivers/sevenz/Archive;

    invoke-direct {v4}, Lorg/apache/commons/compress/archivers/sevenz/Archive;-><init>()V

    move-object v2, v4

    .line 547
    invoke-static {v1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v3

    .line 549
    :cond_2
    const/4 v4, 0x1

    if-ne v3, v4, :cond_3

    .line 552
    invoke-direct {p0, v1, v2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readHeader(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/Archive;)V

    .line 553
    const/4 v4, 0x0

    iput-object v4, v2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->subStreamsInfo:Lorg/apache/commons/compress/archivers/sevenz/SubStreamsInfo;

    .line 554
    return-object v2

    .line 550
    :cond_3
    new-instance v4, Ljava/io/IOException;

    const-string v5, "Broken or unsupported archive: no Header"

    invoke-direct {v4, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v4
.end method

.method public static matches([BI)Z
    .locals 4
    .param p0, "signature"    # [B
    .param p1, "length"    # I

    .line 1993
    sget-object v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->sevenZSignature:[B

    array-length v0, v0

    const/4 v1, 0x0

    if-ge p1, v0, :cond_0

    .line 1994
    return v1

    .line 1997
    :cond_0
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    sget-object v2, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->sevenZSignature:[B

    array-length v2, v2

    if-ge v0, v2, :cond_2

    .line 1998
    aget-byte v2, p0, v0

    sget-object v3, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->sevenZSignature:[B

    aget-byte v3, v3, v0

    if-eq v2, v3, :cond_1

    .line 1999
    return v1

    .line 1997
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 2002
    .end local v0    # "i":I
    :cond_2
    const/4 v0, 0x1

    return v0
.end method

.method private readAllOrBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;
    .locals 4
    .param p1, "header"    # Ljava/nio/ByteBuffer;
    .param p2, "size"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1214
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    .line 1216
    .local v0, "areAllDefined":I
    if-eqz v0, :cond_1

    .line 1217
    new-instance v1, Ljava/util/BitSet;

    invoke-direct {v1, p2}, Ljava/util/BitSet;-><init>(I)V

    .line 1218
    .local v1, "bits":Ljava/util/BitSet;
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, p2, :cond_0

    .line 1219
    const/4 v3, 0x1

    invoke-virtual {v1, v2, v3}, Ljava/util/BitSet;->set(IZ)V

    .line 1218
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .end local v2    # "i":I
    :cond_0
    goto :goto_1

    .line 1222
    .end local v1    # "bits":Ljava/util/BitSet;
    :cond_1
    invoke-direct {p0, p1, p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;

    move-result-object v1

    .line 1224
    .restart local v1    # "bits":Ljava/util/BitSet;
    :goto_1
    return-object v1
.end method

.method private readArchiveProperties(Ljava/nio/ByteBuffer;)V
    .locals 4
    .param p1, "input"    # Ljava/nio/ByteBuffer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 646
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    .line 647
    .local v0, "nid":I
    :goto_0
    if-eqz v0, :cond_0

    .line 648
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v1

    .line 649
    .local v1, "propertySize":J
    long-to-int v3, v1

    new-array v3, v3, [B

    .line 650
    .local v3, "property":[B
    invoke-static {p1, v3}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->get(Ljava/nio/ByteBuffer;[B)V

    .line 651
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    .line 652
    .end local v1    # "propertySize":J
    .end local v3    # "property":[B
    goto :goto_0

    .line 653
    :cond_0
    return-void
.end method

.method private readBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;
    .locals 5
    .param p1, "header"    # Ljava/nio/ByteBuffer;
    .param p2, "size"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1228
    new-instance v0, Ljava/util/BitSet;

    invoke-direct {v0, p2}, Ljava/util/BitSet;-><init>(I)V

    .line 1229
    .local v0, "bits":Ljava/util/BitSet;
    const/4 v1, 0x0

    .line 1230
    .local v1, "mask":I
    const/4 v2, 0x0

    .line 1231
    .local v2, "cache":I
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    if-ge v3, p2, :cond_2

    .line 1232
    if-nez v1, :cond_0

    .line 1233
    const/16 v1, 0x80

    .line 1234
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v2

    .line 1236
    :cond_0
    and-int v4, v2, v1

    if-eqz v4, :cond_1

    const/4 v4, 0x1

    goto :goto_1

    :cond_1
    const/4 v4, 0x0

    :goto_1
    invoke-virtual {v0, v3, v4}, Ljava/util/BitSet;->set(IZ)V

    .line 1237
    ushr-int/lit8 v1, v1, 0x1

    .line 1231
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 1239
    .end local v3    # "i":I
    :cond_2
    return-object v0
.end method

.method private readEncodedHeader(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/Archive;[B)Ljava/nio/ByteBuffer;
    .locals 19
    .param p1, "header"    # Ljava/nio/ByteBuffer;
    .param p2, "archive"    # Lorg/apache/commons/compress/archivers/sevenz/Archive;
    .param p3, "password"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 670
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    invoke-virtual/range {p1 .. p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v3

    .line 671
    .local v3, "pos":I
    new-instance v4, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;

    const/4 v5, 0x0

    invoke-direct {v4, v5}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;-><init>(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$1;)V

    .line 672
    .local v4, "stats":Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;
    invoke-direct {v0, v1, v4}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->sanityCheckStreamsInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)V

    .line 673
    iget-object v5, v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->options:Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;

    invoke-virtual {v5}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;->getMaxMemoryLimitInKb()I

    move-result v5

    invoke-virtual {v4, v5}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->assertValidity(I)V

    .line 674
    invoke-virtual {v1, v3}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    .line 676
    invoke-direct/range {p0 .. p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readStreamsInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/Archive;)V

    .line 678
    iget-object v5, v2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->folders:[Lorg/apache/commons/compress/archivers/sevenz/Folder;

    if-eqz v5, :cond_5

    iget-object v5, v2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->folders:[Lorg/apache/commons/compress/archivers/sevenz/Folder;

    array-length v5, v5

    if-eqz v5, :cond_5

    .line 681
    iget-object v5, v2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->packSizes:[J

    if-eqz v5, :cond_4

    iget-object v5, v2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->packSizes:[J

    array-length v5, v5

    if-eqz v5, :cond_4

    .line 686
    iget-object v5, v2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->folders:[Lorg/apache/commons/compress/archivers/sevenz/Folder;

    const/4 v6, 0x0

    aget-object v5, v5, v6

    .line 687
    .local v5, "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    const/4 v7, 0x0

    .line 688
    .local v7, "firstPackStreamIndex":I
    const-wide/16 v8, 0x20

    iget-wide v10, v2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->packPos:J

    add-long/2addr v10, v8

    const-wide/16 v8, 0x0

    add-long/2addr v10, v8

    .line 691
    .local v10, "folderOffset":J
    iget-object v8, v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    invoke-interface {v8, v10, v11}, Ljava/nio/channels/SeekableByteChannel;->position(J)Ljava/nio/channels/SeekableByteChannel;

    .line 692
    new-instance v8, Lorg/apache/commons/compress/archivers/sevenz/BoundedSeekableByteChannelInputStream;

    iget-object v9, v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    iget-object v12, v2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->packSizes:[J

    aget-wide v13, v12, v6

    invoke-direct {v8, v9, v13, v14}, Lorg/apache/commons/compress/archivers/sevenz/BoundedSeekableByteChannelInputStream;-><init>(Ljava/nio/channels/SeekableByteChannel;J)V

    move-object v6, v8

    .line 694
    .local v6, "inputStreamStack":Ljava/io/InputStream;
    invoke-virtual {v5}, Lorg/apache/commons/compress/archivers/sevenz/Folder;->getOrderedCoders()Ljava/lang/Iterable;

    move-result-object v8

    invoke-interface {v8}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :goto_0
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_1

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lorg/apache/commons/compress/archivers/sevenz/Coder;

    .line 695
    .local v9, "coder":Lorg/apache/commons/compress/archivers/sevenz/Coder;
    iget-wide v12, v9, Lorg/apache/commons/compress/archivers/sevenz/Coder;->numInStreams:J

    const-wide/16 v14, 0x1

    cmp-long v12, v12, v14

    if-nez v12, :cond_0

    iget-wide v12, v9, Lorg/apache/commons/compress/archivers/sevenz/Coder;->numOutStreams:J

    cmp-long v12, v12, v14

    if-nez v12, :cond_0

    .line 698
    iget-object v12, v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->fileName:Ljava/lang/String;

    .line 699
    invoke-virtual {v5, v9}, Lorg/apache/commons/compress/archivers/sevenz/Folder;->getUnpackSizeForCoder(Lorg/apache/commons/compress/archivers/sevenz/Coder;)J

    move-result-wide v14

    iget-object v13, v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->options:Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;

    invoke-virtual {v13}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;->getMaxMemoryLimitInKb()I

    move-result v18

    .line 698
    move-object v13, v6

    move-object/from16 v16, v9

    move-object/from16 v17, p3

    invoke-static/range {v12 .. v18}, Lorg/apache/commons/compress/archivers/sevenz/Coders;->addDecoder(Ljava/lang/String;Ljava/io/InputStream;JLorg/apache/commons/compress/archivers/sevenz/Coder;[BI)Ljava/io/InputStream;

    move-result-object v6

    .line 700
    .end local v9    # "coder":Lorg/apache/commons/compress/archivers/sevenz/Coder;
    goto :goto_0

    .line 696
    .restart local v9    # "coder":Lorg/apache/commons/compress/archivers/sevenz/Coder;
    :cond_0
    new-instance v8, Ljava/io/IOException;

    const-string v12, "Multi input/output stream coders are not yet supported"

    invoke-direct {v8, v12}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v8

    .line 701
    .end local v9    # "coder":Lorg/apache/commons/compress/archivers/sevenz/Coder;
    :cond_1
    iget-boolean v8, v5, Lorg/apache/commons/compress/archivers/sevenz/Folder;->hasCrc:Z

    if-eqz v8, :cond_2

    .line 702
    new-instance v8, Lorg/apache/commons/compress/utils/CRC32VerifyingInputStream;

    .line 703
    invoke-virtual {v5}, Lorg/apache/commons/compress/archivers/sevenz/Folder;->getUnpackSize()J

    move-result-wide v14

    iget-wide v12, v5, Lorg/apache/commons/compress/archivers/sevenz/Folder;->crc:J

    move-wide/from16 v16, v12

    move-object v12, v8

    move-object v13, v6

    invoke-direct/range {v12 .. v17}, Lorg/apache/commons/compress/utils/CRC32VerifyingInputStream;-><init>(Ljava/io/InputStream;JJ)V

    move-object v6, v8

    .line 705
    :cond_2
    const-string/jumbo v8, "unpackSize"

    invoke-virtual {v5}, Lorg/apache/commons/compress/archivers/sevenz/Folder;->getUnpackSize()J

    move-result-wide v12

    invoke-static {v8, v12, v13}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    move-result v8

    .line 706
    .local v8, "unpackSize":I
    invoke-static {v6, v8}, Lorg/apache/commons/compress/utils/IOUtils;->readRange(Ljava/io/InputStream;I)[B

    move-result-object v9

    .line 707
    .local v9, "nextHeader":[B
    array-length v12, v9

    if-lt v12, v8, :cond_3

    .line 710
    invoke-virtual {v6}, Ljava/io/InputStream;->close()V

    .line 711
    invoke-static {v9}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v12

    sget-object v13, Ljava/nio/ByteOrder;->LITTLE_ENDIAN:Ljava/nio/ByteOrder;

    invoke-virtual {v12, v13}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v12

    return-object v12

    .line 708
    :cond_3
    new-instance v12, Ljava/io/IOException;

    const-string v13, "premature end of stream"

    invoke-direct {v12, v13}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v12

    .line 682
    .end local v5    # "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    .end local v6    # "inputStreamStack":Ljava/io/InputStream;
    .end local v7    # "firstPackStreamIndex":I
    .end local v8    # "unpackSize":I
    .end local v9    # "nextHeader":[B
    .end local v10    # "folderOffset":J
    :cond_4
    new-instance v5, Ljava/io/IOException;

    const-string v6, "no packed streams, can\'t read encoded header"

    invoke-direct {v5, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 679
    :cond_5
    new-instance v5, Ljava/io/IOException;

    const-string v6, "no folders, can\'t read encoded header"

    invoke-direct {v5, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v5
.end method

.method private readFilesInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/Archive;)V
    .locals 19
    .param p1, "header"    # Ljava/nio/ByteBuffer;
    .param p2, "archive"    # Lorg/apache/commons/compress/archivers/sevenz/Archive;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1369
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v3

    long-to-int v3, v3

    .line 1370
    .local v3, "numFilesInt":I
    new-instance v4, Ljava/util/HashMap;

    invoke-direct {v4}, Ljava/util/HashMap;-><init>()V

    .line 1371
    .local v4, "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    const/4 v5, 0x0

    .line 1372
    .local v5, "isEmptyStream":Ljava/util/BitSet;
    const/4 v6, 0x0

    .line 1373
    .local v6, "isEmptyFile":Ljava/util/BitSet;
    const/4 v7, 0x0

    .line 1375
    .local v7, "isAnti":Ljava/util/BitSet;
    :goto_0
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v8

    .line 1376
    .local v8, "propertyType":I
    if-nez v8, :cond_c

    .line 1377
    nop

    .line 1480
    .end local v8    # "propertyType":I
    const/4 v8, 0x0

    .line 1481
    .local v8, "nonEmptyFileCounter":I
    const/4 v9, 0x0

    .line 1482
    .local v9, "emptyFileCounter":I
    const/4 v10, 0x0

    .local v10, "i":I
    :goto_1
    if-ge v10, v3, :cond_9

    .line 1483
    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    invoke-interface {v4, v11}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    .line 1484
    .local v11, "entryAtIndex":Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    if-nez v11, :cond_0

    .line 1485
    goto/16 :goto_7

    .line 1487
    :cond_0
    if-eqz v5, :cond_2

    invoke-virtual {v5, v10}, Ljava/util/BitSet;->get(I)Z

    move-result v14

    if-nez v14, :cond_1

    goto :goto_2

    :cond_1
    const/4 v14, 0x0

    goto :goto_3

    :cond_2
    :goto_2
    const/4 v14, 0x1

    :goto_3
    invoke-virtual {v11, v14}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setHasStream(Z)V

    .line 1488
    invoke-virtual {v11}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->hasStream()Z

    move-result v14

    if-eqz v14, :cond_5

    .line 1489
    iget-object v14, v2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->subStreamsInfo:Lorg/apache/commons/compress/archivers/sevenz/SubStreamsInfo;

    if-eqz v14, :cond_4

    .line 1492
    const/4 v14, 0x0

    invoke-virtual {v11, v14}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setDirectory(Z)V

    .line 1493
    invoke-virtual {v11, v14}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setAntiItem(Z)V

    .line 1494
    iget-object v14, v2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->subStreamsInfo:Lorg/apache/commons/compress/archivers/sevenz/SubStreamsInfo;

    iget-object v14, v14, Lorg/apache/commons/compress/archivers/sevenz/SubStreamsInfo;->hasCrc:Ljava/util/BitSet;

    invoke-virtual {v14, v8}, Ljava/util/BitSet;->get(I)Z

    move-result v14

    invoke-virtual {v11, v14}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setHasCrc(Z)V

    .line 1495
    iget-object v14, v2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->subStreamsInfo:Lorg/apache/commons/compress/archivers/sevenz/SubStreamsInfo;

    iget-object v14, v14, Lorg/apache/commons/compress/archivers/sevenz/SubStreamsInfo;->crcs:[J

    aget-wide v12, v14, v8

    invoke-virtual {v11, v12, v13}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setCrcValue(J)V

    .line 1496
    iget-object v12, v2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->subStreamsInfo:Lorg/apache/commons/compress/archivers/sevenz/SubStreamsInfo;

    iget-object v12, v12, Lorg/apache/commons/compress/archivers/sevenz/SubStreamsInfo;->unpackSizes:[J

    aget-wide v13, v12, v8

    invoke-virtual {v11, v13, v14}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setSize(J)V

    .line 1497
    invoke-virtual {v11}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getSize()J

    move-result-wide v12

    const-wide/16 v14, 0x0

    cmp-long v12, v12, v14

    if-ltz v12, :cond_3

    .line 1500
    add-int/lit8 v8, v8, 0x1

    goto :goto_7

    .line 1498
    :cond_3
    new-instance v12, Ljava/io/IOException;

    const-string v13, "broken archive, entry with negative size"

    invoke-direct {v12, v13}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v12

    .line 1490
    :cond_4
    new-instance v12, Ljava/io/IOException;

    const-string v13, "Archive contains file with streams but no subStreamsInfo"

    invoke-direct {v12, v13}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v12

    .line 1502
    :cond_5
    if-eqz v6, :cond_7

    invoke-virtual {v6, v9}, Ljava/util/BitSet;->get(I)Z

    move-result v12

    if-nez v12, :cond_6

    goto :goto_4

    :cond_6
    const/4 v14, 0x0

    goto :goto_5

    :cond_7
    :goto_4
    const/4 v14, 0x1

    :goto_5
    invoke-virtual {v11, v14}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setDirectory(Z)V

    .line 1503
    if-eqz v7, :cond_8

    invoke-virtual {v7, v9}, Ljava/util/BitSet;->get(I)Z

    move-result v12

    if-eqz v12, :cond_8

    const/4 v13, 0x1

    goto :goto_6

    :cond_8
    const/4 v13, 0x0

    :goto_6
    invoke-virtual {v11, v13}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setAntiItem(Z)V

    .line 1504
    const/4 v12, 0x0

    invoke-virtual {v11, v12}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setHasCrc(Z)V

    .line 1505
    const-wide/16 v12, 0x0

    invoke-virtual {v11, v12, v13}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setSize(J)V

    .line 1506
    add-int/lit8 v9, v9, 0x1

    .line 1482
    .end local v11    # "entryAtIndex":Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    :goto_7
    add-int/lit8 v10, v10, 0x1

    goto/16 :goto_1

    .line 1509
    .end local v10    # "i":I
    :cond_9
    new-instance v10, Ljava/util/ArrayList;

    invoke-direct {v10}, Ljava/util/ArrayList;-><init>()V

    .line 1510
    .local v10, "entries":Ljava/util/List;, "Ljava/util/List<Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    invoke-interface {v4}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v11

    invoke-interface {v11}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v11

    :goto_8
    invoke-interface {v11}, Ljava/util/Iterator;->hasNext()Z

    move-result v12

    if-eqz v12, :cond_b

    invoke-interface {v11}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    .line 1511
    .local v12, "e":Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    if-eqz v12, :cond_a

    .line 1512
    invoke-interface {v10, v12}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1514
    .end local v12    # "e":Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    :cond_a
    goto :goto_8

    .line 1515
    :cond_b
    sget-object v11, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->EMPTY_SEVEN_Z_ARCHIVE_ENTRY_ARRAY:[Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    invoke-interface {v10, v11}, Ljava/util/List;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v11

    check-cast v11, [Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    iput-object v11, v2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->files:[Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    .line 1516
    invoke-direct {v0, v2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->calculateStreamMap(Lorg/apache/commons/compress/archivers/sevenz/Archive;)V

    .line 1517
    return-void

    .line 1379
    .end local v9    # "emptyFileCounter":I
    .end local v10    # "entries":Ljava/util/List;, "Ljava/util/List<Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .local v8, "propertyType":I
    :cond_c
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v9

    .line 1380
    .local v9, "size":J
    packed-switch v8, :pswitch_data_0

    .line 1475
    :pswitch_0
    move-object/from16 v16, v4

    move-object/from16 v17, v6

    move-object/from16 v18, v7

    .end local v4    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .end local v6    # "isEmptyFile":Ljava/util/BitSet;
    .end local v7    # "isAnti":Ljava/util/BitSet;
    .local v16, "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .local v17, "isEmptyFile":Ljava/util/BitSet;
    .local v18, "isAnti":Ljava/util/BitSet;
    invoke-static {v1, v9, v10}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->skipBytesFully(Ljava/nio/ByteBuffer;J)J

    goto/16 :goto_f

    .line 1469
    .end local v16    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .end local v17    # "isEmptyFile":Ljava/util/BitSet;
    .end local v18    # "isAnti":Ljava/util/BitSet;
    .restart local v4    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .restart local v6    # "isEmptyFile":Ljava/util/BitSet;
    .restart local v7    # "isAnti":Ljava/util/BitSet;
    :pswitch_1
    invoke-static {v1, v9, v10}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->skipBytesFully(Ljava/nio/ByteBuffer;J)J

    .line 1470
    move-object/from16 v16, v4

    move-object/from16 v17, v6

    move-object/from16 v18, v7

    goto/16 :goto_f

    .line 1453
    :pswitch_2
    invoke-direct {v0, v1, v3}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readAllOrBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;

    move-result-object v11

    .line 1454
    .local v11, "attributesDefined":Ljava/util/BitSet;
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    .line 1455
    const/4 v12, 0x0

    .local v12, "i":I
    :goto_9
    if-ge v12, v3, :cond_e

    .line 1456
    invoke-direct {v0, v4, v12}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->checkEntryIsInitialized(Ljava/util/Map;I)V

    .line 1457
    invoke-static {v12}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    invoke-interface {v4, v13}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    .line 1458
    .local v13, "entryAtIndex":Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    invoke-virtual {v11, v12}, Ljava/util/BitSet;->get(I)Z

    move-result v14

    invoke-virtual {v13, v14}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setHasWindowsAttributes(Z)V

    .line 1459
    invoke-virtual {v13}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getHasWindowsAttributes()Z

    move-result v14

    if-eqz v14, :cond_d

    .line 1460
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getInt(Ljava/nio/ByteBuffer;)I

    move-result v14

    invoke-virtual {v13, v14}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setWindowsAttributes(I)V

    .line 1455
    .end local v13    # "entryAtIndex":Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    :cond_d
    add-int/lit8 v12, v12, 0x1

    goto :goto_9

    .line 1463
    .end local v12    # "i":I
    :cond_e
    move-object/from16 v16, v4

    move-object/from16 v17, v6

    move-object/from16 v18, v7

    goto/16 :goto_f

    .line 1440
    .end local v11    # "attributesDefined":Ljava/util/BitSet;
    :pswitch_3
    invoke-direct {v0, v1, v3}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readAllOrBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;

    move-result-object v11

    .line 1441
    .local v11, "timesDefined":Ljava/util/BitSet;
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    .line 1442
    const/4 v12, 0x0

    .restart local v12    # "i":I
    :goto_a
    if-ge v12, v3, :cond_10

    .line 1443
    invoke-direct {v0, v4, v12}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->checkEntryIsInitialized(Ljava/util/Map;I)V

    .line 1444
    invoke-static {v12}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    invoke-interface {v4, v13}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    .line 1445
    .restart local v13    # "entryAtIndex":Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    invoke-virtual {v11, v12}, Ljava/util/BitSet;->get(I)Z

    move-result v14

    invoke-virtual {v13, v14}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setHasLastModifiedDate(Z)V

    .line 1446
    invoke-virtual {v13}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getHasLastModifiedDate()Z

    move-result v14

    if-eqz v14, :cond_f

    .line 1447
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getLong(Ljava/nio/ByteBuffer;)J

    move-result-wide v14

    invoke-virtual {v13, v14, v15}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setLastModifiedDate(J)V

    .line 1442
    .end local v13    # "entryAtIndex":Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    :cond_f
    add-int/lit8 v12, v12, 0x1

    goto :goto_a

    .line 1450
    .end local v12    # "i":I
    :cond_10
    move-object/from16 v16, v4

    move-object/from16 v17, v6

    move-object/from16 v18, v7

    goto/16 :goto_f

    .line 1427
    .end local v11    # "timesDefined":Ljava/util/BitSet;
    :pswitch_4
    invoke-direct {v0, v1, v3}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readAllOrBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;

    move-result-object v11

    .line 1428
    .restart local v11    # "timesDefined":Ljava/util/BitSet;
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    .line 1429
    const/4 v12, 0x0

    .restart local v12    # "i":I
    :goto_b
    if-ge v12, v3, :cond_12

    .line 1430
    invoke-direct {v0, v4, v12}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->checkEntryIsInitialized(Ljava/util/Map;I)V

    .line 1431
    invoke-static {v12}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    invoke-interface {v4, v13}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    .line 1432
    .restart local v13    # "entryAtIndex":Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    invoke-virtual {v11, v12}, Ljava/util/BitSet;->get(I)Z

    move-result v14

    invoke-virtual {v13, v14}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setHasAccessDate(Z)V

    .line 1433
    invoke-virtual {v13}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getHasAccessDate()Z

    move-result v14

    if-eqz v14, :cond_11

    .line 1434
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getLong(Ljava/nio/ByteBuffer;)J

    move-result-wide v14

    invoke-virtual {v13, v14, v15}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setAccessDate(J)V

    .line 1429
    .end local v13    # "entryAtIndex":Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    :cond_11
    add-int/lit8 v12, v12, 0x1

    goto :goto_b

    .line 1437
    .end local v12    # "i":I
    :cond_12
    move-object/from16 v16, v4

    move-object/from16 v17, v6

    move-object/from16 v18, v7

    goto/16 :goto_f

    .line 1414
    .end local v11    # "timesDefined":Ljava/util/BitSet;
    :pswitch_5
    invoke-direct {v0, v1, v3}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readAllOrBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;

    move-result-object v11

    .line 1415
    .restart local v11    # "timesDefined":Ljava/util/BitSet;
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    .line 1416
    const/4 v12, 0x0

    .restart local v12    # "i":I
    :goto_c
    if-ge v12, v3, :cond_14

    .line 1417
    invoke-direct {v0, v4, v12}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->checkEntryIsInitialized(Ljava/util/Map;I)V

    .line 1418
    invoke-static {v12}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    invoke-interface {v4, v13}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    .line 1419
    .restart local v13    # "entryAtIndex":Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    invoke-virtual {v11, v12}, Ljava/util/BitSet;->get(I)Z

    move-result v14

    invoke-virtual {v13, v14}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setHasCreationDate(Z)V

    .line 1420
    invoke-virtual {v13}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getHasCreationDate()Z

    move-result v14

    if-eqz v14, :cond_13

    .line 1421
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getLong(Ljava/nio/ByteBuffer;)J

    move-result-wide v14

    invoke-virtual {v13, v14, v15}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setCreationDate(J)V

    .line 1416
    .end local v13    # "entryAtIndex":Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    :cond_13
    add-int/lit8 v12, v12, 0x1

    goto :goto_c

    .line 1424
    .end local v12    # "i":I
    :cond_14
    move-object/from16 v16, v4

    move-object/from16 v17, v6

    move-object/from16 v18, v7

    goto/16 :goto_f

    .line 1394
    .end local v11    # "timesDefined":Ljava/util/BitSet;
    :pswitch_6
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    .line 1395
    const-wide/16 v11, 0x1

    sub-long v11, v9, v11

    long-to-int v11, v11

    new-array v11, v11, [B

    .line 1396
    .local v11, "names":[B
    array-length v12, v11

    .line 1397
    .local v12, "namesLength":I
    invoke-static {v1, v11}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->get(Ljava/nio/ByteBuffer;[B)V

    .line 1398
    const/4 v13, 0x0

    .line 1399
    .local v13, "nextFile":I
    const/4 v14, 0x0

    .line 1400
    .local v14, "nextName":I
    const/4 v15, 0x0

    .local v15, "i":I
    :goto_d
    if-ge v15, v12, :cond_16

    .line 1401
    aget-byte v16, v11, v15

    if-nez v16, :cond_15

    add-int/lit8 v16, v15, 0x1

    aget-byte v16, v11, v16

    if-nez v16, :cond_15

    .line 1402
    invoke-direct {v0, v4, v13}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->checkEntryIsInitialized(Ljava/util/Map;I)V

    .line 1403
    invoke-static {v13}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v4, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    move-object/from16 v16, v4

    .end local v4    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .restart local v16    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    new-instance v4, Ljava/lang/String;

    move-object/from16 v17, v6

    .end local v6    # "isEmptyFile":Ljava/util/BitSet;
    .restart local v17    # "isEmptyFile":Ljava/util/BitSet;
    sub-int v6, v15, v14

    move-object/from16 v18, v7

    .end local v7    # "isAnti":Ljava/util/BitSet;
    .restart local v18    # "isAnti":Ljava/util/BitSet;
    sget-object v7, Ljava/nio/charset/StandardCharsets;->UTF_16LE:Ljava/nio/charset/Charset;

    invoke-direct {v4, v11, v14, v6, v7}, Ljava/lang/String;-><init>([BIILjava/nio/charset/Charset;)V

    invoke-virtual {v2, v4}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setName(Ljava/lang/String;)V

    .line 1404
    add-int/lit8 v2, v15, 0x2

    .line 1405
    .end local v14    # "nextName":I
    .local v2, "nextName":I
    add-int/lit8 v13, v13, 0x1

    move v14, v2

    goto :goto_e

    .line 1401
    .end local v2    # "nextName":I
    .end local v16    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .end local v17    # "isEmptyFile":Ljava/util/BitSet;
    .end local v18    # "isAnti":Ljava/util/BitSet;
    .restart local v4    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .restart local v6    # "isEmptyFile":Ljava/util/BitSet;
    .restart local v7    # "isAnti":Ljava/util/BitSet;
    .restart local v14    # "nextName":I
    :cond_15
    move-object/from16 v16, v4

    move-object/from16 v17, v6

    move-object/from16 v18, v7

    .line 1400
    .end local v4    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .end local v6    # "isEmptyFile":Ljava/util/BitSet;
    .end local v7    # "isAnti":Ljava/util/BitSet;
    .restart local v16    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .restart local v17    # "isEmptyFile":Ljava/util/BitSet;
    .restart local v18    # "isAnti":Ljava/util/BitSet;
    :goto_e
    add-int/lit8 v15, v15, 0x2

    move-object/from16 v2, p2

    move-object/from16 v4, v16

    move-object/from16 v6, v17

    move-object/from16 v7, v18

    goto :goto_d

    .end local v16    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .end local v17    # "isEmptyFile":Ljava/util/BitSet;
    .end local v18    # "isAnti":Ljava/util/BitSet;
    .restart local v4    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .restart local v6    # "isEmptyFile":Ljava/util/BitSet;
    .restart local v7    # "isAnti":Ljava/util/BitSet;
    :cond_16
    move-object/from16 v16, v4

    move-object/from16 v17, v6

    move-object/from16 v18, v7

    .line 1408
    .end local v4    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .end local v6    # "isEmptyFile":Ljava/util/BitSet;
    .end local v7    # "isAnti":Ljava/util/BitSet;
    .end local v15    # "i":I
    .restart local v16    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .restart local v17    # "isEmptyFile":Ljava/util/BitSet;
    .restart local v18    # "isAnti":Ljava/util/BitSet;
    if-ne v14, v12, :cond_17

    if-ne v13, v3, :cond_17

    goto :goto_f

    .line 1409
    :cond_17
    new-instance v2, Ljava/io/IOException;

    const-string v4, "Error parsing file names"

    invoke-direct {v2, v4}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 1390
    .end local v11    # "names":[B
    .end local v12    # "namesLength":I
    .end local v13    # "nextFile":I
    .end local v14    # "nextName":I
    .end local v16    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .end local v17    # "isEmptyFile":Ljava/util/BitSet;
    .end local v18    # "isAnti":Ljava/util/BitSet;
    .restart local v4    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .restart local v6    # "isEmptyFile":Ljava/util/BitSet;
    .restart local v7    # "isAnti":Ljava/util/BitSet;
    :pswitch_7
    move-object/from16 v16, v4

    move-object/from16 v17, v6

    move-object/from16 v18, v7

    .end local v4    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .end local v6    # "isEmptyFile":Ljava/util/BitSet;
    .end local v7    # "isAnti":Ljava/util/BitSet;
    .restart local v16    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .restart local v17    # "isEmptyFile":Ljava/util/BitSet;
    .restart local v18    # "isAnti":Ljava/util/BitSet;
    invoke-virtual {v5}, Ljava/util/BitSet;->cardinality()I

    move-result v2

    invoke-direct {v0, v1, v2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;

    move-result-object v2

    .line 1391
    .end local v18    # "isAnti":Ljava/util/BitSet;
    .local v2, "isAnti":Ljava/util/BitSet;
    move-object v7, v2

    goto :goto_10

    .line 1386
    .end local v2    # "isAnti":Ljava/util/BitSet;
    .end local v16    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .end local v17    # "isEmptyFile":Ljava/util/BitSet;
    .restart local v4    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .restart local v6    # "isEmptyFile":Ljava/util/BitSet;
    .restart local v7    # "isAnti":Ljava/util/BitSet;
    :pswitch_8
    move-object/from16 v16, v4

    move-object/from16 v17, v6

    move-object/from16 v18, v7

    .end local v4    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .end local v6    # "isEmptyFile":Ljava/util/BitSet;
    .end local v7    # "isAnti":Ljava/util/BitSet;
    .restart local v16    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .restart local v17    # "isEmptyFile":Ljava/util/BitSet;
    .restart local v18    # "isAnti":Ljava/util/BitSet;
    invoke-virtual {v5}, Ljava/util/BitSet;->cardinality()I

    move-result v2

    invoke-direct {v0, v1, v2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;

    move-result-object v2

    .line 1387
    .end local v17    # "isEmptyFile":Ljava/util/BitSet;
    .local v2, "isEmptyFile":Ljava/util/BitSet;
    move-object v6, v2

    goto :goto_10

    .line 1382
    .end local v2    # "isEmptyFile":Ljava/util/BitSet;
    .end local v16    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .end local v18    # "isAnti":Ljava/util/BitSet;
    .restart local v4    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .restart local v6    # "isEmptyFile":Ljava/util/BitSet;
    .restart local v7    # "isAnti":Ljava/util/BitSet;
    :pswitch_9
    move-object/from16 v16, v4

    move-object/from16 v17, v6

    move-object/from16 v18, v7

    .end local v4    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .end local v6    # "isEmptyFile":Ljava/util/BitSet;
    .end local v7    # "isAnti":Ljava/util/BitSet;
    .restart local v16    # "fileMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;>;"
    .restart local v17    # "isEmptyFile":Ljava/util/BitSet;
    .restart local v18    # "isAnti":Ljava/util/BitSet;
    invoke-direct {v0, v1, v3}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;

    move-result-object v2

    .line 1383
    .end local v5    # "isEmptyStream":Ljava/util/BitSet;
    .local v2, "isEmptyStream":Ljava/util/BitSet;
    move-object v5, v2

    goto :goto_10

    .line 1479
    .end local v2    # "isEmptyStream":Ljava/util/BitSet;
    .end local v8    # "propertyType":I
    .end local v9    # "size":J
    .restart local v5    # "isEmptyStream":Ljava/util/BitSet;
    :goto_f
    move-object/from16 v6, v17

    move-object/from16 v7, v18

    .end local v17    # "isEmptyFile":Ljava/util/BitSet;
    .end local v18    # "isAnti":Ljava/util/BitSet;
    .restart local v6    # "isEmptyFile":Ljava/util/BitSet;
    .restart local v7    # "isAnti":Ljava/util/BitSet;
    :goto_10
    move-object/from16 v2, p2

    move-object/from16 v4, v16

    goto/16 :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0xe
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method private readFolder(Ljava/nio/ByteBuffer;)Lorg/apache/commons/compress/archivers/sevenz/Folder;
    .locals 20
    .param p1, "header"    # Ljava/nio/ByteBuffer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1144
    move-object/from16 v0, p1

    new-instance v1, Lorg/apache/commons/compress/archivers/sevenz/Folder;

    invoke-direct {v1}, Lorg/apache/commons/compress/archivers/sevenz/Folder;-><init>()V

    .line 1146
    .local v1, "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v2

    .line 1147
    .local v2, "numCoders":J
    long-to-int v4, v2

    new-array v4, v4, [Lorg/apache/commons/compress/archivers/sevenz/Coder;

    .line 1148
    .local v4, "coders":[Lorg/apache/commons/compress/archivers/sevenz/Coder;
    const-wide/16 v5, 0x0

    .line 1149
    .local v5, "totalInStreams":J
    const-wide/16 v7, 0x0

    .line 1150
    .local v7, "totalOutStreams":J
    const/4 v9, 0x0

    .local v9, "i":I
    :goto_0
    array-length v10, v4

    if-ge v9, v10, :cond_6

    .line 1151
    new-instance v10, Lorg/apache/commons/compress/archivers/sevenz/Coder;

    invoke-direct {v10}, Lorg/apache/commons/compress/archivers/sevenz/Coder;-><init>()V

    aput-object v10, v4, v9

    .line 1152
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v10

    .line 1153
    .local v10, "bits":I
    and-int/lit8 v14, v10, 0xf

    .line 1154
    .local v14, "idSize":I
    and-int/lit8 v15, v10, 0x10

    const/16 v16, 0x1

    if-nez v15, :cond_0

    move/from16 v15, v16

    goto :goto_1

    :cond_0
    const/4 v15, 0x0

    .line 1155
    .local v15, "isSimple":Z
    :goto_1
    and-int/lit8 v17, v10, 0x20

    if-eqz v17, :cond_1

    move/from16 v17, v16

    goto :goto_2

    :cond_1
    const/16 v17, 0x0

    .line 1156
    .local v17, "hasAttributes":Z
    :goto_2
    and-int/lit16 v11, v10, 0x80

    if-eqz v11, :cond_2

    move/from16 v11, v16

    goto :goto_3

    :cond_2
    const/4 v11, 0x0

    .line 1158
    .local v11, "moreAlternativeMethods":Z
    :goto_3
    aget-object v12, v4, v9

    new-array v13, v14, [B

    iput-object v13, v12, Lorg/apache/commons/compress/archivers/sevenz/Coder;->decompressionMethodId:[B

    .line 1159
    aget-object v12, v4, v9

    iget-object v12, v12, Lorg/apache/commons/compress/archivers/sevenz/Coder;->decompressionMethodId:[B

    invoke-static {v0, v12}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->get(Ljava/nio/ByteBuffer;[B)V

    .line 1160
    if-eqz v15, :cond_3

    .line 1161
    aget-object v12, v4, v9

    move-wide/from16 v18, v2

    const-wide/16 v2, 0x1

    .end local v2    # "numCoders":J
    .local v18, "numCoders":J
    iput-wide v2, v12, Lorg/apache/commons/compress/archivers/sevenz/Coder;->numInStreams:J

    .line 1162
    aget-object v12, v4, v9

    iput-wide v2, v12, Lorg/apache/commons/compress/archivers/sevenz/Coder;->numOutStreams:J

    goto :goto_4

    .line 1164
    .end local v18    # "numCoders":J
    .restart local v2    # "numCoders":J
    :cond_3
    move-wide/from16 v18, v2

    .end local v2    # "numCoders":J
    .restart local v18    # "numCoders":J
    aget-object v2, v4, v9

    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v12

    iput-wide v12, v2, Lorg/apache/commons/compress/archivers/sevenz/Coder;->numInStreams:J

    .line 1165
    aget-object v2, v4, v9

    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v12

    iput-wide v12, v2, Lorg/apache/commons/compress/archivers/sevenz/Coder;->numOutStreams:J

    .line 1167
    :goto_4
    aget-object v2, v4, v9

    iget-wide v2, v2, Lorg/apache/commons/compress/archivers/sevenz/Coder;->numInStreams:J

    add-long/2addr v5, v2

    .line 1168
    aget-object v2, v4, v9

    iget-wide v2, v2, Lorg/apache/commons/compress/archivers/sevenz/Coder;->numOutStreams:J

    add-long/2addr v7, v2

    .line 1169
    if-eqz v17, :cond_4

    .line 1170
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v2

    .line 1171
    .local v2, "propertiesSize":J
    aget-object v12, v4, v9

    long-to-int v13, v2

    new-array v13, v13, [B

    iput-object v13, v12, Lorg/apache/commons/compress/archivers/sevenz/Coder;->properties:[B

    .line 1172
    aget-object v12, v4, v9

    iget-object v12, v12, Lorg/apache/commons/compress/archivers/sevenz/Coder;->properties:[B

    invoke-static {v0, v12}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->get(Ljava/nio/ByteBuffer;[B)V

    .line 1175
    .end local v2    # "propertiesSize":J
    :cond_4
    if-nez v11, :cond_5

    .line 1150
    .end local v10    # "bits":I
    .end local v11    # "moreAlternativeMethods":Z
    .end local v14    # "idSize":I
    .end local v15    # "isSimple":Z
    .end local v17    # "hasAttributes":Z
    add-int/lit8 v9, v9, 0x1

    move-wide/from16 v2, v18

    goto :goto_0

    .line 1176
    .restart local v10    # "bits":I
    .restart local v11    # "moreAlternativeMethods":Z
    .restart local v14    # "idSize":I
    .restart local v15    # "isSimple":Z
    .restart local v17    # "hasAttributes":Z
    :cond_5
    new-instance v2, Ljava/io/IOException;

    const-string v3, "Alternative methods are unsupported, please report. The reference implementation doesn\'t support them either."

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 1150
    .end local v10    # "bits":I
    .end local v11    # "moreAlternativeMethods":Z
    .end local v14    # "idSize":I
    .end local v15    # "isSimple":Z
    .end local v17    # "hasAttributes":Z
    .end local v18    # "numCoders":J
    .local v2, "numCoders":J
    :cond_6
    move-wide/from16 v18, v2

    .line 1180
    .end local v2    # "numCoders":J
    .end local v9    # "i":I
    .restart local v18    # "numCoders":J
    iput-object v4, v1, Lorg/apache/commons/compress/archivers/sevenz/Folder;->coders:[Lorg/apache/commons/compress/archivers/sevenz/Coder;

    .line 1181
    iput-wide v5, v1, Lorg/apache/commons/compress/archivers/sevenz/Folder;->totalInputStreams:J

    .line 1182
    iput-wide v7, v1, Lorg/apache/commons/compress/archivers/sevenz/Folder;->totalOutputStreams:J

    .line 1184
    const-wide/16 v2, 0x1

    sub-long v9, v7, v2

    .line 1185
    .local v9, "numBindPairs":J
    long-to-int v2, v9

    new-array v2, v2, [Lorg/apache/commons/compress/archivers/sevenz/BindPair;

    .line 1186
    .local v2, "bindPairs":[Lorg/apache/commons/compress/archivers/sevenz/BindPair;
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_5
    array-length v11, v2

    if-ge v3, v11, :cond_7

    .line 1187
    new-instance v11, Lorg/apache/commons/compress/archivers/sevenz/BindPair;

    invoke-direct {v11}, Lorg/apache/commons/compress/archivers/sevenz/BindPair;-><init>()V

    aput-object v11, v2, v3

    .line 1188
    aget-object v11, v2, v3

    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v12

    iput-wide v12, v11, Lorg/apache/commons/compress/archivers/sevenz/BindPair;->inIndex:J

    .line 1189
    aget-object v11, v2, v3

    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v12

    iput-wide v12, v11, Lorg/apache/commons/compress/archivers/sevenz/BindPair;->outIndex:J

    .line 1186
    add-int/lit8 v3, v3, 0x1

    goto :goto_5

    .line 1191
    .end local v3    # "i":I
    :cond_7
    iput-object v2, v1, Lorg/apache/commons/compress/archivers/sevenz/Folder;->bindPairs:[Lorg/apache/commons/compress/archivers/sevenz/BindPair;

    .line 1193
    sub-long v11, v5, v9

    .line 1194
    .local v11, "numPackedStreams":J
    long-to-int v3, v11

    new-array v3, v3, [J

    .line 1195
    .local v3, "packedStreams":[J
    const-wide/16 v13, 0x1

    cmp-long v13, v11, v13

    if-nez v13, :cond_a

    .line 1197
    const/4 v13, 0x0

    .local v13, "i":I
    :goto_6
    long-to-int v14, v5

    if-ge v13, v14, :cond_9

    .line 1198
    invoke-virtual {v1, v13}, Lorg/apache/commons/compress/archivers/sevenz/Folder;->findBindPairForInStream(I)I

    move-result v14

    if-gez v14, :cond_8

    .line 1199
    goto :goto_7

    .line 1197
    :cond_8
    add-int/lit8 v13, v13, 0x1

    goto :goto_6

    .line 1202
    :cond_9
    :goto_7
    int-to-long v14, v13

    const/16 v16, 0x0

    aput-wide v14, v3, v16

    .line 1203
    .end local v13    # "i":I
    goto :goto_9

    .line 1204
    :cond_a
    const/4 v13, 0x0

    .restart local v13    # "i":I
    :goto_8
    long-to-int v14, v11

    if-ge v13, v14, :cond_b

    .line 1205
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v14

    aput-wide v14, v3, v13

    .line 1204
    add-int/lit8 v13, v13, 0x1

    goto :goto_8

    .line 1208
    .end local v13    # "i":I
    :cond_b
    :goto_9
    iput-object v3, v1, Lorg/apache/commons/compress/archivers/sevenz/Folder;->packedStreams:[J

    .line 1210
    return-object v1
.end method

.method private readFully(Ljava/nio/ByteBuffer;)V
    .locals 1
    .param p1, "buf"    # Ljava/nio/ByteBuffer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2019
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    .line 2020
    iget-object v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    invoke-static {v0, p1}, Lorg/apache/commons/compress/utils/IOUtils;->readFully(Ljava/nio/channels/ReadableByteChannel;Ljava/nio/ByteBuffer;)V

    .line 2021
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    .line 2022
    return-void
.end method

.method private readHeader(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/Archive;)V
    .locals 5
    .param p1, "header"    # Ljava/nio/ByteBuffer;
    .param p2, "archive"    # Lorg/apache/commons/compress/archivers/sevenz/Archive;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 583
    invoke-virtual {p1}, Ljava/nio/ByteBuffer;->position()I

    move-result v0

    .line 584
    .local v0, "pos":I
    invoke-direct {p0, p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->sanityCheckAndCollectStatistics(Ljava/nio/ByteBuffer;)Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;

    move-result-object v1

    .line 585
    .local v1, "stats":Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;
    iget-object v2, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->options:Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;

    invoke-virtual {v2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;->getMaxMemoryLimitInKb()I

    move-result v2

    invoke-virtual {v1, v2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->assertValidity(I)V

    .line 586
    invoke-virtual {p1, v0}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    .line 588
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v2

    .line 590
    .local v2, "nid":I
    const/4 v3, 0x2

    if-ne v2, v3, :cond_0

    .line 591
    invoke-direct {p0, p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readArchiveProperties(Ljava/nio/ByteBuffer;)V

    .line 592
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v2

    .line 595
    :cond_0
    const/4 v3, 0x3

    if-eq v2, v3, :cond_3

    .line 600
    const/4 v3, 0x4

    if-ne v2, v3, :cond_1

    .line 601
    invoke-direct {p0, p1, p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readStreamsInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/Archive;)V

    .line 602
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v2

    .line 605
    :cond_1
    const/4 v3, 0x5

    if-ne v2, v3, :cond_2

    .line 606
    invoke-direct {p0, p1, p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readFilesInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/Archive;)V

    .line 607
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v2

    .line 609
    :cond_2
    return-void

    .line 596
    :cond_3
    new-instance v3, Ljava/io/IOException;

    const-string v4, "Additional streams unsupported"

    invoke-direct {v3, v4}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v3
.end method

.method private readHeaders([B)Lorg/apache/commons/compress/archivers/sevenz/Archive;
    .locals 11
    .param p1, "password"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 437
    const/16 v0, 0xc

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    sget-object v1, Ljava/nio/ByteOrder;->LITTLE_ENDIAN:Ljava/nio/ByteOrder;

    .line 438
    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 439
    .local v0, "buf":Ljava/nio/ByteBuffer;
    invoke-direct {p0, v0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readFully(Ljava/nio/ByteBuffer;)V

    .line 440
    const/4 v1, 0x6

    new-array v1, v1, [B

    .line 441
    .local v1, "signature":[B
    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 442
    sget-object v2, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->sevenZSignature:[B

    invoke-static {v1, v2}, Ljava/util/Arrays;->equals([B[B)Z

    move-result v2

    if-eqz v2, :cond_6

    .line 446
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->get()B

    move-result v2

    .line 447
    .local v2, "archiveVersionMajor":B
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->get()B

    move-result v3

    .line 448
    .local v3, "archiveVersionMinor":B
    if-nez v2, :cond_5

    .line 453
    const/4 v4, 0x0

    .line 454
    .local v4, "headerLooksValid":Z
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v5

    int-to-long v5, v5

    const-wide v7, 0xffffffffL

    and-long/2addr v5, v7

    .line 455
    .local v5, "startHeaderCrc":J
    const-wide/16 v7, 0x0

    cmp-long v7, v5, v7

    if-nez v7, :cond_2

    .line 457
    iget-object v7, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    invoke-interface {v7}, Ljava/nio/channels/SeekableByteChannel;->position()J

    move-result-wide v7

    .line 458
    .local v7, "currentPosition":J
    const/16 v9, 0x14

    invoke-static {v9}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v9

    .line 459
    .local v9, "peekBuf":Ljava/nio/ByteBuffer;
    invoke-direct {p0, v9}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readFully(Ljava/nio/ByteBuffer;)V

    .line 460
    iget-object v10, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    invoke-interface {v10, v7, v8}, Ljava/nio/channels/SeekableByteChannel;->position(J)Ljava/nio/channels/SeekableByteChannel;

    .line 462
    :cond_0
    invoke-virtual {v9}, Ljava/nio/ByteBuffer;->hasRemaining()Z

    move-result v10

    if-eqz v10, :cond_1

    .line 463
    invoke-virtual {v9}, Ljava/nio/ByteBuffer;->get()B

    move-result v10

    if-eqz v10, :cond_0

    .line 464
    const/4 v4, 0x1

    .line 465
    nop

    .line 468
    .end local v7    # "currentPosition":J
    .end local v9    # "peekBuf":Ljava/nio/ByteBuffer;
    :cond_1
    goto :goto_0

    .line 469
    :cond_2
    const/4 v4, 0x1

    .line 472
    :goto_0
    if-eqz v4, :cond_3

    .line 473
    invoke-direct {p0, v5, v6}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readStartHeader(J)Lorg/apache/commons/compress/archivers/sevenz/StartHeader;

    move-result-object v7

    .line 474
    .local v7, "startHeader":Lorg/apache/commons/compress/archivers/sevenz/StartHeader;
    const/4 v8, 0x1

    invoke-direct {p0, v7, p1, v8}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->initializeArchive(Lorg/apache/commons/compress/archivers/sevenz/StartHeader;[BZ)Lorg/apache/commons/compress/archivers/sevenz/Archive;

    move-result-object v8

    return-object v8

    .line 477
    .end local v7    # "startHeader":Lorg/apache/commons/compress/archivers/sevenz/StartHeader;
    :cond_3
    iget-object v7, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->options:Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;

    invoke-virtual {v7}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;->getTryToRecoverBrokenArchives()Z

    move-result v7

    if-eqz v7, :cond_4

    .line 478
    invoke-direct {p0, p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->tryToLocateEndHeader([B)Lorg/apache/commons/compress/archivers/sevenz/Archive;

    move-result-object v7

    return-object v7

    .line 480
    :cond_4
    new-instance v7, Ljava/io/IOException;

    const-string v8, "archive seems to be invalid.\nYou may want to retry and enable the tryToRecoverBrokenArchives if the archive could be a multi volume archive that has been closed prematurely."

    invoke-direct {v7, v8}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v7

    .line 449
    .end local v4    # "headerLooksValid":Z
    .end local v5    # "startHeaderCrc":J
    :cond_5
    new-instance v4, Ljava/io/IOException;

    .line 450
    invoke-static {v2}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v5

    invoke-static {v3}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v6

    filled-new-array {v5, v6}, [Ljava/lang/Object;

    move-result-object v5

    .line 449
    const-string v6, "Unsupported 7z version (%d,%d)"

    invoke-static {v6, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 443
    .end local v2    # "archiveVersionMajor":B
    .end local v3    # "archiveVersionMinor":B
    :cond_6
    new-instance v2, Ljava/io/IOException;

    const-string v3, "Bad 7z signature"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method private readPackInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/Archive;)V
    .locals 8
    .param p1, "header"    # Ljava/nio/ByteBuffer;
    .param p2, "archive"    # Lorg/apache/commons/compress/archivers/sevenz/Archive;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 799
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v0

    iput-wide v0, p2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->packPos:J

    .line 800
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v0

    long-to-int v0, v0

    .line 801
    .local v0, "numPackStreamsInt":I
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v1

    .line 802
    .local v1, "nid":I
    const/16 v2, 0x9

    if-ne v1, v2, :cond_1

    .line 803
    new-array v2, v0, [J

    iput-object v2, p2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->packSizes:[J

    .line 804
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    iget-object v3, p2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->packSizes:[J

    array-length v3, v3

    if-ge v2, v3, :cond_0

    .line 805
    iget-object v3, p2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->packSizes:[J

    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v4

    aput-wide v4, v3, v2

    .line 804
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 807
    .end local v2    # "i":I
    :cond_0
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v1

    .line 810
    :cond_1
    const/16 v2, 0xa

    if-ne v1, v2, :cond_4

    .line 811
    invoke-direct {p0, p1, v0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readAllOrBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;

    move-result-object v2

    iput-object v2, p2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->packCrcsDefined:Ljava/util/BitSet;

    .line 812
    new-array v2, v0, [J

    iput-object v2, p2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->packCrcs:[J

    .line 813
    const/4 v2, 0x0

    .restart local v2    # "i":I
    :goto_1
    if-ge v2, v0, :cond_3

    .line 814
    iget-object v3, p2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->packCrcsDefined:Ljava/util/BitSet;

    invoke-virtual {v3, v2}, Ljava/util/BitSet;->get(I)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 815
    iget-object v3, p2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->packCrcs:[J

    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getInt(Ljava/nio/ByteBuffer;)I

    move-result v4

    int-to-long v4, v4

    const-wide v6, 0xffffffffL

    and-long/2addr v4, v6

    aput-wide v4, v3, v2

    .line 813
    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 819
    .end local v2    # "i":I
    :cond_3
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v1

    .line 821
    :cond_4
    return-void
.end method

.method private readStartHeader(J)Lorg/apache/commons/compress/archivers/sevenz/StartHeader;
    .locals 9
    .param p1, "startHeaderCrc"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 558
    new-instance v0, Lorg/apache/commons/compress/archivers/sevenz/StartHeader;

    invoke-direct {v0}, Lorg/apache/commons/compress/archivers/sevenz/StartHeader;-><init>()V

    .line 561
    .local v0, "startHeader":Lorg/apache/commons/compress/archivers/sevenz/StartHeader;
    new-instance v1, Ljava/io/DataInputStream;

    new-instance v8, Lorg/apache/commons/compress/utils/CRC32VerifyingInputStream;

    new-instance v3, Lorg/apache/commons/compress/archivers/sevenz/BoundedSeekableByteChannelInputStream;

    iget-object v2, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    const-wide/16 v4, 0x14

    invoke-direct {v3, v2, v4, v5}, Lorg/apache/commons/compress/archivers/sevenz/BoundedSeekableByteChannelInputStream;-><init>(Ljava/nio/channels/SeekableByteChannel;J)V

    move-object v2, v8

    move-wide v6, p1

    invoke-direct/range {v2 .. v7}, Lorg/apache/commons/compress/utils/CRC32VerifyingInputStream;-><init>(Ljava/io/InputStream;JJ)V

    invoke-direct {v1, v8}, Ljava/io/DataInputStream;-><init>(Ljava/io/InputStream;)V

    .line 563
    .local v1, "dataInputStream":Ljava/io/DataInputStream;
    :try_start_0
    invoke-virtual {v1}, Ljava/io/DataInputStream;->readLong()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->reverseBytes(J)J

    move-result-wide v2

    iput-wide v2, v0, Lorg/apache/commons/compress/archivers/sevenz/StartHeader;->nextHeaderOffset:J

    .line 564
    iget-wide v2, v0, Lorg/apache/commons/compress/archivers/sevenz/StartHeader;->nextHeaderOffset:J

    const-wide/16 v4, 0x0

    cmp-long v2, v2, v4

    if-ltz v2, :cond_1

    iget-wide v2, v0, Lorg/apache/commons/compress/archivers/sevenz/StartHeader;->nextHeaderOffset:J

    const-wide/16 v4, 0x20

    add-long/2addr v2, v4

    iget-object v6, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    .line 565
    invoke-interface {v6}, Ljava/nio/channels/SeekableByteChannel;->size()J

    move-result-wide v6

    cmp-long v2, v2, v6

    if-gtz v2, :cond_1

    .line 569
    invoke-virtual {v1}, Ljava/io/DataInputStream;->readLong()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->reverseBytes(J)J

    move-result-wide v2

    iput-wide v2, v0, Lorg/apache/commons/compress/archivers/sevenz/StartHeader;->nextHeaderSize:J

    .line 570
    iget-wide v2, v0, Lorg/apache/commons/compress/archivers/sevenz/StartHeader;->nextHeaderOffset:J

    iget-wide v6, v0, Lorg/apache/commons/compress/archivers/sevenz/StartHeader;->nextHeaderSize:J

    add-long/2addr v2, v6

    .line 571
    .local v2, "nextHeaderEnd":J
    iget-wide v6, v0, Lorg/apache/commons/compress/archivers/sevenz/StartHeader;->nextHeaderOffset:J

    cmp-long v6, v2, v6

    if-ltz v6, :cond_0

    add-long/2addr v4, v2

    iget-object v6, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    .line 572
    invoke-interface {v6}, Ljava/nio/channels/SeekableByteChannel;->size()J

    move-result-wide v6

    cmp-long v4, v4, v6

    if-gtz v4, :cond_0

    .line 576
    invoke-virtual {v1}, Ljava/io/DataInputStream;->readInt()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->reverseBytes(I)I

    move-result v4

    int-to-long v4, v4

    const-wide v6, 0xffffffffL

    and-long/2addr v4, v6

    iput-wide v4, v0, Lorg/apache/commons/compress/archivers/sevenz/StartHeader;->nextHeaderCrc:J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 578
    nop

    .line 579
    invoke-virtual {v1}, Ljava/io/DataInputStream;->close()V

    .line 578
    return-object v0

    .line 573
    :cond_0
    :try_start_1
    new-instance v4, Ljava/io/IOException;

    const-string v5, "nextHeaderSize is out of bounds"

    invoke-direct {v4, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .end local v0    # "startHeader":Lorg/apache/commons/compress/archivers/sevenz/StartHeader;
    .end local v1    # "dataInputStream":Ljava/io/DataInputStream;
    .end local p1    # "startHeaderCrc":J
    throw v4

    .line 566
    .end local v2    # "nextHeaderEnd":J
    .restart local v0    # "startHeader":Lorg/apache/commons/compress/archivers/sevenz/StartHeader;
    .restart local v1    # "dataInputStream":Ljava/io/DataInputStream;
    .restart local p1    # "startHeaderCrc":J
    :cond_1
    new-instance v2, Ljava/io/IOException;

    const-string v3, "nextHeaderOffset is out of bounds"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .end local v0    # "startHeader":Lorg/apache/commons/compress/archivers/sevenz/StartHeader;
    .end local v1    # "dataInputStream":Ljava/io/DataInputStream;
    .end local p1    # "startHeaderCrc":J
    throw v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 561
    .restart local v0    # "startHeader":Lorg/apache/commons/compress/archivers/sevenz/StartHeader;
    .restart local v1    # "dataInputStream":Ljava/io/DataInputStream;
    .restart local p1    # "startHeaderCrc":J
    :catchall_0
    move-exception v2

    .end local v0    # "startHeader":Lorg/apache/commons/compress/archivers/sevenz/StartHeader;
    .end local v1    # "dataInputStream":Ljava/io/DataInputStream;
    .end local p1    # "startHeaderCrc":J
    :try_start_2
    throw v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 579
    .restart local v0    # "startHeader":Lorg/apache/commons/compress/archivers/sevenz/StartHeader;
    .restart local v1    # "dataInputStream":Ljava/io/DataInputStream;
    .restart local p1    # "startHeaderCrc":J
    :catchall_1
    move-exception v3

    :try_start_3
    invoke-virtual {v1}, Ljava/io/DataInputStream;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    goto :goto_0

    :catchall_2
    move-exception v4

    invoke-virtual {v2, v4}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_0
    throw v3
.end method

.method private readStreamsInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/Archive;)V
    .locals 2
    .param p1, "header"    # Ljava/nio/ByteBuffer;
    .param p2, "archive"    # Lorg/apache/commons/compress/archivers/sevenz/Archive;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 739
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    .line 741
    .local v0, "nid":I
    const/4 v1, 0x6

    if-ne v0, v1, :cond_0

    .line 742
    invoke-direct {p0, p1, p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readPackInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/Archive;)V

    .line 743
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    .line 746
    :cond_0
    const/4 v1, 0x7

    if-ne v0, v1, :cond_1

    .line 747
    invoke-direct {p0, p1, p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUnpackInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/Archive;)V

    .line 748
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    goto :goto_0

    .line 751
    :cond_1
    sget-object v1, Lorg/apache/commons/compress/archivers/sevenz/Folder;->EMPTY_FOLDER_ARRAY:[Lorg/apache/commons/compress/archivers/sevenz/Folder;

    iput-object v1, p2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->folders:[Lorg/apache/commons/compress/archivers/sevenz/Folder;

    .line 754
    :goto_0
    const/16 v1, 0x8

    if-ne v0, v1, :cond_2

    .line 755
    invoke-direct {p0, p1, p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readSubStreamsInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/Archive;)V

    .line 756
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    .line 758
    :cond_2
    return-void
.end method

.method private readSubStreamsInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/Archive;)V
    .locals 24
    .param p1, "header"    # Ljava/nio/ByteBuffer;
    .param p2, "archive"    # Lorg/apache/commons/compress/archivers/sevenz/Archive;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 972
    move-object/from16 v0, p2

    iget-object v1, v0, Lorg/apache/commons/compress/archivers/sevenz/Archive;->folders:[Lorg/apache/commons/compress/archivers/sevenz/Folder;

    array-length v2, v1

    const/4 v4, 0x0

    :goto_0
    const/4 v5, 0x1

    if-ge v4, v2, :cond_0

    aget-object v6, v1, v4

    .line 973
    .local v6, "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    iput v5, v6, Lorg/apache/commons/compress/archivers/sevenz/Folder;->numUnpackSubStreams:I

    .line 972
    .end local v6    # "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 975
    :cond_0
    iget-object v1, v0, Lorg/apache/commons/compress/archivers/sevenz/Archive;->folders:[Lorg/apache/commons/compress/archivers/sevenz/Folder;

    array-length v1, v1

    int-to-long v1, v1

    .line 977
    .local v1, "unpackStreamsCount":J
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v4

    .line 978
    .local v4, "nid":I
    const/16 v6, 0xd

    if-ne v4, v6, :cond_2

    .line 979
    const-wide/16 v1, 0x0

    .line 980
    iget-object v6, v0, Lorg/apache/commons/compress/archivers/sevenz/Archive;->folders:[Lorg/apache/commons/compress/archivers/sevenz/Folder;

    array-length v7, v6

    const/4 v8, 0x0

    :goto_1
    if-ge v8, v7, :cond_1

    aget-object v9, v6, v8

    .line 981
    .local v9, "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v10

    .line 982
    .local v10, "numStreams":J
    long-to-int v12, v10

    iput v12, v9, Lorg/apache/commons/compress/archivers/sevenz/Folder;->numUnpackSubStreams:I

    .line 983
    add-long/2addr v1, v10

    .line 980
    .end local v9    # "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    .end local v10    # "numStreams":J
    add-int/lit8 v8, v8, 0x1

    goto :goto_1

    .line 985
    :cond_1
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v4

    .line 988
    :cond_2
    long-to-int v6, v1

    .line 989
    .local v6, "totalUnpackStreams":I
    new-instance v7, Lorg/apache/commons/compress/archivers/sevenz/SubStreamsInfo;

    invoke-direct {v7}, Lorg/apache/commons/compress/archivers/sevenz/SubStreamsInfo;-><init>()V

    .line 990
    .local v7, "subStreamsInfo":Lorg/apache/commons/compress/archivers/sevenz/SubStreamsInfo;
    new-array v8, v6, [J

    iput-object v8, v7, Lorg/apache/commons/compress/archivers/sevenz/SubStreamsInfo;->unpackSizes:[J

    .line 991
    new-instance v8, Ljava/util/BitSet;

    invoke-direct {v8, v6}, Ljava/util/BitSet;-><init>(I)V

    iput-object v8, v7, Lorg/apache/commons/compress/archivers/sevenz/SubStreamsInfo;->hasCrc:Ljava/util/BitSet;

    .line 992
    new-array v8, v6, [J

    iput-object v8, v7, Lorg/apache/commons/compress/archivers/sevenz/SubStreamsInfo;->crcs:[J

    .line 994
    const/4 v8, 0x0

    .line 995
    .local v8, "nextUnpackStream":I
    iget-object v9, v0, Lorg/apache/commons/compress/archivers/sevenz/Archive;->folders:[Lorg/apache/commons/compress/archivers/sevenz/Folder;

    array-length v10, v9

    const/4 v11, 0x0

    :goto_2
    const/16 v12, 0x9

    if-ge v11, v10, :cond_6

    aget-object v13, v9, v11

    .line 996
    .local v13, "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    iget v14, v13, Lorg/apache/commons/compress/archivers/sevenz/Folder;->numUnpackSubStreams:I

    if-nez v14, :cond_3

    .line 997
    goto :goto_4

    .line 999
    :cond_3
    const-wide/16 v14, 0x0

    .line 1000
    .local v14, "sum":J
    if-ne v4, v12, :cond_4

    .line 1001
    const/4 v12, 0x0

    .local v12, "i":I
    :goto_3
    iget v3, v13, Lorg/apache/commons/compress/archivers/sevenz/Folder;->numUnpackSubStreams:I

    sub-int/2addr v3, v5

    if-ge v12, v3, :cond_4

    .line 1002
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v17

    .line 1003
    .local v17, "size":J
    iget-object v3, v7, Lorg/apache/commons/compress/archivers/sevenz/SubStreamsInfo;->unpackSizes:[J

    add-int/lit8 v19, v8, 0x1

    .end local v8    # "nextUnpackStream":I
    .local v19, "nextUnpackStream":I
    aput-wide v17, v3, v8

    .line 1004
    add-long v14, v14, v17

    .line 1001
    .end local v17    # "size":J
    add-int/lit8 v12, v12, 0x1

    move/from16 v8, v19

    goto :goto_3

    .line 1007
    .end local v12    # "i":I
    .end local v19    # "nextUnpackStream":I
    .restart local v8    # "nextUnpackStream":I
    :cond_4
    invoke-virtual {v13}, Lorg/apache/commons/compress/archivers/sevenz/Folder;->getUnpackSize()J

    move-result-wide v17

    cmp-long v3, v14, v17

    if-gtz v3, :cond_5

    .line 1010
    iget-object v3, v7, Lorg/apache/commons/compress/archivers/sevenz/SubStreamsInfo;->unpackSizes:[J

    add-int/lit8 v12, v8, 0x1

    .end local v8    # "nextUnpackStream":I
    .local v12, "nextUnpackStream":I
    invoke-virtual {v13}, Lorg/apache/commons/compress/archivers/sevenz/Folder;->getUnpackSize()J

    move-result-wide v17

    sub-long v17, v17, v14

    aput-wide v17, v3, v8

    move v8, v12

    .line 995
    .end local v12    # "nextUnpackStream":I
    .end local v13    # "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    .end local v14    # "sum":J
    .restart local v8    # "nextUnpackStream":I
    :goto_4
    add-int/lit8 v11, v11, 0x1

    goto :goto_2

    .line 1008
    .restart local v13    # "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    .restart local v14    # "sum":J
    :cond_5
    new-instance v3, Ljava/io/IOException;

    const-string/jumbo v5, "sum of unpack sizes of folder exceeds total unpack size"

    invoke-direct {v3, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 1012
    .end local v13    # "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    .end local v14    # "sum":J
    :cond_6
    if-ne v4, v12, :cond_7

    .line 1013
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v4

    .line 1016
    :cond_7
    const/4 v3, 0x0

    .line 1017
    .local v3, "numDigests":I
    iget-object v9, v0, Lorg/apache/commons/compress/archivers/sevenz/Archive;->folders:[Lorg/apache/commons/compress/archivers/sevenz/Folder;

    array-length v10, v9

    const/4 v11, 0x0

    :goto_5
    if-ge v11, v10, :cond_a

    aget-object v12, v9, v11

    .line 1018
    .local v12, "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    iget v13, v12, Lorg/apache/commons/compress/archivers/sevenz/Folder;->numUnpackSubStreams:I

    if-ne v13, v5, :cond_8

    iget-boolean v13, v12, Lorg/apache/commons/compress/archivers/sevenz/Folder;->hasCrc:Z

    if-nez v13, :cond_9

    .line 1019
    :cond_8
    iget v13, v12, Lorg/apache/commons/compress/archivers/sevenz/Folder;->numUnpackSubStreams:I

    add-int/2addr v3, v13

    .line 1017
    .end local v12    # "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    :cond_9
    add-int/lit8 v11, v11, 0x1

    goto :goto_5

    .line 1023
    :cond_a
    const/16 v9, 0xa

    if-ne v4, v9, :cond_10

    .line 1024
    move-object/from16 v9, p0

    move-object/from16 v10, p1

    invoke-direct {v9, v10, v3}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readAllOrBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;

    move-result-object v11

    .line 1025
    .local v11, "hasMissingCrc":Ljava/util/BitSet;
    new-array v12, v3, [J

    .line 1026
    .local v12, "missingCrcs":[J
    const/4 v13, 0x0

    .local v13, "i":I
    :goto_6
    if-ge v13, v3, :cond_c

    .line 1027
    invoke-virtual {v11, v13}, Ljava/util/BitSet;->get(I)Z

    move-result v14

    if-eqz v14, :cond_b

    .line 1028
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getInt(Ljava/nio/ByteBuffer;)I

    move-result v14

    int-to-long v14, v14

    const-wide v17, 0xffffffffL

    and-long v14, v14, v17

    aput-wide v14, v12, v13

    .line 1026
    :cond_b
    add-int/lit8 v13, v13, 0x1

    goto :goto_6

    .line 1031
    .end local v13    # "i":I
    :cond_c
    const/4 v13, 0x0

    .line 1032
    .local v13, "nextCrc":I
    const/4 v14, 0x0

    .line 1033
    .local v14, "nextMissingCrc":I
    iget-object v15, v0, Lorg/apache/commons/compress/archivers/sevenz/Archive;->folders:[Lorg/apache/commons/compress/archivers/sevenz/Folder;

    array-length v5, v15

    move/from16 v16, v14

    move v14, v13

    const/4 v13, 0x0

    .end local v13    # "nextCrc":I
    .local v14, "nextCrc":I
    .local v16, "nextMissingCrc":I
    :goto_7
    if-ge v13, v5, :cond_f

    move-wide/from16 v18, v1

    .end local v1    # "unpackStreamsCount":J
    .local v18, "unpackStreamsCount":J
    aget-object v1, v15, v13

    .line 1034
    .local v1, "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    iget v2, v1, Lorg/apache/commons/compress/archivers/sevenz/Folder;->numUnpackSubStreams:I

    move/from16 v20, v3

    const/4 v3, 0x1

    .end local v3    # "numDigests":I
    .local v20, "numDigests":I
    if-ne v2, v3, :cond_d

    iget-boolean v2, v1, Lorg/apache/commons/compress/archivers/sevenz/Folder;->hasCrc:Z

    if-eqz v2, :cond_d

    .line 1035
    iget-object v2, v7, Lorg/apache/commons/compress/archivers/sevenz/SubStreamsInfo;->hasCrc:Ljava/util/BitSet;

    invoke-virtual {v2, v14, v3}, Ljava/util/BitSet;->set(IZ)V

    .line 1036
    iget-object v2, v7, Lorg/apache/commons/compress/archivers/sevenz/SubStreamsInfo;->crcs:[J

    move/from16 v17, v4

    .end local v4    # "nid":I
    .local v17, "nid":I
    iget-wide v3, v1, Lorg/apache/commons/compress/archivers/sevenz/Folder;->crc:J

    aput-wide v3, v2, v14

    .line 1037
    add-int/lit8 v14, v14, 0x1

    goto :goto_9

    .line 1034
    .end local v17    # "nid":I
    .restart local v4    # "nid":I
    :cond_d
    move/from16 v17, v4

    .line 1039
    .end local v4    # "nid":I
    .restart local v17    # "nid":I
    const/4 v2, 0x0

    move/from16 v3, v16

    .end local v16    # "nextMissingCrc":I
    .local v2, "i":I
    .local v3, "nextMissingCrc":I
    :goto_8
    iget v4, v1, Lorg/apache/commons/compress/archivers/sevenz/Folder;->numUnpackSubStreams:I

    if-ge v2, v4, :cond_e

    .line 1040
    iget-object v4, v7, Lorg/apache/commons/compress/archivers/sevenz/SubStreamsInfo;->hasCrc:Ljava/util/BitSet;

    move-object/from16 v21, v1

    .end local v1    # "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    .local v21, "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    invoke-virtual {v11, v3}, Ljava/util/BitSet;->get(I)Z

    move-result v1

    invoke-virtual {v4, v14, v1}, Ljava/util/BitSet;->set(IZ)V

    .line 1041
    iget-object v1, v7, Lorg/apache/commons/compress/archivers/sevenz/SubStreamsInfo;->crcs:[J

    aget-wide v22, v12, v3

    aput-wide v22, v1, v14

    .line 1042
    add-int/lit8 v14, v14, 0x1

    .line 1043
    add-int/lit8 v3, v3, 0x1

    .line 1039
    add-int/lit8 v2, v2, 0x1

    move-object/from16 v1, v21

    goto :goto_8

    .end local v21    # "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    .restart local v1    # "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    :cond_e
    move-object/from16 v21, v1

    .end local v1    # "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    .restart local v21    # "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    move/from16 v16, v3

    .line 1033
    .end local v2    # "i":I
    .end local v3    # "nextMissingCrc":I
    .end local v21    # "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    .restart local v16    # "nextMissingCrc":I
    :goto_9
    add-int/lit8 v13, v13, 0x1

    move/from16 v4, v17

    move-wide/from16 v1, v18

    move/from16 v3, v20

    goto :goto_7

    .line 1048
    .end local v17    # "nid":I
    .end local v18    # "unpackStreamsCount":J
    .end local v20    # "numDigests":I
    .local v1, "unpackStreamsCount":J
    .local v3, "numDigests":I
    .restart local v4    # "nid":I
    :cond_f
    move-wide/from16 v18, v1

    move/from16 v20, v3

    move/from16 v17, v4

    .end local v1    # "unpackStreamsCount":J
    .end local v3    # "numDigests":I
    .end local v4    # "nid":I
    .restart local v17    # "nid":I
    .restart local v18    # "unpackStreamsCount":J
    .restart local v20    # "numDigests":I
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v4

    .end local v17    # "nid":I
    .restart local v4    # "nid":I
    goto :goto_a

    .line 1023
    .end local v11    # "hasMissingCrc":Ljava/util/BitSet;
    .end local v12    # "missingCrcs":[J
    .end local v14    # "nextCrc":I
    .end local v16    # "nextMissingCrc":I
    .end local v18    # "unpackStreamsCount":J
    .end local v20    # "numDigests":I
    .restart local v1    # "unpackStreamsCount":J
    .restart local v3    # "numDigests":I
    :cond_10
    move-object/from16 v9, p0

    move-object/from16 v10, p1

    move-wide/from16 v18, v1

    move/from16 v20, v3

    move/from16 v17, v4

    .line 1051
    .end local v1    # "unpackStreamsCount":J
    .end local v3    # "numDigests":I
    .restart local v18    # "unpackStreamsCount":J
    .restart local v20    # "numDigests":I
    :goto_a
    iput-object v7, v0, Lorg/apache/commons/compress/archivers/sevenz/Archive;->subStreamsInfo:Lorg/apache/commons/compress/archivers/sevenz/SubStreamsInfo;

    .line 1052
    return-void
.end method

.method private static readUint64(Ljava/nio/ByteBuffer;)J
    .locals 10
    .param p0, "in"    # Ljava/nio/ByteBuffer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1933
    invoke-static {p0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    int-to-long v0, v0

    .line 1934
    .local v0, "firstByte":J
    const/16 v2, 0x80

    .line 1935
    .local v2, "mask":I
    const-wide/16 v3, 0x0

    .line 1936
    .local v3, "value":J
    const/4 v5, 0x0

    .local v5, "i":I
    :goto_0
    const/16 v6, 0x8

    if-ge v5, v6, :cond_1

    .line 1937
    int-to-long v6, v2

    and-long/2addr v6, v0

    const-wide/16 v8, 0x0

    cmp-long v6, v6, v8

    if-nez v6, :cond_0

    .line 1938
    add-int/lit8 v6, v2, -0x1

    int-to-long v6, v6

    and-long/2addr v6, v0

    mul-int/lit8 v8, v5, 0x8

    shl-long/2addr v6, v8

    or-long/2addr v6, v3

    return-wide v6

    .line 1940
    :cond_0
    invoke-static {p0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v6

    int-to-long v6, v6

    .line 1941
    .local v6, "nextByte":J
    mul-int/lit8 v8, v5, 0x8

    shl-long v8, v6, v8

    or-long/2addr v3, v8

    .line 1942
    ushr-int/lit8 v2, v2, 0x1

    .line 1936
    .end local v6    # "nextByte":J
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 1944
    .end local v5    # "i":I
    :cond_1
    return-wide v3
.end method

.method private readUnpackInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/Archive;)V
    .locals 12
    .param p1, "header"    # Ljava/nio/ByteBuffer;
    .param p2, "archive"    # Lorg/apache/commons/compress/archivers/sevenz/Archive;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 877
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    .line 878
    .local v0, "nid":I
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v1

    long-to-int v1, v1

    .line 879
    .local v1, "numFoldersInt":I
    new-array v2, v1, [Lorg/apache/commons/compress/archivers/sevenz/Folder;

    .line 880
    .local v2, "folders":[Lorg/apache/commons/compress/archivers/sevenz/Folder;
    iput-object v2, p2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->folders:[Lorg/apache/commons/compress/archivers/sevenz/Folder;

    .line 881
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    .line 882
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    if-ge v3, v1, :cond_0

    .line 883
    invoke-direct {p0, p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readFolder(Ljava/nio/ByteBuffer;)Lorg/apache/commons/compress/archivers/sevenz/Folder;

    move-result-object v4

    aput-object v4, v2, v3

    .line 882
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 886
    .end local v3    # "i":I
    :cond_0
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    .line 887
    array-length v3, v2

    const/4 v4, 0x0

    move v5, v4

    :goto_1
    if-ge v5, v3, :cond_2

    aget-object v6, v2, v5

    .line 888
    .local v6, "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    const-string/jumbo v7, "totalOutputStreams"

    iget-wide v8, v6, Lorg/apache/commons/compress/archivers/sevenz/Folder;->totalOutputStreams:J

    invoke-static {v7, v8, v9}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    .line 889
    iget-wide v7, v6, Lorg/apache/commons/compress/archivers/sevenz/Folder;->totalOutputStreams:J

    long-to-int v7, v7

    new-array v7, v7, [J

    iput-object v7, v6, Lorg/apache/commons/compress/archivers/sevenz/Folder;->unpackSizes:[J

    .line 890
    const/4 v7, 0x0

    .local v7, "i":I
    :goto_2
    int-to-long v8, v7

    iget-wide v10, v6, Lorg/apache/commons/compress/archivers/sevenz/Folder;->totalOutputStreams:J

    cmp-long v8, v8, v10

    if-gez v8, :cond_1

    .line 891
    iget-object v8, v6, Lorg/apache/commons/compress/archivers/sevenz/Folder;->unpackSizes:[J

    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v9

    aput-wide v9, v8, v7

    .line 890
    add-int/lit8 v7, v7, 0x1

    goto :goto_2

    .line 887
    .end local v6    # "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    .end local v7    # "i":I
    :cond_1
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 895
    :cond_2
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    .line 896
    const/16 v3, 0xa

    if-ne v0, v3, :cond_5

    .line 897
    invoke-direct {p0, p1, v1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readAllOrBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;

    move-result-object v3

    .line 898
    .local v3, "crcsDefined":Ljava/util/BitSet;
    const/4 v5, 0x0

    .local v5, "i":I
    :goto_3
    if-ge v5, v1, :cond_4

    .line 899
    invoke-virtual {v3, v5}, Ljava/util/BitSet;->get(I)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 900
    aget-object v6, v2, v5

    const/4 v7, 0x1

    iput-boolean v7, v6, Lorg/apache/commons/compress/archivers/sevenz/Folder;->hasCrc:Z

    .line 901
    aget-object v6, v2, v5

    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getInt(Ljava/nio/ByteBuffer;)I

    move-result v7

    int-to-long v7, v7

    const-wide v9, 0xffffffffL

    and-long/2addr v7, v9

    iput-wide v7, v6, Lorg/apache/commons/compress/archivers/sevenz/Folder;->crc:J

    goto :goto_4

    .line 903
    :cond_3
    aget-object v6, v2, v5

    iput-boolean v4, v6, Lorg/apache/commons/compress/archivers/sevenz/Folder;->hasCrc:Z

    .line 898
    :goto_4
    add-int/lit8 v5, v5, 0x1

    goto :goto_3

    .line 907
    .end local v5    # "i":I
    :cond_4
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    .line 909
    .end local v3    # "crcsDefined":Ljava/util/BitSet;
    :cond_5
    return-void
.end method

.method private reopenFolderInputStream(ILorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;)V
    .locals 10
    .param p1, "folderIndex"    # I
    .param p2, "file"    # Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1659
    iget-object v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->deferredBlockStreams:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 1660
    iget-object v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentFolderInputStream:Ljava/io/InputStream;

    if-eqz v0, :cond_0

    .line 1661
    iget-object v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentFolderInputStream:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 1662
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentFolderInputStream:Ljava/io/InputStream;

    .line 1664
    :cond_0
    iget-object v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v0, v0, Lorg/apache/commons/compress/archivers/sevenz/Archive;->folders:[Lorg/apache/commons/compress/archivers/sevenz/Folder;

    aget-object v0, v0, p1

    .line 1665
    .local v0, "folder":Lorg/apache/commons/compress/archivers/sevenz/Folder;
    iget-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v1, v1, Lorg/apache/commons/compress/archivers/sevenz/Archive;->streamMap:Lorg/apache/commons/compress/archivers/sevenz/StreamMap;

    iget-object v1, v1, Lorg/apache/commons/compress/archivers/sevenz/StreamMap;->folderFirstPackStreamIndex:[I

    aget v7, v1, p1

    .line 1666
    .local v7, "firstPackStreamIndex":I
    iget-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-wide v1, v1, Lorg/apache/commons/compress/archivers/sevenz/Archive;->packPos:J

    const-wide/16 v3, 0x20

    add-long/2addr v1, v3

    iget-object v3, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v3, v3, Lorg/apache/commons/compress/archivers/sevenz/Archive;->streamMap:Lorg/apache/commons/compress/archivers/sevenz/StreamMap;

    iget-object v3, v3, Lorg/apache/commons/compress/archivers/sevenz/StreamMap;->packStreamOffsets:[J

    aget-wide v4, v3, v7

    add-long v8, v1, v4

    .line 1669
    .local v8, "folderOffset":J
    move-object v1, p0

    move-object v2, v0

    move-wide v3, v8

    move v5, v7

    move-object v6, p2

    invoke-direct/range {v1 .. v6}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->buildDecoderStack(Lorg/apache/commons/compress/archivers/sevenz/Folder;JILorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;)Ljava/io/InputStream;

    move-result-object v1

    iput-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentFolderInputStream:Ljava/io/InputStream;

    .line 1670
    return-void
.end method

.method private sanityCheckAndCollectStatistics(Ljava/nio/ByteBuffer;)Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;
    .locals 5
    .param p1, "header"    # Ljava/nio/ByteBuffer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 613
    new-instance v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;-><init>(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$1;)V

    .line 615
    .local v0, "stats":Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v1

    .line 617
    .local v1, "nid":I
    const/4 v2, 0x2

    if-ne v1, v2, :cond_0

    .line 618
    invoke-direct {p0, p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->sanityCheckArchiveProperties(Ljava/nio/ByteBuffer;)V

    .line 619
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v1

    .line 622
    :cond_0
    const/4 v2, 0x3

    if-eq v1, v2, :cond_4

    .line 627
    const/4 v2, 0x4

    if-ne v1, v2, :cond_1

    .line 628
    invoke-direct {p0, p1, v0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->sanityCheckStreamsInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)V

    .line 629
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v1

    .line 632
    :cond_1
    const/4 v2, 0x5

    if-ne v1, v2, :cond_2

    .line 633
    invoke-direct {p0, p1, v0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->sanityCheckFilesInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)V

    .line 634
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v1

    .line 637
    :cond_2
    if-nez v1, :cond_3

    .line 641
    return-object v0

    .line 638
    :cond_3
    new-instance v2, Ljava/io/IOException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Badly terminated header, found "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 623
    :cond_4
    new-instance v2, Ljava/io/IOException;

    const-string v3, "Additional streams unsupported"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method private sanityCheckArchiveProperties(Ljava/nio/ByteBuffer;)V
    .locals 6
    .param p1, "header"    # Ljava/nio/ByteBuffer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 657
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    .line 658
    .local v0, "nid":I
    :goto_0
    if-eqz v0, :cond_1

    .line 659
    nop

    .line 660
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v1

    const-string v3, "propertySize"

    invoke-static {v3, v1, v2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    move-result v1

    .line 661
    .local v1, "propertySize":I
    int-to-long v2, v1

    invoke-static {p1, v2, v3}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->skipBytesFully(Ljava/nio/ByteBuffer;J)J

    move-result-wide v2

    int-to-long v4, v1

    cmp-long v2, v2, v4

    if-ltz v2, :cond_0

    .line 664
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    .line 665
    .end local v1    # "propertySize":I
    goto :goto_0

    .line 662
    .restart local v1    # "propertySize":I
    :cond_0
    new-instance v2, Ljava/io/IOException;

    const-string v3, "invalid property size"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 666
    .end local v1    # "propertySize":I
    :cond_1
    return-void
.end method

.method private sanityCheckFilesInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)V
    .locals 11
    .param p1, "header"    # Ljava/nio/ByteBuffer;
    .param p2, "stats"    # Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1243
    const-string v0, "numFiles"

    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v1

    invoke-static {v0, v1, v2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    move-result v0

    invoke-static {p2, v0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$802(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;I)I

    .line 1245
    const/4 v0, -0x1

    .line 1247
    .local v0, "emptyStreams":I
    :goto_0
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v1

    .line 1248
    .local v1, "propertyType":I
    if-nez v1, :cond_1

    .line 1249
    nop

    .line 1365
    .end local v1    # "propertyType":I
    invoke-static {p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$800(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)I

    move-result v1

    if-lez v0, :cond_0

    move v2, v0

    goto :goto_1

    :cond_0
    const/4 v2, 0x0

    :goto_1
    sub-int/2addr v1, v2

    invoke-static {p2, v1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$902(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;I)I

    .line 1366
    return-void

    .line 1251
    .restart local v1    # "propertyType":I
    :cond_1
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v2

    .line 1252
    .local v2, "size":J
    const/4 v4, -0x1

    const-string v5, "Not implemented"

    packed-switch v1, :pswitch_data_0

    .line 1358
    :pswitch_0
    invoke-static {p1, v2, v3}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->skipBytesFully(Ljava/nio/ByteBuffer;J)J

    move-result-wide v4

    cmp-long v4, v4, v2

    if-ltz v4, :cond_12

    goto/16 :goto_3

    .line 1350
    :pswitch_1
    invoke-static {p1, v2, v3}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->skipBytesFully(Ljava/nio/ByteBuffer;J)J

    move-result-wide v4

    cmp-long v4, v4, v2

    if-ltz v4, :cond_2

    goto/16 :goto_3

    .line 1351
    :cond_2
    new-instance v4, Ljava/io/IOException;

    const-string v5, "Incomplete kDummy property"

    invoke-direct {v4, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 1344
    :pswitch_2
    new-instance v4, Ljava/io/IOException;

    const-string v5, "kStartPos is unsupported, please report"

    invoke-direct {v4, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 1332
    :pswitch_3
    invoke-static {p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$800(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)I

    move-result v4

    invoke-direct {p0, p1, v4}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readAllOrBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;

    move-result-object v4

    .line 1333
    invoke-virtual {v4}, Ljava/util/BitSet;->cardinality()I

    move-result v4

    .line 1334
    .local v4, "attributesDefined":I
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v6

    .line 1335
    .local v6, "external":I
    if-nez v6, :cond_4

    .line 1338
    mul-int/lit8 v5, v4, 0x4

    int-to-long v7, v5

    invoke-static {p1, v7, v8}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->skipBytesFully(Ljava/nio/ByteBuffer;J)J

    move-result-wide v7

    mul-int/lit8 v5, v4, 0x4

    int-to-long v9, v5

    cmp-long v5, v7, v9

    if-ltz v5, :cond_3

    goto/16 :goto_3

    .line 1339
    :cond_3
    new-instance v5, Ljava/io/IOException;

    const-string v7, "invalid windows attributes size"

    invoke-direct {v5, v7}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 1336
    :cond_4
    new-instance v7, Ljava/io/IOException;

    invoke-direct {v7, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v7

    .line 1320
    .end local v4    # "attributesDefined":I
    .end local v6    # "external":I
    :pswitch_4
    invoke-static {p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$800(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)I

    move-result v4

    invoke-direct {p0, p1, v4}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readAllOrBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;

    move-result-object v4

    .line 1321
    invoke-virtual {v4}, Ljava/util/BitSet;->cardinality()I

    move-result v4

    .line 1322
    .local v4, "timesDefined":I
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v6

    .line 1323
    .restart local v6    # "external":I
    if-nez v6, :cond_6

    .line 1326
    mul-int/lit8 v5, v4, 0x8

    int-to-long v7, v5

    invoke-static {p1, v7, v8}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->skipBytesFully(Ljava/nio/ByteBuffer;J)J

    move-result-wide v7

    mul-int/lit8 v5, v4, 0x8

    int-to-long v9, v5

    cmp-long v5, v7, v9

    if-ltz v5, :cond_5

    goto/16 :goto_3

    .line 1327
    :cond_5
    new-instance v5, Ljava/io/IOException;

    const-string v7, "invalid modification dates size"

    invoke-direct {v5, v7}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 1324
    :cond_6
    new-instance v7, Ljava/io/IOException;

    invoke-direct {v7, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v7

    .line 1308
    .end local v4    # "timesDefined":I
    .end local v6    # "external":I
    :pswitch_5
    invoke-static {p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$800(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)I

    move-result v4

    invoke-direct {p0, p1, v4}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readAllOrBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;

    move-result-object v4

    .line 1309
    invoke-virtual {v4}, Ljava/util/BitSet;->cardinality()I

    move-result v4

    .line 1310
    .restart local v4    # "timesDefined":I
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v6

    .line 1311
    .restart local v6    # "external":I
    if-nez v6, :cond_8

    .line 1314
    mul-int/lit8 v5, v4, 0x8

    int-to-long v7, v5

    invoke-static {p1, v7, v8}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->skipBytesFully(Ljava/nio/ByteBuffer;J)J

    move-result-wide v7

    mul-int/lit8 v5, v4, 0x8

    int-to-long v9, v5

    cmp-long v5, v7, v9

    if-ltz v5, :cond_7

    goto/16 :goto_3

    .line 1315
    :cond_7
    new-instance v5, Ljava/io/IOException;

    const-string v7, "invalid access dates size"

    invoke-direct {v5, v7}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 1312
    :cond_8
    new-instance v7, Ljava/io/IOException;

    invoke-direct {v7, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v7

    .line 1296
    .end local v4    # "timesDefined":I
    .end local v6    # "external":I
    :pswitch_6
    invoke-static {p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$800(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)I

    move-result v4

    invoke-direct {p0, p1, v4}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readAllOrBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;

    move-result-object v4

    .line 1297
    invoke-virtual {v4}, Ljava/util/BitSet;->cardinality()I

    move-result v4

    .line 1298
    .restart local v4    # "timesDefined":I
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v6

    .line 1299
    .restart local v6    # "external":I
    if-nez v6, :cond_a

    .line 1302
    mul-int/lit8 v5, v4, 0x8

    int-to-long v7, v5

    invoke-static {p1, v7, v8}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->skipBytesFully(Ljava/nio/ByteBuffer;J)J

    move-result-wide v7

    mul-int/lit8 v5, v4, 0x8

    int-to-long v9, v5

    cmp-long v5, v7, v9

    if-ltz v5, :cond_9

    goto/16 :goto_3

    .line 1303
    :cond_9
    new-instance v5, Ljava/io/IOException;

    const-string v7, "invalid creation dates size"

    invoke-direct {v5, v7}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 1300
    :cond_a
    new-instance v7, Ljava/io/IOException;

    invoke-direct {v7, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v7

    .line 1272
    .end local v4    # "timesDefined":I
    .end local v6    # "external":I
    :pswitch_7
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v4

    .line 1273
    .local v4, "external":I
    if-nez v4, :cond_f

    .line 1276
    const-wide/16 v5, 0x1

    sub-long v5, v2, v5

    .line 1277
    const-string v7, "file names length"

    invoke-static {v7, v5, v6}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    move-result v5

    .line 1278
    .local v5, "namesLength":I
    and-int/lit8 v6, v5, 0x1

    if-nez v6, :cond_e

    .line 1282
    const/4 v6, 0x0

    .line 1283
    .local v6, "filesSeen":I
    const/4 v7, 0x0

    .local v7, "i":I
    :goto_2
    if-ge v7, v5, :cond_c

    .line 1284
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getChar(Ljava/nio/ByteBuffer;)C

    move-result v8

    .line 1285
    .local v8, "c":C
    if-nez v8, :cond_b

    .line 1286
    add-int/lit8 v6, v6, 0x1

    .line 1283
    .end local v8    # "c":C
    :cond_b
    add-int/lit8 v7, v7, 0x2

    goto :goto_2

    .line 1289
    .end local v7    # "i":I
    :cond_c
    invoke-static {p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$800(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)I

    move-result v7

    if-ne v6, v7, :cond_d

    goto :goto_3

    .line 1290
    :cond_d
    new-instance v7, Ljava/io/IOException;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "Invalid number of file names ("

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, " instead of "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    .line 1291
    invoke-static {p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$800(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)I

    move-result v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, ")"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v7, v8}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v7

    .line 1279
    .end local v6    # "filesSeen":I
    :cond_e
    new-instance v6, Ljava/io/IOException;

    const-string v7, "File names length invalid"

    invoke-direct {v6, v7}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v6

    .line 1274
    .end local v5    # "namesLength":I
    :cond_f
    new-instance v6, Ljava/io/IOException;

    invoke-direct {v6, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v6

    .line 1265
    .end local v4    # "external":I
    :pswitch_8
    if-eq v0, v4, :cond_10

    .line 1268
    invoke-direct {p0, p1, v0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;

    .line 1269
    goto :goto_3

    .line 1266
    :cond_10
    new-instance v4, Ljava/io/IOException;

    const-string v5, "Header format error: kEmptyStream must appear before kAnti"

    invoke-direct {v4, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 1258
    :pswitch_9
    if-eq v0, v4, :cond_11

    .line 1261
    invoke-direct {p0, p1, v0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;

    .line 1262
    goto :goto_3

    .line 1259
    :cond_11
    new-instance v4, Ljava/io/IOException;

    const-string v5, "Header format error: kEmptyStream must appear before kEmptyFile"

    invoke-direct {v4, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 1254
    :pswitch_a
    invoke-static {p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$800(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)I

    move-result v4

    invoke-direct {p0, p1, v4}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;

    move-result-object v4

    invoke-virtual {v4}, Ljava/util/BitSet;->cardinality()I

    move-result v0

    .line 1255
    nop

    .line 1364
    .end local v1    # "propertyType":I
    .end local v2    # "size":J
    :goto_3
    goto/16 :goto_0

    .line 1359
    .restart local v1    # "propertyType":I
    .restart local v2    # "size":J
    :cond_12
    new-instance v4, Ljava/io/IOException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Incomplete property of type "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v4

    :pswitch_data_0
    .packed-switch 0xe
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_0
        :pswitch_0
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method private sanityCheckFolder(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)I
    .locals 21
    .param p1, "header"    # Ljava/nio/ByteBuffer;
    .param p2, "stats"    # Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1057
    move-object/from16 v0, p1

    move-object/from16 v1, p2

    const-string v2, "numCoders"

    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v3

    invoke-static {v2, v3, v4}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    move-result v2

    .line 1058
    .local v2, "numCoders":I
    if-eqz v2, :cond_11

    .line 1061
    invoke-static/range {p2 .. p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$700(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)J

    move-result-wide v3

    int-to-long v5, v2

    add-long/2addr v3, v5

    invoke-static {v1, v3, v4}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$702(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;J)J

    .line 1063
    const-wide/16 v3, 0x0

    .line 1064
    .local v3, "totalOutStreams":J
    const-wide/16 v5, 0x0

    .line 1065
    .local v5, "totalInStreams":J
    const/4 v7, 0x0

    .local v7, "i":I
    :goto_0
    const-wide/16 v8, 0x1

    const/4 v11, 0x1

    if-ge v7, v2, :cond_7

    .line 1066
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v12

    .line 1067
    .local v12, "bits":I
    and-int/lit8 v13, v12, 0xf

    .line 1068
    .local v13, "idSize":I
    new-array v14, v13, [B

    invoke-static {v0, v14}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->get(Ljava/nio/ByteBuffer;[B)V

    .line 1070
    and-int/lit8 v14, v12, 0x10

    if-nez v14, :cond_0

    move v14, v11

    goto :goto_1

    :cond_0
    const/4 v14, 0x0

    .line 1071
    .local v14, "isSimple":Z
    :goto_1
    and-int/lit8 v15, v12, 0x20

    if-eqz v15, :cond_1

    move v15, v11

    goto :goto_2

    :cond_1
    const/4 v15, 0x0

    .line 1072
    .local v15, "hasAttributes":Z
    :goto_2
    and-int/lit16 v10, v12, 0x80

    if-eqz v10, :cond_2

    move v10, v11

    goto :goto_3

    :cond_2
    const/4 v10, 0x0

    .line 1073
    .local v10, "moreAlternativeMethods":Z
    :goto_3
    if-nez v10, :cond_6

    .line 1078
    if-eqz v14, :cond_3

    .line 1079
    add-long/2addr v5, v8

    .line 1080
    add-long/2addr v3, v8

    goto :goto_4

    .line 1082
    :cond_3
    nop

    .line 1083
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v8

    const-string v11, "numInStreams"

    invoke-static {v11, v8, v9}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    move-result v8

    int-to-long v8, v8

    add-long/2addr v5, v8

    .line 1084
    nop

    .line 1085
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v8

    const-string v11, "numOutStreams"

    invoke-static {v11, v8, v9}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    move-result v8

    int-to-long v8, v8

    add-long/2addr v3, v8

    .line 1088
    :goto_4
    if-eqz v15, :cond_5

    .line 1089
    nop

    .line 1090
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v8

    const-string v11, "propertiesSize"

    invoke-static {v11, v8, v9}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    move-result v8

    .line 1091
    .local v8, "propertiesSize":I
    move/from16 v16, v2

    move-wide/from16 v17, v3

    .end local v2    # "numCoders":I
    .end local v3    # "totalOutStreams":J
    .local v16, "numCoders":I
    .local v17, "totalOutStreams":J
    int-to-long v2, v8

    invoke-static {v0, v2, v3}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->skipBytesFully(Ljava/nio/ByteBuffer;J)J

    move-result-wide v2

    move-wide/from16 v19, v5

    .end local v5    # "totalInStreams":J
    .local v19, "totalInStreams":J
    int-to-long v4, v8

    cmp-long v2, v2, v4

    if-ltz v2, :cond_4

    goto :goto_5

    .line 1092
    :cond_4
    new-instance v2, Ljava/io/IOException;

    const-string v3, "invalid propertiesSize in folder"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 1088
    .end local v8    # "propertiesSize":I
    .end local v16    # "numCoders":I
    .end local v17    # "totalOutStreams":J
    .end local v19    # "totalInStreams":J
    .restart local v2    # "numCoders":I
    .restart local v3    # "totalOutStreams":J
    .restart local v5    # "totalInStreams":J
    :cond_5
    move/from16 v16, v2

    move-wide/from16 v17, v3

    move-wide/from16 v19, v5

    .line 1065
    .end local v2    # "numCoders":I
    .end local v3    # "totalOutStreams":J
    .end local v5    # "totalInStreams":J
    .end local v10    # "moreAlternativeMethods":Z
    .end local v12    # "bits":I
    .end local v13    # "idSize":I
    .end local v14    # "isSimple":Z
    .end local v15    # "hasAttributes":Z
    .restart local v16    # "numCoders":I
    .restart local v17    # "totalOutStreams":J
    .restart local v19    # "totalInStreams":J
    :goto_5
    add-int/lit8 v7, v7, 0x1

    move/from16 v2, v16

    move-wide/from16 v3, v17

    move-wide/from16 v5, v19

    goto :goto_0

    .line 1074
    .end local v16    # "numCoders":I
    .end local v17    # "totalOutStreams":J
    .end local v19    # "totalInStreams":J
    .restart local v2    # "numCoders":I
    .restart local v3    # "totalOutStreams":J
    .restart local v5    # "totalInStreams":J
    .restart local v10    # "moreAlternativeMethods":Z
    .restart local v12    # "bits":I
    .restart local v13    # "idSize":I
    .restart local v14    # "isSimple":Z
    .restart local v15    # "hasAttributes":Z
    :cond_6
    move/from16 v16, v2

    .end local v2    # "numCoders":I
    .restart local v16    # "numCoders":I
    new-instance v2, Ljava/io/IOException;

    const-string v8, "Alternative methods are unsupported, please report. The reference implementation doesn\'t support them either."

    invoke-direct {v2, v8}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 1065
    .end local v10    # "moreAlternativeMethods":Z
    .end local v12    # "bits":I
    .end local v13    # "idSize":I
    .end local v14    # "isSimple":Z
    .end local v15    # "hasAttributes":Z
    .end local v16    # "numCoders":I
    .restart local v2    # "numCoders":I
    :cond_7
    move/from16 v16, v2

    .line 1096
    .end local v2    # "numCoders":I
    .end local v7    # "i":I
    .restart local v16    # "numCoders":I
    const-string/jumbo v2, "totalInStreams"

    invoke-static {v2, v5, v6}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    .line 1097
    const-string/jumbo v2, "totalOutStreams"

    invoke-static {v2, v3, v4}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    .line 1098
    invoke-static/range {p2 .. p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$300(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)J

    move-result-wide v12

    add-long/2addr v12, v3

    invoke-static {v1, v12, v13}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$302(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;J)J

    .line 1099
    invoke-static/range {p2 .. p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$400(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)J

    move-result-wide v12

    add-long/2addr v12, v5

    invoke-static {v1, v12, v13}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$402(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;J)J

    .line 1101
    const-wide/16 v12, 0x0

    cmp-long v2, v3, v12

    if-eqz v2, :cond_10

    .line 1105
    sub-long v7, v3, v8

    .line 1106
    const-string v2, "numBindPairs"

    invoke-static {v2, v7, v8}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    move-result v2

    .line 1107
    .local v2, "numBindPairs":I
    int-to-long v7, v2

    cmp-long v7, v5, v7

    if-ltz v7, :cond_f

    .line 1110
    new-instance v7, Ljava/util/BitSet;

    long-to-int v8, v5

    invoke-direct {v7, v8}, Ljava/util/BitSet;-><init>(I)V

    .line 1111
    .local v7, "inStreamsBound":Ljava/util/BitSet;
    const/4 v8, 0x0

    .local v8, "i":I
    :goto_6
    if-ge v8, v2, :cond_a

    .line 1112
    const-string v9, "inIndex"

    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v12

    invoke-static {v9, v12, v13}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    move-result v9

    .line 1113
    .local v9, "inIndex":I
    int-to-long v12, v9

    cmp-long v10, v5, v12

    if-lez v10, :cond_9

    .line 1116
    invoke-virtual {v7, v9}, Ljava/util/BitSet;->set(I)V

    .line 1117
    const-string v10, "outIndex"

    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v12

    invoke-static {v10, v12, v13}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    move-result v10

    .line 1118
    .local v10, "outIndex":I
    int-to-long v12, v10

    cmp-long v12, v3, v12

    if-lez v12, :cond_8

    .line 1111
    .end local v9    # "inIndex":I
    .end local v10    # "outIndex":I
    add-int/lit8 v8, v8, 0x1

    goto :goto_6

    .line 1119
    .restart local v9    # "inIndex":I
    .restart local v10    # "outIndex":I
    :cond_8
    new-instance v11, Ljava/io/IOException;

    const-string v12, "outIndex is bigger than number of outStreams"

    invoke-direct {v11, v12}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v11

    .line 1114
    .end local v10    # "outIndex":I
    :cond_9
    new-instance v10, Ljava/io/IOException;

    const-string v11, "inIndex is bigger than number of inStreams"

    invoke-direct {v10, v11}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v10

    .line 1123
    .end local v8    # "i":I
    .end local v9    # "inIndex":I
    :cond_a
    int-to-long v8, v2

    sub-long v8, v5, v8

    .line 1124
    const-string v10, "numPackedStreams"

    invoke-static {v10, v8, v9}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    move-result v8

    .line 1126
    .local v8, "numPackedStreams":I
    if-ne v8, v11, :cond_c

    .line 1127
    const/4 v9, 0x0

    invoke-virtual {v7, v9}, Ljava/util/BitSet;->nextClearBit(I)I

    move-result v9

    const/4 v10, -0x1

    if-eq v9, v10, :cond_b

    goto :goto_8

    .line 1128
    :cond_b
    new-instance v9, Ljava/io/IOException;

    const-string v10, "Couldn\'t find stream\'s bind pair index"

    invoke-direct {v9, v10}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v9

    .line 1131
    :cond_c
    const/4 v9, 0x0

    .local v9, "i":I
    :goto_7
    if-ge v9, v8, :cond_e

    .line 1132
    nop

    .line 1133
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v10

    const-string v12, "packedStreamIndex"

    invoke-static {v12, v10, v11}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    move-result v10

    .line 1134
    .local v10, "packedStreamIndex":I
    int-to-long v11, v10

    cmp-long v11, v11, v5

    if-gez v11, :cond_d

    .line 1131
    .end local v10    # "packedStreamIndex":I
    add-int/lit8 v9, v9, 0x1

    goto :goto_7

    .line 1135
    .restart local v10    # "packedStreamIndex":I
    :cond_d
    new-instance v11, Ljava/io/IOException;

    const-string v12, "packedStreamIndex is bigger than number of totalInStreams"

    invoke-direct {v11, v12}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v11

    .line 1140
    .end local v9    # "i":I
    .end local v10    # "packedStreamIndex":I
    :cond_e
    :goto_8
    long-to-int v9, v3

    return v9

    .line 1108
    .end local v7    # "inStreamsBound":Ljava/util/BitSet;
    .end local v8    # "numPackedStreams":I
    :cond_f
    new-instance v7, Ljava/io/IOException;

    const-string v8, "Total input streams can\'t be less than the number of bind pairs"

    invoke-direct {v7, v8}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v7

    .line 1102
    .end local v2    # "numBindPairs":I
    :cond_10
    new-instance v2, Ljava/io/IOException;

    const-string v7, "Total output streams can\'t be 0"

    invoke-direct {v2, v7}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 1059
    .end local v3    # "totalOutStreams":J
    .end local v5    # "totalInStreams":J
    .end local v16    # "numCoders":I
    .local v2, "numCoders":I
    :cond_11
    move/from16 v16, v2

    .end local v2    # "numCoders":I
    .restart local v16    # "numCoders":I
    new-instance v2, Ljava/io/IOException;

    const-string v3, "Folder without coders"

    invoke-direct {v2, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method private sanityCheckPackInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)V
    .locals 21
    .param p1, "header"    # Ljava/nio/ByteBuffer;
    .param p2, "stats"    # Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 761
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v2

    .line 762
    .local v2, "packPos":J
    const-wide/16 v4, 0x0

    cmp-long v6, v2, v4

    const-string v7, ") is out of range"

    if-ltz v6, :cond_6

    const-wide/16 v8, 0x20

    add-long v10, v2, v8

    iget-object v6, v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    invoke-interface {v6}, Ljava/nio/channels/SeekableByteChannel;->size()J

    move-result-wide v12

    cmp-long v6, v10, v12

    if-gtz v6, :cond_6

    add-long v10, v2, v8

    cmp-long v6, v10, v4

    if-ltz v6, :cond_6

    .line 766
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v10

    .line 767
    .local v10, "numPackStreams":J
    const-string v6, "numPackStreams"

    invoke-static {v6, v10, v11}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    move-result v6

    move-object/from16 v12, p2

    invoke-static {v12, v6}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$102(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;I)I

    .line 768
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v6

    .line 769
    .local v6, "nid":I
    const/16 v13, 0x9

    if-ne v6, v13, :cond_2

    .line 770
    const-wide/16 v13, 0x0

    .line 771
    .local v13, "totalPackSizes":J
    const/4 v15, 0x0

    .local v15, "i":I
    :goto_0
    invoke-static/range {p2 .. p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$100(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)I

    move-result v4

    if-ge v15, v4, :cond_1

    .line 772
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v4

    .line 773
    .local v4, "packSize":J
    add-long/2addr v13, v4

    .line 774
    add-long v18, v2, v8

    add-long v18, v18, v13

    .line 775
    .local v18, "endOfPackStreams":J
    const-wide/16 v16, 0x0

    cmp-long v20, v4, v16

    if-ltz v20, :cond_0

    iget-object v8, v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    .line 776
    invoke-interface {v8}, Ljava/nio/channels/SeekableByteChannel;->size()J

    move-result-wide v8

    cmp-long v8, v18, v8

    if-gtz v8, :cond_0

    cmp-long v8, v18, v2

    if-ltz v8, :cond_0

    .line 771
    .end local v4    # "packSize":J
    .end local v18    # "endOfPackStreams":J
    add-int/lit8 v15, v15, 0x1

    move-wide/from16 v4, v16

    const-wide/16 v8, 0x20

    goto :goto_0

    .line 778
    .restart local v4    # "packSize":J
    .restart local v18    # "endOfPackStreams":J
    :cond_0
    new-instance v8, Ljava/io/IOException;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    move/from16 v16, v6

    .end local v6    # "nid":I
    .local v16, "nid":I
    const-string v6, "packSize ("

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v8, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v8

    .line 771
    .end local v4    # "packSize":J
    .end local v16    # "nid":I
    .end local v18    # "endOfPackStreams":J
    .restart local v6    # "nid":I
    :cond_1
    move/from16 v16, v6

    .line 781
    .end local v6    # "nid":I
    .end local v15    # "i":I
    .restart local v16    # "nid":I
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v6

    .end local v16    # "nid":I
    .restart local v6    # "nid":I
    goto :goto_1

    .line 769
    .end local v13    # "totalPackSizes":J
    :cond_2
    move/from16 v16, v6

    .line 784
    :goto_1
    const/16 v4, 0xa

    if-ne v6, v4, :cond_4

    .line 785
    invoke-static/range {p2 .. p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$100(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)I

    move-result v4

    invoke-direct {v0, v1, v4}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readAllOrBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;

    move-result-object v4

    .line 786
    invoke-virtual {v4}, Ljava/util/BitSet;->cardinality()I

    move-result v4

    .line 787
    .local v4, "crcsDefined":I
    mul-int/lit8 v5, v4, 0x4

    int-to-long v7, v5

    invoke-static {v1, v7, v8}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->skipBytesFully(Ljava/nio/ByteBuffer;J)J

    move-result-wide v7

    mul-int/lit8 v5, v4, 0x4

    int-to-long v13, v5

    cmp-long v5, v7, v13

    if-ltz v5, :cond_3

    .line 790
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v6

    goto :goto_2

    .line 788
    :cond_3
    new-instance v5, Ljava/io/IOException;

    const-string v7, "invalid number of CRCs in PackInfo"

    invoke-direct {v5, v7}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 793
    .end local v4    # "crcsDefined":I
    :cond_4
    :goto_2
    if-nez v6, :cond_5

    .line 796
    return-void

    .line 794
    :cond_5
    new-instance v4, Ljava/io/IOException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Badly terminated PackInfo ("

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v7, ")"

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 762
    .end local v6    # "nid":I
    .end local v10    # "numPackStreams":J
    :cond_6
    move-object/from16 v12, p2

    .line 764
    new-instance v4, Ljava/io/IOException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "packPos ("

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v4
.end method

.method private sanityCheckStreamsInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)V
    .locals 3
    .param p1, "header"    # Ljava/nio/ByteBuffer;
    .param p2, "stats"    # Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 716
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    .line 718
    .local v0, "nid":I
    const/4 v1, 0x6

    if-ne v0, v1, :cond_0

    .line 719
    invoke-direct {p0, p1, p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->sanityCheckPackInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)V

    .line 720
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    .line 723
    :cond_0
    const/4 v1, 0x7

    if-ne v0, v1, :cond_1

    .line 724
    invoke-direct {p0, p1, p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->sanityCheckUnpackInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)V

    .line 725
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    .line 728
    :cond_1
    const/16 v1, 0x8

    if-ne v0, v1, :cond_2

    .line 729
    invoke-direct {p0, p1, p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->sanityCheckSubStreamsInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)V

    .line 730
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    .line 733
    :cond_2
    if-nez v0, :cond_3

    .line 736
    return-void

    .line 734
    :cond_3
    new-instance v1, Ljava/io/IOException;

    const-string v2, "Badly terminated StreamsInfo"

    invoke-direct {v1, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method private sanityCheckSubStreamsInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)V
    .locals 9
    .param p1, "header"    # Ljava/nio/ByteBuffer;
    .param p2, "stats"    # Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 913
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    .line 914
    .local v0, "nid":I
    new-instance v1, Ljava/util/LinkedList;

    invoke-direct {v1}, Ljava/util/LinkedList;-><init>()V

    .line 915
    .local v1, "numUnpackSubStreamsPerFolder":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Integer;>;"
    const/16 v2, 0xd

    if-ne v0, v2, :cond_1

    .line 916
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    invoke-static {p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$200(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)I

    move-result v3

    if-ge v2, v3, :cond_0

    .line 917
    const-string v3, "numStreams"

    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v4

    invoke-static {v3, v4, v5}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 916
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 919
    .end local v2    # "i":I
    :cond_0
    invoke-interface {v1}, Ljava/util/List;->stream()Ljava/util/stream/Stream;

    move-result-object v2

    new-instance v3, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$$ExternalSyntheticLambda0;

    invoke-direct {v3}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$$ExternalSyntheticLambda0;-><init>()V

    invoke-static {v3}, Ljava/util/stream/Collectors;->summingLong(Ljava/util/function/ToLongFunction;)Ljava/util/stream/Collector;

    move-result-object v3

    invoke-interface {v2, v3}, Ljava/util/stream/Stream;->collect(Ljava/util/stream/Collector;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Long;

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    invoke-static {p2, v2, v3}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$602(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;J)J

    .line 920
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    goto :goto_1

    .line 922
    :cond_1
    invoke-static {p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$200(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)I

    move-result v2

    int-to-long v2, v2

    invoke-static {p2, v2, v3}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$602(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;J)J

    .line 925
    :goto_1
    const-string/jumbo v2, "totalUnpackStreams"

    invoke-static {p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$600(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)J

    move-result-wide v3

    invoke-static {v2, v3, v4}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    .line 927
    const/16 v2, 0x9

    if-ne v0, v2, :cond_6

    .line 928
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_2
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_5

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    .line 929
    .local v3, "numUnpackSubStreams":I
    if-nez v3, :cond_2

    .line 930
    goto :goto_2

    .line 932
    :cond_2
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_3
    add-int/lit8 v5, v3, -0x1

    if-ge v4, v5, :cond_4

    .line 933
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v5

    .line 934
    .local v5, "size":J
    const-wide/16 v7, 0x0

    cmp-long v7, v5, v7

    if-ltz v7, :cond_3

    .line 932
    .end local v5    # "size":J
    add-int/lit8 v4, v4, 0x1

    goto :goto_3

    .line 935
    .restart local v5    # "size":J
    :cond_3
    new-instance v2, Ljava/io/IOException;

    const-string v7, "negative unpackSize"

    invoke-direct {v2, v7}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 938
    .end local v3    # "numUnpackSubStreams":I
    .end local v4    # "i":I
    .end local v5    # "size":J
    :cond_4
    goto :goto_2

    .line 939
    :cond_5
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    .line 942
    :cond_6
    const/4 v2, 0x0

    .line 943
    .local v2, "numDigests":I
    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_8

    .line 944
    invoke-static {p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$500(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)Ljava/util/BitSet;

    move-result-object v3

    if-nez v3, :cond_7

    invoke-static {p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$200(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)I

    move-result v3

    goto :goto_4

    .line 945
    :cond_7
    invoke-static {p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$200(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)I

    move-result v3

    invoke-static {p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$500(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)Ljava/util/BitSet;

    move-result-object v4

    invoke-virtual {v4}, Ljava/util/BitSet;->cardinality()I

    move-result v4

    sub-int/2addr v3, v4

    :goto_4
    move v2, v3

    goto :goto_8

    .line 947
    :cond_8
    const/4 v3, 0x0

    .line 948
    .local v3, "folderIdx":I
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_5
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_b

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Integer;

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    .line 949
    .local v5, "numUnpackSubStreams":I
    const/4 v6, 0x1

    if-ne v5, v6, :cond_a

    invoke-static {p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$500(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)Ljava/util/BitSet;

    move-result-object v6

    if-eqz v6, :cond_a

    .line 950
    invoke-static {p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$500(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)Ljava/util/BitSet;

    move-result-object v6

    add-int/lit8 v7, v3, 0x1

    .end local v3    # "folderIdx":I
    .local v7, "folderIdx":I
    invoke-virtual {v6, v3}, Ljava/util/BitSet;->get(I)Z

    move-result v3

    if-nez v3, :cond_9

    move v3, v7

    goto :goto_6

    :cond_9
    move v3, v7

    goto :goto_7

    .line 951
    .end local v7    # "folderIdx":I
    .restart local v3    # "folderIdx":I
    :cond_a
    :goto_6
    add-int/2addr v2, v5

    .line 953
    .end local v5    # "numUnpackSubStreams":I
    :goto_7
    goto :goto_5

    .line 956
    .end local v3    # "folderIdx":I
    :cond_b
    :goto_8
    const/16 v3, 0xa

    if-ne v0, v3, :cond_d

    .line 957
    const-string v3, "numDigests"

    int-to-long v4, v2

    invoke-static {v3, v4, v5}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    .line 958
    invoke-direct {p0, p1, v2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readAllOrBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;

    move-result-object v3

    .line 959
    invoke-virtual {v3}, Ljava/util/BitSet;->cardinality()I

    move-result v3

    .line 960
    .local v3, "missingCrcs":I
    mul-int/lit8 v4, v3, 0x4

    int-to-long v4, v4

    invoke-static {p1, v4, v5}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->skipBytesFully(Ljava/nio/ByteBuffer;J)J

    move-result-wide v4

    mul-int/lit8 v6, v3, 0x4

    int-to-long v6, v6

    cmp-long v4, v4, v6

    if-ltz v4, :cond_c

    .line 963
    invoke-static {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v0

    goto :goto_9

    .line 961
    :cond_c
    new-instance v4, Ljava/io/IOException;

    const-string v5, "invalid number of missing CRCs in SubStreamInfo"

    invoke-direct {v4, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 966
    .end local v3    # "missingCrcs":I
    :cond_d
    :goto_9
    if-nez v0, :cond_e

    .line 969
    return-void

    .line 967
    :cond_e
    new-instance v3, Ljava/io/IOException;

    const-string v4, "Badly terminated SubStreamsInfo"

    invoke-direct {v3, v4}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v3
.end method

.method private sanityCheckUnpackInfo(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)V
    .locals 18
    .param p1, "header"    # Ljava/nio/ByteBuffer;
    .param p2, "stats"    # Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 825
    move-object/from16 v0, p1

    move-object/from16 v1, p2

    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v2

    .line 826
    .local v2, "nid":I
    const/16 v3, 0xb

    if-ne v2, v3, :cond_a

    .line 829
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v3

    .line 830
    .local v3, "numFolders":J
    const-string v5, "numFolders"

    invoke-static {v5, v3, v4}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->assertFitsIntoNonNegativeInt(Ljava/lang/String;J)I

    move-result v5

    invoke-static {v1, v5}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$202(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;I)I

    .line 831
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v5

    .line 832
    .local v5, "external":I
    if-nez v5, :cond_9

    .line 836
    new-instance v6, Ljava/util/LinkedList;

    invoke-direct {v6}, Ljava/util/LinkedList;-><init>()V

    .line 837
    .local v6, "numberOfOutputStreamsPerFolder":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Integer;>;"
    const/4 v7, 0x0

    .local v7, "i":I
    :goto_0
    invoke-static/range {p2 .. p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$200(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)I

    move-result v8

    if-ge v7, v8, :cond_0

    .line 838
    invoke-direct/range {p0 .. p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->sanityCheckFolder(Ljava/nio/ByteBuffer;Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)I

    move-result v8

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    invoke-interface {v6, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 837
    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    .line 841
    .end local v7    # "i":I
    :cond_0
    invoke-static/range {p2 .. p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$300(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)J

    move-result-wide v7

    invoke-static/range {p2 .. p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$200(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)I

    move-result v9

    int-to-long v9, v9

    sub-long/2addr v7, v9

    .line 842
    .local v7, "totalNumberOfBindPairs":J
    invoke-static/range {p2 .. p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$400(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)J

    move-result-wide v9

    sub-long/2addr v9, v7

    .line 843
    .local v9, "packedStreamsRequiredByFolders":J
    invoke-static/range {p2 .. p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$100(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)I

    move-result v11

    int-to-long v11, v11

    cmp-long v11, v9, v11

    if-ltz v11, :cond_8

    .line 847
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v2

    .line 848
    const/16 v11, 0xc

    if-ne v2, v11, :cond_7

    .line 852
    invoke-interface {v6}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v11

    :goto_1
    invoke-interface {v11}, Ljava/util/Iterator;->hasNext()Z

    move-result v12

    if-eqz v12, :cond_3

    invoke-interface {v11}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/Integer;

    invoke-virtual {v12}, Ljava/lang/Integer;->intValue()I

    move-result v12

    .line 853
    .local v12, "numberOfOutputStreams":I
    const/4 v13, 0x0

    .local v13, "i":I
    :goto_2
    if-ge v13, v12, :cond_2

    .line 854
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readUint64(Ljava/nio/ByteBuffer;)J

    move-result-wide v14

    .line 855
    .local v14, "unpackSize":J
    const-wide/16 v16, 0x0

    cmp-long v16, v14, v16

    if-ltz v16, :cond_1

    .line 853
    .end local v14    # "unpackSize":J
    add-int/lit8 v13, v13, 0x1

    goto :goto_2

    .line 856
    .restart local v14    # "unpackSize":J
    :cond_1
    new-instance v11, Ljava/lang/IllegalArgumentException;

    move-wide/from16 v16, v3

    .end local v3    # "numFolders":J
    .local v16, "numFolders":J
    const-string v3, "negative unpackSize"

    invoke-direct {v11, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v11

    .line 853
    .end local v14    # "unpackSize":J
    .end local v16    # "numFolders":J
    .restart local v3    # "numFolders":J
    :cond_2
    move-wide/from16 v16, v3

    .line 859
    .end local v3    # "numFolders":J
    .end local v12    # "numberOfOutputStreams":I
    .end local v13    # "i":I
    .restart local v16    # "numFolders":J
    goto :goto_1

    .line 861
    .end local v16    # "numFolders":J
    .restart local v3    # "numFolders":J
    :cond_3
    move-wide/from16 v16, v3

    .end local v3    # "numFolders":J
    .restart local v16    # "numFolders":J
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v2

    .line 862
    const/16 v3, 0xa

    if-ne v2, v3, :cond_5

    .line 863
    invoke-static/range {p2 .. p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$200(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)I

    move-result v3

    move-object/from16 v4, p0

    invoke-direct {v4, v0, v3}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->readAllOrBits(Ljava/nio/ByteBuffer;I)Ljava/util/BitSet;

    move-result-object v3

    invoke-static {v1, v3}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$502(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;Ljava/util/BitSet;)Ljava/util/BitSet;

    .line 864
    invoke-static/range {p2 .. p2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;->access$500(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$ArchiveStatistics;)Ljava/util/BitSet;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/BitSet;->cardinality()I

    move-result v3

    .line 865
    .local v3, "crcsDefined":I
    mul-int/lit8 v11, v3, 0x4

    int-to-long v11, v11

    invoke-static {v0, v11, v12}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->skipBytesFully(Ljava/nio/ByteBuffer;J)J

    move-result-wide v11

    mul-int/lit8 v13, v3, 0x4

    int-to-long v13, v13

    cmp-long v11, v11, v13

    if-ltz v11, :cond_4

    .line 868
    invoke-static/range {p1 .. p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getUnsignedByte(Ljava/nio/ByteBuffer;)I

    move-result v2

    goto :goto_3

    .line 866
    :cond_4
    new-instance v11, Ljava/io/IOException;

    const-string v12, "invalid number of CRCs in UnpackInfo"

    invoke-direct {v11, v12}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v11

    .line 862
    .end local v3    # "crcsDefined":I
    :cond_5
    move-object/from16 v4, p0

    .line 871
    :goto_3
    if-nez v2, :cond_6

    .line 874
    return-void

    .line 872
    :cond_6
    new-instance v3, Ljava/io/IOException;

    const-string v11, "Badly terminated UnpackInfo"

    invoke-direct {v3, v11}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 849
    .end local v16    # "numFolders":J
    .local v3, "numFolders":J
    :cond_7
    move-wide/from16 v16, v3

    .end local v3    # "numFolders":J
    .restart local v16    # "numFolders":J
    new-instance v3, Ljava/io/IOException;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "Expected kCodersUnpackSize, got "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-direct {v3, v11}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 844
    .end local v16    # "numFolders":J
    .restart local v3    # "numFolders":J
    :cond_8
    move-wide/from16 v16, v3

    .end local v3    # "numFolders":J
    .restart local v16    # "numFolders":J
    new-instance v3, Ljava/io/IOException;

    const-string v11, "archive doesn\'t contain enough packed streams"

    invoke-direct {v3, v11}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 833
    .end local v6    # "numberOfOutputStreamsPerFolder":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Integer;>;"
    .end local v7    # "totalNumberOfBindPairs":J
    .end local v9    # "packedStreamsRequiredByFolders":J
    .end local v16    # "numFolders":J
    .restart local v3    # "numFolders":J
    :cond_9
    move-wide/from16 v16, v3

    .end local v3    # "numFolders":J
    .restart local v16    # "numFolders":J
    new-instance v3, Ljava/io/IOException;

    const-string v6, "External unsupported"

    invoke-direct {v3, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 827
    .end local v5    # "external":I
    .end local v16    # "numFolders":J
    :cond_a
    move-object/from16 v4, p0

    new-instance v3, Ljava/io/IOException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Expected kFolder, got "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v3, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v3
.end method

.method private static skipBytesFully(Ljava/nio/ByteBuffer;J)J
    .locals 4
    .param p0, "input"    # Ljava/nio/ByteBuffer;
    .param p1, "bytesToSkip"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2006
    const-wide/16 v0, 0x1

    cmp-long v0, p1, v0

    if-gez v0, :cond_0

    .line 2007
    const-wide/16 v0, 0x0

    return-wide v0

    .line 2009
    :cond_0
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->position()I

    move-result v0

    .line 2010
    .local v0, "current":I
    invoke-virtual {p0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v1

    .line 2011
    .local v1, "maxSkip":I
    int-to-long v2, v1

    cmp-long v2, v2, p1

    if-gez v2, :cond_1

    .line 2012
    int-to-long p1, v1

    .line 2014
    :cond_1
    long-to-int v2, p1

    add-int/2addr v2, v0

    invoke-virtual {p0, v2}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    .line 2015
    return-wide p1
.end method

.method private skipEntriesWhenNeeded(IZI)Z
    .locals 12
    .param p1, "entryIndex"    # I
    .param p2, "isInSameFolder"    # Z
    .param p3, "folderIndex"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1696
    iget-object v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v0, v0, Lorg/apache/commons/compress/archivers/sevenz/Archive;->files:[Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    aget-object v0, v0, p1

    .line 1699
    .local v0, "file":Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    iget v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentEntryIndex:I

    if-ne v1, p1, :cond_0

    invoke-direct {p0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->hasCurrentEntryBeenRead()Z

    move-result v1

    if-nez v1, :cond_0

    .line 1700
    const/4 v1, 0x0

    return v1

    .line 1708
    :cond_0
    iget-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v1, v1, Lorg/apache/commons/compress/archivers/sevenz/Archive;->streamMap:Lorg/apache/commons/compress/archivers/sevenz/StreamMap;

    iget-object v1, v1, Lorg/apache/commons/compress/archivers/sevenz/StreamMap;->folderFirstFileIndex:[I

    iget v2, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentFolderIndex:I

    aget v1, v1, v2

    .line 1709
    .local v1, "filesToSkipStartIndex":I
    const/4 v2, 0x1

    if-eqz p2, :cond_2

    .line 1710
    iget v3, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentEntryIndex:I

    if-ge v3, p1, :cond_1

    .line 1712
    iget v3, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentEntryIndex:I

    add-int/lit8 v1, v3, 0x1

    goto :goto_0

    .line 1717
    :cond_1
    invoke-direct {p0, p3, v0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->reopenFolderInputStream(ILorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;)V

    .line 1721
    :cond_2
    :goto_0
    move v3, v1

    .local v3, "i":I
    :goto_1
    if-ge v3, p1, :cond_4

    .line 1722
    iget-object v4, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v4, v4, Lorg/apache/commons/compress/archivers/sevenz/Archive;->files:[Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    aget-object v4, v4, v3

    .line 1723
    .local v4, "fileToSkip":Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    new-instance v6, Lorg/apache/commons/compress/utils/BoundedInputStream;

    iget-object v5, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentFolderInputStream:Ljava/io/InputStream;

    invoke-virtual {v4}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getSize()J

    move-result-wide v7

    invoke-direct {v6, v5, v7, v8}, Lorg/apache/commons/compress/utils/BoundedInputStream;-><init>(Ljava/io/InputStream;J)V

    .line 1724
    .local v6, "fileStreamToSkip":Ljava/io/InputStream;
    invoke-virtual {v4}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getHasCrc()Z

    move-result v5

    if-eqz v5, :cond_3

    .line 1725
    new-instance v11, Lorg/apache/commons/compress/utils/CRC32VerifyingInputStream;

    invoke-virtual {v4}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getSize()J

    move-result-wide v7

    invoke-virtual {v4}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getCrcValue()J

    move-result-wide v9

    move-object v5, v11

    invoke-direct/range {v5 .. v10}, Lorg/apache/commons/compress/utils/CRC32VerifyingInputStream;-><init>(Ljava/io/InputStream;JJ)V

    .end local v6    # "fileStreamToSkip":Ljava/io/InputStream;
    .local v5, "fileStreamToSkip":Ljava/io/InputStream;
    goto :goto_2

    .line 1724
    .end local v5    # "fileStreamToSkip":Ljava/io/InputStream;
    .restart local v6    # "fileStreamToSkip":Ljava/io/InputStream;
    :cond_3
    move-object v5, v6

    .line 1727
    .end local v6    # "fileStreamToSkip":Ljava/io/InputStream;
    .restart local v5    # "fileStreamToSkip":Ljava/io/InputStream;
    :goto_2
    iget-object v6, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->deferredBlockStreams:Ljava/util/ArrayList;

    invoke-virtual {v6, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 1730
    invoke-virtual {v0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getContentMethods()Ljava/lang/Iterable;

    move-result-object v6

    invoke-virtual {v4, v6}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setContentMethods(Ljava/lang/Iterable;)V

    .line 1721
    .end local v4    # "fileToSkip":Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    .end local v5    # "fileStreamToSkip":Ljava/io/InputStream;
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 1732
    .end local v3    # "i":I
    :cond_4
    return v2
.end method

.method private tryToLocateEndHeader([B)Lorg/apache/commons/compress/archivers/sevenz/Archive;
    .locals 17
    .param p1, "password"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 486
    move-object/from16 v1, p0

    const/4 v2, 0x1

    invoke-static {v2}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v3

    .line 487
    .local v3, "nidBuf":Ljava/nio/ByteBuffer;
    const-wide/32 v4, 0x100000

    .line 489
    .local v4, "searchLimit":J
    iget-object v0, v1, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    invoke-interface {v0}, Ljava/nio/channels/SeekableByteChannel;->position()J

    move-result-wide v6

    const-wide/16 v8, 0x14

    add-long/2addr v6, v8

    .line 492
    .local v6, "previousDataSize":J
    iget-object v0, v1, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    invoke-interface {v0}, Ljava/nio/channels/SeekableByteChannel;->position()J

    move-result-wide v8

    const-wide/32 v10, 0x100000

    add-long/2addr v8, v10

    iget-object v0, v1, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    invoke-interface {v0}, Ljava/nio/channels/SeekableByteChannel;->size()J

    move-result-wide v12

    cmp-long v0, v8, v12

    if-lez v0, :cond_0

    .line 493
    iget-object v0, v1, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    invoke-interface {v0}, Ljava/nio/channels/SeekableByteChannel;->position()J

    move-result-wide v8

    .local v8, "minPos":J
    goto :goto_0

    .line 495
    .end local v8    # "minPos":J
    :cond_0
    iget-object v0, v1, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    invoke-interface {v0}, Ljava/nio/channels/SeekableByteChannel;->size()J

    move-result-wide v8

    sub-long/2addr v8, v10

    .line 497
    .restart local v8    # "minPos":J
    :goto_0
    iget-object v0, v1, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    invoke-interface {v0}, Ljava/nio/channels/SeekableByteChannel;->size()J

    move-result-wide v10

    const-wide/16 v12, 0x1

    sub-long/2addr v10, v12

    .line 499
    .local v10, "pos":J
    :goto_1
    cmp-long v0, v10, v8

    if-lez v0, :cond_5

    .line 500
    sub-long/2addr v10, v12

    .line 501
    iget-object v0, v1, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    invoke-interface {v0, v10, v11}, Ljava/nio/channels/SeekableByteChannel;->position(J)Ljava/nio/channels/SeekableByteChannel;

    .line 502
    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    .line 503
    iget-object v0, v1, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    invoke-interface {v0, v3}, Ljava/nio/channels/SeekableByteChannel;->read(Ljava/nio/ByteBuffer;)I

    move-result v0

    if-lt v0, v2, :cond_4

    .line 506
    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v0

    const/4 v14, 0x0

    aget-byte v15, v0, v14

    .line 508
    .local v15, "nid":I
    const/16 v0, 0x17

    if-eq v15, v0, :cond_2

    if-ne v15, v2, :cond_1

    goto :goto_2

    :cond_1
    move-object/from16 v2, p1

    move-object/from16 v16, v3

    goto :goto_3

    .line 511
    :cond_2
    :goto_2
    :try_start_0
    new-instance v0, Lorg/apache/commons/compress/archivers/sevenz/StartHeader;

    invoke-direct {v0}, Lorg/apache/commons/compress/archivers/sevenz/StartHeader;-><init>()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2

    .line 512
    .local v0, "startHeader":Lorg/apache/commons/compress/archivers/sevenz/StartHeader;
    move-object/from16 v16, v3

    .end local v3    # "nidBuf":Ljava/nio/ByteBuffer;
    .local v16, "nidBuf":Ljava/nio/ByteBuffer;
    sub-long v2, v10, v6

    :try_start_1
    iput-wide v2, v0, Lorg/apache/commons/compress/archivers/sevenz/StartHeader;->nextHeaderOffset:J

    .line 513
    iget-object v2, v1, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    invoke-interface {v2}, Ljava/nio/channels/SeekableByteChannel;->size()J

    move-result-wide v2

    sub-long/2addr v2, v10

    iput-wide v2, v0, Lorg/apache/commons/compress/archivers/sevenz/StartHeader;->nextHeaderSize:J
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 514
    move-object/from16 v2, p1

    :try_start_2
    invoke-direct {v1, v0, v2, v14}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->initializeArchive(Lorg/apache/commons/compress/archivers/sevenz/StartHeader;[BZ)Lorg/apache/commons/compress/archivers/sevenz/Archive;

    move-result-object v3

    .line 516
    .local v3, "result":Lorg/apache/commons/compress/archivers/sevenz/Archive;
    iget-object v14, v3, Lorg/apache/commons/compress/archivers/sevenz/Archive;->packSizes:[J

    array-length v14, v14

    if-lez v14, :cond_3

    iget-object v14, v3, Lorg/apache/commons/compress/archivers/sevenz/Archive;->files:[Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    array-length v14, v14
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    if-lez v14, :cond_3

    .line 517
    return-object v3

    .line 521
    .end local v0    # "startHeader":Lorg/apache/commons/compress/archivers/sevenz/StartHeader;
    .end local v3    # "result":Lorg/apache/commons/compress/archivers/sevenz/Archive;
    :cond_3
    goto :goto_3

    .line 519
    :catch_0
    move-exception v0

    goto :goto_3

    :catch_1
    move-exception v0

    move-object/from16 v2, p1

    goto :goto_3

    .end local v16    # "nidBuf":Ljava/nio/ByteBuffer;
    .local v3, "nidBuf":Ljava/nio/ByteBuffer;
    :catch_2
    move-exception v0

    move-object/from16 v2, p1

    move-object/from16 v16, v3

    .line 523
    .end local v3    # "nidBuf":Ljava/nio/ByteBuffer;
    .end local v15    # "nid":I
    .restart local v16    # "nidBuf":Ljava/nio/ByteBuffer;
    :goto_3
    move-object/from16 v3, v16

    const/4 v2, 0x1

    goto :goto_1

    .line 504
    .end local v16    # "nidBuf":Ljava/nio/ByteBuffer;
    .restart local v3    # "nidBuf":Ljava/nio/ByteBuffer;
    :cond_4
    new-instance v0, Ljava/io/EOFException;

    invoke-direct {v0}, Ljava/io/EOFException;-><init>()V

    throw v0

    .line 524
    :cond_5
    move-object/from16 v16, v3

    .end local v3    # "nidBuf":Ljava/nio/ByteBuffer;
    .restart local v16    # "nidBuf":Ljava/nio/ByteBuffer;
    new-instance v0, Ljava/io/IOException;

    const-string v3, "Start header corrupt and unable to guess end header"

    invoke-direct {v0, v3}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static utf16Decode([C)[B
    .locals 2
    .param p0, "chars"    # [C
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 2062
    if-nez p0, :cond_0

    .line 2063
    const/4 v0, 0x0

    return-object v0

    .line 2065
    :cond_0
    sget-object v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->PASSWORD_ENCODER:Ljava/nio/charset/CharsetEncoder;

    invoke-static {p0}, Ljava/nio/CharBuffer;->wrap([C)Ljava/nio/CharBuffer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/nio/charset/CharsetEncoder;->encode(Ljava/nio/CharBuffer;)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 2066
    .local v0, "encoded":Ljava/nio/ByteBuffer;
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->hasArray()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 2067
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v1

    return-object v1

    .line 2069
    :cond_1
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->remaining()I

    move-result v1

    new-array v1, v1, [B

    .line 2070
    .local v1, "e":[B
    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 2071
    return-object v1
.end method


# virtual methods
.method public close()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 385
    iget-object v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    if-eqz v0, :cond_2

    .line 387
    const/4 v0, 0x0

    const/4 v1, 0x0

    :try_start_0
    iget-object v2, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    invoke-interface {v2}, Ljava/nio/channels/SeekableByteChannel;->close()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 389
    iput-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    .line 390
    iget-object v2, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->password:[B

    if-eqz v2, :cond_0

    .line 391
    iget-object v2, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->password:[B

    invoke-static {v2, v0}, Ljava/util/Arrays;->fill([BB)V

    .line 393
    :cond_0
    iput-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->password:[B

    .line 394
    goto :goto_0

    .line 389
    :catchall_0
    move-exception v2

    iput-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->channel:Ljava/nio/channels/SeekableByteChannel;

    .line 390
    iget-object v3, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->password:[B

    if-eqz v3, :cond_1

    .line 391
    iget-object v3, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->password:[B

    invoke-static {v3, v0}, Ljava/util/Arrays;->fill([BB)V

    .line 393
    :cond_1
    iput-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->password:[B

    .line 394
    throw v2

    .line 396
    :cond_2
    :goto_0
    return-void
.end method

.method public getDefaultName()Ljava/lang/String;
    .locals 4

    .line 2047
    const-string/jumbo v0, "unknown archive"

    iget-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->fileName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->fileName:Ljava/lang/String;

    if-nez v0, :cond_0

    goto :goto_0

    .line 2051
    :cond_0
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->fileName:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v0

    .line 2052
    .local v0, "lastSegment":Ljava/lang/String;
    const-string v1, "."

    invoke-virtual {v0, v1}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v1

    .line 2053
    .local v1, "dotPos":I
    if-lez v1, :cond_1

    .line 2054
    const/4 v2, 0x0

    invoke-virtual {v0, v2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 2056
    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string/jumbo v3, "~"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    return-object v2

    .line 2048
    .end local v0    # "lastSegment":Ljava/lang/String;
    .end local v1    # "dotPos":I
    :cond_2
    :goto_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public getEntries()Ljava/lang/Iterable;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/lang/Iterable<",
            "Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;",
            ">;"
        }
    .end annotation

    .line 433
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v1, v1, Lorg/apache/commons/compress/archivers/sevenz/Archive;->files:[Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    return-object v0
.end method

.method public getInputStream(Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;)Ljava/io/InputStream;
    .locals 4
    .param p1, "entry"    # Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1861
    const/4 v0, -0x1

    .line 1862
    .local v0, "entryIndex":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    iget-object v2, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v2, v2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->files:[Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    array-length v2, v2

    if-ge v1, v2, :cond_1

    .line 1863
    iget-object v2, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v2, v2, Lorg/apache/commons/compress/archivers/sevenz/Archive;->files:[Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    aget-object v2, v2, v1

    if-ne p1, v2, :cond_0

    .line 1864
    move v0, v1

    .line 1865
    goto :goto_1

    .line 1862
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1869
    .end local v1    # "i":I
    :cond_1
    :goto_1
    if-ltz v0, :cond_2

    .line 1873
    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->buildDecodingStream(IZ)V

    .line 1874
    iput v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentEntryIndex:I

    .line 1875
    iget-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v1, v1, Lorg/apache/commons/compress/archivers/sevenz/Archive;->streamMap:Lorg/apache/commons/compress/archivers/sevenz/StreamMap;

    iget-object v1, v1, Lorg/apache/commons/compress/archivers/sevenz/StreamMap;->fileFolderIndex:[I

    aget v1, v1, v0

    iput v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentFolderIndex:I

    .line 1876
    invoke-direct {p0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getCurrentStream()Ljava/io/InputStream;

    move-result-object v1

    return-object v1

    .line 1870
    :cond_2
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Can not find "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " in "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->fileName:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public getNextEntry()Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 406
    iget v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentEntryIndex:I

    iget-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v1, v1, Lorg/apache/commons/compress/archivers/sevenz/Archive;->files:[Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    array-length v1, v1

    add-int/lit8 v1, v1, -0x1

    if-lt v0, v1, :cond_0

    .line 407
    const/4 v0, 0x0

    return-object v0

    .line 409
    :cond_0
    iget v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentEntryIndex:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentEntryIndex:I

    .line 410
    iget-object v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    iget-object v0, v0, Lorg/apache/commons/compress/archivers/sevenz/Archive;->files:[Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;

    iget v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentEntryIndex:I

    aget-object v0, v0, v1

    .line 411
    .local v0, "entry":Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;
    invoke-virtual {v0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->getName()Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_1

    iget-object v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->options:Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;

    invoke-virtual {v1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFileOptions;->getUseDefaultNameForUnnamedEntries()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 412
    invoke-virtual {p0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getDefaultName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZArchiveEntry;->setName(Ljava/lang/String;)V

    .line 414
    :cond_1
    iget v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->currentEntryIndex:I

    const/4 v2, 0x0

    invoke-direct {p0, v1, v2}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->buildDecodingStream(IZ)V

    .line 415
    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->compressedBytesReadFromCurrentEntry:J

    iput-wide v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->uncompressedBytesReadFromCurrentEntry:J

    .line 416
    return-object v0
.end method

.method public getStatisticsForCurrentEntry()Lorg/apache/commons/compress/utils/InputStreamStatistics;
    .locals 1

    .line 1919
    new-instance v0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$2;

    invoke-direct {v0, p0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile$2;-><init>(Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;)V

    return-object v0
.end method

.method public read()I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1820
    invoke-direct {p0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getCurrentStream()Ljava/io/InputStream;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/InputStream;->read()I

    move-result v0

    .line 1821
    .local v0, "b":I
    if-ltz v0, :cond_0

    .line 1822
    iget-wide v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->uncompressedBytesReadFromCurrentEntry:J

    const-wide/16 v3, 0x1

    add-long/2addr v1, v3

    iput-wide v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->uncompressedBytesReadFromCurrentEntry:J

    .line 1824
    :cond_0
    return v0
.end method

.method public read([B)I
    .locals 2
    .param p1, "b"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1888
    const/4 v0, 0x0

    array-length v1, p1

    invoke-virtual {p0, p1, v0, v1}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->read([BII)I

    move-result v0

    return v0
.end method

.method public read([BII)I
    .locals 5
    .param p1, "b"    # [B
    .param p2, "off"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 1902
    if-nez p3, :cond_0

    .line 1903
    const/4 v0, 0x0

    return v0

    .line 1905
    :cond_0
    invoke-direct {p0}, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->getCurrentStream()Ljava/io/InputStream;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Ljava/io/InputStream;->read([BII)I

    move-result v0

    .line 1906
    .local v0, "cnt":I
    if-lez v0, :cond_1

    .line 1907
    iget-wide v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->uncompressedBytesReadFromCurrentEntry:J

    int-to-long v3, v0

    add-long/2addr v1, v3

    iput-wide v1, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->uncompressedBytesReadFromCurrentEntry:J

    .line 1909
    :cond_1
    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .line 2026
    iget-object v0, p0, Lorg/apache/commons/compress/archivers/sevenz/SevenZFile;->archive:Lorg/apache/commons/compress/archivers/sevenz/Archive;

    invoke-virtual {v0}, Lorg/apache/commons/compress/archivers/sevenz/Archive;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
