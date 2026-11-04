.class public Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;
.super Ljava/lang/Object;
.source "ByteArrayPool.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/base/common/util/ByteArrayPool$DEFAULT_HOLDER;
    }
.end annotation


# static fields
.field protected static final BUF_COMPARATOR:Ljava/util/Comparator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Comparator<",
            "[B>;"
        }
    .end annotation
.end field


# instance fields
.field private mBuffersByLastUse:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "[B>;"
        }
    .end annotation
.end field

.field private mBuffersBySize:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "[B>;"
        }
    .end annotation
.end field

.field private mCurrentSize:I

.field private final mSizeLimit:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 15
    new-instance v0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool$1;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool$1;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->BUF_COMPARATOR:Ljava/util/Comparator;

    return-void
.end method

.method public constructor <init>(I)V
    .locals 2
    .param p1, "sizeLimit"    # I

    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 11
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mBuffersByLastUse:Ljava/util/List;

    .line 12
    new-instance v0, Ljava/util/ArrayList;

    const/16 v1, 0x40

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mBuffersBySize:Ljava/util/List;

    .line 13
    const/4 v0, 0x0

    iput v0, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mCurrentSize:I

    .line 22
    iput p1, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mSizeLimit:I

    .line 23
    return-void
.end method

.method public static defaultPool()Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;
    .locals 1

    .line 26
    invoke-static {}, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool$DEFAULT_HOLDER;->access$000()Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;

    move-result-object v0

    return-object v0
.end method

.method private declared-synchronized trim()V
    .locals 3

    monitor-enter p0

    .line 59
    nop

    :goto_0
    :try_start_0
    iget v0, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mCurrentSize:I

    iget v1, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mSizeLimit:I

    if-le v0, v1, :cond_0

    .line 60
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mBuffersByLastUse:Ljava/util/List;

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [B

    .line 61
    .local v0, "buf":[B
    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mBuffersBySize:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 62
    iget v1, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mCurrentSize:I

    array-length v2, v0

    sub-int/2addr v1, v2

    iput v1, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mCurrentSize:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 63
    .end local v0    # "buf":[B
    goto :goto_0

    .line 65
    .end local p0    # "this":Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;
    :cond_0
    monitor-exit p0

    return-void

    .line 58
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method


# virtual methods
.method public declared-synchronized getBuf(I)[B
    .locals 4
    .param p1, "len"    # I

    monitor-enter p0

    .line 30
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    :try_start_0
    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mBuffersBySize:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-ge v0, v1, :cond_1

    .line 31
    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mBuffersBySize:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [B

    .line 32
    .local v1, "buf":[B
    array-length v2, v1

    if-ne v2, p1, :cond_0

    .line 33
    iget v2, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mCurrentSize:I

    array-length v3, v1

    sub-int/2addr v2, v3

    iput v2, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mCurrentSize:I

    .line 34
    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mBuffersBySize:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    .line 35
    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mBuffersByLastUse:Ljava/util/List;

    invoke-interface {v2, v1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 36
    monitor-exit p0

    return-object v1

    .line 30
    .end local v1    # "buf":[B
    .end local p0    # "this":Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 40
    .end local v0    # "i":I
    :cond_1
    :try_start_1
    new-array v0, p1, [B
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit p0

    return-object v0

    .line 29
    .end local p1    # "len":I
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized returnBuf([B)V
    .locals 3
    .param p1, "buf"    # [B

    monitor-enter p0

    .line 45
    if-eqz p1, :cond_1

    :try_start_0
    array-length v0, p1

    iget v1, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mSizeLimit:I

    if-gt v0, v1, :cond_1

    .line 46
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mBuffersByLastUse:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 47
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mBuffersBySize:Ljava/util/List;

    sget-object v1, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->BUF_COMPARATOR:Ljava/util/Comparator;

    invoke-static {v0, p1, v1}, Ljava/util/Collections;->binarySearch(Ljava/util/List;Ljava/lang/Object;Ljava/util/Comparator;)I

    move-result v0

    .line 48
    .local v0, "pos":I
    if-gez v0, :cond_0

    .line 49
    neg-int v1, v0

    add-int/lit8 v0, v1, -0x1

    .line 52
    :cond_0
    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mBuffersBySize:Ljava/util/List;

    invoke-interface {v1, v0, p1}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 53
    iget v1, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mCurrentSize:I

    array-length v2, p1

    add-int/2addr v1, v2

    iput v1, p0, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->mCurrentSize:I

    .line 54
    invoke-direct {p0}, Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;->trim()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 44
    .end local v0    # "pos":I
    .end local p0    # "this":Lcom/rokid/security/sdk/base/common/util/ByteArrayPool;
    .end local p1    # "buf":[B
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1

    .line 56
    .restart local p1    # "buf":[B
    :cond_1
    :goto_0
    monitor-exit p0

    return-void
.end method
