.class public Lorg/apache/commons/compress/harmony/unpack200/Segment;
.super Ljava/lang/Object;
.source "Segment.java"


# static fields
.field public static final LOG_LEVEL_QUIET:I = 0x0

.field public static final LOG_LEVEL_STANDARD:I = 0x1

.field public static final LOG_LEVEL_VERBOSE:I = 0x2


# instance fields
.field private attrDefinitionBands:Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;

.field private bcBands:Lorg/apache/commons/compress/harmony/unpack200/BcBands;

.field private classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

.field private classFilesContents:[[B

.field private cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

.field private deflateHint:Z

.field private doPreRead:Z

.field private fileBands:Lorg/apache/commons/compress/harmony/unpack200/FileBands;

.field private fileDeflate:[Z

.field private fileIsClass:[Z

.field private header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

.field private icBands:Lorg/apache/commons/compress/harmony/unpack200/IcBands;

.field private internalBuffer:Ljava/io/InputStream;

.field private logLevel:I

.field private logStream:Ljava/io/PrintWriter;

.field private overrideDeflateHint:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 68
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private buildClassFile(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;
    .locals 36
    .param p1, "classNum"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 109
    move-object/from16 v0, p0

    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;

    invoke-direct {v1}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;-><init>()V

    .line 110
    .local v1, "classFile":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;
    iget-object v2, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getClassVersionMajor()[I

    move-result-object v2

    .line 111
    .local v2, "major":[I
    iget-object v3, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    invoke-virtual {v3}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getClassVersionMinor()[I

    move-result-object v3

    .line 112
    .local v3, "minor":[I
    if-eqz v2, :cond_0

    .line 113
    aget v4, v2, p1

    iput v4, v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->major:I

    .line 114
    aget v4, v3, p1

    iput v4, v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->minor:I

    goto :goto_0

    .line 116
    :cond_0
    iget-object v4, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->getDefaultClassMajorVersion()I

    move-result v4

    iput v4, v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->major:I

    .line 117
    iget-object v4, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->getDefaultClassMinorVersion()I

    move-result v4

    iput v4, v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->minor:I

    .line 120
    :goto_0
    iget-object v4, v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->pool:Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassConstantPool;

    .line 121
    .local v4, "cp":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassConstantPool;
    iget-object v5, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    invoke-virtual {v5}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getClassThisInts()[I

    move-result-object v5

    aget v5, v5, p1

    .line 122
    .local v5, "fullNameIndexInCpClass":I
    iget-object v6, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v6}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getCpClass()[Ljava/lang/String;

    move-result-object v6

    aget-object v6, v6, v5

    .line 124
    .local v6, "fullName":Ljava/lang/String;
    const-string v7, "/"

    invoke-virtual {v6, v7}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v7

    const/4 v8, 0x1

    add-int/2addr v7, v8

    .line 129
    .local v7, "i":I
    iget-object v9, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    invoke-virtual {v9}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getClassAttributes()[Ljava/util/ArrayList;

    move-result-object v9

    aget-object v9, v9, p1

    .line 130
    .local v9, "classAttributes":Ljava/util/ArrayList;
    const/4 v10, 0x0

    .line 131
    .local v10, "sourceFileAttribute":Lorg/apache/commons/compress/harmony/unpack200/bytecode/SourceFileAttribute;
    const/4 v11, 0x0

    .local v11, "index":I
    :goto_1
    invoke-virtual {v9}, Ljava/util/ArrayList;->size()I

    move-result v12

    if-ge v11, v12, :cond_2

    .line 132
    invoke-virtual {v9, v11}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;

    invoke-virtual {v12}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;->isSourceFileAttribute()Z

    move-result v12

    if-eqz v12, :cond_1

    .line 133
    invoke-virtual {v9, v11}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v12

    move-object v10, v12

    check-cast v10, Lorg/apache/commons/compress/harmony/unpack200/bytecode/SourceFileAttribute;

    .line 131
    :cond_1
    add-int/lit8 v11, v11, 0x1

    goto :goto_1

    .line 137
    .end local v11    # "index":I
    :cond_2
    const/4 v11, -0x1

    const/4 v12, 0x0

    if-nez v10, :cond_7

    .line 140
    iget-object v13, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->attrDefinitionBands:Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;

    invoke-virtual {v13}, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->getAttributeDefinitionMap()Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    move-result-object v13

    .line 141
    const-string v14, "SourceFile"

    invoke-virtual {v13, v14, v12}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->getAttributeLayout(Ljava/lang/String;I)Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    move-result-object v13

    .line 142
    .local v13, "SOURCE_FILE":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    iget-object v14, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    invoke-virtual {v14}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getRawClassFlags()[J

    move-result-object v14

    move-object/from16 v16, v9

    .end local v9    # "classAttributes":Ljava/util/ArrayList;
    .local v16, "classAttributes":Ljava/util/ArrayList;
    aget-wide v8, v14, p1

    invoke-virtual {v13, v8, v9}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;->matches(J)Z

    move-result v8

    if-eqz v8, :cond_6

    .line 143
    const/4 v8, -0x1

    .line 144
    .local v8, "firstDollar":I
    const/4 v9, 0x0

    .local v9, "index":I
    :goto_2
    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v14

    if-ge v9, v14, :cond_4

    .line 145
    invoke-virtual {v6, v9}, Ljava/lang/String;->charAt(I)C

    move-result v14

    const/16 v15, 0x24

    if-gt v14, v15, :cond_3

    .line 146
    move v8, v9

    .line 144
    :cond_3
    add-int/lit8 v9, v9, 0x1

    goto :goto_2

    .line 149
    .end local v9    # "index":I
    :cond_4
    const/4 v9, 0x0

    .line 151
    .local v9, "fileName":Ljava/lang/String;
    const-string v14, ".java"

    if-le v8, v11, :cond_5

    if-gt v7, v8, :cond_5

    .line 152
    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v7, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v15, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    goto :goto_3

    .line 154
    :cond_5
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v7}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v11, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    .line 156
    :goto_3
    new-instance v11, Lorg/apache/commons/compress/harmony/unpack200/bytecode/SourceFileAttribute;

    iget-object v14, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v14, v9, v12}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(Ljava/lang/String;Z)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v14

    invoke-direct {v11, v14}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/SourceFileAttribute;-><init>(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;)V

    move-object v10, v11

    .line 157
    const/4 v11, 0x1

    new-array v14, v11, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;

    invoke-virtual {v4, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassConstantPool;->add(Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;

    move-result-object v11

    check-cast v11, Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;

    aput-object v11, v14, v12

    iput-object v14, v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->attributes:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;

    .line 158
    .end local v8    # "firstDollar":I
    .end local v9    # "fileName":Ljava/lang/String;
    goto :goto_4

    .line 159
    :cond_6
    new-array v8, v12, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;

    iput-object v8, v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->attributes:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;

    .line 161
    .end local v13    # "SOURCE_FILE":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    :goto_4
    goto :goto_5

    .line 162
    .end local v16    # "classAttributes":Ljava/util/ArrayList;
    .local v9, "classAttributes":Ljava/util/ArrayList;
    :cond_7
    move-object/from16 v16, v9

    .end local v9    # "classAttributes":Ljava/util/ArrayList;
    .restart local v16    # "classAttributes":Ljava/util/ArrayList;
    const/4 v8, 0x1

    new-array v9, v8, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;

    invoke-virtual {v4, v10}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassConstantPool;->add(Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;

    move-result-object v8

    check-cast v8, Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;

    aput-object v8, v9, v12

    iput-object v9, v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->attributes:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;

    .line 169
    :goto_5
    new-instance v8, Ljava/util/ArrayList;

    invoke-virtual/range {v16 .. v16}, Ljava/util/ArrayList;->size()I

    move-result v9

    invoke-direct {v8, v9}, Ljava/util/ArrayList;-><init>(I)V

    .line 170
    .local v8, "classAttributesWithoutSourceFileAttribute":Ljava/util/ArrayList;
    const/4 v9, 0x0

    .local v9, "index":I
    :goto_6
    invoke-virtual/range {v16 .. v16}, Ljava/util/ArrayList;->size()I

    move-result v11

    if-ge v9, v11, :cond_9

    .line 171
    move-object/from16 v11, v16

    .end local v16    # "classAttributes":Ljava/util/ArrayList;
    .local v11, "classAttributes":Ljava/util/ArrayList;
    invoke-virtual {v11, v9}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;

    .line 172
    .local v13, "attrib":Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;
    invoke-virtual {v13}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;->isSourceFileAttribute()Z

    move-result v14

    if-nez v14, :cond_8

    .line 173
    invoke-virtual {v8, v13}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 170
    .end local v13    # "attrib":Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;
    :cond_8
    add-int/lit8 v9, v9, 0x1

    move-object/from16 v16, v11

    goto :goto_6

    .end local v11    # "classAttributes":Ljava/util/ArrayList;
    .restart local v16    # "classAttributes":Ljava/util/ArrayList;
    :cond_9
    move-object/from16 v11, v16

    .line 176
    .end local v9    # "index":I
    .end local v16    # "classAttributes":Ljava/util/ArrayList;
    .restart local v11    # "classAttributes":Ljava/util/ArrayList;
    iget-object v9, v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->attributes:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;

    .line 177
    .local v9, "originalAttributes":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;
    array-length v13, v9

    .line 178
    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v14

    add-int/2addr v13, v14

    new-array v13, v13, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;

    iput-object v13, v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->attributes:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;

    .line 179
    iget-object v13, v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->attributes:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;

    array-length v14, v9

    invoke-static {v9, v12, v13, v12, v14}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 180
    const/4 v13, 0x0

    .local v13, "index":I
    :goto_7
    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v14

    if-ge v13, v14, :cond_a

    .line 181
    invoke-virtual {v8, v13}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;

    .line 182
    .local v14, "attrib":Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;
    invoke-virtual {v4, v14}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassConstantPool;->add(Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;

    .line 183
    iget-object v12, v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->attributes:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;

    array-length v15, v9

    add-int/2addr v15, v13

    aput-object v14, v12, v15

    .line 180
    .end local v14    # "attrib":Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;
    add-int/lit8 v13, v13, 0x1

    const/4 v12, 0x0

    goto :goto_7

    .line 187
    .end local v13    # "index":I
    :cond_a
    iget-object v12, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v12, v5}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpClassValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;

    move-result-object v12

    invoke-virtual {v4, v12}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassConstantPool;->add(Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;

    move-result-object v12

    .line 188
    .local v12, "cfThis":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    iget-object v13, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    iget-object v14, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    invoke-virtual {v14}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getClassSuperInts()[I

    move-result-object v14

    aget v14, v14, p1

    invoke-virtual {v13, v14}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpClassValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;

    move-result-object v13

    invoke-virtual {v4, v13}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassConstantPool;->add(Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;

    move-result-object v13

    .line 190
    .local v13, "cfSuper":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    iget-object v14, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    invoke-virtual {v14}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getClassInterfacesInts()[[I

    move-result-object v14

    aget-object v14, v14, p1

    array-length v14, v14

    new-array v14, v14, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;

    .line 191
    .local v14, "cfInterfaces":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    const/4 v7, 0x0

    :goto_8
    array-length v15, v14

    if-ge v7, v15, :cond_b

    .line 192
    iget-object v15, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-object/from16 v17, v2

    .end local v2    # "major":[I
    .local v17, "major":[I
    iget-object v2, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getClassInterfacesInts()[[I

    move-result-object v2

    aget-object v2, v2, p1

    aget v2, v2, v7

    invoke-virtual {v15, v2}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpClassValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;

    move-result-object v2

    invoke-virtual {v4, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassConstantPool;->add(Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;

    move-result-object v2

    aput-object v2, v14, v7

    .line 191
    add-int/lit8 v7, v7, 0x1

    move-object/from16 v2, v17

    goto :goto_8

    .line 195
    .end local v17    # "major":[I
    .restart local v2    # "major":[I
    :cond_b
    move-object/from16 v17, v2

    .end local v2    # "major":[I
    .restart local v17    # "major":[I
    iget-object v2, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getClassFieldCount()[I

    move-result-object v2

    aget v2, v2, p1

    new-array v2, v2, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;

    .line 197
    .local v2, "cfFields":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    const/4 v7, 0x0

    :goto_9
    array-length v15, v2

    if-ge v7, v15, :cond_c

    .line 198
    iget-object v15, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    invoke-virtual {v15}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getFieldDescrInts()[[I

    move-result-object v15

    aget-object v15, v15, p1

    aget v15, v15, v7

    .line 199
    .local v15, "descriptorIndex":I
    move-object/from16 v18, v3

    .end local v3    # "minor":[I
    .local v18, "minor":[I
    iget-object v3, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v3}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getCpDescriptorNameInts()[I

    move-result-object v3

    aget v3, v3, v15

    .line 200
    .local v3, "nameIndex":I
    move/from16 v19, v5

    .end local v5    # "fullNameIndexInCpClass":I
    .local v19, "fullNameIndexInCpClass":I
    iget-object v5, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v5}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getCpDescriptorTypeInts()[I

    move-result-object v5

    aget v5, v5, v15

    .line 201
    .local v5, "typeIndex":I
    move-object/from16 v20, v8

    .end local v8    # "classAttributesWithoutSourceFileAttribute":Ljava/util/ArrayList;
    .local v20, "classAttributesWithoutSourceFileAttribute":Ljava/util/ArrayList;
    iget-object v8, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v8, v3}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v8

    .line 202
    .local v8, "name":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    move/from16 v27, v3

    .end local v3    # "nameIndex":I
    .local v27, "nameIndex":I
    iget-object v3, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v3, v5}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpSignatureValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v3

    .line 203
    .local v3, "descriptor":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    move/from16 v28, v5

    .end local v5    # "typeIndex":I
    .local v28, "typeIndex":I
    new-instance v5, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPField;

    move-object/from16 v29, v9

    .end local v9    # "originalAttributes":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;
    .local v29, "originalAttributes":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;
    iget-object v9, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    invoke-virtual {v9}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getFieldFlags()[[J

    move-result-object v9

    aget-object v9, v9, p1

    aget-wide v24, v9, v7

    iget-object v9, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    .line 204
    invoke-virtual {v9}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getFieldAttributes()[[Ljava/util/ArrayList;

    move-result-object v9

    aget-object v9, v9, p1

    aget-object v26, v9, v7

    move-object/from16 v21, v5

    move-object/from16 v22, v8

    move-object/from16 v23, v3

    invoke-direct/range {v21 .. v26}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPField;-><init>(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;JLjava/util/List;)V

    .line 203
    invoke-virtual {v4, v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassConstantPool;->add(Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;

    move-result-object v5

    aput-object v5, v2, v7

    .line 197
    .end local v3    # "descriptor":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    .end local v8    # "name":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    .end local v15    # "descriptorIndex":I
    .end local v27    # "nameIndex":I
    .end local v28    # "typeIndex":I
    add-int/lit8 v7, v7, 0x1

    move-object/from16 v3, v18

    move/from16 v5, v19

    move-object/from16 v8, v20

    move-object/from16 v9, v29

    goto :goto_9

    .line 207
    .end local v18    # "minor":[I
    .end local v19    # "fullNameIndexInCpClass":I
    .end local v20    # "classAttributesWithoutSourceFileAttribute":Ljava/util/ArrayList;
    .end local v29    # "originalAttributes":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;
    .local v3, "minor":[I
    .local v5, "fullNameIndexInCpClass":I
    .local v8, "classAttributesWithoutSourceFileAttribute":Ljava/util/ArrayList;
    .restart local v9    # "originalAttributes":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;
    :cond_c
    move-object/from16 v18, v3

    move/from16 v19, v5

    move-object/from16 v20, v8

    move-object/from16 v29, v9

    .end local v3    # "minor":[I
    .end local v5    # "fullNameIndexInCpClass":I
    .end local v8    # "classAttributesWithoutSourceFileAttribute":Ljava/util/ArrayList;
    .end local v9    # "originalAttributes":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;
    .restart local v18    # "minor":[I
    .restart local v19    # "fullNameIndexInCpClass":I
    .restart local v20    # "classAttributesWithoutSourceFileAttribute":Ljava/util/ArrayList;
    .restart local v29    # "originalAttributes":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;
    iget-object v3, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    invoke-virtual {v3}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getClassMethodCount()[I

    move-result-object v3

    aget v3, v3, p1

    new-array v3, v3, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;

    .line 209
    .local v3, "cfMethods":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    const/4 v5, 0x0

    .end local v7    # "i":I
    .local v5, "i":I
    :goto_a
    array-length v7, v3

    if-ge v5, v7, :cond_d

    .line 210
    iget-object v7, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    invoke-virtual {v7}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getMethodDescrInts()[[I

    move-result-object v7

    aget-object v7, v7, p1

    aget v7, v7, v5

    .line 211
    .local v7, "descriptorIndex":I
    iget-object v8, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v8}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getCpDescriptorNameInts()[I

    move-result-object v8

    aget v8, v8, v7

    .line 212
    .local v8, "nameIndex":I
    iget-object v9, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v9}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getCpDescriptorTypeInts()[I

    move-result-object v9

    aget v9, v9, v7

    .line 213
    .local v9, "typeIndex":I
    iget-object v15, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v15, v8}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v15

    .line 214
    .local v15, "name":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    move/from16 v27, v7

    .end local v7    # "descriptorIndex":I
    .local v27, "descriptorIndex":I
    iget-object v7, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v7, v9}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpSignatureValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v7

    .line 215
    .local v7, "descriptor":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    move/from16 v28, v8

    .end local v8    # "nameIndex":I
    .local v28, "nameIndex":I
    new-instance v8, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPMethod;

    move/from16 v30, v9

    .end local v9    # "typeIndex":I
    .local v30, "typeIndex":I
    iget-object v9, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    invoke-virtual {v9}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getMethodFlags()[[J

    move-result-object v9

    aget-object v9, v9, p1

    aget-wide v24, v9, v5

    iget-object v9, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    .line 216
    invoke-virtual {v9}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getMethodAttributes()[[Ljava/util/ArrayList;

    move-result-object v9

    aget-object v9, v9, p1

    aget-object v26, v9, v5

    move-object/from16 v21, v8

    move-object/from16 v22, v15

    move-object/from16 v23, v7

    invoke-direct/range {v21 .. v26}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPMethod;-><init>(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;JLjava/util/List;)V

    .line 215
    invoke-virtual {v4, v8}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassConstantPool;->add(Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;

    move-result-object v8

    aput-object v8, v3, v5

    .line 209
    .end local v7    # "descriptor":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    .end local v15    # "name":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    .end local v27    # "descriptorIndex":I
    .end local v28    # "nameIndex":I
    .end local v30    # "typeIndex":I
    add-int/lit8 v5, v5, 0x1

    goto :goto_a

    .line 218
    :cond_d
    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassConstantPool;->addNestedEntries()V

    .line 221
    const/4 v7, 0x0

    .line 222
    .local v7, "addInnerClassesAttr":Z
    invoke-virtual/range {p0 .. p0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getClassBands()Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    move-result-object v8

    invoke-virtual {v8}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getIcLocal()[[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    move-result-object v8

    aget-object v8, v8, p1

    .line 223
    .local v8, "ic_local":[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    if-eqz v8, :cond_e

    const/16 v16, 0x1

    goto :goto_b

    :cond_e
    const/16 v16, 0x0

    :goto_b
    move/from16 v9, v16

    .line 224
    .local v9, "ic_local_sent":Z
    new-instance v15, Lorg/apache/commons/compress/harmony/unpack200/bytecode/InnerClassesAttribute;

    move/from16 v16, v5

    .end local v5    # "i":I
    .local v16, "i":I
    const-string v5, "InnerClasses"

    invoke-direct {v15, v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/InnerClassesAttribute;-><init>(Ljava/lang/String;)V

    move-object v5, v15

    .line 225
    .local v5, "innerClassesAttribute":Lorg/apache/commons/compress/harmony/unpack200/bytecode/InnerClassesAttribute;
    invoke-virtual/range {p0 .. p0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getIcBands()Lorg/apache/commons/compress/harmony/unpack200/IcBands;

    move-result-object v15

    invoke-virtual {v15, v6, v4}, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->getRelevantIcTuples(Ljava/lang/String;Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassConstantPool;)[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    move-result-object v15

    .line 226
    .local v15, "ic_relevant":[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    move-object/from16 v21, v6

    .end local v6    # "fullName":Ljava/lang/String;
    .local v21, "fullName":Ljava/lang/String;
    invoke-direct {v0, v8, v15}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->computeIcStored([Lorg/apache/commons/compress/harmony/unpack200/IcTuple;[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;)Ljava/util/List;

    move-result-object v6

    .line 227
    .local v6, "ic_stored":Ljava/util/List;
    const/16 v22, 0x0

    move/from16 v35, v22

    move/from16 v22, v7

    move/from16 v7, v35

    .local v7, "index":I
    .local v22, "addInnerClassesAttr":Z
    :goto_c
    move-object/from16 v23, v10

    .end local v10    # "sourceFileAttribute":Lorg/apache/commons/compress/harmony/unpack200/bytecode/SourceFileAttribute;
    .local v23, "sourceFileAttribute":Lorg/apache/commons/compress/harmony/unpack200/bytecode/SourceFileAttribute;
    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v10

    if-ge v7, v10, :cond_14

    .line 228
    invoke-interface {v6, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    .line 229
    .local v10, "icStored":Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    move-object/from16 v24, v6

    .end local v6    # "ic_stored":Ljava/util/List;
    .local v24, "ic_stored":Ljava/util/List;
    invoke-virtual {v10}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->thisClassIndex()I

    move-result v6

    .line 230
    .local v6, "innerClassIndex":I
    move-object/from16 v25, v11

    .end local v11    # "classAttributes":Ljava/util/ArrayList;
    .local v25, "classAttributes":Ljava/util/ArrayList;
    invoke-virtual {v10}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->outerClassIndex()I

    move-result v11

    .line 231
    .local v11, "outerClassIndex":I
    move-object/from16 v26, v3

    .end local v3    # "cfMethods":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .local v26, "cfMethods":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    invoke-virtual {v10}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->simpleClassNameIndex()I

    move-result v3

    .line 233
    .local v3, "simpleClassNameIndex":I
    move-object/from16 v27, v2

    .end local v2    # "cfFields":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .local v27, "cfFields":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    invoke-virtual {v10}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->thisClassString()Ljava/lang/String;

    move-result-object v2

    .line 234
    .local v2, "innerClassString":Ljava/lang/String;
    move-object/from16 v28, v14

    .end local v14    # "cfInterfaces":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .local v28, "cfInterfaces":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    invoke-virtual {v10}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->outerClassString()Ljava/lang/String;

    move-result-object v14

    .line 235
    .local v14, "outerClassString":Ljava/lang/String;
    move-object/from16 v30, v13

    .end local v13    # "cfSuper":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .local v30, "cfSuper":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    invoke-virtual {v10}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->simpleClassName()Ljava/lang/String;

    move-result-object v13

    .line 237
    .local v13, "simpleClassName":Ljava/lang/String;
    const/16 v31, 0x0

    .line 238
    .local v31, "innerClass":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;
    const/16 v32, 0x0

    .line 239
    .local v32, "innerName":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    const/16 v33, 0x0

    .line 241
    .local v33, "outerClass":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;
    move-object/from16 v34, v12

    const/4 v12, -0x1

    .end local v12    # "cfThis":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .local v34, "cfThis":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    if-eq v6, v12, :cond_f

    iget-object v12, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v12, v6}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpClassValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;

    move-result-object v12

    goto :goto_d

    :cond_f
    iget-object v12, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    .line 242
    invoke-virtual {v12, v2}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpClassValue(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;

    move-result-object v12

    :goto_d
    nop

    .line 243
    .end local v31    # "innerClass":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;
    .local v12, "innerClass":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;
    invoke-virtual {v10}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->isAnonymous()Z

    move-result v31

    if-nez v31, :cond_11

    .line 244
    move-object/from16 v31, v2

    const/4 v2, -0x1

    .end local v2    # "innerClassString":Ljava/lang/String;
    .local v31, "innerClassString":Ljava/lang/String;
    if-eq v3, v2, :cond_10

    iget-object v2, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v2

    goto :goto_e

    :cond_10
    iget-object v2, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    .line 245
    invoke-virtual {v2, v13}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v2

    :goto_e
    move-object/from16 v32, v2

    goto :goto_f

    .line 243
    .end local v31    # "innerClassString":Ljava/lang/String;
    .restart local v2    # "innerClassString":Ljava/lang/String;
    :cond_11
    move-object/from16 v31, v2

    .end local v2    # "innerClassString":Ljava/lang/String;
    .restart local v31    # "innerClassString":Ljava/lang/String;
    move-object/from16 v2, v32

    .line 248
    .end local v32    # "innerName":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    .local v2, "innerName":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    :goto_f
    invoke-virtual {v10}, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->isMember()Z

    move-result v32

    if-eqz v32, :cond_13

    .line 249
    move/from16 v32, v3

    const/4 v3, -0x1

    .end local v3    # "simpleClassNameIndex":I
    .local v32, "simpleClassNameIndex":I
    if-eq v11, v3, :cond_12

    iget-object v3, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v3, v11}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpClassValue(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;

    move-result-object v3

    goto :goto_10

    :cond_12
    iget-object v3, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    .line 250
    invoke-virtual {v3, v14}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpClassValue(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;

    move-result-object v3

    :goto_10
    move-object/from16 v33, v3

    goto :goto_11

    .line 248
    .end local v32    # "simpleClassNameIndex":I
    .restart local v3    # "simpleClassNameIndex":I
    :cond_13
    move/from16 v32, v3

    .end local v3    # "simpleClassNameIndex":I
    .restart local v32    # "simpleClassNameIndex":I
    move-object/from16 v3, v33

    .line 252
    .end local v33    # "outerClass":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;
    .local v3, "outerClass":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;
    :goto_11
    move/from16 v33, v6

    .end local v6    # "innerClassIndex":I
    .local v33, "innerClassIndex":I
    iget v6, v10, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;->F:I

    .line 253
    .local v6, "flags":I
    invoke-virtual {v5, v12, v3, v2, v6}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/InnerClassesAttribute;->addInnerClassesEntry(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;I)V

    .line 254
    const/16 v22, 0x1

    .line 227
    .end local v2    # "innerName":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;
    .end local v3    # "outerClass":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;
    .end local v6    # "flags":I
    .end local v10    # "icStored":Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    .end local v11    # "outerClassIndex":I
    .end local v12    # "innerClass":Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPClass;
    .end local v13    # "simpleClassName":Ljava/lang/String;
    .end local v14    # "outerClassString":Ljava/lang/String;
    .end local v31    # "innerClassString":Ljava/lang/String;
    .end local v32    # "simpleClassNameIndex":I
    .end local v33    # "innerClassIndex":I
    add-int/lit8 v7, v7, 0x1

    move-object/from16 v10, v23

    move-object/from16 v6, v24

    move-object/from16 v11, v25

    move-object/from16 v3, v26

    move-object/from16 v2, v27

    move-object/from16 v14, v28

    move-object/from16 v13, v30

    move-object/from16 v12, v34

    goto/16 :goto_c

    .end local v24    # "ic_stored":Ljava/util/List;
    .end local v25    # "classAttributes":Ljava/util/ArrayList;
    .end local v26    # "cfMethods":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .end local v27    # "cfFields":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .end local v28    # "cfInterfaces":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .end local v30    # "cfSuper":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .end local v34    # "cfThis":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .local v2, "cfFields":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .local v3, "cfMethods":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .local v6, "ic_stored":Ljava/util/List;
    .local v11, "classAttributes":Ljava/util/ArrayList;
    .local v12, "cfThis":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .local v13, "cfSuper":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .local v14, "cfInterfaces":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    :cond_14
    move-object/from16 v27, v2

    move-object/from16 v26, v3

    move-object/from16 v24, v6

    move-object/from16 v25, v11

    move-object/from16 v34, v12

    move-object/from16 v30, v13

    move-object/from16 v28, v14

    .line 258
    .end local v2    # "cfFields":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .end local v3    # "cfMethods":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .end local v6    # "ic_stored":Ljava/util/List;
    .end local v7    # "index":I
    .end local v11    # "classAttributes":Ljava/util/ArrayList;
    .end local v12    # "cfThis":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .end local v13    # "cfSuper":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .end local v14    # "cfInterfaces":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .restart local v24    # "ic_stored":Ljava/util/List;
    .restart local v25    # "classAttributes":Ljava/util/ArrayList;
    .restart local v26    # "cfMethods":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .restart local v27    # "cfFields":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .restart local v28    # "cfInterfaces":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .restart local v30    # "cfSuper":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .restart local v34    # "cfThis":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    if-eqz v9, :cond_15

    array-length v2, v8

    if-nez v2, :cond_15

    .line 259
    const/4 v7, 0x0

    .end local v22    # "addInnerClassesAttr":Z
    .local v7, "addInnerClassesAttr":Z
    goto :goto_12

    .line 264
    .end local v7    # "addInnerClassesAttr":Z
    .restart local v22    # "addInnerClassesAttr":Z
    :cond_15
    move/from16 v7, v22

    .end local v22    # "addInnerClassesAttr":Z
    .restart local v7    # "addInnerClassesAttr":Z
    :goto_12
    if-nez v9, :cond_16

    array-length v2, v15

    if-nez v2, :cond_16

    .line 265
    const/4 v7, 0x0

    .line 268
    :cond_16
    if-eqz v7, :cond_18

    .line 271
    iget-object v2, v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->attributes:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;

    .line 272
    .local v2, "originalAttrs":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;
    array-length v3, v2

    const/4 v6, 0x1

    add-int/2addr v3, v6

    move-object v6, v15

    .end local v15    # "ic_relevant":[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    .local v6, "ic_relevant":[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    new-array v3, v3, [Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;

    .line 273
    .local v3, "newAttrs":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;
    const/4 v10, 0x0

    .local v10, "index":I
    :goto_13
    array-length v11, v2

    if-ge v10, v11, :cond_17

    .line 274
    aget-object v11, v2, v10

    aput-object v11, v3, v10

    .line 273
    add-int/lit8 v10, v10, 0x1

    goto :goto_13

    .line 276
    .end local v10    # "index":I
    :cond_17
    array-length v10, v3

    const/4 v11, 0x1

    sub-int/2addr v10, v11

    aput-object v5, v3, v10

    .line 277
    iput-object v3, v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->attributes:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;

    .line 278
    invoke-virtual {v4, v5}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassConstantPool;->addWithNestedEntries(Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;

    goto :goto_14

    .line 268
    .end local v2    # "originalAttrs":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;
    .end local v3    # "newAttrs":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/Attribute;
    .end local v6    # "ic_relevant":[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    .restart local v15    # "ic_relevant":[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    :cond_18
    move-object v6, v15

    .line 281
    .end local v15    # "ic_relevant":[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    .restart local v6    # "ic_relevant":[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    :goto_14
    invoke-virtual {v4, v0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassConstantPool;->resolve(Lorg/apache/commons/compress/harmony/unpack200/Segment;)V

    .line 284
    iget-object v2, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getClassFlags()[J

    move-result-object v2

    aget-wide v10, v2, p1

    long-to-int v2, v10

    iput v2, v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->accessFlags:I

    .line 285
    move-object/from16 v2, v34

    .end local v34    # "cfThis":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .local v2, "cfThis":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    invoke-virtual {v4, v2}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassConstantPool;->indexOf(Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;)I

    move-result v3

    iput v3, v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->thisClass:I

    .line 286
    move-object/from16 v3, v30

    .end local v30    # "cfSuper":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .local v3, "cfSuper":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    invoke-virtual {v4, v3}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassConstantPool;->indexOf(Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;)I

    move-result v10

    iput v10, v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->superClass:I

    .line 288
    move-object/from16 v10, v28

    .end local v28    # "cfInterfaces":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .local v10, "cfInterfaces":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    array-length v11, v10

    new-array v11, v11, [I

    iput-object v11, v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->interfaces:[I

    .line 289
    const/4 v11, 0x0

    .end local v16    # "i":I
    .local v11, "i":I
    :goto_15
    array-length v12, v10

    if-ge v11, v12, :cond_19

    .line 290
    iget-object v12, v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->interfaces:[I

    aget-object v13, v10, v11

    invoke-virtual {v4, v13}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassConstantPool;->indexOf(Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;)I

    move-result v13

    aput v13, v12, v11

    .line 289
    add-int/lit8 v11, v11, 0x1

    goto :goto_15

    .line 292
    :cond_19
    move-object/from16 v12, v27

    .end local v27    # "cfFields":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .local v12, "cfFields":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    iput-object v12, v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->fields:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;

    .line 293
    move-object/from16 v13, v26

    .end local v26    # "cfMethods":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    .local v13, "cfMethods":[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
    iput-object v13, v1, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->methods:[Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;

    .line 294
    return-object v1
.end method

.method private computeIcStored([Lorg/apache/commons/compress/harmony/unpack200/IcTuple;[Lorg/apache/commons/compress/harmony/unpack200/IcTuple;)Ljava/util/List;
    .locals 5
    .param p1, "ic_local"    # [Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    .param p2, "ic_relevant"    # [Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    .line 306
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p2

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 307
    .local v0, "result":Ljava/util/List;
    new-instance v1, Ljava/util/ArrayList;

    array-length v2, p2

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(I)V

    .line 308
    .local v1, "duplicates":Ljava/util/List;
    new-instance v2, Ljava/util/HashSet;

    array-length v3, p2

    invoke-direct {v2, v3}, Ljava/util/HashSet;-><init>(I)V

    .line 314
    .local v2, "isInResult":Ljava/util/Set;
    if-eqz p1, :cond_1

    .line 315
    const/4 v3, 0x0

    .local v3, "index":I
    :goto_0
    array-length v4, p1

    if-ge v3, v4, :cond_1

    .line 316
    aget-object v4, p1, v3

    invoke-interface {v2, v4}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 317
    aget-object v4, p1, v3

    invoke-interface {v0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 315
    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 323
    .end local v3    # "index":I
    :cond_1
    const/4 v3, 0x0

    .restart local v3    # "index":I
    :goto_1
    array-length v4, p2

    if-ge v3, v4, :cond_3

    .line 324
    aget-object v4, p2, v3

    invoke-interface {v2, v4}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 325
    aget-object v4, p2, v3

    invoke-interface {v0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_2

    .line 327
    :cond_2
    aget-object v4, p2, v3

    invoke-interface {v1, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 323
    :goto_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 332
    .end local v3    # "index":I
    :cond_3
    const/4 v3, 0x0

    .restart local v3    # "index":I
    :goto_3
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v4

    if-ge v3, v4, :cond_4

    .line 333
    invoke-interface {v1, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lorg/apache/commons/compress/harmony/unpack200/IcTuple;

    .line 334
    .local v4, "tuple":Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    invoke-interface {v0, v4}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 332
    .end local v4    # "tuple":Lorg/apache/commons/compress/harmony/unpack200/IcTuple;
    add-int/lit8 v3, v3, 0x1

    goto :goto_3

    .line 337
    .end local v3    # "index":I
    :cond_4
    return-object v0
.end method

.method private parseSegment()V
    .locals 17
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 375
    move-object/from16 v0, p0

    iget-object v1, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->unpack()V

    .line 376
    iget-object v1, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->unpack()V

    .line 377
    iget-object v1, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->attrDefinitionBands:Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->unpack()V

    .line 378
    iget-object v1, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->icBands:Lorg/apache/commons/compress/harmony/unpack200/IcBands;

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->unpack()V

    .line 379
    iget-object v1, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->unpack()V

    .line 380
    iget-object v1, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->bcBands:Lorg/apache/commons/compress/harmony/unpack200/BcBands;

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/unpack200/BcBands;->unpack()V

    .line 381
    iget-object v1, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->fileBands:Lorg/apache/commons/compress/harmony/unpack200/FileBands;

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/unpack200/FileBands;->unpack()V

    .line 383
    const/4 v1, 0x0

    .line 384
    .local v1, "classNum":I
    iget-object v2, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->getNumberOfFiles()I

    move-result v2

    .line 385
    .local v2, "numberOfFiles":I
    iget-object v3, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->fileBands:Lorg/apache/commons/compress/harmony/unpack200/FileBands;

    invoke-virtual {v3}, Lorg/apache/commons/compress/harmony/unpack200/FileBands;->getFileName()[Ljava/lang/String;

    move-result-object v3

    .line 386
    .local v3, "fileName":[Ljava/lang/String;
    iget-object v4, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->fileBands:Lorg/apache/commons/compress/harmony/unpack200/FileBands;

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/FileBands;->getFileOptions()[I

    move-result-object v4

    .line 387
    .local v4, "fileOptions":[I
    iget-object v5, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    invoke-virtual {v5}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->getOptions()Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;

    move-result-object v5

    .line 389
    .local v5, "options":Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;
    new-array v6, v2, [[B

    iput-object v6, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classFilesContents:[[B

    .line 390
    new-array v6, v2, [Z

    iput-object v6, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->fileDeflate:[Z

    .line 391
    new-array v6, v2, [Z

    iput-object v6, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->fileIsClass:[Z

    .line 393
    new-instance v6, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v6}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 394
    .local v6, "bos":Ljava/io/ByteArrayOutputStream;
    new-instance v7, Ljava/io/DataOutputStream;

    invoke-direct {v7, v6}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 396
    .local v7, "dos":Ljava/io/DataOutputStream;
    const/4 v8, 0x0

    .local v8, "i":I
    :goto_0
    if-ge v8, v2, :cond_9

    .line 397
    aget-object v9, v3, v8

    .line 399
    .local v9, "name":Ljava/lang/String;
    const/4 v11, 0x1

    if-eqz v9, :cond_1

    const-string v12, ""

    invoke-virtual {v9, v12}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v12

    if-eqz v12, :cond_0

    goto :goto_1

    :cond_0
    const/4 v12, 0x0

    goto :goto_2

    :cond_1
    :goto_1
    move v12, v11

    .line 400
    .local v12, "nameIsEmpty":Z
    :goto_2
    aget v13, v4, v8

    const/4 v14, 0x2

    and-int/2addr v13, v14

    if-eq v13, v14, :cond_3

    if-eqz v12, :cond_2

    goto :goto_3

    :cond_2
    const/4 v13, 0x0

    goto :goto_4

    :cond_3
    :goto_3
    move v13, v11

    .line 401
    .local v13, "isClass":Z
    :goto_4
    if-eqz v13, :cond_4

    if-eqz v12, :cond_4

    .line 402
    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v15, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v15}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getCpClass()[Ljava/lang/String;

    move-result-object v15

    iget-object v10, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    invoke-virtual {v10}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->getClassThisInts()[I

    move-result-object v10

    aget v10, v10, v1

    aget-object v10, v15, v10

    invoke-virtual {v14, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v14, ".class"

    invoke-virtual {v10, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    .line 403
    aput-object v9, v3, v8

    .line 406
    :cond_4
    iget-boolean v10, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->overrideDeflateHint:Z

    if-nez v10, :cond_7

    .line 407
    iget-object v10, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->fileDeflate:[Z

    aget v14, v4, v8

    and-int/2addr v14, v11

    if-eq v14, v11, :cond_6

    invoke-virtual {v5}, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->shouldDeflate()Z

    move-result v14

    if-eqz v14, :cond_5

    goto :goto_5

    :cond_5
    const/16 v16, 0x0

    goto :goto_6

    :cond_6
    :goto_5
    move/from16 v16, v11

    :goto_6
    aput-boolean v16, v10, v8

    goto :goto_7

    .line 409
    :cond_7
    iget-object v10, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->fileDeflate:[Z

    iget-boolean v11, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->deflateHint:Z

    aput-boolean v11, v10, v8

    .line 412
    :goto_7
    iget-object v10, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->fileIsClass:[Z

    aput-boolean v13, v10, v8

    .line 414
    if-eqz v13, :cond_8

    .line 415
    invoke-direct {v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->buildClassFile(I)Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;

    move-result-object v10

    .line 416
    .local v10, "classFile":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;
    invoke-virtual {v10, v7}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;->write(Ljava/io/DataOutputStream;)V

    .line 417
    invoke-virtual {v7}, Ljava/io/DataOutputStream;->flush()V

    .line 419
    iget-object v11, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classFilesContents:[[B

    invoke-virtual {v6}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v14

    aput-object v14, v11, v1

    .line 420
    invoke-virtual {v6}, Ljava/io/ByteArrayOutputStream;->reset()V

    .line 422
    add-int/lit8 v1, v1, 0x1

    .line 396
    .end local v9    # "name":Ljava/lang/String;
    .end local v10    # "classFile":Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFile;
    .end local v12    # "nameIsEmpty":Z
    .end local v13    # "isClass":Z
    :cond_8
    add-int/lit8 v8, v8, 0x1

    goto/16 :goto_0

    .line 425
    .end local v8    # "i":I
    :cond_9
    return-void
.end method

.method private readSegment(Ljava/io/InputStream;)V
    .locals 2
    .param p1, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 349
    const/4 v0, 0x2

    const-string v1, "-------"

    invoke-virtual {p0, v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->log(ILjava/lang/String;)V

    .line 350
    new-instance v0, Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-direct {v0, p0}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;-><init>(Lorg/apache/commons/compress/harmony/unpack200/Segment;)V

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    .line 351
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v0, p1}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->read(Ljava/io/InputStream;)V

    .line 352
    new-instance v0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;

    invoke-direct {v0, p0}, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;-><init>(Lorg/apache/commons/compress/harmony/unpack200/Segment;)V

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->attrDefinitionBands:Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;

    .line 353
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->attrDefinitionBands:Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;

    invoke-virtual {v0, p1}, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->read(Ljava/io/InputStream;)V

    .line 354
    new-instance v0, Lorg/apache/commons/compress/harmony/unpack200/IcBands;

    invoke-direct {v0, p0}, Lorg/apache/commons/compress/harmony/unpack200/IcBands;-><init>(Lorg/apache/commons/compress/harmony/unpack200/Segment;)V

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->icBands:Lorg/apache/commons/compress/harmony/unpack200/IcBands;

    .line 355
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->icBands:Lorg/apache/commons/compress/harmony/unpack200/IcBands;

    invoke-virtual {v0, p1}, Lorg/apache/commons/compress/harmony/unpack200/IcBands;->read(Ljava/io/InputStream;)V

    .line 356
    new-instance v0, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    invoke-direct {v0, p0}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;-><init>(Lorg/apache/commons/compress/harmony/unpack200/Segment;)V

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    .line 357
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    invoke-virtual {v0, p1}, Lorg/apache/commons/compress/harmony/unpack200/ClassBands;->read(Ljava/io/InputStream;)V

    .line 358
    new-instance v0, Lorg/apache/commons/compress/harmony/unpack200/BcBands;

    invoke-direct {v0, p0}, Lorg/apache/commons/compress/harmony/unpack200/BcBands;-><init>(Lorg/apache/commons/compress/harmony/unpack200/Segment;)V

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->bcBands:Lorg/apache/commons/compress/harmony/unpack200/BcBands;

    .line 359
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->bcBands:Lorg/apache/commons/compress/harmony/unpack200/BcBands;

    invoke-virtual {v0, p1}, Lorg/apache/commons/compress/harmony/unpack200/BcBands;->read(Ljava/io/InputStream;)V

    .line 360
    new-instance v0, Lorg/apache/commons/compress/harmony/unpack200/FileBands;

    invoke-direct {v0, p0}, Lorg/apache/commons/compress/harmony/unpack200/FileBands;-><init>(Lorg/apache/commons/compress/harmony/unpack200/Segment;)V

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->fileBands:Lorg/apache/commons/compress/harmony/unpack200/FileBands;

    .line 361
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->fileBands:Lorg/apache/commons/compress/harmony/unpack200/FileBands;

    invoke-virtual {v0, p1}, Lorg/apache/commons/compress/harmony/unpack200/FileBands;->read(Ljava/io/InputStream;)V

    .line 363
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->fileBands:Lorg/apache/commons/compress/harmony/unpack200/FileBands;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/FileBands;->processFileBits()V

    .line 364
    return-void
.end method


# virtual methods
.method protected getAttrDefinitionBands()Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;
    .locals 1

    .line 553
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->attrDefinitionBands:Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;

    return-object v0
.end method

.method protected getClassBands()Lorg/apache/commons/compress/harmony/unpack200/ClassBands;
    .locals 1

    .line 557
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classBands:Lorg/apache/commons/compress/harmony/unpack200/ClassBands;

    return-object v0
.end method

.method public getConstantPool()Lorg/apache/commons/compress/harmony/unpack200/SegmentConstantPool;
    .locals 1

    .line 541
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getConstantPool()Lorg/apache/commons/compress/harmony/unpack200/SegmentConstantPool;

    move-result-object v0

    return-object v0
.end method

.method protected getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;
    .locals 1

    .line 561
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->cpBands:Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    return-object v0
.end method

.method protected getIcBands()Lorg/apache/commons/compress/harmony/unpack200/IcBands;
    .locals 1

    .line 565
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->icBands:Lorg/apache/commons/compress/harmony/unpack200/IcBands;

    return-object v0
.end method

.method public getSegmentHeader()Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;
    .locals 1

    .line 545
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    return-object v0
.end method

.method public log(ILjava/lang/String;)V
    .locals 1
    .param p1, "logLevel"    # I
    .param p2, "message"    # Ljava/lang/String;

    .line 577
    iget v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->logLevel:I

    if-lt v0, p1, :cond_0

    .line 578
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->logStream:Ljava/io/PrintWriter;

    invoke-virtual {v0, p2}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 580
    :cond_0
    return-void
.end method

.method public overrideDeflateHint(Z)V
    .locals 1
    .param p1, "deflateHint"    # Z

    .line 588
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->overrideDeflateHint:Z

    .line 589
    iput-boolean p1, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->deflateHint:Z

    .line 590
    return-void
.end method

.method public setLogLevel(I)V
    .locals 0
    .param p1, "logLevel"    # I

    .line 569
    iput p1, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->logLevel:I

    .line 570
    return-void
.end method

.method public setLogStream(Ljava/io/OutputStream;)V
    .locals 1
    .param p1, "logStream"    # Ljava/io/OutputStream;

    .line 573
    new-instance v0, Ljava/io/PrintWriter;

    invoke-direct {v0, p1}, Ljava/io/PrintWriter;-><init>(Ljava/io/OutputStream;)V

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->logStream:Ljava/io/PrintWriter;

    .line 574
    return-void
.end method

.method public setPreRead(Z)V
    .locals 0
    .param p1, "value"    # Z

    .line 549
    iput-boolean p1, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->doPreRead:Z

    .line 550
    return-void
.end method

.method public unpack(Ljava/io/InputStream;Ljava/util/jar/JarOutputStream;)V
    .locals 0
    .param p1, "in"    # Ljava/io/InputStream;
    .param p2, "out"    # Ljava/util/jar/JarOutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 436
    invoke-virtual {p0, p1}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->unpackRead(Ljava/io/InputStream;)V

    .line 437
    invoke-virtual {p0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->unpackProcess()V

    .line 438
    invoke-virtual {p0, p2}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->unpackWrite(Ljava/util/jar/JarOutputStream;)V

    .line 439
    return-void
.end method

.method unpackProcess()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 464
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->internalBuffer:Ljava/io/InputStream;

    if-eqz v0, :cond_0

    .line 465
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->internalBuffer:Ljava/io/InputStream;

    invoke-direct {p0, v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->readSegment(Ljava/io/InputStream;)V

    .line 467
    :cond_0
    invoke-direct {p0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->parseSegment()V

    .line 468
    return-void
.end method

.method unpackRead(Ljava/io/InputStream;)V
    .locals 5
    .param p1, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 445
    invoke-virtual {p1}, Ljava/io/InputStream;->markSupported()Z

    move-result v0

    if-nez v0, :cond_0

    .line 446
    new-instance v0, Ljava/io/BufferedInputStream;

    invoke-direct {v0, p1}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    move-object p1, v0

    .line 449
    :cond_0
    new-instance v0, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    invoke-direct {v0, p0}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;-><init>(Lorg/apache/commons/compress/harmony/unpack200/Segment;)V

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    .line 450
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    invoke-virtual {v0, p1}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->read(Ljava/io/InputStream;)V

    .line 452
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->getArchiveSize()J

    move-result-wide v0

    long-to-int v0, v0

    iget-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->getArchiveSizeOffset()I

    move-result v1

    sub-int/2addr v0, v1

    .line 454
    .local v0, "size":I
    iget-boolean v1, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->doPreRead:Z

    if-eqz v1, :cond_1

    iget-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    invoke-virtual {v1}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->getArchiveSize()J

    move-result-wide v1

    const-wide/16 v3, 0x0

    cmp-long v1, v1, v3

    if-eqz v1, :cond_1

    .line 455
    new-array v1, v0, [B

    .line 456
    .local v1, "data":[B
    invoke-virtual {p1, v1}, Ljava/io/InputStream;->read([B)I

    .line 457
    new-instance v2, Ljava/io/BufferedInputStream;

    new-instance v3, Ljava/io/ByteArrayInputStream;

    invoke-direct {v3, v1}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-direct {v2, v3}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;)V

    iput-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->internalBuffer:Ljava/io/InputStream;

    .line 458
    .end local v1    # "data":[B
    goto :goto_0

    .line 459
    :cond_1
    invoke-direct {p0, p1}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->readSegment(Ljava/io/InputStream;)V

    .line 461
    :goto_0
    return-void
.end method

.method unpackWrite(Ljava/util/jar/JarOutputStream;)V
    .locals 1
    .param p1, "out"    # Ljava/util/jar/JarOutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 471
    invoke-virtual {p0, p1}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->writeJar(Ljava/util/jar/JarOutputStream;)V

    .line 472
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->logStream:Ljava/io/PrintWriter;

    if-eqz v0, :cond_0

    .line 473
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->logStream:Ljava/io/PrintWriter;

    invoke-virtual {v0}, Ljava/io/PrintWriter;->close()V

    .line 475
    :cond_0
    return-void
.end method

.method public writeJar(Ljava/util/jar/JarOutputStream;)V
    .locals 21
    .param p1, "out"    # Ljava/util/jar/JarOutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 488
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    iget-object v2, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->fileBands:Lorg/apache/commons/compress/harmony/unpack200/FileBands;

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/unpack200/FileBands;->getFileName()[Ljava/lang/String;

    move-result-object v2

    .line 489
    .local v2, "fileName":[Ljava/lang/String;
    iget-object v3, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->fileBands:Lorg/apache/commons/compress/harmony/unpack200/FileBands;

    invoke-virtual {v3}, Lorg/apache/commons/compress/harmony/unpack200/FileBands;->getFileModtime()[I

    move-result-object v3

    .line 490
    .local v3, "fileModtime":[I
    iget-object v4, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->fileBands:Lorg/apache/commons/compress/harmony/unpack200/FileBands;

    invoke-virtual {v4}, Lorg/apache/commons/compress/harmony/unpack200/FileBands;->getFileSize()[J

    move-result-object v4

    .line 491
    .local v4, "fileSize":[J
    iget-object v5, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->fileBands:Lorg/apache/commons/compress/harmony/unpack200/FileBands;

    invoke-virtual {v5}, Lorg/apache/commons/compress/harmony/unpack200/FileBands;->getFileBits()[[B

    move-result-object v5

    .line 494
    .local v5, "fileBits":[[B
    const/4 v6, 0x0

    .line 495
    .local v6, "classNum":I
    iget-object v7, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    invoke-virtual {v7}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->getNumberOfFiles()I

    move-result v7

    .line 496
    .local v7, "numberOfFiles":I
    iget-object v8, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    invoke-virtual {v8}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->getArchiveModtime()J

    move-result-wide v8

    .line 498
    .local v8, "archiveModtime":J
    const/4 v10, 0x0

    .local v10, "i":I
    :goto_0
    if-ge v10, v7, :cond_3

    .line 499
    aget-object v11, v2, v10

    .line 506
    .local v11, "name":Ljava/lang/String;
    aget v12, v3, v10

    int-to-long v12, v12

    add-long/2addr v12, v8

    const-wide/16 v14, 0x3e8

    mul-long/2addr v12, v14

    .line 507
    .local v12, "modtime":J
    iget-object v14, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->fileDeflate:[Z

    aget-boolean v14, v14, v10

    .line 509
    .local v14, "deflate":Z
    new-instance v15, Ljava/util/jar/JarEntry;

    invoke-direct {v15, v11}, Ljava/util/jar/JarEntry;-><init>(Ljava/lang/String;)V

    .line 510
    .local v15, "entry":Ljava/util/jar/JarEntry;
    if-eqz v14, :cond_0

    .line 511
    move-object/from16 v16, v2

    .end local v2    # "fileName":[Ljava/lang/String;
    .local v16, "fileName":[Ljava/lang/String;
    const/16 v2, 0x8

    invoke-virtual {v15, v2}, Ljava/util/jar/JarEntry;->setMethod(I)V

    move-object/from16 v17, v3

    move/from16 v18, v7

    move-wide/from16 v19, v8

    goto :goto_2

    .line 513
    .end local v16    # "fileName":[Ljava/lang/String;
    .restart local v2    # "fileName":[Ljava/lang/String;
    :cond_0
    move-object/from16 v16, v2

    .end local v2    # "fileName":[Ljava/lang/String;
    .restart local v16    # "fileName":[Ljava/lang/String;
    const/4 v2, 0x0

    invoke-virtual {v15, v2}, Ljava/util/jar/JarEntry;->setMethod(I)V

    .line 514
    new-instance v2, Ljava/util/zip/CRC32;

    invoke-direct {v2}, Ljava/util/zip/CRC32;-><init>()V

    .line 515
    .local v2, "crc":Ljava/util/zip/CRC32;
    move-object/from16 v17, v3

    .end local v3    # "fileModtime":[I
    .local v17, "fileModtime":[I
    iget-object v3, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->fileIsClass:[Z

    aget-boolean v3, v3, v10

    if-eqz v3, :cond_1

    .line 516
    iget-object v3, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classFilesContents:[[B

    aget-object v3, v3, v6

    invoke-virtual {v2, v3}, Ljava/util/zip/CRC32;->update([B)V

    .line 517
    iget-object v3, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classFilesContents:[[B

    aget-object v3, v3, v6

    array-length v3, v3

    move/from16 v18, v7

    move-wide/from16 v19, v8

    .end local v7    # "numberOfFiles":I
    .end local v8    # "archiveModtime":J
    .local v18, "numberOfFiles":I
    .local v19, "archiveModtime":J
    int-to-long v7, v3

    invoke-virtual {v15, v7, v8}, Ljava/util/jar/JarEntry;->setSize(J)V

    goto :goto_1

    .line 519
    .end local v18    # "numberOfFiles":I
    .end local v19    # "archiveModtime":J
    .restart local v7    # "numberOfFiles":I
    .restart local v8    # "archiveModtime":J
    :cond_1
    move/from16 v18, v7

    move-wide/from16 v19, v8

    .end local v7    # "numberOfFiles":I
    .end local v8    # "archiveModtime":J
    .restart local v18    # "numberOfFiles":I
    .restart local v19    # "archiveModtime":J
    aget-object v3, v5, v10

    invoke-virtual {v2, v3}, Ljava/util/zip/CRC32;->update([B)V

    .line 520
    aget-wide v7, v4, v10

    invoke-virtual {v15, v7, v8}, Ljava/util/jar/JarEntry;->setSize(J)V

    .line 522
    :goto_1
    invoke-virtual {v2}, Ljava/util/zip/CRC32;->getValue()J

    move-result-wide v7

    invoke-virtual {v15, v7, v8}, Ljava/util/jar/JarEntry;->setCrc(J)V

    .line 525
    .end local v2    # "crc":Ljava/util/zip/CRC32;
    :goto_2
    invoke-static {}, Ljava/util/TimeZone;->getDefault()Ljava/util/TimeZone;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/TimeZone;->getRawOffset()I

    move-result v2

    int-to-long v2, v2

    sub-long v2, v12, v2

    invoke-virtual {v15, v2, v3}, Ljava/util/jar/JarEntry;->setTime(J)V

    .line 526
    invoke-virtual {v1, v15}, Ljava/util/jar/JarOutputStream;->putNextEntry(Ljava/util/zip/ZipEntry;)V

    .line 529
    iget-object v2, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->fileIsClass:[Z

    aget-boolean v2, v2, v10

    if-eqz v2, :cond_2

    .line 530
    iget-object v2, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classFilesContents:[[B

    aget-object v2, v2, v6

    array-length v2, v2

    int-to-long v2, v2

    invoke-virtual {v15, v2, v3}, Ljava/util/jar/JarEntry;->setSize(J)V

    .line 531
    iget-object v2, v0, Lorg/apache/commons/compress/harmony/unpack200/Segment;->classFilesContents:[[B

    aget-object v2, v2, v6

    invoke-virtual {v1, v2}, Ljava/util/jar/JarOutputStream;->write([B)V

    .line 532
    add-int/lit8 v6, v6, 0x1

    goto :goto_3

    .line 534
    :cond_2
    aget-wide v2, v4, v10

    invoke-virtual {v15, v2, v3}, Ljava/util/jar/JarEntry;->setSize(J)V

    .line 535
    aget-object v2, v5, v10

    invoke-virtual {v1, v2}, Ljava/util/jar/JarOutputStream;->write([B)V

    .line 498
    .end local v11    # "name":Ljava/lang/String;
    .end local v12    # "modtime":J
    .end local v14    # "deflate":Z
    .end local v15    # "entry":Ljava/util/jar/JarEntry;
    :goto_3
    add-int/lit8 v10, v10, 0x1

    move-object/from16 v2, v16

    move-object/from16 v3, v17

    move/from16 v7, v18

    move-wide/from16 v8, v19

    goto/16 :goto_0

    .line 538
    .end local v10    # "i":I
    .end local v16    # "fileName":[Ljava/lang/String;
    .end local v17    # "fileModtime":[I
    .end local v18    # "numberOfFiles":I
    .end local v19    # "archiveModtime":J
    .local v2, "fileName":[Ljava/lang/String;
    .restart local v3    # "fileModtime":[I
    .restart local v7    # "numberOfFiles":I
    .restart local v8    # "archiveModtime":J
    :cond_3
    return-void
.end method
