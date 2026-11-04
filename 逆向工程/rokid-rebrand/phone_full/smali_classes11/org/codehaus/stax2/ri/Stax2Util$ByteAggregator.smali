.class public final Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;
.super Ljava/lang/Object;
.source "Stax2Util.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/Stax2Util;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "ByteAggregator"
.end annotation


# static fields
.field static final DEFAULT_BLOCK_ARRAY_SIZE:I = 0x64

.field private static final INITIAL_BLOCK_SIZE:I = 0x1f4

.field private static final NO_BYTES:[B


# instance fields
.field private mBlockCount:I

.field private mBlocks:[[B

.field private mSpareBlock:[B

.field private mTotalLen:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 163
    const/4 v0, 0x0

    new-array v0, v0, [B

    sput-object v0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->NO_BYTES:[B

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 190
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public addFullBlock([B)[B
    .locals 5
    .param p1, "block"    # [B

    .line 220
    array-length v0, p1

    .line 222
    .local v0, "blockLen":I
    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mBlocks:[[B

    if-nez v1, :cond_0

    .line 223
    const/16 v1, 0x64

    new-array v1, v1, [[B

    iput-object v1, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mBlocks:[[B

    goto :goto_0

    .line 225
    :cond_0
    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mBlocks:[[B

    array-length v1, v1

    .line 226
    .local v1, "oldLen":I
    iget v2, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mBlockCount:I

    if-lt v2, v1, :cond_1

    .line 227
    iget-object v2, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mBlocks:[[B

    .line 228
    .local v2, "old":[[B
    add-int v3, v1, v1

    new-array v3, v3, [[B

    iput-object v3, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mBlocks:[[B

    .line 229
    iget-object v3, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mBlocks:[[B

    const/4 v4, 0x0

    invoke-static {v2, v4, v3, v4, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 232
    .end local v1    # "oldLen":I
    .end local v2    # "old":[[B
    :cond_1
    :goto_0
    iget-object v1, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mBlocks:[[B

    iget v2, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mBlockCount:I

    aput-object p1, v1, v2

    .line 233
    iget v1, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mBlockCount:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mBlockCount:I

    .line 234
    iget v1, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mTotalLen:I

    add-int/2addr v1, v0

    iput v1, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mTotalLen:I

    .line 242
    iget v1, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mTotalLen:I

    shr-int/lit8 v1, v1, 0x1

    const/16 v2, 0x3e8

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v1

    .line 243
    .local v1, "newSize":I
    new-array v2, v1, [B

    return-object v2
.end method

.method public aggregateAll([BI)[B
    .locals 7
    .param p1, "lastBlock"    # [B
    .param p2, "lastLen"    # I

    .line 252
    iget v0, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mTotalLen:I

    add-int/2addr v0, p2

    .line 254
    .local v0, "totalLen":I
    if-nez v0, :cond_0

    .line 255
    sget-object v1, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->NO_BYTES:[B

    return-object v1

    .line 258
    :cond_0
    new-array v1, v0, [B

    .line 259
    .local v1, "result":[B
    const/4 v2, 0x0

    .line 261
    .local v2, "offset":I
    iget-object v3, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mBlocks:[[B

    const/4 v4, 0x0

    if-eqz v3, :cond_1

    .line 262
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    iget v5, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mBlockCount:I

    if-ge v3, v5, :cond_1

    .line 263
    iget-object v5, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mBlocks:[[B

    aget-object v5, v5, v3

    .line 264
    .local v5, "block":[B
    array-length v6, v5

    .line 265
    .local v6, "len":I
    invoke-static {v5, v4, v1, v2, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 266
    add-int/2addr v2, v6

    .line 262
    .end local v5    # "block":[B
    .end local v6    # "len":I
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 269
    .end local v3    # "i":I
    :cond_1
    invoke-static {p1, v4, v1, v2, p2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 271
    iput-object p1, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mSpareBlock:[B

    .line 272
    add-int/2addr v2, p2

    .line 273
    if-ne v2, v0, :cond_2

    .line 276
    return-object v1

    .line 274
    :cond_2
    new-instance v3, Ljava/lang/RuntimeException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Internal error: total len assumed to be "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ", copied "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " bytes"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v3
.end method

.method public startAggregation()[B
    .locals 2

    .line 199
    const/4 v0, 0x0

    iput v0, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mTotalLen:I

    .line 200
    iput v0, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mBlockCount:I

    .line 201
    iget-object v0, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mSpareBlock:[B

    .line 202
    .local v0, "result":[B
    if-nez v0, :cond_0

    .line 203
    const/16 v1, 0x1f4

    new-array v0, v1, [B

    goto :goto_0

    .line 205
    :cond_0
    const/4 v1, 0x0

    iput-object v1, p0, Lorg/codehaus/stax2/ri/Stax2Util$ByteAggregator;->mSpareBlock:[B

    .line 207
    :goto_0
    return-object v0
.end method
