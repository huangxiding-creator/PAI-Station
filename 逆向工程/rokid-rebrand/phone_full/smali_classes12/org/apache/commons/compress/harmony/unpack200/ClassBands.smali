.class public Lorg/apache/commons/compress/harmony/unpack200/ClassBands;
.super Lorg/apache/commons/compress/harmony/unpack200/BandSet;
.source "ClassBands.java"


# instance fields
.field private final attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

.field private classAccessFlags:[J

.field private classAttributes:[Ljava/util/ArrayList;

.field private final classCount:I

.field private classFieldCount:[I

.field private classFlags:[J

.field private classInterfacesInts:[[I

.field private classMethodCount:[I

.field private classSuperInts:[I

.field private classThis:[Ljava/lang/String;

.field private classThisInts:[I

.field private classVersionMajor:[I

.field private classVersionMinor:[I

.field private codeAttributes:[Ljava/util/List;

.field private codeHandlerCatchPO:[[I

.field private codeHandlerClassRCN:[[I

.field private codeHandlerCount:[I

.field private codeHandlerEndPO:[[I

.field private codeHandlerStartP:[[I

.field private codeHasAttributes:[Z

.field private codeMaxNALocals:[I

.field private codeMaxStack:[I

.field private final cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

.field private fieldAccessFlags:[[J

.field private fieldAttributes:[[Ljava/util/ArrayList;

.field private fieldDescr:[[Ljava/lang/String;

.field private fieldDescrInts:[[I

.field private fieldFlags:[[J

.field private icLocal:[[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

.field private methodAccessFlags:[[J

.field private methodAttrCalls:[I

.field private methodAttributes:[[Ljava/util/ArrayList;

.field private methodDescr:[[Ljava/lang/String;

.field private methodDescrInts:[[I

.field private methodFlags:[[J

.field private final options:Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;


# direct methods
.method public constructor <init>(Lorg/apache/commons/compress/harmony/unpack200/Segment;)V
    .locals 1
    .param p1, "segment"    # Lorg/apache/commons/compress/harmony/unpack200/Segment;

    .line 123
    invoke-direct {p0, p1}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;-><init>(Lorg/apache/commons/compress/harmony/unpack200/Segment;)V

    .line 124
    invoke-virtual {p1}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getAttrDefinitionBands()Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;

    move-result-object v0

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->getAttributeDefinitionMap()Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    .line 125
    invoke-virtual {p1}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    .line 126
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->getClassCount()I

    move-result v0

    iput v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classCount:I

    .line 127
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->getOptions()Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->options:Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;

    .line 129
    return-void
.end method

.method private getCallCount([[I[[JI)I
    .locals 9
    .param p1, "methodAttrIndexes"    # [[I
    .param p2, "flags"    # [[J
    .param p3, "context"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 407
    const/4 v0, 0x0

    .line 408
    .local v0, "callCount":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p1

    if-ge v1, v2, :cond_1

    .line 409
    const/4 v2, 0x0

    .local v2, "j":I
    :goto_1
    aget-object v3, p1, v1

    array-length v3, v3

    if-ge v2, v3, :cond_0

    .line 410
    aget-object v3, p1, v1

    aget v3, v3, v2

    .line 411
    .local v3, "index":I
    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    invoke-virtual {v4, v3, p3}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(II)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v4

    .line 412
    .local v4, "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->numBackwardsCallables()I

    move-result v5

    add-int/2addr v0, v5

    .line 409
    .end local v3    # "index":I
    .end local v4    # "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 408
    .end local v2    # "j":I
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 415
    .end local v1    # "i":I
    :cond_1
    const/4 v1, 0x0

    .line 416
    .local v1, "layoutsUsed":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_2
    array-length v3, p2

    if-ge v2, v3, :cond_3

    .line 417
    const/4 v3, 0x0

    .local v3, "j":I
    :goto_3
    aget-object v4, p2, v2

    array-length v4, v4

    if-ge v3, v4, :cond_2

    .line 418
    int-to-long v4, v1

    aget-object v6, p2, v2

    aget-wide v7, v6, v3

    or-long/2addr v4, v7

    long-to-int v1, v4

    .line 417
    add-int/lit8 v3, v3, 0x1

    goto :goto_3

    .line 416
    .end local v3    # "j":I
    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 421
    .end local v2    # "i":I
    :cond_3
    const/4 v2, 0x0

    .restart local v2    # "i":I
    :goto_4
    const/16 v3, 0x1a

    if-ge v2, v3, :cond_5

    .line 422
    const/4 v3, 0x1

    shl-int/2addr v3, v2

    and-int/2addr v3, v1

    if-eqz v3, :cond_4

    .line 423
    iget-object v3, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    invoke-virtual {v3, v2, p3}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(II)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v3

    .line 424
    .local v3, "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    invoke-virtual {v3}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->numBackwardsCallables()I

    move-result v4

    add-int/2addr v0, v4

    .line 421
    .end local v3    # "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :cond_4
    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    .line 427
    .end local v2    # "i":I
    :cond_5
    return v0
.end method

.method private parseClassAttrBands(Ljava/io/InputStream;)V
    .locals 69
    .param p1, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 431
    move-object/from16 v6, p0

    move-object/from16 v7, p1

    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getCpUTF8()[Ljava/lang/String;

    move-result-object v8

    .line 432
    .local v8, "cpUTF8":[Ljava/lang/String;
    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getCpClass()[Ljava/lang/String;

    move-result-object v9

    .line 435
    .local v9, "cpClass":[Ljava/lang/String;
    iget v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classCount:I

    new-array v0, v0, [Ljava/util/ArrayList;

    iput-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classAttributes:[Ljava/util/ArrayList;

    .line 436
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classCount:I

    if-ge v0, v1, :cond_0

    .line 437
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classAttributes:[Ljava/util/ArrayList;

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    aput-object v2, v1, v0

    .line 436
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 440
    .end local v0    # "i":I
    :cond_0
    iget v3, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classCount:I

    sget-object v4, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->options:Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->hasClassFlagsHi()Z

    move-result v5

    const-string v1, "class_flags"

    move-object/from16 v0, p0

    move-object/from16 v2, p1

    invoke-virtual/range {v0 .. v5}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseFlags(Ljava/lang/String;Ljava/io/InputStream;ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;Z)[J

    move-result-object v0

    iput-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFlags:[J

    .line 441
    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFlags:[J

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countBit16([J)I

    move-result v0

    .line 442
    .local v0, "classAttrCount":I
    const-string v1, "class_attr_count"

    sget-object v2, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v1, v7, v2, v0}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v1

    .line 443
    .local v1, "classAttrCounts":[I
    const-string v2, "class_attr_indexes"

    sget-object v3, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v2, v7, v3, v1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v2

    .line 444
    .local v2, "classAttrIndexes":[[I
    iget-object v3, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFlags:[J

    filled-new-array {v3}, [[J

    move-result-object v3

    const/4 v4, 0x0

    invoke-direct {v6, v2, v3, v4}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getCallCount([[I[[JI)I

    move-result v3

    .line 445
    .local v3, "callCount":I
    const-string v5, "class_attr_calls"

    sget-object v10, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v5, v7, v10, v3}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v5

    .line 447
    .local v5, "classAttrCalls":[I
    iget-object v10, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    const-string v11, "Deprecated"

    invoke-virtual {v10, v11, v4}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v10

    .line 450
    .local v10, "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    iget-object v11, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    const-string v12, "SourceFile"

    invoke-virtual {v11, v12, v4}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v11

    .line 452
    .local v11, "sourceFileLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    iget-object v12, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFlags:[J

    invoke-static {v12, v11}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v12

    .line 453
    .local v12, "sourceFileCount":I
    const-string v13, "class_SourceFile_RUN"

    sget-object v14, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v13, v7, v14, v12}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v13

    .line 455
    .local v13, "classSourceFile":[I
    iget-object v14, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    .line 456
    const-string v15, "EnclosingMethod"

    invoke-virtual {v14, v15, v4}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v14

    .line 457
    .local v14, "enclosingMethodLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    iget-object v15, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFlags:[J

    invoke-static {v15, v14}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v15

    .line 458
    .local v15, "enclosingMethodCount":I
    const-string v4, "class_EnclosingMethod_RC"

    move/from16 v16, v0

    .end local v0    # "classAttrCount":I
    .local v16, "classAttrCount":I
    sget-object v0, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v4, v7, v0, v15}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v0

    .line 460
    .local v0, "enclosingMethodRC":[I
    const-string v4, "class_EnclosingMethod_RDN"

    move-object/from16 v17, v1

    .end local v1    # "classAttrCounts":[I
    .local v17, "classAttrCounts":[I
    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v4, v7, v1, v15}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v1

    .line 463
    .local v1, "enclosingMethodRDN":[I
    iget-object v4, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    move-object/from16 v18, v2

    .end local v2    # "classAttrIndexes":[[I
    .local v18, "classAttrIndexes":[[I
    const-string v2, "Signature"

    move/from16 v19, v3

    const/4 v3, 0x0

    .end local v3    # "callCount":I
    .local v19, "callCount":I
    invoke-virtual {v4, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v2

    .line 465
    .local v2, "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    iget-object v3, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFlags:[J

    invoke-static {v3, v2}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v3

    .line 466
    .local v3, "signatureCount":I
    const-string v4, "class_Signature_RS"

    move/from16 v20, v12

    .end local v12    # "sourceFileCount":I
    .local v20, "sourceFileCount":I
    sget-object v12, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v4, v7, v12, v3}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v4

    .line 468
    .local v4, "classSignature":[I
    invoke-direct {v6, v7, v5}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseClassMetadataBands(Ljava/io/InputStream;[I)I

    move-result v12

    .line 470
    .local v12, "backwardsCallsUsed":I
    move/from16 v21, v3

    .end local v3    # "signatureCount":I
    .local v21, "signatureCount":I
    iget-object v3, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    move/from16 v22, v15

    .end local v15    # "enclosingMethodCount":I
    .local v22, "enclosingMethodCount":I
    const-string v15, "InnerClasses"

    move-object/from16 v23, v8

    const/4 v8, 0x0

    .end local v8    # "cpUTF8":[Ljava/lang/String;
    .local v23, "cpUTF8":[Ljava/lang/String;
    invoke-virtual {v3, v15, v8}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v3

    .line 472
    .local v3, "innerClassLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    iget-object v8, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFlags:[J

    invoke-static {v8, v3}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v8

    .line 473
    .local v8, "innerClassCount":I
    const-string v15, "class_InnerClasses_N"

    move-object/from16 v24, v9

    .end local v9    # "cpClass":[Ljava/lang/String;
    .local v24, "cpClass":[Ljava/lang/String;
    sget-object v9, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v15, v7, v9, v8}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v9

    .line 474
    .local v9, "classInnerClassesN":[I
    const-string v15, "class_InnerClasses_RC"

    move/from16 v25, v8

    .end local v8    # "innerClassCount":I
    .local v25, "innerClassCount":I
    sget-object v8, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v15, v7, v8, v9}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v8

    .line 476
    .local v8, "classInnerClassesRC":[[I
    const-string v15, "class_InnerClasses_F"

    move-object/from16 v26, v8

    .end local v8    # "classInnerClassesRC":[[I
    .local v26, "classInnerClassesRC":[[I
    sget-object v8, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v15, v7, v8, v9}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v8

    .line 478
    .local v8, "classInnerClassesF":[[I
    const/4 v15, 0x0

    .line 479
    .local v15, "flagsCount":I
    const/16 v27, 0x0

    move/from16 v68, v27

    move-object/from16 v27, v9

    move/from16 v9, v68

    .local v9, "i":I
    .local v27, "classInnerClassesN":[I
    :goto_1
    move-object/from16 v28, v3

    .end local v3    # "innerClassLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v28, "innerClassLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    array-length v3, v8

    if-ge v9, v3, :cond_3

    .line 480
    const/4 v3, 0x0

    .local v3, "j":I
    :goto_2
    move-object/from16 v29, v4

    .end local v4    # "classSignature":[I
    .local v29, "classSignature":[I
    aget-object v4, v8, v9

    array-length v4, v4

    if-ge v3, v4, :cond_2

    .line 481
    aget-object v4, v8, v9

    aget v4, v4, v3

    if-eqz v4, :cond_1

    .line 482
    add-int/lit8 v15, v15, 0x1

    .line 480
    :cond_1
    add-int/lit8 v3, v3, 0x1

    move-object/from16 v4, v29

    goto :goto_2

    .line 479
    .end local v3    # "j":I
    :cond_2
    add-int/lit8 v9, v9, 0x1

    move-object/from16 v3, v28

    move-object/from16 v4, v29

    goto :goto_1

    .end local v29    # "classSignature":[I
    .restart local v4    # "classSignature":[I
    :cond_3
    move-object/from16 v29, v4

    .line 486
    .end local v4    # "classSignature":[I
    .end local v9    # "i":I
    .restart local v29    # "classSignature":[I
    const-string v3, "class_InnerClasses_outer_RCN"

    sget-object v4, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v3, v7, v4, v15}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v3

    .line 488
    .local v3, "classInnerClassesOuterRCN":[I
    const-string v4, "class_InnerClasses_name_RUN"

    sget-object v9, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v4, v7, v9, v15}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v4

    .line 491
    .local v4, "classInnerClassesNameRUN":[I
    iget-object v9, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    move/from16 v30, v15

    .end local v15    # "flagsCount":I
    .local v30, "flagsCount":I
    const-string v15, "class-file version"

    move-object/from16 v31, v4

    const/4 v4, 0x0

    .end local v4    # "classInnerClassesNameRUN":[I
    .local v31, "classInnerClassesNameRUN":[I
    invoke-virtual {v9, v15, v4}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v9

    .line 493
    .local v9, "versionLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    iget-object v4, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFlags:[J

    invoke-static {v4, v9}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v4

    .line 494
    .local v4, "versionCount":I
    const-string v15, "class_file_version_minor_H"

    move-object/from16 v32, v9

    .end local v9    # "versionLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v32, "versionLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    sget-object v9, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v15, v7, v9, v4}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v9

    .line 496
    .local v9, "classFileVersionMinorH":[I
    const-string v15, "class_file_version_major_H"

    move-object/from16 v33, v9

    .end local v9    # "classFileVersionMinorH":[I
    .local v33, "classFileVersionMinorH":[I
    sget-object v9, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v15, v7, v9, v4}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v9

    .line 498
    .local v9, "classFileVersionMajorH":[I
    if-lez v4, :cond_4

    .line 499
    iget v15, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classCount:I

    new-array v15, v15, [I

    iput-object v15, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classVersionMajor:[I

    .line 500
    iget v15, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classCount:I

    new-array v15, v15, [I

    iput-object v15, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classVersionMinor:[I

    .line 502
    :cond_4
    iget-object v15, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    invoke-virtual {v15}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->getDefaultClassMajorVersion()I

    move-result v15

    .line 503
    .local v15, "defaultVersionMajor":I
    move/from16 v34, v4

    .end local v4    # "versionCount":I
    .local v34, "versionCount":I
    iget-object v4, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->getDefaultClassMinorVersion()I

    move-result v4

    .line 506
    .local v4, "defaultVersionMinor":I
    move/from16 v35, v12

    .line 507
    .local v35, "backwardsCallIndex":I
    move/from16 v36, v12

    .end local v12    # "backwardsCallsUsed":I
    .local v36, "backwardsCallsUsed":I
    iget-object v12, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->options:Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;

    invoke-virtual {v12}, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->hasClassFlagsHi()Z

    move-result v12

    if-eqz v12, :cond_5

    const/16 v12, 0x3e

    goto :goto_3

    :cond_5
    const/16 v12, 0x1f

    .line 508
    .local v12, "limit":I
    :goto_3
    move/from16 v37, v4

    .end local v4    # "defaultVersionMinor":I
    .local v37, "defaultVersionMinor":I
    add-int/lit8 v4, v12, 0x1

    new-array v4, v4, [Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    .line 509
    .local v4, "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    move/from16 v38, v15

    .end local v15    # "defaultVersionMajor":I
    .local v38, "defaultVersionMajor":I
    add-int/lit8 v15, v12, 0x1

    new-array v15, v15, [I

    .line 510
    .local v15, "counts":[I
    move-object/from16 v39, v9

    .end local v9    # "classFileVersionMajorH":[I
    .local v39, "classFileVersionMajorH":[I
    add-int/lit8 v9, v12, 0x1

    new-array v9, v9, [Ljava/util/List;

    .line 511
    .local v9, "otherAttributes":[Ljava/util/List;
    const/16 v40, 0x0

    move-object/from16 v41, v3

    move/from16 v3, v40

    .local v3, "i":I
    .local v41, "classInnerClassesOuterRCN":[I
    :goto_4
    if-ge v3, v12, :cond_7

    .line 512
    move/from16 v40, v12

    .end local v12    # "limit":I
    .local v40, "limit":I
    iget-object v12, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    move-object/from16 v42, v8

    const/4 v8, 0x0

    .end local v8    # "classInnerClassesF":[[I
    .local v42, "classInnerClassesF":[[I
    invoke-virtual {v12, v3, v8}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(II)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v12

    .line 513
    .local v12, "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    if-eqz v12, :cond_6

    invoke-virtual {v12}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->isDefaultLayout()Z

    move-result v8

    if-nez v8, :cond_6

    .line 514
    aput-object v12, v4, v3

    .line 515
    iget-object v8, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFlags:[J

    invoke-static {v8, v12}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v8

    aput v8, v15, v3

    .line 511
    .end local v12    # "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :cond_6
    add-int/lit8 v3, v3, 0x1

    move/from16 v12, v40

    move-object/from16 v8, v42

    goto :goto_4

    .end local v40    # "limit":I
    .end local v42    # "classInnerClassesF":[[I
    .restart local v8    # "classInnerClassesF":[[I
    .local v12, "limit":I
    :cond_7
    move-object/from16 v42, v8

    move/from16 v40, v12

    .line 518
    .end local v3    # "i":I
    .end local v8    # "classInnerClassesF":[[I
    .end local v12    # "limit":I
    .restart local v40    # "limit":I
    .restart local v42    # "classInnerClassesF":[[I
    const/4 v3, 0x0

    move/from16 v8, v35

    .end local v35    # "backwardsCallIndex":I
    .restart local v3    # "i":I
    .local v8, "backwardsCallIndex":I
    :goto_5
    array-length v12, v15

    if-ge v3, v12, :cond_a

    .line 519
    aget v12, v15, v3

    if-lez v12, :cond_9

    .line 520
    iget-object v12, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    move-object/from16 v35, v2

    .end local v2    # "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v35, "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    aget-object v2, v4, v3

    invoke-virtual {v12, v2}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeBands(Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;)Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;

    move-result-object v2

    .line 521
    .local v2, "bands":Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;
    aget v12, v15, v3

    invoke-virtual {v2, v7, v12}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;->parseAttributes(Ljava/io/InputStream;I)Ljava/util/List;

    move-result-object v12

    aput-object v12, v9, v3

    .line 522
    aget-object v12, v4, v3

    invoke-virtual {v12}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->numBackwardsCallables()I

    move-result v12

    .line 523
    .local v12, "numBackwardsCallables":I
    if-lez v12, :cond_8

    .line 524
    new-array v7, v12, [I

    .line 525
    .local v7, "backwardsCalls":[I
    move-object/from16 v43, v15

    const/4 v15, 0x0

    .end local v15    # "counts":[I
    .local v43, "counts":[I
    invoke-static {v5, v8, v7, v15, v12}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 526
    invoke-virtual {v2, v7}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;->setBackwardsCalls([I)V

    .line 527
    add-int/2addr v8, v12

    goto :goto_6

    .line 523
    .end local v7    # "backwardsCalls":[I
    .end local v43    # "counts":[I
    .restart local v15    # "counts":[I
    :cond_8
    move-object/from16 v43, v15

    .end local v15    # "counts":[I
    .restart local v43    # "counts":[I
    goto :goto_6

    .line 519
    .end local v12    # "numBackwardsCallables":I
    .end local v35    # "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v43    # "counts":[I
    .local v2, "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v15    # "counts":[I
    :cond_9
    move-object/from16 v35, v2

    move-object/from16 v43, v15

    .line 518
    .end local v2    # "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v15    # "counts":[I
    .restart local v35    # "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v43    # "counts":[I
    :goto_6
    add-int/lit8 v3, v3, 0x1

    move-object/from16 v7, p1

    move-object/from16 v2, v35

    move-object/from16 v15, v43

    goto :goto_5

    .end local v35    # "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v43    # "counts":[I
    .restart local v2    # "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v15    # "counts":[I
    :cond_a
    move-object/from16 v35, v2

    move-object/from16 v43, v15

    .line 533
    .end local v2    # "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v3    # "i":I
    .end local v15    # "counts":[I
    .restart local v35    # "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v43    # "counts":[I
    const/4 v2, 0x0

    .line 534
    .local v2, "sourceFileIndex":I
    const/4 v3, 0x0

    .line 535
    .local v3, "enclosingMethodIndex":I
    const/4 v7, 0x0

    .line 536
    .local v7, "signatureIndex":I
    const/4 v12, 0x0

    .line 537
    .local v12, "innerClassIndex":I
    const/4 v15, 0x0

    .line 538
    .local v15, "innerClassC2NIndex":I
    const/16 v44, 0x0

    .line 539
    .local v44, "versionIndex":I
    move/from16 v45, v2

    .end local v2    # "sourceFileIndex":I
    .local v45, "sourceFileIndex":I
    iget v2, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classCount:I

    new-array v2, v2, [[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    iput-object v2, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->icLocal:[[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    .line 540
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_7
    move-object/from16 v46, v5

    .end local v5    # "classAttrCalls":[I
    .local v46, "classAttrCalls":[I
    iget v5, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classCount:I

    if-ge v2, v5, :cond_1d

    .line 541
    iget-object v5, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFlags:[J

    move/from16 v48, v8

    move-object/from16 v47, v9

    .end local v8    # "backwardsCallIndex":I
    .end local v9    # "otherAttributes":[Ljava/util/List;
    .local v47, "otherAttributes":[Ljava/util/List;
    .local v48, "backwardsCallIndex":I
    aget-wide v8, v5, v2

    .line 542
    .local v8, "flag":J
    iget-object v5, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFlags:[J

    move-object/from16 v49, v4

    .end local v4    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v49, "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    aget-wide v4, v5, v2

    invoke-virtual {v10, v4, v5}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v4

    if-eqz v4, :cond_b

    .line 543
    iget-object v4, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classAttributes:[Ljava/util/ArrayList;

    aget-object v4, v4, v2

    new-instance v5, Lorg/apache/commons/compress/harmony/unpack200/bytecode/DeprecatedAttribute;

    invoke-direct {v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/DeprecatedAttribute;-><init>()V

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 545
    :cond_b
    invoke-virtual {v11, v8, v9}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v4

    if-eqz v4, :cond_10

    .line 546
    aget v4, v13, v45

    move/from16 v51, v12

    move-object/from16 v50, v13

    .end local v12    # "innerClassIndex":I
    .end local v13    # "classSourceFile":[I
    .local v50, "classSourceFile":[I
    .local v51, "innerClassIndex":I
    int-to-long v12, v4

    .line 547
    .local v12, "result":J
    iget-object v4, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getConstantPool()Lorg/apache/commons/compress/harmony/unpack200/SegmentConstantPool;

    move-result-object v4

    invoke-virtual {v11, v12, v13, v4}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->getValue(JLorg/apache/commons/compress/harmony/unpack200/SegmentConstantPool;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;

    move-result-object v4

    .line 548
    .local v4, "value":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    if-nez v4, :cond_f

    .line 550
    iget-object v5, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classThis:[Ljava/lang/String;

    aget-object v5, v5, v2

    move-object/from16 v53, v4

    .end local v4    # "value":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .local v53, "value":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    iget-object v4, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classThis:[Ljava/lang/String;

    aget-object v4, v4, v2

    move-object/from16 v54, v10

    .end local v10    # "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v54, "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    const/16 v10, 0x2f

    invoke-virtual {v4, v10}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v4

    const/4 v10, 0x1

    add-int/2addr v4, v10

    invoke-virtual {v5, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    .line 551
    .local v4, "className":Ljava/lang/String;
    const/16 v5, 0x2e

    invoke-virtual {v4, v5}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v5

    add-int/2addr v5, v10

    invoke-virtual {v4, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    .line 554
    invoke-virtual {v4}, Ljava/lang/String;->toCharArray()[C

    move-result-object v5

    .line 555
    .local v5, "chars":[C
    const/4 v10, -0x1

    .line 556
    .local v10, "index":I
    const/16 v55, 0x0

    move/from16 v56, v10

    move/from16 v10, v55

    .local v10, "j":I
    .local v56, "index":I
    :goto_8
    move-object/from16 v55, v11

    .end local v11    # "sourceFileLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v55, "sourceFileLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    array-length v11, v5

    if-ge v10, v11, :cond_d

    .line 557
    aget-char v11, v5, v10

    move-object/from16 v57, v5

    .end local v5    # "chars":[C
    .local v57, "chars":[C
    const/16 v5, 0x2d

    if-gt v11, v5, :cond_c

    .line 558
    move v5, v10

    .line 559
    .end local v56    # "index":I
    .local v5, "index":I
    goto :goto_9

    .line 556
    .end local v5    # "index":I
    .restart local v56    # "index":I
    :cond_c
    add-int/lit8 v10, v10, 0x1

    move-object/from16 v11, v55

    move-object/from16 v5, v57

    goto :goto_8

    .end local v57    # "chars":[C
    .local v5, "chars":[C
    :cond_d
    move-object/from16 v57, v5

    .end local v5    # "chars":[C
    .restart local v57    # "chars":[C
    move/from16 v10, v56

    .line 562
    .end local v56    # "index":I
    .local v10, "index":I
    :goto_9
    const/4 v5, -0x1

    if-le v10, v5, :cond_e

    .line 563
    const/4 v5, 0x0

    invoke-virtual {v4, v5, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    .line 566
    :cond_e
    iget-object v5, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    move-object/from16 v56, v4

    .end local v4    # "className":Ljava/lang/String;
    .local v56, "className":Ljava/lang/String;
    const-string v4, ".java"

    invoke-virtual {v11, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    const/4 v11, 0x1

    invoke-virtual {v5, v4, v11}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(Ljava/lang/String;Z)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v4

    .end local v53    # "value":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .local v4, "value":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    goto :goto_a

    .line 548
    .end local v54    # "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v55    # "sourceFileLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v56    # "className":Ljava/lang/String;
    .end local v57    # "chars":[C
    .local v10, "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v11    # "sourceFileLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :cond_f
    move-object/from16 v53, v4

    move-object/from16 v54, v10

    move-object/from16 v55, v11

    .line 568
    .end local v10    # "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v11    # "sourceFileLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v54    # "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v55    # "sourceFileLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :goto_a
    iget-object v5, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classAttributes:[Ljava/util/ArrayList;

    aget-object v5, v5, v2

    new-instance v10, Lorg/apache/commons/compress/harmony/unpack200/bytecode/SourceFileAttribute;

    move-object v11, v4

    check-cast v11, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    invoke-direct {v10, v11}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/SourceFileAttribute;-><init>(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;)V

    invoke-virtual {v5, v10}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 569
    add-int/lit8 v45, v45, 0x1

    goto :goto_b

    .line 545
    .end local v4    # "value":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .end local v50    # "classSourceFile":[I
    .end local v51    # "innerClassIndex":I
    .end local v54    # "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v55    # "sourceFileLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v10    # "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v11    # "sourceFileLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v12, "innerClassIndex":I
    .restart local v13    # "classSourceFile":[I
    :cond_10
    move-object/from16 v54, v10

    move-object/from16 v55, v11

    move/from16 v51, v12

    move-object/from16 v50, v13

    .line 571
    .end local v10    # "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v11    # "sourceFileLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v12    # "innerClassIndex":I
    .end local v13    # "classSourceFile":[I
    .restart local v50    # "classSourceFile":[I
    .restart local v51    # "innerClassIndex":I
    .restart local v54    # "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v55    # "sourceFileLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :goto_b
    invoke-virtual {v14, v8, v9}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v4

    if-eqz v4, :cond_12

    .line 572
    iget-object v4, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    aget v5, v0, v3

    invoke-virtual {v4, v5}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpClassValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;

    move-result-object v4

    .line 573
    .local v4, "theClass":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;
    const/4 v5, 0x0

    .line 574
    .local v5, "theMethod":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPNameAndType;
    aget v10, v1, v3

    if-eqz v10, :cond_11

    .line 575
    iget-object v10, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    aget v11, v1, v3

    const/4 v12, 0x1

    sub-int/2addr v11, v12

    invoke-virtual {v10, v11}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpNameAndTypeValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPNameAndType;

    move-result-object v5

    .line 577
    :cond_11
    iget-object v10, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classAttributes:[Ljava/util/ArrayList;

    aget-object v10, v10, v2

    new-instance v11, Lorg/apache/commons/compress/harmony/unpack200/bytecode/EnclosingMethodAttribute;

    invoke-direct {v11, v4, v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/EnclosingMethodAttribute;-><init>(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPNameAndType;)V

    invoke-virtual {v10, v11}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 578
    add-int/lit8 v3, v3, 0x1

    .line 580
    .end local v4    # "theClass":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;
    .end local v5    # "theMethod":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPNameAndType;
    :cond_12
    move-object/from16 v4, v35

    .end local v35    # "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v4, "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    invoke-virtual {v4, v8, v9}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v5

    if-eqz v5, :cond_13

    .line 581
    aget v5, v29, v7

    int-to-long v10, v5

    .line 582
    .local v10, "result":J
    iget-object v5, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v5}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getConstantPool()Lorg/apache/commons/compress/harmony/unpack200/SegmentConstantPool;

    move-result-object v5

    invoke-virtual {v4, v10, v11, v5}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->getValue(JLorg/apache/commons/compress/harmony/unpack200/SegmentConstantPool;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;

    move-result-object v5

    check-cast v5, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    .line 583
    .local v5, "value":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    iget-object v12, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classAttributes:[Ljava/util/ArrayList;

    aget-object v12, v12, v2

    new-instance v13, Lorg/apache/commons/compress/harmony/unpack200/bytecode/SignatureAttribute;

    invoke-direct {v13, v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/SignatureAttribute;-><init>(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;)V

    invoke-virtual {v12, v13}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 584
    add-int/lit8 v7, v7, 0x1

    .line 586
    .end local v5    # "value":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    .end local v10    # "result":J
    :cond_13
    move-object/from16 v5, v28

    .end local v28    # "innerClassLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v5, "innerClassLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    invoke-virtual {v5, v8, v9}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v10

    if-eqz v10, :cond_18

    .line 589
    iget-object v10, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->icLocal:[[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    aget v11, v27, v51

    new-array v11, v11, [Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    aput-object v11, v10, v2

    .line 590
    const/4 v10, 0x0

    .local v10, "j":I
    :goto_c
    iget-object v11, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->icLocal:[[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    aget-object v11, v11, v2

    array-length v11, v11

    if-ge v10, v11, :cond_17

    .line 591
    aget-object v11, v26, v51

    aget v11, v11, v10

    .line 592
    .local v11, "icTupleCIndex":I
    const/4 v12, -0x1

    .line 593
    .local v12, "icTupleC2Index":I
    const/4 v13, -0x1

    .line 595
    .local v13, "icTupleNIndex":I
    move-object/from16 v28, v0

    .end local v0    # "enclosingMethodRC":[I
    .local v28, "enclosingMethodRC":[I
    aget-object v0, v24, v11

    .line 596
    .local v0, "icTupleC":Ljava/lang/String;
    aget-object v35, v42, v51

    aget v35, v35, v10

    .line 597
    .local v35, "icTupleF":I
    const/16 v52, 0x0

    .line 598
    .local v52, "icTupleC2":Ljava/lang/String;
    const/16 v53, 0x0

    .line 600
    .local v53, "icTupleN":Ljava/lang/String;
    if-eqz v35, :cond_14

    .line 601
    aget v12, v41, v15

    .line 602
    aget v13, v31, v15

    .line 603
    aget-object v52, v24, v12

    .line 604
    aget-object v53, v23, v13

    .line 605
    add-int/lit8 v15, v15, 0x1

    move-object/from16 v65, v1

    move/from16 v66, v3

    move-object/from16 v67, v4

    goto :goto_e

    .line 608
    :cond_14
    move-object/from16 v65, v1

    .end local v1    # "enclosingMethodRDN":[I
    .local v65, "enclosingMethodRDN":[I
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getIcBands()Lorg/apache/commons/compress/harmony/unpack200/IcBands;

    move-result-object v1

    .line 609
    .local v1, "icBands":Lorg/apache/commons/compress/harmony/unpack200/IcBands;
    move/from16 v66, v3

    .end local v3    # "enclosingMethodIndex":I
    .local v66, "enclosingMethodIndex":I
    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->getIcTuples()[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    move-result-object v3

    .line 610
    .local v3, "icAll":[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    const/16 v56, 0x0

    move-object/from16 v57, v1

    move/from16 v1, v56

    .local v1, "k":I
    .local v57, "icBands":Lorg/apache/commons/compress/harmony/unpack200/IcBands;
    :goto_d
    move-object/from16 v67, v4

    .end local v4    # "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v67, "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    array-length v4, v3

    if-ge v1, v4, :cond_16

    .line 611
    aget-object v4, v3, v1

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->getC()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_15

    .line 612
    aget-object v4, v3, v1

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->getF()I

    move-result v35

    .line 613
    aget-object v4, v3, v1

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->getC2()Ljava/lang/String;

    move-result-object v52

    .line 614
    aget-object v4, v3, v1

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->getN()Ljava/lang/String;

    move-result-object v53

    .line 615
    goto :goto_e

    .line 610
    :cond_15
    add-int/lit8 v1, v1, 0x1

    move-object/from16 v4, v67

    goto :goto_d

    .line 620
    .end local v1    # "k":I
    .end local v3    # "icAll":[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    .end local v57    # "icBands":Lorg/apache/commons/compress/harmony/unpack200/IcBands;
    :cond_16
    :goto_e
    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    move-object/from16 v56, v1

    move-object/from16 v57, v0

    move/from16 v58, v35

    move-object/from16 v59, v52

    move-object/from16 v60, v53

    move/from16 v61, v11

    move/from16 v62, v12

    move/from16 v63, v13

    move/from16 v64, v10

    invoke-direct/range {v56 .. v64}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;IIII)V

    .line 622
    .local v1, "icTuple":Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    iget-object v3, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->icLocal:[[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    aget-object v3, v3, v2

    aput-object v1, v3, v10

    .line 590
    .end local v0    # "icTupleC":Ljava/lang/String;
    .end local v1    # "icTuple":Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    .end local v11    # "icTupleCIndex":I
    .end local v12    # "icTupleC2Index":I
    .end local v13    # "icTupleNIndex":I
    .end local v35    # "icTupleF":I
    .end local v52    # "icTupleC2":Ljava/lang/String;
    .end local v53    # "icTupleN":Ljava/lang/String;
    add-int/lit8 v10, v10, 0x1

    move-object/from16 v0, v28

    move-object/from16 v1, v65

    move/from16 v3, v66

    move-object/from16 v4, v67

    goto/16 :goto_c

    .end local v28    # "enclosingMethodRC":[I
    .end local v65    # "enclosingMethodRDN":[I
    .end local v66    # "enclosingMethodIndex":I
    .end local v67    # "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v0, "enclosingMethodRC":[I
    .local v1, "enclosingMethodRDN":[I
    .local v3, "enclosingMethodIndex":I
    .restart local v4    # "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :cond_17
    move-object/from16 v28, v0

    move-object/from16 v65, v1

    move/from16 v66, v3

    move-object/from16 v67, v4

    .line 624
    .end local v0    # "enclosingMethodRC":[I
    .end local v1    # "enclosingMethodRDN":[I
    .end local v3    # "enclosingMethodIndex":I
    .end local v4    # "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v10    # "j":I
    .restart local v28    # "enclosingMethodRC":[I
    .restart local v65    # "enclosingMethodRDN":[I
    .restart local v66    # "enclosingMethodIndex":I
    .restart local v67    # "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    add-int/lit8 v12, v51, 0x1

    .end local v51    # "innerClassIndex":I
    .local v12, "innerClassIndex":I
    goto :goto_f

    .line 586
    .end local v12    # "innerClassIndex":I
    .end local v28    # "enclosingMethodRC":[I
    .end local v65    # "enclosingMethodRDN":[I
    .end local v66    # "enclosingMethodIndex":I
    .end local v67    # "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v0    # "enclosingMethodRC":[I
    .restart local v1    # "enclosingMethodRDN":[I
    .restart local v3    # "enclosingMethodIndex":I
    .restart local v4    # "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v51    # "innerClassIndex":I
    :cond_18
    move-object/from16 v28, v0

    move-object/from16 v65, v1

    move/from16 v66, v3

    move-object/from16 v67, v4

    .end local v0    # "enclosingMethodRC":[I
    .end local v1    # "enclosingMethodRDN":[I
    .end local v3    # "enclosingMethodIndex":I
    .end local v4    # "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v28    # "enclosingMethodRC":[I
    .restart local v65    # "enclosingMethodRDN":[I
    .restart local v66    # "enclosingMethodIndex":I
    .restart local v67    # "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    move/from16 v12, v51

    .line 626
    .end local v51    # "innerClassIndex":I
    .restart local v12    # "innerClassIndex":I
    :goto_f
    move-object/from16 v0, v32

    .end local v32    # "versionLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v0, "versionLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    invoke-virtual {v0, v8, v9}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v1

    if-eqz v1, :cond_19

    .line 627
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classVersionMajor:[I

    aget v3, v39, v44

    aput v3, v1, v2

    .line 628
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classVersionMinor:[I

    aget v3, v33, v44

    aput v3, v1, v2

    .line 629
    add-int/lit8 v44, v44, 0x1

    goto :goto_10

    .line 630
    :cond_19
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classVersionMajor:[I

    if-eqz v1, :cond_1a

    .line 632
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classVersionMajor:[I

    aput v38, v1, v2

    .line 633
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classVersionMinor:[I

    aput v37, v1, v2

    .line 636
    :cond_1a
    :goto_10
    const/4 v1, 0x0

    .local v1, "j":I
    :goto_11
    move-object/from16 v4, v49

    .end local v49    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v4, "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    array-length v3, v4

    if-ge v1, v3, :cond_1c

    .line 637
    aget-object v3, v4, v1

    if-eqz v3, :cond_1b

    aget-object v3, v4, v1

    invoke-virtual {v3, v8, v9}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v3

    if-eqz v3, :cond_1b

    .line 639
    iget-object v3, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classAttributes:[Ljava/util/ArrayList;

    aget-object v3, v3, v2

    aget-object v10, v47, v1

    const/4 v11, 0x0

    invoke-interface {v10, v11}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v10

    invoke-virtual {v3, v10}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 640
    aget-object v3, v47, v1

    invoke-interface {v3, v11}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    goto :goto_12

    .line 637
    :cond_1b
    const/4 v11, 0x0

    .line 636
    :goto_12
    add-int/lit8 v1, v1, 0x1

    move-object/from16 v49, v4

    goto :goto_11

    :cond_1c
    const/4 v11, 0x0

    .line 540
    .end local v1    # "j":I
    .end local v8    # "flag":J
    add-int/lit8 v2, v2, 0x1

    move-object/from16 v32, v0

    move-object/from16 v0, v28

    move-object/from16 v9, v47

    move/from16 v8, v48

    move-object/from16 v13, v50

    move-object/from16 v10, v54

    move-object/from16 v11, v55

    move-object/from16 v1, v65

    move/from16 v3, v66

    move-object/from16 v35, v67

    move-object/from16 v28, v5

    move-object/from16 v5, v46

    goto/16 :goto_7

    .line 644
    .end local v2    # "i":I
    .end local v5    # "innerClassLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v47    # "otherAttributes":[Ljava/util/List;
    .end local v48    # "backwardsCallIndex":I
    .end local v50    # "classSourceFile":[I
    .end local v54    # "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v55    # "sourceFileLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v65    # "enclosingMethodRDN":[I
    .end local v66    # "enclosingMethodIndex":I
    .end local v67    # "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v0, "enclosingMethodRC":[I
    .local v1, "enclosingMethodRDN":[I
    .restart local v3    # "enclosingMethodIndex":I
    .local v8, "backwardsCallIndex":I
    .restart local v9    # "otherAttributes":[Ljava/util/List;
    .local v10, "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v11, "sourceFileLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v13, "classSourceFile":[I
    .local v28, "innerClassLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v32    # "versionLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v35, "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :cond_1d
    return-void
.end method

.method private parseClassMetadataBands(Ljava/io/InputStream;[I)I
    .locals 18
    .param p1, "in"    # Ljava/io/InputStream;
    .param p2, "classAttrCalls"    # [I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;,
            Ljava/io/IOException;
        }
    .end annotation

    .line 1041
    move-object/from16 v6, p0

    const/4 v0, 0x0

    .line 1042
    .local v0, "numBackwardsCalls":I
    const/4 v1, 0x2

    new-array v2, v1, [Ljava/lang/String;

    const-string v1, "RVA"

    const/4 v7, 0x0

    aput-object v1, v2, v7

    const-string v1, "RIA"

    const/4 v8, 0x1

    aput-object v1, v2, v8

    .line 1044
    .local v2, "RxA":[Ljava/lang/String;
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    .line 1045
    const-string v3, "RuntimeVisibleAnnotations"

    invoke-virtual {v1, v3, v7}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v9

    .line 1046
    .local v9, "rvaLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    .line 1047
    const-string v3, "RuntimeInvisibleAnnotations"

    invoke-virtual {v1, v3, v7}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v10

    .line 1048
    .local v10, "riaLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFlags:[J

    invoke-static {v1, v9}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v11

    .line 1049
    .local v11, "rvaCount":I
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFlags:[J

    invoke-static {v1, v10}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v12

    .line 1050
    .local v12, "riaCount":I
    filled-new-array {v11, v12}, [I

    move-result-object v3

    .line 1051
    .local v3, "RxACount":[I
    filled-new-array {v7, v7}, [I

    move-result-object v1

    move-object v13, v1

    .line 1052
    .local v13, "backwardsCalls":[I
    if-lez v11, :cond_1

    .line 1053
    add-int/lit8 v0, v0, 0x1

    .line 1054
    aget v1, p2, v7

    aput v1, v13, v7

    .line 1055
    if-lez v12, :cond_0

    .line 1056
    add-int/lit8 v0, v0, 0x1

    .line 1057
    aget v1, p2, v8

    aput v1, v13, v8

    move v14, v0

    goto :goto_0

    .line 1055
    :cond_0
    move v14, v0

    goto :goto_0

    .line 1059
    :cond_1
    if-lez v12, :cond_2

    .line 1060
    add-int/lit8 v0, v0, 0x1

    .line 1061
    aget v1, p2, v7

    aput v1, v13, v8

    move v14, v0

    goto :goto_0

    .line 1059
    :cond_2
    move v14, v0

    .line 1063
    .end local v0    # "numBackwardsCalls":I
    .local v14, "numBackwardsCalls":I
    :goto_0
    const-string v5, "class"

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object v4, v13

    invoke-direct/range {v0 .. v5}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseMetadata(Ljava/io/InputStream;[Ljava/lang/String;[I[ILjava/lang/String;)[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;

    move-result-object v0

    .line 1064
    .local v0, "mbgs":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    aget-object v1, v0, v7

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->getAttributes()Ljava/util/List;

    move-result-object v1

    .line 1065
    .local v1, "rvaAttributes":Ljava/util/List;
    aget-object v4, v0, v8

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->getAttributes()Ljava/util/List;

    move-result-object v4

    .line 1066
    .local v4, "riaAttributes":Ljava/util/List;
    const/4 v5, 0x0

    .line 1067
    .local v5, "rvaAttributesIndex":I
    const/4 v7, 0x0

    .line 1068
    .local v7, "riaAttributesIndex":I
    const/4 v8, 0x0

    .local v8, "i":I
    :goto_1
    iget-object v15, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFlags:[J

    array-length v15, v15

    if-ge v8, v15, :cond_5

    .line 1069
    iget-object v15, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFlags:[J

    move-object/from16 v16, v2

    move-object/from16 v17, v3

    .end local v2    # "RxA":[Ljava/lang/String;
    .end local v3    # "RxACount":[I
    .local v16, "RxA":[Ljava/lang/String;
    .local v17, "RxACount":[I
    aget-wide v2, v15, v8

    invoke-virtual {v9, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 1070
    iget-object v2, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classAttributes:[Ljava/util/ArrayList;

    aget-object v2, v2, v8

    add-int/lit8 v3, v5, 0x1

    .end local v5    # "rvaAttributesIndex":I
    .local v3, "rvaAttributesIndex":I
    invoke-interface {v1, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v2, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move v5, v3

    .line 1072
    .end local v3    # "rvaAttributesIndex":I
    .restart local v5    # "rvaAttributesIndex":I
    :cond_3
    iget-object v2, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFlags:[J

    move-object v3, v0

    move-object v15, v1

    .end local v0    # "mbgs":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    .end local v1    # "rvaAttributes":Ljava/util/List;
    .local v3, "mbgs":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    .local v15, "rvaAttributes":Ljava/util/List;
    aget-wide v0, v2, v8

    invoke-virtual {v10, v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 1073
    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classAttributes:[Ljava/util/ArrayList;

    aget-object v0, v0, v8

    add-int/lit8 v1, v7, 0x1

    .end local v7    # "riaAttributesIndex":I
    .local v1, "riaAttributesIndex":I
    invoke-interface {v4, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move v7, v1

    .line 1068
    .end local v1    # "riaAttributesIndex":I
    .restart local v7    # "riaAttributesIndex":I
    :cond_4
    add-int/lit8 v8, v8, 0x1

    move-object v0, v3

    move-object v1, v15

    move-object/from16 v2, v16

    move-object/from16 v3, v17

    goto :goto_1

    .line 1076
    .end local v8    # "i":I
    .end local v15    # "rvaAttributes":Ljava/util/List;
    .end local v16    # "RxA":[Ljava/lang/String;
    .end local v17    # "RxACount":[I
    .restart local v0    # "mbgs":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    .local v1, "rvaAttributes":Ljava/util/List;
    .restart local v2    # "RxA":[Ljava/lang/String;
    .local v3, "RxACount":[I
    :cond_5
    return v14
.end method

.method private parseCodeAttrBands(Ljava/io/InputStream;I)V
    .locals 49
    .param p1, "in"    # Ljava/io/InputStream;
    .param p2, "codeFlagsCount"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 718
    move-object/from16 v6, p0

    move-object/from16 v7, p1

    sget-object v4, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    .line 719
    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getSegmentHeader()Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    move-result-object v0

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->getOptions()Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;

    move-result-object v0

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->hasCodeFlagsHi()Z

    move-result v5

    .line 718
    const-string v1, "code_flags"

    move-object/from16 v0, p0

    move-object/from16 v2, p1

    move/from16 v3, p2

    invoke-virtual/range {v0 .. v5}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseFlags(Ljava/lang/String;Ljava/io/InputStream;ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;Z)[J

    move-result-object v0

    .line 720
    .local v0, "codeFlags":[J
    invoke-static {v0}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countBit16([J)I

    move-result v1

    .line 721
    .local v1, "codeAttrCount":I
    const-string v2, "code_attr_count"

    sget-object v3, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v2, v7, v3, v1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v2

    .line 722
    .local v2, "codeAttrCounts":[I
    const-string v3, "code_attr_indexes"

    sget-object v4, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v3, v7, v4, v2}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v3

    .line 723
    .local v3, "codeAttrIndexes":[[I
    const/4 v4, 0x0

    .line 724
    .local v4, "callCount":I
    const/4 v5, 0x0

    .local v5, "i":I
    :goto_0
    array-length v8, v3

    const/4 v9, 0x3

    if-ge v5, v8, :cond_1

    .line 725
    const/4 v8, 0x0

    .local v8, "j":I
    :goto_1
    aget-object v10, v3, v5

    array-length v10, v10

    if-ge v8, v10, :cond_0

    .line 726
    aget-object v10, v3, v5

    aget v10, v10, v8

    .line 727
    .local v10, "index":I
    iget-object v11, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    invoke-virtual {v11, v10, v9}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(II)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v11

    .line 728
    .local v11, "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    invoke-virtual {v11}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->numBackwardsCallables()I

    move-result v12

    add-int/2addr v4, v12

    .line 725
    .end local v10    # "index":I
    .end local v11    # "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    add-int/lit8 v8, v8, 0x1

    goto :goto_1

    .line 724
    .end local v8    # "j":I
    :cond_0
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 731
    .end local v5    # "i":I
    :cond_1
    const-string v5, "code_attr_calls"

    sget-object v8, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v5, v7, v8, v4}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v5

    .line 733
    .local v5, "codeAttrCalls":[I
    iget-object v8, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    .line 734
    const-string v10, "LineNumberTable"

    invoke-virtual {v8, v10, v9}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v8

    .line 735
    .local v8, "lineNumberTableLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    invoke-static {v0, v8}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v10

    .line 736
    .local v10, "lineNumberTableCount":I
    const-string v11, "code_LineNumberTable_N"

    sget-object v12, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v11, v7, v12, v10}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v11

    .line 738
    .local v11, "lineNumberTableN":[I
    const-string v12, "code_LineNumberTable_bci_P"

    sget-object v13, Lorg/apache/commons/compress/harmony/pack200/Codec;->BCI5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v12, v7, v13, v11}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v12

    .line 740
    .local v12, "lineNumberTableBciP":[[I
    const-string v13, "code_LineNumberTable_line"

    sget-object v14, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v13, v7, v14, v11}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v13

    .line 743
    .local v13, "lineNumberTableLine":[[I
    iget-object v14, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    .line 744
    const-string v15, "LocalVariableTable"

    invoke-virtual {v14, v15, v9}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v14

    .line 745
    .local v14, "localVariableTableLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    iget-object v15, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    .line 746
    move/from16 v16, v1

    .end local v1    # "codeAttrCount":I
    .local v16, "codeAttrCount":I
    const-string v1, "LocalVariableTypeTable"

    invoke-virtual {v15, v1, v9}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v1

    .line 748
    .local v1, "localVariableTypeTableLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    invoke-static {v0, v14}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v15

    .line 749
    .local v15, "lengthLocalVariableNBand":I
    const-string v9, "code_LocalVariableTable_N"

    move-object/from16 v18, v2

    .end local v2    # "codeAttrCounts":[I
    .local v18, "codeAttrCounts":[I
    sget-object v2, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v9, v7, v2, v15}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v2

    .line 751
    .local v2, "localVariableTableN":[I
    const-string v9, "code_LocalVariableTable_bci_P"

    move-object/from16 v19, v3

    .end local v3    # "codeAttrIndexes":[[I
    .local v19, "codeAttrIndexes":[[I
    sget-object v3, Lorg/apache/commons/compress/harmony/pack200/Codec;->BCI5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v9, v7, v3, v2}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v3

    .line 753
    .local v3, "localVariableTableBciP":[[I
    const-string v9, "code_LocalVariableTable_span_O"

    move/from16 v20, v4

    .end local v4    # "callCount":I
    .local v20, "callCount":I
    sget-object v4, Lorg/apache/commons/compress/harmony/pack200/Codec;->BRANCH5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v9, v7, v4, v2}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v4

    .line 755
    .local v4, "localVariableTableSpanO":[[I
    const-string v9, "code_LocalVariableTable_name_RU"

    move/from16 v21, v10

    .end local v10    # "lineNumberTableCount":I
    .local v21, "lineNumberTableCount":I
    sget-object v10, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v9, v7, v10, v2}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseCPUTF8References(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v9

    .line 757
    .local v9, "localVariableTableNameRU":[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    const-string v10, "code_LocalVariableTable_type_RS"

    move/from16 v22, v15

    .end local v15    # "lengthLocalVariableNBand":I
    .local v22, "lengthLocalVariableNBand":I
    sget-object v15, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v10, v7, v15, v2}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseCPSignatureReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v10

    .line 759
    .local v10, "localVariableTableTypeRS":[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    const-string v15, "code_LocalVariableTable_slot"

    move-object/from16 v23, v10

    .end local v10    # "localVariableTableTypeRS":[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    .local v23, "localVariableTableTypeRS":[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    sget-object v10, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v15, v7, v10, v2}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v10

    .line 762
    .local v10, "localVariableTableSlot":[[I
    invoke-static {v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v15

    .line 764
    .local v15, "lengthLocalVariableTypeTableNBand":I
    move-object/from16 v24, v1

    .end local v1    # "localVariableTypeTableLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v24, "localVariableTypeTableLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    const-string v1, "code_LocalVariableTypeTable_N"

    move-object/from16 v25, v10

    .end local v10    # "localVariableTableSlot":[[I
    .local v25, "localVariableTableSlot":[[I
    sget-object v10, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v1, v7, v10, v15}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v1

    .line 766
    .local v1, "localVariableTypeTableN":[I
    const-string v10, "code_LocalVariableTypeTable_bci_P"

    move/from16 v26, v15

    .end local v15    # "lengthLocalVariableTypeTableNBand":I
    .local v26, "lengthLocalVariableTypeTableNBand":I
    sget-object v15, Lorg/apache/commons/compress/harmony/pack200/Codec;->BCI5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v10, v7, v15, v1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v10

    .line 768
    .local v10, "localVariableTypeTableBciP":[[I
    const-string v15, "code_LocalVariableTypeTable_span_O"

    move-object/from16 v27, v10

    .end local v10    # "localVariableTypeTableBciP":[[I
    .local v27, "localVariableTypeTableBciP":[[I
    sget-object v10, Lorg/apache/commons/compress/harmony/pack200/Codec;->BRANCH5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v15, v7, v10, v1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v10

    .line 770
    .local v10, "localVariableTypeTableSpanO":[[I
    const-string v15, "code_LocalVariableTypeTable_name_RU"

    move-object/from16 v28, v10

    .end local v10    # "localVariableTypeTableSpanO":[[I
    .local v28, "localVariableTypeTableSpanO":[[I
    sget-object v10, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v15, v7, v10, v1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseCPUTF8References(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v10

    .line 772
    .local v10, "localVariableTypeTableNameRU":[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    const-string v15, "code_LocalVariableTypeTable_type_RS"

    move-object/from16 v29, v10

    .end local v10    # "localVariableTypeTableNameRU":[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    .local v29, "localVariableTypeTableNameRU":[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    sget-object v10, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v15, v7, v10, v1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseCPSignatureReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v10

    .line 774
    .local v10, "localVariableTypeTableTypeRS":[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    const-string v15, "code_LocalVariableTypeTable_slot"

    move-object/from16 v30, v10

    .end local v10    # "localVariableTypeTableTypeRS":[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    .local v30, "localVariableTypeTableTypeRS":[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    sget-object v10, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v15, v7, v10, v1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v10

    .line 778
    .local v10, "localVariableTypeTableSlot":[[I
    const/4 v15, 0x0

    .line 779
    .local v15, "backwardsCallIndex":I
    move/from16 v31, v15

    .end local v15    # "backwardsCallIndex":I
    .local v31, "backwardsCallIndex":I
    iget-object v15, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->options:Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;

    invoke-virtual {v15}, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->hasCodeFlagsHi()Z

    move-result v15

    if-eqz v15, :cond_2

    const/16 v15, 0x3e

    goto :goto_2

    :cond_2
    const/16 v15, 0x1f

    .line 780
    .local v15, "limit":I
    :goto_2
    move-object/from16 v32, v10

    .end local v10    # "localVariableTypeTableSlot":[[I
    .local v32, "localVariableTypeTableSlot":[[I
    add-int/lit8 v10, v15, 0x1

    new-array v10, v10, [Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    .line 781
    .local v10, "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    move-object/from16 v33, v1

    .end local v1    # "localVariableTypeTableN":[I
    .local v33, "localVariableTypeTableN":[I
    add-int/lit8 v1, v15, 0x1

    new-array v1, v1, [I

    .line 782
    .local v1, "counts":[I
    move-object/from16 v34, v9

    .end local v9    # "localVariableTableNameRU":[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    .local v34, "localVariableTableNameRU":[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    add-int/lit8 v9, v15, 0x1

    new-array v9, v9, [Ljava/util/List;

    .line 783
    .local v9, "otherAttributes":[Ljava/util/List;
    const/16 v35, 0x0

    move-object/from16 v36, v4

    move/from16 v4, v35

    .local v4, "i":I
    .local v36, "localVariableTableSpanO":[[I
    :goto_3
    if-ge v4, v15, :cond_4

    .line 784
    move/from16 v35, v15

    .end local v15    # "limit":I
    .local v35, "limit":I
    iget-object v15, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    move-object/from16 v37, v3

    const/4 v3, 0x3

    .end local v3    # "localVariableTableBciP":[[I
    .local v37, "localVariableTableBciP":[[I
    invoke-virtual {v15, v4, v3}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(II)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v15

    .line 785
    .local v15, "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    if-eqz v15, :cond_3

    invoke-virtual {v15}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->isDefaultLayout()Z

    move-result v17

    if-nez v17, :cond_3

    .line 786
    aput-object v15, v10, v4

    .line 787
    invoke-static {v0, v15}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v17

    aput v17, v1, v4

    .line 783
    .end local v15    # "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :cond_3
    add-int/lit8 v4, v4, 0x1

    move/from16 v15, v35

    move-object/from16 v3, v37

    goto :goto_3

    .end local v35    # "limit":I
    .end local v37    # "localVariableTableBciP":[[I
    .restart local v3    # "localVariableTableBciP":[[I
    .local v15, "limit":I
    :cond_4
    move-object/from16 v37, v3

    move/from16 v35, v15

    .line 790
    .end local v3    # "localVariableTableBciP":[[I
    .end local v4    # "i":I
    .end local v15    # "limit":I
    .restart local v35    # "limit":I
    .restart local v37    # "localVariableTableBciP":[[I
    const/4 v3, 0x0

    move/from16 v15, v31

    .end local v31    # "backwardsCallIndex":I
    .local v3, "i":I
    .local v15, "backwardsCallIndex":I
    :goto_4
    array-length v4, v1

    move-object/from16 v17, v2

    .end local v2    # "localVariableTableN":[I
    .local v17, "localVariableTableN":[I
    if-ge v3, v4, :cond_7

    .line 791
    aget v4, v1, v3

    if-lez v4, :cond_6

    .line 792
    iget-object v4, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    aget-object v2, v10, v3

    invoke-virtual {v4, v2}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeBands(Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;)Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;

    move-result-object v2

    .line 793
    .local v2, "bands":Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;
    aget v4, v1, v3

    invoke-virtual {v2, v7, v4}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;->parseAttributes(Ljava/io/InputStream;I)Ljava/util/List;

    move-result-object v4

    aput-object v4, v9, v3

    .line 794
    aget-object v4, v10, v3

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->numBackwardsCallables()I

    move-result v4

    .line 795
    .local v4, "numBackwardsCallables":I
    if-lez v4, :cond_5

    .line 796
    move-object/from16 v38, v1

    .end local v1    # "counts":[I
    .local v38, "counts":[I
    new-array v1, v4, [I

    .line 797
    .local v1, "backwardsCalls":[I
    const/4 v7, 0x0

    invoke-static {v5, v15, v1, v7, v4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 798
    invoke-virtual {v2, v1}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;->setBackwardsCalls([I)V

    .line 799
    add-int/2addr v15, v4

    goto :goto_5

    .line 795
    .end local v38    # "counts":[I
    .local v1, "counts":[I
    :cond_5
    move-object/from16 v38, v1

    .end local v1    # "counts":[I
    .restart local v38    # "counts":[I
    goto :goto_5

    .line 791
    .end local v2    # "bands":Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;
    .end local v4    # "numBackwardsCallables":I
    .end local v38    # "counts":[I
    .restart local v1    # "counts":[I
    :cond_6
    move-object/from16 v38, v1

    .line 790
    .end local v1    # "counts":[I
    .restart local v38    # "counts":[I
    :goto_5
    add-int/lit8 v3, v3, 0x1

    move-object/from16 v7, p1

    move-object/from16 v2, v17

    move-object/from16 v1, v38

    goto :goto_4

    .end local v38    # "counts":[I
    .restart local v1    # "counts":[I
    :cond_7
    move-object/from16 v38, v1

    .line 804
    .end local v1    # "counts":[I
    .end local v3    # "i":I
    .restart local v38    # "counts":[I
    const/4 v1, 0x0

    .line 805
    .local v1, "lineNumberIndex":I
    const/4 v2, 0x0

    .line 806
    .local v2, "lvtIndex":I
    const/4 v3, 0x0

    .line 807
    .local v3, "lvttIndex":I
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_6
    move/from16 v7, p2

    if-ge v4, v7, :cond_e

    .line 808
    move-object/from16 v40, v9

    move-object/from16 v39, v10

    .end local v9    # "otherAttributes":[Ljava/util/List;
    .end local v10    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v39, "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v40, "otherAttributes":[Ljava/util/List;
    aget-wide v9, v0, v4

    invoke-virtual {v8, v9, v10}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v9

    if-eqz v9, :cond_8

    .line 809
    new-instance v9, Lorg/apache/commons/compress/harmony/unpack200/bytecode/LineNumberTableAttribute;

    aget v10, v11, v1

    move-object/from16 v41, v5

    .end local v5    # "codeAttrCalls":[I
    .local v41, "codeAttrCalls":[I
    aget-object v5, v12, v1

    aget-object v7, v13, v1

    invoke-direct {v9, v10, v5, v7}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/LineNumberTableAttribute;-><init>(I[I[I)V

    move-object v5, v9

    .line 811
    .local v5, "lnta":Lorg/apache/commons/compress/harmony/unpack200/bytecode/LineNumberTableAttribute;
    add-int/lit8 v1, v1, 0x1

    .line 812
    iget-object v7, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeAttributes:[Ljava/util/List;

    aget-object v7, v7, v4

    invoke-interface {v7, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_7

    .line 808
    .end local v41    # "codeAttrCalls":[I
    .local v5, "codeAttrCalls":[I
    :cond_8
    move-object/from16 v41, v5

    .line 814
    .end local v5    # "codeAttrCalls":[I
    .restart local v41    # "codeAttrCalls":[I
    :goto_7
    aget-wide v9, v0, v4

    invoke-virtual {v14, v9, v10}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v5

    if-eqz v5, :cond_9

    .line 815
    new-instance v5, Lorg/apache/commons/compress/harmony/unpack200/bytecode/LocalVariableTableAttribute;

    aget v43, v17, v2

    aget-object v44, v37, v2

    aget-object v45, v36, v2

    aget-object v46, v34, v2

    aget-object v47, v23, v2

    aget-object v48, v25, v2

    move-object/from16 v42, v5

    invoke-direct/range {v42 .. v48}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/LocalVariableTableAttribute;-><init>(I[I[I[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;[I)V

    .line 819
    .local v5, "lvta":Lorg/apache/commons/compress/harmony/unpack200/bytecode/LocalVariableTableAttribute;
    add-int/lit8 v2, v2, 0x1

    .line 820
    iget-object v7, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeAttributes:[Ljava/util/List;

    aget-object v7, v7, v4

    invoke-interface {v7, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 822
    .end local v5    # "lvta":Lorg/apache/commons/compress/harmony/unpack200/bytecode/LocalVariableTableAttribute;
    :cond_9
    aget-wide v9, v0, v4

    move-object/from16 v5, v24

    .end local v24    # "localVariableTypeTableLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v5, "localVariableTypeTableLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    invoke-virtual {v5, v9, v10}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v7

    if-eqz v7, :cond_a

    .line 823
    new-instance v7, Lorg/apache/commons/compress/harmony/unpack200/bytecode/LocalVariableTypeTableAttribute;

    aget v43, v33, v3

    aget-object v44, v27, v3

    aget-object v45, v28, v3

    aget-object v46, v29, v3

    aget-object v47, v30, v3

    aget-object v48, v32, v3

    move-object/from16 v42, v7

    invoke-direct/range {v42 .. v48}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/LocalVariableTypeTableAttribute;-><init>(I[I[I[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;[I)V

    .line 827
    .local v7, "lvtta":Lorg/apache/commons/compress/harmony/unpack200/bytecode/LocalVariableTypeTableAttribute;
    add-int/lit8 v3, v3, 0x1

    .line 828
    iget-object v9, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeAttributes:[Ljava/util/List;

    aget-object v9, v9, v4

    invoke-interface {v9, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 831
    .end local v7    # "lvtta":Lorg/apache/commons/compress/harmony/unpack200/bytecode/LocalVariableTypeTableAttribute;
    :cond_a
    const/4 v7, 0x0

    .local v7, "j":I
    :goto_8
    move-object/from16 v9, v39

    .end local v39    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v9, "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    array-length v10, v9

    if-ge v7, v10, :cond_d

    .line 832
    aget-object v10, v9, v7

    if-eqz v10, :cond_c

    aget-object v10, v9, v7

    move/from16 v24, v1

    move/from16 v39, v2

    .end local v1    # "lineNumberIndex":I
    .end local v2    # "lvtIndex":I
    .local v24, "lineNumberIndex":I
    .local v39, "lvtIndex":I
    aget-wide v1, v0, v4

    invoke-virtual {v10, v1, v2}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v1

    if-eqz v1, :cond_b

    .line 834
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeAttributes:[Ljava/util/List;

    aget-object v1, v1, v4

    aget-object v2, v40, v7

    const/4 v10, 0x0

    invoke-interface {v2, v10}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 835
    aget-object v1, v40, v7

    invoke-interface {v1, v10}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    goto :goto_9

    .line 832
    :cond_b
    const/4 v10, 0x0

    goto :goto_9

    .end local v24    # "lineNumberIndex":I
    .end local v39    # "lvtIndex":I
    .restart local v1    # "lineNumberIndex":I
    .restart local v2    # "lvtIndex":I
    :cond_c
    move/from16 v24, v1

    move/from16 v39, v2

    const/4 v10, 0x0

    .line 831
    .end local v1    # "lineNumberIndex":I
    .end local v2    # "lvtIndex":I
    .restart local v24    # "lineNumberIndex":I
    .restart local v39    # "lvtIndex":I
    :goto_9
    add-int/lit8 v7, v7, 0x1

    move/from16 v1, v24

    move/from16 v2, v39

    move-object/from16 v39, v9

    goto :goto_8

    .end local v24    # "lineNumberIndex":I
    .end local v39    # "lvtIndex":I
    .restart local v1    # "lineNumberIndex":I
    .restart local v2    # "lvtIndex":I
    :cond_d
    move/from16 v24, v1

    move/from16 v39, v2

    const/4 v10, 0x0

    .line 807
    .end local v1    # "lineNumberIndex":I
    .end local v2    # "lvtIndex":I
    .end local v7    # "j":I
    .restart local v24    # "lineNumberIndex":I
    .restart local v39    # "lvtIndex":I
    add-int/lit8 v4, v4, 0x1

    move-object v10, v9

    move-object/from16 v9, v40

    move-object/from16 v24, v5

    move-object/from16 v5, v41

    goto/16 :goto_6

    .line 840
    .end local v4    # "i":I
    .end local v39    # "lvtIndex":I
    .end local v40    # "otherAttributes":[Ljava/util/List;
    .end local v41    # "codeAttrCalls":[I
    .restart local v1    # "lineNumberIndex":I
    .restart local v2    # "lvtIndex":I
    .local v5, "codeAttrCalls":[I
    .local v9, "otherAttributes":[Ljava/util/List;
    .restart local v10    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v24, "localVariableTypeTableLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :cond_e
    return-void
.end method

.method private parseCodeBands(Ljava/io/InputStream;)V
    .locals 17
    .param p1, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;,
            Ljava/io/IOException;
        }
    .end annotation

    .line 647
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    iget-object v2, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    const-string v3, "Code"

    const/4 v4, 0x2

    invoke-virtual {v2, v3, v4}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v2

    .line 650
    .local v2, "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    iget-object v3, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodFlags:[[J

    invoke-static {v3, v2}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([[JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v3

    .line 651
    .local v3, "codeCount":I
    const-string v5, "code_headers"

    sget-object v6, Lorg/apache/commons/compress/harmony/pack200/Codec;->BYTE1:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v0, v5, v1, v6, v3}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v5

    .line 653
    .local v5, "codeHeaders":[I
    iget-object v6, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v6}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getSegmentHeader()Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    move-result-object v6

    invoke-virtual {v6}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->getOptions()Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;

    move-result-object v6

    invoke-virtual {v6}, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->hasAllCodeFlags()Z

    move-result v6

    .line 654
    .local v6, "allCodeHasFlags":Z
    if-nez v6, :cond_0

    .line 655
    new-array v7, v3, [Z

    iput-object v7, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeHasAttributes:[Z

    .line 657
    :cond_0
    const/4 v7, 0x0

    .line 658
    .local v7, "codeSpecialHeader":I
    const/4 v8, 0x0

    .local v8, "i":I
    :goto_0
    const/4 v9, 0x1

    if-ge v8, v3, :cond_2

    .line 659
    aget v10, v5, v8

    if-nez v10, :cond_1

    .line 660
    add-int/lit8 v7, v7, 0x1

    .line 661
    if-nez v6, :cond_1

    .line 662
    iget-object v10, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeHasAttributes:[Z

    aput-boolean v9, v10, v8

    .line 658
    :cond_1
    add-int/lit8 v8, v8, 0x1

    goto :goto_0

    .line 666
    .end local v8    # "i":I
    :cond_2
    const-string v8, "code_max_stack"

    sget-object v10, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v0, v8, v1, v10, v7}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v8

    .line 667
    .local v8, "codeMaxStackSpecials":[I
    const-string v10, "code_max_na_locals"

    sget-object v11, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v0, v10, v1, v11, v7}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v10

    .line 669
    .local v10, "codeMaxNALocalsSpecials":[I
    const-string v11, "code_handler_count"

    sget-object v12, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v0, v11, v1, v12, v7}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v11

    .line 672
    .local v11, "codeHandlerCountSpecials":[I
    new-array v12, v3, [I

    iput-object v12, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeMaxStack:[I

    .line 673
    new-array v12, v3, [I

    iput-object v12, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeMaxNALocals:[I

    .line 674
    new-array v12, v3, [I

    iput-object v12, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeHandlerCount:[I

    .line 675
    const/4 v12, 0x0

    .line 676
    .local v12, "special":I
    const/4 v13, 0x0

    .local v13, "i":I
    :goto_1
    if-ge v13, v3, :cond_8

    .line 677
    aget v14, v5, v13

    const/16 v15, 0xff

    and-int/2addr v14, v15

    .line 678
    .local v14, "header":I
    if-ltz v14, :cond_7

    .line 681
    if-nez v14, :cond_3

    .line 682
    iget-object v15, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeMaxStack:[I

    aget v16, v8, v12

    aput v16, v15, v13

    .line 683
    iget-object v15, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeMaxNALocals:[I

    aget v16, v10, v12

    aput v16, v15, v13

    .line 684
    iget-object v15, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeHandlerCount:[I

    aget v16, v11, v12

    aput v16, v15, v13

    .line 685
    add-int/lit8 v12, v12, 0x1

    move v15, v4

    goto :goto_2

    .line 686
    :cond_3
    const/16 v4, 0x90

    if-gt v14, v4, :cond_4

    .line 687
    iget-object v4, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeMaxStack:[I

    add-int/lit8 v15, v14, -0x1

    rem-int/lit8 v15, v15, 0xc

    aput v15, v4, v13

    .line 688
    iget-object v4, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeMaxNALocals:[I

    add-int/lit8 v15, v14, -0x1

    div-int/lit8 v15, v15, 0xc

    aput v15, v4, v13

    .line 689
    iget-object v4, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeHandlerCount:[I

    const/4 v15, 0x0

    aput v15, v4, v13

    const/4 v15, 0x2

    goto :goto_2

    .line 690
    :cond_4
    const/16 v4, 0xd0

    if-gt v14, v4, :cond_5

    .line 691
    iget-object v4, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeMaxStack:[I

    add-int/lit16 v15, v14, -0x91

    rem-int/lit8 v15, v15, 0x8

    aput v15, v4, v13

    .line 692
    iget-object v4, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeMaxNALocals:[I

    add-int/lit16 v15, v14, -0x91

    div-int/lit8 v15, v15, 0x8

    aput v15, v4, v13

    .line 693
    iget-object v4, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeHandlerCount:[I

    aput v9, v4, v13

    const/4 v15, 0x2

    goto :goto_2

    .line 694
    :cond_5
    if-gt v14, v15, :cond_6

    .line 695
    iget-object v4, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeMaxStack:[I

    add-int/lit16 v15, v14, -0xd1

    rem-int/lit8 v15, v15, 0x7

    aput v15, v4, v13

    .line 696
    iget-object v4, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeMaxNALocals:[I

    add-int/lit16 v15, v14, -0xd1

    div-int/lit8 v15, v15, 0x7

    aput v15, v4, v13

    .line 697
    iget-object v4, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeHandlerCount:[I

    const/4 v15, 0x2

    aput v15, v4, v13

    .line 676
    .end local v14    # "header":I
    :goto_2
    add-int/lit8 v13, v13, 0x1

    move v4, v15

    goto :goto_1

    .line 699
    .restart local v14    # "header":I
    :cond_6
    new-instance v4, Ljava/lang/IllegalStateException;

    const-string v9, "Shouldn\'t get here either"

    invoke-direct {v4, v9}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 679
    :cond_7
    new-instance v4, Ljava/lang/IllegalStateException;

    const-string v9, "Shouldn\'t get here"

    invoke-direct {v4, v9}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 702
    .end local v13    # "i":I
    .end local v14    # "header":I
    :cond_8
    sget-object v4, Lorg/apache/commons/compress/harmony/pack200/Codec;->BCI5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    iget-object v9, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeHandlerCount:[I

    const-string v13, "code_handler_start_P"

    invoke-virtual {v0, v13, v1, v4, v9}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v4

    iput-object v4, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeHandlerStartP:[[I

    .line 703
    sget-object v4, Lorg/apache/commons/compress/harmony/pack200/Codec;->BRANCH5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    iget-object v9, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeHandlerCount:[I

    const-string v13, "code_handler_end_PO"

    invoke-virtual {v0, v13, v1, v4, v9}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v4

    iput-object v4, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeHandlerEndPO:[[I

    .line 704
    sget-object v4, Lorg/apache/commons/compress/harmony/pack200/Codec;->BRANCH5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    iget-object v9, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeHandlerCount:[I

    const-string v13, "code_handler_catch_PO"

    invoke-virtual {v0, v13, v1, v4, v9}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v4

    iput-object v4, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeHandlerCatchPO:[[I

    .line 705
    sget-object v4, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    iget-object v9, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeHandlerCount:[I

    const-string v13, "code_handler_class_RCN"

    invoke-virtual {v0, v13, v1, v4, v9}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v4

    iput-object v4, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeHandlerClassRCN:[[I

    .line 707
    if-eqz v6, :cond_9

    move v4, v3

    goto :goto_3

    :cond_9
    move v4, v7

    .line 709
    .local v4, "codeFlagsCount":I
    :goto_3
    new-array v9, v4, [Ljava/util/List;

    iput-object v9, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeAttributes:[Ljava/util/List;

    .line 710
    const/4 v9, 0x0

    .local v9, "i":I
    :goto_4
    iget-object v13, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeAttributes:[Ljava/util/List;

    array-length v13, v13

    if-ge v9, v13, :cond_a

    .line 711
    iget-object v13, v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeAttributes:[Ljava/util/List;

    new-instance v14, Ljava/util/ArrayList;

    invoke-direct {v14}, Ljava/util/ArrayList;-><init>()V

    aput-object v14, v13, v9

    .line 710
    add-int/lit8 v9, v9, 0x1

    goto :goto_4

    .line 713
    .end local v9    # "i":I
    :cond_a
    invoke-direct {v0, v1, v4}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseCodeAttrBands(Ljava/io/InputStream;I)V

    .line 714
    return-void
.end method

.method private parseFieldAttrBands(Ljava/io/InputStream;)V
    .locals 34
    .param p1, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 165
    move-object/from16 v6, p0

    move-object/from16 v7, p1

    iget-object v3, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFieldCount:[I

    sget-object v4, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->options:Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->hasFieldFlagsHi()Z

    move-result v5

    const-string v1, "field_flags"

    move-object/from16 v0, p0

    move-object/from16 v2, p1

    invoke-virtual/range {v0 .. v5}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseFlags(Ljava/lang/String;Ljava/io/InputStream;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;Z)[[J

    move-result-object v0

    iput-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    .line 166
    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countBit16([[J)I

    move-result v0

    .line 167
    .local v0, "fieldAttrCount":I
    const-string v1, "field_attr_count"

    sget-object v2, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v1, v7, v2, v0}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v1

    .line 168
    .local v1, "fieldAttrCounts":[I
    const-string v2, "field_attr_indexes"

    sget-object v3, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v2, v7, v3, v1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v2

    .line 169
    .local v2, "fieldAttrIndexes":[[I
    iget-object v3, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    const/4 v4, 0x1

    invoke-direct {v6, v2, v3, v4}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getCallCount([[I[[JI)I

    move-result v3

    .line 170
    .local v3, "callCount":I
    const-string v5, "field_attr_calls"

    sget-object v8, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v5, v7, v8, v3}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v5

    .line 173
    .local v5, "fieldAttrCalls":[I
    iget v8, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classCount:I

    new-array v8, v8, [[Ljava/util/ArrayList;

    iput-object v8, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldAttributes:[[Ljava/util/ArrayList;

    .line 174
    const/4 v8, 0x0

    .local v8, "i":I
    :goto_0
    iget v9, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classCount:I

    if-ge v8, v9, :cond_1

    .line 175
    iget-object v9, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldAttributes:[[Ljava/util/ArrayList;

    iget-object v10, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    aget-object v10, v10, v8

    array-length v10, v10

    new-array v10, v10, [Ljava/util/ArrayList;

    aput-object v10, v9, v8

    .line 176
    const/4 v9, 0x0

    .local v9, "j":I
    :goto_1
    iget-object v10, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    aget-object v10, v10, v8

    array-length v10, v10

    if-ge v9, v10, :cond_0

    .line 177
    iget-object v10, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldAttributes:[[Ljava/util/ArrayList;

    aget-object v10, v10, v8

    new-instance v11, Ljava/util/ArrayList;

    invoke-direct {v11}, Ljava/util/ArrayList;-><init>()V

    aput-object v11, v10, v9

    .line 176
    add-int/lit8 v9, v9, 0x1

    goto :goto_1

    .line 174
    .end local v9    # "j":I
    :cond_0
    add-int/lit8 v8, v8, 0x1

    goto :goto_0

    .line 181
    .end local v8    # "i":I
    :cond_1
    iget-object v8, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    const-string v9, "ConstantValue"

    invoke-virtual {v8, v9, v4}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v8

    .line 183
    .local v8, "constantValueLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    iget-object v9, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    invoke-static {v9, v8}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([[JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v9

    .line 184
    .local v9, "constantCount":I
    const-string v10, "field_ConstantValue_KQ"

    sget-object v11, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v10, v7, v11, v9}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v10

    .line 186
    .local v10, "field_constantValue_KQ":[I
    const/4 v11, 0x0

    .line 188
    .local v11, "constantValueIndex":I
    iget-object v12, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    const-string v13, "Signature"

    invoke-virtual {v12, v13, v4}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v12

    .line 190
    .local v12, "signatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    iget-object v13, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    invoke-static {v13, v12}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([[JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v13

    .line 191
    .local v13, "signatureCount":I
    const-string v14, "field_Signature_RS"

    sget-object v15, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v14, v7, v15, v13}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v14

    .line 192
    .local v14, "fieldSignatureRS":[I
    const/4 v15, 0x0

    .line 194
    .local v15, "signatureIndex":I
    move/from16 v16, v0

    .end local v0    # "fieldAttrCount":I
    .local v16, "fieldAttrCount":I
    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    move-object/from16 v17, v1

    .end local v1    # "fieldAttrCounts":[I
    .local v17, "fieldAttrCounts":[I
    const-string v1, "Deprecated"

    invoke-virtual {v0, v1, v4}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v0

    .line 197
    .local v0, "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_2
    iget v4, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classCount:I

    if-ge v1, v4, :cond_8

    .line 198
    const/4 v4, 0x0

    .local v4, "j":I
    :goto_3
    move-object/from16 v19, v2

    .end local v2    # "fieldAttrIndexes":[[I
    .local v19, "fieldAttrIndexes":[[I
    iget-object v2, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    aget-object v2, v2, v1

    array-length v2, v2

    if-ge v4, v2, :cond_7

    .line 199
    iget-object v2, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    aget-object v2, v2, v1

    move/from16 v20, v13

    move-object/from16 v21, v14

    .end local v13    # "signatureCount":I
    .end local v14    # "fieldSignatureRS":[I
    .local v20, "signatureCount":I
    .local v21, "fieldSignatureRS":[I
    aget-wide v13, v2, v4

    .line 200
    .local v13, "flag":J
    invoke-virtual {v0, v13, v14}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 201
    iget-object v2, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldAttributes:[[Ljava/util/ArrayList;

    aget-object v2, v2, v1

    aget-object v2, v2, v4

    move-object/from16 v22, v0

    .end local v0    # "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v22, "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    new-instance v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/DeprecatedAttribute;

    invoke-direct {v0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/DeprecatedAttribute;-><init>()V

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_4

    .line 200
    .end local v22    # "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v0    # "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :cond_2
    move-object/from16 v22, v0

    .line 203
    .end local v0    # "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v22    # "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :goto_4
    invoke-virtual {v8, v13, v14}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 205
    aget v0, v10, v11

    move/from16 v23, v3

    .end local v3    # "callCount":I
    .local v23, "callCount":I
    int-to-long v2, v0

    .line 206
    .local v2, "result":J
    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldDescr:[[Ljava/lang/String;

    aget-object v0, v0, v1

    aget-object v0, v0, v4

    .line 207
    .local v0, "desc":Ljava/lang/String;
    move/from16 v25, v9

    const/16 v9, 0x3a

    .end local v9    # "constantCount":I
    .local v25, "constantCount":I
    invoke-virtual {v0, v9}, Ljava/lang/String;->indexOf(I)I

    move-result v26

    .line 208
    .local v26, "colon":I
    add-int/lit8 v9, v26, 0x1

    invoke-virtual {v0, v9}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v9

    .line 209
    .local v9, "type":Ljava/lang/String;
    move-object/from16 v27, v0

    .end local v0    # "desc":Ljava/lang/String;
    .local v27, "desc":Ljava/lang/String;
    const-string v0, "B"

    invoke-virtual {v9, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    const-string v0, "S"

    invoke-virtual {v9, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    const-string v0, "C"

    invoke-virtual {v9, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    const-string v0, "Z"

    invoke-virtual {v9, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 210
    :cond_3
    const-string v9, "I"

    .line 212
    :cond_4
    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getConstantPool()Lorg/apache/commons/compress/harmony/unpack200/SegmentConstantPool;

    move-result-object v0

    invoke-virtual {v8, v2, v3, v9, v0}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->getValue(JLjava/lang/String;Lorg/apache/commons/compress/harmony/unpack200/SegmentConstantPool;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;

    move-result-object v0

    .line 213
    .local v0, "value":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    move-wide/from16 v28, v2

    .end local v2    # "result":J
    .local v28, "result":J
    iget-object v2, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldAttributes:[[Ljava/util/ArrayList;

    aget-object v2, v2, v1

    aget-object v2, v2, v4

    new-instance v3, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ConstantValueAttribute;

    invoke-direct {v3, v0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ConstantValueAttribute;-><init>(Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;)V

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 214
    add-int/lit8 v11, v11, 0x1

    goto :goto_5

    .line 203
    .end local v0    # "value":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .end local v23    # "callCount":I
    .end local v25    # "constantCount":I
    .end local v26    # "colon":I
    .end local v27    # "desc":Ljava/lang/String;
    .end local v28    # "result":J
    .restart local v3    # "callCount":I
    .local v9, "constantCount":I
    :cond_5
    move/from16 v23, v3

    move/from16 v25, v9

    .line 216
    .end local v3    # "callCount":I
    .end local v9    # "constantCount":I
    .restart local v23    # "callCount":I
    .restart local v25    # "constantCount":I
    :goto_5
    invoke-virtual {v12, v13, v14}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 218
    aget v0, v21, v15

    int-to-long v2, v0

    .line 219
    .restart local v2    # "result":J
    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldDescr:[[Ljava/lang/String;

    aget-object v0, v0, v1

    aget-object v0, v0, v4

    .line 220
    .local v0, "desc":Ljava/lang/String;
    const/16 v9, 0x3a

    invoke-virtual {v0, v9}, Ljava/lang/String;->indexOf(I)I

    move-result v9

    .line 221
    .local v9, "colon":I
    move-object/from16 v24, v8

    .end local v8    # "constantValueLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v24, "constantValueLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    add-int/lit8 v8, v9, 0x1

    invoke-virtual {v0, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v8

    .line 222
    .local v8, "type":Ljava/lang/String;
    move-object/from16 v26, v0

    .end local v0    # "desc":Ljava/lang/String;
    .local v26, "desc":Ljava/lang/String;
    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getConstantPool()Lorg/apache/commons/compress/harmony/unpack200/SegmentConstantPool;

    move-result-object v0

    invoke-virtual {v12, v2, v3, v8, v0}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->getValue(JLjava/lang/String;Lorg/apache/commons/compress/harmony/unpack200/SegmentConstantPool;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;

    move-result-object v0

    check-cast v0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    .line 223
    .local v0, "value":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    move-wide/from16 v27, v2

    .end local v2    # "result":J
    .local v27, "result":J
    iget-object v2, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldAttributes:[[Ljava/util/ArrayList;

    aget-object v2, v2, v1

    aget-object v2, v2, v4

    new-instance v3, Lorg/apache/commons/compress/harmony/unpack200/bytecode/SignatureAttribute;

    invoke-direct {v3, v0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/SignatureAttribute;-><init>(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;)V

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 224
    add-int/lit8 v15, v15, 0x1

    goto :goto_6

    .line 216
    .end local v0    # "value":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    .end local v9    # "colon":I
    .end local v24    # "constantValueLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v26    # "desc":Ljava/lang/String;
    .end local v27    # "result":J
    .local v8, "constantValueLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :cond_6
    move-object/from16 v24, v8

    .line 198
    .end local v8    # "constantValueLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v13    # "flag":J
    .restart local v24    # "constantValueLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :goto_6
    add-int/lit8 v4, v4, 0x1

    move-object/from16 v2, v19

    move/from16 v13, v20

    move-object/from16 v14, v21

    move-object/from16 v0, v22

    move/from16 v3, v23

    move-object/from16 v8, v24

    move/from16 v9, v25

    goto/16 :goto_3

    .end local v20    # "signatureCount":I
    .end local v21    # "fieldSignatureRS":[I
    .end local v22    # "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v23    # "callCount":I
    .end local v24    # "constantValueLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v25    # "constantCount":I
    .local v0, "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v3    # "callCount":I
    .restart local v8    # "constantValueLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v9, "constantCount":I
    .local v13, "signatureCount":I
    .restart local v14    # "fieldSignatureRS":[I
    :cond_7
    move-object/from16 v22, v0

    move/from16 v23, v3

    move-object/from16 v24, v8

    move/from16 v25, v9

    move/from16 v20, v13

    move-object/from16 v21, v14

    .line 197
    .end local v0    # "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v3    # "callCount":I
    .end local v4    # "j":I
    .end local v8    # "constantValueLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v9    # "constantCount":I
    .end local v13    # "signatureCount":I
    .end local v14    # "fieldSignatureRS":[I
    .restart local v20    # "signatureCount":I
    .restart local v21    # "fieldSignatureRS":[I
    .restart local v22    # "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v23    # "callCount":I
    .restart local v24    # "constantValueLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v25    # "constantCount":I
    add-int/lit8 v1, v1, 0x1

    move-object/from16 v2, v19

    const/4 v4, 0x1

    goto/16 :goto_2

    .end local v19    # "fieldAttrIndexes":[[I
    .end local v20    # "signatureCount":I
    .end local v21    # "fieldSignatureRS":[I
    .end local v22    # "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v23    # "callCount":I
    .end local v24    # "constantValueLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v25    # "constantCount":I
    .restart local v0    # "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v2, "fieldAttrIndexes":[[I
    .restart local v3    # "callCount":I
    .restart local v8    # "constantValueLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v9    # "constantCount":I
    .restart local v13    # "signatureCount":I
    .restart local v14    # "fieldSignatureRS":[I
    :cond_8
    move-object/from16 v22, v0

    move-object/from16 v19, v2

    move/from16 v23, v3

    move-object/from16 v24, v8

    move/from16 v25, v9

    move/from16 v20, v13

    move-object/from16 v21, v14

    .line 229
    .end local v0    # "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v1    # "i":I
    .end local v2    # "fieldAttrIndexes":[[I
    .end local v3    # "callCount":I
    .end local v8    # "constantValueLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v9    # "constantCount":I
    .end local v13    # "signatureCount":I
    .end local v14    # "fieldSignatureRS":[I
    .restart local v19    # "fieldAttrIndexes":[[I
    .restart local v20    # "signatureCount":I
    .restart local v21    # "fieldSignatureRS":[I
    .restart local v22    # "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v23    # "callCount":I
    .restart local v24    # "constantValueLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v25    # "constantCount":I
    invoke-direct {v6, v7, v5}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseFieldMetadataBands(Ljava/io/InputStream;[I)I

    move-result v0

    .line 232
    .local v0, "backwardsCallsUsed":I
    move v1, v0

    .line 233
    .local v1, "backwardsCallIndex":I
    iget-object v2, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->options:Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->hasFieldFlagsHi()Z

    move-result v2

    if-eqz v2, :cond_9

    const/16 v2, 0x3e

    goto :goto_7

    :cond_9
    const/16 v2, 0x1f

    .line 234
    .local v2, "limit":I
    :goto_7
    add-int/lit8 v3, v2, 0x1

    new-array v3, v3, [Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    .line 235
    .local v3, "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    add-int/lit8 v4, v2, 0x1

    new-array v4, v4, [I

    .line 236
    .local v4, "counts":[I
    add-int/lit8 v8, v2, 0x1

    new-array v8, v8, [Ljava/util/List;

    .line 237
    .local v8, "otherAttributes":[Ljava/util/List;
    const/4 v9, 0x0

    .local v9, "i":I
    :goto_8
    if-ge v9, v2, :cond_b

    .line 238
    iget-object v13, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    const/4 v14, 0x1

    invoke-virtual {v13, v9, v14}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(II)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v13

    .line 239
    .local v13, "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    if-eqz v13, :cond_a

    invoke-virtual {v13}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->isDefaultLayout()Z

    move-result v18

    if-nez v18, :cond_a

    .line 240
    aput-object v13, v3, v9

    .line 241
    iget-object v14, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    invoke-static {v14, v13}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([[JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v14

    aput v14, v4, v9

    .line 237
    .end local v13    # "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :cond_a
    add-int/lit8 v9, v9, 0x1

    goto :goto_8

    .line 244
    .end local v9    # "i":I
    :cond_b
    const/4 v9, 0x0

    .restart local v9    # "i":I
    :goto_9
    array-length v13, v4

    if-ge v9, v13, :cond_e

    .line 245
    aget v13, v4, v9

    if-lez v13, :cond_d

    .line 246
    iget-object v13, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    aget-object v14, v3, v9

    invoke-virtual {v13, v14}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeBands(Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;)Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;

    move-result-object v13

    .line 247
    .local v13, "bands":Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;
    aget v14, v4, v9

    invoke-virtual {v13, v7, v14}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;->parseAttributes(Ljava/io/InputStream;I)Ljava/util/List;

    move-result-object v14

    aput-object v14, v8, v9

    .line 248
    aget-object v14, v3, v9

    invoke-virtual {v14}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->numBackwardsCallables()I

    move-result v14

    .line 249
    .local v14, "numBackwardsCallables":I
    if-lez v14, :cond_c

    .line 250
    move/from16 v26, v0

    .end local v0    # "backwardsCallsUsed":I
    .local v26, "backwardsCallsUsed":I
    new-array v0, v14, [I

    .line 251
    .local v0, "backwardsCalls":[I
    move/from16 v27, v2

    const/4 v2, 0x0

    .end local v2    # "limit":I
    .local v27, "limit":I
    invoke-static {v5, v1, v0, v2, v14}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 252
    invoke-virtual {v13, v0}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;->setBackwardsCalls([I)V

    .line 253
    add-int/2addr v1, v14

    goto :goto_a

    .line 249
    .end local v26    # "backwardsCallsUsed":I
    .end local v27    # "limit":I
    .local v0, "backwardsCallsUsed":I
    .restart local v2    # "limit":I
    :cond_c
    move/from16 v26, v0

    move/from16 v27, v2

    .end local v0    # "backwardsCallsUsed":I
    .end local v2    # "limit":I
    .restart local v26    # "backwardsCallsUsed":I
    .restart local v27    # "limit":I
    goto :goto_a

    .line 245
    .end local v13    # "bands":Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;
    .end local v14    # "numBackwardsCallables":I
    .end local v26    # "backwardsCallsUsed":I
    .end local v27    # "limit":I
    .restart local v0    # "backwardsCallsUsed":I
    .restart local v2    # "limit":I
    :cond_d
    move/from16 v26, v0

    move/from16 v27, v2

    .line 244
    .end local v0    # "backwardsCallsUsed":I
    .end local v2    # "limit":I
    .restart local v26    # "backwardsCallsUsed":I
    .restart local v27    # "limit":I
    :goto_a
    add-int/lit8 v9, v9, 0x1

    move/from16 v0, v26

    move/from16 v2, v27

    goto :goto_9

    .end local v26    # "backwardsCallsUsed":I
    .end local v27    # "limit":I
    .restart local v0    # "backwardsCallsUsed":I
    .restart local v2    # "limit":I
    :cond_e
    move/from16 v26, v0

    move/from16 v27, v2

    .line 259
    .end local v0    # "backwardsCallsUsed":I
    .end local v2    # "limit":I
    .end local v9    # "i":I
    .restart local v26    # "backwardsCallsUsed":I
    .restart local v27    # "limit":I
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_b
    iget v2, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classCount:I

    if-ge v0, v2, :cond_13

    .line 260
    const/4 v2, 0x0

    .local v2, "j":I
    :goto_c
    iget-object v9, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    aget-object v9, v9, v0

    array-length v9, v9

    if-ge v2, v9, :cond_12

    .line 261
    iget-object v9, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    aget-object v9, v9, v0

    aget-wide v13, v9, v2

    .line 262
    .local v13, "flag":J
    const/4 v9, 0x0

    .line 263
    .local v9, "othersAddedAtStart":I
    const/16 v28, 0x0

    move/from16 v33, v28

    move/from16 v28, v1

    move/from16 v1, v33

    .local v1, "k":I
    .local v28, "backwardsCallIndex":I
    :goto_d
    move-object/from16 v29, v4

    .end local v4    # "counts":[I
    .local v29, "counts":[I
    array-length v4, v3

    if-ge v1, v4, :cond_11

    .line 264
    aget-object v4, v3, v1

    if-eqz v4, :cond_10

    aget-object v4, v3, v1

    invoke-virtual {v4, v13, v14}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v4

    if-eqz v4, :cond_10

    .line 266
    aget-object v4, v3, v1

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->getIndex()I

    move-result v4

    move-object/from16 v30, v3

    .end local v3    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v30, "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    const/16 v3, 0xf

    if-ge v4, v3, :cond_f

    .line 267
    iget-object v3, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldAttributes:[[Ljava/util/ArrayList;

    aget-object v3, v3, v0

    aget-object v3, v3, v2

    add-int/lit8 v4, v9, 0x1

    move/from16 v31, v4

    .end local v9    # "othersAddedAtStart":I
    .local v31, "othersAddedAtStart":I
    aget-object v4, v8, v1

    move-object/from16 v32, v5

    const/4 v5, 0x0

    .end local v5    # "fieldAttrCalls":[I
    .local v32, "fieldAttrCalls":[I
    invoke-interface {v4, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v3, v9, v4}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    move/from16 v9, v31

    goto :goto_e

    .line 269
    .end local v31    # "othersAddedAtStart":I
    .end local v32    # "fieldAttrCalls":[I
    .restart local v5    # "fieldAttrCalls":[I
    .restart local v9    # "othersAddedAtStart":I
    :cond_f
    move-object/from16 v32, v5

    const/4 v5, 0x0

    .end local v5    # "fieldAttrCalls":[I
    .restart local v32    # "fieldAttrCalls":[I
    iget-object v3, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldAttributes:[[Ljava/util/ArrayList;

    aget-object v3, v3, v0

    aget-object v3, v3, v2

    aget-object v4, v8, v1

    invoke-interface {v4, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 271
    :goto_e
    aget-object v3, v8, v1

    invoke-interface {v3, v5}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    goto :goto_f

    .line 264
    .end local v30    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v32    # "fieldAttrCalls":[I
    .restart local v3    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v5    # "fieldAttrCalls":[I
    :cond_10
    move-object/from16 v30, v3

    move-object/from16 v32, v5

    const/4 v5, 0x0

    .line 263
    .end local v3    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v5    # "fieldAttrCalls":[I
    .restart local v30    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v32    # "fieldAttrCalls":[I
    :goto_f
    add-int/lit8 v1, v1, 0x1

    move-object/from16 v4, v29

    move-object/from16 v3, v30

    move-object/from16 v5, v32

    goto :goto_d

    .end local v30    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v32    # "fieldAttrCalls":[I
    .restart local v3    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v5    # "fieldAttrCalls":[I
    :cond_11
    move-object/from16 v30, v3

    move-object/from16 v32, v5

    const/4 v5, 0x0

    .line 260
    .end local v1    # "k":I
    .end local v3    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v5    # "fieldAttrCalls":[I
    .end local v9    # "othersAddedAtStart":I
    .end local v13    # "flag":J
    .restart local v30    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v32    # "fieldAttrCalls":[I
    add-int/lit8 v2, v2, 0x1

    move/from16 v1, v28

    move-object/from16 v4, v29

    move-object/from16 v5, v32

    goto :goto_c

    .end local v28    # "backwardsCallIndex":I
    .end local v29    # "counts":[I
    .end local v30    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v32    # "fieldAttrCalls":[I
    .local v1, "backwardsCallIndex":I
    .restart local v3    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v4    # "counts":[I
    .restart local v5    # "fieldAttrCalls":[I
    :cond_12
    move/from16 v28, v1

    move-object/from16 v30, v3

    move-object/from16 v29, v4

    move-object/from16 v32, v5

    const/4 v5, 0x0

    .line 259
    .end local v1    # "backwardsCallIndex":I
    .end local v2    # "j":I
    .end local v3    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v4    # "counts":[I
    .end local v5    # "fieldAttrCalls":[I
    .restart local v28    # "backwardsCallIndex":I
    .restart local v29    # "counts":[I
    .restart local v30    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v32    # "fieldAttrCalls":[I
    add-int/lit8 v0, v0, 0x1

    move-object/from16 v5, v32

    goto/16 :goto_b

    .line 276
    .end local v0    # "i":I
    .end local v28    # "backwardsCallIndex":I
    .end local v29    # "counts":[I
    .end local v30    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v32    # "fieldAttrCalls":[I
    .restart local v1    # "backwardsCallIndex":I
    .restart local v3    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v4    # "counts":[I
    .restart local v5    # "fieldAttrCalls":[I
    :cond_13
    return-void
.end method

.method private parseFieldBands(Ljava/io/InputStream;)V
    .locals 3
    .param p1, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 159
    sget-object v0, Lorg/apache/commons/compress/harmony/pack200/Codec;->DELTA5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    iget-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFieldCount:[I

    const-string v2, "field_descr"

    invoke-virtual {p0, v2, p1, v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldDescrInts:[[I

    .line 160
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldDescrInts:[[I

    iget-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getCpDescriptor()[Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getReferences([[I[Ljava/lang/String;)[[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldDescr:[[Ljava/lang/String;

    .line 161
    invoke-direct {p0, p1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseFieldAttrBands(Ljava/io/InputStream;)V

    .line 162
    return-void
.end method

.method private parseFieldMetadataBands(Ljava/io/InputStream;[I)I
    .locals 19
    .param p1, "in"    # Ljava/io/InputStream;
    .param p2, "fieldAttrCalls"    # [I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;,
            Ljava/io/IOException;
        }
    .end annotation

    .line 844
    move-object/from16 v6, p0

    const/4 v0, 0x0

    .line 845
    .local v0, "backwardsCallsUsed":I
    const/4 v1, 0x2

    new-array v2, v1, [Ljava/lang/String;

    const-string v1, "RVA"

    const/4 v7, 0x0

    aput-object v1, v2, v7

    const-string v1, "RIA"

    const/4 v8, 0x1

    aput-object v1, v2, v8

    .line 847
    .local v2, "RxA":[Ljava/lang/String;
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    .line 848
    const-string v3, "RuntimeVisibleAnnotations"

    invoke-virtual {v1, v3, v8}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v9

    .line 849
    .local v9, "rvaLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    .line 850
    const-string v3, "RuntimeInvisibleAnnotations"

    invoke-virtual {v1, v3, v8}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v10

    .line 852
    .local v10, "riaLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    invoke-static {v1, v9}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([[JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v11

    .line 853
    .local v11, "rvaCount":I
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    invoke-static {v1, v10}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([[JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v12

    .line 854
    .local v12, "riaCount":I
    filled-new-array {v11, v12}, [I

    move-result-object v3

    .line 855
    .local v3, "RxACount":[I
    filled-new-array {v7, v7}, [I

    move-result-object v1

    move-object v13, v1

    .line 856
    .local v13, "backwardsCalls":[I
    if-lez v11, :cond_1

    .line 857
    aget v1, p2, v7

    aput v1, v13, v7

    .line 858
    add-int/lit8 v0, v0, 0x1

    .line 859
    if-lez v12, :cond_0

    .line 860
    aget v1, p2, v8

    aput v1, v13, v8

    .line 861
    add-int/lit8 v0, v0, 0x1

    move v14, v0

    goto :goto_0

    .line 859
    :cond_0
    move v14, v0

    goto :goto_0

    .line 863
    :cond_1
    if-lez v12, :cond_2

    .line 864
    aget v1, p2, v7

    aput v1, v13, v8

    .line 865
    add-int/lit8 v0, v0, 0x1

    move v14, v0

    goto :goto_0

    .line 863
    :cond_2
    move v14, v0

    .line 867
    .end local v0    # "backwardsCallsUsed":I
    .local v14, "backwardsCallsUsed":I
    :goto_0
    const-string v5, "field"

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object v4, v13

    invoke-direct/range {v0 .. v5}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseMetadata(Ljava/io/InputStream;[Ljava/lang/String;[I[ILjava/lang/String;)[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;

    move-result-object v0

    .line 868
    .local v0, "mb":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    aget-object v1, v0, v7

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->getAttributes()Ljava/util/List;

    move-result-object v1

    .line 869
    .local v1, "rvaAttributes":Ljava/util/List;
    aget-object v4, v0, v8

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->getAttributes()Ljava/util/List;

    move-result-object v4

    .line 870
    .local v4, "riaAttributes":Ljava/util/List;
    const/4 v5, 0x0

    .line 871
    .local v5, "rvaAttributesIndex":I
    const/4 v7, 0x0

    .line 872
    .local v7, "riaAttributesIndex":I
    const/4 v8, 0x0

    .local v8, "i":I
    :goto_1
    iget-object v15, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    array-length v15, v15

    if-ge v8, v15, :cond_6

    .line 873
    const/4 v15, 0x0

    .local v15, "j":I
    :goto_2
    move-object/from16 v16, v0

    .end local v0    # "mb":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    .local v16, "mb":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    aget-object v0, v0, v8

    array-length v0, v0

    if-ge v15, v0, :cond_5

    .line 874
    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    aget-object v0, v0, v8

    move-object/from16 v17, v2

    move-object/from16 v18, v3

    .end local v2    # "RxA":[Ljava/lang/String;
    .end local v3    # "RxACount":[I
    .local v17, "RxA":[Ljava/lang/String;
    .local v18, "RxACount":[I
    aget-wide v2, v0, v15

    invoke-virtual {v9, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 875
    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldAttributes:[[Ljava/util/ArrayList;

    aget-object v0, v0, v8

    aget-object v0, v0, v15

    add-int/lit8 v2, v5, 0x1

    .end local v5    # "rvaAttributesIndex":I
    .local v2, "rvaAttributesIndex":I
    invoke-interface {v1, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move v5, v2

    .line 877
    .end local v2    # "rvaAttributesIndex":I
    .restart local v5    # "rvaAttributesIndex":I
    :cond_3
    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    aget-object v0, v0, v8

    aget-wide v2, v0, v15

    invoke-virtual {v10, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 878
    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldAttributes:[[Ljava/util/ArrayList;

    aget-object v0, v0, v8

    aget-object v0, v0, v15

    add-int/lit8 v2, v7, 0x1

    .end local v7    # "riaAttributesIndex":I
    .local v2, "riaAttributesIndex":I
    invoke-interface {v4, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move v7, v2

    .line 873
    .end local v2    # "riaAttributesIndex":I
    .restart local v7    # "riaAttributesIndex":I
    :cond_4
    add-int/lit8 v15, v15, 0x1

    move-object/from16 v0, v16

    move-object/from16 v2, v17

    move-object/from16 v3, v18

    goto :goto_2

    .end local v17    # "RxA":[Ljava/lang/String;
    .end local v18    # "RxACount":[I
    .local v2, "RxA":[Ljava/lang/String;
    .restart local v3    # "RxACount":[I
    :cond_5
    move-object/from16 v17, v2

    move-object/from16 v18, v3

    .line 872
    .end local v2    # "RxA":[Ljava/lang/String;
    .end local v3    # "RxACount":[I
    .end local v15    # "j":I
    .restart local v17    # "RxA":[Ljava/lang/String;
    .restart local v18    # "RxACount":[I
    add-int/lit8 v8, v8, 0x1

    move-object/from16 v0, v16

    goto :goto_1

    .line 882
    .end local v8    # "i":I
    .end local v16    # "mb":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    .end local v17    # "RxA":[Ljava/lang/String;
    .end local v18    # "RxACount":[I
    .restart local v0    # "mb":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    .restart local v2    # "RxA":[Ljava/lang/String;
    .restart local v3    # "RxACount":[I
    :cond_6
    return v14
.end method

.method private parseMetadata(Ljava/io/InputStream;[Ljava/lang/String;[I[ILjava/lang/String;)[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    .locals 27
    .param p1, "in"    # Ljava/io/InputStream;
    .param p2, "RxA"    # [Ljava/lang/String;
    .param p3, "RxACount"    # [I
    .param p4, "backwardsCallCounts"    # [I
    .param p5, "contextName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 887
    move-object/from16 v6, p0

    move-object/from16 v7, p1

    move-object/from16 v8, p2

    move-object/from16 v9, p5

    array-length v0, v8

    new-array v10, v0, [Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;

    .line 888
    .local v10, "mbg":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    const/4 v0, 0x0

    move v11, v0

    .local v11, "i":I
    :goto_0
    array-length v0, v8

    if-ge v11, v0, :cond_6

    .line 889
    new-instance v0, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;

    aget-object v1, v8, v11

    iget-object v2, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-direct {v0, v1, v2}, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;-><init>(Ljava/lang/String;Lorg/apache/commons/compress/harmony/unpack200/CpBands;)V

    aput-object v0, v10, v11

    .line 890
    aget-object v12, v8, v11

    .line 891
    .local v12, "rxa":Ljava/lang/String;
    const/16 v0, 0x50

    invoke-virtual {v12, v0}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    const-string v13, "_"

    if-ltz v0, :cond_0

    .line 892
    aget-object v0, v10, v11

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "_param_NB"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lorg/apache/commons/compress/harmony/pack200/Codec;->BYTE1:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    aget v3, p3, v11

    invoke-virtual {v6, v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v1

    iput-object v1, v0, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->param_NB:[I

    .line 894
    :cond_0
    const/4 v0, 0x0

    .line 895
    .local v0, "pairCount":I
    const-string v1, "AD"

    invoke-virtual {v12, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    .line 896
    aget-object v1, v10, v11

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "_anno_N"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    sget-object v3, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    aget v4, p3, v11

    invoke-virtual {v6, v2, v7, v3, v4}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v2

    iput-object v2, v1, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->anno_N:[I

    .line 897
    aget-object v1, v10, v11

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "_type_RS"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    sget-object v3, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    aget-object v4, v10, v11

    iget-object v4, v4, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->anno_N:[I

    invoke-virtual {v6, v2, v7, v3, v4}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseCPSignatureReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v2

    iput-object v2, v1, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->type_RS:[[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    .line 899
    aget-object v1, v10, v11

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "_pair_N"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    sget-object v3, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    aget-object v4, v10, v11

    iget-object v4, v4, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->anno_N:[I

    invoke-virtual {v6, v2, v7, v3, v4}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v2

    iput-object v2, v1, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->pair_N:[[I

    .line 900
    const/4 v1, 0x0

    .local v1, "j":I
    :goto_1
    aget-object v2, v10, v11

    iget-object v2, v2, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->pair_N:[[I

    array-length v2, v2

    if-ge v1, v2, :cond_2

    .line 901
    const/4 v2, 0x0

    .local v2, "k":I
    :goto_2
    aget-object v3, v10, v11

    iget-object v3, v3, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->pair_N:[[I

    aget-object v3, v3, v1

    array-length v3, v3

    if-ge v2, v3, :cond_1

    .line 902
    aget-object v3, v10, v11

    iget-object v3, v3, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->pair_N:[[I

    aget-object v3, v3, v1

    aget v3, v3, v2

    add-int/2addr v0, v3

    .line 901
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 900
    .end local v2    # "k":I
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 906
    .end local v1    # "j":I
    :cond_2
    aget-object v1, v10, v11

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "_name_RU"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    sget-object v3, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v2, v7, v3, v0}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseCPUTF8References(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v2

    iput-object v2, v1, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->name_RU:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move v14, v0

    goto :goto_3

    .line 909
    :cond_3
    aget v0, p3, v11

    move v14, v0

    .line 911
    .end local v0    # "pairCount":I
    .local v14, "pairCount":I
    :goto_3
    aget-object v0, v10, v11

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "_T"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lorg/apache/commons/compress/harmony/pack200/Codec;->BYTE1:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    aget v3, p4, v11

    add-int/2addr v3, v14

    invoke-virtual {v6, v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v1

    iput-object v1, v0, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->T:[I

    .line 913
    const/4 v0, 0x0

    .local v0, "ICount":I
    const/4 v1, 0x0

    .local v1, "DCount":I
    const/4 v2, 0x0

    .local v2, "FCount":I
    const/4 v3, 0x0

    .local v3, "JCount":I
    const/4 v4, 0x0

    .local v4, "cCount":I
    const/4 v5, 0x0

    .local v5, "eCount":I
    const/4 v15, 0x0

    .local v15, "sCount":I
    const/16 v16, 0x0

    .line 914
    .local v16, "arrayCount":I
    const/16 v17, 0x0

    .line 915
    .local v17, "atCount":I
    const/16 v18, 0x0

    move/from16 v8, v17

    move/from16 v17, v14

    move/from16 v14, v18

    move/from16 v25, v15

    move v15, v0

    move/from16 v0, v16

    move/from16 v16, v5

    move v5, v1

    move/from16 v1, v25

    move/from16 v26, v4

    move v4, v2

    move/from16 v2, v26

    .local v0, "arrayCount":I
    .local v1, "sCount":I
    .local v2, "cCount":I
    .local v4, "FCount":I
    .local v5, "DCount":I
    .local v8, "atCount":I
    .local v14, "j":I
    .local v15, "ICount":I
    .local v16, "eCount":I
    .local v17, "pairCount":I
    :goto_4
    aget-object v6, v10, v11

    iget-object v6, v6, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->T:[I

    array-length v6, v6

    if-ge v14, v6, :cond_4

    .line 916
    aget-object v6, v10, v11

    iget-object v6, v6, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->T:[I

    aget v6, v6, v14

    int-to-char v6, v6

    .line 917
    .local v6, "c":C
    sparse-switch v6, :sswitch_data_0

    goto :goto_5

    .line 941
    :sswitch_0
    add-int/lit8 v1, v1, 0x1

    .line 942
    goto :goto_5

    .line 938
    :sswitch_1
    add-int/lit8 v16, v16, 0x1

    .line 939
    goto :goto_5

    .line 935
    :sswitch_2
    add-int/lit8 v2, v2, 0x1

    .line 936
    goto :goto_5

    .line 944
    :sswitch_3
    add-int/lit8 v0, v0, 0x1

    .line 945
    goto :goto_5

    .line 932
    :sswitch_4
    add-int/lit8 v3, v3, 0x1

    .line 933
    goto :goto_5

    .line 929
    :sswitch_5
    add-int/lit8 v4, v4, 0x1

    .line 930
    goto :goto_5

    .line 926
    :sswitch_6
    add-int/lit8 v5, v5, 0x1

    .line 927
    goto :goto_5

    .line 923
    :sswitch_7
    add-int/lit8 v15, v15, 0x1

    .line 924
    goto :goto_5

    .line 947
    :sswitch_8
    add-int/lit8 v8, v8, 0x1

    .line 915
    .end local v6    # "c":C
    :goto_5
    add-int/lit8 v14, v14, 0x1

    move-object/from16 v6, p0

    goto :goto_4

    .line 951
    .end local v14    # "j":I
    :cond_4
    aget-object v6, v10, v11

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v14, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    move/from16 v18, v0

    .end local v0    # "arrayCount":I
    .local v18, "arrayCount":I
    const-string v0, "_caseI_KI"

    invoke-virtual {v14, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v14, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    move/from16 v19, v8

    move-object/from16 v8, p0

    .end local v8    # "atCount":I
    .local v19, "atCount":I
    invoke-virtual {v8, v0, v7, v14, v15}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseCPIntReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPInteger;

    move-result-object v0

    iput-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->caseI_KI:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPInteger;

    .line 952
    aget-object v0, v10, v11

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v14, "_caseD_KD"

    invoke-virtual {v6, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    sget-object v14, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v8, v6, v7, v14, v5}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseCPDoubleReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPDouble;

    move-result-object v6

    iput-object v6, v0, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->caseD_KD:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPDouble;

    .line 954
    aget-object v0, v10, v11

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v14, "_caseF_KF"

    invoke-virtual {v6, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    sget-object v14, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v8, v6, v7, v14, v4}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseCPFloatReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPFloat;

    move-result-object v6

    iput-object v6, v0, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->caseF_KF:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPFloat;

    .line 956
    aget-object v0, v10, v11

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v14, "_caseJ_KJ"

    invoke-virtual {v6, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    sget-object v14, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v8, v6, v7, v14, v3}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseCPLongReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPLong;

    move-result-object v6

    iput-object v6, v0, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->caseJ_KJ:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPLong;

    .line 957
    aget-object v0, v10, v11

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v14, "_casec_RS"

    invoke-virtual {v6, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    sget-object v14, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v8, v6, v7, v14, v2}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseCPSignatureReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v6

    iput-object v6, v0, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->casec_RS:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    .line 959
    aget-object v6, v10, v11

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v14, "_caseet_RS"

    invoke-virtual {v0, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    sget-object v20, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    iget-object v0, v8, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    .line 960
    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getCpSignature()[Ljava/lang/String;

    move-result-object v21

    .line 959
    move/from16 v22, v15

    move/from16 v15, v18

    .end local v18    # "arrayCount":I
    .local v15, "arrayCount":I
    .local v22, "ICount":I
    move-object/from16 v0, p0

    move v15, v1

    .end local v1    # "sCount":I
    .local v15, "sCount":I
    .restart local v18    # "arrayCount":I
    move-object v1, v14

    move v14, v2

    .end local v2    # "cCount":I
    .local v14, "cCount":I
    move-object/from16 v2, p1

    move/from16 v23, v3

    .end local v3    # "JCount":I
    .local v23, "JCount":I
    move-object/from16 v3, v20

    move/from16 v20, v4

    .end local v4    # "FCount":I
    .local v20, "FCount":I
    move/from16 v4, v16

    move/from16 v24, v5

    .end local v5    # "DCount":I
    .local v24, "DCount":I
    move-object/from16 v5, v21

    invoke-virtual/range {v0 .. v5}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I[Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    iput-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->caseet_RS:[Ljava/lang/String;

    .line 961
    aget-object v6, v10, v11

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "_caseec_RU"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sget-object v3, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    iget-object v0, v8, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    .line 962
    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getCpUTF8()[Ljava/lang/String;

    move-result-object v5

    .line 961
    move-object/from16 v0, p0

    invoke-virtual/range {v0 .. v5}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I[Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    iput-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->caseec_RU:[Ljava/lang/String;

    .line 963
    aget-object v0, v10, v11

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "_cases_RU"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v8, v1, v7, v2, v15}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseCPUTF8References(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v1

    iput-object v1, v0, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->cases_RU:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    .line 964
    aget-object v0, v10, v11

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "_casearray_N"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    move/from16 v3, v18

    .end local v18    # "arrayCount":I
    .local v3, "arrayCount":I
    invoke-virtual {v8, v1, v7, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v1

    iput-object v1, v0, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->casearray_N:[I

    .line 966
    aget-object v0, v10, v11

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "_nesttype_RS"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    move/from16 v4, v19

    .end local v19    # "atCount":I
    .local v4, "atCount":I
    invoke-virtual {v8, v1, v7, v2, v4}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseCPUTF8References(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v1

    iput-object v1, v0, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->nesttype_RS:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    .line 968
    aget-object v0, v10, v11

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "_nestpair_N"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v8, v1, v7, v2, v4}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v1

    iput-object v1, v0, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->nestpair_N:[I

    .line 969
    const/4 v0, 0x0

    .line 970
    .local v0, "nestPairCount":I
    const/4 v1, 0x0

    .local v1, "j":I
    :goto_6
    aget-object v2, v10, v11

    iget-object v2, v2, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->nestpair_N:[I

    array-length v2, v2

    if-ge v1, v2, :cond_5

    .line 971
    aget-object v2, v10, v11

    iget-object v2, v2, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->nestpair_N:[I

    aget v2, v2, v1

    add-int/2addr v0, v2

    .line 970
    add-int/lit8 v1, v1, 0x1

    goto :goto_6

    .line 973
    .end local v1    # "j":I
    :cond_5
    aget-object v1, v10, v11

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v5, "_nestname_RU"

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    sget-object v5, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v8, v2, v7, v5, v0}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseCPUTF8References(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v2

    iput-object v2, v1, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->nestname_RU:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    .line 888
    .end local v0    # "nestPairCount":I
    .end local v3    # "arrayCount":I
    .end local v4    # "atCount":I
    .end local v12    # "rxa":Ljava/lang/String;
    .end local v14    # "cCount":I
    .end local v15    # "sCount":I
    .end local v16    # "eCount":I
    .end local v17    # "pairCount":I
    .end local v20    # "FCount":I
    .end local v22    # "ICount":I
    .end local v23    # "JCount":I
    .end local v24    # "DCount":I
    add-int/lit8 v11, v11, 0x1

    move-object v6, v8

    move-object/from16 v8, p2

    goto/16 :goto_0

    :cond_6
    move-object v8, v6

    .line 976
    .end local v11    # "i":I
    return-object v10

    nop

    :sswitch_data_0
    .sparse-switch
        0x40 -> :sswitch_8
        0x42 -> :sswitch_7
        0x43 -> :sswitch_7
        0x44 -> :sswitch_6
        0x46 -> :sswitch_5
        0x49 -> :sswitch_7
        0x4a -> :sswitch_4
        0x53 -> :sswitch_7
        0x5a -> :sswitch_7
        0x5b -> :sswitch_3
        0x63 -> :sswitch_2
        0x65 -> :sswitch_1
        0x73 -> :sswitch_0
    .end sparse-switch
.end method

.method private parseMethodAttrBands(Ljava/io/InputStream;)V
    .locals 32
    .param p1, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 285
    move-object/from16 v6, p0

    move-object/from16 v7, p1

    iget-object v3, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classMethodCount:[I

    sget-object v4, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->options:Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->hasMethodFlagsHi()Z

    move-result v5

    const-string v1, "method_flags"

    move-object/from16 v0, p0

    move-object/from16 v2, p1

    invoke-virtual/range {v0 .. v5}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseFlags(Ljava/lang/String;Ljava/io/InputStream;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;Z)[[J

    move-result-object v0

    iput-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodFlags:[[J

    .line 286
    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodFlags:[[J

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countBit16([[J)I

    move-result v0

    .line 287
    .local v0, "methodAttrCount":I
    const-string v1, "method_attr_count"

    sget-object v2, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v1, v7, v2, v0}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v1

    .line 288
    .local v1, "methodAttrCounts":[I
    const-string v2, "method_attr_indexes"

    sget-object v3, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v2, v7, v3, v1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v2

    .line 289
    .local v2, "methodAttrIndexes":[[I
    iget-object v3, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodFlags:[[J

    const/4 v4, 0x2

    invoke-direct {v6, v2, v3, v4}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getCallCount([[I[[JI)I

    move-result v3

    .line 290
    .local v3, "callCount":I
    const-string v5, "method_attr_calls"

    sget-object v8, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v5, v7, v8, v3}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v5

    iput-object v5, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAttrCalls:[I

    .line 293
    iget v5, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classCount:I

    new-array v5, v5, [[Ljava/util/ArrayList;

    iput-object v5, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAttributes:[[Ljava/util/ArrayList;

    .line 294
    const/4 v5, 0x0

    .local v5, "i":I
    :goto_0
    iget v8, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classCount:I

    if-ge v5, v8, :cond_1

    .line 295
    iget-object v8, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAttributes:[[Ljava/util/ArrayList;

    iget-object v9, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodFlags:[[J

    aget-object v9, v9, v5

    array-length v9, v9

    new-array v9, v9, [Ljava/util/ArrayList;

    aput-object v9, v8, v5

    .line 296
    const/4 v8, 0x0

    .local v8, "j":I
    :goto_1
    iget-object v9, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodFlags:[[J

    aget-object v9, v9, v5

    array-length v9, v9

    if-ge v8, v9, :cond_0

    .line 297
    iget-object v9, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAttributes:[[Ljava/util/ArrayList;

    aget-object v9, v9, v5

    new-instance v10, Ljava/util/ArrayList;

    invoke-direct {v10}, Ljava/util/ArrayList;-><init>()V

    aput-object v10, v9, v8

    .line 296
    add-int/lit8 v8, v8, 0x1

    goto :goto_1

    .line 294
    .end local v8    # "j":I
    :cond_0
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 302
    .end local v5    # "i":I
    :cond_1
    iget-object v5, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    const-string v8, "Exceptions"

    invoke-virtual {v5, v8, v4}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v5

    .line 304
    .local v5, "methodExceptionsLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    iget-object v8, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodFlags:[[J

    invoke-static {v8, v5}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([[JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v8

    .line 305
    .local v8, "count":I
    const-string v9, "method_Exceptions_n"

    sget-object v10, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v9, v7, v10, v8}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v9

    .line 306
    .local v9, "numExceptions":[I
    const-string v10, "method_Exceptions_RC"

    sget-object v11, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v10, v7, v11, v9}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v10

    .line 309
    .local v10, "methodExceptionsRS":[[I
    iget-object v11, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    const-string v12, "Signature"

    invoke-virtual {v11, v12, v4}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v11

    .line 311
    .local v11, "methodSignatureLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    iget-object v12, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodFlags:[[J

    invoke-static {v12, v11}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([[JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v12

    .line 312
    .local v12, "count1":I
    const-string v13, "method_signature_RS"

    sget-object v14, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {v6, v13, v7, v14, v12}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v13

    .line 314
    .local v13, "methodSignatureRS":[I
    iget-object v14, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    const-string v15, "Deprecated"

    invoke-virtual {v14, v15, v4}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v14

    .line 318
    .local v14, "deprecatedLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    const/4 v15, 0x0

    .line 319
    .local v15, "methodExceptionsIndex":I
    const/16 v16, 0x0

    .line 320
    .local v16, "methodSignatureIndex":I
    const/16 v17, 0x0

    move/from16 v4, v17

    .local v4, "i":I
    :goto_2
    move/from16 v18, v0

    .end local v0    # "methodAttrCount":I
    .local v18, "methodAttrCount":I
    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAttributes:[[Ljava/util/ArrayList;

    array-length v0, v0

    if-ge v4, v0, :cond_9

    .line 321
    const/4 v0, 0x0

    .local v0, "j":I
    :goto_3
    move-object/from16 v19, v1

    .end local v1    # "methodAttrCounts":[I
    .local v19, "methodAttrCounts":[I
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAttributes:[[Ljava/util/ArrayList;

    aget-object v1, v1, v4

    array-length v1, v1

    if-ge v0, v1, :cond_8

    .line 322
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodFlags:[[J

    aget-object v1, v1, v4

    move-object/from16 v20, v2

    move/from16 v21, v3

    .end local v2    # "methodAttrIndexes":[[I
    .end local v3    # "callCount":I
    .local v20, "methodAttrIndexes":[[I
    .local v21, "callCount":I
    aget-wide v2, v1, v0

    .line 323
    .local v2, "flag":J
    invoke-virtual {v5, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 324
    aget v1, v9, v15

    .line 325
    .local v1, "n":I
    aget-object v22, v10, v15

    .line 326
    .local v22, "exceptions":[I
    move-object/from16 v23, v5

    .end local v5    # "methodExceptionsLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v23, "methodExceptionsLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    new-array v5, v1, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;

    .line 327
    .local v5, "exceptionClasses":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;
    const/16 v24, 0x0

    move/from16 v25, v8

    move/from16 v8, v24

    .local v8, "k":I
    .local v25, "count":I
    :goto_4
    if-ge v8, v1, :cond_2

    .line 328
    move/from16 v24, v1

    .end local v1    # "n":I
    .local v24, "n":I
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-object/from16 v26, v9

    .end local v9    # "numExceptions":[I
    .local v26, "numExceptions":[I
    aget v9, v22, v8

    invoke-virtual {v1, v9}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpClassValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;

    move-result-object v1

    aput-object v1, v5, v8

    .line 327
    add-int/lit8 v8, v8, 0x1

    move/from16 v1, v24

    move-object/from16 v9, v26

    goto :goto_4

    .end local v24    # "n":I
    .end local v26    # "numExceptions":[I
    .restart local v1    # "n":I
    .restart local v9    # "numExceptions":[I
    :cond_2
    move/from16 v24, v1

    move-object/from16 v26, v9

    .line 330
    .end local v1    # "n":I
    .end local v8    # "k":I
    .end local v9    # "numExceptions":[I
    .restart local v24    # "n":I
    .restart local v26    # "numExceptions":[I
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAttributes:[[Ljava/util/ArrayList;

    aget-object v1, v1, v4

    aget-object v1, v1, v0

    new-instance v8, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ExceptionsAttribute;

    invoke-direct {v8, v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ExceptionsAttribute;-><init>([Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;)V

    invoke-virtual {v1, v8}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 331
    add-int/lit8 v15, v15, 0x1

    goto :goto_5

    .line 323
    .end local v22    # "exceptions":[I
    .end local v23    # "methodExceptionsLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v24    # "n":I
    .end local v25    # "count":I
    .end local v26    # "numExceptions":[I
    .local v5, "methodExceptionsLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v8, "count":I
    .restart local v9    # "numExceptions":[I
    :cond_3
    move-object/from16 v23, v5

    move/from16 v25, v8

    move-object/from16 v26, v9

    .line 333
    .end local v5    # "methodExceptionsLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v8    # "count":I
    .end local v9    # "numExceptions":[I
    .restart local v23    # "methodExceptionsLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v25    # "count":I
    .restart local v26    # "numExceptions":[I
    :goto_5
    invoke-virtual {v11, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v1

    if-eqz v1, :cond_6

    .line 335
    aget v1, v13, v16

    int-to-long v8, v1

    .line 336
    .local v8, "result":J
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodDescr:[[Ljava/lang/String;

    aget-object v1, v1, v4

    aget-object v1, v1, v0

    .line 337
    .local v1, "desc":Ljava/lang/String;
    const/16 v5, 0x3a

    invoke-virtual {v1, v5}, Ljava/lang/String;->indexOf(I)I

    move-result v5

    .line 338
    .local v5, "colon":I
    move-object/from16 v22, v10

    .end local v10    # "methodExceptionsRS":[[I
    .local v22, "methodExceptionsRS":[[I
    add-int/lit8 v10, v5, 0x1

    invoke-virtual {v1, v10}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v10

    .line 341
    .local v10, "type":Ljava/lang/String;
    move-object/from16 v24, v1

    .end local v1    # "desc":Ljava/lang/String;
    .local v24, "desc":Ljava/lang/String;
    const-string v1, "B"

    invoke-virtual {v10, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    const-string v1, "H"

    invoke-virtual {v10, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 342
    :cond_4
    const-string v10, "I"

    .line 344
    :cond_5
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    .line 345
    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getConstantPool()Lorg/apache/commons/compress/harmony/unpack200/SegmentConstantPool;

    move-result-object v1

    .line 344
    invoke-virtual {v11, v8, v9, v10, v1}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->getValue(JLjava/lang/String;Lorg/apache/commons/compress/harmony/unpack200/SegmentConstantPool;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;

    move-result-object v1

    check-cast v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    .line 346
    .local v1, "value":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    move/from16 v27, v5

    .end local v5    # "colon":I
    .local v27, "colon":I
    iget-object v5, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAttributes:[[Ljava/util/ArrayList;

    aget-object v5, v5, v4

    aget-object v5, v5, v0

    move-wide/from16 v28, v8

    .end local v8    # "result":J
    .local v28, "result":J
    new-instance v8, Lorg/apache/commons/compress/harmony/unpack200/bytecode/SignatureAttribute;

    invoke-direct {v8, v1}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/SignatureAttribute;-><init>(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;)V

    invoke-virtual {v5, v8}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 347
    add-int/lit8 v16, v16, 0x1

    goto :goto_6

    .line 333
    .end local v1    # "value":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    .end local v22    # "methodExceptionsRS":[[I
    .end local v24    # "desc":Ljava/lang/String;
    .end local v27    # "colon":I
    .end local v28    # "result":J
    .local v10, "methodExceptionsRS":[[I
    :cond_6
    move-object/from16 v22, v10

    .line 349
    .end local v10    # "methodExceptionsRS":[[I
    .restart local v22    # "methodExceptionsRS":[[I
    :goto_6
    invoke-virtual {v14, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v1

    if-eqz v1, :cond_7

    .line 350
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAttributes:[[Ljava/util/ArrayList;

    aget-object v1, v1, v4

    aget-object v1, v1, v0

    new-instance v5, Lorg/apache/commons/compress/harmony/unpack200/bytecode/DeprecatedAttribute;

    invoke-direct {v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/DeprecatedAttribute;-><init>()V

    invoke-virtual {v1, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 321
    .end local v2    # "flag":J
    :cond_7
    add-int/lit8 v0, v0, 0x1

    move-object/from16 v1, v19

    move-object/from16 v2, v20

    move/from16 v3, v21

    move-object/from16 v10, v22

    move-object/from16 v5, v23

    move/from16 v8, v25

    move-object/from16 v9, v26

    goto/16 :goto_3

    .end local v20    # "methodAttrIndexes":[[I
    .end local v21    # "callCount":I
    .end local v22    # "methodExceptionsRS":[[I
    .end local v23    # "methodExceptionsLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v25    # "count":I
    .end local v26    # "numExceptions":[I
    .local v2, "methodAttrIndexes":[[I
    .restart local v3    # "callCount":I
    .local v5, "methodExceptionsLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v8, "count":I
    .restart local v9    # "numExceptions":[I
    .restart local v10    # "methodExceptionsRS":[[I
    :cond_8
    move-object/from16 v20, v2

    move/from16 v21, v3

    move-object/from16 v23, v5

    move/from16 v25, v8

    move-object/from16 v26, v9

    move-object/from16 v22, v10

    .line 320
    .end local v0    # "j":I
    .end local v2    # "methodAttrIndexes":[[I
    .end local v3    # "callCount":I
    .end local v5    # "methodExceptionsLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v8    # "count":I
    .end local v9    # "numExceptions":[I
    .end local v10    # "methodExceptionsRS":[[I
    .restart local v20    # "methodAttrIndexes":[[I
    .restart local v21    # "callCount":I
    .restart local v22    # "methodExceptionsRS":[[I
    .restart local v23    # "methodExceptionsLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v25    # "count":I
    .restart local v26    # "numExceptions":[I
    add-int/lit8 v4, v4, 0x1

    move/from16 v0, v18

    move-object/from16 v1, v19

    goto/16 :goto_2

    .end local v19    # "methodAttrCounts":[I
    .end local v20    # "methodAttrIndexes":[[I
    .end local v21    # "callCount":I
    .end local v22    # "methodExceptionsRS":[[I
    .end local v23    # "methodExceptionsLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v25    # "count":I
    .end local v26    # "numExceptions":[I
    .local v1, "methodAttrCounts":[I
    .restart local v2    # "methodAttrIndexes":[[I
    .restart local v3    # "callCount":I
    .restart local v5    # "methodExceptionsLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v8    # "count":I
    .restart local v9    # "numExceptions":[I
    .restart local v10    # "methodExceptionsRS":[[I
    :cond_9
    move-object/from16 v19, v1

    move-object/from16 v20, v2

    move/from16 v21, v3

    move-object/from16 v23, v5

    move/from16 v25, v8

    move-object/from16 v26, v9

    move-object/from16 v22, v10

    .line 356
    .end local v1    # "methodAttrCounts":[I
    .end local v2    # "methodAttrIndexes":[[I
    .end local v3    # "callCount":I
    .end local v4    # "i":I
    .end local v5    # "methodExceptionsLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v8    # "count":I
    .end local v9    # "numExceptions":[I
    .end local v10    # "methodExceptionsRS":[[I
    .restart local v19    # "methodAttrCounts":[I
    .restart local v20    # "methodAttrIndexes":[[I
    .restart local v21    # "callCount":I
    .restart local v22    # "methodExceptionsRS":[[I
    .restart local v23    # "methodExceptionsLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v25    # "count":I
    .restart local v26    # "numExceptions":[I
    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAttrCalls:[I

    invoke-direct {v6, v7, v0}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseMethodMetadataBands(Ljava/io/InputStream;[I)I

    move-result v0

    .line 359
    .local v0, "backwardsCallsUsed":I
    move v1, v0

    .line 360
    .local v1, "backwardsCallIndex":I
    iget-object v2, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->options:Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->hasMethodFlagsHi()Z

    move-result v2

    if-eqz v2, :cond_a

    const/16 v2, 0x3e

    goto :goto_7

    :cond_a
    const/16 v2, 0x1f

    .line 361
    .local v2, "limit":I
    :goto_7
    add-int/lit8 v3, v2, 0x1

    new-array v3, v3, [Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    .line 362
    .local v3, "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    add-int/lit8 v4, v2, 0x1

    new-array v4, v4, [I

    .line 363
    .local v4, "counts":[I
    add-int/lit8 v5, v2, 0x1

    new-array v5, v5, [Ljava/util/List;

    .line 364
    .local v5, "otherAttributes":[Ljava/util/List;
    const/4 v8, 0x0

    .local v8, "i":I
    :goto_8
    if-ge v8, v2, :cond_c

    .line 365
    iget-object v9, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    const/4 v10, 0x2

    invoke-virtual {v9, v8, v10}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(II)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v9

    .line 366
    .local v9, "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    if-eqz v9, :cond_b

    invoke-virtual {v9}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->isDefaultLayout()Z

    move-result v17

    if-nez v17, :cond_b

    .line 367
    aput-object v9, v3, v8

    .line 368
    iget-object v10, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodFlags:[[J

    invoke-static {v10, v9}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([[JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v10

    aput v10, v4, v8

    .line 364
    .end local v9    # "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :cond_b
    add-int/lit8 v8, v8, 0x1

    goto :goto_8

    .line 371
    .end local v8    # "i":I
    :cond_c
    const/4 v8, 0x0

    .restart local v8    # "i":I
    :goto_9
    array-length v9, v4

    if-ge v8, v9, :cond_f

    .line 372
    aget v9, v4, v8

    if-lez v9, :cond_e

    .line 373
    iget-object v9, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    aget-object v10, v3, v8

    invoke-virtual {v9, v10}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeBands(Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;)Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;

    move-result-object v9

    .line 374
    .local v9, "bands":Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;
    aget v10, v4, v8

    invoke-virtual {v9, v7, v10}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;->parseAttributes(Ljava/io/InputStream;I)Ljava/util/List;

    move-result-object v10

    aput-object v10, v5, v8

    .line 375
    aget-object v10, v3, v8

    invoke-virtual {v10}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->numBackwardsCallables()I

    move-result v10

    .line 376
    .local v10, "numBackwardsCallables":I
    if-lez v10, :cond_d

    .line 377
    move/from16 v24, v0

    .end local v0    # "backwardsCallsUsed":I
    .local v24, "backwardsCallsUsed":I
    new-array v0, v10, [I

    .line 378
    .local v0, "backwardsCalls":[I
    move/from16 v27, v2

    .end local v2    # "limit":I
    .local v27, "limit":I
    iget-object v2, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAttrCalls:[I

    move-object/from16 v28, v4

    const/4 v4, 0x0

    .end local v4    # "counts":[I
    .local v28, "counts":[I
    invoke-static {v2, v1, v0, v4, v10}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 379
    invoke-virtual {v9, v0}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;->setBackwardsCalls([I)V

    .line 380
    add-int/2addr v1, v10

    goto :goto_a

    .line 376
    .end local v24    # "backwardsCallsUsed":I
    .end local v27    # "limit":I
    .end local v28    # "counts":[I
    .local v0, "backwardsCallsUsed":I
    .restart local v2    # "limit":I
    .restart local v4    # "counts":[I
    :cond_d
    move/from16 v24, v0

    move/from16 v27, v2

    move-object/from16 v28, v4

    .end local v0    # "backwardsCallsUsed":I
    .end local v2    # "limit":I
    .end local v4    # "counts":[I
    .restart local v24    # "backwardsCallsUsed":I
    .restart local v27    # "limit":I
    .restart local v28    # "counts":[I
    goto :goto_a

    .line 372
    .end local v9    # "bands":Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;
    .end local v10    # "numBackwardsCallables":I
    .end local v24    # "backwardsCallsUsed":I
    .end local v27    # "limit":I
    .end local v28    # "counts":[I
    .restart local v0    # "backwardsCallsUsed":I
    .restart local v2    # "limit":I
    .restart local v4    # "counts":[I
    :cond_e
    move/from16 v24, v0

    move/from16 v27, v2

    move-object/from16 v28, v4

    .line 371
    .end local v0    # "backwardsCallsUsed":I
    .end local v2    # "limit":I
    .end local v4    # "counts":[I
    .restart local v24    # "backwardsCallsUsed":I
    .restart local v27    # "limit":I
    .restart local v28    # "counts":[I
    :goto_a
    add-int/lit8 v8, v8, 0x1

    move/from16 v0, v24

    move/from16 v2, v27

    move-object/from16 v4, v28

    goto :goto_9

    .end local v24    # "backwardsCallsUsed":I
    .end local v27    # "limit":I
    .end local v28    # "counts":[I
    .restart local v0    # "backwardsCallsUsed":I
    .restart local v2    # "limit":I
    .restart local v4    # "counts":[I
    :cond_f
    move/from16 v24, v0

    move/from16 v27, v2

    move-object/from16 v28, v4

    .line 386
    .end local v0    # "backwardsCallsUsed":I
    .end local v2    # "limit":I
    .end local v4    # "counts":[I
    .end local v8    # "i":I
    .restart local v24    # "backwardsCallsUsed":I
    .restart local v27    # "limit":I
    .restart local v28    # "counts":[I
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_b
    iget-object v2, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAttributes:[[Ljava/util/ArrayList;

    array-length v2, v2

    if-ge v0, v2, :cond_14

    .line 387
    const/4 v2, 0x0

    .local v2, "j":I
    :goto_c
    iget-object v4, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAttributes:[[Ljava/util/ArrayList;

    aget-object v4, v4, v0

    array-length v4, v4

    if-ge v2, v4, :cond_13

    .line 388
    iget-object v4, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodFlags:[[J

    aget-object v4, v4, v0

    aget-wide v8, v4, v2

    .line 389
    .local v8, "flag":J
    const/4 v4, 0x0

    .line 390
    .local v4, "othersAddedAtStart":I
    const/4 v10, 0x0

    .local v10, "k":I
    :goto_d
    move/from16 v29, v1

    .end local v1    # "backwardsCallIndex":I
    .local v29, "backwardsCallIndex":I
    array-length v1, v3

    if-ge v10, v1, :cond_12

    .line 391
    aget-object v1, v3, v10

    if-eqz v1, :cond_11

    aget-object v1, v3, v10

    invoke-virtual {v1, v8, v9}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v1

    if-eqz v1, :cond_11

    .line 393
    aget-object v1, v3, v10

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->getIndex()I

    move-result v1

    move-object/from16 v30, v3

    .end local v3    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v30, "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    const/16 v3, 0xf

    if-ge v1, v3, :cond_10

    .line 394
    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAttributes:[[Ljava/util/ArrayList;

    aget-object v1, v1, v0

    aget-object v1, v1, v2

    add-int/lit8 v3, v4, 0x1

    move/from16 v31, v3

    .end local v4    # "othersAddedAtStart":I
    .local v31, "othersAddedAtStart":I
    aget-object v3, v5, v10

    const/4 v7, 0x0

    invoke-interface {v3, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v1, v4, v3}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    move/from16 v4, v31

    goto :goto_e

    .line 396
    .end local v31    # "othersAddedAtStart":I
    .restart local v4    # "othersAddedAtStart":I
    :cond_10
    const/4 v7, 0x0

    iget-object v1, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAttributes:[[Ljava/util/ArrayList;

    aget-object v1, v1, v0

    aget-object v1, v1, v2

    aget-object v3, v5, v10

    invoke-interface {v3, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 398
    :goto_e
    aget-object v1, v5, v10

    invoke-interface {v1, v7}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    goto :goto_f

    .line 391
    .end local v30    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v3    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :cond_11
    move-object/from16 v30, v3

    const/4 v7, 0x0

    .line 390
    .end local v3    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v30    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :goto_f
    add-int/lit8 v10, v10, 0x1

    move-object/from16 v7, p1

    move/from16 v1, v29

    move-object/from16 v3, v30

    goto :goto_d

    .end local v30    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v3    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :cond_12
    move-object/from16 v30, v3

    const/4 v7, 0x0

    .line 387
    .end local v3    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v4    # "othersAddedAtStart":I
    .end local v8    # "flag":J
    .end local v10    # "k":I
    .restart local v30    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    add-int/lit8 v2, v2, 0x1

    move-object/from16 v7, p1

    move/from16 v1, v29

    goto :goto_c

    .end local v29    # "backwardsCallIndex":I
    .end local v30    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v1    # "backwardsCallIndex":I
    .restart local v3    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :cond_13
    move/from16 v29, v1

    move-object/from16 v30, v3

    const/4 v7, 0x0

    .line 386
    .end local v1    # "backwardsCallIndex":I
    .end local v2    # "j":I
    .end local v3    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v29    # "backwardsCallIndex":I
    .restart local v30    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    add-int/lit8 v0, v0, 0x1

    move-object/from16 v7, p1

    goto :goto_b

    .line 403
    .end local v0    # "i":I
    .end local v29    # "backwardsCallIndex":I
    .end local v30    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v1    # "backwardsCallIndex":I
    .restart local v3    # "otherLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :cond_14
    return-void
.end method

.method private parseMethodBands(Ljava/io/InputStream;)V
    .locals 3
    .param p1, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 279
    sget-object v0, Lorg/apache/commons/compress/harmony/pack200/Codec;->MDELTA5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    iget-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classMethodCount:[I

    const-string v2, "method_descr"

    invoke-virtual {p0, v2, p1, v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodDescrInts:[[I

    .line 280
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodDescrInts:[[I

    iget-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getCpDescriptor()[Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getReferences([[I[Ljava/lang/String;)[[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodDescr:[[Ljava/lang/String;

    .line 281
    invoke-direct {p0, p1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseMethodAttrBands(Ljava/io/InputStream;)V

    .line 282
    return-void
.end method

.method private parseMethodMetadataBands(Ljava/io/InputStream;[I)I
    .locals 22
    .param p1, "in"    # Ljava/io/InputStream;
    .param p2, "methodAttrCalls"    # [I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;,
            Ljava/io/IOException;
        }
    .end annotation

    .line 981
    move-object/from16 v6, p0

    const/4 v0, 0x0

    .line 982
    .local v0, "backwardsCallsUsed":I
    const/4 v1, 0x5

    new-array v2, v1, [Ljava/lang/String;

    const-string v3, "RVA"

    const/4 v7, 0x0

    aput-object v3, v2, v7

    const-string v3, "RIA"

    const/4 v4, 0x1

    aput-object v3, v2, v4

    const-string v3, "RVPA"

    const/4 v5, 0x2

    aput-object v3, v2, v5

    const-string v3, "RIPA"

    const/4 v8, 0x3

    aput-object v3, v2, v8

    const-string v3, "AD"

    const/4 v9, 0x4

    aput-object v3, v2, v9

    move-object v10, v2

    .line 983
    .local v10, "RxA":[Ljava/lang/String;
    filled-new-array {v7, v7, v7, v7, v7}, [I

    move-result-object v2

    move-object v11, v2

    .line 985
    .local v11, "rxaCounts":[I
    iget-object v2, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    .line 986
    const-string v3, "RuntimeVisibleAnnotations"

    invoke-virtual {v2, v3, v5}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v12

    .line 987
    .local v12, "rvaLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    iget-object v2, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    const-string v3, "RuntimeInvisibleAnnotations"

    invoke-virtual {v2, v3, v5}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v13

    .line 989
    .local v13, "riaLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    iget-object v2, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    const-string v3, "RuntimeVisibleParameterAnnotations"

    invoke-virtual {v2, v3, v5}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v14

    .line 991
    .local v14, "rvpaLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    iget-object v2, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    const-string v3, "RuntimeInvisibleParameterAnnotations"

    invoke-virtual {v2, v3, v5}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v15

    .line 993
    .local v15, "ripaLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    iget-object v2, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    const-string v3, "AnnotationDefault"

    invoke-virtual {v2, v3, v5}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v16

    .line 995
    .local v16, "adLayout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    new-array v2, v1, [Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    aput-object v12, v2, v7

    aput-object v13, v2, v4

    aput-object v14, v2, v5

    aput-object v15, v2, v8

    aput-object v16, v2, v9

    move-object v8, v2

    .line 997
    .local v8, "rxaLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    array-length v3, v8

    if-ge v2, v3, :cond_0

    .line 998
    iget-object v3, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodFlags:[[J

    aget-object v4, v8, v2

    invoke-static {v3, v4}, Lorg/apache/commons/compress/harmony/unpack200/SegmentUtils;->countMatches([[JLorg/apache/commons/compress/harmony/unpack200/IMatcher;)I

    move-result v3

    aput v3, v11, v2

    .line 997
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 1000
    .end local v2    # "i":I
    :cond_0
    new-array v9, v1, [I

    .line 1001
    .local v9, "backwardsCalls":[I
    const/4 v1, 0x0

    .line 1002
    .local v1, "methodAttrIndex":I
    const/4 v2, 0x0

    move/from16 v17, v0

    move/from16 v18, v1

    .end local v0    # "backwardsCallsUsed":I
    .end local v1    # "methodAttrIndex":I
    .restart local v2    # "i":I
    .local v17, "backwardsCallsUsed":I
    .local v18, "methodAttrIndex":I
    :goto_1
    array-length v0, v9

    if-ge v2, v0, :cond_2

    .line 1003
    aget v0, v11, v2

    if-lez v0, :cond_1

    .line 1004
    add-int/lit8 v17, v17, 0x1

    .line 1005
    aget v0, p2, v18

    aput v0, v9, v2

    .line 1006
    add-int/lit8 v18, v18, 0x1

    goto :goto_2

    .line 1008
    :cond_1
    aput v7, v9, v2

    .line 1002
    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 1011
    .end local v2    # "i":I
    :cond_2
    const-string v5, "method"

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object v2, v10

    move-object v3, v11

    move-object v4, v9

    invoke-direct/range {v0 .. v5}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseMetadata(Ljava/io/InputStream;[Ljava/lang/String;[I[ILjava/lang/String;)[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;

    move-result-object v0

    .line 1012
    .local v0, "mbgs":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    array-length v1, v10

    new-array v1, v1, [Ljava/util/List;

    .line 1013
    .local v1, "attributeLists":[Ljava/util/List;
    array-length v2, v10

    new-array v2, v2, [I

    .line 1014
    .local v2, "attributeListIndexes":[I
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_3
    array-length v4, v0

    if-ge v3, v4, :cond_3

    .line 1015
    aget-object v4, v0, v3

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->getAttributes()Ljava/util/List;

    move-result-object v4

    aput-object v4, v1, v3

    .line 1016
    aput v7, v2, v3

    .line 1014
    add-int/lit8 v3, v3, 0x1

    goto :goto_3

    .line 1018
    .end local v3    # "i":I
    :cond_3
    const/4 v3, 0x0

    .restart local v3    # "i":I
    :goto_4
    iget-object v4, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodFlags:[[J

    array-length v4, v4

    if-ge v3, v4, :cond_7

    .line 1019
    const/4 v4, 0x0

    .local v4, "j":I
    :goto_5
    iget-object v5, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodFlags:[[J

    aget-object v5, v5, v3

    array-length v5, v5

    if-ge v4, v5, :cond_6

    .line 1020
    const/4 v5, 0x0

    .local v5, "k":I
    :goto_6
    array-length v7, v8

    if-ge v5, v7, :cond_5

    .line 1021
    aget-object v7, v8, v5

    move-object/from16 v19, v0

    .end local v0    # "mbgs":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    .local v19, "mbgs":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodFlags:[[J

    aget-object v0, v0, v3

    move-object/from16 v20, v8

    move-object/from16 v21, v9

    .end local v8    # "rxaLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v9    # "backwardsCalls":[I
    .local v20, "rxaLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .local v21, "backwardsCalls":[I
    aget-wide v8, v0, v4

    invoke-virtual {v7, v8, v9}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 1022
    iget-object v0, v6, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAttributes:[[Ljava/util/ArrayList;

    aget-object v0, v0, v3

    aget-object v0, v0, v4

    aget-object v7, v1, v5

    aget v8, v2, v5

    add-int/lit8 v9, v8, 0x1

    aput v9, v2, v5

    invoke-interface {v7, v8}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    invoke-virtual {v0, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 1020
    :cond_4
    add-int/lit8 v5, v5, 0x1

    move-object/from16 v0, v19

    move-object/from16 v8, v20

    move-object/from16 v9, v21

    goto :goto_6

    .end local v19    # "mbgs":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    .end local v20    # "rxaLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v21    # "backwardsCalls":[I
    .restart local v0    # "mbgs":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    .restart local v8    # "rxaLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v9    # "backwardsCalls":[I
    :cond_5
    move-object/from16 v19, v0

    move-object/from16 v20, v8

    move-object/from16 v21, v9

    .line 1019
    .end local v0    # "mbgs":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    .end local v5    # "k":I
    .end local v8    # "rxaLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v9    # "backwardsCalls":[I
    .restart local v19    # "mbgs":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    .restart local v20    # "rxaLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v21    # "backwardsCalls":[I
    add-int/lit8 v4, v4, 0x1

    goto :goto_5

    .end local v19    # "mbgs":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    .end local v20    # "rxaLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v21    # "backwardsCalls":[I
    .restart local v0    # "mbgs":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    .restart local v8    # "rxaLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v9    # "backwardsCalls":[I
    :cond_6
    move-object/from16 v19, v0

    move-object/from16 v20, v8

    move-object/from16 v21, v9

    .line 1018
    .end local v0    # "mbgs":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    .end local v4    # "j":I
    .end local v8    # "rxaLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v9    # "backwardsCalls":[I
    .restart local v19    # "mbgs":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    .restart local v20    # "rxaLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v21    # "backwardsCalls":[I
    add-int/lit8 v3, v3, 0x1

    goto :goto_4

    .line 1027
    .end local v3    # "i":I
    .end local v19    # "mbgs":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    .end local v20    # "rxaLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v21    # "backwardsCalls":[I
    .restart local v0    # "mbgs":[Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;
    .restart local v8    # "rxaLayouts":[Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .restart local v9    # "backwardsCalls":[I
    :cond_7
    return v17
.end method


# virtual methods
.method public getClassAttributes()[Ljava/util/ArrayList;
    .locals 1

    .line 1080
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classAttributes:[Ljava/util/ArrayList;

    return-object v0
.end method

.method public getClassFieldCount()[I
    .locals 1

    .line 1084
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFieldCount:[I

    return-object v0
.end method

.method public getClassFlags()[J
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 1092
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classAccessFlags:[J

    if-nez v0, :cond_2

    .line 1093
    const-wide/16 v0, 0x7fff

    .line 1094
    .local v0, "mask":J
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    const/16 v3, 0x10

    if-ge v2, v3, :cond_1

    .line 1095
    iget-object v3, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    const/4 v4, 0x0

    invoke-virtual {v3, v2, v4}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(II)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v3

    .line 1096
    .local v3, "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    if-eqz v3, :cond_0

    invoke-virtual {v3}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->isDefaultLayout()Z

    move-result v4

    if-nez v4, :cond_0

    .line 1097
    const/4 v4, 0x1

    shl-int/2addr v4, v2

    not-int v4, v4

    int-to-long v4, v4

    and-long/2addr v0, v4

    .line 1094
    .end local v3    # "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 1100
    .end local v2    # "i":I
    :cond_1
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFlags:[J

    array-length v2, v2

    new-array v2, v2, [J

    iput-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classAccessFlags:[J

    .line 1101
    const/4 v2, 0x0

    .restart local v2    # "i":I
    :goto_1
    iget-object v3, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFlags:[J

    array-length v3, v3

    if-ge v2, v3, :cond_2

    .line 1102
    iget-object v3, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classAccessFlags:[J

    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFlags:[J

    aget-wide v5, v4, v2

    and-long v4, v5, v0

    aput-wide v4, v3, v2

    .line 1101
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 1105
    .end local v0    # "mask":J
    .end local v2    # "i":I
    :cond_2
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classAccessFlags:[J

    return-object v0
.end method

.method public getClassInterfacesInts()[[I
    .locals 1

    .line 1109
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classInterfacesInts:[[I

    return-object v0
.end method

.method public getClassMethodCount()[I
    .locals 1

    .line 1113
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classMethodCount:[I

    return-object v0
.end method

.method public getClassSuperInts()[I
    .locals 1

    .line 1117
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classSuperInts:[I

    return-object v0
.end method

.method public getClassThisInts()[I
    .locals 1

    .line 1121
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classThisInts:[I

    return-object v0
.end method

.method public getClassVersionMajor()[I
    .locals 1

    .line 1219
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classVersionMajor:[I

    return-object v0
.end method

.method public getClassVersionMinor()[I
    .locals 1

    .line 1229
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classVersionMinor:[I

    return-object v0
.end method

.method public getCodeHandlerCatchPO()[[I
    .locals 1

    .line 1237
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeHandlerCatchPO:[[I

    return-object v0
.end method

.method public getCodeHandlerClassRCN()[[I
    .locals 1

    .line 1241
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeHandlerClassRCN:[[I

    return-object v0
.end method

.method public getCodeHandlerCount()[I
    .locals 1

    .line 1233
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeHandlerCount:[I

    return-object v0
.end method

.method public getCodeHandlerEndPO()[[I
    .locals 1

    .line 1245
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeHandlerEndPO:[[I

    return-object v0
.end method

.method public getCodeHandlerStartP()[[I
    .locals 1

    .line 1249
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeHandlerStartP:[[I

    return-object v0
.end method

.method public getCodeHasAttributes()[Z
    .locals 1

    .line 1257
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeHasAttributes:[Z

    return-object v0
.end method

.method public getCodeMaxNALocals()[I
    .locals 1

    .line 1125
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeMaxNALocals:[I

    return-object v0
.end method

.method public getCodeMaxStack()[I
    .locals 1

    .line 1129
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeMaxStack:[I

    return-object v0
.end method

.method public getFieldAttributes()[[Ljava/util/ArrayList;
    .locals 1

    .line 1133
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldAttributes:[[Ljava/util/ArrayList;

    return-object v0
.end method

.method public getFieldDescrInts()[[I
    .locals 1

    .line 1137
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldDescrInts:[[I

    return-object v0
.end method

.method public getFieldFlags()[[J
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 1145
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldAccessFlags:[[J

    if-nez v0, :cond_3

    .line 1146
    const-wide/16 v0, 0x7fff

    .line 1147
    .local v0, "mask":J
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    const/16 v3, 0x10

    if-ge v2, v3, :cond_1

    .line 1148
    iget-object v3, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    const/4 v4, 0x1

    invoke-virtual {v3, v2, v4}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(II)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v3

    .line 1149
    .local v3, "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    if-eqz v3, :cond_0

    invoke-virtual {v3}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->isDefaultLayout()Z

    move-result v5

    if-nez v5, :cond_0

    .line 1150
    shl-int/2addr v4, v2

    not-int v4, v4

    int-to-long v4, v4

    and-long/2addr v0, v4

    .line 1147
    .end local v3    # "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 1153
    .end local v2    # "i":I
    :cond_1
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    array-length v2, v2

    new-array v2, v2, [[J

    iput-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldAccessFlags:[[J

    .line 1154
    const/4 v2, 0x0

    .restart local v2    # "i":I
    :goto_1
    iget-object v3, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    array-length v3, v3

    if-ge v2, v3, :cond_3

    .line 1155
    iget-object v3, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldAccessFlags:[[J

    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    aget-object v4, v4, v2

    array-length v4, v4

    new-array v4, v4, [J

    aput-object v4, v3, v2

    .line 1156
    const/4 v3, 0x0

    .local v3, "j":I
    :goto_2
    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    aget-object v4, v4, v2

    array-length v4, v4

    if-ge v3, v4, :cond_2

    .line 1157
    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldAccessFlags:[[J

    aget-object v4, v4, v2

    iget-object v5, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldFlags:[[J

    aget-object v5, v5, v2

    aget-wide v6, v5, v3

    and-long v5, v6, v0

    aput-wide v5, v4, v3

    .line 1156
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 1154
    .end local v3    # "j":I
    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 1161
    .end local v0    # "mask":J
    .end local v2    # "i":I
    :cond_3
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->fieldAccessFlags:[[J

    return-object v0
.end method

.method public getIcLocal()[[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    .locals 1

    .line 1253
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->icLocal:[[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    return-object v0
.end method

.method public getMethodAttributes()[[Ljava/util/ArrayList;
    .locals 1

    .line 1185
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAttributes:[[Ljava/util/ArrayList;

    return-object v0
.end method

.method public getMethodDescr()[[Ljava/lang/String;
    .locals 1

    .line 1189
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodDescr:[[Ljava/lang/String;

    return-object v0
.end method

.method public getMethodDescrInts()[[I
    .locals 1

    .line 1141
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodDescrInts:[[I

    return-object v0
.end method

.method public getMethodFlags()[[J
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 1193
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAccessFlags:[[J

    if-nez v0, :cond_3

    .line 1194
    const-wide/16 v0, 0x7fff

    .line 1195
    .local v0, "mask":J
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    const/16 v3, 0x10

    if-ge v2, v3, :cond_1

    .line 1196
    iget-object v3, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->attrMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    const/4 v4, 0x2

    invoke-virtual {v3, v2, v4}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(II)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v3

    .line 1197
    .local v3, "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    if-eqz v3, :cond_0

    invoke-virtual {v3}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->isDefaultLayout()Z

    move-result v4

    if-nez v4, :cond_0

    .line 1198
    const/4 v4, 0x1

    shl-int/2addr v4, v2

    not-int v4, v4

    int-to-long v4, v4

    and-long/2addr v0, v4

    .line 1195
    .end local v3    # "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 1201
    .end local v2    # "i":I
    :cond_1
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodFlags:[[J

    array-length v2, v2

    new-array v2, v2, [[J

    iput-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAccessFlags:[[J

    .line 1202
    const/4 v2, 0x0

    .restart local v2    # "i":I
    :goto_1
    iget-object v3, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodFlags:[[J

    array-length v3, v3

    if-ge v2, v3, :cond_3

    .line 1203
    iget-object v3, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAccessFlags:[[J

    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodFlags:[[J

    aget-object v4, v4, v2

    array-length v4, v4

    new-array v4, v4, [J

    aput-object v4, v3, v2

    .line 1204
    const/4 v3, 0x0

    .local v3, "j":I
    :goto_2
    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodFlags:[[J

    aget-object v4, v4, v2

    array-length v4, v4

    if-ge v3, v4, :cond_2

    .line 1205
    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAccessFlags:[[J

    aget-object v4, v4, v2

    iget-object v5, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodFlags:[[J

    aget-object v5, v5, v2

    aget-wide v6, v5, v3

    and-long v5, v6, v0

    aput-wide v5, v4, v3

    .line 1204
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 1202
    .end local v3    # "j":I
    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 1209
    .end local v0    # "mask":J
    .end local v2    # "i":I
    :cond_3
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->methodAccessFlags:[[J

    return-object v0
.end method

.method public getOrderedCodeAttributes()Ljava/util/ArrayList;
    .locals 5

    .line 1172
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeAttributes:[Ljava/util/List;

    array-length v1, v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 1173
    .local v0, "orderedAttributeList":Ljava/util/ArrayList;
    const/4 v1, 0x0

    .local v1, "classIndex":I
    :goto_0
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeAttributes:[Ljava/util/List;

    array-length v2, v2

    if-ge v1, v2, :cond_1

    .line 1174
    new-instance v2, Ljava/util/ArrayList;

    iget-object v3, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeAttributes:[Ljava/util/List;

    aget-object v3, v3, v1

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    invoke-direct {v2, v3}, Ljava/util/ArrayList;-><init>(I)V

    .line 1175
    .local v2, "currentAttributes":Ljava/util/ArrayList;
    const/4 v3, 0x0

    .local v3, "attributeIndex":I
    :goto_1
    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeAttributes:[Ljava/util/List;

    aget-object v4, v4, v1

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    if-ge v3, v4, :cond_0

    .line 1176
    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->codeAttributes:[Ljava/util/List;

    aget-object v4, v4, v1

    invoke-interface {v4, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;

    .line 1177
    .local v4, "attribute":Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;
    invoke-virtual {v2, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 1175
    .end local v4    # "attribute":Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 1179
    .end local v3    # "attributeIndex":I
    :cond_0
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 1173
    .end local v2    # "currentAttributes":Ljava/util/ArrayList;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1181
    .end local v1    # "classIndex":I
    :cond_1
    return-object v0
.end method

.method public getRawClassFlags()[J
    .locals 1

    .line 1088
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFlags:[J

    return-object v0
.end method

.method public read(Ljava/io/InputStream;)V
    .locals 4
    .param p1, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 138
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->getClassCount()I

    move-result v0

    .line 139
    .local v0, "classCount":I
    const-string v1, "class_this"

    sget-object v2, Lorg/apache/commons/compress/harmony/pack200/Codec;->DELTA5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {p0, v1, p1, v2, v0}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v1

    iput-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classThisInts:[I

    .line 140
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classThisInts:[I

    iget-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getCpClass()[Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v1, v2}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getReferences([I[Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classThis:[Ljava/lang/String;

    .line 141
    const-string v1, "class_super"

    sget-object v2, Lorg/apache/commons/compress/harmony/pack200/Codec;->DELTA5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {p0, v1, p1, v2, v0}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v1

    iput-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classSuperInts:[I

    .line 142
    const-string v1, "class_interface_count"

    sget-object v2, Lorg/apache/commons/compress/harmony/pack200/Codec;->DELTA5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {p0, v1, p1, v2, v0}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v1

    .line 143
    .local v1, "classInterfaceLengths":[I
    const-string v2, "class_interface"

    sget-object v3, Lorg/apache/commons/compress/harmony/pack200/Codec;->DELTA5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {p0, v2, p1, v3, v1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;[I)[[I

    move-result-object v2

    iput-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classInterfacesInts:[[I

    .line 144
    const-string v2, "class_field_count"

    sget-object v3, Lorg/apache/commons/compress/harmony/pack200/Codec;->DELTA5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {p0, v2, p1, v3, v0}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v2

    iput-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classFieldCount:[I

    .line 145
    const-string v2, "class_method_count"

    sget-object v3, Lorg/apache/commons/compress/harmony/pack200/Codec;->DELTA5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {p0, v2, p1, v3, v0}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v2

    iput-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->classMethodCount:[I

    .line 146
    invoke-direct {p0, p1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseFieldBands(Ljava/io/InputStream;)V

    .line 147
    invoke-direct {p0, p1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseMethodBands(Ljava/io/InputStream;)V

    .line 148
    invoke-direct {p0, p1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseClassAttrBands(Ljava/io/InputStream;)V

    .line 149
    invoke-direct {p0, p1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->parseCodeBands(Ljava/io/InputStream;)V

    .line 151
    return-void
.end method

.method public unpack()V
    .locals 0

    .line 156
    return-void
.end method
