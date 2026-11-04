.class public Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;
.super Lorg/apache/commons/compress/harmony/unpack200/BandSet;
.source "AttrDefinitionBands.java"


# instance fields
.field private attributeDefinitionHeader:[I

.field private attributeDefinitionLayout:[Ljava/lang/String;

.field private attributeDefinitionMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

.field private attributeDefinitionName:[Ljava/lang/String;

.field private final cpUTF8:[Ljava/lang/String;


# direct methods
.method public constructor <init>(Lorg/apache/commons/compress/harmony/unpack200/Segment;)V
    .locals 1
    .param p1, "segment"    # Lorg/apache/commons/compress/harmony/unpack200/Segment;

    .line 53
    invoke-direct {p0, p1}, Lorg/apache/commons/compress/harmony/unpack200/BandSet;-><init>(Lorg/apache/commons/compress/harmony/unpack200/Segment;)V

    .line 54
    invoke-virtual {p1}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->getCpUTF8()[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->cpUTF8:[Ljava/lang/String;

    .line 55
    return-void
.end method

.method private setupDefaultAttributeNames()V
    .locals 2

    .line 98
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    const-string v1, "AnnotationDefault"

    invoke-virtual {v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v0

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/AnnotationDefaultAttribute;->setAttributeName(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;)V

    .line 99
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    const-string v1, "Code"

    invoke-virtual {v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v0

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/CodeAttribute;->setAttributeName(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;)V

    .line 100
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    const-string v1, "ConstantValue"

    invoke-virtual {v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v0

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ConstantValueAttribute;->setAttributeName(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;)V

    .line 101
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    const-string v1, "Deprecated"

    invoke-virtual {v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v0

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/DeprecatedAttribute;->setAttributeName(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;)V

    .line 102
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    const-string v1, "EnclosingMethod"

    invoke-virtual {v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v0

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/EnclosingMethodAttribute;->setAttributeName(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;)V

    .line 103
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    const-string v1, "Exceptions"

    invoke-virtual {v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v0

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ExceptionsAttribute;->setAttributeName(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;)V

    .line 104
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    const-string v1, "InnerClasses"

    invoke-virtual {v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v0

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/InnerClassesAttribute;->setAttributeName(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;)V

    .line 105
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    const-string v1, "LineNumberTable"

    invoke-virtual {v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v0

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/LineNumberTableAttribute;->setAttributeName(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;)V

    .line 106
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    const-string v1, "LocalVariableTable"

    invoke-virtual {v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v0

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/LocalVariableTableAttribute;->setAttributeName(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;)V

    .line 107
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    const-string v1, "LocalVariableTypeTable"

    invoke-virtual {v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v0

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/LocalVariableTypeTableAttribute;->setAttributeName(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;)V

    .line 108
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    const-string v1, "Signature"

    invoke-virtual {v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v0

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/SignatureAttribute;->setAttributeName(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;)V

    .line 109
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    const-string v1, "SourceFile"

    invoke-virtual {v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v0

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/SourceFileAttribute;->setAttributeName(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;)V

    .line 110
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    const-string v1, "RuntimeVisibleAnnotations"

    invoke-virtual {v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v0

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->setRvaAttributeName(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;)V

    .line 111
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    const-string v1, "RuntimeInvisibleAnnotations"

    invoke-virtual {v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v0

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->setRiaAttributeName(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;)V

    .line 112
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    const-string v1, "RuntimeVisibleParameterAnnotations"

    invoke-virtual {v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v0

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->setRvpaAttributeName(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;)V

    .line 113
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    .line 114
    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getCpBands()Lorg/apache/commons/compress/harmony/unpack200/CpBands;

    move-result-object v0

    const-string v1, "RuntimeInvisibleParameterAnnotations"

    invoke-virtual {v0, v1}, Lorg/apache/commons/compress/harmony/unpack200/CpBands;->cpUTF8Value(Ljava/lang/String;)Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;

    move-result-object v0

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/unpack200/MetadataBandGroup;->setRipaAttributeName(Lorg/apache/commons/compress/harmony/unpack200/bytecode/CPUTF8;)V

    .line 115
    return-void
.end method


# virtual methods
.method public getAttributeDefinitionMap()Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;
    .locals 1

    .line 118
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->attributeDefinitionMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    return-object v0
.end method

.method public read(Ljava/io/InputStream;)V
    .locals 12
    .param p1, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 64
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->header:Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    invoke-virtual {v0}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->getAttributeDefinitionCount()I

    move-result v0

    .line 65
    .local v0, "attributeDefinitionCount":I
    const-string v1, "attr_definition_headers"

    sget-object v2, Lorg/apache/commons/compress/harmony/pack200/Codec;->BYTE1:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-virtual {p0, v1, p1, v2, v0}, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->decodeBandInt(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I)[I

    move-result-object v1

    iput-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->attributeDefinitionHeader:[I

    .line 66
    sget-object v4, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    iget-object v6, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->cpUTF8:[Ljava/lang/String;

    const-string v2, "attr_definition_name"

    move-object v1, p0

    move-object v3, p1

    move v5, v0

    invoke-virtual/range {v1 .. v6}, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->parseReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I[Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->attributeDefinitionName:[Ljava/lang/String;

    .line 68
    sget-object v4, Lorg/apache/commons/compress/harmony/pack200/Codec;->UNSIGNED5:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    iget-object v6, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->cpUTF8:[Ljava/lang/String;

    const-string v2, "attr_definition_layout"

    move-object v1, p0

    invoke-virtual/range {v1 .. v6}, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->parseReferences(Ljava/lang/String;Ljava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;I[Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->attributeDefinitionLayout:[Ljava/lang/String;

    .line 71
    new-instance v1, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    invoke-direct {v1}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;-><init>()V

    iput-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->attributeDefinitionMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    .line 73
    const/16 v1, 0x20

    .line 74
    .local v1, "overflowIndex":I
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/unpack200/Segment;->getSegmentHeader()Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;

    move-result-object v2

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/unpack200/SegmentHeader;->getOptions()Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;

    move-result-object v2

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/unpack200/SegmentOptions;->hasClassFlagsHi()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 75
    const/16 v1, 0x3f

    .line 77
    :cond_0
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, v0, :cond_2

    .line 78
    iget-object v3, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->attributeDefinitionHeader:[I

    aget v3, v3, v2

    and-int/lit8 v3, v3, 0x3

    .line 79
    .local v3, "context":I
    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->attributeDefinitionHeader:[I

    aget v4, v4, v2

    shr-int/lit8 v4, v4, 0x2

    add-int/lit8 v4, v4, -0x1

    .line 80
    .local v4, "index":I
    const/4 v5, -0x1

    if-ne v4, v5, :cond_1

    .line 81
    add-int/lit8 v5, v1, 0x1

    .end local v1    # "overflowIndex":I
    .local v5, "overflowIndex":I
    move v4, v1

    move v10, v4

    move v1, v5

    goto :goto_1

    .line 80
    .end local v5    # "overflowIndex":I
    .restart local v1    # "overflowIndex":I
    :cond_1
    move v10, v4

    .line 83
    .end local v4    # "index":I
    .local v10, "index":I
    :goto_1
    new-instance v11, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;

    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->attributeDefinitionName:[Ljava/lang/String;

    aget-object v5, v4, v2

    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->attributeDefinitionLayout:[Ljava/lang/String;

    aget-object v7, v4, v2

    const/4 v9, 0x0

    move-object v4, v11

    move v6, v3

    move v8, v10

    invoke-direct/range {v4 .. v9}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;-><init>(Ljava/lang/String;ILjava/lang/String;IZ)V

    .line 85
    .local v4, "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    new-instance v5, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;

    iget-object v6, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->segment:Lorg/apache/commons/compress/harmony/unpack200/Segment;

    invoke-direct {v5, v6, v4}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;-><init>(Lorg/apache/commons/compress/harmony/unpack200/Segment;Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;)V

    .line 86
    .local v5, "newBands":Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;
    iget-object v6, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->attributeDefinitionMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    invoke-virtual {v6, v4, v5}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->add(Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;)V

    .line 77
    .end local v3    # "context":I
    .end local v4    # "layout":Lorg/apache/commons/compress/harmony/unpack200/AttributeLayout;
    .end local v5    # "newBands":Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;
    .end local v10    # "index":I
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 88
    .end local v2    # "i":I
    :cond_2
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->attributeDefinitionMap:Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/unpack200/AttributeLayoutMap;->checkMap()V

    .line 89
    invoke-direct {p0}, Lorg/apache/commons/compress/harmony/unpack200/AttrDefinitionBands;->setupDefaultAttributeNames()V

    .line 90
    return-void
.end method

.method public unpack()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;,
            Ljava/io/IOException;
        }
    .end annotation

    .line 95
    return-void
.end method
