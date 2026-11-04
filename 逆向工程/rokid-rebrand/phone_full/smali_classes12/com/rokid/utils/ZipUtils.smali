.class public Lcom/rokid/utils/ZipUtils;
.super Ljava/lang/Object;
.source "ZipUtils.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/utils/ZipUtils$DecompressCallback;
    }
.end annotation


# static fields
.field private static final BUFFER:I = 0x2000


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static compress(Ljava/io/File;Ljava/util/zip/ZipOutputStream;Ljava/lang/String;)V
    .locals 1
    .param p0, "file"    # Ljava/io/File;
    .param p1, "zipOut"    # Ljava/util/zip/ZipOutputStream;
    .param p2, "baseDir"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 57
    invoke-virtual {p0}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 58
    invoke-static {p0, p1, p2}, Lcom/rokid/utils/ZipUtils;->compressDirectory(Ljava/io/File;Ljava/util/zip/ZipOutputStream;Ljava/lang/String;)V

    goto :goto_0

    .line 60
    :cond_0
    invoke-static {p0, p1, p2}, Lcom/rokid/utils/ZipUtils;->compressFile(Ljava/io/File;Ljava/util/zip/ZipOutputStream;Ljava/lang/String;)V

    .line 62
    :goto_0
    return-void
.end method

.method public static compress(Ljava/lang/String;Ljava/lang/String;)V
    .locals 6
    .param p0, "srcPath"    # Ljava/lang/String;
    .param p1, "dstPath"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 29
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 30
    .local v0, "srcFile":Ljava/io/File;
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 31
    .local v1, "dstFile":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 35
    const/4 v2, 0x0

    .line 36
    .local v2, "out":Ljava/io/FileOutputStream;
    const/4 v3, 0x0

    .line 38
    .local v3, "zipOut":Ljava/util/zip/ZipOutputStream;
    :try_start_0
    new-instance v4, Ljava/io/FileOutputStream;

    invoke-direct {v4, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    move-object v2, v4

    .line 39
    new-instance v4, Ljava/util/zip/CheckedOutputStream;

    new-instance v5, Ljava/util/zip/CRC32;

    invoke-direct {v5}, Ljava/util/zip/CRC32;-><init>()V

    invoke-direct {v4, v2, v5}, Ljava/util/zip/CheckedOutputStream;-><init>(Ljava/io/OutputStream;Ljava/util/zip/Checksum;)V

    .line 40
    .local v4, "cos":Ljava/util/zip/CheckedOutputStream;
    new-instance v5, Ljava/util/zip/ZipOutputStream;

    invoke-direct {v5, v4}, Ljava/util/zip/ZipOutputStream;-><init>(Ljava/io/OutputStream;)V

    move-object v3, v5

    .line 41
    const-string v5, ""

    .line 42
    .local v5, "baseDir":Ljava/lang/String;
    invoke-static {v0, v3, v5}, Lcom/rokid/utils/ZipUtils;->compress(Ljava/io/File;Ljava/util/zip/ZipOutputStream;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 45
    .end local v4    # "cos":Ljava/util/zip/CheckedOutputStream;
    .end local v5    # "baseDir":Ljava/lang/String;
    nop

    .line 46
    invoke-virtual {v3}, Ljava/util/zip/ZipOutputStream;->close()V

    .line 47
    const/4 v2, 0x0

    .line 50
    if-eqz v2, :cond_0

    .line 51
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V

    .line 54
    :cond_0
    return-void

    .line 45
    :catchall_0
    move-exception v4

    if-eqz v3, :cond_1

    .line 46
    invoke-virtual {v3}, Ljava/util/zip/ZipOutputStream;->close()V

    .line 47
    const/4 v2, 0x0

    .line 50
    :cond_1
    if-eqz v2, :cond_2

    .line 51
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V

    .line 53
    :cond_2
    throw v4

    .line 32
    .end local v2    # "out":Ljava/io/FileOutputStream;
    .end local v3    # "zipOut":Ljava/util/zip/ZipOutputStream;
    :cond_3
    new-instance v2, Ljava/io/FileNotFoundException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string/jumbo v4, "\u4e0d\u5b58\u5728\uff01"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/FileNotFoundException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method private static compressDirectory(Ljava/io/File;Ljava/util/zip/ZipOutputStream;Ljava/lang/String;)V
    .locals 5
    .param p0, "dir"    # Ljava/io/File;
    .param p1, "zipOut"    # Ljava/util/zip/ZipOutputStream;
    .param p2, "baseDir"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 66
    invoke-virtual {p0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v0

    .line 67
    .local v0, "files":[Ljava/io/File;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, v0

    if-ge v1, v2, :cond_0

    .line 68
    aget-object v2, v0, v1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {p0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "/"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, p1, v3}, Lcom/rokid/utils/ZipUtils;->compress(Ljava/io/File;Ljava/util/zip/ZipOutputStream;Ljava/lang/String;)V

    .line 67
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 70
    .end local v1    # "i":I
    :cond_0
    return-void
.end method

.method private static compressFile(Ljava/io/File;Ljava/util/zip/ZipOutputStream;Ljava/lang/String;)V
    .locals 8
    .param p0, "file"    # Ljava/io/File;
    .param p1, "zipOut"    # Ljava/util/zip/ZipOutputStream;
    .param p2, "baseDir"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 74
    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    .line 75
    return-void

    .line 78
    :cond_0
    const/4 v0, 0x0

    .line 80
    .local v0, "bis":Ljava/io/BufferedInputStream;
    :try_start_0
    new-instance v1, Ljava/io/BufferedInputStream;

    new-instance v2, Ljava/io/FileInputStream;

    invoke-direct {v2, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-direct {v1, v2}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    move-object v0, v1

    .line 81
    new-instance v1, Ljava/util/zip/ZipEntry;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/util/zip/ZipEntry;-><init>(Ljava/lang/String;)V

    .line 82
    .local v1, "entry":Ljava/util/zip/ZipEntry;
    invoke-virtual {p1, v1}, Ljava/util/zip/ZipOutputStream;->putNextEntry(Ljava/util/zip/ZipEntry;)V

    .line 84
    const/16 v2, 0x2000

    new-array v3, v2, [B

    .line 85
    .local v3, "data":[B
    :goto_0
    const/4 v4, 0x0

    invoke-virtual {v0, v3, v4, v2}, Ljava/io/BufferedInputStream;->read([BII)I

    move-result v5

    move v6, v5

    .local v6, "count":I
    const/4 v7, -0x1

    if-eq v5, v7, :cond_1

    .line 86
    invoke-virtual {p1, v3, v4, v6}, Ljava/util/zip/ZipOutputStream;->write([BII)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 90
    .end local v1    # "entry":Ljava/util/zip/ZipEntry;
    .end local v3    # "data":[B
    .end local v6    # "count":I
    :cond_1
    nop

    .line 91
    invoke-virtual {v0}, Ljava/io/BufferedInputStream;->close()V

    .line 94
    return-void

    .line 90
    :catchall_0
    move-exception v1

    if-eqz v0, :cond_2

    .line 91
    invoke-virtual {v0}, Ljava/io/BufferedInputStream;->close()V

    .line 93
    :cond_2
    throw v1
.end method

.method public static decompress(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/utils/ZipUtils$DecompressCallback;)V
    .locals 20
    .param p0, "zipFile"    # Ljava/lang/String;
    .param p1, "dstPath"    # Ljava/lang/String;
    .param p2, "decompressCallback"    # Lcom/rokid/utils/ZipUtils$DecompressCallback;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 97
    move-object/from16 v1, p1

    move-object/from16 v2, p2

    const-string v0, "/"

    new-instance v3, Ljava/io/File;

    invoke-direct {v3, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 98
    .local v3, "pathFile":Ljava/io/File;
    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v4

    if-nez v4, :cond_0

    .line 99
    invoke-virtual {v3}, Ljava/io/File;->mkdirs()Z

    .line 101
    :cond_0
    new-instance v4, Ljava/util/zip/ZipFile;

    move-object/from16 v5, p0

    invoke-direct {v4, v5}, Ljava/util/zip/ZipFile;-><init>(Ljava/lang/String;)V

    .line 103
    .local v4, "zip":Ljava/util/zip/ZipFile;
    invoke-virtual {v4}, Ljava/util/zip/ZipFile;->size()I

    move-result v6

    .line 104
    .local v6, "total":I
    const/4 v7, 0x0

    .line 106
    .local v7, "process":I
    invoke-virtual {v4}, Ljava/util/zip/ZipFile;->entries()Ljava/util/Enumeration;

    move-result-object v8

    .local v8, "entries":Ljava/util/Enumeration;
    :goto_0
    invoke-interface {v8}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v9

    if-eqz v9, :cond_a

    .line 107
    invoke-interface {v8}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/util/zip/ZipEntry;

    .line 108
    .local v9, "entry":Ljava/util/zip/ZipEntry;
    invoke-virtual {v9}, Ljava/util/zip/ZipEntry;->getName()Ljava/lang/String;

    move-result-object v10

    .line 109
    .local v10, "zipEntryName":Ljava/lang/String;
    const/4 v11, 0x0

    .line 110
    .local v11, "in":Ljava/io/InputStream;
    const/4 v12, 0x0

    .line 112
    .local v12, "out":Ljava/io/OutputStream;
    :try_start_0
    invoke-virtual {v4, v9}, Ljava/util/zip/ZipFile;->getInputStream(Ljava/util/zip/ZipEntry;)Ljava/io/InputStream;

    move-result-object v13

    move-object v11, v13

    .line 113
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v13, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    const-string v14, "\\*"

    invoke-virtual {v13, v14, v0}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    .line 115
    .local v13, "outPath":Ljava/lang/String;
    new-instance v14, Ljava/io/File;

    const/16 v15, 0x2f

    invoke-virtual {v13, v15}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v15

    move-object/from16 v16, v0

    const/4 v0, 0x0

    invoke-virtual {v13, v0, v15}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v15

    invoke-direct {v14, v15}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 116
    .local v14, "file":Ljava/io/File;
    invoke-virtual {v14}, Ljava/io/File;->exists()Z

    move-result v15
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    if-nez v15, :cond_1

    .line 117
    :try_start_1
    invoke-virtual {v14}, Ljava/io/File;->mkdirs()Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    .line 138
    .end local v13    # "outPath":Ljava/lang/String;
    .end local v14    # "file":Ljava/io/File;
    :catchall_0
    move-exception v0

    move-object/from16 v18, v3

    goto/16 :goto_5

    .line 119
    .restart local v13    # "outPath":Ljava/lang/String;
    .restart local v14    # "file":Ljava/io/File;
    :cond_1
    :goto_1
    add-int/lit8 v7, v7, 0x1

    .line 121
    :try_start_2
    new-instance v15, Ljava/io/File;

    invoke-direct {v15, v13}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v15}, Ljava/io/File;->isDirectory()Z

    move-result v15
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    if-eqz v15, :cond_4

    .line 138
    if-eqz v11, :cond_2

    .line 139
    invoke-virtual {v11}, Ljava/io/InputStream;->close()V

    .line 142
    :cond_2
    if-eqz v12, :cond_3

    .line 143
    invoke-virtual {v12}, Ljava/io/OutputStream;->close()V

    move-object/from16 v18, v3

    goto :goto_4

    .line 142
    :cond_3
    move-object/from16 v18, v3

    goto :goto_4

    .line 125
    :cond_4
    :try_start_3
    new-instance v15, Ljava/io/FileOutputStream;

    invoke-direct {v15, v13}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;)V

    move-object v12, v15

    .line 126
    const/16 v15, 0x400

    new-array v15, v15, [B

    .line 128
    .local v15, "buf1":[B
    :goto_2
    invoke-virtual {v11, v15}, Ljava/io/InputStream;->read([B)I

    move-result v17
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    move/from16 v18, v17

    .local v18, "len":I
    if-lez v17, :cond_5

    .line 129
    move/from16 v1, v18

    .end local v18    # "len":I
    .local v1, "len":I
    :try_start_4
    invoke-virtual {v12, v15, v0, v1}, Ljava/io/OutputStream;->write([BII)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    move-object/from16 v1, p1

    goto :goto_2

    .line 132
    .end local v1    # "len":I
    .restart local v18    # "len":I
    :cond_5
    move/from16 v1, v18

    .end local v18    # "len":I
    .restart local v1    # "len":I
    if-eqz v2, :cond_6

    .line 133
    mul-int/lit8 v0, v7, 0x64

    :try_start_5
    div-int/2addr v0, v6

    int-to-float v0, v0

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    move/from16 v17, v1

    .end local v1    # "len":I
    .local v17, "len":I
    int-to-double v0, v0

    const-wide/high16 v18, 0x4059000000000000L    # 100.0

    div-double v0, v0, v18

    .line 134
    .local v0, "percent":D
    move-object/from16 v18, v3

    .end local v3    # "pathFile":Ljava/io/File;
    .local v18, "pathFile":Ljava/io/File;
    double-to-float v3, v0

    :try_start_6
    invoke-interface {v2, v3}, Lcom/rokid/utils/ZipUtils$DecompressCallback;->onDecompressPercent(F)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    goto :goto_3

    .line 138
    .end local v0    # "percent":D
    .end local v13    # "outPath":Ljava/lang/String;
    .end local v14    # "file":Ljava/io/File;
    .end local v15    # "buf1":[B
    .end local v17    # "len":I
    :catchall_1
    move-exception v0

    goto :goto_5

    .line 132
    .end local v18    # "pathFile":Ljava/io/File;
    .restart local v1    # "len":I
    .restart local v3    # "pathFile":Ljava/io/File;
    .restart local v13    # "outPath":Ljava/lang/String;
    .restart local v14    # "file":Ljava/io/File;
    .restart local v15    # "buf1":[B
    :cond_6
    move/from16 v17, v1

    move-object/from16 v18, v3

    .line 138
    .end local v1    # "len":I
    .end local v3    # "pathFile":Ljava/io/File;
    .end local v13    # "outPath":Ljava/lang/String;
    .end local v14    # "file":Ljava/io/File;
    .end local v15    # "buf1":[B
    .restart local v18    # "pathFile":Ljava/io/File;
    :goto_3
    if-eqz v11, :cond_7

    .line 139
    invoke-virtual {v11}, Ljava/io/InputStream;->close()V

    .line 142
    :cond_7
    nop

    .line 143
    invoke-virtual {v12}, Ljava/io/OutputStream;->close()V

    .line 146
    .end local v9    # "entry":Ljava/util/zip/ZipEntry;
    .end local v10    # "zipEntryName":Ljava/lang/String;
    .end local v11    # "in":Ljava/io/InputStream;
    .end local v12    # "out":Ljava/io/OutputStream;
    nop

    .line 106
    .end local v18    # "pathFile":Ljava/io/File;
    .restart local v3    # "pathFile":Ljava/io/File;
    :goto_4
    move-object/from16 v1, p1

    move-object/from16 v0, v16

    move-object/from16 v3, v18

    .end local v3    # "pathFile":Ljava/io/File;
    .restart local v18    # "pathFile":Ljava/io/File;
    goto/16 :goto_0

    .line 138
    .end local v18    # "pathFile":Ljava/io/File;
    .restart local v3    # "pathFile":Ljava/io/File;
    .restart local v9    # "entry":Ljava/util/zip/ZipEntry;
    .restart local v10    # "zipEntryName":Ljava/lang/String;
    .restart local v11    # "in":Ljava/io/InputStream;
    .restart local v12    # "out":Ljava/io/OutputStream;
    :catchall_2
    move-exception v0

    move-object/from16 v18, v3

    .end local v3    # "pathFile":Ljava/io/File;
    .restart local v18    # "pathFile":Ljava/io/File;
    :goto_5
    if-eqz v11, :cond_8

    .line 139
    invoke-virtual {v11}, Ljava/io/InputStream;->close()V

    .line 142
    :cond_8
    if-eqz v12, :cond_9

    .line 143
    invoke-virtual {v12}, Ljava/io/OutputStream;->close()V

    .line 145
    :cond_9
    throw v0

    .line 147
    .end local v8    # "entries":Ljava/util/Enumeration;
    .end local v9    # "entry":Ljava/util/zip/ZipEntry;
    .end local v10    # "zipEntryName":Ljava/lang/String;
    .end local v11    # "in":Ljava/io/InputStream;
    .end local v12    # "out":Ljava/io/OutputStream;
    .end local v18    # "pathFile":Ljava/io/File;
    .restart local v3    # "pathFile":Ljava/io/File;
    :cond_a
    invoke-virtual {v4}, Ljava/util/zip/ZipFile;->close()V

    .line 148
    return-void
.end method

.method public static main([Ljava/lang/String;)V
    .locals 3
    .param p0, "args"    # [Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 159
    const-string v0, "/a/b/c/zipFolder"

    .line 160
    .local v0, "targetFolderPath":Ljava/lang/String;
    const-string v1, "/a/b/c/raw.zip"

    .line 161
    .local v1, "rawZipFilePath":Ljava/lang/String;
    const-string v2, "/a/b/c/new.zip"

    .line 167
    .local v2, "newZipFilePath":Ljava/lang/String;
    invoke-static {v0, v2}, Lcom/rokid/utils/ZipUtils;->compress(Ljava/lang/String;Ljava/lang/String;)V

    .line 169
    return-void
.end method
