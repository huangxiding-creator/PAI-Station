.class public Lorg/xerial/snappy/SnappyHadoopCompatibleOutputStream;
.super Lorg/xerial/snappy/SnappyOutputStream;
.source "SnappyHadoopCompatibleOutputStream.java"


# direct methods
.method public constructor <init>(Ljava/io/OutputStream;)V
    .locals 1

    .line 11
    const v0, 0x8000

    invoke-direct {p0, p1, v0}, Lorg/xerial/snappy/SnappyHadoopCompatibleOutputStream;-><init>(Ljava/io/OutputStream;I)V

    .line 12
    return-void
.end method

.method public constructor <init>(Ljava/io/OutputStream;I)V
    .locals 1

    .line 16
    invoke-static {}, Lorg/xerial/snappy/buffer/CachedBufferAllocator;->getBufferAllocatorFactory()Lorg/xerial/snappy/buffer/BufferAllocatorFactory;

    move-result-object v0

    invoke-direct {p0, p1, p2, v0}, Lorg/xerial/snappy/SnappyOutputStream;-><init>(Ljava/io/OutputStream;ILorg/xerial/snappy/buffer/BufferAllocatorFactory;)V

    .line 17
    return-void
.end method


# virtual methods
.method protected writeBlockPreemble()V
    .locals 0

    .line 28
    invoke-virtual {p0}, Lorg/xerial/snappy/SnappyHadoopCompatibleOutputStream;->writeCurrentDataSize()V

    .line 29
    return-void
.end method

.method protected writeHeader()I
    .locals 1

    .line 22
    const/4 v0, 0x0

    return v0
.end method
