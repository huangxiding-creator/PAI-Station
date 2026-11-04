.class public Lorg/apache/commons/compress/harmony/pack200/FileBands;
.super Lorg/apache/commons/compress/harmony/pack200/BandSet;
.source "FileBands.java"


# instance fields
.field private final cpBands:Lorg/apache/commons/compress/harmony/pack200/CpBands;

.field private final fileList:Ljava/util/List;

.field private final fileName:[Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

.field private final file_bits:[[B

.field private final file_modtime:[I

.field private file_name:[I

.field private final file_options:[I

.field private final file_size:[J

.field private final options:Lorg/apache/commons/compress/harmony/pack200/PackingOptions;


# direct methods
.method public constructor <init>(Lorg/apache/commons/compress/harmony/pack200/CpBands;Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;Lorg/apache/commons/compress/harmony/pack200/PackingOptions;Lorg/apache/commons/compress/harmony/pack200/Archive$SegmentUnit;I)V
    .locals 19
    .param p1, "cpBands"    # Lorg/apache/commons/compress/harmony/pack200/CpBands;
    .param p2, "segmentHeader"    # Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;
    .param p3, "options"    # Lorg/apache/commons/compress/harmony/pack200/PackingOptions;
    .param p4, "segmentUnit"    # Lorg/apache/commons/compress/harmony/pack200/Archive$SegmentUnit;
    .param p5, "effort"    # I

    .line 49
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p3

    move-object/from16 v3, p2

    move/from16 v4, p5

    invoke-direct {v0, v4, v3}, Lorg/apache/commons/compress/harmony/pack200/BandSet;-><init>(ILorg/apache/commons/compress/harmony/pack200/SegmentHeader;)V

    .line 50
    invoke-virtual/range {p4 .. p4}, Lorg/apache/commons/compress/harmony/pack200/Archive$SegmentUnit;->getFileList()Ljava/util/List;

    move-result-object v5

    iput-object v5, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->fileList:Ljava/util/List;

    .line 51
    iput-object v2, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->options:Lorg/apache/commons/compress/harmony/pack200/PackingOptions;

    .line 52
    iput-object v1, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->cpBands:Lorg/apache/commons/compress/harmony/pack200/CpBands;

    .line 53
    iget-object v5, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->fileList:Ljava/util/List;

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v5

    .line 54
    .local v5, "size":I
    new-array v6, v5, [Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    iput-object v6, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->fileName:[Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    .line 55
    new-array v6, v5, [I

    iput-object v6, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_modtime:[I

    .line 56
    new-array v6, v5, [J

    iput-object v6, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_size:[J

    .line 57
    new-array v6, v5, [I

    iput-object v6, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_options:[I

    .line 58
    const/4 v6, 0x0

    .line 59
    .local v6, "totalSize":I
    new-array v7, v5, [[B

    iput-object v7, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_bits:[[B

    .line 60
    invoke-virtual/range {p2 .. p2}, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;->getArchive_modtime()I

    move-result v7

    .line 62
    .local v7, "archiveModtime":I
    new-instance v8, Ljava/util/HashSet;

    invoke-direct {v8}, Ljava/util/HashSet;-><init>()V

    .line 63
    .local v8, "classNames":Ljava/util/Set;
    invoke-virtual/range {p4 .. p4}, Lorg/apache/commons/compress/harmony/pack200/Archive$SegmentUnit;->getClassList()Ljava/util/List;

    move-result-object v9

    invoke-interface {v9}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v9

    .local v9, "iterator":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v9}, Ljava/util/Iterator;->hasNext()Z

    move-result v10

    if-eqz v10, :cond_0

    .line 64
    invoke-interface {v9}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Lorg/objectweb/asm/ClassReader;

    .line 65
    .local v10, "reader":Lorg/objectweb/asm/ClassReader;
    invoke-virtual {v10}, Lorg/objectweb/asm/ClassReader;->getClassName()Ljava/lang/String;

    move-result-object v11

    invoke-interface {v8, v11}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 66
    .end local v10    # "reader":Lorg/objectweb/asm/ClassReader;
    goto :goto_0

    .line 67
    .end local v9    # "iterator":Ljava/util/Iterator;
    :cond_0
    const-string v9, ""

    invoke-virtual {v1, v9}, Lorg/apache/commons/compress/harmony/pack200/CpBands;->getCPUtf8(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    move-result-object v9

    .line 69
    .local v9, "emptyString":Lorg/apache/commons/compress/harmony/pack200/CPUTF8;
    const/high16 v10, -0x80000000

    .line 70
    .local v10, "latestModtime":I
    const-string v11, "keep"

    invoke-virtual/range {p3 .. p3}, Lorg/apache/commons/compress/harmony/pack200/PackingOptions;->getModificationTime()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    xor-int/lit8 v11, v11, 0x1

    .line 71
    .local v11, "isLatest":Z
    const/4 v12, 0x0

    .local v12, "i":I
    :goto_1
    if-ge v12, v5, :cond_5

    .line 72
    iget-object v13, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->fileList:Ljava/util/List;

    invoke-interface {v13, v12}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;

    .line 73
    .local v13, "packingFile":Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;
    invoke-virtual {v13}, Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;->getName()Ljava/lang/String;

    move-result-object v14

    .line 74
    .local v14, "name":Ljava/lang/String;
    const-string v15, ".class"

    invoke-virtual {v14, v15}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v15

    if-eqz v15, :cond_2

    invoke-virtual {v2, v14}, Lorg/apache/commons/compress/harmony/pack200/PackingOptions;->isPassFile(Ljava/lang/String;)Z

    move-result v15

    if-nez v15, :cond_2

    .line 75
    iget-object v15, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_options:[I

    aget v16, v15, v12

    or-int/lit8 v16, v16, 0x2

    aput v16, v15, v12

    .line 76
    invoke-virtual {v14}, Ljava/lang/String;->length()I

    move-result v15

    add-int/lit8 v15, v15, -0x6

    const/4 v2, 0x0

    invoke-virtual {v14, v2, v15}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v8, v2}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 77
    iget-object v2, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->fileName:[Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    aput-object v9, v2, v12

    goto :goto_2

    .line 79
    :cond_1
    iget-object v2, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->fileName:[Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    invoke-virtual {v1, v14}, Lorg/apache/commons/compress/harmony/pack200/CpBands;->getCPUtf8(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    move-result-object v15

    aput-object v15, v2, v12

    goto :goto_2

    .line 82
    :cond_2
    iget-object v2, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->fileName:[Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    invoke-virtual {v1, v14}, Lorg/apache/commons/compress/harmony/pack200/CpBands;->getCPUtf8(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    move-result-object v15

    aput-object v15, v2, v12

    .line 85
    :goto_2
    invoke-virtual/range {p3 .. p3}, Lorg/apache/commons/compress/harmony/pack200/PackingOptions;->isKeepDeflateHint()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-virtual {v13}, Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;->isDefalteHint()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 86
    iget-object v2, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_options:[I

    aget v15, v2, v12

    or-int/lit8 v15, v15, 0x1

    aput v15, v2, v12

    .line 88
    :cond_3
    invoke-virtual {v13}, Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;->getContents()[B

    move-result-object v2

    .line 89
    .local v2, "bytes":[B
    iget-object v15, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_size:[J

    array-length v1, v2

    move-object/from16 v16, v2

    .end local v2    # "bytes":[B
    .local v16, "bytes":[B
    int-to-long v1, v1

    aput-wide v1, v15, v12

    .line 90
    int-to-long v1, v6

    iget-object v15, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_size:[J

    aget-wide v17, v15, v12

    add-long v1, v1, v17

    long-to-int v6, v1

    .line 93
    invoke-virtual {v13}, Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;->getModtime()J

    move-result-wide v1

    invoke-static {}, Ljava/util/TimeZone;->getDefault()Ljava/util/TimeZone;

    move-result-object v15

    invoke-virtual {v15}, Ljava/util/TimeZone;->getRawOffset()I

    move-result v15

    int-to-long v3, v15

    add-long/2addr v1, v3

    const-wide/16 v3, 0x3e8

    div-long/2addr v1, v3

    .line 94
    .local v1, "modtime":J
    iget-object v3, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_modtime:[I

    move-object v4, v8

    move-object v15, v9

    .end local v8    # "classNames":Ljava/util/Set;
    .end local v9    # "emptyString":Lorg/apache/commons/compress/harmony/pack200/CPUTF8;
    .local v4, "classNames":Ljava/util/Set;
    .local v15, "emptyString":Lorg/apache/commons/compress/harmony/pack200/CPUTF8;
    int-to-long v8, v7

    sub-long v8, v1, v8

    long-to-int v8, v8

    aput v8, v3, v12

    .line 95
    if-eqz v11, :cond_4

    iget-object v3, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_modtime:[I

    aget v3, v3, v12

    if-ge v10, v3, :cond_4

    .line 96
    iget-object v3, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_modtime:[I

    aget v3, v3, v12

    move v10, v3

    .line 99
    :cond_4
    iget-object v3, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_bits:[[B

    invoke-virtual {v13}, Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;->getContents()[B

    move-result-object v8

    aput-object v8, v3, v12

    .line 71
    .end local v13    # "packingFile":Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;
    .end local v14    # "name":Ljava/lang/String;
    .end local v16    # "bytes":[B
    add-int/lit8 v12, v12, 0x1

    move-object/from16 v1, p1

    move-object/from16 v3, p2

    move-object/from16 v2, p3

    move-object v8, v4

    move-object v9, v15

    move/from16 v4, p5

    goto/16 :goto_1

    .end local v1    # "modtime":J
    .end local v4    # "classNames":Ljava/util/Set;
    .end local v15    # "emptyString":Lorg/apache/commons/compress/harmony/pack200/CPUTF8;
    .restart local v8    # "classNames":Ljava/util/Set;
    .restart local v9    # "emptyString":Lorg/apache/commons/compress/harmony/pack200/CPUTF8;
    :cond_5
    move-object v4, v8

    move-object v15, v9

    .line 102
    .end local v8    # "classNames":Ljava/util/Set;
    .end local v9    # "emptyString":Lorg/apache/commons/compress/harmony/pack200/CPUTF8;
    .end local v12    # "i":I
    .restart local v4    # "classNames":Ljava/util/Set;
    .restart local v15    # "emptyString":Lorg/apache/commons/compress/harmony/pack200/CPUTF8;
    if-eqz v11, :cond_6

    .line 103
    const/4 v1, 0x0

    .local v1, "index":I
    :goto_3
    if-ge v1, v5, :cond_6

    .line 104
    iget-object v2, v0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_modtime:[I

    aput v10, v2, v1

    .line 103
    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    .line 107
    .end local v1    # "index":I
    :cond_6
    return-void
.end method

.method private flatten([[B)[I
    .locals 7
    .param p1, "bytes"    # [[B

    .line 157
    const/4 v0, 0x0

    .line 158
    .local v0, "total":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p1

    if-ge v1, v2, :cond_0

    .line 159
    aget-object v2, p1, v1

    array-length v2, v2

    add-int/2addr v0, v2

    .line 158
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 161
    .end local v1    # "i":I
    :cond_0
    new-array v1, v0, [I

    .line 162
    .local v1, "band":[I
    const/4 v2, 0x0

    .line 163
    .local v2, "index":I
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_1
    array-length v4, p1

    if-ge v3, v4, :cond_2

    .line 164
    const/4 v4, 0x0

    .local v4, "j":I
    :goto_2
    aget-object v5, p1, v3

    array-length v5, v5

    if-ge v4, v5, :cond_1

    .line 165
    add-int/lit8 v5, v2, 0x1

    .end local v2    # "index":I
    .local v5, "index":I
    aget-object v6, p1, v3

    aget-byte v6, v6, v4

    and-int/lit16 v6, v6, 0xff

    aput v6, v1, v2

    .line 164
    add-int/lit8 v4, v4, 0x1

    move v2, v5

    goto :goto_2

    .line 163
    .end local v4    # "j":I
    .end local v5    # "index":I
    .restart local v2    # "index":I
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 168
    .end local v3    # "i":I
    :cond_2
    return-object v1
.end method


# virtual methods
.method public finaliseBands()V
    .locals 5

    .line 114
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->fileName:[Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    array-length v0, v0

    new-array v0, v0, [I

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_name:[I

    .line 115
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_name:[I

    array-length v1, v1

    if-ge v0, v1, :cond_1

    .line 116
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->fileName:[Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    aget-object v1, v1, v0

    iget-object v2, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->cpBands:Lorg/apache/commons/compress/harmony/pack200/CpBands;

    const-string v3, ""

    invoke-virtual {v2, v3}, Lorg/apache/commons/compress/harmony/pack200/CpBands;->getCPUtf8(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 117
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->fileList:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;

    .line 118
    .local v1, "packingFile":Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;
    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;->getName()Ljava/lang/String;

    move-result-object v2

    .line 119
    .local v2, "name":Ljava/lang/String;
    iget-object v3, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->options:Lorg/apache/commons/compress/harmony/pack200/PackingOptions;

    invoke-virtual {v3, v2}, Lorg/apache/commons/compress/harmony/pack200/PackingOptions;->isPassFile(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 120
    iget-object v3, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->fileName:[Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    iget-object v4, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->cpBands:Lorg/apache/commons/compress/harmony/pack200/CpBands;

    invoke-virtual {v4, v2}, Lorg/apache/commons/compress/harmony/pack200/CpBands;->getCPUtf8(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    move-result-object v4

    aput-object v4, v3, v0

    .line 121
    iget-object v3, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_options:[I

    aget v4, v3, v0

    and-int/lit8 v4, v4, -0x3

    aput v4, v3, v0

    .line 124
    .end local v1    # "packingFile":Lorg/apache/commons/compress/harmony/pack200/Archive$PackingFile;
    .end local v2    # "name":Ljava/lang/String;
    :cond_0
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_name:[I

    iget-object v2, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->fileName:[Lorg/apache/commons/compress/harmony/pack200/CPUTF8;

    aget-object v2, v2, v0

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/pack200/CPUTF8;->getIndex()I

    move-result v2

    aput v2, v1, v0

    .line 115
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 126
    .end local v0    # "i":I
    :cond_1
    return-void
.end method

.method public pack(Ljava/io/OutputStream;)V
    .locals 10
    .param p1, "out"    # Ljava/io/OutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 130
    const-string v0, "Writing file bands..."

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/pack200/PackingUtils;->log(Ljava/lang/String;)V

    .line 131
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_name:[I

    sget-object v1, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    const-string v2, "file_name"

    invoke-virtual {p0, v2, v0, v1}, Lorg/apache/commons/compress/harmony/pack200/FileBands;->encodeBandInt(Ljava/lang/String;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;)[B

    move-result-object v0

    .line 132
    .local v0, "encodedBand":[B
    invoke-virtual {p1, v0}, Ljava/io/OutputStream;->write([B)V

    .line 133
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Wrote "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    array-length v3, v0

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " bytes from file_name["

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v3, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_name:[I

    array-length v3, v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "]"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lorg/apache/commons/compress/harmony/pack200/PackingUtils;->log(Ljava/lang/String;)V

    .line 135
    iget-object v6, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_size:[J

    sget-object v7, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    sget-object v8, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->segmentHeader:Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;

    .line 136
    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;->have_file_size_hi()Z

    move-result v9

    .line 135
    const-string v5, "file_size"

    move-object v4, p0

    invoke-virtual/range {v4 .. v9}, Lorg/apache/commons/compress/harmony/pack200/FileBands;->encodeFlags(Ljava/lang/String;[JLorg/apache/commons/compress/harmony/pack200/BHSDCodec;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;Z)[B

    move-result-object v0

    .line 137
    invoke-virtual {p1, v0}, Ljava/io/OutputStream;->write([B)V

    .line 138
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    array-length v4, v0

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, " bytes from file_size["

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v4, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_size:[J

    array-length v4, v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lorg/apache/commons/compress/harmony/pack200/PackingUtils;->log(Ljava/lang/String;)V

    .line 140
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->segmentHeader:Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;->have_file_modtime()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 141
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_modtime:[I

    sget-object v4, Lorg/apache/commons/compress/harmony/pack200/Codec;->DELTA5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    const-string v5, "file_modtime"

    invoke-virtual {p0, v5, v1, v4}, Lorg/apache/commons/compress/harmony/pack200/FileBands;->encodeBandInt(Ljava/lang/String;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;)[B

    move-result-object v0

    .line 142
    invoke-virtual {p1, v0}, Ljava/io/OutputStream;->write([B)V

    .line 143
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    array-length v4, v0

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, " bytes from file_modtime["

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v4, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_modtime:[I

    array-length v4, v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lorg/apache/commons/compress/harmony/pack200/PackingUtils;->log(Ljava/lang/String;)V

    .line 145
    :cond_0
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->segmentHeader:Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;->have_file_options()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 146
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_options:[I

    sget-object v4, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    const-string v5, "file_options"

    invoke-virtual {p0, v5, v1, v4}, Lorg/apache/commons/compress/harmony/pack200/FileBands;->encodeBandInt(Ljava/lang/String;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;)[B

    move-result-object v0

    .line 147
    invoke-virtual {p1, v0}, Ljava/io/OutputStream;->write([B)V

    .line 148
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    array-length v4, v0

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, " bytes from file_options["

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v4, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_options:[I

    array-length v4, v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lorg/apache/commons/compress/harmony/pack200/PackingUtils;->log(Ljava/lang/String;)V

    .line 151
    :cond_1
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_bits:[[B

    invoke-direct {p0, v1}, Lorg/apache/commons/compress/harmony/pack200/FileBands;->flatten([[B)[I

    move-result-object v1

    sget-object v4, Lorg/apache/commons/compress/harmony/pack200/Codec;->BYTE1:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    const-string v5, "file_bits"

    invoke-virtual {p0, v5, v1, v4}, Lorg/apache/commons/compress/harmony/pack200/FileBands;->encodeBandInt(Ljava/lang/String;[ILorg/apache/commons/compress/harmony/pack200/BHSDCodec;)[B

    move-result-object v0

    .line 152
    invoke-virtual {p1, v0}, Ljava/io/OutputStream;->write([B)V

    .line 153
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    array-length v2, v0

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " bytes from file_bits["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lorg/apache/commons/compress/harmony/pack200/FileBands;->file_bits:[[B

    array-length v2, v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lorg/apache/commons/compress/harmony/pack200/PackingUtils;->log(Ljava/lang/String;)V

    .line 154
    return-void
.end method
