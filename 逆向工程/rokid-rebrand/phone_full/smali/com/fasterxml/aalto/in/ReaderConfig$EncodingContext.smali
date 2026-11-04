.class final Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;
.super Ljava/lang/Object;
.source "ReaderConfig.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/fasterxml/aalto/in/ReaderConfig;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "EncodingContext"
.end annotation


# instance fields
.field mAsciiTable:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

.field mGeneralTable:Lcom/fasterxml/aalto/in/CharBasedPNameTable;

.field mLatin1Table:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

.field mUtf8Table:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;


# direct methods
.method constructor <init>()V
    .locals 0

    .line 759
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public declared-synchronized getAsciiSymbols()Lcom/fasterxml/aalto/in/ByteBasedPNameTable;
    .locals 2

    monitor-enter p0

    .line 789
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->mAsciiTable:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    if-nez v0, :cond_0

    .line 790
    new-instance v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    const/16 v1, 0x40

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;-><init>(I)V

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->mAsciiTable:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    .line 792
    .end local p0    # "this":Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;
    :cond_0
    new-instance v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->mAsciiTable:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;-><init>(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 788
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getLatin1Symbols()Lcom/fasterxml/aalto/in/ByteBasedPNameTable;
    .locals 2

    monitor-enter p0

    .line 776
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->mLatin1Table:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    if-nez v0, :cond_0

    .line 777
    new-instance v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    const/16 v1, 0x40

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;-><init>(I)V

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->mLatin1Table:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    .line 779
    .end local p0    # "this":Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;
    :cond_0
    new-instance v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->mLatin1Table:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;-><init>(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 775
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getSymbols()Lcom/fasterxml/aalto/in/CharBasedPNameTable;
    .locals 2

    monitor-enter p0

    .line 802
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->mGeneralTable:Lcom/fasterxml/aalto/in/CharBasedPNameTable;

    if-nez v0, :cond_0

    .line 803
    new-instance v0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;

    const/16 v1, 0x40

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/in/CharBasedPNameTable;-><init>(I)V

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->mGeneralTable:Lcom/fasterxml/aalto/in/CharBasedPNameTable;

    .line 805
    .end local p0    # "this":Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;
    :cond_0
    new-instance v0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;

    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->mGeneralTable:Lcom/fasterxml/aalto/in/CharBasedPNameTable;

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/in/CharBasedPNameTable;-><init>(Lcom/fasterxml/aalto/in/CharBasedPNameTable;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 801
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getUtf8Symbols()Lcom/fasterxml/aalto/in/ByteBasedPNameTable;
    .locals 2

    monitor-enter p0

    .line 763
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->mUtf8Table:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    if-nez v0, :cond_0

    .line 764
    new-instance v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    const/16 v1, 0x40

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;-><init>(I)V

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->mUtf8Table:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    .line 766
    .end local p0    # "this":Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;
    :cond_0
    new-instance v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    iget-object v1, p0, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->mUtf8Table:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;-><init>(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 762
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized updateAsciiSymbols(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;)V
    .locals 1
    .param p1, "sym"    # Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    monitor-enter p0

    .line 797
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->mAsciiTable:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mergeFromChild(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 798
    monitor-exit p0

    return-void

    .line 796
    .end local p0    # "this":Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;
    .end local p1    # "sym":Lcom/fasterxml/aalto/in/ByteBasedPNameTable;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized updateLatin1Symbols(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;)V
    .locals 1
    .param p1, "sym"    # Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    monitor-enter p0

    .line 784
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->mLatin1Table:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mergeFromChild(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 785
    monitor-exit p0

    return-void

    .line 783
    .end local p0    # "this":Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;
    .end local p1    # "sym":Lcom/fasterxml/aalto/in/ByteBasedPNameTable;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized updateSymbols(Lcom/fasterxml/aalto/in/CharBasedPNameTable;)V
    .locals 1
    .param p1, "sym"    # Lcom/fasterxml/aalto/in/CharBasedPNameTable;

    monitor-enter p0

    .line 810
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->mGeneralTable:Lcom/fasterxml/aalto/in/CharBasedPNameTable;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->mergeFromChild(Lcom/fasterxml/aalto/in/CharBasedPNameTable;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 811
    monitor-exit p0

    return-void

    .line 809
    .end local p0    # "this":Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;
    .end local p1    # "sym":Lcom/fasterxml/aalto/in/CharBasedPNameTable;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized updateUtf8Symbols(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;)V
    .locals 1
    .param p1, "sym"    # Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    monitor-enter p0

    .line 771
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->mUtf8Table:Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mergeFromChild(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 772
    monitor-exit p0

    return-void

    .line 770
    .end local p0    # "this":Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;
    .end local p1    # "sym":Lcom/fasterxml/aalto/in/ByteBasedPNameTable;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method
