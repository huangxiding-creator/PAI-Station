.class Lorg/xerial/snappy/buffer/CachedBufferAllocator$1;
.super Ljava/lang/Object;
.source "CachedBufferAllocator.java"

# interfaces
.implements Lorg/xerial/snappy/buffer/BufferAllocatorFactory;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/xerial/snappy/buffer/CachedBufferAllocator;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getBufferAllocator(I)Lorg/xerial/snappy/buffer/BufferAllocator;
    .locals 0

    .line 17
    invoke-static {p1}, Lorg/xerial/snappy/buffer/CachedBufferAllocator;->getAllocator(I)Lorg/xerial/snappy/buffer/CachedBufferAllocator;

    move-result-object p1

    return-object p1
.end method
