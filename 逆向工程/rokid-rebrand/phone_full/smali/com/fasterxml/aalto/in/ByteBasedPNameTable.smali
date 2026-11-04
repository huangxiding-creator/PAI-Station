.class public final Lcom/fasterxml/aalto/in/ByteBasedPNameTable;
.super Lcom/fasterxml/aalto/util/NameTable;
.source "ByteBasedPNameTable.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    }
.end annotation


# static fields
.field static final INITIAL_COLLISION_LEN:I = 0x20

.field static final LAST_VALID_BUCKET:I = 0xfe

.field static final MIN_HASH_SIZE:I = 0x10


# instance fields
.field private mCollCount:I

.field private mCollEnd:I

.field private mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

.field private mCollListShared:Z

.field private mCount:I

.field private mMainHash:[I

.field private mMainHashMask:I

.field private mMainHashShared:Z

.field private mMainNames:[Lcom/fasterxml/aalto/in/ByteBasedPName;

.field private mMainNamesShared:Z

.field private transient mNeedRehash:Z


# direct methods
.method public constructor <init>(I)V
    .locals 2
    .param p1, "hashSize"    # I

    .line 145
    invoke-direct {p0}, Lcom/fasterxml/aalto/util/NameTable;-><init>()V

    .line 147
    const/16 v0, 0x10

    if-ge p1, v0, :cond_0

    .line 148
    const/16 p1, 0x10

    goto :goto_1

    .line 153
    :cond_0
    add-int/lit8 v0, p1, -0x1

    and-int/2addr v0, p1

    if-eqz v0, :cond_2

    .line 154
    const/16 v0, 0x10

    .line 155
    .local v0, "curr":I
    :goto_0
    if-ge v0, p1, :cond_1

    .line 156
    add-int/2addr v0, v0

    goto :goto_0

    .line 159
    :cond_1
    move p1, v0

    .line 163
    .end local v0    # "curr":I
    :cond_2
    :goto_1
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCount:I

    .line 164
    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHashShared:Z

    .line 165
    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNamesShared:Z

    .line 166
    add-int/lit8 v1, p1, -0x1

    iput v1, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHashMask:I

    .line 167
    new-array v1, p1, [I

    iput-object v1, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    .line 168
    new-array v1, p1, [Lcom/fasterxml/aalto/in/ByteBasedPName;

    iput-object v1, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNames:[Lcom/fasterxml/aalto/in/ByteBasedPName;

    .line 170
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollListShared:Z

    .line 171
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    .line 172
    iput v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollEnd:I

    .line 174
    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mNeedRehash:Z

    .line 175
    return-void
.end method

.method constructor <init>(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;)V
    .locals 1
    .param p1, "parent"    # Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    .line 181
    invoke-direct {p0}, Lcom/fasterxml/aalto/util/NameTable;-><init>()V

    .line 183
    iget v0, p1, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCount:I

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCount:I

    .line 184
    iget v0, p1, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHashMask:I

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHashMask:I

    .line 185
    iget-object v0, p1, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    .line 186
    iget-object v0, p1, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNames:[Lcom/fasterxml/aalto/in/ByteBasedPName;

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNames:[Lcom/fasterxml/aalto/in/ByteBasedPName;

    .line 187
    iget-object v0, p1, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    .line 188
    iget v0, p1, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollCount:I

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollCount:I

    .line 189
    iget v0, p1, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollEnd:I

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollEnd:I

    .line 190
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mNeedRehash:Z

    .line 193
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHashShared:Z

    .line 194
    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNamesShared:Z

    .line 195
    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollListShared:Z

    .line 196
    return-void
.end method

.method public static final calcHash(I)I
    .locals 2
    .param p0, "firstQuad"    # I

    .line 388
    mul-int/lit8 v0, p0, 0x1f

    .line 389
    .local v0, "hash":I
    ushr-int/lit8 v1, v0, 0x10

    xor-int/2addr v0, v1

    .line 390
    ushr-int/lit8 v1, v0, 0x8

    xor-int/2addr v0, v1

    .line 391
    return v0
.end method

.method public static final calcHash(II)I
    .locals 2
    .param p0, "firstQuad"    # I
    .param p1, "secondQuad"    # I

    .line 396
    mul-int/lit8 v0, p0, 0x1f

    add-int/2addr v0, p1

    .line 397
    .local v0, "hash":I
    ushr-int/lit8 v1, v0, 0x10

    xor-int/2addr v0, v1

    .line 398
    ushr-int/lit8 v1, v0, 0x8

    xor-int/2addr v0, v1

    .line 399
    return v0
.end method

.method public static final calcHash([II)I
    .locals 4
    .param p0, "quads"    # [I
    .param p1, "qlen"    # I

    .line 404
    const/4 v0, 0x0

    aget v0, p0, v0

    .line 405
    .local v0, "hash":I
    const/4 v1, 0x1

    .local v1, "i":I
    :goto_0
    if-ge v1, p1, :cond_0

    .line 406
    mul-int/lit8 v2, v0, 0x1f

    aget v3, p0, v1

    add-int v0, v2, v3

    .line 405
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 408
    .end local v1    # "i":I
    :cond_0
    ushr-int/lit8 v1, v0, 0x10

    xor-int/2addr v0, v1

    .line 409
    ushr-int/lit8 v1, v0, 0x8

    xor-int/2addr v0, v1

    .line 410
    return v0
.end method

.method public static calcQuads([B)[I
    .locals 6
    .param p0, "wordBytes"    # [B

    .line 415
    array-length v0, p0

    .line 416
    .local v0, "blen":I
    add-int/lit8 v1, v0, 0x3

    div-int/lit8 v1, v1, 0x4

    new-array v1, v1, [I

    .line 417
    .local v1, "result":[I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, v0, :cond_1

    .line 418
    aget-byte v3, p0, v2

    and-int/lit16 v3, v3, 0xff

    .line 420
    .local v3, "x":I
    add-int/lit8 v2, v2, 0x1

    if-ge v2, v0, :cond_0

    .line 421
    shl-int/lit8 v4, v3, 0x8

    aget-byte v5, p0, v2

    and-int/lit16 v5, v5, 0xff

    or-int v3, v4, v5

    .line 422
    add-int/lit8 v2, v2, 0x1

    if-ge v2, v0, :cond_0

    .line 423
    shl-int/lit8 v4, v3, 0x8

    aget-byte v5, p0, v2

    and-int/lit16 v5, v5, 0xff

    or-int v3, v4, v5

    .line 424
    add-int/lit8 v2, v2, 0x1

    if-ge v2, v0, :cond_0

    .line 425
    shl-int/lit8 v4, v3, 0x8

    aget-byte v5, p0, v2

    and-int/lit16 v5, v5, 0xff

    or-int v3, v4, v5

    .line 429
    :cond_0
    shr-int/lit8 v4, v2, 0x2

    aput v3, v1, v4

    .line 417
    .end local v3    # "x":I
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 431
    .end local v2    # "i":I
    :cond_1
    return-object v1
.end method

.method private doAddSymbol(ILcom/fasterxml/aalto/in/ByteBasedPName;)V
    .locals 7
    .param p1, "hash"    # I
    .param p2, "symbol"    # Lcom/fasterxml/aalto/in/ByteBasedPName;

    .line 525
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHashShared:Z

    if-eqz v0, :cond_0

    .line 526
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->unshareMain()V

    .line 529
    :cond_0
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mNeedRehash:Z

    if-eqz v0, :cond_1

    .line 530
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->rehash()V

    .line 533
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCount:I

    const/4 v1, 0x1

    add-int/2addr v0, v1

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCount:I

    .line 539
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHashMask:I

    and-int/2addr v0, p1

    .line 540
    .local v0, "ix":I
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNames:[Lcom/fasterxml/aalto/in/ByteBasedPName;

    aget-object v2, v2, v0

    if-nez v2, :cond_3

    .line 541
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    shl-int/lit8 v3, p1, 0x8

    aput v3, v2, v0

    .line 542
    iget-boolean v2, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNamesShared:Z

    if-eqz v2, :cond_2

    .line 543
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->unshareNames()V

    .line 545
    :cond_2
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNames:[Lcom/fasterxml/aalto/in/ByteBasedPName;

    aput-object p2, v2, v0

    goto :goto_2

    .line 550
    :cond_3
    iget-boolean v2, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollListShared:Z

    if-eqz v2, :cond_4

    .line 551
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->unshareCollision()V

    .line 553
    :cond_4
    iget v2, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollCount:I

    add-int/2addr v2, v1

    iput v2, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollCount:I

    .line 554
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    aget v2, v2, v0

    .line 555
    .local v2, "entryValue":I
    and-int/lit16 v3, v2, 0xff

    .line 556
    .local v3, "bucket":I
    if-nez v3, :cond_7

    .line 557
    iget v4, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollEnd:I

    const/16 v5, 0xfe

    if-gt v4, v5, :cond_5

    .line 558
    iget v3, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollEnd:I

    .line 559
    iget v4, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollEnd:I

    add-int/2addr v4, v1

    iput v4, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollEnd:I

    .line 561
    iget-object v4, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    array-length v4, v4

    if-lt v3, v4, :cond_6

    .line 562
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->expandCollision()V

    goto :goto_0

    .line 565
    :cond_5
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->findBestBucket()I

    move-result v3

    .line 568
    :cond_6
    :goto_0
    iget-object v4, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    and-int/lit16 v5, v2, -0x100

    add-int/lit8 v6, v3, 0x1

    or-int/2addr v5, v6

    aput v5, v4, v0

    goto :goto_1

    .line 570
    :cond_7
    add-int/lit8 v3, v3, -0x1

    .line 574
    :goto_1
    iget-object v4, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    new-instance v5, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    iget-object v6, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    aget-object v6, v6, v3

    invoke-direct {v5, p2, v6}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;-><init>(Lcom/fasterxml/aalto/in/ByteBasedPName;Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;)V

    aput-object v5, v4, v3

    .line 581
    .end local v2    # "entryValue":I
    .end local v3    # "bucket":I
    :goto_2
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    array-length v2, v2

    .line 582
    .local v2, "hashSize":I
    iget v3, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCount:I

    shr-int/lit8 v4, v2, 0x1

    if-le v3, v4, :cond_9

    .line 583
    shr-int/lit8 v3, v2, 0x2

    .line 587
    .local v3, "hashQuarter":I
    iget v4, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCount:I

    sub-int v5, v2, v3

    if-le v4, v5, :cond_8

    .line 588
    iput-boolean v1, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mNeedRehash:Z

    goto :goto_3

    .line 589
    :cond_8
    iget v4, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollCount:I

    if-lt v4, v3, :cond_9

    .line 590
    iput-boolean v1, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mNeedRehash:Z

    .line 594
    .end local v2    # "hashSize":I
    .end local v3    # "hashQuarter":I
    :cond_9
    :goto_3
    return-void
.end method

.method private expandCollision()V
    .locals 4

    .line 757
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    .line 758
    .local v0, "old":[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    array-length v1, v0

    .line 759
    .local v1, "len":I
    add-int v2, v1, v1

    new-array v2, v2, [Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    iput-object v2, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    .line 760
    const/4 v2, 0x0

    iget-object v3, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    invoke-static {v0, v2, v3, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 761
    return-void
.end method

.method private findBestBucket()I
    .locals 7

    .line 700
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    .line 701
    .local v0, "buckets":[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    const v1, 0x7fffffff

    .line 702
    .local v1, "bestCount":I
    const/4 v2, -0x1

    .line 704
    .local v2, "bestIx":I
    const/4 v3, 0x0

    .local v3, "i":I
    iget v4, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollEnd:I

    .local v4, "len":I
    :goto_0
    if-ge v3, v4, :cond_2

    .line 705
    aget-object v5, v0, v3

    invoke-virtual {v5}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;->length()I

    move-result v5

    .line 706
    .local v5, "count":I
    if-ge v5, v1, :cond_1

    .line 707
    const/4 v6, 0x1

    if-ne v5, v6, :cond_0

    .line 708
    return v3

    .line 710
    :cond_0
    move v1, v5

    .line 711
    move v2, v3

    .line 704
    .end local v5    # "count":I
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 714
    .end local v3    # "i":I
    .end local v4    # "len":I
    :cond_2
    return v2
.end method

.method private rehash()V
    .locals 17

    .line 606
    move-object/from16 v0, p0

    const/4 v1, 0x0

    iput-boolean v1, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mNeedRehash:Z

    .line 608
    iput-boolean v1, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNamesShared:Z

    .line 614
    const/4 v2, 0x0

    .line 615
    .local v2, "symbolsSeen":I
    iget-object v3, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    .line 616
    .local v3, "oldMainHash":[I
    array-length v4, v3

    .line 617
    .local v4, "len":I
    add-int v5, v4, v4

    new-array v5, v5, [I

    iput-object v5, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    .line 618
    add-int v5, v4, v4

    add-int/lit8 v5, v5, -0x1

    iput v5, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHashMask:I

    .line 619
    iget-object v5, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNames:[Lcom/fasterxml/aalto/in/ByteBasedPName;

    .line 620
    .local v5, "oldNames":[Lcom/fasterxml/aalto/in/ByteBasedPName;
    add-int v6, v4, v4

    new-array v6, v6, [Lcom/fasterxml/aalto/in/ByteBasedPName;

    iput-object v6, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNames:[Lcom/fasterxml/aalto/in/ByteBasedPName;

    .line 621
    const/4 v6, 0x0

    .local v6, "i":I
    :goto_0
    if-ge v6, v4, :cond_1

    .line 622
    aget-object v7, v5, v6

    .line 623
    .local v7, "symbol":Lcom/fasterxml/aalto/in/ByteBasedPName;
    if-eqz v7, :cond_0

    .line 624
    add-int/lit8 v2, v2, 0x1

    .line 625
    invoke-virtual {v7}, Lcom/fasterxml/aalto/in/ByteBasedPName;->hashCode()I

    move-result v8

    .line 626
    .local v8, "hash":I
    iget v9, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHashMask:I

    and-int/2addr v9, v8

    .line 627
    .local v9, "ix":I
    iget-object v10, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNames:[Lcom/fasterxml/aalto/in/ByteBasedPName;

    aput-object v7, v10, v9

    .line 628
    iget-object v10, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    shl-int/lit8 v11, v8, 0x8

    aput v11, v10, v9

    .line 621
    .end local v7    # "symbol":Lcom/fasterxml/aalto/in/ByteBasedPName;
    .end local v8    # "hash":I
    .end local v9    # "ix":I
    :cond_0
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 636
    .end local v6    # "i":I
    :cond_1
    iget v6, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollEnd:I

    .line 637
    .local v6, "oldEnd":I
    if-nez v6, :cond_2

    .line 638
    return-void

    .line 641
    :cond_2
    iput v1, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollCount:I

    .line 642
    iput v1, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollEnd:I

    .line 643
    iput-boolean v1, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollListShared:Z

    .line 645
    iget-object v1, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    .line 646
    .local v1, "oldBuckets":[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    array-length v7, v1

    new-array v7, v7, [Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    iput-object v7, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    .line 647
    const/4 v7, 0x0

    .local v7, "i":I
    :goto_1
    if-ge v7, v6, :cond_8

    .line 648
    aget-object v8, v1, v7

    .local v8, "curr":Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    :goto_2
    if-eqz v8, :cond_7

    .line 649
    add-int/lit8 v2, v2, 0x1

    .line 650
    iget-object v9, v8, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;->mName:Lcom/fasterxml/aalto/in/ByteBasedPName;

    .line 651
    .local v9, "symbol":Lcom/fasterxml/aalto/in/ByteBasedPName;
    invoke-virtual {v9}, Lcom/fasterxml/aalto/in/ByteBasedPName;->hashCode()I

    move-result v10

    .line 652
    .local v10, "hash":I
    iget v11, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHashMask:I

    and-int/2addr v11, v10

    .line 653
    .local v11, "ix":I
    iget-object v12, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    aget v12, v12, v11

    .line 654
    .local v12, "val":I
    iget-object v13, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNames:[Lcom/fasterxml/aalto/in/ByteBasedPName;

    aget-object v13, v13, v11

    if-nez v13, :cond_3

    .line 655
    iget-object v13, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    shl-int/lit8 v14, v10, 0x8

    aput v14, v13, v11

    .line 656
    iget-object v13, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNames:[Lcom/fasterxml/aalto/in/ByteBasedPName;

    aput-object v9, v13, v11

    move-object/from16 v16, v1

    goto :goto_5

    .line 658
    :cond_3
    iget v13, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollCount:I

    add-int/lit8 v13, v13, 0x1

    iput v13, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollCount:I

    .line 659
    and-int/lit16 v13, v12, 0xff

    .line 660
    .local v13, "bucket":I
    if-nez v13, :cond_6

    .line 661
    iget v14, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollEnd:I

    const/16 v15, 0xfe

    if-gt v14, v15, :cond_4

    .line 662
    iget v13, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollEnd:I

    .line 663
    iget v14, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollEnd:I

    add-int/lit8 v14, v14, 0x1

    iput v14, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollEnd:I

    .line 665
    iget-object v14, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    array-length v14, v14

    if-lt v13, v14, :cond_5

    .line 666
    invoke-direct/range {p0 .. p0}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->expandCollision()V

    goto :goto_3

    .line 669
    :cond_4
    invoke-direct/range {p0 .. p0}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->findBestBucket()I

    move-result v13

    .line 672
    :cond_5
    :goto_3
    iget-object v14, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    and-int/lit16 v15, v12, -0x100

    add-int/lit8 v16, v13, 0x1

    or-int v15, v15, v16

    aput v15, v14, v11

    goto :goto_4

    .line 674
    :cond_6
    add-int/lit8 v13, v13, -0x1

    .line 677
    :goto_4
    iget-object v14, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    new-instance v15, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    move-object/from16 v16, v1

    .end local v1    # "oldBuckets":[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    .local v16, "oldBuckets":[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    iget-object v1, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    aget-object v1, v1, v13

    invoke-direct {v15, v9, v1}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;-><init>(Lcom/fasterxml/aalto/in/ByteBasedPName;Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;)V

    aput-object v15, v14, v13

    .line 648
    .end local v9    # "symbol":Lcom/fasterxml/aalto/in/ByteBasedPName;
    .end local v10    # "hash":I
    .end local v11    # "ix":I
    .end local v12    # "val":I
    .end local v13    # "bucket":I
    :goto_5
    iget-object v8, v8, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;->mNext:Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    move-object/from16 v1, v16

    goto :goto_2

    .end local v16    # "oldBuckets":[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    .restart local v1    # "oldBuckets":[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    :cond_7
    move-object/from16 v16, v1

    .line 647
    .end local v1    # "oldBuckets":[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    .end local v8    # "curr":Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    .restart local v16    # "oldBuckets":[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    add-int/lit8 v7, v7, 0x1

    goto :goto_1

    .end local v16    # "oldBuckets":[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    .restart local v1    # "oldBuckets":[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    :cond_8
    move-object/from16 v16, v1

    .line 682
    .end local v1    # "oldBuckets":[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    .end local v7    # "i":I
    .restart local v16    # "oldBuckets":[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    iget v1, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCount:I

    if-ne v2, v1, :cond_9

    .line 691
    return-void

    .line 683
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

    iget v8, v0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCount:I

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v1, v7}, Ljava/lang/Error;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method private unshareCollision()V
    .locals 4

    .line 735
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    .line 736
    .local v0, "old":[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 737
    const/16 v2, 0x20

    new-array v2, v2, [Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    iput-object v2, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    goto :goto_0

    .line 739
    :cond_0
    array-length v2, v0

    .line 740
    .local v2, "len":I
    new-array v3, v2, [Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    iput-object v3, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    .line 741
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    invoke-static {v0, v1, v3, v1, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 743
    .end local v2    # "len":I
    :goto_0
    iput-boolean v1, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollListShared:Z

    .line 744
    return-void
.end method

.method private unshareMain()V
    .locals 4

    .line 725
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    .line 726
    .local v0, "old":[I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    array-length v1, v1

    .line 728
    .local v1, "len":I
    new-array v2, v1, [I

    iput-object v2, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    .line 729
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 730
    iput-boolean v3, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHashShared:Z

    .line 731
    return-void
.end method

.method private unshareNames()V
    .locals 4

    .line 748
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNames:[Lcom/fasterxml/aalto/in/ByteBasedPName;

    .line 749
    .local v0, "old":[Lcom/fasterxml/aalto/in/ByteBasedPName;
    array-length v1, v0

    .line 750
    .local v1, "len":I
    new-array v2, v1, [Lcom/fasterxml/aalto/in/ByteBasedPName;

    iput-object v2, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNames:[Lcom/fasterxml/aalto/in/ByteBasedPName;

    .line 751
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNames:[Lcom/fasterxml/aalto/in/ByteBasedPName;

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 752
    iput-boolean v3, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNamesShared:Z

    .line 753
    return-void
.end method


# virtual methods
.method public addSymbol(ILjava/lang/String;III)Lcom/fasterxml/aalto/in/ByteBasedPName;
    .locals 6
    .param p1, "hash"    # I
    .param p2, "symbolStr"    # Ljava/lang/String;
    .param p3, "colonIx"    # I
    .param p4, "firstQuad"    # I
    .param p5, "secondQuad"    # I

    .line 365
    invoke-static {}, Lcom/fasterxml/aalto/in/ByteBasedPNameFactory;->getInstance()Lcom/fasterxml/aalto/in/ByteBasedPNameFactory;

    move-result-object v0

    move v1, p1

    move-object v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    invoke-virtual/range {v0 .. v5}, Lcom/fasterxml/aalto/in/ByteBasedPNameFactory;->constructPName(ILjava/lang/String;III)Lcom/fasterxml/aalto/in/ByteBasedPName;

    move-result-object v0

    .line 367
    .local v0, "symbol":Lcom/fasterxml/aalto/in/ByteBasedPName;
    invoke-direct {p0, p1, v0}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->doAddSymbol(ILcom/fasterxml/aalto/in/ByteBasedPName;)V

    .line 368
    return-object v0
.end method

.method public addSymbol(ILjava/lang/String;I[II)Lcom/fasterxml/aalto/in/ByteBasedPName;
    .locals 6
    .param p1, "hash"    # I
    .param p2, "symbolStr"    # Ljava/lang/String;
    .param p3, "colonIx"    # I
    .param p4, "quads"    # [I
    .param p5, "qlen"    # I

    .line 374
    invoke-static {}, Lcom/fasterxml/aalto/in/ByteBasedPNameFactory;->getInstance()Lcom/fasterxml/aalto/in/ByteBasedPNameFactory;

    move-result-object v0

    move v1, p1

    move-object v2, p2

    move v3, p3

    move-object v4, p4

    move v5, p5

    invoke-virtual/range {v0 .. v5}, Lcom/fasterxml/aalto/in/ByteBasedPNameFactory;->constructPName(ILjava/lang/String;I[II)Lcom/fasterxml/aalto/in/ByteBasedPName;

    move-result-object v0

    .line 376
    .local v0, "symbol":Lcom/fasterxml/aalto/in/ByteBasedPName;
    invoke-direct {p0, p1, v0}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->doAddSymbol(ILcom/fasterxml/aalto/in/ByteBasedPName;)V

    .line 377
    return-object v0
.end method

.method public findSymbol(III)Lcom/fasterxml/aalto/in/ByteBasedPName;
    .locals 5
    .param p1, "hash"    # I
    .param p2, "firstQuad"    # I
    .param p3, "secondQuad"    # I

    .line 277
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHashMask:I

    and-int/2addr v0, p1

    .line 278
    .local v0, "ix":I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    aget v1, v1, v0

    .line 283
    .local v1, "val":I
    shr-int/lit8 v2, v1, 0x8

    xor-int/2addr v2, p1

    shl-int/lit8 v2, v2, 0x8

    const/4 v3, 0x0

    if-nez v2, :cond_2

    .line 285
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNames:[Lcom/fasterxml/aalto/in/ByteBasedPName;

    aget-object v2, v2, v0

    .line 286
    .local v2, "pname":Lcom/fasterxml/aalto/in/ByteBasedPName;
    if-nez v2, :cond_0

    .line 287
    return-object v3

    .line 289
    :cond_0
    invoke-virtual {v2, p2, p3}, Lcom/fasterxml/aalto/in/ByteBasedPName;->equals(II)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 290
    return-object v2

    .line 289
    .end local v2    # "pname":Lcom/fasterxml/aalto/in/ByteBasedPName;
    :cond_1
    goto :goto_0

    .line 292
    :cond_2
    if-nez v1, :cond_3

    .line 293
    return-object v3

    .line 292
    :cond_3
    :goto_0
    nop

    .line 296
    and-int/lit16 v1, v1, 0xff

    .line 297
    if-lez v1, :cond_4

    .line 298
    add-int/lit8 v1, v1, -0x1

    .line 299
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    aget-object v2, v2, v1

    .line 300
    .local v2, "bucket":Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    if-eqz v2, :cond_4

    .line 301
    invoke-virtual {v2, p1, p2, p3}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;->find(III)Lcom/fasterxml/aalto/in/ByteBasedPName;

    move-result-object v3

    return-object v3

    .line 305
    .end local v2    # "bucket":Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    :cond_4
    return-object v3
.end method

.method public findSymbol(I[II)Lcom/fasterxml/aalto/in/ByteBasedPName;
    .locals 5
    .param p1, "hash"    # I
    .param p2, "quads"    # [I
    .param p3, "qlen"    # I

    .line 328
    const/4 v0, 0x3

    if-ge p3, v0, :cond_1

    .line 329
    const/4 v0, 0x0

    aget v1, p2, v0

    const/4 v2, 0x2

    if-ge p3, v2, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x1

    aget v0, p2, v0

    :goto_0
    invoke-virtual {p0, p1, v1, v0}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->findSymbol(III)Lcom/fasterxml/aalto/in/ByteBasedPName;

    move-result-object v0

    return-object v0

    .line 332
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHashMask:I

    and-int/2addr v0, p1

    .line 333
    .local v0, "ix":I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    aget v1, v1, v0

    .line 334
    .local v1, "val":I
    shr-int/lit8 v2, v1, 0x8

    xor-int/2addr v2, p1

    shl-int/lit8 v2, v2, 0x8

    const/4 v3, 0x0

    if-nez v2, :cond_4

    .line 335
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNames:[Lcom/fasterxml/aalto/in/ByteBasedPName;

    aget-object v2, v2, v0

    .line 336
    .local v2, "pname":Lcom/fasterxml/aalto/in/ByteBasedPName;
    if-nez v2, :cond_2

    .line 337
    return-object v3

    .line 339
    :cond_2
    invoke-virtual {v2, p2, p3}, Lcom/fasterxml/aalto/in/ByteBasedPName;->equals([II)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 340
    return-object v2

    .line 339
    .end local v2    # "pname":Lcom/fasterxml/aalto/in/ByteBasedPName;
    :cond_3
    goto :goto_1

    .line 342
    :cond_4
    if-nez v1, :cond_5

    .line 343
    return-object v3

    .line 342
    :cond_5
    :goto_1
    nop

    .line 345
    and-int/lit16 v1, v1, 0xff

    .line 346
    if-lez v1, :cond_6

    .line 347
    add-int/lit8 v1, v1, -0x1

    .line 348
    iget-object v2, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    aget-object v2, v2, v1

    .line 349
    .local v2, "bucket":Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    if-eqz v2, :cond_6

    .line 350
    invoke-virtual {v2, p1, p2, p3}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;->find(I[II)Lcom/fasterxml/aalto/in/ByteBasedPName;

    move-result-object v3

    return-object v3

    .line 353
    .end local v2    # "bucket":Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;
    :cond_6
    return-object v3
.end method

.method public markAsShared()V
    .locals 1

    .line 223
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHashShared:Z

    .line 224
    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNamesShared:Z

    .line 225
    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollListShared:Z

    .line 226
    return-void
.end method

.method public maybeDirty()Z
    .locals 1

    .line 253
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHashShared:Z

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public mergeFromChild(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;)Z
    .locals 2
    .param p1, "child"    # Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    .line 201
    iget v0, p1, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCount:I

    iget v1, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCount:I

    if-gt v0, v1, :cond_0

    .line 202
    const/4 v0, 0x0

    return v0

    .line 206
    :cond_0
    iget v0, p1, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCount:I

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCount:I

    .line 207
    iget v0, p1, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHashMask:I

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHashMask:I

    .line 208
    iget-object v0, p1, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    .line 209
    iget-object v0, p1, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNames:[Lcom/fasterxml/aalto/in/ByteBasedPName;

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNames:[Lcom/fasterxml/aalto/in/ByteBasedPName;

    .line 210
    iget-object v0, p1, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    .line 211
    iget v0, p1, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollCount:I

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollCount:I

    .line 212
    iget v0, p1, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollEnd:I

    iput v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollEnd:I

    .line 217
    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->markAsShared()V

    .line 218
    const/4 v0, 0x1

    return v0
.end method

.method public nuke()V
    .locals 1

    .line 232
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    .line 233
    iput-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainNames:[Lcom/fasterxml/aalto/in/ByteBasedPName;

    .line 234
    iput-object v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    .line 235
    return-void
.end method

.method public size()I
    .locals 1

    .line 244
    iget v0, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCount:I

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 6

    .line 443
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 444
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string v1, "[PNameTable, size: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 445
    iget v1, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCount:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 446
    const/16 v1, 0x2f

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 447
    iget-object v1, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mMainHash:[I

    array-length v1, v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 448
    const-string v1, ", "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 449
    iget v1, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollCount:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 450
    const-string v1, " coll; avg length: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 456
    iget v1, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCount:I

    .line 457
    .local v1, "pathCount":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    iget v3, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollEnd:I

    if-ge v2, v3, :cond_1

    .line 458
    iget-object v3, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCollList:[Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;

    aget-object v3, v3, v2

    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/ByteBasedPNameTable$Bucket;->length()I

    move-result v3

    .line 459
    .local v3, "spillLen":I
    const/4 v4, 0x1

    .local v4, "j":I
    :goto_1
    if-gt v4, v3, :cond_0

    .line 460
    add-int/2addr v1, v4

    .line 459
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 457
    .end local v3    # "spillLen":I
    .end local v4    # "j":I
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 465
    .end local v2    # "i":I
    :cond_1
    iget v2, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCount:I

    if-nez v2, :cond_2

    .line 466
    const-wide/16 v2, 0x0

    .local v2, "avgLength":D
    goto :goto_2

    .line 468
    .end local v2    # "avgLength":D
    :cond_2
    int-to-double v2, v1

    iget v4, p0, Lcom/fasterxml/aalto/in/ByteBasedPNameTable;->mCount:I

    int-to-double v4, v4

    div-double/2addr v2, v4

    .line 473
    .restart local v2    # "avgLength":D
    :goto_2
    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    .line 474
    const/16 v4, 0x5d

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 475
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    return-object v4
.end method
