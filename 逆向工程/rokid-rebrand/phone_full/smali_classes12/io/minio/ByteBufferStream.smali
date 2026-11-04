.class Lio/minio/ByteBufferStream;
.super Ljava/io/ByteArrayOutputStream;
.source "ByteBufferStream.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 27
    invoke-direct {p0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 28
    return-void
.end method


# virtual methods
.method public inputStream()Ljava/io/InputStream;
    .locals 4

    .line 31
    new-instance v0, Ljava/io/ByteArrayInputStream;

    iget-object v1, p0, Lio/minio/ByteBufferStream;->buf:[B

    const/4 v2, 0x0

    iget v3, p0, Lio/minio/ByteBufferStream;->count:I

    invoke-direct {v0, v1, v2, v3}, Ljava/io/ByteArrayInputStream;-><init>([BII)V

    return-object v0
.end method
