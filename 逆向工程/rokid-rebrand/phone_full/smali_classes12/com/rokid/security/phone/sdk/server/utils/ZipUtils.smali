.class public final Lcom/rokid/security/phone/sdk/server/utils/ZipUtils;
.super Ljava/lang/Object;
.source "ZipUtils.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nZipUtils.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ZipUtils.kt\ncom/rokid/security/phone/sdk/server/utils/ZipUtils\n+ 2 _Arrays.kt\nkotlin/collections/ArraysKt___ArraysKt\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,80:1\n13579#2,2:81\n1#3:83\n*S KotlinDebug\n*F\n+ 1 ZipUtils.kt\ncom/rokid/security/phone/sdk/server/utils/ZipUtils\n*L\n61#1:81,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000(\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u000e\n\u0000\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J \u0010\u0003\u001a\u00020\u00042\u0006\u0010\u0005\u001a\u00020\u00062\u0006\u0010\u0007\u001a\u00020\u00062\u0006\u0010\u0008\u001a\u00020\tH\u0002J\u0016\u0010\n\u001a\u00020\u00042\u0006\u0010\u000b\u001a\u00020\u00062\u0006\u0010\u000c\u001a\u00020\r\u00a8\u0006\u000e"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/utils/ZipUtils;",
        "",
        "()V",
        "addDirectoryToZip",
        "",
        "rootDir",
        "Ljava/io/File;",
        "currentFile",
        "zipOut",
        "Ljava/util/zip/ZipOutputStream;",
        "compressDirectory",
        "sourceDir",
        "zipFilePath",
        "",
        "sdk-server_release"
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/utils/ZipUtils;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/utils/ZipUtils;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/utils/ZipUtils;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/utils/ZipUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/utils/ZipUtils;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final addDirectoryToZip(Ljava/io/File;Ljava/io/File;Ljava/util/zip/ZipOutputStream;)V
    .locals 11
    .param p1, "rootDir"    # Ljava/io/File;
    .param p2, "currentFile"    # Ljava/io/File;
    .param p3, "zipOut"    # Ljava/util/zip/ZipOutputStream;

    .line 47
    invoke-virtual {p2}, Ljava/io/File;->isHidden()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 48
    return-void

    .line 52
    :cond_0
    invoke-virtual {p1}, Ljava/io/File;->toPath()Ljava/nio/file/Path;

    move-result-object v0

    invoke-virtual {p2}, Ljava/io/File;->toPath()Ljava/nio/file/Path;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/nio/file/Path;->relativize(Ljava/nio/file/Path;)Ljava/nio/file/Path;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    .line 54
    .local v0, "entryName":Ljava/lang/String;
    invoke-virtual {p2}, Ljava/io/File;->isDirectory()Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_5

    .line 56
    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-nez v1, :cond_1

    const/4 v1, 0x1

    goto :goto_0

    :cond_1
    move v1, v2

    :goto_0
    if-eqz v1, :cond_2

    const-string v1, ""

    goto :goto_1

    :cond_2
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v3, 0x2f

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 57
    .local v1, "dirEntryName":Ljava/lang/String;
    :goto_1
    new-instance v3, Ljava/util/zip/ZipEntry;

    invoke-direct {v3, v1}, Ljava/util/zip/ZipEntry;-><init>(Ljava/lang/String;)V

    invoke-virtual {p3, v3}, Ljava/util/zip/ZipOutputStream;->putNextEntry(Ljava/util/zip/ZipEntry;)V

    .line 58
    invoke-virtual {p3}, Ljava/util/zip/ZipOutputStream;->closeEntry()V

    .line 61
    invoke-virtual {p2}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v3

    if-eqz v3, :cond_4

    .local v3, "$this$forEach$iv":[Ljava/lang/Object;
    const/4 v4, 0x0

    .line 81
    .local v4, "$i$f$forEach":I
    array-length v5, v3

    :goto_2
    if-ge v2, v5, :cond_3

    aget-object v6, v3, v2

    .local v6, "element$iv":Ljava/lang/Object;
    move-object v7, v6

    .local v7, "childFile":Ljava/io/File;
    const/4 v8, 0x0

    .line 62
    .local v8, "$i$a$-forEach-ZipUtils$addDirectoryToZip$1":I
    sget-object v9, Lcom/rokid/security/phone/sdk/server/utils/ZipUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/utils/ZipUtils;

    const-string v10, "childFile"

    invoke-static {v7, v10}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {v9, p1, v7, p3}, Lcom/rokid/security/phone/sdk/server/utils/ZipUtils;->addDirectoryToZip(Ljava/io/File;Ljava/io/File;Ljava/util/zip/ZipOutputStream;)V

    .line 63
    nop

    .line 81
    .end local v7    # "childFile":Ljava/io/File;
    .end local v8    # "$i$a$-forEach-ZipUtils$addDirectoryToZip$1":I
    nop

    .end local v6    # "element$iv":Ljava/lang/Object;
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 82
    :cond_3
    nop

    .end local v3    # "$this$forEach$iv":[Ljava/lang/Object;
    .end local v4    # "$i$f$forEach":I
    goto :goto_4

    .line 61
    .end local v1    # "dirEntryName":Ljava/lang/String;
    :cond_4
    goto :goto_4

    .line 66
    :cond_5
    new-instance v1, Ljava/util/zip/ZipEntry;

    invoke-direct {v1, v0}, Ljava/util/zip/ZipEntry;-><init>(Ljava/lang/String;)V

    .line 67
    .local v1, "zipEntry":Ljava/util/zip/ZipEntry;
    invoke-virtual {p3, v1}, Ljava/util/zip/ZipOutputStream;->putNextEntry(Ljava/util/zip/ZipEntry;)V

    .line 69
    new-instance v3, Ljava/io/FileInputStream;

    invoke-direct {v3, p2}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    check-cast v3, Ljava/io/Closeable;

    :try_start_0
    move-object v4, v3

    check-cast v4, Ljava/io/FileInputStream;

    .local v4, "fileIn":Ljava/io/FileInputStream;
    const/4 v5, 0x0

    .line 70
    .local v5, "$i$a$-use-ZipUtils$addDirectoryToZip$2":I
    const/16 v6, 0x2000

    new-array v6, v6, [B

    .line 71
    .local v6, "buffer":[B
    const/4 v7, 0x0

    .line 72
    .local v7, "bytesRead":I
    :goto_3
    invoke-virtual {v4, v6}, Ljava/io/FileInputStream;->read([B)I

    move-result v8

    move v9, v8

    .line 83
    .local v9, "it":I
    const/4 v10, 0x0

    .line 72
    .local v10, "$i$a$-also-ZipUtils$addDirectoryToZip$2$1":I
    move v7, v9

    .end local v9    # "it":I
    .end local v10    # "$i$a$-also-ZipUtils$addDirectoryToZip$2$1":I
    const/4 v9, -0x1

    if-eq v8, v9, :cond_6

    .line 73
    invoke-virtual {p3, v6, v2, v7}, Ljava/util/zip/ZipOutputStream;->write([BII)V

    goto :goto_3

    .line 75
    :cond_6
    nop

    .end local v4    # "fileIn":Ljava/io/FileInputStream;
    .end local v5    # "$i$a$-use-ZipUtils$addDirectoryToZip$2":I
    .end local v6    # "buffer":[B
    .end local v7    # "bytesRead":I
    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 69
    const/4 v2, 0x0

    invoke-static {v3, v2}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 76
    invoke-virtual {p3}, Ljava/util/zip/ZipOutputStream;->closeEntry()V

    .line 78
    .end local v1    # "zipEntry":Ljava/util/zip/ZipEntry;
    :goto_4
    return-void

    .line 69
    .restart local v1    # "zipEntry":Ljava/util/zip/ZipEntry;
    :catchall_0
    move-exception v2

    .end local v0    # "entryName":Ljava/lang/String;
    .end local v1    # "zipEntry":Ljava/util/zip/ZipEntry;
    .end local p1    # "rootDir":Ljava/io/File;
    .end local p2    # "currentFile":Ljava/io/File;
    .end local p3    # "zipOut":Ljava/util/zip/ZipOutputStream;
    :try_start_1
    throw v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .restart local v0    # "entryName":Ljava/lang/String;
    .restart local v1    # "zipEntry":Ljava/util/zip/ZipEntry;
    .restart local p1    # "rootDir":Ljava/io/File;
    .restart local p2    # "currentFile":Ljava/io/File;
    .restart local p3    # "zipOut":Ljava/util/zip/ZipOutputStream;
    :catchall_1
    move-exception v4

    invoke-static {v3, v2}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    throw v4
.end method


# virtual methods
.method public final compressDirectory(Ljava/io/File;Ljava/lang/String;)V
    .locals 7
    .param p1, "sourceDir"    # Ljava/io/File;
    .param p2, "zipFilePath"    # Ljava/lang/String;

    const-string/jumbo v0, "sourceDir"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "zipFilePath"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 22
    nop

    .line 24
    :try_start_0
    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 28
    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p2}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;)V

    check-cast v0, Ljava/io/Closeable;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    move-object v1, v0

    check-cast v1, Ljava/io/FileOutputStream;

    .local v1, "fileOut":Ljava/io/FileOutputStream;
    const/4 v2, 0x0

    .line 29
    .local v2, "$i$a$-use-ZipUtils$compressDirectory$1":I
    new-instance v3, Ljava/util/zip/ZipOutputStream;

    move-object v4, v1

    check-cast v4, Ljava/io/OutputStream;

    invoke-direct {v3, v4}, Ljava/util/zip/ZipOutputStream;-><init>(Ljava/io/OutputStream;)V

    check-cast v3, Ljava/io/Closeable;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    :try_start_2
    move-object v4, v3

    check-cast v4, Ljava/util/zip/ZipOutputStream;

    .local v4, "zipOut":Ljava/util/zip/ZipOutputStream;
    const/4 v5, 0x0

    .line 31
    .local v5, "$i$a$-use-ZipUtils$compressDirectory$1$1":I
    sget-object v6, Lcom/rokid/security/phone/sdk/server/utils/ZipUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/utils/ZipUtils;

    invoke-direct {v6, p1, p1, v4}, Lcom/rokid/security/phone/sdk/server/utils/ZipUtils;->addDirectoryToZip(Ljava/io/File;Ljava/io/File;Ljava/util/zip/ZipOutputStream;)V

    .line 32
    nop

    .end local v4    # "zipOut":Ljava/util/zip/ZipOutputStream;
    .end local v5    # "$i$a$-use-ZipUtils$compressDirectory$1$1":I
    sget-object v4, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 29
    const/4 v4, 0x0

    :try_start_3
    invoke-static {v3, v4}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 33
    nop

    .end local v1    # "fileOut":Ljava/io/FileOutputStream;
    .end local v2    # "$i$a$-use-ZipUtils$compressDirectory$1":I
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 28
    :try_start_4
    invoke-static {v0, v4}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    goto :goto_0

    .line 29
    .restart local v1    # "fileOut":Ljava/io/FileOutputStream;
    .restart local v2    # "$i$a$-use-ZipUtils$compressDirectory$1":I
    :catchall_0
    move-exception v4

    .end local v1    # "fileOut":Ljava/io/FileOutputStream;
    .end local v2    # "$i$a$-use-ZipUtils$compressDirectory$1":I
    .end local p1    # "sourceDir":Ljava/io/File;
    .end local p2    # "zipFilePath":Ljava/lang/String;
    :try_start_5
    throw v4
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .restart local v1    # "fileOut":Ljava/io/FileOutputStream;
    .restart local v2    # "$i$a$-use-ZipUtils$compressDirectory$1":I
    .restart local p1    # "sourceDir":Ljava/io/File;
    .restart local p2    # "zipFilePath":Ljava/lang/String;
    :catchall_1
    move-exception v5

    :try_start_6
    invoke-static {v3, v4}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local p1    # "sourceDir":Ljava/io/File;
    .end local p2    # "zipFilePath":Ljava/lang/String;
    throw v5
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    .line 28
    .end local v1    # "fileOut":Ljava/io/FileOutputStream;
    .end local v2    # "$i$a$-use-ZipUtils$compressDirectory$1":I
    .restart local p1    # "sourceDir":Ljava/io/File;
    .restart local p2    # "zipFilePath":Ljava/lang/String;
    :catchall_2
    move-exception v1

    .end local p1    # "sourceDir":Ljava/io/File;
    .end local p2    # "zipFilePath":Ljava/lang/String;
    :try_start_7
    throw v1
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_3

    .restart local p1    # "sourceDir":Ljava/io/File;
    .restart local p2    # "zipFilePath":Ljava/lang/String;
    :catchall_3
    move-exception v2

    :try_start_8
    invoke-static {v0, v1}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local p1    # "sourceDir":Ljava/io/File;
    .end local p2    # "zipFilePath":Ljava/lang/String;
    throw v2

    .line 25
    .restart local p1    # "sourceDir":Ljava/io/File;
    .restart local p2    # "zipFilePath":Ljava/lang/String;
    :cond_0
    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "\u6e90\u76ee\u5f55\u4e0d\u5b58\u5728\u6216\u4e0d\u662f\u4e00\u4e2a\u6709\u6548\u7684\u76ee\u5f55: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    .end local p1    # "sourceDir":Ljava/io/File;
    .end local p2    # "zipFilePath":Ljava/lang/String;
    throw v0
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_0

    .line 34
    .restart local p1    # "sourceDir":Ljava/io/File;
    .restart local p2    # "zipFilePath":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 35
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 38
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method
