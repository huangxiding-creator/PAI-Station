.class public Lorg/apache/commons/compress/harmony/pack200/Archive;
.super Ljava/lang/Object;
.source "Archive.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;,
        Lorg/apache/commons/compress/harmony/pack200/Archive$SegmentUnit;
    }
.end annotation


# instance fields
.field private currentSegmentSize:J

.field private jarFile:Ljava/util/jar/JarFile;

.field private final jarInputStream:Ljava/util/jar/JarInputStream;

.field private final options:Lorg/apache/commons/compress/harmony/pack200/PackingOptions;

.field private final outputStream:Ljava/io/OutputStream;


# direct methods
.method public constructor <init>(Ljava/util/jar/JarFile;Ljava/io/OutputStream;Lorg/apache/commons/compress/harmony/pack200/PackingOptions;)V
    .locals 1
    .param p1, "jarFile"    # Ljava/util/jar/JarFile;
    .param p2, "outputStream"    # Ljava/io/OutputStream;
    .param p3, "options"    # Lorg/apache/commons/compress/harmony/pack200/PackingOptions;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 75
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 76
    if-nez p3, :cond_0

    .line 77
    new-instance v0, Lorg/apache/commons/compress/harmony/pack200/PackingOptions;

    invoke-direct {v0}, Lorg/apache/commons/compress/harmony/pack200/PackingOptions;-><init>()V

    move-object p3, v0

    .line 79
    :cond_0
    iput-object p3, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->options:Lorg/apache/commons/compress/harmony/pack200/PackingOptions;

    .line 80
    invoke-virtual {p3}, Lorg/apache/commons/compress/harmony/pack200/PackingOptions;->isGzip()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 81
    new-instance v0, Ljava/util/zip/GZIPOutputStream;

    invoke-direct {v0, p2}, Ljava/util/zip/GZIPOutputStream;-><init>(Ljava/io/OutputStream;)V

    move-object p2, v0

    .line 83
    :cond_1
    new-instance v0, Ljava/io/BufferedOutputStream;

    invoke-direct {v0, p2}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;)V

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->outputStream:Ljava/io/OutputStream;

    .line 84
    iput-object p1, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->jarFile:Ljava/util/jar/JarFile;

    .line 85
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->jarInputStream:Ljava/util/jar/JarInputStream;

    .line 86
    invoke-static {p3}, Lorg/apache/commons/compress/harmony/pack200/PackingUtils;->config(Lorg/apache/commons/compress/harmony/pack200/PackingOptions;)V

    .line 87
    return-void
.end method

.method public constructor <init>(Ljava/util/jar/JarInputStream;Ljava/io/OutputStream;Lorg/apache/commons/compress/harmony/pack200/PackingOptions;)V
    .locals 1
    .param p1, "inputStream"    # Ljava/util/jar/JarInputStream;
    .param p2, "outputStream"    # Ljava/io/OutputStream;
    .param p3, "options"    # Lorg/apache/commons/compress/harmony/pack200/PackingOptions;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 53
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 54
    iput-object p1, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->jarInputStream:Ljava/util/jar/JarInputStream;

    .line 55
    if-nez p3, :cond_0

    .line 57
    new-instance v0, Lorg/apache/commons/compress/harmony/pack200/PackingOptions;

    invoke-direct {v0}, Lorg/apache/commons/compress/harmony/pack200/PackingOptions;-><init>()V

    move-object p3, v0

    .line 59
    :cond_0
    iput-object p3, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->options:Lorg/apache/commons/compress/harmony/pack200/PackingOptions;

    .line 60
    invoke-virtual {p3}, Lorg/apache/commons/compress/harmony/pack200/PackingOptions;->isGzip()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 61
    new-instance v0, Ljava/util/zip/GZIPOutputStream;

    invoke-direct {v0, p2}, Ljava/util/zip/GZIPOutputStream;-><init>(Ljava/io/OutputStream;)V

    move-object p2, v0

    .line 63
    :cond_1
    new-instance v0, Ljava/io/BufferedOutputStream;

    invoke-direct {v0, p2}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;)V

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->outputStream:Ljava/io/OutputStream;

    .line 64
    invoke-static {p3}, Lorg/apache/commons/compress/harmony/pack200/PackingUtils;->config(Lorg/apache/commons/compress/harmony/pack200/PackingOptions;)V

    .line 65
    return-void
.end method

.method private addJarEntry(Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;Ljava/util/List;Ljava/util/List;)Z
    .locals 10
    .param p1, "packingFile"    # Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;
    .param p2, "javaClasses"    # Ljava/util/List;
    .param p3, "files"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 177
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->options:Lorg/apache/commons/compress/harmony/pack200/PackingOptions;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/pack200/PackingOptions;->getSegmentLimit()J

    move-result-wide v0

    .line 178
    .local v0, "segmentLimit":J
    const-wide/16 v2, -0x1

    cmp-long v2, v0, v2

    const/4 v3, 0x0

    if-eqz v2, :cond_1

    const-wide/16 v4, 0x0

    cmp-long v2, v0, v4

    if-eqz v2, :cond_1

    .line 182
    invoke-direct {p0, p1}, Lorg/apache/commons/compress/harmony/pack200/Archive;->estimateSize(Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;)J

    move-result-wide v6

    .line 183
    .local v6, "packedSize":J
    iget-wide v8, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->currentSegmentSize:J

    add-long/2addr v8, v6

    cmp-long v2, v8, v0

    if-lez v2, :cond_0

    iget-wide v8, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->currentSegmentSize:J

    cmp-long v2, v8, v4

    if-lez v2, :cond_0

    .line 185
    return v3

    .line 188
    :cond_0
    iget-wide v4, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->currentSegmentSize:J

    add-long/2addr v4, v6

    iput-wide v4, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->currentSegmentSize:J

    .line 191
    .end local v6    # "packedSize":J
    :cond_1
    invoke-virtual {p1}, Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;->getName()Ljava/lang/String;

    move-result-object v2

    .line 192
    .local v2, "name":Ljava/lang/String;
    const-string v4, ".class"

    invoke-virtual {v2, v4}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2

    iget-object v4, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->options:Lorg/apache/commons/compress/harmony/pack200/PackingOptions;

    invoke-virtual {v4, v2}, Lorg/apache/commons/compress/harmony/pack200/PackingOptions;->isPassFile(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_2

    .line 193
    new-instance v4, Lorg/apache/commons/compress/harmony/pack200/Pack200ClassReader;

    invoke-static {p1}, Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;->access$000(Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;)[B

    move-result-object v5

    invoke-direct {v4, v5}, Lorg/apache/commons/compress/harmony/pack200/Pack200ClassReader;-><init>([B)V

    .line 194
    .local v4, "classParser":Lorg/apache/commons/compress/harmony/pack200/Pack200ClassReader;
    invoke-virtual {v4, v2}, Lorg/apache/commons/compress/harmony/pack200/Pack200ClassReader;->setFileName(Ljava/lang/String;)V

    .line 195
    invoke-interface {p2, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 196
    new-array v3, v3, [B

    invoke-static {p1, v3}, Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;->access$002(Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;[B)[B

    .line 198
    .end local v4    # "classParser":Lorg/apache/commons/compress/harmony/pack200/Pack200ClassReader;
    :cond_2
    invoke-interface {p3, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 199
    const/4 v3, 0x1

    return v3
.end method

.method private doNormalPack()V
    .locals 10
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 113
    const-string v0, "Start to perform a normal packing"

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/pack200/PackingUtils;->log(Ljava/lang/String;)V

    .line 115
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->jarInputStream:Ljava/util/jar/JarInputStream;

    if-eqz v0, :cond_0

    .line 116
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->jarInputStream:Ljava/util/jar/JarInputStream;

    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->options:Lorg/apache/commons/compress/harmony/pack200/PackingOptions;

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/pack200/PackingOptions;->isKeepFileOrder()Z

    move-result v1

    invoke-static {v0, v1}, Lorg/apache/commons/compress/harmony/pack200/PackingUtils;->getPackingFileListFromJar(Ljava/util/jar/JarInputStream;Z)Ljava/util/List;

    move-result-object v0

    .local v0, "packingFileList":Ljava/util/List;
    goto :goto_0

    .line 118
    .end local v0    # "packingFileList":Ljava/util/List;
    :cond_0
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->jarFile:Ljava/util/jar/JarFile;

    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->options:Lorg/apache/commons/compress/harmony/pack200/PackingOptions;

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/pack200/PackingOptions;->isKeepFileOrder()Z

    move-result v1

    invoke-static {v0, v1}, Lorg/apache/commons/compress/harmony/pack200/PackingUtils;->getPackingFileListFromJar(Ljava/util/jar/JarFile;Z)Ljava/util/List;

    move-result-object v0

    .line 121
    .restart local v0    # "packingFileList":Ljava/util/List;
    :goto_0
    invoke-direct {p0, v0}, Lorg/apache/commons/compress/harmony/pack200/Archive;->splitIntoSegments(Ljava/util/List;)Ljava/util/List;

    move-result-object v1

    .line 122
    .local v1, "segmentUnitList":Ljava/util/List;
    const/4 v2, 0x0

    .line 123
    .local v2, "previousByteAmount":I
    const/4 v3, 0x0

    .line 125
    .local v3, "packedByteAmount":I
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v4

    .line 127
    .local v4, "segmentSize":I
    const/4 v5, 0x0

    .local v5, "index":I
    :goto_1
    if-ge v5, v4, :cond_1

    .line 128
    invoke-interface {v1, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lorg/apache/commons/compress/harmony/pack200/Archive$SegmentUnit;

    .line 129
    .local v6, "segmentUnit":Lorg/apache/commons/compress/harmony/pack200/Archive$SegmentUnit;
    new-instance v7, Lorg/apache/commons/compress/harmony/pack200/Segment;

    invoke-direct {v7}, Lorg/apache/commons/compress/harmony/pack200/Segment;-><init>()V

    iget-object v8, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->outputStream:Ljava/io/OutputStream;

    iget-object v9, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->options:Lorg/apache/commons/compress/harmony/pack200/PackingOptions;

    invoke-virtual {v7, v6, v8, v9}, Lorg/apache/commons/compress/harmony/pack200/Segment;->pack(Lorg/apache/commons/compress/harmony/pack200/Archive$SegmentUnit;Ljava/io/OutputStream;Lorg/apache/commons/compress/harmony/pack200/PackingOptions;)V

    .line 130
    invoke-virtual {v6}, Lorg/apache/commons/compress/harmony/pack200/Archive$SegmentUnit;->getByteAmount()I

    move-result v7

    add-int/2addr v2, v7

    .line 131
    invoke-virtual {v6}, Lorg/apache/commons/compress/harmony/pack200/Archive$SegmentUnit;->getPackedByteAmount()I

    move-result v7

    add-int/2addr v3, v7

    .line 127
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 134
    .end local v5    # "index":I
    .end local v6    # "segmentUnit":Lorg/apache/commons/compress/harmony/pack200/Archive$SegmentUnit;
    :cond_1
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Total: Packed "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " input bytes of "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " files into "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " bytes in "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " segments"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lorg/apache/commons/compress/harmony/pack200/PackingUtils;->log(Ljava/lang/String;)V

    .line 137
    iget-object v5, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->outputStream:Ljava/io/OutputStream;

    invoke-virtual {v5}, Ljava/io/OutputStream;->close()V

    .line 138
    return-void
.end method

.method private doZeroEffortPack()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 104
    const-string v0, "Start to perform a zero-effort packing"

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/pack200/PackingUtils;->log(Ljava/lang/String;)V

    .line 105
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->jarInputStream:Ljava/util/jar/JarInputStream;

    if-eqz v0, :cond_0

    .line 106
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->jarInputStream:Ljava/util/jar/JarInputStream;

    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->outputStream:Ljava/io/OutputStream;

    invoke-static {v0, v1}, Lorg/apache/commons/compress/harmony/pack200/PackingUtils;->copyThroughJar(Ljava/util/jar/JarInputStream;Ljava/io/OutputStream;)V

    goto :goto_0

    .line 108
    :cond_0
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->jarFile:Ljava/util/jar/JarFile;

    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->outputStream:Ljava/io/OutputStream;

    invoke-static {v0, v1}, Lorg/apache/commons/compress/harmony/pack200/PackingUtils;->copyThroughJar(Ljava/util/jar/JarFile;Ljava/io/OutputStream;)V

    .line 110
    :goto_0
    return-void
.end method

.method private estimateSize(Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;)J
    .locals 8
    .param p1, "packingFile"    # Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;

    .line 205
    invoke-virtual {p1}, Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;->getName()Ljava/lang/String;

    move-result-object v0

    .line 206
    .local v0, "name":Ljava/lang/String;
    const-string v1, "META-INF"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    const-wide/16 v2, 0x0

    if-nez v1, :cond_2

    const-string v1, "/META-INF"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 209
    :cond_0
    invoke-static {p1}, Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;->access$000(Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;)[B

    move-result-object v1

    array-length v1, v1

    int-to-long v4, v1

    .line 210
    .local v4, "fileSize":J
    cmp-long v1, v4, v2

    if-gez v1, :cond_1

    .line 211
    const-wide/16 v4, 0x0

    .line 213
    :cond_1
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    int-to-long v1, v1

    add-long/2addr v1, v4

    const-wide/16 v6, 0x5

    add-long/2addr v1, v6

    return-wide v1

    .line 207
    .end local v4    # "fileSize":J
    :cond_2
    :goto_0
    return-wide v2
.end method

.method private splitIntoSegments(Ljava/util/List;)Ljava/util/List;
    .locals 13
    .param p1, "packingFileList"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 141
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 142
    .local v0, "segmentUnitList":Ljava/util/List;
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 143
    .local v1, "classes":Ljava/util/List;
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 144
    .local v2, "files":Ljava/util/List;
    iget-object v3, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->options:Lorg/apache/commons/compress/harmony/pack200/PackingOptions;

    invoke-virtual {v3}, Lorg/apache/commons/compress/harmony/pack200/PackingOptions;->getSegmentLimit()J

    move-result-wide v3

    .line 146
    .local v3, "segmentLimit":J
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v5

    .line 148
    .local v5, "size":I
    const/4 v6, 0x0

    .local v6, "index":I
    :goto_0
    if-ge v6, v5, :cond_2

    .line 149
    invoke-interface {p1, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;

    .line 150
    .local v7, "packingFile":Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;
    invoke-direct {p0, v7, v1, v2}, Lorg/apache/commons/compress/harmony/pack200/Archive;->addJarEntry(Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;Ljava/util/List;Ljava/util/List;)Z

    move-result v8

    const-wide/16 v9, 0x0

    if-nez v8, :cond_0

    .line 152
    new-instance v8, Lorg/apache/commons/compress/harmony/pack200/Archive$SegmentUnit;

    invoke-direct {v8, v1, v2}, Lorg/apache/commons/compress/harmony/pack200/Archive$SegmentUnit;-><init>(Ljava/util/List;Ljava/util/List;)V

    invoke-interface {v0, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 153
    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V

    move-object v1, v8

    .line 154
    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V

    move-object v2, v8

    .line 155
    iput-wide v9, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->currentSegmentSize:J

    .line 157
    invoke-direct {p0, v7, v1, v2}, Lorg/apache/commons/compress/harmony/pack200/Archive;->addJarEntry(Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;Ljava/util/List;Ljava/util/List;)Z

    .line 159
    iput-wide v9, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->currentSegmentSize:J

    goto :goto_1

    .line 160
    :cond_0
    cmp-long v8, v3, v9

    if-nez v8, :cond_1

    invoke-direct {p0, v7}, Lorg/apache/commons/compress/harmony/pack200/Archive;->estimateSize(Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;)J

    move-result-wide v11

    cmp-long v8, v11, v9

    if-lez v8, :cond_1

    .line 162
    new-instance v8, Lorg/apache/commons/compress/harmony/pack200/Archive$SegmentUnit;

    invoke-direct {v8, v1, v2}, Lorg/apache/commons/compress/harmony/pack200/Archive$SegmentUnit;-><init>(Ljava/util/List;Ljava/util/List;)V

    invoke-interface {v0, v8}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 163
    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V

    move-object v1, v8

    .line 164
    new-instance v8, Ljava/util/ArrayList;

    invoke-direct {v8}, Ljava/util/ArrayList;-><init>()V

    move-object v2, v8

    .line 148
    :cond_1
    :goto_1
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 169
    .end local v6    # "index":I
    .end local v7    # "packingFile":Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;
    :cond_2
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v6

    if-gtz v6, :cond_3

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v6

    if-lez v6, :cond_4

    .line 170
    :cond_3
    new-instance v6, Lorg/apache/commons/compress/harmony/pack200/Archive$SegmentUnit;

    invoke-direct {v6, v1, v2}, Lorg/apache/commons/compress/harmony/pack200/Archive$SegmentUnit;-><init>(Ljava/util/List;Ljava/util/List;)V

    invoke-interface {v0, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 172
    :cond_4
    return-object v0
.end method


# virtual methods
.method public pack()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;,
            Ljava/io/IOException;
        }
    .end annotation

    .line 96
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/Archive;->options:Lorg/apache/commons/compress/harmony/pack200/PackingOptions;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/pack200/PackingOptions;->getEffort()I

    move-result v0

    if-nez v0, :cond_0

    .line 97
    invoke-direct {p0}, Lorg/apache/commons/compress/harmony/pack200/Archive;->doZeroEffortPack()V

    goto :goto_0

    .line 99
    :cond_0
    invoke-direct {p0}, Lorg/apache/commons/compress/harmony/pack200/Archive;->doNormalPack()V

    .line 101
    :goto_0
    return-void
.end method
