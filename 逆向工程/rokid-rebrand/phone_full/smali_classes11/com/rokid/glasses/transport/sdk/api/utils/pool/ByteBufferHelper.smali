.class public final Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;
.super Ljava/lang/Object;
.source "ByteBufferHelper.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nByteBufferHelper.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ByteBufferHelper.kt\ncom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,52:1\n1855#2,2:53\n*S KotlinDebug\n*F\n+ 1 ByteBufferHelper.kt\ncom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper\n*L\n20#1:53,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000,\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0004\u0018\u00002\u00020\u0001:\u0001\u000fB\u0005\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u0007\u001a\u00020\u00052\u0006\u0010\u0008\u001a\u00020\tJ\u0010\u0010\n\u001a\u00020\u00052\u0006\u0010\u0008\u001a\u00020\tH\u0002J\u000e\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u0005J\u0006\u0010\u000e\u001a\u00020\u000cR\u001e\u0010\u0003\u001a\u0012\u0012\u0004\u0012\u00020\u00050\u0004j\u0008\u0012\u0004\u0012\u00020\u0005`\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0010"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;",
        "",
        "()V",
        "mBuffers",
        "Ljava/util/ArrayList;",
        "Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;",
        "Lkotlin/collections/ArrayList;",
        "allocateBuffer",
        "size",
        "",
        "allocateNew",
        "recycle",
        "",
        "managedByteBuffer",
        "release",
        "ManagedByteBuffer",
        "sdk-api_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field private final mBuffers:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->mBuffers:Ljava/util/ArrayList;

    .line 10
    return-void
.end method

.method private final allocateNew(I)Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    .locals 3
    .param p1, "size"    # I

    .line 45
    invoke-static {p1}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 46
    .local v0, "buffer":Ljava/nio/ByteBuffer;
    new-instance v1, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;

    const-string v2, "buffer"

    invoke-static {v0, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {v1, v0, p1}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;-><init>(Ljava/nio/ByteBuffer;I)V

    return-object v1
.end method


# virtual methods
.method public final declared-synchronized allocateBuffer(I)Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    .locals 8
    .param p1, "size"    # I

    monitor-enter p0

    .line 16
    :try_start_0
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->mBuffers:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 17
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->allocateNew(I)Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 19
    .end local p0    # "this":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;
    :cond_0
    const/4 v0, 0x0

    .line 20
    .local v0, "buffer":Ljava/lang/Object;
    :try_start_1
    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->mBuffers:Ljava/util/ArrayList;

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 53
    .local v2, "$i$f$forEach":I
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    .local v4, "element$iv":Ljava/lang/Object;
    move-object v5, v4

    check-cast v5, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;

    .local v5, "it":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    const/4 v6, 0x0

    .line 21
    .local v6, "$i$a$-forEach-ByteBufferHelper$allocateBuffer$1":I
    invoke-virtual {v5}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getOriginSize()I

    move-result v7

    if-lt v7, p1, :cond_1

    .line 22
    move-object v0, v5

    .line 23
    goto :goto_1

    .line 25
    :cond_1
    nop

    .line 53
    .end local v5    # "it":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    .end local v6    # "$i$a$-forEach-ByteBufferHelper$allocateBuffer$1":I
    :goto_1
    nop

    .end local v4    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 54
    :cond_2
    nop

    .line 26
    .end local v1    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$forEach":I
    if-eqz v0, :cond_3

    move-object v1, v0

    .local v1, "it":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    const/4 v2, 0x0

    .line 27
    .local v2, "$i$a$-let-ByteBufferHelper$allocateBuffer$2":I
    invoke-virtual {v1}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/nio/ByteBuffer;->limit(I)Ljava/nio/Buffer;

    .line 28
    invoke-virtual {v1}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->getBuffer()Ljava/nio/ByteBuffer;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    .line 29
    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->mBuffers:Ljava/util/ArrayList;

    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 30
    monitor-exit p0

    return-object v1

    .line 32
    .end local v1    # "it":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    .end local v2    # "$i$a$-let-ByteBufferHelper$allocateBuffer$2":I
    :cond_3
    :try_start_2
    invoke-direct {p0, p1}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->allocateNew(I)Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;

    move-result-object v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    monitor-exit p0

    return-object v1

    .line 15
    .end local v0    # "buffer":Ljava/lang/Object;
    .end local p1    # "size":I
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public final declared-synchronized recycle(Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;)V
    .locals 1
    .param p1, "managedByteBuffer"    # Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;

    monitor-enter p0

    :try_start_0
    const-string v0, "managedByteBuffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 37
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->mBuffers:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 38
    monitor-exit p0

    return-void

    .line 36
    .end local p0    # "this":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;
    .end local p1    # "managedByteBuffer":Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public final release()V
    .locals 1

    .line 41
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;->mBuffers:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 42
    return-void
.end method
