.class public Lcom/fasterxml/aalto/in/CharBasedPNameTable;
.super Lcom/fasterxml/aalto/util/NameTable;
.source "CharBasedPNameTable.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;
    }
.end annotation


# static fields
.field protected static final DEFAULT_FILL_FACTOR:F = 0.75f

.field static final MIN_HASH_SIZE:I = 0x10


# instance fields
.field protected _buckets:[Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

.field protected _dirty:Z

.field protected _indexMask:I

.field protected _size:I

.field protected _sizeThreshold:I

.field protected _symbols:[Lcom/fasterxml/aalto/in/PNameC;


# direct methods
.method public constructor <init>(I)V
    .locals 3
    .param p1, "initialSize"    # I

    .line 101
    invoke-direct {p0}, Lcom/fasterxml/aalto/util/NameTable;-><init>()V

    .line 103
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_dirty:Z

    .line 106
    if-lt p1, v0, :cond_1

    .line 110
    const/16 v0, 0x10

    .line 111
    .local v0, "currSize":I
    :goto_0
    if-ge v0, p1, :cond_0

    .line 112
    add-int/2addr v0, v0

    goto :goto_0

    .line 114
    :cond_0
    move p1, v0

    .line 117
    .end local v0    # "currSize":I
    new-array v0, p1, [Lcom/fasterxml/aalto/in/PNameC;

    iput-object v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_symbols:[Lcom/fasterxml/aalto/in/PNameC;

    .line 118
    shr-int/lit8 v0, p1, 0x1

    new-array v0, v0, [Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    iput-object v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_buckets:[Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    .line 120
    add-int/lit8 v0, p1, -0x1

    iput v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_indexMask:I

    .line 121
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_size:I

    .line 125
    mul-int/lit8 v0, p1, 0x3

    add-int/lit8 v0, v0, 0x3

    shr-int/lit8 v0, v0, 0x2

    iput v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_sizeThreshold:I

    .line 126
    return-void

    .line 107
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Can not use negative/zero initial size: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method constructor <init>(Lcom/fasterxml/aalto/in/CharBasedPNameTable;)V
    .locals 1
    .param p1, "parent"    # Lcom/fasterxml/aalto/in/CharBasedPNameTable;

    .line 129
    invoke-direct {p0}, Lcom/fasterxml/aalto/util/NameTable;-><init>()V

    .line 130
    iget-object v0, p1, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_symbols:[Lcom/fasterxml/aalto/in/PNameC;

    iput-object v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_symbols:[Lcom/fasterxml/aalto/in/PNameC;

    .line 131
    iget-object v0, p1, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_buckets:[Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    iput-object v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_buckets:[Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    .line 132
    iget v0, p1, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_size:I

    iput v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_size:I

    .line 133
    iget v0, p1, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_sizeThreshold:I

    iput v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_sizeThreshold:I

    .line 134
    iget v0, p1, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_indexMask:I

    iput v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_indexMask:I

    .line 137
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_dirty:Z

    .line 138
    return-void
.end method

.method private copyArrays()V
    .locals 5

    .line 266
    iget-object v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_symbols:[Lcom/fasterxml/aalto/in/PNameC;

    .line 267
    .local v0, "oldSyms":[Lcom/fasterxml/aalto/in/PNameC;
    array-length v1, v0

    .line 268
    .local v1, "size":I
    new-array v2, v1, [Lcom/fasterxml/aalto/in/PNameC;

    iput-object v2, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_symbols:[Lcom/fasterxml/aalto/in/PNameC;

    .line 269
    iget-object v2, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_symbols:[Lcom/fasterxml/aalto/in/PNameC;

    const/4 v3, 0x0

    invoke-static {v0, v3, v2, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 270
    iget-object v2, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_buckets:[Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    .line 271
    .local v2, "oldBuckets":[Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;
    array-length v1, v2

    .line 272
    new-array v4, v1, [Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    iput-object v4, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_buckets:[Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    .line 273
    iget-object v4, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_buckets:[Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    invoke-static {v2, v3, v4, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 275
    const/4 v3, 0x1

    iput-boolean v3, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_dirty:Z

    .line 276
    return-void
.end method

.method private rehash()V
    .locals 13

    .line 287
    iget-object v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_symbols:[Lcom/fasterxml/aalto/in/PNameC;

    array-length v0, v0

    .line 288
    .local v0, "size":I
    add-int v1, v0, v0

    .line 289
    .local v1, "newSize":I
    iget-object v2, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_symbols:[Lcom/fasterxml/aalto/in/PNameC;

    .line 290
    .local v2, "oldSyms":[Lcom/fasterxml/aalto/in/PNameC;
    iget-object v3, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_buckets:[Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    .line 291
    .local v3, "oldBuckets":[Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;
    new-array v4, v1, [Lcom/fasterxml/aalto/in/PNameC;

    iput-object v4, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_symbols:[Lcom/fasterxml/aalto/in/PNameC;

    .line 292
    shr-int/lit8 v4, v1, 0x1

    new-array v4, v4, [Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    iput-object v4, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_buckets:[Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    .line 294
    add-int/lit8 v4, v1, -0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_indexMask:I

    .line 295
    iget v4, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_sizeThreshold:I

    iget v5, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_sizeThreshold:I

    add-int/2addr v4, v5

    iput v4, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_sizeThreshold:I

    .line 297
    const/4 v4, 0x0

    .line 302
    .local v4, "count":I
    const/4 v5, 0x0

    .local v5, "i":I
    :goto_0
    if-ge v5, v0, :cond_2

    .line 303
    aget-object v6, v2, v5

    .line 304
    .local v6, "symbol":Lcom/fasterxml/aalto/in/PNameC;
    if-eqz v6, :cond_1

    .line 305
    add-int/lit8 v4, v4, 0x1

    .line 306
    invoke-virtual {v6}, Lcom/fasterxml/aalto/in/PNameC;->getCustomHash()I

    move-result v7

    iget v8, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_indexMask:I

    and-int/2addr v7, v8

    .line 307
    .local v7, "index":I
    iget-object v8, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_symbols:[Lcom/fasterxml/aalto/in/PNameC;

    aget-object v8, v8, v7

    if-nez v8, :cond_0

    .line 308
    iget-object v8, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_symbols:[Lcom/fasterxml/aalto/in/PNameC;

    aput-object v6, v8, v7

    goto :goto_1

    .line 310
    :cond_0
    shr-int/lit8 v8, v7, 0x1

    .line 311
    .local v8, "bix":I
    iget-object v9, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_buckets:[Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    new-instance v10, Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    iget-object v11, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_buckets:[Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    aget-object v11, v11, v8

    invoke-direct {v10, v6, v11}, Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;-><init>(Lcom/fasterxml/aalto/in/PNameC;Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;)V

    aput-object v10, v9, v8

    .line 302
    .end local v6    # "symbol":Lcom/fasterxml/aalto/in/PNameC;
    .end local v7    # "index":I
    .end local v8    # "bix":I
    :cond_1
    :goto_1
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 316
    .end local v5    # "i":I
    :cond_2
    shr-int/lit8 v0, v0, 0x1

    .line 317
    const/4 v5, 0x0

    .restart local v5    # "i":I
    :goto_2
    if-ge v5, v0, :cond_5

    .line 318
    aget-object v6, v3, v5

    .line 319
    .local v6, "b":Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;
    :goto_3
    if-eqz v6, :cond_4

    .line 320
    add-int/lit8 v4, v4, 0x1

    .line 321
    invoke-virtual {v6}, Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;->getSymbol()Lcom/fasterxml/aalto/in/PNameC;

    move-result-object v7

    .line 322
    .local v7, "symbol":Lcom/fasterxml/aalto/in/PNameC;
    invoke-virtual {v7}, Lcom/fasterxml/aalto/in/PNameC;->getCustomHash()I

    move-result v8

    iget v9, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_indexMask:I

    and-int/2addr v8, v9

    .line 323
    .local v8, "index":I
    iget-object v9, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_symbols:[Lcom/fasterxml/aalto/in/PNameC;

    aget-object v9, v9, v8

    if-nez v9, :cond_3

    .line 324
    iget-object v9, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_symbols:[Lcom/fasterxml/aalto/in/PNameC;

    aput-object v7, v9, v8

    goto :goto_4

    .line 326
    :cond_3
    shr-int/lit8 v9, v8, 0x1

    .line 327
    .local v9, "bix":I
    iget-object v10, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_buckets:[Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    new-instance v11, Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    iget-object v12, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_buckets:[Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    aget-object v12, v12, v9

    invoke-direct {v11, v7, v12}, Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;-><init>(Lcom/fasterxml/aalto/in/PNameC;Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;)V

    aput-object v11, v10, v9

    .line 329
    .end local v9    # "bix":I
    :goto_4
    invoke-virtual {v6}, Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;->getNext()Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    move-result-object v6

    .line 330
    .end local v7    # "symbol":Lcom/fasterxml/aalto/in/PNameC;
    .end local v8    # "index":I
    goto :goto_3

    .line 317
    .end local v6    # "b":Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;
    :cond_4
    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    .line 333
    .end local v5    # "i":I
    :cond_5
    iget v5, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_size:I

    if-ne v4, v5, :cond_6

    .line 336
    return-void

    .line 334
    :cond_6
    new-instance v5, Ljava/lang/Error;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Internal error on SymbolTable.rehash(): had "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v7, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_size:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " entries; now have "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "."

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/Error;-><init>(Ljava/lang/String;)V

    throw v5
.end method


# virtual methods
.method public addSymbol([CIII)Lcom/fasterxml/aalto/in/PNameC;
    .locals 8
    .param p1, "buffer"    # [C
    .param p2, "start"    # I
    .param p3, "len"    # I
    .param p4, "hash"    # I

    .line 216
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p1, p2, p3}, Ljava/lang/String;-><init>([CII)V

    invoke-virtual {v0}, Ljava/lang/String;->intern()Ljava/lang/String;

    move-result-object v0

    .line 217
    .local v0, "newStr":Ljava/lang/String;
    invoke-static {v0, p4}, Lcom/fasterxml/aalto/in/PNameC;->construct(Ljava/lang/String;I)Lcom/fasterxml/aalto/in/PNameC;

    move-result-object v1

    .line 218
    .local v1, "pname":Lcom/fasterxml/aalto/in/PNameC;
    iget v2, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_indexMask:I

    and-int/2addr v2, p4

    .line 222
    .local v2, "index":I
    iget-object v3, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_symbols:[Lcom/fasterxml/aalto/in/PNameC;

    aget-object v3, v3, v2

    const/4 v4, 0x1

    if-nez v3, :cond_0

    .line 223
    const/4 v3, 0x1

    .local v3, "primary":Z
    goto :goto_1

    .line 228
    .end local v3    # "primary":Z
    :cond_0
    iget v3, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_size:I

    iget v5, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_sizeThreshold:I

    if-lt v3, v5, :cond_2

    .line 229
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->rehash()V

    .line 231
    iget v3, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_indexMask:I

    and-int v2, p4, v3

    .line 232
    iget-object v3, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_symbols:[Lcom/fasterxml/aalto/in/PNameC;

    aget-object v3, v3, v2

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_0

    :cond_1
    const/4 v3, 0x0

    .restart local v3    # "primary":Z
    :goto_0
    goto :goto_1

    .line 234
    .end local v3    # "primary":Z
    :cond_2
    const/4 v3, 0x0

    .line 239
    .restart local v3    # "primary":Z
    :goto_1
    iget-boolean v5, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_dirty:Z

    if-nez v5, :cond_3

    .line 240
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->copyArrays()V

    .line 243
    :cond_3
    iget v5, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_size:I

    add-int/2addr v5, v4

    iput v5, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_size:I

    .line 244
    if-eqz v3, :cond_4

    .line 245
    iget-object v4, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_symbols:[Lcom/fasterxml/aalto/in/PNameC;

    aput-object v1, v4, v2

    goto :goto_2

    .line 248
    :cond_4
    shr-int/lit8 v4, v2, 0x1

    .line 249
    .local v4, "bix":I
    iget-object v5, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_buckets:[Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    new-instance v6, Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    iget-object v7, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_buckets:[Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    aget-object v7, v7, v4

    invoke-direct {v6, v1, v7}, Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;-><init>(Lcom/fasterxml/aalto/in/PNameC;Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;)V

    aput-object v6, v5, v4

    .line 251
    .end local v4    # "bix":I
    :goto_2
    return-object v1
.end method

.method public findSymbol([CIII)Lcom/fasterxml/aalto/in/PNameC;
    .locals 4
    .param p1, "buffer"    # [C
    .param p2, "start"    # I
    .param p3, "len"    # I
    .param p4, "hash"    # I

    .line 194
    iget v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_indexMask:I

    and-int/2addr v0, p4

    .line 195
    .local v0, "index":I
    iget-object v1, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_symbols:[Lcom/fasterxml/aalto/in/PNameC;

    aget-object v1, v1, v0

    .line 198
    .local v1, "sym":Lcom/fasterxml/aalto/in/PNameC;
    if-eqz v1, :cond_1

    .line 199
    invoke-virtual {v1, p1, p2, p3, p4}, Lcom/fasterxml/aalto/in/PNameC;->equalsPName([CIII)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 200
    return-object v1

    .line 203
    :cond_0
    iget-object v2, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_buckets:[Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    shr-int/lit8 v3, v0, 0x1

    aget-object v2, v2, v3

    .line 204
    .local v2, "b":Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;
    if-eqz v2, :cond_1

    .line 205
    invoke-virtual {v2, p1, p2, p3, p4}, Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;->find([CIII)Lcom/fasterxml/aalto/in/PNameC;

    move-result-object v1

    .line 206
    if-eqz v1, :cond_1

    .line 207
    return-object v1

    .line 211
    .end local v2    # "b":Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;
    :cond_1
    const/4 v2, 0x0

    return-object v2
.end method

.method public maybeDirty()Z
    .locals 1

    .line 184
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_dirty:Z

    return v0
.end method

.method public declared-synchronized mergeFromChild(Lcom/fasterxml/aalto/in/CharBasedPNameTable;)V
    .locals 2
    .param p1, "child"    # Lcom/fasterxml/aalto/in/CharBasedPNameTable;

    monitor-enter p0

    .line 150
    :try_start_0
    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->size()I

    move-result v0

    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->size()I

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-gt v0, v1, :cond_0

    .line 151
    monitor-exit p0

    return-void

    .line 155
    :cond_0
    :try_start_1
    iget-object v0, p1, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_symbols:[Lcom/fasterxml/aalto/in/PNameC;

    iput-object v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_symbols:[Lcom/fasterxml/aalto/in/PNameC;

    .line 156
    iget-object v0, p1, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_buckets:[Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    iput-object v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_buckets:[Lcom/fasterxml/aalto/in/CharBasedPNameTable$Bucket;

    .line 157
    iget v0, p1, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_size:I

    iput v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_size:I

    .line 158
    iget v0, p1, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_sizeThreshold:I

    iput v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_sizeThreshold:I

    .line 159
    iget v0, p1, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_indexMask:I

    iput v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_indexMask:I

    .line 163
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_dirty:Z

    .line 171
    iput-boolean v0, p1, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_dirty:Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 172
    monitor-exit p0

    return-void

    .line 149
    .end local p0    # "this":Lcom/fasterxml/aalto/in/CharBasedPNameTable;
    .end local p1    # "child":Lcom/fasterxml/aalto/in/CharBasedPNameTable;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public size()I
    .locals 1

    .line 181
    iget v0, p0, Lcom/fasterxml/aalto/in/CharBasedPNameTable;->_size:I

    return v0
.end method
