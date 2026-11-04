.class Lorg/apache/commons/compress/archivers/examples/Archiver$ArchiverFileVisitor;
.super Ljava/nio/file/SimpleFileVisitor;
.source "Archiver.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/apache/commons/compress/archivers/examples/Archiver;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "ArchiverFileVisitor"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/nio/file/SimpleFileVisitor<",
        "Ljava/nio/file/Path;",
        ">;"
    }
.end annotation


# instance fields
.field private final directory:Ljava/nio/file/Path;

.field private final linkOptions:[Ljava/nio/file/LinkOption;

.field private final target:Lorg/apache/commons/compress/archivers/ArchiveOutputStream;


# direct methods
.method private varargs constructor <init>(Lorg/apache/commons/compress/archivers/ArchiveOutputStream;Ljava/nio/file/Path;[Ljava/nio/file/LinkOption;)V
    .locals 1
    .param p1, "target"    # Lorg/apache/commons/compress/archivers/ArchiveOutputStream;
    .param p2, "directory"    # Ljava/nio/file/Path;
    .param p3, "linkOptions"    # [Ljava/nio/file/LinkOption;

    .line 61
    invoke-direct {p0}, Ljava/nio/file/SimpleFileVisitor;-><init>()V

    .line 62
    iput-object p1, p0, Lorg/apache/commons/compress/archivers/examples/Archiver$ArchiverFileVisitor;->target:Lorg/apache/commons/compress/archivers/ArchiveOutputStream;

    .line 63
    iput-object p2, p0, Lorg/apache/commons/compress/archivers/examples/Archiver$ArchiverFileVisitor;->directory:Ljava/nio/file/Path;

    .line 64
    if-nez p3, :cond_0

    sget-object v0, Lorg/apache/commons/compress/utils/IOUtils;->EMPTY_LINK_OPTIONS:[Ljava/nio/file/LinkOption;

    goto :goto_0

    :cond_0
    invoke-virtual {p3}, [Ljava/nio/file/LinkOption;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/nio/file/LinkOption;

    :goto_0
    iput-object v0, p0, Lorg/apache/commons/compress/archivers/examples/Archiver$ArchiverFileVisitor;->linkOptions:[Ljava/nio/file/LinkOption;

    .line 65
    return-void
.end method

.method synthetic constructor <init>(Lorg/apache/commons/compress/archivers/ArchiveOutputStream;Ljava/nio/file/Path;[Ljava/nio/file/LinkOption;Lorg/apache/commons/compress/archivers/examples/Archiver$1;)V
    .locals 0
    .param p1, "x0"    # Lorg/apache/commons/compress/archivers/ArchiveOutputStream;
    .param p2, "x1"    # Ljava/nio/file/Path;
    .param p3, "x2"    # [Ljava/nio/file/LinkOption;
    .param p4, "x3"    # Lorg/apache/commons/compress/archivers/examples/Archiver$1;

    .line 54
    invoke-direct {p0, p1, p2, p3}, Lorg/apache/commons/compress/archivers/examples/Archiver$ArchiverFileVisitor;-><init>(Lorg/apache/commons/compress/archivers/ArchiveOutputStream;Ljava/nio/file/Path;[Ljava/nio/file/LinkOption;)V

    return-void
.end method


# virtual methods
.method public bridge synthetic preVisitDirectory(Ljava/lang/Object;Ljava/nio/file/attribute/BasicFileAttributes;)Ljava/nio/file/FileVisitResult;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 54
    check-cast p1, Ljava/nio/file/Path;

    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/compress/archivers/examples/Archiver$ArchiverFileVisitor;->preVisitDirectory(Ljava/nio/file/Path;Ljava/nio/file/attribute/BasicFileAttributes;)Ljava/nio/file/FileVisitResult;

    move-result-object p1

    return-object p1
.end method

.method public preVisitDirectory(Ljava/nio/file/Path;Ljava/nio/file/attribute/BasicFileAttributes;)Ljava/nio/file/FileVisitResult;
    .locals 1
    .param p1, "dir"    # Ljava/nio/file/Path;
    .param p2, "attrs"    # Ljava/nio/file/attribute/BasicFileAttributes;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 69
    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lorg/apache/commons/compress/archivers/examples/Archiver$ArchiverFileVisitor;->visit(Ljava/nio/file/Path;Ljava/nio/file/attribute/BasicFileAttributes;Z)Ljava/nio/file/FileVisitResult;

    move-result-object v0

    return-object v0
.end method

.method protected visit(Ljava/nio/file/Path;Ljava/nio/file/attribute/BasicFileAttributes;Z)Ljava/nio/file/FileVisitResult;
    .locals 4
    .param p1, "path"    # Ljava/nio/file/Path;
    .param p2, "attrs"    # Ljava/nio/file/attribute/BasicFileAttributes;
    .param p3, "isFile"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 74
    invoke-static {p1}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 75
    invoke-static {p2}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 76
    iget-object v0, p0, Lorg/apache/commons/compress/archivers/examples/Archiver$ArchiverFileVisitor;->directory:Ljava/nio/file/Path;

    invoke-interface {v0, p1}, Ljava/nio/file/Path;->relativize(Ljava/nio/file/Path;)Ljava/nio/file/Path;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x5c

    const/16 v2, 0x2f

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v0

    .line 77
    .local v0, "name":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_3

    .line 78
    iget-object v1, p0, Lorg/apache/commons/compress/archivers/examples/Archiver$ArchiverFileVisitor;->target:Lorg/apache/commons/compress/archivers/ArchiveOutputStream;

    if-nez p3, :cond_1

    .line 79
    const-string v2, "/"

    invoke-virtual {v0, v2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    goto :goto_0

    :cond_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_1

    :cond_1
    :goto_0
    move-object v2, v0

    :goto_1
    iget-object v3, p0, Lorg/apache/commons/compress/archivers/examples/Archiver$ArchiverFileVisitor;->linkOptions:[Ljava/nio/file/LinkOption;

    .line 78
    invoke-virtual {v1, p1, v2, v3}, Lorg/apache/commons/compress/archivers/ArchiveOutputStream;->createArchiveEntry(Ljava/nio/file/Path;Ljava/lang/String;[Ljava/nio/file/LinkOption;)Lorg/apache/commons/compress/archivers/ArchiveEntry;

    move-result-object v1

    .line 80
    .local v1, "archiveEntry":Lorg/apache/commons/compress/archivers/ArchiveEntry;
    iget-object v2, p0, Lorg/apache/commons/compress/archivers/examples/Archiver$ArchiverFileVisitor;->target:Lorg/apache/commons/compress/archivers/ArchiveOutputStream;

    invoke-virtual {v2, v1}, Lorg/apache/commons/compress/archivers/ArchiveOutputStream;->putArchiveEntry(Lorg/apache/commons/compress/archivers/ArchiveEntry;)V

    .line 81
    if-eqz p3, :cond_2

    .line 83
    iget-object v2, p0, Lorg/apache/commons/compress/archivers/examples/Archiver$ArchiverFileVisitor;->target:Lorg/apache/commons/compress/archivers/ArchiveOutputStream;

    invoke-static {p1, v2}, Ljava/nio/file/Files;->copy(Ljava/nio/file/Path;Ljava/io/OutputStream;)J

    .line 85
    :cond_2
    iget-object v2, p0, Lorg/apache/commons/compress/archivers/examples/Archiver$ArchiverFileVisitor;->target:Lorg/apache/commons/compress/archivers/ArchiveOutputStream;

    invoke-virtual {v2}, Lorg/apache/commons/compress/archivers/ArchiveOutputStream;->closeArchiveEntry()V

    .line 87
    .end local v1    # "archiveEntry":Lorg/apache/commons/compress/archivers/ArchiveEntry;
    :cond_3
    sget-object v1, Ljava/nio/file/FileVisitResult;->CONTINUE:Ljava/nio/file/FileVisitResult;

    return-object v1
.end method

.method public bridge synthetic visitFile(Ljava/lang/Object;Ljava/nio/file/attribute/BasicFileAttributes;)Ljava/nio/file/FileVisitResult;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 54
    check-cast p1, Ljava/nio/file/Path;

    invoke-virtual {p0, p1, p2}, Lorg/apache/commons/compress/archivers/examples/Archiver$ArchiverFileVisitor;->visitFile(Ljava/nio/file/Path;Ljava/nio/file/attribute/BasicFileAttributes;)Ljava/nio/file/FileVisitResult;

    move-result-object p1

    return-object p1
.end method

.method public visitFile(Ljava/nio/file/Path;Ljava/nio/file/attribute/BasicFileAttributes;)Ljava/nio/file/FileVisitResult;
    .locals 1
    .param p1, "file"    # Ljava/nio/file/Path;
    .param p2, "attrs"    # Ljava/nio/file/attribute/BasicFileAttributes;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 92
    const/4 v0, 0x1

    invoke-virtual {p0, p1, p2, v0}, Lorg/apache/commons/compress/archivers/examples/Archiver$ArchiverFileVisitor;->visit(Ljava/nio/file/Path;Ljava/nio/file/attribute/BasicFileAttributes;Z)Ljava/nio/file/FileVisitResult;

    move-result-object v0

    return-object v0
.end method
