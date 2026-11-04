.class Lorg/apache/commons/compress/archivers/zip/BinaryTree;
.super Ljava/lang/Object;
.source "BinaryTree.java"


# static fields
.field private static final NODE:I = -0x2

.field private static final UNDEFINED:I = -0x1


# instance fields
.field private final tree:[I


# direct methods
.method public constructor <init>(I)V
    .locals 5
    .param p1, "depth"    # I

    .line 49
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 50
    if-ltz p1, :cond_0

    const/16 v0, 0x1e

    if-gt p1, v0, :cond_0

    .line 54
    add-int/lit8 v0, p1, 0x1

    const-wide/16 v1, 0x1

    shl-long v3, v1, v0

    sub-long/2addr v3, v1

    long-to-int v0, v3

    new-array v0, v0, [I

    iput-object v0, p0, Lorg/apache/commons/compress/archivers/zip/BinaryTree;->tree:[I

    .line 55
    iget-object v0, p0, Lorg/apache/commons/compress/archivers/zip/BinaryTree;->tree:[I

    const/4 v1, -0x1

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([II)V

    .line 56
    return-void

    .line 51
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "depth must be bigger than 0 and not bigger than 30 but is "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method static decode(Ljava/io/InputStream;I)Lorg/apache/commons/compress/archivers/zip/BinaryTree;
    .locals 19
    .param p0, "inputStream"    # Ljava/io/InputStream;
    .param p1, "totalNumberOfValues"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 116
    move/from16 v0, p1

    if-ltz v0, :cond_d

    .line 121
    invoke-virtual/range {p0 .. p0}, Ljava/io/InputStream;->read()I

    move-result v1

    const/4 v2, 0x1

    add-int/2addr v1, v2

    .line 122
    .local v1, "size":I
    if-eqz v1, :cond_c

    .line 126
    move-object/from16 v3, p0

    invoke-static {v3, v1}, Lorg/apache/commons/compress/utils/IOUtils;->readRange(Ljava/io/InputStream;I)[B

    move-result-object v4

    .line 127
    .local v4, "encodedTree":[B
    array-length v5, v4

    if-ne v5, v1, :cond_b

    .line 132
    const/4 v5, 0x0

    .line 134
    .local v5, "maxLength":I
    new-array v6, v0, [I

    .line 135
    .local v6, "originalBitLengths":[I
    const/4 v7, 0x0

    .line 136
    .local v7, "pos":I
    array-length v8, v4

    const/4 v10, 0x0

    :goto_0
    if-ge v10, v8, :cond_2

    aget-byte v11, v4, v10

    .line 138
    .local v11, "b":B
    and-int/lit16 v12, v11, 0xf0

    shr-int/lit8 v12, v12, 0x4

    add-int/2addr v12, v2

    .line 139
    .local v12, "numberOfValues":I
    add-int v13, v7, v12

    if-gt v13, v0, :cond_1

    .line 142
    and-int/lit8 v13, v11, 0xf

    add-int/2addr v13, v2

    .line 144
    .local v13, "bitLength":I
    const/4 v14, 0x0

    .local v14, "j":I
    :goto_1
    if-ge v14, v12, :cond_0

    .line 145
    add-int/lit8 v15, v7, 0x1

    .end local v7    # "pos":I
    .local v15, "pos":I
    aput v13, v6, v7

    .line 144
    add-int/lit8 v14, v14, 0x1

    move v7, v15

    goto :goto_1

    .line 148
    .end local v14    # "j":I
    .end local v15    # "pos":I
    .restart local v7    # "pos":I
    :cond_0
    invoke-static {v5, v13}, Ljava/lang/Math;->max(II)I

    move-result v5

    .line 136
    .end local v11    # "b":B
    .end local v12    # "numberOfValues":I
    .end local v13    # "bitLength":I
    add-int/lit8 v10, v10, 0x1

    goto :goto_0

    .line 140
    .restart local v11    # "b":B
    .restart local v12    # "numberOfValues":I
    :cond_1
    new-instance v2, Ljava/io/IOException;

    const-string v8, "Number of values exceeds given total number of values"

    invoke-direct {v2, v8}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 151
    .end local v11    # "b":B
    .end local v12    # "numberOfValues":I
    :cond_2
    array-length v8, v6

    .line 153
    .local v8, "oBitLengths":I
    new-array v10, v8, [I

    .line 154
    .local v10, "permutation":[I
    const/4 v11, 0x0

    .local v11, "k":I
    :goto_2
    array-length v12, v10

    if-ge v11, v12, :cond_3

    .line 155
    aput v11, v10, v11

    .line 154
    add-int/lit8 v11, v11, 0x1

    goto :goto_2

    .line 158
    .end local v11    # "k":I
    :cond_3
    const/4 v11, 0x0

    .line 159
    .local v11, "c":I
    new-array v12, v8, [I

    .line 160
    .local v12, "sortedBitLengths":[I
    const/4 v13, 0x0

    .local v13, "k":I
    :goto_3
    if-ge v13, v8, :cond_6

    .line 162
    const/4 v14, 0x0

    .local v14, "l":I
    :goto_4
    if-ge v14, v8, :cond_5

    .line 164
    aget v15, v6, v14

    if-ne v15, v13, :cond_4

    .line 166
    aput v13, v12, v11

    .line 169
    aput v14, v10, v11

    .line 171
    add-int/lit8 v11, v11, 0x1

    .line 162
    :cond_4
    add-int/lit8 v14, v14, 0x1

    goto :goto_4

    .line 160
    .end local v14    # "l":I
    :cond_5
    add-int/lit8 v13, v13, 0x1

    goto :goto_3

    .line 177
    .end local v13    # "k":I
    :cond_6
    const/4 v13, 0x0

    .line 178
    .local v13, "code":I
    const/4 v14, 0x0

    .line 179
    .local v14, "codeIncrement":I
    const/4 v15, 0x0

    .line 181
    .local v15, "lastBitLength":I
    new-array v9, v0, [I

    .line 183
    .local v9, "codes":[I
    add-int/lit8 v16, v0, -0x1

    .local v16, "i":I
    :goto_5
    if-ltz v16, :cond_8

    .line 184
    add-int/2addr v13, v14

    .line 185
    aget v2, v12, v16

    if-eq v2, v15, :cond_7

    .line 186
    aget v2, v12, v16

    .line 187
    .end local v15    # "lastBitLength":I
    .local v2, "lastBitLength":I
    rsub-int/lit8 v15, v2, 0x10

    const/16 v17, 0x1

    shl-int v14, v17, v15

    move v15, v2

    goto :goto_6

    .line 185
    .end local v2    # "lastBitLength":I
    .restart local v15    # "lastBitLength":I
    :cond_7
    const/16 v17, 0x1

    .line 189
    :goto_6
    aget v2, v10, v16

    aput v13, v9, v2

    .line 183
    add-int/lit8 v16, v16, -0x1

    move/from16 v2, v17

    goto :goto_5

    .line 193
    .end local v16    # "i":I
    :cond_8
    new-instance v2, Lorg/apache/commons/compress/archivers/zip/BinaryTree;

    invoke-direct {v2, v5}, Lorg/apache/commons/compress/archivers/zip/BinaryTree;-><init>(I)V

    .line 195
    .local v2, "tree":Lorg/apache/commons/compress/archivers/zip/BinaryTree;
    const/16 v16, 0x0

    move/from16 v17, v1

    move/from16 v1, v16

    .local v1, "k":I
    .local v17, "size":I
    :goto_7
    array-length v3, v9

    if-ge v1, v3, :cond_a

    .line 196
    aget v3, v6, v1

    .line 197
    .local v3, "bitLength":I
    if-lez v3, :cond_9

    .line 198
    aget v16, v9, v1

    shl-int/lit8 v16, v16, 0x10

    move-object/from16 v18, v4

    .end local v4    # "encodedTree":[B
    .local v18, "encodedTree":[B
    invoke-static/range {v16 .. v16}, Ljava/lang/Integer;->reverse(I)I

    move-result v4

    move/from16 v16, v5

    const/4 v5, 0x0

    .end local v5    # "maxLength":I
    .local v16, "maxLength":I
    invoke-virtual {v2, v5, v4, v3, v1}, Lorg/apache/commons/compress/archivers/zip/BinaryTree;->addLeaf(IIII)V

    goto :goto_8

    .line 197
    .end local v16    # "maxLength":I
    .end local v18    # "encodedTree":[B
    .restart local v4    # "encodedTree":[B
    .restart local v5    # "maxLength":I
    :cond_9
    move-object/from16 v18, v4

    move/from16 v16, v5

    const/4 v5, 0x0

    .line 195
    .end local v3    # "bitLength":I
    .end local v4    # "encodedTree":[B
    .end local v5    # "maxLength":I
    .restart local v16    # "maxLength":I
    .restart local v18    # "encodedTree":[B
    :goto_8
    add-int/lit8 v1, v1, 0x1

    move-object/from16 v3, p0

    move/from16 v5, v16

    move-object/from16 v4, v18

    goto :goto_7

    .line 202
    .end local v1    # "k":I
    .end local v16    # "maxLength":I
    .end local v18    # "encodedTree":[B
    .restart local v4    # "encodedTree":[B
    .restart local v5    # "maxLength":I
    :cond_a
    return-object v2

    .line 128
    .end local v2    # "tree":Lorg/apache/commons/compress/archivers/zip/BinaryTree;
    .end local v5    # "maxLength":I
    .end local v6    # "originalBitLengths":[I
    .end local v7    # "pos":I
    .end local v8    # "oBitLengths":I
    .end local v9    # "codes":[I
    .end local v10    # "permutation":[I
    .end local v11    # "c":I
    .end local v12    # "sortedBitLengths":[I
    .end local v13    # "code":I
    .end local v14    # "codeIncrement":I
    .end local v15    # "lastBitLength":I
    .end local v17    # "size":I
    .local v1, "size":I
    :cond_b
    move/from16 v17, v1

    .end local v1    # "size":I
    .restart local v17    # "size":I
    new-instance v1, Ljava/io/EOFException;

    invoke-direct {v1}, Ljava/io/EOFException;-><init>()V

    throw v1

    .line 123
    .end local v4    # "encodedTree":[B
    .end local v17    # "size":I
    .restart local v1    # "size":I
    :cond_c
    move/from16 v17, v1

    .end local v1    # "size":I
    .restart local v17    # "size":I
    new-instance v1, Ljava/io/IOException;

    const-string v2, "Cannot read the size of the encoded tree, unexpected end of stream"

    invoke-direct {v1, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 117
    .end local v17    # "size":I
    :cond_d
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "totalNumberOfValues must be bigger than 0, is "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1
.end method


# virtual methods
.method public addLeaf(IIII)V
    .locals 3
    .param p1, "node"    # I
    .param p2, "path"    # I
    .param p3, "depth"    # I
    .param p4, "value"    # I

    .line 67
    if-nez p3, :cond_1

    .line 69
    iget-object v0, p0, Lorg/apache/commons/compress/archivers/zip/BinaryTree;->tree:[I

    aget v0, v0, p1

    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    .line 72
    iget-object v0, p0, Lorg/apache/commons/compress/archivers/zip/BinaryTree;->tree:[I

    aput p4, v0, p1

    goto :goto_0

    .line 70
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Tree value at index "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " has already been assigned ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lorg/apache/commons/compress/archivers/zip/BinaryTree;->tree:[I

    aget v2, v2, p1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 75
    :cond_1
    iget-object v0, p0, Lorg/apache/commons/compress/archivers/zip/BinaryTree;->tree:[I

    const/4 v1, -0x2

    aput v1, v0, p1

    .line 78
    mul-int/lit8 v0, p1, 0x2

    add-int/lit8 v0, v0, 0x1

    and-int/lit8 v1, p2, 0x1

    add-int/2addr v0, v1

    .line 79
    .local v0, "nextChild":I
    ushr-int/lit8 v1, p2, 0x1

    add-int/lit8 v2, p3, -0x1

    invoke-virtual {p0, v0, v1, v2, p4}, Lorg/apache/commons/compress/archivers/zip/BinaryTree;->addLeaf(IIII)V

    .line 81
    .end local v0    # "nextChild":I
    :goto_0
    return-void
.end method

.method public read(Lorg/apache/commons/compress/archivers/zip/BitStream;)I
    .locals 7
    .param p1, "stream"    # Lorg/apache/commons/compress/archivers/zip/BitStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 90
    const/4 v0, 0x0

    .line 93
    .local v0, "currentIndex":I
    :goto_0
    invoke-virtual {p1}, Lorg/apache/commons/compress/archivers/zip/BitStream;->nextBit()I

    move-result v1

    .line 94
    .local v1, "bit":I
    const/4 v2, -0x1

    if-ne v1, v2, :cond_0

    .line 95
    return v2

    .line 98
    :cond_0
    mul-int/lit8 v3, v0, 0x2

    add-int/lit8 v3, v3, 0x1

    add-int/2addr v3, v1

    .line 99
    .local v3, "childIndex":I
    iget-object v4, p0, Lorg/apache/commons/compress/archivers/zip/BinaryTree;->tree:[I

    aget v4, v4, v3

    .line 100
    .local v4, "value":I
    const/4 v5, -0x2

    if-ne v4, v5, :cond_1

    .line 102
    move v0, v3

    .line 108
    .end local v1    # "bit":I
    .end local v3    # "childIndex":I
    .end local v4    # "value":I
    goto :goto_0

    .line 103
    .restart local v1    # "bit":I
    .restart local v3    # "childIndex":I
    .restart local v4    # "value":I
    :cond_1
    if-eq v4, v2, :cond_2

    .line 104
    return v4

    .line 106
    :cond_2
    new-instance v2, Ljava/io/IOException;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "The child "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " of node at index "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " is not defined"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v2, v5}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v2
.end method
