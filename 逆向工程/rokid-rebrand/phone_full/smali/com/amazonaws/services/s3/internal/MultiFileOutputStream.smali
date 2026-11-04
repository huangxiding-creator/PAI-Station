.class public Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;
.super Ljava/io/OutputStream;
.source "MultiFileOutputStream.java"

# interfaces
.implements Lcom/amazonaws/services/s3/OnFileDelete;


# static fields
.field private static final DEFAULT_PART_SIZE:I = 0x500000

.field private static final PART_BYTE:I = 0x5

.field private static final SHIFT_VALUE:I = 0x14


# instance fields
.field private closed:Z

.field private currFileBytesWritten:I

.field private diskLimit:J

.field private diskPermits:Ljava/util/concurrent/Semaphore;

.field private filesCreated:I

.field private final namePrefix:Ljava/lang/String;

.field private observer:Lcom/amazonaws/services/s3/UploadObjectObserver;

.field private os:Ljava/io/FileOutputStream;

.field private partSize:J

.field private final root:Ljava/io/File;

.field private totalBytesWritten:J


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 67
    invoke-direct {p0}, Ljava/io/OutputStream;-><init>()V

    .line 44
    const-wide/32 v0, 0x500000

    iput-wide v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->partSize:J

    .line 45
    const-wide v0, 0x7fffffffffffffffL

    iput-wide v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->diskLimit:J

    .line 68
    new-instance v0, Ljava/io/File;

    const-string v1, "java.io.tmpdir"

    invoke-static {v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->root:Ljava/io/File;

    .line 69
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->yyMMdd_hhmmss()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->namePrefix:Ljava/lang/String;

    .line 70
    return-void
.end method

.method public constructor <init>(Ljava/io/File;Ljava/lang/String;)V
    .locals 3
    .param p1, "root"    # Ljava/io/File;
    .param p2, "namePrefix"    # Ljava/lang/String;

    .line 80
    invoke-direct {p0}, Ljava/io/OutputStream;-><init>()V

    .line 44
    const-wide/32 v0, 0x500000

    iput-wide v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->partSize:J

    .line 45
    const-wide v0, 0x7fffffffffffffffL

    iput-wide v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->diskLimit:J

    .line 81
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Ljava/io/File;->canWrite()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 85
    if-eqz p2, :cond_0

    invoke-virtual {p2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_0

    .line 89
    iput-object p1, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->root:Ljava/io/File;

    .line 90
    iput-object p2, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->namePrefix:Ljava/lang/String;

    .line 91
    return-void

    .line 86
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Please specify a non-empty name prefix"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 82
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " must be a writable directory"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private blockIfNecessary()V
    .locals 4

    .line 211
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->diskPermits:Ljava/util/concurrent/Semaphore;

    if-eqz v0, :cond_1

    iget-wide v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->diskLimit:J

    const-wide v2, 0x7fffffffffffffffL

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    goto :goto_0

    .line 215
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->diskPermits:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->acquire()V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 220
    nop

    .line 221
    return-void

    .line 216
    :catch_0
    move-exception v0

    .line 219
    .local v0, "e":Ljava/lang/InterruptedException;
    new-instance v1, Lcom/amazonaws/AbortedException;

    invoke-direct {v1, v0}, Lcom/amazonaws/AbortedException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 212
    .end local v0    # "e":Ljava/lang/InterruptedException;
    :cond_1
    :goto_0
    return-void
.end method

.method private fos()Ljava/io/FileOutputStream;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 176
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->closed:Z

    if-nez v0, :cond_3

    .line 179
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->os:Ljava/io/FileOutputStream;

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->currFileBytesWritten:I

    int-to-long v0, v0

    iget-wide v2, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->partSize:J

    cmp-long v0, v0, v2

    if-ltz v0, :cond_2

    .line 180
    :cond_0
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->os:Ljava/io/FileOutputStream;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    .line 181
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->os:Ljava/io/FileOutputStream;

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V

    .line 183
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->observer:Lcom/amazonaws/services/s3/UploadObjectObserver;

    new-instance v2, Lcom/amazonaws/services/s3/internal/PartCreationEvent;

    iget v3, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->filesCreated:I

    .line 184
    invoke-virtual {p0, v3}, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->getFile(I)Ljava/io/File;

    move-result-object v3

    iget v4, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->filesCreated:I

    invoke-direct {v2, v3, v4, v1, p0}, Lcom/amazonaws/services/s3/internal/PartCreationEvent;-><init>(Ljava/io/File;IZLcom/amazonaws/services/s3/OnFileDelete;)V

    .line 183
    invoke-virtual {v0, v2}, Lcom/amazonaws/services/s3/UploadObjectObserver;->onPartCreate(Lcom/amazonaws/services/s3/internal/PartCreationEvent;)V

    .line 186
    :cond_1
    iput v1, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->currFileBytesWritten:I

    .line 187
    iget v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->filesCreated:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->filesCreated:I

    .line 188
    invoke-direct {p0}, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->blockIfNecessary()V

    .line 189
    iget v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->filesCreated:I

    invoke-virtual {p0, v0}, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->getFile(I)Ljava/io/File;

    move-result-object v0

    .line 190
    .local v0, "file":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->deleteOnExit()V

    .line 191
    new-instance v1, Ljava/io/FileOutputStream;

    invoke-direct {v1, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    iput-object v1, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->os:Ljava/io/FileOutputStream;

    .line 193
    .end local v0    # "file":Ljava/io/File;
    :cond_2
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->os:Ljava/io/FileOutputStream;

    return-object v0

    .line 177
    :cond_3
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Output stream is already closed"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method static yyMMdd_hhmmss()Ljava/lang/String;
    .locals 2

    .line 302
    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string/jumbo v1, "yyMMdd-hhmmss"

    invoke-direct {v0, v1}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    new-instance v1, Ljava/util/Date;

    invoke-direct {v1}, Ljava/util/Date;-><init>()V

    invoke-virtual {v0, v1}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public cleanup()V
    .locals 5

    .line 256
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->getNumFilesWritten()I

    move-result v1

    if-ge v0, v1, :cond_1

    .line 257
    invoke-virtual {p0, v0}, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->getFile(I)Ljava/io/File;

    move-result-object v1

    .line 258
    .local v1, "f":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 259
    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    move-result v2

    if-nez v2, :cond_0

    .line 260
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-static {v2}, Lcom/amazonaws/logging/LogFactory;->getLog(Ljava/lang/Class;)Lcom/amazonaws/logging/Log;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Ignoring failure to delete file "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    .line 256
    .end local v1    # "f":Ljava/io/File;
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 265
    .end local v0    # "i":I
    :cond_1
    return-void
.end method

.method public close()V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 232
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->closed:Z

    if-eqz v0, :cond_0

    .line 233
    return-void

    .line 235
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->closed:Z

    .line 236
    iget-object v1, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->os:Ljava/io/FileOutputStream;

    if-eqz v1, :cond_2

    .line 237
    iget-object v1, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->os:Ljava/io/FileOutputStream;

    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V

    .line 238
    iget v1, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->filesCreated:I

    invoke-virtual {p0, v1}, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->getFile(I)Ljava/io/File;

    move-result-object v1

    .line 239
    .local v1, "lastPart":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->length()J

    move-result-wide v2

    const-wide/16 v4, 0x0

    cmp-long v2, v2, v4

    if-nez v2, :cond_1

    .line 240
    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    move-result v0

    if-nez v0, :cond_2

    .line 241
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-static {v0}, Lcom/amazonaws/logging/LogFactory;->getLog(Ljava/lang/Class;)Lcom/amazonaws/logging/Log;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Ignoring failure to delete empty file "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v2}, Lcom/amazonaws/logging/Log;->debug(Ljava/lang/Object;)V

    goto :goto_0

    .line 246
    :cond_1
    iget-object v2, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->observer:Lcom/amazonaws/services/s3/UploadObjectObserver;

    new-instance v3, Lcom/amazonaws/services/s3/internal/PartCreationEvent;

    iget v4, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->filesCreated:I

    .line 247
    invoke-virtual {p0, v4}, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->getFile(I)Ljava/io/File;

    move-result-object v4

    iget v5, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->filesCreated:I

    invoke-direct {v3, v4, v5, v0, p0}, Lcom/amazonaws/services/s3/internal/PartCreationEvent;-><init>(Ljava/io/File;IZLcom/amazonaws/services/s3/OnFileDelete;)V

    .line 246
    invoke-virtual {v2, v3}, Lcom/amazonaws/services/s3/UploadObjectObserver;->onPartCreate(Lcom/amazonaws/services/s3/internal/PartCreationEvent;)V

    .line 250
    .end local v1    # "lastPart":Ljava/io/File;
    :cond_2
    :goto_0
    return-void
.end method

.method public flush()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 225
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->os:Ljava/io/FileOutputStream;

    if-eqz v0, :cond_0

    .line 226
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->os:Ljava/io/FileOutputStream;

    invoke-virtual {v0}, Ljava/io/FileOutputStream;->flush()V

    .line 228
    :cond_0
    return-void
.end method

.method public getDiskLimit()J
    .locals 2

    .line 310
    iget-wide v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->diskLimit:J

    return-wide v0
.end method

.method public getFile(I)Ljava/io/File;
    .locals 4
    .param p1, "partNumber"    # I

    .line 281
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->root:Ljava/io/File;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->namePrefix:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v0
.end method

.method public getNamePrefix()Ljava/lang/String;
    .locals 1

    .line 293
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->namePrefix:Ljava/lang/String;

    return-object v0
.end method

.method public getNumFilesWritten()I
    .locals 1

    .line 272
    iget v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->filesCreated:I

    return v0
.end method

.method public getPartSize()J
    .locals 2

    .line 285
    iget-wide v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->partSize:J

    return-wide v0
.end method

.method public getRoot()Ljava/io/File;
    .locals 1

    .line 289
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->root:Ljava/io/File;

    return-object v0
.end method

.method public getTotalBytesWritten()J
    .locals 2

    .line 297
    iget-wide v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->totalBytesWritten:J

    return-wide v0
.end method

.method public init(Lcom/amazonaws/services/s3/UploadObjectObserver;JJ)Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;
    .locals 3
    .param p1, "observer"    # Lcom/amazonaws/services/s3/UploadObjectObserver;
    .param p2, "partSize"    # J
    .param p4, "diskLimit"    # J

    .line 111
    if-eqz p1, :cond_2

    .line 114
    iput-object p1, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->observer:Lcom/amazonaws/services/s3/UploadObjectObserver;

    .line 115
    const/4 v0, 0x1

    shl-long v0, p2, v0

    cmp-long v0, p4, v0

    if-ltz v0, :cond_1

    .line 120
    iput-wide p2, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->partSize:J

    .line 121
    iput-wide p4, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->diskLimit:J

    .line 122
    div-long v0, p4, p2

    long-to-int v0, v0

    .line 123
    .local v0, "max":I
    if-gez v0, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    new-instance v1, Ljava/util/concurrent/Semaphore;

    invoke-direct {v1, v0}, Ljava/util/concurrent/Semaphore;-><init>(I)V

    :goto_0
    iput-object v1, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->diskPermits:Ljava/util/concurrent/Semaphore;

    .line 124
    return-object p0

    .line 116
    .end local v0    # "max":I
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Maximum temporary disk space must be at least twice as large as the part size: partSize="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2, p3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", diskSize="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p4, p5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 112
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Observer must be specified"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public isClosed()Z
    .locals 1

    .line 306
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->closed:Z

    return v0
.end method

.method public onFileDelete(Lcom/amazonaws/services/s3/internal/FileDeletionEvent;)V
    .locals 1
    .param p1, "event"    # Lcom/amazonaws/services/s3/internal/FileDeletionEvent;

    .line 198
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->diskPermits:Ljava/util/concurrent/Semaphore;

    if-eqz v0, :cond_0

    .line 199
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->diskPermits:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 201
    :cond_0
    return-void
.end method

.method public write(I)V
    .locals 4
    .param p1, "b"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 134
    invoke-direct {p0}, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->fos()Ljava/io/FileOutputStream;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/io/FileOutputStream;->write(I)V

    .line 135
    iget v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->currFileBytesWritten:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->currFileBytesWritten:I

    .line 136
    iget-wide v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->totalBytesWritten:J

    const-wide/16 v2, 0x1

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->totalBytesWritten:J

    .line 137
    return-void
.end method

.method public write([B)V
    .locals 4
    .param p1, "b"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 146
    array-length v0, p1

    if-nez v0, :cond_0

    .line 147
    return-void

    .line 149
    :cond_0
    invoke-direct {p0}, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->fos()Ljava/io/FileOutputStream;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/io/FileOutputStream;->write([B)V

    .line 150
    iget v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->currFileBytesWritten:I

    array-length v1, p1

    add-int/2addr v0, v1

    iput v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->currFileBytesWritten:I

    .line 151
    iget-wide v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->totalBytesWritten:J

    array-length v2, p1

    int-to-long v2, v2

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->totalBytesWritten:J

    .line 152
    return-void
.end method

.method public write([BII)V
    .locals 4
    .param p1, "b"    # [B
    .param p2, "off"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 161
    array-length v0, p1

    if-nez v0, :cond_0

    .line 162
    return-void

    .line 164
    :cond_0
    invoke-direct {p0}, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->fos()Ljava/io/FileOutputStream;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Ljava/io/FileOutputStream;->write([BII)V

    .line 165
    iget v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->currFileBytesWritten:I

    add-int/2addr v0, p3

    iput v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->currFileBytesWritten:I

    .line 166
    iget-wide v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->totalBytesWritten:J

    int-to-long v2, p3

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/amazonaws/services/s3/internal/MultiFileOutputStream;->totalBytesWritten:J

    .line 167
    return-void
.end method
