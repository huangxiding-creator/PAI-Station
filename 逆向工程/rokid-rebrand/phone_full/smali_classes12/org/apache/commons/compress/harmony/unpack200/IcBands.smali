.class public Lorg/apache/commons/compress/harmony/unpack200/IcBands;
.super Lorg/apache/commons/compress/harmony/unpack200/BandSet;
.source "IcBands.java"


# instance fields
.field private final cpClass:[Ljava/lang/String;

.field private final cpUTF8:[Ljava/lang/String;

.field private icAll:[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

.field private outerClassToTuples:Ljava/util/Map;

.field private thisClassToTuple:Ljava/util/Map;


# direct methods
.method public constructor <init>(Lorg/apache/commons/compress/harmony/unpack200/Segment;)V
    .locals 1
    .param p1, "segment"    # Lorg/apache/commons/compress/harmony/unpack200/Segment;

    .line 53
    invoke-direct {p0, p1}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;-><init>(Lorg/apache/commons/compress/harmony/unpack200/Segment;)V

    .line 54
    invoke-virtual {p1}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getCpClass()[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->cpClass:[Ljava/lang/String;

    .line 55
    invoke-virtual {p1}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getCpUTF8()[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->cpUTF8:[Ljava/lang/String;

    .line 56
    return-void
.end method

.method static synthetic lambda$getRelevantIcTuples$0(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 3
    .param p0, "arg0"    # Ljava/lang/Object;
    .param p1, "arg1"    # Ljava/lang/Object;

    .line 224
    move-object v0, p0

    check-cast v0, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->getTupleIndex()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    .line 225
    .local v0, "index1":Ljava/lang/Integer;
    move-object v1, p1

    check-cast v1, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->getTupleIndex()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    .line 226
    .local v1, "index2":Ljava/lang/Integer;
    invoke-virtual {v0, v1}, Ljava/lang/Integer;->compareTo(Ljava/lang/Integer;)I

    move-result v2

    return v2
.end method


# virtual methods
.method public getIcTuples()[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    .locals 1

    .line 149
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->icAll:[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    return-object v0
.end method

.method public getRelevantIcTuples(Ljava/lang/String;Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassConstantPool;)[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    .locals 10
    .param p1, "className"    # Ljava/lang/String;
    .param p2, "cp"    # Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassConstantPool;

    .line 160
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    .line 161
    .local v0, "relevantTuplesContains":Ljava/util/Set;
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 163
    .local v1, "relevantTuples":Ljava/util/List;
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->outerClassToTuples:Ljava/util/Map;

    invoke-interface {v2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/List;

    .line 164
    .local v2, "relevantCandidates":Ljava/util/List;
    if-eqz v2, :cond_0

    .line 165
    const/4 v3, 0x0

    .local v3, "index":I
    :goto_0
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v4

    if-ge v3, v4, :cond_0

    .line 166
    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    .line 167
    .local v4, "tuple":Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    invoke-interface {v0, v4}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 168
    invoke-interface {v1, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 165
    .end local v4    # "tuple":Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 172
    .end local v3    # "index":I
    :cond_0
    invoke-virtual {p2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassConstantPool;->entries()Ljava/util/List;

    move-result-object v3

    .line 178
    .local v3, "entries":Ljava/util/List;
    const/4 v4, 0x0

    .local v4, "eIndex":I
    :goto_1
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v5

    if-ge v4, v5, :cond_2

    .line 179
    invoke-interface {v3, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ConstantPoolEntry;

    .line 180
    .local v5, "entry":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ConstantPoolEntry;
    instance-of v6, v5, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;

    if-eqz v6, :cond_1

    .line 181
    move-object v6, v5

    check-cast v6, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;

    .line 182
    .local v6, "clazz":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;
    iget-object v7, p0, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->thisClassToTuple:Ljava/util/Map;

    iget-object v8, v6, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;->name:Ljava/lang/String;

    invoke-interface {v7, v8}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    .line 183
    .local v7, "relevant":Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    if-eqz v7, :cond_1

    invoke-interface {v0, v7}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_1

    .line 184
    invoke-interface {v1, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 178
    .end local v5    # "entry":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ConstantPoolEntry;
    .end local v6    # "clazz":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;
    .end local v7    # "relevant":Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    :cond_1
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 195
    .end local v4    # "eIndex":I
    :cond_2
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 196
    .local v4, "tuplesToScan":Ljava/util/ArrayList;
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    .line 198
    .local v5, "tuplesToAdd":Ljava/util/ArrayList;
    :goto_2
    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v6

    if-lez v6, :cond_7

    .line 200
    invoke-virtual {v5}, Ljava/util/ArrayList;->clear()V

    .line 201
    const/4 v6, 0x0

    .local v6, "index":I
    :goto_3
    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v7

    if-ge v6, v7, :cond_4

    .line 202
    invoke-virtual {v4, v6}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    .line 203
    .local v7, "aRelevantTuple":Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    iget-object v8, p0, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->thisClassToTuple:Ljava/util/Map;

    invoke-virtual {v7}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->outerClassString()Ljava/lang/String;

    move-result-object v9

    invoke-interface {v8, v9}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    .line 204
    .local v8, "relevant":Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    if-eqz v8, :cond_3

    invoke-virtual {v7}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->outerIsAnonymous()Z

    move-result v9

    if-nez v9, :cond_3

    .line 205
    invoke-virtual {v5, v8}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 201
    .end local v7    # "aRelevantTuple":Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    .end local v8    # "relevant":Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    :cond_3
    add-int/lit8 v6, v6, 0x1

    goto :goto_3

    .line 209
    .end local v6    # "index":I
    :cond_4
    invoke-virtual {v4}, Ljava/util/ArrayList;->clear()V

    .line 210
    const/4 v6, 0x0

    .restart local v6    # "index":I
    :goto_4
    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v7

    if-ge v6, v7, :cond_6

    .line 211
    invoke-virtual {v5, v6}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    .line 212
    .local v7, "tuple":Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    invoke-interface {v0, v7}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_5

    .line 213
    invoke-interface {v1, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 214
    invoke-virtual {v4, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 210
    .end local v7    # "tuple":Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    :cond_5
    add-int/lit8 v6, v6, 0x1

    goto :goto_4

    .end local v6    # "index":I
    :cond_6
    goto :goto_2

    .line 223
    :cond_7
    new-instance v6, Lorg/apache/commons/compress/harmony/unpack200/IcBands$$ExternalSyntheticLambda0;

    invoke-direct {v6}, Lorg/apache/commons/compress/harmony/unpack200/IcBands$$ExternalSyntheticLambda0;-><init>()V

    invoke-static {v1, v6}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    .line 229
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v6

    new-array v6, v6, [Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    .line 230
    .local v6, "relevantTuplesArray":[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    const/4 v7, 0x0

    .local v7, "i":I
    :goto_5
    array-length v8, v6

    if-ge v7, v8, :cond_8

    .line 231
    invoke-interface {v1, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    aput-object v8, v6, v7

    .line 230
    add-int/lit8 v7, v7, 0x1

    goto :goto_5

    .line 234
    .end local v7    # "i":I
    :cond_8
    return-object v6
.end method

.method public read(Ljava/io/InputStream;)V
    .locals 31
    .param p1, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 66
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    iget-object v2, v0, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->getInnerClassCount()I

    move-result v2

    .line 67
    .local v2, "innerClassCount":I
    const-string v3, "ic_this_class"

    sget-object v4, Lorg/apache/commons/compress/harmony/pack200/Codec;->UDELTA5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v0, v3, v1, v4, v2}, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v3

    .line 68
    .local v3, "icThisClassInts":[I
    iget-object v4, v0, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->cpClass:[Ljava/lang/String;

    invoke-virtual {v0, v3, v4}, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->getReferences([I[Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v4

    .line 69
    .local v4, "icThisClass":[Ljava/lang/String;
    const-string v5, "ic_flags"

    sget-object v6, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v0, v5, v1, v6, v2}, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v5

    .line 70
    .local v5, "icFlags":[I
    invoke-static {v5}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countBit16([I)I

    move-result v6

    .line 71
    .local v6, "outerClasses":I
    const-string v7, "ic_outer_class"

    sget-object v8, Lorg/apache/commons/compress/harmony/pack200/Codec;->DELTA5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v0, v7, v1, v8, v6}, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v7

    .line 72
    .local v7, "icOuterClassInts":[I
    new-array v8, v6, [Ljava/lang/String;

    .line 73
    .local v8, "icOuterClass":[Ljava/lang/String;
    const/4 v9, 0x0

    .local v9, "i":I
    :goto_0
    array-length v10, v8

    const/4 v11, 0x0

    if-ge v9, v10, :cond_1

    .line 74
    aget v10, v7, v9

    if-nez v10, :cond_0

    .line 75
    aput-object v11, v8, v9

    goto :goto_1

    .line 77
    :cond_0
    iget-object v10, v0, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->cpClass:[Ljava/lang/String;

    aget v11, v7, v9

    add-int/lit8 v11, v11, -0x1

    aget-object v10, v10, v11

    aput-object v10, v8, v9

    .line 73
    :goto_1
    add-int/lit8 v9, v9, 0x1

    goto :goto_0

    .line 80
    .end local v9    # "i":I
    :cond_1
    const-string v9, "ic_name"

    sget-object v10, Lorg/apache/commons/compress/harmony/pack200/Codec;->DELTA5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v0, v9, v1, v10, v6}, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v9

    .line 81
    .local v9, "icNameInts":[I
    new-array v10, v6, [Ljava/lang/String;

    .line 82
    .local v10, "icName":[Ljava/lang/String;
    const/4 v12, 0x0

    .local v12, "i":I
    :goto_2
    array-length v13, v10

    if-ge v12, v13, :cond_3

    .line 83
    aget v13, v9, v12

    if-nez v13, :cond_2

    .line 84
    aput-object v11, v10, v12

    goto :goto_3

    .line 86
    :cond_2
    iget-object v13, v0, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->cpUTF8:[Ljava/lang/String;

    aget v14, v9, v12

    add-int/lit8 v14, v14, -0x1

    aget-object v13, v13, v14

    aput-object v13, v10, v12

    .line 82
    :goto_3
    add-int/lit8 v12, v12, 0x1

    goto :goto_2

    .line 91
    .end local v12    # "i":I
    :cond_3
    array-length v11, v4

    new-array v11, v11, [Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    iput-object v11, v0, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->icAll:[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    .line 92
    const/4 v11, 0x0

    .line 93
    .local v11, "index":I
    const/4 v12, 0x0

    move v15, v12

    .local v15, "i":I
    :goto_4
    array-length v12, v4

    if-ge v15, v12, :cond_5

    .line 94
    aget-object v21, v4, v15

    .line 95
    .local v21, "icTupleC":Ljava/lang/String;
    aget v22, v5, v15

    .line 96
    .local v22, "icTupleF":I
    const/4 v12, 0x0

    .line 97
    .local v12, "icTupleC2":Ljava/lang/String;
    const/4 v13, 0x0

    .line 98
    .local v13, "icTupleN":Ljava/lang/String;
    aget v23, v3, v15

    .line 99
    .local v23, "cIndex":I
    const/4 v14, -0x1

    .line 100
    .local v14, "c2Index":I
    const/16 v16, -0x1

    .line 101
    .local v16, "nIndex":I
    aget v17, v5, v15

    const/high16 v18, 0x10000

    and-int v17, v17, v18

    if-eqz v17, :cond_4

    .line 102
    aget-object v12, v8, v11

    .line 103
    aget-object v13, v10, v11

    .line 104
    aget v17, v7, v11

    add-int/lit8 v14, v17, -0x1

    .line 105
    aget v17, v9, v11

    add-int/lit8 v16, v17, -0x1

    .line 106
    add-int/lit8 v11, v11, 0x1

    move-object/from16 v24, v12

    move-object/from16 v25, v13

    move/from16 v26, v14

    move/from16 v27, v16

    goto :goto_5

    .line 101
    :cond_4
    move-object/from16 v24, v12

    move-object/from16 v25, v13

    move/from16 v26, v14

    move/from16 v27, v16

    .line 108
    .end local v12    # "icTupleC2":Ljava/lang/String;
    .end local v13    # "icTupleN":Ljava/lang/String;
    .end local v14    # "c2Index":I
    .end local v16    # "nIndex":I
    .local v24, "icTupleC2":Ljava/lang/String;
    .local v25, "icTupleN":Ljava/lang/String;
    .local v26, "c2Index":I
    .local v27, "nIndex":I
    :goto_5
    iget-object v14, v0, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->icAll:[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    new-instance v28, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    move-object/from16 v12, v28

    move-object/from16 v13, v21

    move-object/from16 v29, v14

    move/from16 v14, v22

    move/from16 v30, v15

    .end local v15    # "i":I
    .local v30, "i":I
    move-object/from16 v15, v24

    move-object/from16 v16, v25

    move/from16 v17, v23

    move/from16 v18, v26

    move/from16 v19, v27

    move/from16 v20, v30

    invoke-direct/range {v12 .. v20}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;IIII)V

    aput-object v28, v29, v30

    .line 93
    .end local v21    # "icTupleC":Ljava/lang/String;
    .end local v22    # "icTupleF":I
    .end local v23    # "cIndex":I
    .end local v24    # "icTupleC2":Ljava/lang/String;
    .end local v25    # "icTupleN":Ljava/lang/String;
    .end local v26    # "c2Index":I
    .end local v27    # "nIndex":I
    add-int/lit8 v15, v30, 0x1

    .end local v30    # "i":I
    .restart local v15    # "i":I
    goto :goto_4

    .line 110
    .end local v15    # "i":I
    :cond_5
    return-void
.end method

.method public unpack()V
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 114
    invoke-virtual {p0}, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->getIcTuples()[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    move-result-object v0

    .line 115
    .local v0, "allTuples":[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    new-instance v1, Ljava/util/HashMap;

    array-length v2, v0

    invoke-direct {v1, v2}, Ljava/util/HashMap;-><init>(I)V

    iput-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->thisClassToTuple:Ljava/util/Map;

    .line 116
    new-instance v1, Ljava/util/HashMap;

    array-length v2, v0

    invoke-direct {v1, v2}, Ljava/util/HashMap;-><init>(I)V

    iput-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->outerClassToTuples:Ljava/util/Map;

    .line 117
    const/4 v1, 0x0

    .local v1, "index":I
    :goto_0
    array-length v2, v0

    if-ge v1, v2, :cond_5

    .line 119
    aget-object v2, v0, v1

    .line 124
    .local v2, "tuple":Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    iget-object v3, p0, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->thisClassToTuple:Ljava/util/Map;

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->thisClassString()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v3, v4, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .line 125
    .local v3, "result":Ljava/lang/Object;
    if-nez v3, :cond_4

    .line 134
    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->isAnonymous()Z

    move-result v4

    if-nez v4, :cond_0

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->outerIsAnonymous()Z

    move-result v4

    if-eqz v4, :cond_1

    :cond_0
    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->nestedExplicitFlagSet()Z

    move-result v4

    if-eqz v4, :cond_3

    .line 137
    :cond_1
    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->outerClassString()Ljava/lang/String;

    move-result-object v4

    .line 138
    .local v4, "key":Ljava/lang/String;
    iget-object v5, p0, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->outerClassToTuples:Ljava/util/Map;

    invoke-interface {v5, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/List;

    .line 139
    .local v5, "bucket":Ljava/util/List;
    if-nez v5, :cond_2

    .line 140
    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6}, Ljava/util/ArrayList;-><init>()V

    move-object v5, v6

    .line 141
    iget-object v6, p0, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->outerClassToTuples:Ljava/util/Map;

    invoke-interface {v6, v4, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 143
    :cond_2
    invoke-interface {v5, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 117
    .end local v2    # "tuple":Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    .end local v3    # "result":Ljava/lang/Object;
    .end local v4    # "key":Ljava/lang/String;
    .end local v5    # "bucket":Ljava/util/List;
    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 126
    .restart local v2    # "tuple":Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    .restart local v3    # "result":Ljava/lang/Object;
    :cond_4
    new-instance v4, Ljava/lang/Error;

    const-string v5, "Collision detected in <thisClassString, IcTuple> mapping. There are at least two inner clases with the same name."

    invoke-direct {v4, v5}, Ljava/lang/Error;-><init>(Ljava/lang/String;)V

    throw v4

    .line 146
    .end local v1    # "index":I
    .end local v2    # "tuple":Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    .end local v3    # "result":Ljava/lang/Object;
    :cond_5
    return-void
.end method
