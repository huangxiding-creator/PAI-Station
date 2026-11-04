.class public Lorg/xerial/snappy/buffer/CachedBufferAllocator;
.super Ljava/lang/Object;
.source "CachedBufferAllocator.java"

# interfaces
.implements Lorg/xerial/snappy/buffer/BufferAllocator;


# static fields
.field static final synthetic $assertionsDisabled:Z

.field private static factory:Lorg/xerial/snappy/buffer/BufferAllocatorFactory;

.field private static final queueTable:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Ljava/lang/ref/SoftReference<",
            "Lorg/xerial/snappy/buffer/CachedBufferAllocator;",
            ">;>;"
        }
    .end annotation
.end field


# instance fields
.field private final bufferQueue:Ljava/util/Deque;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Deque<",
            "[B>;"
        }
    .end annotation
.end field

.field private final bufferSize:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 9
    nop

    .line 12
    new-instance v0, Lorg/xerial/snappy/buffer/CachedBufferAllocator$1;

    invoke-direct {v0}, Lorg/xerial/snappy/buffer/CachedBufferAllocator$1;-><init>()V

    sput-object v0, Lorg/xerial/snappy/buffer/CachedBufferAllocator;->factory:Lorg/xerial/snappy/buffer/BufferAllocatorFactory;

    .line 35
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lorg/xerial/snappy/buffer/CachedBufferAllocator;->queueTable:Ljava/util/Map;

    return-void
.end method

.method public constructor <init>(I)V
    .locals 0

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 42
    iput p1, p0, Lorg/xerial/snappy/buffer/CachedBufferAllocator;->bufferSize:I

    .line 43
    new-instance p1, Ljava/util/ArrayDeque;

    invoke-direct {p1}, Ljava/util/ArrayDeque;-><init>()V

    iput-object p1, p0, Lorg/xerial/snappy/buffer/CachedBufferAllocator;->bufferQueue:Ljava/util/Deque;

    .line 44
    return-void
.end method

.method public static declared-synchronized getAllocator(I)Lorg/xerial/snappy/buffer/CachedBufferAllocator;
    .locals 4

    const-class v0, Lorg/xerial/snappy/buffer/CachedBufferAllocator;

    monitor-enter v0

    .line 48
    nop

    .line 50
    :try_start_0
    sget-object v1, Lorg/xerial/snappy/buffer/CachedBufferAllocator;->queueTable:Ljava/util/Map;

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 51
    sget-object v1, Lorg/xerial/snappy/buffer/CachedBufferAllocator;->queueTable:Ljava/util/Map;

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/ref/SoftReference;

    invoke-virtual {v1}, Ljava/lang/ref/SoftReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/xerial/snappy/buffer/CachedBufferAllocator;

    goto :goto_0

    .line 50
    :cond_0
    const/4 v1, 0x0

    .line 53
    :goto_0
    if-nez v1, :cond_1

    .line 54
    new-instance v1, Lorg/xerial/snappy/buffer/CachedBufferAllocator;

    invoke-direct {v1, p0}, Lorg/xerial/snappy/buffer/CachedBufferAllocator;-><init>(I)V

    .line 55
    sget-object v2, Lorg/xerial/snappy/buffer/CachedBufferAllocator;->queueTable:Ljava/util/Map;

    invoke-static {p0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p0

    new-instance v3, Ljava/lang/ref/SoftReference;

    invoke-direct {v3, v1}, Ljava/lang/ref/SoftReference;-><init>(Ljava/lang/Object;)V

    invoke-interface {v2, p0, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 57
    :cond_1
    monitor-exit v0

    return-object v1

    .line 47
    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static getBufferAllocatorFactory()Lorg/xerial/snappy/buffer/BufferAllocatorFactory;
    .locals 1

    .line 29
    sget-object v0, Lorg/xerial/snappy/buffer/CachedBufferAllocator;->factory:Lorg/xerial/snappy/buffer/BufferAllocatorFactory;

    return-object v0
.end method

.method public static setBufferAllocatorFactory(Lorg/xerial/snappy/buffer/BufferAllocatorFactory;)V
    .locals 0

    .line 23
    if-eqz p0, :cond_0

    .line 24
    sput-object p0, Lorg/xerial/snappy/buffer/CachedBufferAllocator;->factory:Lorg/xerial/snappy/buffer/BufferAllocatorFactory;

    .line 25
    return-void

    .line 23
    :cond_0
    new-instance p0, Ljava/lang/AssertionError;

    invoke-direct {p0}, Ljava/lang/AssertionError;-><init>()V

    throw p0
.end method


# virtual methods
.method public allocate(I)[B
    .locals 1

    .line 63
    monitor-enter p0

    .line 64
    :try_start_0
    iget-object v0, p0, Lorg/xerial/snappy/buffer/CachedBufferAllocator;->bufferQueue:Ljava/util/Deque;

    invoke-interface {v0}, Ljava/util/Deque;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 65
    new-array p1, p1, [B

    monitor-exit p0

    return-object p1

    .line 68
    :cond_0
    iget-object p1, p0, Lorg/xerial/snappy/buffer/CachedBufferAllocator;->bufferQueue:Ljava/util/Deque;

    invoke-interface {p1}, Ljava/util/Deque;->pollFirst()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [B

    monitor-exit p0

    return-object p1

    .line 70
    :catchall_0
    move-exception p1

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method public release([B)V
    .locals 1

    .line 76
    monitor-enter p0

    .line 77
    :try_start_0
    iget-object v0, p0, Lorg/xerial/snappy/buffer/CachedBufferAllocator;->bufferQueue:Ljava/util/Deque;

    invoke-interface {v0, p1}, Ljava/util/Deque;->addLast(Ljava/lang/Object;)V

    .line 78
    monitor-exit p0

    .line 79
    return-void

    .line 78
    :catchall_0
    move-exception p1

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method
