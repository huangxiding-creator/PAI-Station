.class Lorg/apache/commons/compress/archivers/tar/TarArchiveSparseZeroInputStream;
.super Ljava/io/InputStream;
.source "TarArchiveSparseZeroInputStream.java"


# direct methods
.method constructor <init>()V
    .locals 0

    .line 27
    invoke-direct {p0}, Ljava/io/InputStream;-><init>()V

    return-void
.end method


# virtual methods
.method public read()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 36
    const/4 v0, 0x0

    return v0
.end method

.method public skip(J)J
    .locals 0
    .param p1, "n"    # J

    .line 47
    return-wide p1
.end method
