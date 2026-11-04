.class public final Lcom/fasterxml/aalto/util/BufferRecycler;
.super Ljava/lang/Object;
.source "BufferRecycler.java"


# instance fields
.field private volatile mFullBBuffer:[B

.field private volatile mFullCBuffer:[C

.field private volatile mMediumCBuffer:[C

.field private volatile mSmallCBuffer:[C


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 21
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/util/BufferRecycler;->mSmallCBuffer:[C

    .line 22
    iput-object v0, p0, Lcom/fasterxml/aalto/util/BufferRecycler;->mMediumCBuffer:[C

    .line 23
    iput-object v0, p0, Lcom/fasterxml/aalto/util/BufferRecycler;->mFullCBuffer:[C

    .line 25
    iput-object v0, p0, Lcom/fasterxml/aalto/util/BufferRecycler;->mFullBBuffer:[B

    .line 27
    return-void
.end method


# virtual methods
.method public declared-synchronized getFullBBuffer(I)[B
    .locals 3
    .param p1, "minSize"    # I

    monitor-enter p0

    .line 88
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/util/BufferRecycler;->mFullBBuffer:[B

    .line 89
    .local v0, "result":[B
    const/4 v1, 0x0

    if-eqz v0, :cond_0

    array-length v2, v0

    if-lt v2, p1, :cond_0

    .line 90
    iput-object v1, p0, Lcom/fasterxml/aalto/util/BufferRecycler;->mFullBBuffer:[B
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 91
    monitor-exit p0

    return-object v0

    .line 93
    .end local p0    # "this":Lcom/fasterxml/aalto/util/BufferRecycler;
    :cond_0
    monitor-exit p0

    return-object v1

    .line 87
    .end local v0    # "result":[B
    .end local p1    # "minSize":I
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized getFullCBuffer(I)[C
    .locals 3
    .param p1, "minSize"    # I

    monitor-enter p0

    .line 69
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/util/BufferRecycler;->mFullCBuffer:[C

    .line 70
    .local v0, "result":[C
    const/4 v1, 0x0

    if-eqz v0, :cond_0

    array-length v2, v0

    if-lt v2, p1, :cond_0

    .line 71
    iput-object v1, p0, Lcom/fasterxml/aalto/util/BufferRecycler;->mFullCBuffer:[C
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 72
    monitor-exit p0

    return-object v0

    .line 74
    .end local p0    # "this":Lcom/fasterxml/aalto/util/BufferRecycler;
    :cond_0
    monitor-exit p0

    return-object v1

    .line 68
    .end local v0    # "result":[C
    .end local p1    # "minSize":I
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized getMediumCBuffer(I)[C
    .locals 3
    .param p1, "minSize"    # I

    monitor-enter p0

    .line 52
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/util/BufferRecycler;->mMediumCBuffer:[C

    .line 53
    .local v0, "result":[C
    const/4 v1, 0x0

    if-eqz v0, :cond_0

    array-length v2, v0

    if-lt v2, p1, :cond_0

    .line 54
    iput-object v1, p0, Lcom/fasterxml/aalto/util/BufferRecycler;->mMediumCBuffer:[C
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 55
    monitor-exit p0

    return-object v0

    .line 57
    .end local p0    # "this":Lcom/fasterxml/aalto/util/BufferRecycler;
    :cond_0
    monitor-exit p0

    return-object v1

    .line 51
    .end local v0    # "result":[C
    .end local p1    # "minSize":I
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized getSmallCBuffer(I)[C
    .locals 3
    .param p1, "minSize"    # I

    monitor-enter p0

    .line 35
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/util/BufferRecycler;->mSmallCBuffer:[C

    .line 36
    .local v0, "result":[C
    const/4 v1, 0x0

    if-eqz v0, :cond_0

    array-length v2, v0

    if-lt v2, p1, :cond_0

    .line 37
    iput-object v1, p0, Lcom/fasterxml/aalto/util/BufferRecycler;->mSmallCBuffer:[C
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 38
    monitor-exit p0

    return-object v0

    .line 40
    .end local p0    # "this":Lcom/fasterxml/aalto/util/BufferRecycler;
    :cond_0
    monitor-exit p0

    return-object v1

    .line 34
    .end local v0    # "result":[C
    .end local p1    # "minSize":I
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized returnFullBBuffer([B)V
    .locals 0
    .param p1, "buffer"    # [B

    monitor-enter p0

    .line 98
    :try_start_0
    iput-object p1, p0, Lcom/fasterxml/aalto/util/BufferRecycler;->mFullBBuffer:[B
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 99
    monitor-exit p0

    return-void

    .line 97
    .end local p0    # "this":Lcom/fasterxml/aalto/util/BufferRecycler;
    .end local p1    # "buffer":[B
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized returnFullCBuffer([C)V
    .locals 0
    .param p1, "buffer"    # [C

    monitor-enter p0

    .line 79
    :try_start_0
    iput-object p1, p0, Lcom/fasterxml/aalto/util/BufferRecycler;->mFullCBuffer:[C
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 80
    monitor-exit p0

    return-void

    .line 78
    .end local p0    # "this":Lcom/fasterxml/aalto/util/BufferRecycler;
    .end local p1    # "buffer":[C
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized returnMediumCBuffer([C)V
    .locals 0
    .param p1, "buffer"    # [C

    monitor-enter p0

    .line 62
    :try_start_0
    iput-object p1, p0, Lcom/fasterxml/aalto/util/BufferRecycler;->mMediumCBuffer:[C
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 63
    monitor-exit p0

    return-void

    .line 61
    .end local p0    # "this":Lcom/fasterxml/aalto/util/BufferRecycler;
    .end local p1    # "buffer":[C
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized returnSmallCBuffer([C)V
    .locals 0
    .param p1, "buffer"    # [C

    monitor-enter p0

    .line 45
    :try_start_0
    iput-object p1, p0, Lcom/fasterxml/aalto/util/BufferRecycler;->mSmallCBuffer:[C
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 46
    monitor-exit p0

    return-void

    .line 44
    .end local p0    # "this":Lcom/fasterxml/aalto/util/BufferRecycler;
    .end local p1    # "buffer":[C
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method
