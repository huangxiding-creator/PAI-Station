.class public final Lcom/fasterxml/aalto/out/WNameTable;
.super Lcom/fasterxml/aalto/util/NameTable;
.source "WNameTable.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    }
.end annotation


# static fields
.field static final INITIAL_COLLISION_LEN:I = 0x20

.field static final LAST_VALID_BUCKET:I = 0xfe

.field static final MIN_HASH_SIZE:I = 0x10


# instance fields
.field private mCollCount:I

.field private mCollEnd:I

.field private mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

.field private mCollListShared:Z

.field private mCount:I

.field private mMainHash:[I

.field private mMainHashMask:I

.field private mMainHashShared:Z

.field private mMainNames:[Lcom/fasterxml/aalto/out/WName;

.field private mMainNamesShared:Z

.field final mNameFactory:Lcom/fasterxml/aalto/out/WNameFactory;

.field private transient mNeedRehash:Z

.field final mParent:Lcom/fasterxml/aalto/out/WNameTable;


# direct methods
.method protected constructor <init>(I)V
    .locals 3
    .param p1, "hashSize"    # I

    .line 161
    invoke-direct {p0}, Lcom/fasterxml/aalto/util/NameTable;-><init>()V

    .line 162
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mNameFactory:Lcom/fasterxml/aalto/out/WNameFactory;

    .line 163
    iput-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mParent:Lcom/fasterxml/aalto/out/WNameTable;

    .line 168
    const/16 v1, 0x10

    if-ge p1, v1, :cond_0

    .line 169
    const/16 p1, 0x10

    goto :goto_1

    .line 174
    :cond_0
    add-int/lit8 v1, p1, -0x1

    and-int/2addr v1, p1

    if-eqz v1, :cond_2

    .line 175
    const/16 v1, 0x10

    .line 176
    .local v1, "curr":I
    :goto_0
    if-ge v1, p1, :cond_1

    .line 177
    add-int/2addr v1, v1

    goto :goto_0

    .line 180
    :cond_1
    move p1, v1

    .line 184
    .end local v1    # "curr":I
    :cond_2
    :goto_1
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCount:I

    .line 185
    iput-boolean v1, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHashShared:Z

    .line 186
    iput-boolean v1, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNamesShared:Z

    .line 187
    add-int/lit8 v2, p1, -0x1

    iput v2, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHashMask:I

    .line 188
    new-array v2, p1, [I

    iput-object v2, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    .line 189
    new-array v2, p1, [Lcom/fasterxml/aalto/out/WName;

    iput-object v2, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNames:[Lcom/fasterxml/aalto/out/WName;

    .line 191
    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollListShared:Z

    .line 192
    iput-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    .line 193
    iput v1, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollEnd:I

    .line 195
    iput-boolean v1, p0, Lcom/fasterxml/aalto/out/WNameTable;->mNeedRehash:Z

    .line 196
    return-void
.end method

.method private constructor <init>(Lcom/fasterxml/aalto/out/WNameTable;Lcom/fasterxml/aalto/out/WNameFactory;)V
    .locals 1
    .param p1, "parent"    # Lcom/fasterxml/aalto/out/WNameTable;
    .param p2, "f"    # Lcom/fasterxml/aalto/out/WNameFactory;

    .line 202
    invoke-direct {p0}, Lcom/fasterxml/aalto/util/NameTable;-><init>()V

    .line 203
    iput-object p1, p0, Lcom/fasterxml/aalto/out/WNameTable;->mParent:Lcom/fasterxml/aalto/out/WNameTable;

    .line 204
    iput-object p2, p0, Lcom/fasterxml/aalto/out/WNameTable;->mNameFactory:Lcom/fasterxml/aalto/out/WNameFactory;

    .line 207
    iget v0, p1, Lcom/fasterxml/aalto/out/WNameTable;->mCount:I

    iput v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCount:I

    .line 208
    iget v0, p1, Lcom/fasterxml/aalto/out/WNameTable;->mMainHashMask:I

    iput v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHashMask:I

    .line 209
    iget-object v0, p1, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    iput-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    .line 210
    iget-object v0, p1, Lcom/fasterxml/aalto/out/WNameTable;->mMainNames:[Lcom/fasterxml/aalto/out/WName;

    iput-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNames:[Lcom/fasterxml/aalto/out/WName;

    .line 211
    iget-object v0, p1, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    iput-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    .line 212
    iget v0, p1, Lcom/fasterxml/aalto/out/WNameTable;->mCollCount:I

    iput v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollCount:I

    .line 213
    iget v0, p1, Lcom/fasterxml/aalto/out/WNameTable;->mCollEnd:I

    iput v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollEnd:I

    .line 214
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mNeedRehash:Z

    .line 217
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHashShared:Z

    .line 218
    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNamesShared:Z

    .line 219
    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollListShared:Z

    .line 220
    return-void
.end method

.method private addSymbol(Lcom/fasterxml/aalto/out/WName;)V
    .locals 8
    .param p1, "symbol"    # Lcom/fasterxml/aalto/out/WName;

    .line 462
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHashShared:Z

    if-eqz v0, :cond_0

    .line 463
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/WNameTable;->unshareMain()V

    .line 466
    :cond_0
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mNeedRehash:Z

    if-eqz v0, :cond_1

    .line 467
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/WNameTable;->rehash()V

    .line 469
    :cond_1
    invoke-virtual {p1}, Lcom/fasterxml/aalto/out/WName;->hashCode()I

    move-result v0

    .line 471
    .local v0, "hash":I
    iget v1, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCount:I

    const/4 v2, 0x1

    add-int/2addr v1, v2

    iput v1, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCount:I

    .line 475
    iget v1, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHashMask:I

    and-int/2addr v1, v0

    .line 476
    .local v1, "ix":I
    iget-object v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNames:[Lcom/fasterxml/aalto/out/WName;

    aget-object v3, v3, v1

    if-nez v3, :cond_3

    .line 477
    iget-object v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    shl-int/lit8 v4, v0, 0x8

    aput v4, v3, v1

    .line 478
    iget-boolean v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNamesShared:Z

    if-eqz v3, :cond_2

    .line 479
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/WNameTable;->unshareNames()V

    .line 481
    :cond_2
    iget-object v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNames:[Lcom/fasterxml/aalto/out/WName;

    aput-object p1, v3, v1

    goto :goto_2

    .line 486
    :cond_3
    iget-boolean v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollListShared:Z

    if-eqz v3, :cond_4

    .line 487
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/WNameTable;->unshareCollision()V

    .line 489
    :cond_4
    iget v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollCount:I

    add-int/2addr v3, v2

    iput v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollCount:I

    .line 490
    iget-object v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    aget v3, v3, v1

    .line 491
    .local v3, "entryValue":I
    and-int/lit16 v4, v3, 0xff

    .line 492
    .local v4, "bucket":I
    if-nez v4, :cond_7

    .line 493
    iget v5, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollEnd:I

    const/16 v6, 0xfe

    if-gt v5, v6, :cond_5

    .line 494
    iget v4, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollEnd:I

    .line 495
    iget v5, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollEnd:I

    add-int/2addr v5, v2

    iput v5, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollEnd:I

    .line 497
    iget-object v5, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    array-length v5, v5

    if-lt v4, v5, :cond_6

    .line 498
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/WNameTable;->expandCollision()V

    goto :goto_0

    .line 501
    :cond_5
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/WNameTable;->findBestBucket()I

    move-result v4

    .line 504
    :cond_6
    :goto_0
    iget-object v5, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    and-int/lit16 v6, v3, -0x100

    add-int/lit8 v7, v4, 0x1

    or-int/2addr v6, v7

    aput v6, v5, v1

    goto :goto_1

    .line 506
    :cond_7
    add-int/lit8 v4, v4, -0x1

    .line 510
    :goto_1
    iget-object v5, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    new-instance v6, Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    iget-object v7, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    aget-object v7, v7, v4

    invoke-direct {v6, p1, v7}, Lcom/fasterxml/aalto/out/WNameTable$Bucket;-><init>(Lcom/fasterxml/aalto/out/WName;Lcom/fasterxml/aalto/out/WNameTable$Bucket;)V

    aput-object v6, v5, v4

    .line 517
    .end local v3    # "entryValue":I
    .end local v4    # "bucket":I
    :goto_2
    iget-object v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    array-length v3, v3

    .line 518
    .local v3, "hashSize":I
    iget v4, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCount:I

    shr-int/lit8 v5, v3, 0x1

    if-le v4, v5, :cond_9

    .line 519
    shr-int/lit8 v4, v3, 0x2

    .line 523
    .local v4, "hashQuarter":I
    iget v5, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCount:I

    sub-int v6, v3, v4

    if-le v5, v6, :cond_8

    .line 524
    iput-boolean v2, p0, Lcom/fasterxml/aalto/out/WNameTable;->mNeedRehash:Z

    goto :goto_3

    .line 525
    :cond_8
    iget v5, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollCount:I

    if-lt v5, v4, :cond_9

    .line 526
    iput-boolean v2, p0, Lcom/fasterxml/aalto/out/WNameTable;->mNeedRehash:Z

    .line 530
    .end local v3    # "hashSize":I
    .end local v4    # "hashQuarter":I
    :cond_9
    :goto_3
    return-void
.end method

.method private expandCollision()V
    .locals 4

    .line 679
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    .line 680
    .local v0, "old":[Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    array-length v1, v0

    .line 681
    .local v1, "len":I
    add-int v2, v1, v1

    new-array v2, v2, [Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    iput-object v2, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    .line 682
    const/4 v2, 0x0

    iget-object v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    invoke-static {v0, v2, v3, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 683
    return-void
.end method

.method private findBestBucket()I
    .locals 7

    .line 622
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    .line 623
    .local v0, "buckets":[Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    const v1, 0x7fffffff

    .line 624
    .local v1, "bestCount":I
    const/4 v2, -0x1

    .line 626
    .local v2, "bestIx":I
    const/4 v3, 0x0

    .local v3, "i":I
    iget v4, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollEnd:I

    .local v4, "len":I
    :goto_0
    if-ge v3, v4, :cond_2

    .line 627
    aget-object v5, v0, v3

    invoke-virtual {v5}, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->length()I

    move-result v5

    .line 628
    .local v5, "count":I
    if-ge v5, v1, :cond_1

    .line 629
    const/4 v6, 0x1

    if-ne v5, v6, :cond_0

    .line 630
    return v3

    .line 632
    :cond_0
    move v1, v5

    .line 633
    move v2, v3

    .line 626
    .end local v5    # "count":I
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 636
    .end local v3    # "i":I
    .end local v4    # "len":I
    :cond_2
    return v2
.end method

.method private declared-synchronized mergeFromChild(Lcom/fasterxml/aalto/out/WNameTable;)Z
    .locals 2
    .param p1, "child"    # Lcom/fasterxml/aalto/out/WNameTable;

    monitor-enter p0

    .line 240
    :try_start_0
    iget v0, p1, Lcom/fasterxml/aalto/out/WNameTable;->mCount:I

    iget v1, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCount:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-gt v0, v1, :cond_0

    .line 241
    monitor-exit p0

    const/4 v0, 0x0

    return v0

    .line 245
    :cond_0
    :try_start_1
    iget v0, p1, Lcom/fasterxml/aalto/out/WNameTable;->mCount:I

    iput v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCount:I

    .line 246
    iget v0, p1, Lcom/fasterxml/aalto/out/WNameTable;->mMainHashMask:I

    iput v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHashMask:I

    .line 247
    iget-object v0, p1, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    iput-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    .line 248
    iget-object v0, p1, Lcom/fasterxml/aalto/out/WNameTable;->mMainNames:[Lcom/fasterxml/aalto/out/WName;

    iput-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNames:[Lcom/fasterxml/aalto/out/WName;

    .line 249
    iget-object v0, p1, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    iput-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    .line 250
    iget v0, p1, Lcom/fasterxml/aalto/out/WNameTable;->mCollCount:I

    iput v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollCount:I

    .line 251
    iget v0, p1, Lcom/fasterxml/aalto/out/WNameTable;->mCollEnd:I

    iput v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollEnd:I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 252
    monitor-exit p0

    const/4 v0, 0x1

    return v0

    .line 239
    .end local p0    # "this":Lcom/fasterxml/aalto/out/WNameTable;
    .end local p1    # "child":Lcom/fasterxml/aalto/out/WNameTable;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method private rehash()V
    .locals 17

    .line 534
    move-object/from16 v0, p0

    const/4 v1, 0x0

    iput-boolean v1, v0, Lcom/fasterxml/aalto/out/WNameTable;->mNeedRehash:Z

    .line 536
    iput-boolean v1, v0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNamesShared:Z

    .line 542
    const/4 v2, 0x0

    .line 543
    .local v2, "symbolsSeen":I
    iget-object v3, v0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    .line 544
    .local v3, "oldMainHash":[I
    array-length v4, v3

    .line 545
    .local v4, "len":I
    add-int v5, v4, v4

    new-array v5, v5, [I

    iput-object v5, v0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    .line 546
    add-int v5, v4, v4

    add-int/lit8 v5, v5, -0x1

    iput v5, v0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHashMask:I

    .line 547
    iget-object v5, v0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNames:[Lcom/fasterxml/aalto/out/WName;

    .line 548
    .local v5, "oldNames":[Lcom/fasterxml/aalto/out/WName;
    add-int v6, v4, v4

    new-array v6, v6, [Lcom/fasterxml/aalto/out/WName;

    iput-object v6, v0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNames:[Lcom/fasterxml/aalto/out/WName;

    .line 549
    const/4 v6, 0x0

    .local v6, "i":I
    :goto_0
    if-ge v6, v4, :cond_1

    .line 550
    aget-object v7, v5, v6

    .line 551
    .local v7, "symbol":Lcom/fasterxml/aalto/out/WName;
    if-eqz v7, :cond_0

    .line 552
    add-int/lit8 v2, v2, 0x1

    .line 553
    invoke-virtual {v7}, Lcom/fasterxml/aalto/out/WName;->hashCode()I

    move-result v8

    .line 554
    .local v8, "hash":I
    iget v9, v0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHashMask:I

    and-int/2addr v9, v8

    .line 555
    .local v9, "ix":I
    iget-object v10, v0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNames:[Lcom/fasterxml/aalto/out/WName;

    aput-object v7, v10, v9

    .line 556
    iget-object v10, v0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    shl-int/lit8 v11, v8, 0x8

    aput v11, v10, v9

    .line 549
    .end local v7    # "symbol":Lcom/fasterxml/aalto/out/WName;
    .end local v8    # "hash":I
    .end local v9    # "ix":I
    :cond_0
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 564
    .end local v6    # "i":I
    :cond_1
    iget v6, v0, Lcom/fasterxml/aalto/out/WNameTable;->mCollEnd:I

    .line 565
    .local v6, "oldEnd":I
    if-nez v6, :cond_2

    .line 566
    return-void

    .line 569
    :cond_2
    iput v1, v0, Lcom/fasterxml/aalto/out/WNameTable;->mCollCount:I

    .line 570
    iput v1, v0, Lcom/fasterxml/aalto/out/WNameTable;->mCollEnd:I

    .line 571
    iput-boolean v1, v0, Lcom/fasterxml/aalto/out/WNameTable;->mCollListShared:Z

    .line 573
    iget-object v1, v0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    .line 574
    .local v1, "oldBuckets":[Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    array-length v7, v1

    new-array v7, v7, [Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    iput-object v7, v0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    .line 575
    const/4 v7, 0x0

    .local v7, "i":I
    :goto_1
    if-ge v7, v6, :cond_8

    .line 576
    aget-object v8, v1, v7

    .local v8, "curr":Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    :goto_2
    if-eqz v8, :cond_7

    .line 577
    add-int/lit8 v2, v2, 0x1

    .line 578
    iget-object v9, v8, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->mName:Lcom/fasterxml/aalto/out/WName;

    .line 579
    .local v9, "symbol":Lcom/fasterxml/aalto/out/WName;
    invoke-virtual {v9}, Lcom/fasterxml/aalto/out/WName;->hashCode()I

    move-result v10

    .line 580
    .local v10, "hash":I
    iget v11, v0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHashMask:I

    and-int/2addr v11, v10

    .line 581
    .local v11, "ix":I
    iget-object v12, v0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    aget v12, v12, v11

    .line 582
    .local v12, "val":I
    iget-object v13, v0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNames:[Lcom/fasterxml/aalto/out/WName;

    aget-object v13, v13, v11

    if-nez v13, :cond_3

    .line 583
    iget-object v13, v0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    shl-int/lit8 v14, v10, 0x8

    aput v14, v13, v11

    .line 584
    iget-object v13, v0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNames:[Lcom/fasterxml/aalto/out/WName;

    aput-object v9, v13, v11

    move-object/from16 v16, v1

    goto :goto_5

    .line 586
    :cond_3
    iget v13, v0, Lcom/fasterxml/aalto/out/WNameTable;->mCollCount:I

    add-int/lit8 v13, v13, 0x1

    iput v13, v0, Lcom/fasterxml/aalto/out/WNameTable;->mCollCount:I

    .line 587
    and-int/lit16 v13, v12, 0xff

    .line 588
    .local v13, "bucket":I
    if-nez v13, :cond_6

    .line 589
    iget v14, v0, Lcom/fasterxml/aalto/out/WNameTable;->mCollEnd:I

    const/16 v15, 0xfe

    if-gt v14, v15, :cond_4

    .line 590
    iget v13, v0, Lcom/fasterxml/aalto/out/WNameTable;->mCollEnd:I

    .line 591
    iget v14, v0, Lcom/fasterxml/aalto/out/WNameTable;->mCollEnd:I

    add-int/lit8 v14, v14, 0x1

    iput v14, v0, Lcom/fasterxml/aalto/out/WNameTable;->mCollEnd:I

    .line 593
    iget-object v14, v0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    array-length v14, v14

    if-lt v13, v14, :cond_5

    .line 594
    invoke-direct/range {p0 .. p0}, Lcom/fasterxml/aalto/out/WNameTable;->expandCollision()V

    goto :goto_3

    .line 597
    :cond_4
    invoke-direct/range {p0 .. p0}, Lcom/fasterxml/aalto/out/WNameTable;->findBestBucket()I

    move-result v13

    .line 600
    :cond_5
    :goto_3
    iget-object v14, v0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    and-int/lit16 v15, v12, -0x100

    add-int/lit8 v16, v13, 0x1

    or-int v15, v15, v16

    aput v15, v14, v11

    goto :goto_4

    .line 602
    :cond_6
    add-int/lit8 v13, v13, -0x1

    .line 605
    :goto_4
    iget-object v14, v0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    new-instance v15, Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    move-object/from16 v16, v1

    .end local v1    # "oldBuckets":[Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    .local v16, "oldBuckets":[Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    iget-object v1, v0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    aget-object v1, v1, v13

    invoke-direct {v15, v9, v1}, Lcom/fasterxml/aalto/out/WNameTable$Bucket;-><init>(Lcom/fasterxml/aalto/out/WName;Lcom/fasterxml/aalto/out/WNameTable$Bucket;)V

    aput-object v15, v14, v13

    .line 576
    .end local v9    # "symbol":Lcom/fasterxml/aalto/out/WName;
    .end local v10    # "hash":I
    .end local v11    # "ix":I
    .end local v12    # "val":I
    .end local v13    # "bucket":I
    :goto_5
    iget-object v8, v8, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->mNext:Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    move-object/from16 v1, v16

    goto :goto_2

    .end local v16    # "oldBuckets":[Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    .restart local v1    # "oldBuckets":[Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    :cond_7
    move-object/from16 v16, v1

    .line 575
    .end local v1    # "oldBuckets":[Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    .end local v8    # "curr":Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    .restart local v16    # "oldBuckets":[Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    add-int/lit8 v7, v7, 0x1

    goto :goto_1

    .end local v16    # "oldBuckets":[Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    .restart local v1    # "oldBuckets":[Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    :cond_8
    move-object/from16 v16, v1

    .line 610
    .end local v1    # "oldBuckets":[Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    .end local v7    # "i":I
    .restart local v16    # "oldBuckets":[Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    iget v1, v0, Lcom/fasterxml/aalto/out/WNameTable;->mCount:I

    if-ne v2, v1, :cond_9

    .line 613
    return-void

    .line 611
    :cond_9
    new-instance v1, Ljava/lang/Error;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Internal error: count after rehash "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "; should be "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget v8, v0, Lcom/fasterxml/aalto/out/WNameTable;->mCount:I

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v1, v7}, Ljava/lang/Error;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method private unshareCollision()V
    .locals 4

    .line 657
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    .line 658
    .local v0, "old":[Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 659
    const/16 v2, 0x20

    new-array v2, v2, [Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    iput-object v2, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    goto :goto_0

    .line 661
    :cond_0
    array-length v2, v0

    .line 662
    .local v2, "len":I
    new-array v3, v2, [Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    iput-object v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    .line 663
    iget-object v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    invoke-static {v0, v1, v3, v1, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 665
    .end local v2    # "len":I
    :goto_0
    iput-boolean v1, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollListShared:Z

    .line 666
    return-void
.end method

.method private unshareMain()V
    .locals 4

    .line 647
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    .line 648
    .local v0, "old":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    array-length v1, v1

    .line 650
    .local v1, "len":I
    new-array v2, v1, [I

    iput-object v2, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    .line 651
    iget-object v2, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 652
    iput-boolean v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHashShared:Z

    .line 653
    return-void
.end method

.method private unshareNames()V
    .locals 4

    .line 670
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNames:[Lcom/fasterxml/aalto/out/WName;

    .line 671
    .local v0, "old":[Lcom/fasterxml/aalto/out/WName;
    array-length v1, v0

    .line 672
    .local v1, "len":I
    new-array v2, v1, [Lcom/fasterxml/aalto/out/WName;

    iput-object v2, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNames:[Lcom/fasterxml/aalto/out/WName;

    .line 673
    iget-object v2, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNames:[Lcom/fasterxml/aalto/out/WName;

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 674
    iput-boolean v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNamesShared:Z

    .line 675
    return-void
.end method


# virtual methods
.method protected declared-synchronized createChild(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;
    .locals 1
    .param p1, "f"    # Lcom/fasterxml/aalto/out/WNameFactory;

    monitor-enter p0

    .line 224
    :try_start_0
    new-instance v0, Lcom/fasterxml/aalto/out/WNameTable;

    invoke-direct {v0, p0, p1}, Lcom/fasterxml/aalto/out/WNameTable;-><init>(Lcom/fasterxml/aalto/out/WNameTable;Lcom/fasterxml/aalto/out/WNameFactory;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    .line 224
    .end local p0    # "this":Lcom/fasterxml/aalto/out/WNameTable;
    .end local p1    # "f":Lcom/fasterxml/aalto/out/WNameFactory;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public findSymbol(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;
    .locals 5
    .param p1, "localName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 293
    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v0

    .line 294
    .local v0, "hash":I
    iget v1, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHashMask:I

    and-int/2addr v1, v0

    .line 295
    .local v1, "ix":I
    iget-object v2, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    aget v2, v2, v1

    .line 300
    .local v2, "val":I
    shr-int/lit8 v3, v2, 0x8

    xor-int/2addr v3, v0

    shl-int/lit8 v3, v3, 0x8

    if-nez v3, :cond_0

    .line 302
    iget-object v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNames:[Lcom/fasterxml/aalto/out/WName;

    aget-object v3, v3, v1

    .line 303
    .local v3, "wname":Lcom/fasterxml/aalto/out/WName;
    if-eqz v3, :cond_0

    .line 304
    invoke-virtual {v3, p1}, Lcom/fasterxml/aalto/out/WName;->hasName(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 305
    return-object v3

    .line 309
    .end local v3    # "wname":Lcom/fasterxml/aalto/out/WName;
    :cond_0
    if-eqz v2, :cond_1

    .line 311
    and-int/lit16 v2, v2, 0xff

    .line 312
    if-lez v2, :cond_1

    .line 313
    add-int/lit8 v2, v2, -0x1

    .line 314
    iget-object v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    aget-object v3, v3, v2

    .line 315
    .local v3, "bucket":Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    if-eqz v3, :cond_1

    .line 316
    invoke-virtual {v3, p1}, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->find(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v4

    .line 317
    .local v4, "name":Lcom/fasterxml/aalto/out/WName;
    if-eqz v4, :cond_1

    .line 318
    return-object v4

    .line 324
    .end local v3    # "bucket":Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    .end local v4    # "name":Lcom/fasterxml/aalto/out/WName;
    :cond_1
    iget-object v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mNameFactory:Lcom/fasterxml/aalto/out/WNameFactory;

    invoke-virtual {v3, p1}, Lcom/fasterxml/aalto/out/WNameFactory;->constructName(Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v3

    .line 325
    .local v3, "name":Lcom/fasterxml/aalto/out/WName;
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/out/WNameTable;->addSymbol(Lcom/fasterxml/aalto/out/WName;)V

    .line 326
    return-object v3
.end method

.method public findSymbol(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;
    .locals 5
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 337
    invoke-virtual {p2}, Ljava/lang/String;->hashCode()I

    move-result v0

    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v1

    xor-int/2addr v0, v1

    .line 338
    .local v0, "hash":I
    iget v1, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHashMask:I

    and-int/2addr v1, v0

    .line 339
    .local v1, "ix":I
    iget-object v2, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    aget v2, v2, v1

    .line 344
    .local v2, "val":I
    shr-int/lit8 v3, v2, 0x8

    xor-int/2addr v3, v0

    shl-int/lit8 v3, v3, 0x8

    if-nez v3, :cond_0

    .line 346
    iget-object v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNames:[Lcom/fasterxml/aalto/out/WName;

    aget-object v3, v3, v1

    .line 347
    .local v3, "wname":Lcom/fasterxml/aalto/out/WName;
    if-eqz v3, :cond_0

    .line 348
    invoke-virtual {v3, p1, p2}, Lcom/fasterxml/aalto/out/WName;->hasName(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 349
    return-object v3

    .line 353
    .end local v3    # "wname":Lcom/fasterxml/aalto/out/WName;
    :cond_0
    if-eqz v2, :cond_1

    .line 355
    and-int/lit16 v2, v2, 0xff

    .line 356
    if-lez v2, :cond_1

    .line 357
    add-int/lit8 v2, v2, -0x1

    .line 358
    iget-object v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    aget-object v3, v3, v2

    .line 359
    .local v3, "bucket":Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    if-eqz v3, :cond_1

    .line 360
    invoke-virtual {v3, p1, p2}, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->find(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v4

    .line 361
    .local v4, "name":Lcom/fasterxml/aalto/out/WName;
    if-eqz v4, :cond_1

    .line 362
    return-object v4

    .line 368
    .end local v3    # "bucket":Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    .end local v4    # "name":Lcom/fasterxml/aalto/out/WName;
    :cond_1
    iget-object v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mNameFactory:Lcom/fasterxml/aalto/out/WNameFactory;

    invoke-virtual {v3, p1, p2}, Lcom/fasterxml/aalto/out/WNameFactory;->constructName(Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/out/WName;

    move-result-object v3

    .line 369
    .local v3, "name":Lcom/fasterxml/aalto/out/WName;
    invoke-direct {p0, v3}, Lcom/fasterxml/aalto/out/WNameTable;->addSymbol(Lcom/fasterxml/aalto/out/WName;)V

    .line 370
    return-object v3
.end method

.method public markAsShared()V
    .locals 1

    .line 257
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHashShared:Z

    .line 258
    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNamesShared:Z

    .line 259
    iput-boolean v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollListShared:Z

    .line 260
    return-void
.end method

.method public maybeDirty()Z
    .locals 1

    .line 287
    iget-boolean v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHashShared:Z

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public mergeToParent()Z
    .locals 1

    .line 229
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mParent:Lcom/fasterxml/aalto/out/WNameTable;

    invoke-direct {v0, p0}, Lcom/fasterxml/aalto/out/WNameTable;->mergeFromChild(Lcom/fasterxml/aalto/out/WNameTable;)Z

    move-result v0

    .line 233
    .local v0, "changed":Z
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/WNameTable;->markAsShared()V

    .line 234
    return v0
.end method

.method public nuke()V
    .locals 1

    .line 266
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    .line 267
    iput-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNames:[Lcom/fasterxml/aalto/out/WName;

    .line 268
    iput-object v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    .line 269
    return-void
.end method

.method public size()I
    .locals 1

    .line 278
    iget v0, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCount:I

    return v0
.end method

.method public toDebugString()Ljava/lang/String;
    .locals 5

    .line 420
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 421
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string v1, "[WNameTable, size: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 422
    iget v1, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCount:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 423
    const/16 v1, 0x2f

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 424
    iget-object v1, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    array-length v1, v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 425
    const-string v1, " -> "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 426
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    iget-object v2, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    array-length v2, v2

    if-ge v1, v2, :cond_1

    .line 427
    const-string v2, "\n#"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 428
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 429
    const-string v2, ": 0x"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 430
    iget-object v2, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    aget v2, v2, v1

    invoke-static {v2}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 431
    const-string v2, " == "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 432
    iget-object v2, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainNames:[Lcom/fasterxml/aalto/out/WName;

    aget-object v2, v2, v1

    .line 433
    .local v2, "name":Lcom/fasterxml/aalto/out/WName;
    if-nez v2, :cond_0

    .line 434
    const-string v3, "null"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 436
    :cond_0
    const/16 v3, 0x22

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 437
    invoke-virtual {v2}, Lcom/fasterxml/aalto/out/WName;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 438
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 426
    .end local v2    # "name":Lcom/fasterxml/aalto/out/WName;
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 441
    .end local v1    # "i":I
    :cond_1
    const-string v1, "\nSpill("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 442
    iget v1, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollEnd:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 443
    const-string v1, "):"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 444
    const/4 v1, 0x0

    .restart local v1    # "i":I
    :goto_2
    iget v2, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollEnd:I

    if-ge v1, v2, :cond_2

    .line 445
    iget-object v2, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    aget-object v2, v2, v1

    .line 446
    .local v2, "bucket":Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    const-string v3, "\nsp#"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 447
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 448
    const-string v3, ": "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 449
    invoke-virtual {v2}, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->toDebugString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 444
    .end local v2    # "bucket":Lcom/fasterxml/aalto/out/WNameTable$Bucket;
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 451
    .end local v1    # "i":I
    :cond_2
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public toString()Ljava/lang/String;
    .locals 6

    .line 382
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 383
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string v1, "[WNameTable, size: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 384
    iget v1, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCount:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 385
    const/16 v1, 0x2f

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 386
    iget-object v1, p0, Lcom/fasterxml/aalto/out/WNameTable;->mMainHash:[I

    array-length v1, v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 387
    const-string v1, ", "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 388
    iget v1, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollCount:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 389
    const-string v1, " coll; avg length: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 395
    iget v1, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCount:I

    .line 396
    .local v1, "pathCount":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    iget v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollEnd:I

    if-ge v2, v3, :cond_1

    .line 397
    iget-object v3, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCollList:[Lcom/fasterxml/aalto/out/WNameTable$Bucket;

    aget-object v3, v3, v2

    invoke-virtual {v3}, Lcom/fasterxml/aalto/out/WNameTable$Bucket;->length()I

    move-result v3

    .line 398
    .local v3, "spillLen":I
    const/4 v4, 0x1

    .local v4, "j":I
    :goto_1
    if-gt v4, v3, :cond_0

    .line 399
    add-int/2addr v1, v4

    .line 398
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 396
    .end local v3    # "spillLen":I
    .end local v4    # "j":I
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 404
    .end local v2    # "i":I
    :cond_1
    iget v2, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCount:I

    if-nez v2, :cond_2

    .line 405
    const-wide/16 v2, 0x0

    .local v2, "avgLength":D
    goto :goto_2

    .line 407
    .end local v2    # "avgLength":D
    :cond_2
    int-to-double v2, v1

    iget v4, p0, Lcom/fasterxml/aalto/out/WNameTable;->mCount:I

    int-to-double v4, v4

    div-double/2addr v2, v4

    .line 412
    .restart local v2    # "avgLength":D
    :goto_2
    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    .line 413
    const/16 v4, 0x5d

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 414
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    return-object v4
.end method
