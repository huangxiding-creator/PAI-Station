.class final Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;
.super Ljava/lang/Object;
.source "WriterConfig.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/fasterxml/aalto/out/WriterConfig;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "EncodingContext"
.end annotation


# instance fields
.field mAsciiTable:Lcom/fasterxml/aalto/out/WNameTable;

.field mCharTable:Lcom/fasterxml/aalto/out/WNameTable;

.field mLatin1Table:Lcom/fasterxml/aalto/out/WNameTable;

.field mUtf8Table:Lcom/fasterxml/aalto/out/WNameTable;


# direct methods
.method constructor <init>()V
    .locals 0

    .line 505
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public declared-synchronized getAsciiSymbols(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;
    .locals 2
    .param p1, "f"    # Lcom/fasterxml/aalto/out/WNameFactory;

    monitor-enter p0

    .line 525
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;->mAsciiTable:Lcom/fasterxml/aalto/out/WNameTable;

    if-nez v0, :cond_0

    .line 526
    new-instance v0, Lcom/fasterxml/aalto/out/WNameTable;

    const/16 v1, 0x40

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/out/WNameTable;-><init>(I)V

    iput-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;->mAsciiTable:Lcom/fasterxml/aalto/out/WNameTable;

    .line 528
    .end local p0    # "this":Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;->mAsciiTable:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/WNameTable;->createChild(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 524
    .end local p1    # "f":Lcom/fasterxml/aalto/out/WNameFactory;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized getCharSymbols(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;
    .locals 2
    .param p1, "f"    # Lcom/fasterxml/aalto/out/WNameFactory;

    monitor-enter p0

    .line 533
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;->mCharTable:Lcom/fasterxml/aalto/out/WNameTable;

    if-nez v0, :cond_0

    .line 534
    new-instance v0, Lcom/fasterxml/aalto/out/WNameTable;

    const/16 v1, 0x40

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/out/WNameTable;-><init>(I)V

    iput-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;->mCharTable:Lcom/fasterxml/aalto/out/WNameTable;

    .line 536
    .end local p0    # "this":Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;->mCharTable:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/WNameTable;->createChild(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 532
    .end local p1    # "f":Lcom/fasterxml/aalto/out/WNameFactory;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized getLatin1Symbols(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;
    .locals 2
    .param p1, "f"    # Lcom/fasterxml/aalto/out/WNameFactory;

    monitor-enter p0

    .line 517
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;->mLatin1Table:Lcom/fasterxml/aalto/out/WNameTable;

    if-nez v0, :cond_0

    .line 518
    new-instance v0, Lcom/fasterxml/aalto/out/WNameTable;

    const/16 v1, 0x40

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/out/WNameTable;-><init>(I)V

    iput-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;->mLatin1Table:Lcom/fasterxml/aalto/out/WNameTable;

    .line 520
    .end local p0    # "this":Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;->mLatin1Table:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/WNameTable;->createChild(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 516
    .end local p1    # "f":Lcom/fasterxml/aalto/out/WNameFactory;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized getUtf8Symbols(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;
    .locals 2
    .param p1, "f"    # Lcom/fasterxml/aalto/out/WNameFactory;

    monitor-enter p0

    .line 509
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;->mUtf8Table:Lcom/fasterxml/aalto/out/WNameTable;

    if-nez v0, :cond_0

    .line 510
    new-instance v0, Lcom/fasterxml/aalto/out/WNameTable;

    const/16 v1, 0x40

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/out/WNameTable;-><init>(I)V

    iput-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;->mUtf8Table:Lcom/fasterxml/aalto/out/WNameTable;

    .line 512
    .end local p0    # "this":Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;->mUtf8Table:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/WNameTable;->createChild(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 508
    .end local p1    # "f":Lcom/fasterxml/aalto/out/WNameFactory;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method
