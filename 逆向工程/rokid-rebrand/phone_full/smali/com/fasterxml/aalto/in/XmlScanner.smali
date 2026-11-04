.class public abstract Lcom/fasterxml/aalto/in/XmlScanner;
.super Ljava/lang/Object;
.source "XmlScanner.java"

# interfaces
.implements Lcom/fasterxml/aalto/util/XmlConsts;
.implements Ljavax/xml/stream/XMLStreamConstants;
.implements Ljavax/xml/namespace/NamespaceContext;


# static fields
.field private static final BIND_CACHE_MASK:I = 0x3f

.field private static final BIND_CACHE_SIZE:I = 0x40

.field private static final BIND_MISSES_TO_ACTIVATE_CACHE:I = 0xa

.field protected static final INT_0:I = 0x30

.field protected static final INT_9:I = 0x39

.field protected static final INT_A:I = 0x41

.field protected static final INT_AMP:I = 0x26

.field protected static final INT_APOS:I = 0x27

.field protected static final INT_COLON:I = 0x3a

.field protected static final INT_CR:I = 0xd

.field protected static final INT_EQ:I = 0x3d

.field protected static final INT_EXCL:I = 0x21

.field protected static final INT_F:I = 0x46

.field protected static final INT_GT:I = 0x3e

.field protected static final INT_HYPHEN:I = 0x2d

.field protected static final INT_LBRACKET:I = 0x5b

.field protected static final INT_LF:I = 0xa

.field protected static final INT_LT:I = 0x3c

.field protected static final INT_NULL:I = 0x0

.field protected static final INT_QMARK:I = 0x3f

.field protected static final INT_QUOTE:I = 0x22

.field protected static final INT_RBRACKET:I = 0x5d

.field protected static final INT_SLASH:I = 0x2f

.field protected static final INT_SPACE:I = 0x20

.field protected static final INT_TAB:I = 0x9

.field protected static final INT_a:I = 0x61

.field protected static final INT_f:I = 0x66

.field protected static final INT_z:I = 0x7a

.field protected static final MAX_UNICODE_CHAR:I = 0x10ffff

.field public static final TOKEN_EOI:I = -0x1


# instance fields
.field protected final CDATA_STR:Ljava/lang/String;

.field protected final _attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

.field protected _attrCount:I

.field protected final _cfgCoalescing:Z

.field protected _cfgLazyParsing:Z

.field protected final _config:Lcom/fasterxml/aalto/in/ReaderConfig;

.field protected _currElem:Lcom/fasterxml/aalto/in/ElementScope;

.field protected _currNsCount:I

.field protected _currRow:I

.field protected _currToken:I

.field protected _defaultNs:Lcom/fasterxml/aalto/in/NsBinding;

.field protected _depth:I

.field protected _entityPending:Z

.field protected _isEmptyTag:Z

.field protected _lastNsContext:Lcom/fasterxml/aalto/in/FixedNsContext;

.field protected _lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

.field protected _nameBuffer:[C

.field protected _nsBindMisses:I

.field protected _nsBindingCache:[Lcom/fasterxml/aalto/in/PName;

.field protected _nsBindingCount:I

.field protected _nsBindings:[Lcom/fasterxml/aalto/in/NsBinding;

.field protected _pastBytesOrChars:J

.field protected _publicId:Ljava/lang/String;

.field protected _rowStartOffset:I

.field protected _startColumn:J

.field protected _startRawOffset:J

.field protected _startRow:J

.field protected _systemId:Ljava/lang/String;

.field protected final _textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

.field protected _tokenIncomplete:Z

.field protected _tokenName:Lcom/fasterxml/aalto/in/PName;

.field protected final _xml11:Z


# direct methods
.method protected constructor <init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V
    .locals 3
    .param p1, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;

    .line 323
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 46
    const-string v0, "CDATA["

    iput-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->CDATA_STR:Ljava/lang/String;

    .line 136
    const/4 v0, 0x7

    iput v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_currToken:I

    .line 138
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_tokenIncomplete:Z

    .line 144
    iput v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_depth:I

    .line 154
    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_entityPending:Z

    .line 168
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nameBuffer:[C

    .line 175
    iput-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    .line 188
    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_isEmptyTag:Z

    .line 216
    iput-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    .line 223
    iput v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_currNsCount:I

    .line 229
    invoke-static {}, Lcom/fasterxml/aalto/in/NsBinding;->createDefaultNs()Lcom/fasterxml/aalto/in/NsBinding;

    move-result-object v2

    iput-object v2, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_defaultNs:Lcom/fasterxml/aalto/in/NsBinding;

    .line 239
    iput v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindingCount:I

    .line 248
    iput-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindingCache:[Lcom/fasterxml/aalto/in/PName;

    .line 250
    iput v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindMisses:I

    .line 263
    sget-object v1, Lcom/fasterxml/aalto/in/FixedNsContext;->EMPTY_CONTEXT:Lcom/fasterxml/aalto/in/FixedNsContext;

    iput-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_lastNsContext:Lcom/fasterxml/aalto/in/FixedNsContext;

    .line 273
    iput v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_attrCount:I

    .line 309
    const-wide/16 v1, -0x1

    iput-wide v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_startRow:J

    .line 314
    iput-wide v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_startColumn:J

    .line 324
    iput-object p1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    .line 326
    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/ReaderConfig;->willCoalesceText()Z

    move-result v1

    iput-boolean v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_cfgCoalescing:Z

    .line 327
    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/ReaderConfig;->willParseLazily()Z

    move-result v1

    iput-boolean v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_cfgLazyParsing:Z

    .line 328
    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/ReaderConfig;->isXml11()Z

    move-result v1

    iput-boolean v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_xml11:Z

    .line 329
    iget-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-static {v1}, Lcom/fasterxml/aalto/util/TextBuilder;->createRecyclableBuffer(Lcom/fasterxml/aalto/in/ReaderConfig;)Lcom/fasterxml/aalto/util/TextBuilder;

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    .line 330
    new-instance v1, Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-direct {v1, p1}, Lcom/fasterxml/aalto/in/AttributeCollector;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V

    iput-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    .line 331
    const/16 v1, 0x3c

    invoke-virtual {p1, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->allocSmallCBuffer(I)[C

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nameBuffer:[C

    .line 332
    iput v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_currRow:I

    .line 333
    return-void
.end method

.method private findCurrNsDecl(I)Lcom/fasterxml/aalto/in/NsDeclaration;
    .locals 4
    .param p1, "index"    # I

    .line 878
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    .line 883
    .local v0, "nsDecl":Lcom/fasterxml/aalto/in/NsDeclaration;
    iget v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_depth:I

    .line 886
    .local v1, "level":I
    iget v2, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_currToken:I

    const/4 v3, 0x1

    if-ne v2, v3, :cond_0

    .line 887
    iget v2, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_currNsCount:I

    sub-int/2addr v2, v3

    sub-int/2addr v2, p1

    .line 888
    .local v2, "count":I
    add-int/lit8 v1, v1, -0x1

    goto :goto_0

    .line 890
    .end local v2    # "count":I
    :cond_0
    move v2, p1

    .line 893
    .restart local v2    # "count":I
    :goto_0
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->getLevel()I

    move-result v3

    if-ne v3, v1, :cond_2

    .line 894
    if-nez v2, :cond_1

    .line 895
    return-object v0

    .line 897
    :cond_1
    add-int/lit8 v2, v2, -0x1

    .line 898
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->getPrev()Lcom/fasterxml/aalto/in/NsDeclaration;

    move-result-object v0

    goto :goto_0

    .line 900
    :cond_2
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInvalidNsIndex(I)V

    .line 901
    const/4 v3, 0x0

    return-object v3
.end method


# virtual methods
.method protected abstract _closeSource()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method

.method protected _releaseBuffers()V
    .locals 2

    .line 360
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->recycle(Z)V

    .line 361
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nameBuffer:[C

    if-eqz v0, :cond_0

    .line 362
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nameBuffer:[C

    .line 363
    .local v0, "buf":[C
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nameBuffer:[C

    .line 364
    iget-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v1, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->freeSmallCBuffer([C)V

    .line 366
    .end local v0    # "buf":[C
    :cond_0
    return-void
.end method

.method protected final bindName(Lcom/fasterxml/aalto/in/PName;Ljava/lang/String;)Lcom/fasterxml/aalto/in/PName;
    .locals 6
    .param p1, "name"    # Lcom/fasterxml/aalto/in/PName;
    .param p2, "prefix"    # Ljava/lang/String;

    .line 1125
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindingCache:[Lcom/fasterxml/aalto/in/PName;

    if-eqz v0, :cond_0

    .line 1126
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindingCache:[Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/PName;->unboundHashCode()I

    move-result v1

    and-int/lit8 v1, v1, 0x3f

    aget-object v0, v0, v1

    .line 1127
    .local v0, "cn":Lcom/fasterxml/aalto/in/PName;
    if-eqz v0, :cond_0

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/PName;->unboundEquals(Lcom/fasterxml/aalto/in/PName;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 1128
    return-object v0

    .line 1133
    .end local v0    # "cn":Lcom/fasterxml/aalto/in/PName;
    :cond_0
    const/4 v0, 0x0

    .local v0, "i":I
    iget v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindingCount:I

    .local v1, "len":I
    :goto_0
    if-ge v0, v1, :cond_5

    .line 1134
    iget-object v2, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindings:[Lcom/fasterxml/aalto/in/NsBinding;

    aget-object v2, v2, v0

    .line 1135
    .local v2, "b":Lcom/fasterxml/aalto/in/NsBinding;
    iget-object v3, v2, Lcom/fasterxml/aalto/in/NsBinding;->mPrefix:Ljava/lang/String;

    if-eq v3, p2, :cond_1

    .line 1136
    nop

    .line 1133
    .end local v2    # "b":Lcom/fasterxml/aalto/in/NsBinding;
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1140
    .restart local v2    # "b":Lcom/fasterxml/aalto/in/NsBinding;
    :cond_1
    if-lez v0, :cond_2

    .line 1141
    iget-object v3, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindings:[Lcom/fasterxml/aalto/in/NsBinding;

    iget-object v4, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindings:[Lcom/fasterxml/aalto/in/NsBinding;

    add-int/lit8 v5, v0, -0x1

    aget-object v4, v4, v5

    aput-object v4, v3, v0

    .line 1142
    iget-object v3, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindings:[Lcom/fasterxml/aalto/in/NsBinding;

    add-int/lit8 v4, v0, -0x1

    aput-object v2, v3, v4

    .line 1145
    :cond_2
    invoke-virtual {p1, v2}, Lcom/fasterxml/aalto/in/PName;->createBoundName(Lcom/fasterxml/aalto/in/NsBinding;)Lcom/fasterxml/aalto/in/PName;

    move-result-object v3

    .line 1146
    .local v3, "bn":Lcom/fasterxml/aalto/in/PName;
    iget-object v4, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindingCache:[Lcom/fasterxml/aalto/in/PName;

    if-nez v4, :cond_4

    .line 1147
    iget v4, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindMisses:I

    add-int/lit8 v4, v4, 0x1

    iput v4, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindMisses:I

    const/16 v5, 0xa

    if-ge v4, v5, :cond_3

    .line 1148
    return-object v3

    .line 1150
    :cond_3
    const/16 v4, 0x40

    new-array v4, v4, [Lcom/fasterxml/aalto/in/PName;

    iput-object v4, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindingCache:[Lcom/fasterxml/aalto/in/PName;

    .line 1152
    :cond_4
    iget-object v4, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindingCache:[Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/PName;->unboundHashCode()I

    move-result v5

    and-int/lit8 v5, v5, 0x3f

    aput-object v3, v4, v5

    .line 1153
    return-object v3

    .line 1159
    .end local v0    # "i":I
    .end local v1    # "len":I
    .end local v2    # "b":Lcom/fasterxml/aalto/in/NsBinding;
    .end local v3    # "bn":Lcom/fasterxml/aalto/in/PName;
    :cond_5
    const-string/jumbo v0, "xml"

    if-ne p2, v0, :cond_6

    .line 1160
    sget-object v0, Lcom/fasterxml/aalto/in/NsBinding;->XML_BINDING:Lcom/fasterxml/aalto/in/NsBinding;

    invoke-virtual {p1, v0}, Lcom/fasterxml/aalto/in/PName;->createBoundName(Lcom/fasterxml/aalto/in/NsBinding;)Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    return-object v0

    .line 1165
    :cond_6
    iget v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindMisses:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindMisses:I

    .line 1166
    new-instance v0, Lcom/fasterxml/aalto/in/NsBinding;

    invoke-direct {v0, p2}, Lcom/fasterxml/aalto/in/NsBinding;-><init>(Ljava/lang/String;)V

    .line 1167
    .local v0, "b":Lcom/fasterxml/aalto/in/NsBinding;
    iget v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindingCount:I

    if-nez v1, :cond_7

    .line 1168
    const/16 v1, 0x10

    new-array v1, v1, [Lcom/fasterxml/aalto/in/NsBinding;

    iput-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindings:[Lcom/fasterxml/aalto/in/NsBinding;

    goto :goto_1

    .line 1169
    :cond_7
    iget v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindingCount:I

    iget-object v2, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindings:[Lcom/fasterxml/aalto/in/NsBinding;

    array-length v2, v2

    if-lt v1, v2, :cond_8

    .line 1170
    iget-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindings:[Lcom/fasterxml/aalto/in/NsBinding;

    iget-object v2, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindings:[Lcom/fasterxml/aalto/in/NsBinding;

    array-length v2, v2

    invoke-static {v1, v2}, Lcom/fasterxml/aalto/util/DataUtil;->growAnyArrayBy(Ljava/lang/Object;I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Lcom/fasterxml/aalto/in/NsBinding;

    check-cast v1, [Lcom/fasterxml/aalto/in/NsBinding;

    iput-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindings:[Lcom/fasterxml/aalto/in/NsBinding;

    .line 1172
    :cond_8
    :goto_1
    iget-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindings:[Lcom/fasterxml/aalto/in/NsBinding;

    iget v2, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindingCount:I

    aput-object v0, v1, v2

    .line 1173
    iget v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindingCount:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindingCount:I

    .line 1174
    invoke-virtual {p1, v0}, Lcom/fasterxml/aalto/in/PName;->createBoundName(Lcom/fasterxml/aalto/in/NsBinding;)Lcom/fasterxml/aalto/in/PName;

    move-result-object v1

    return-object v1
.end method

.method protected final bindNs(Lcom/fasterxml/aalto/in/PName;Ljava/lang/String;)V
    .locals 5
    .param p1, "name"    # Lcom/fasterxml/aalto/in/PName;
    .param p2, "uri"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1227
    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/PName;->getPrefix()Ljava/lang/String;

    move-result-object v0

    .line 1229
    .local v0, "prefix":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 1230
    iget-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_defaultNs:Lcom/fasterxml/aalto/in/NsBinding;

    .local v1, "ns":Lcom/fasterxml/aalto/in/NsBinding;
    goto :goto_0

    .line 1232
    .end local v1    # "ns":Lcom/fasterxml/aalto/in/NsBinding;
    :cond_0
    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/PName;->getLocalName()Ljava/lang/String;

    move-result-object v0

    .line 1233
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->findOrCreateBinding(Ljava/lang/String;)Lcom/fasterxml/aalto/in/NsBinding;

    move-result-object v1

    .line 1234
    .restart local v1    # "ns":Lcom/fasterxml/aalto/in/NsBinding;
    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/NsBinding;->isImmutable()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 1235
    invoke-virtual {p0, v0, p2}, Lcom/fasterxml/aalto/in/XmlScanner;->checkImmutableBinding(Ljava/lang/String;Ljava/lang/String;)V

    .line 1244
    :cond_1
    :goto_0
    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/NsBinding;->isImmutable()Z

    move-result v2

    if-nez v2, :cond_3

    .line 1245
    const-string v2, "http://www.w3.org/XML/1998/namespace"

    if-ne p2, v2, :cond_2

    .line 1246
    const-string/jumbo v3, "xml"

    invoke-virtual {p0, v3, v2}, Lcom/fasterxml/aalto/in/XmlScanner;->reportIllegalNsDecl(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 1247
    :cond_2
    const-string v2, "http://www.w3.org/2000/xmlns/"

    if-ne p2, v2, :cond_3

    .line 1248
    const-string/jumbo v3, "xmlns"

    invoke-virtual {p0, v3, v2}, Lcom/fasterxml/aalto/in/XmlScanner;->reportIllegalNsDecl(Ljava/lang/String;Ljava/lang/String;)V

    .line 1252
    :cond_3
    :goto_1
    iget-object v2, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    if-eqz v2, :cond_4

    iget-object v2, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    iget v3, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_depth:I

    invoke-virtual {v2, v0, v3}, Lcom/fasterxml/aalto/in/NsDeclaration;->alreadyDeclared(Ljava/lang/String;I)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 1253
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportDuplicateNsDecl(Ljava/lang/String;)V

    .line 1255
    :cond_4
    new-instance v2, Lcom/fasterxml/aalto/in/NsDeclaration;

    iget-object v3, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    iget v4, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_depth:I

    invoke-direct {v2, v1, p2, v3, v4}, Lcom/fasterxml/aalto/in/NsDeclaration;-><init>(Lcom/fasterxml/aalto/in/NsBinding;Ljava/lang/String;Lcom/fasterxml/aalto/in/NsDeclaration;I)V

    iput-object v2, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    .line 1256
    return-void
.end method

.method protected final checkImmutableBinding(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "uri"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1265
    const-string/jumbo v0, "xml"

    if-ne p1, v0, :cond_0

    const-string v0, "http://www.w3.org/XML/1998/namespace"

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 1266
    :cond_0
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;->reportIllegalNsDecl(Ljava/lang/String;)V

    .line 1268
    :cond_1
    return-void
.end method

.method public final close(Z)V
    .locals 2
    .param p1, "forceCloseSource"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 348
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->_releaseBuffers()V

    .line 349
    if-nez p1, :cond_0

    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->willAutoCloseInput()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 351
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->_closeSource()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 354
    nop

    .line 356
    :cond_1
    return-void

    .line 352
    :catch_0
    move-exception v0

    .line 353
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public final decodeAttrBinaryValue(ILorg/codehaus/stax2/typed/Base64Variant;Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;)[B
    .locals 1
    .param p1, "index"    # I
    .param p2, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .param p3, "dec"    # Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 824
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v0, p1, p2, p3, p0}, Lcom/fasterxml/aalto/in/AttributeCollector;->decodeBinaryValue(ILorg/codehaus/stax2/typed/Base64Variant;Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;Lcom/fasterxml/aalto/in/XmlScanner;)[B

    move-result-object v0

    return-object v0
.end method

.method public final decodeAttrValue(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V
    .locals 1
    .param p1, "index"    # I
    .param p2, "tvd"    # Lorg/codehaus/stax2/typed/TypedValueDecoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 806
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/in/AttributeCollector;->decodeValue(ILorg/codehaus/stax2/typed/TypedValueDecoder;)V

    .line 807
    return-void
.end method

.method public final decodeAttrValues(ILorg/codehaus/stax2/typed/TypedArrayDecoder;)I
    .locals 1
    .param p1, "index"    # I
    .param p2, "tad"    # Lorg/codehaus/stax2/typed/TypedArrayDecoder;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 818
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v0, p1, p2, p0}, Lcom/fasterxml/aalto/in/AttributeCollector;->decodeValues(ILorg/codehaus/stax2/typed/TypedArrayDecoder;Lcom/fasterxml/aalto/in/XmlScanner;)I

    move-result v0

    return v0
.end method

.method public final decodeElements(Lorg/codehaus/stax2/typed/TypedArrayDecoder;Z)I
    .locals 6
    .param p1, "tad"    # Lorg/codehaus/stax2/typed/TypedArrayDecoder;
    .param p2, "reset"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 613
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_tokenIncomplete:Z

    if-eqz v0, :cond_0

    .line 614
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->finishToken()V

    .line 618
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/util/TextBuilder;->decodeElements(Lorg/codehaus/stax2/typed/TypedArrayDecoder;Z)I

    move-result v0
    :try_end_0
    .catch Lorg/codehaus/stax2/typed/TypedXMLStreamException; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    .line 619
    :catch_0
    move-exception v0

    .line 621
    .local v0, "tex":Lorg/codehaus/stax2/typed/TypedXMLStreamException;
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->getCurrentLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v1

    .line 622
    .local v1, "loc":Ljavax/xml/stream/Location;
    invoke-virtual {v0}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;->getLexical()Ljava/lang/String;

    move-result-object v2

    .line 623
    .local v2, "lexical":Ljava/lang/String;
    invoke-virtual {v0}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;->getCause()Ljava/lang/Throwable;

    move-result-object v3

    check-cast v3, Ljava/lang/IllegalArgumentException;

    .line 624
    .local v3, "iae":Ljava/lang/IllegalArgumentException;
    new-instance v4, Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    invoke-virtual {v0}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;->getMessage()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v2, v5, v1, v3}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/stream/Location;Ljava/lang/IllegalArgumentException;)V

    throw v4
.end method

.method public final findAttrIndex(Ljava/lang/String;Ljava/lang/String;)I
    .locals 2
    .param p1, "nsURI"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 832
    iget v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_attrCount:I

    const/4 v1, 0x1

    if-ge v0, v1, :cond_0

    .line 833
    const/4 v0, -0x1

    return v0

    .line 835
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/in/AttributeCollector;->findIndex(Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method protected final findOrCreateBinding(Ljava/lang/String;)Lcom/fasterxml/aalto/in/NsBinding;
    .locals 6
    .param p1, "prefix"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1191
    const/4 v0, 0x0

    .local v0, "i":I
    iget v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindingCount:I

    .local v1, "len":I
    :goto_0
    if-ge v0, v1, :cond_2

    .line 1192
    iget-object v2, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindings:[Lcom/fasterxml/aalto/in/NsBinding;

    aget-object v2, v2, v0

    .line 1193
    .local v2, "b":Lcom/fasterxml/aalto/in/NsBinding;
    iget-object v3, v2, Lcom/fasterxml/aalto/in/NsBinding;->mPrefix:Ljava/lang/String;

    if-ne v3, p1, :cond_1

    .line 1194
    if-lez v0, :cond_0

    .line 1195
    iget-object v3, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindings:[Lcom/fasterxml/aalto/in/NsBinding;

    iget-object v4, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindings:[Lcom/fasterxml/aalto/in/NsBinding;

    add-int/lit8 v5, v0, -0x1

    aget-object v4, v4, v5

    aput-object v4, v3, v0

    .line 1196
    iget-object v3, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindings:[Lcom/fasterxml/aalto/in/NsBinding;

    add-int/lit8 v4, v0, -0x1

    aput-object v2, v3, v4

    .line 1198
    :cond_0
    return-object v2

    .line 1191
    .end local v2    # "b":Lcom/fasterxml/aalto/in/NsBinding;
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 1202
    .end local v0    # "i":I
    .end local v1    # "len":I
    :cond_2
    const-string/jumbo v0, "xml"

    if-ne p1, v0, :cond_3

    .line 1203
    sget-object v0, Lcom/fasterxml/aalto/in/NsBinding;->XML_BINDING:Lcom/fasterxml/aalto/in/NsBinding;

    return-object v0

    .line 1205
    :cond_3
    const-string/jumbo v0, "xmlns"

    if-ne p1, v0, :cond_4

    .line 1206
    sget-object v0, Lcom/fasterxml/aalto/in/NsBinding;->XMLNS_BINDING:Lcom/fasterxml/aalto/in/NsBinding;

    return-object v0

    .line 1209
    :cond_4
    new-instance v0, Lcom/fasterxml/aalto/in/NsBinding;

    invoke-direct {v0, p1}, Lcom/fasterxml/aalto/in/NsBinding;-><init>(Ljava/lang/String;)V

    .line 1210
    .local v0, "b":Lcom/fasterxml/aalto/in/NsBinding;
    iget v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindingCount:I

    if-nez v1, :cond_5

    .line 1211
    const/16 v1, 0x10

    new-array v1, v1, [Lcom/fasterxml/aalto/in/NsBinding;

    iput-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindings:[Lcom/fasterxml/aalto/in/NsBinding;

    goto :goto_1

    .line 1212
    :cond_5
    iget v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindingCount:I

    iget-object v2, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindings:[Lcom/fasterxml/aalto/in/NsBinding;

    array-length v2, v2

    if-lt v1, v2, :cond_6

    .line 1213
    iget-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindings:[Lcom/fasterxml/aalto/in/NsBinding;

    iget-object v2, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindings:[Lcom/fasterxml/aalto/in/NsBinding;

    array-length v2, v2

    invoke-static {v1, v2}, Lcom/fasterxml/aalto/util/DataUtil;->growAnyArrayBy(Ljava/lang/Object;I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Lcom/fasterxml/aalto/in/NsBinding;

    check-cast v1, [Lcom/fasterxml/aalto/in/NsBinding;

    iput-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindings:[Lcom/fasterxml/aalto/in/NsBinding;

    .line 1215
    :cond_6
    :goto_1
    iget-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindings:[Lcom/fasterxml/aalto/in/NsBinding;

    iget v2, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindingCount:I

    aput-object v0, v1, v2

    .line 1216
    iget v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindingCount:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_nsBindingCount:I

    .line 1217
    return-object v0
.end method

.method protected abstract finishCData()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract finishCharacters()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract finishComment()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract finishDTD(Z)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract finishPI()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract finishSpace()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract finishToken()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public fireSaxCharacterEvents(Lorg/xml/sax/ContentHandler;)V
    .locals 1
    .param p1, "h"    # Lorg/xml/sax/ContentHandler;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;,
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 705
    if-eqz p1, :cond_1

    .line 706
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_tokenIncomplete:Z

    if-eqz v0, :cond_0

    .line 707
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->finishToken()V

    .line 709
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/util/TextBuilder;->fireSaxCharacterEvents(Lorg/xml/sax/ContentHandler;)V

    .line 711
    :cond_1
    return-void
.end method

.method public fireSaxCommentEvent(Lorg/xml/sax/ext/LexicalHandler;)V
    .locals 1
    .param p1, "h"    # Lorg/xml/sax/ext/LexicalHandler;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;,
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 727
    if-eqz p1, :cond_1

    .line 728
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_tokenIncomplete:Z

    if-eqz v0, :cond_0

    .line 729
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->finishToken()V

    .line 731
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/util/TextBuilder;->fireSaxCommentEvent(Lorg/xml/sax/ext/LexicalHandler;)V

    .line 733
    :cond_1
    return-void
.end method

.method public fireSaxEndElement(Lorg/xml/sax/ContentHandler;)V
    .locals 7
    .param p1, "h"    # Lorg/xml/sax/ContentHandler;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 678
    if-eqz p1, :cond_2

    .line 683
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->getName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    .line 684
    .local v0, "n":Lcom/fasterxml/aalto/in/PName;
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getNsUri()Ljava/lang/String;

    move-result-object v1

    .line 686
    .local v1, "uri":Ljava/lang/String;
    const-string v2, ""

    if-nez v1, :cond_0

    move-object v3, v2

    goto :goto_0

    :cond_0
    move-object v3, v1

    :goto_0
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getLocalName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v5

    invoke-interface {p1, v3, v4, v5}, Lorg/xml/sax/ContentHandler;->endElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 688
    iget-object v3, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    .line 693
    .local v3, "nsDecl":Lcom/fasterxml/aalto/in/NsDeclaration;
    iget v4, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_depth:I

    .line 694
    .local v4, "level":I
    :goto_1
    if-eqz v3, :cond_2

    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/NsDeclaration;->getLevel()I

    move-result v5

    if-ne v5, v4, :cond_2

    .line 695
    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/NsDeclaration;->getPrefix()Ljava/lang/String;

    move-result-object v5

    .line 696
    .local v5, "prefix":Ljava/lang/String;
    if-nez v5, :cond_1

    move-object v6, v2

    goto :goto_2

    :cond_1
    move-object v6, v5

    :goto_2
    invoke-interface {p1, v6}, Lorg/xml/sax/ContentHandler;->endPrefixMapping(Ljava/lang/String;)V

    .line 697
    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/NsDeclaration;->getPrev()Lcom/fasterxml/aalto/in/NsDeclaration;

    move-result-object v3

    .line 698
    .end local v5    # "prefix":Ljava/lang/String;
    goto :goto_1

    .line 700
    .end local v0    # "n":Lcom/fasterxml/aalto/in/PName;
    .end local v1    # "uri":Ljava/lang/String;
    .end local v3    # "nsDecl":Lcom/fasterxml/aalto/in/NsDeclaration;
    .end local v4    # "level":I
    :cond_2
    return-void
.end method

.method public fireSaxPIEvent(Lorg/xml/sax/ContentHandler;)V
    .locals 2
    .param p1, "h"    # Lorg/xml/sax/ContentHandler;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;,
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 738
    if-eqz p1, :cond_1

    .line 739
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_tokenIncomplete:Z

    if-eqz v0, :cond_0

    .line 740
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->finishToken()V

    .line 742
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getLocalName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->getText()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1, v0, v1}, Lorg/xml/sax/ContentHandler;->processingInstruction(Ljava/lang/String;Ljava/lang/String;)V

    .line 744
    :cond_1
    return-void
.end method

.method public fireSaxSpaceEvents(Lorg/xml/sax/ContentHandler;)V
    .locals 1
    .param p1, "h"    # Lorg/xml/sax/ContentHandler;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;,
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 716
    if-eqz p1, :cond_1

    .line 717
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_tokenIncomplete:Z

    if-eqz v0, :cond_0

    .line 718
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->finishToken()V

    .line 720
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/util/TextBuilder;->fireSaxSpaceEvents(Lorg/xml/sax/ContentHandler;)V

    .line 722
    :cond_1
    return-void
.end method

.method public fireSaxStartElement(Lorg/xml/sax/ContentHandler;Lorg/xml/sax/Attributes;)V
    .locals 7
    .param p1, "h"    # Lorg/xml/sax/ContentHandler;
    .param p2, "attrs"    # Lorg/xml/sax/Attributes;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 650
    if-eqz p1, :cond_3

    .line 652
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    .line 657
    .local v0, "nsDecl":Lcom/fasterxml/aalto/in/NsDeclaration;
    iget v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_depth:I

    add-int/lit8 v1, v1, -0x1

    .line 658
    .local v1, "level":I
    :goto_0
    const-string v2, ""

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->getLevel()I

    move-result v3

    if-ne v3, v1, :cond_1

    .line 659
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->getPrefix()Ljava/lang/String;

    move-result-object v3

    .line 660
    .local v3, "prefix":Ljava/lang/String;
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->getCurrNsURI()Ljava/lang/String;

    move-result-object v4

    .line 661
    .local v4, "uri":Ljava/lang/String;
    if-nez v3, :cond_0

    goto :goto_1

    :cond_0
    move-object v2, v3

    :goto_1
    invoke-interface {p1, v2, v4}, Lorg/xml/sax/ContentHandler;->startPrefixMapping(Ljava/lang/String;Ljava/lang/String;)V

    .line 662
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->getPrev()Lcom/fasterxml/aalto/in/NsDeclaration;

    move-result-object v0

    .line 663
    .end local v3    # "prefix":Ljava/lang/String;
    .end local v4    # "uri":Ljava/lang/String;
    goto :goto_0

    .line 666
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->getName()Lcom/fasterxml/aalto/in/PName;

    move-result-object v3

    .line 667
    .local v3, "n":Lcom/fasterxml/aalto/in/PName;
    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/PName;->getNsUri()Ljava/lang/String;

    move-result-object v4

    .line 669
    .restart local v4    # "uri":Ljava/lang/String;
    if-nez v4, :cond_2

    goto :goto_2

    :cond_2
    move-object v2, v4

    .line 670
    :goto_2
    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/PName;->getLocalName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v6

    .line 669
    invoke-interface {p1, v2, v5, v6, p2}, Lorg/xml/sax/ContentHandler;->startElement(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lorg/xml/sax/Attributes;)V

    .line 673
    .end local v0    # "nsDecl":Lcom/fasterxml/aalto/in/NsDeclaration;
    .end local v1    # "level":I
    .end local v3    # "n":Lcom/fasterxml/aalto/in/PName;
    .end local v4    # "uri":Ljava/lang/String;
    :cond_3
    return-void
.end method

.method public getAttrCollector()Lcom/fasterxml/aalto/in/AttributeCollector;
    .locals 1

    .line 378
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    return-object v0
.end method

.method public final getAttrCount()I
    .locals 1

    .line 753
    iget v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_attrCount:I

    return v0
.end method

.method public final getAttrLocalName(I)Ljava/lang/String;
    .locals 1
    .param p1, "index"    # I

    .line 759
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/AttributeCollector;->getName(I)Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getLocalName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final getAttrNsURI(I)Ljava/lang/String;
    .locals 1
    .param p1, "index"    # I

    .line 777
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/AttributeCollector;->getName(I)Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getNsUri()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final getAttrPrefix(I)Ljava/lang/String;
    .locals 1
    .param p1, "index"    # I

    .line 783
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/AttributeCollector;->getName(I)Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getPrefix()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final getAttrPrefixedName(I)Ljava/lang/String;
    .locals 1
    .param p1, "index"    # I

    .line 771
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/AttributeCollector;->getName(I)Lcom/fasterxml/aalto/in/PName;

    move-result-object v0

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final getAttrQName(I)Ljavax/xml/namespace/QName;
    .locals 1
    .param p1, "index"    # I

    .line 765
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/AttributeCollector;->getQName(I)Ljavax/xml/namespace/QName;

    move-result-object v0

    return-object v0
.end method

.method public final getAttrType(I)Ljava/lang/String;
    .locals 1
    .param p1, "index"    # I

    .line 842
    const-string v0, "CDATA"

    return-object v0
.end method

.method public final getAttrValue(I)Ljava/lang/String;
    .locals 1
    .param p1, "index"    # I

    .line 789
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/AttributeCollector;->getValue(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final getAttrValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "nsURI"    # Ljava/lang/String;
    .param p2, "localName"    # Ljava/lang/String;

    .line 797
    iget v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_attrCount:I

    const/4 v1, 0x1

    if-ge v0, v1, :cond_0

    .line 798
    const/4 v0, 0x0

    return-object v0

    .line 800
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_attrCollector:Lcom/fasterxml/aalto/in/AttributeCollector;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/in/AttributeCollector;->getValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getConfig()Lcom/fasterxml/aalto/in/ReaderConfig;
    .locals 1

    .line 376
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    return-object v0
.end method

.method public abstract getCurrentColumnNr()I
.end method

.method public final getCurrentLineNr()I
    .locals 1

    .line 488
    iget v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_currRow:I

    add-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public abstract getCurrentLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
.end method

.method public final getDTDPublicId()Ljava/lang/String;
    .locals 1

    .line 530
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_publicId:Ljava/lang/String;

    return-object v0
.end method

.method public final getDTDSystemId()Ljava/lang/String;
    .locals 1

    .line 534
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_systemId:Ljava/lang/String;

    return-object v0
.end method

.method public final getDepth()I
    .locals 1

    .line 511
    iget v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_depth:I

    return v0
.end method

.method public getEndLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 481
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_tokenIncomplete:Z

    if-eqz v0, :cond_0

    .line 482
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->finishToken()V

    .line 484
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->getCurrentLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v0

    return-object v0
.end method

.method public abstract getEndingByteOffset()J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract getEndingCharOffset()J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public final getInputPublicId()Ljava/lang/String;
    .locals 1

    .line 498
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getPublicId()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final getInputSystemId()Ljava/lang/String;
    .locals 1

    .line 494
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getSystemId()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final getName()Lcom/fasterxml/aalto/in/PName;
    .locals 1

    .line 522
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    return-object v0
.end method

.method public final getNamespacePrefix(I)Ljava/lang/String;
    .locals 1
    .param p1, "index"    # I

    .line 868
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;->findCurrNsDecl(I)Lcom/fasterxml/aalto/in/NsDeclaration;

    move-result-object v0

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->getBinding()Lcom/fasterxml/aalto/in/NsBinding;

    move-result-object v0

    iget-object v0, v0, Lcom/fasterxml/aalto/in/NsBinding;->mPrefix:Ljava/lang/String;

    return-object v0
.end method

.method public final getNamespaceURI()Ljava/lang/String;
    .locals 2

    .line 909
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/PName;->getNsUri()Ljava/lang/String;

    move-result-object v0

    .line 911
    .local v0, "uri":Ljava/lang/String;
    if-nez v0, :cond_0

    iget-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_defaultNs:Lcom/fasterxml/aalto/in/NsBinding;

    iget-object v1, v1, Lcom/fasterxml/aalto/in/NsBinding;->mURI:Ljava/lang/String;

    goto :goto_0

    :cond_0
    move-object v1, v0

    :goto_0
    return-object v1
.end method

.method public final getNamespaceURI(I)Ljava/lang/String;
    .locals 1
    .param p1, "index"    # I

    .line 873
    invoke-direct {p0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;->findCurrNsDecl(I)Lcom/fasterxml/aalto/in/NsDeclaration;

    move-result-object v0

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->getBinding()Lcom/fasterxml/aalto/in/NsBinding;

    move-result-object v0

    iget-object v0, v0, Lcom/fasterxml/aalto/in/NsBinding;->mURI:Ljava/lang/String;

    return-object v0
.end method

.method public getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;

    .line 929
    if-eqz p1, :cond_6

    .line 932
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    .line 934
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_defaultNs:Lcom/fasterxml/aalto/in/NsBinding;

    iget-object v0, v0, Lcom/fasterxml/aalto/in/NsBinding;->mURI:Ljava/lang/String;

    .line 935
    .local v0, "uri":Ljava/lang/String;
    if-nez v0, :cond_0

    const-string v1, ""

    goto :goto_0

    :cond_0
    move-object v1, v0

    :goto_0
    return-object v1

    .line 938
    .end local v0    # "uri":Ljava/lang/String;
    :cond_1
    const-string/jumbo v0, "xml"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 939
    const-string v0, "http://www.w3.org/XML/1998/namespace"

    return-object v0

    .line 941
    :cond_2
    const-string/jumbo v0, "xmlns"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 942
    const-string v0, "http://www.w3.org/2000/xmlns/"

    return-object v0

    .line 945
    :cond_3
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    .line 946
    .local v0, "nsDecl":Lcom/fasterxml/aalto/in/NsDeclaration;
    :goto_1
    if-eqz v0, :cond_5

    .line 947
    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/NsDeclaration;->hasPrefix(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 948
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->getCurrNsURI()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 950
    :cond_4
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->getPrev()Lcom/fasterxml/aalto/in/NsDeclaration;

    move-result-object v0

    goto :goto_1

    .line 952
    :cond_5
    const/4 v1, 0x0

    return-object v1

    .line 930
    .end local v0    # "nsDecl":Lcom/fasterxml/aalto/in/NsDeclaration;
    :cond_6
    new-instance v0, Ljava/lang/IllegalArgumentException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_NULL_ARG:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final getNonTransientNamespaceContext()Ljavax/xml/namespace/NamespaceContext;
    .locals 2

    .line 916
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_lastNsContext:Lcom/fasterxml/aalto/in/FixedNsContext;

    iget-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/FixedNsContext;->reuseOrCreate(Lcom/fasterxml/aalto/in/NsDeclaration;)Lcom/fasterxml/aalto/in/FixedNsContext;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_lastNsContext:Lcom/fasterxml/aalto/in/FixedNsContext;

    .line 917
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_lastNsContext:Lcom/fasterxml/aalto/in/FixedNsContext;

    return-object v0
.end method

.method public final getNsCount()I
    .locals 2

    .line 860
    iget v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_currToken:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 861
    iget v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_currNsCount:I

    return v0

    .line 863
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    if-nez v0, :cond_1

    const/4 v0, 0x0

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    iget v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_depth:I

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/NsDeclaration;->countDeclsOnLevel(I)I

    move-result v0

    :goto_0
    return v0
.end method

.method public getPrefix(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "nsURI"    # Ljava/lang/String;

    .line 961
    if-eqz p1, :cond_7

    .line 964
    const-string v0, "http://www.w3.org/XML/1998/namespace"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 965
    const-string/jumbo v0, "xml"

    return-object v0

    .line 967
    :cond_0
    const-string v0, "http://www.w3.org/2000/xmlns/"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 968
    const-string/jumbo v0, "xmlns"

    return-object v0

    .line 971
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_defaultNs:Lcom/fasterxml/aalto/in/NsBinding;

    iget-object v0, v0, Lcom/fasterxml/aalto/in/NsBinding;->mURI:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 972
    const-string v0, ""

    return-object v0

    .line 978
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    .local v0, "nsDecl":Lcom/fasterxml/aalto/in/NsDeclaration;
    :goto_0
    if-eqz v0, :cond_6

    .line 980
    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/NsDeclaration;->hasNsURI(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 982
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->getPrefix()Ljava/lang/String;

    move-result-object v1

    .line 984
    .local v1, "prefix":Ljava/lang/String;
    if-eqz v1, :cond_5

    .line 985
    iget-object v2, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    .local v2, "decl2":Lcom/fasterxml/aalto/in/NsDeclaration;
    :goto_1
    if-eq v2, v0, :cond_4

    .line 987
    invoke-virtual {v2, v1}, Lcom/fasterxml/aalto/in/NsDeclaration;->hasPrefix(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 988
    goto :goto_2

    .line 986
    :cond_3
    invoke-virtual {v2}, Lcom/fasterxml/aalto/in/NsDeclaration;->getPrev()Lcom/fasterxml/aalto/in/NsDeclaration;

    move-result-object v2

    goto :goto_1

    .line 991
    .end local v2    # "decl2":Lcom/fasterxml/aalto/in/NsDeclaration;
    :cond_4
    return-object v1

    .line 979
    .end local v1    # "prefix":Ljava/lang/String;
    :cond_5
    :goto_2
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->getPrev()Lcom/fasterxml/aalto/in/NsDeclaration;

    move-result-object v0

    goto :goto_0

    .line 995
    .end local v0    # "nsDecl":Lcom/fasterxml/aalto/in/NsDeclaration;
    :cond_6
    const/4 v0, 0x0

    return-object v0

    .line 962
    :cond_7
    new-instance v0, Ljava/lang/IllegalArgumentException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_NULL_ARG:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public getPrefixes(Ljava/lang/String;)Ljava/util/Iterator;
    .locals 5
    .param p1, "nsURI"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Iterator<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 1001
    if-eqz p1, :cond_a

    .line 1004
    const-string v0, "http://www.w3.org/XML/1998/namespace"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1005
    new-instance v0, Lcom/fasterxml/aalto/util/SingletonIterator;

    const-string/jumbo v1, "xml"

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/util/SingletonIterator;-><init>(Ljava/lang/String;)V

    return-object v0

    .line 1007
    :cond_0
    const-string v0, "http://www.w3.org/2000/xmlns/"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1008
    new-instance v0, Lcom/fasterxml/aalto/util/SingletonIterator;

    const-string/jumbo v1, "xmlns"

    invoke-direct {v0, v1}, Lcom/fasterxml/aalto/util/SingletonIterator;-><init>(Ljava/lang/String;)V

    return-object v0

    .line 1010
    :cond_1
    const/4 v0, 0x0

    .line 1013
    .local v0, "l":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    iget-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_defaultNs:Lcom/fasterxml/aalto/in/NsBinding;

    iget-object v1, v1, Lcom/fasterxml/aalto/in/NsBinding;->mURI:Ljava/lang/String;

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 1014
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    move-object v0, v1

    .line 1015
    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 1019
    :cond_2
    iget-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    .local v1, "nsDecl":Lcom/fasterxml/aalto/in/NsDeclaration;
    :goto_0
    if-eqz v1, :cond_7

    .line 1021
    invoke-virtual {v1, p1}, Lcom/fasterxml/aalto/in/NsDeclaration;->hasNsURI(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_6

    .line 1023
    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/NsDeclaration;->getPrefix()Ljava/lang/String;

    move-result-object v2

    .line 1025
    .local v2, "prefix":Ljava/lang/String;
    if-eqz v2, :cond_6

    .line 1026
    iget-object v3, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_lastNsDecl:Lcom/fasterxml/aalto/in/NsDeclaration;

    .local v3, "decl2":Lcom/fasterxml/aalto/in/NsDeclaration;
    :goto_1
    if-eq v3, v1, :cond_4

    .line 1028
    invoke-virtual {v3, v2}, Lcom/fasterxml/aalto/in/NsDeclaration;->hasPrefix(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 1029
    goto :goto_2

    .line 1027
    :cond_3
    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/NsDeclaration;->getPrev()Lcom/fasterxml/aalto/in/NsDeclaration;

    move-result-object v3

    goto :goto_1

    .line 1032
    .end local v3    # "decl2":Lcom/fasterxml/aalto/in/NsDeclaration;
    :cond_4
    if-nez v0, :cond_5

    .line 1033
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    move-object v0, v3

    .line 1035
    :cond_5
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 1020
    .end local v2    # "prefix":Ljava/lang/String;
    :cond_6
    :goto_2
    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/NsDeclaration;->getPrev()Lcom/fasterxml/aalto/in/NsDeclaration;

    move-result-object v1

    goto :goto_0

    .line 1040
    .end local v1    # "nsDecl":Lcom/fasterxml/aalto/in/NsDeclaration;
    :cond_7
    if-nez v0, :cond_8

    .line 1041
    invoke-static {}, Lcom/fasterxml/aalto/util/EmptyIterator;->getInstance()Lcom/fasterxml/aalto/util/EmptyIterator;

    move-result-object v1

    return-object v1

    .line 1043
    :cond_8
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_9

    .line 1044
    new-instance v1, Lcom/fasterxml/aalto/util/SingletonIterator;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-direct {v1, v2}, Lcom/fasterxml/aalto/util/SingletonIterator;-><init>(Ljava/lang/String;)V

    return-object v1

    .line 1046
    :cond_9
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    return-object v1

    .line 1002
    .end local v0    # "l":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :cond_a
    new-instance v0, Ljava/lang/IllegalArgumentException;

    sget-object v1, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_NULL_ARG:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final getQName()Ljavax/xml/namespace/QName;
    .locals 2

    .line 526
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    iget-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_defaultNs:Lcom/fasterxml/aalto/in/NsBinding;

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/PName;->constructQName(Lcom/fasterxml/aalto/in/NsBinding;)Ljavax/xml/namespace/QName;

    move-result-object v0

    return-object v0
.end method

.method public final getStartLocation()Lorg/codehaus/stax2/XMLStreamLocation2;
    .locals 8

    .line 467
    iget-wide v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_startRow:J

    long-to-int v0, v0

    .line 468
    .local v0, "row":I
    iget-wide v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_startColumn:J

    long-to-int v1, v1

    .line 469
    .local v1, "col":I
    iget-object v2, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v2}, Lcom/fasterxml/aalto/in/ReaderConfig;->getPublicId()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v3}, Lcom/fasterxml/aalto/in/ReaderConfig;->getSystemId()Ljava/lang/String;

    move-result-object v3

    iget-wide v4, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_startRawOffset:J

    move v6, v0

    move v7, v1

    invoke-static/range {v2 .. v7}, Lcom/fasterxml/aalto/impl/LocationImpl;->fromZeroBased(Ljava/lang/String;Ljava/lang/String;JII)Lcom/fasterxml/aalto/impl/LocationImpl;

    move-result-object v2

    return-object v2
.end method

.method public abstract getStartingByteOffset()J
.end method

.method public abstract getStartingCharOffset()J
.end method

.method public final getText(Ljava/io/Writer;Z)I
    .locals 2
    .param p1, "w"    # Ljava/io/Writer;
    .param p2, "preserveContents"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 581
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_tokenIncomplete:Z

    if-eqz v0, :cond_0

    .line 582
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->finishToken()V

    .line 588
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/util/TextBuilder;->rawContentsTo(Ljava/io/Writer;)I

    move-result v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    .line 589
    :catch_0
    move-exception v0

    .line 590
    .local v0, "ioe":Ljava/io/IOException;
    new-instance v1, Lcom/fasterxml/aalto/impl/IoStreamException;

    invoke-direct {v1, v0}, Lcom/fasterxml/aalto/impl/IoStreamException;-><init>(Ljava/io/IOException;)V

    throw v1
.end method

.method public final getText()Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 545
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_tokenIncomplete:Z

    if-eqz v0, :cond_0

    .line 546
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->finishToken()V

    .line 548
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->contentsAsString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final getTextCharacters(I[CII)I
    .locals 1
    .param p1, "srcStart"    # I
    .param p2, "target"    # [C
    .param p3, "targetStart"    # I
    .param p4, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 572
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_tokenIncomplete:Z

    if-eqz v0, :cond_0

    .line 573
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->finishToken()V

    .line 575
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/fasterxml/aalto/util/TextBuilder;->contentsToArray(I[CII)I

    move-result v0

    return v0
.end method

.method public final getTextCharacters()[C
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 563
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_tokenIncomplete:Z

    if-eqz v0, :cond_0

    .line 564
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->finishToken()V

    .line 566
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->getTextBuffer()[C

    move-result-object v0

    return-object v0
.end method

.method public final getTextLength()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 554
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_tokenIncomplete:Z

    if-eqz v0, :cond_0

    .line 555
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->finishToken()V

    .line 557
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->size()I

    move-result v0

    return v0
.end method

.method protected handleInvalidXmlChar(I)C
    .locals 5
    .param p1, "i"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1529
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->getIllegalCharHandler()Lcom/fasterxml/aalto/util/IllegalCharHandler;

    move-result-object v0

    .line 1531
    .local v0, "iHandler":Lcom/fasterxml/aalto/util/IllegalCharHandler;
    if-eqz v0, :cond_0

    .line 1532
    invoke-interface {v0, p1}, Lcom/fasterxml/aalto/util/IllegalCharHandler;->convertIllegalChar(I)C

    move-result v1

    return v1

    .line 1535
    :cond_0
    int-to-char v1, p1

    .line 1536
    .local v1, "c":C
    if-nez v1, :cond_1

    .line 1537
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->throwNullChar()V

    .line 1540
    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Illegal XML character ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {v1}, Lcom/fasterxml/aalto/util/XmlChars;->getCharDesc(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ")"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 1541
    .local v2, "msg":Ljava/lang/String;
    iget-boolean v3, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_xml11:Z

    if-eqz v3, :cond_2

    .line 1542
    const/16 v3, 0x20

    if-ge p1, v3, :cond_2

    .line 1543
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " [note: in XML 1.1, it could be included via entity expansion]"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 1546
    :cond_2
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1549
    int-to-char v3, p1

    return v3
.end method

.method public final hasEmptyStack()Z
    .locals 1

    .line 508
    iget v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_depth:I

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public final isAttrSpecified(I)Z
    .locals 1
    .param p1, "index"    # I

    .line 849
    const/4 v0, 0x1

    return v0
.end method

.method public final isEmptyTag()Z
    .locals 1

    .line 513
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_isEmptyTag:Z

    return v0
.end method

.method public final isTextWhitespace()Z
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 597
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_tokenIncomplete:Z

    if-eqz v0, :cond_0

    .line 598
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->finishToken()V

    .line 600
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/util/TextBuilder;->isAllWhitespace()Z

    move-result v0

    return v0
.end method

.method protected abstract loadMore()Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected final loadMoreGuaranteed()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1283
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_0

    .line 1284
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Unexpected end-of-input when trying to parse "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_currToken:I

    invoke-static {v1}, Lcom/fasterxml/aalto/impl/ErrorConsts;->tokenTypeDesc(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1286
    :cond_0
    return-void
.end method

.method protected final loadMoreGuaranteed(I)V
    .locals 2
    .param p1, "tt"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1290
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->loadMore()Z

    move-result v0

    if-nez v0, :cond_0

    .line 1291
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Unexpected end-of-input when trying to parse "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p1}, Lcom/fasterxml/aalto/impl/ErrorConsts;->tokenTypeDesc(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1293
    :cond_0
    return-void
.end method

.method public abstract nextFromProlog(Z)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method public abstract nextFromTree()I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected reportDoubleHyphenInComments()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1446
    const-string v0, "String \'--\' not allowed in comment (missing \'>\'?)"

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1447
    return-void
.end method

.method protected reportDuplicateNsDecl(Ljava/lang/String;)V
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1480
    if-nez p1, :cond_0

    .line 1481
    const-string v0, "Duplicate namespace declaration for the default namespace"

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    goto :goto_0

    .line 1483
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Duplicate namespace declaration for prefix \'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1485
    :goto_0
    return-void
.end method

.method protected reportEntityOverflow()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1458
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Illegal character entity: value higher than max allowed (0x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const v1, 0x10ffff

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1459
    return-void
.end method

.method protected reportEofInName([CI)V
    .locals 2
    .param p1, "cbuf"    # [C
    .param p2, "clen"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1430
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Unexpected end-of-input in name (parsing "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_currToken:I

    invoke-static {v1}, Lcom/fasterxml/aalto/impl/ErrorConsts;->tokenTypeDesc(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1431
    return-void
.end method

.method protected reportIllegalCDataEnd()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1508
    const-string v0, "String \']]>\' not allowed in textual content, except as the end marker of CDATA section"

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1509
    return-void
.end method

.method protected reportIllegalNsDecl(Ljava/lang/String;)V
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1490
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Illegal namespace declaration: can not re-bind prefix \'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1491
    return-void
.end method

.method protected reportIllegalNsDecl(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;
    .param p2, "uri"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1496
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Illegal namespace declaration: can not bind URI \'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\' to prefix other than \'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1497
    return-void
.end method

.method protected reportInputProblem(Ljava/lang/String;)V
    .locals 2
    .param p1, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1333
    new-instance v0, Lcom/fasterxml/aalto/WFCException;

    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->getCurrentLocation()Lorg/codehaus/stax2/XMLStreamLocation2;

    move-result-object v1

    invoke-direct {v0, p1, v1}, Lcom/fasterxml/aalto/WFCException;-><init>(Ljava/lang/String;Ljavax/xml/stream/Location;)V

    throw v0
.end method

.method protected reportInvalidNameChar(II)V
    .locals 3
    .param p1, "ch"    # I
    .param p2, "index"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1402
    const/16 v0, 0x3a

    if-ne p1, v0, :cond_0

    .line 1403
    const-string v0, "Invalid colon in name: at most one colon allowed in element/attribute names, and none in PI target or entity names"

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1405
    :cond_0
    const-string v0, ")"

    if-nez p2, :cond_1

    .line 1406
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid name start character (0x"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 1407
    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1406
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1409
    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid name character (0x"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 1410
    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1409
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1411
    return-void
.end method

.method protected reportInvalidNsIndex(I)V
    .locals 3
    .param p1, "index"    # I

    .line 1467
    new-instance v0, Ljava/lang/IndexOutOfBoundsException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Illegal namespace declaration index, "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", current START_ELEMENT/END_ELEMENT has "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->getNsCount()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " declarations"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IndexOutOfBoundsException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected reportInvalidXmlChar(I)V
    .locals 3
    .param p1, "ch"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1416
    if-nez p1, :cond_0

    .line 1417
    const-string v0, "Invalid null character"

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1419
    :cond_0
    const/16 v0, 0x20

    const-string v1, ")"

    if-ge p1, v0, :cond_1

    .line 1420
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid white space character (0x"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 1421
    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1420
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1423
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid xml content character (0x"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 1424
    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1423
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1425
    return-void
.end method

.method protected reportMissingPISpace(I)V
    .locals 1
    .param p1, "ch"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1440
    const-string v0, ": expected either white space, or closing \'?>\'"

    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1441
    return-void
.end method

.method protected reportMultipleColonsInName()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1452
    const-string v0, "Multiple colons not allowed in names"

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1453
    return-void
.end method

.method protected reportPrologProblem(ZLjava/lang/String;)V
    .locals 3
    .param p1, "isProlog"    # Z
    .param p2, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1385
    if-eqz p1, :cond_0

    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->SUFFIX_IN_PROLOG:Ljava/lang/String;

    goto :goto_0

    :cond_0
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->SUFFIX_IN_EPILOG:Ljava/lang/String;

    .line 1386
    .local v0, "prefix":Ljava/lang/String;
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ": "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1387
    return-void
.end method

.method protected reportPrologUnexpChar(ZILjava/lang/String;)V
    .locals 3
    .param p1, "isProlog"    # Z
    .param p2, "ch"    # I
    .param p3, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1371
    if-eqz p1, :cond_0

    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->SUFFIX_IN_PROLOG:Ljava/lang/String;

    goto :goto_0

    :cond_0
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->SUFFIX_IN_EPILOG:Ljava/lang/String;

    .line 1372
    .local v0, "fullMsg":Ljava/lang/String;
    :goto_0
    if-nez p3, :cond_1

    .line 1373
    const/16 v1, 0x26

    if-ne p2, v1, :cond_2

    .line 1374
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "; no entities allowed"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, p2, v1}, Lcom/fasterxml/aalto/in/XmlScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    goto :goto_1

    .line 1377
    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1379
    :cond_2
    :goto_1
    invoke-virtual {p0, p2, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1380
    return-void
.end method

.method protected reportPrologUnexpElement(ZI)V
    .locals 3
    .param p1, "isProlog"    # Z
    .param p2, "ch"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1350
    if-gez p2, :cond_0

    .line 1351
    const v0, 0x7ffff

    and-int/2addr p2, v0

    .line 1353
    :cond_0
    const/16 v0, 0x2f

    if-ne p2, v0, :cond_2

    .line 1354
    if-eqz p1, :cond_1

    .line 1355
    const-string v0, "Unexpected end element in prolog: malformed XML document, expected root element"

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1357
    :cond_1
    const-string v0, "Unexpected end element in epilog: malformed XML document (unbalanced start/end tags?)"

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1361
    :cond_2
    const/16 v0, 0x20

    if-ge p2, v0, :cond_4

    .line 1362
    if-eqz p1, :cond_3

    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->SUFFIX_IN_PROLOG:Ljava/lang/String;

    goto :goto_0

    :cond_3
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->SUFFIX_IN_EPILOG:Ljava/lang/String;

    .line 1363
    .local v0, "type":Ljava/lang/String;
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unrecognized directive "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, p2, v1}, Lcom/fasterxml/aalto/in/XmlScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1365
    .end local v0    # "type":Ljava/lang/String;
    :cond_4
    const-string v0, "Second root element in content: malformed XML document, only one allowed"

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1366
    return-void
.end method

.method protected reportTreeUnexpChar(ILjava/lang/String;)V
    .locals 2
    .param p1, "ch"    # I
    .param p2, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1392
    sget-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->SUFFIX_IN_TREE:Ljava/lang/String;

    .line 1393
    .local v0, "fullMsg":Ljava/lang/String;
    if-eqz p2, :cond_0

    .line 1394
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1396
    :cond_0
    invoke-virtual {p0, p1, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->throwUnexpectedChar(ILjava/lang/String;)V

    .line 1397
    return-void
.end method

.method protected reportUnboundPrefix(Lcom/fasterxml/aalto/in/PName;Z)V
    .locals 2
    .param p1, "name"    # Lcom/fasterxml/aalto/in/PName;
    .param p2, "isAttr"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1473
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Unbound namespace prefix \'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/PName;->getPrefix()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\' (for "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    if-eqz p2, :cond_0

    const-string v1, "attribute"

    goto :goto_0

    :cond_0
    const-string v1, "element"

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " name \'"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Lcom/fasterxml/aalto/in/PName;->getPrefixedName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\')"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1474
    return-void
.end method

.method protected reportUnexpandedEntityInAttr(Lcom/fasterxml/aalto/in/PName;Z)V
    .locals 2
    .param p1, "name"    # Lcom/fasterxml/aalto/in/PName;
    .param p2, "isNsDecl"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1343
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Unexpanded ENTITY_REFERENCE ("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_tokenName:Lcom/fasterxml/aalto/in/PName;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ") in "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    if-eqz p2, :cond_0

    const-string v1, "namespace declaration"

    goto :goto_0

    :cond_0
    const-string v1, "attribute value"

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1345
    return-void
.end method

.method protected reportUnexpectedEndTag(Ljava/lang/String;)V
    .locals 2
    .param p1, "expName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1502
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Unexpected end tag: expected </"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ">"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1503
    return-void
.end method

.method public final resetForDecoding(Lorg/codehaus/stax2/typed/Base64Variant;Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;Z)V
    .locals 1
    .param p1, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .param p2, "dec"    # Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;
    .param p3, "firstChunk"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 635
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_tokenIncomplete:Z

    if-eqz v0, :cond_0

    .line 636
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->finishToken()V

    .line 638
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_textBuilder:Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-virtual {v0, p1, p2, p3}, Lcom/fasterxml/aalto/util/TextBuilder;->resetForBinaryDecode(Lorg/codehaus/stax2/typed/Base64Variant;Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;Z)V

    .line 639
    return-void
.end method

.method protected abstract skipCData()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract skipCharacters()Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract skipCoalescedText()Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract skipComment()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract skipPI()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected abstract skipSpace()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation
.end method

.method protected final skipToken()Z
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 410
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_tokenIncomplete:Z

    .line 411
    iget v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_currToken:I

    const/4 v2, 0x1

    const/16 v3, 0x9

    packed-switch v1, :pswitch_data_0

    .line 448
    :pswitch_0
    new-instance v0, Ljava/lang/Error;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Internal error, unexpected incomplete token type "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_currToken:I

    invoke-static {v2}, Lcom/fasterxml/aalto/impl/ErrorConsts;->tokenTypeDesc(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/Error;-><init>(Ljava/lang/String;)V

    throw v0

    .line 435
    :pswitch_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->skipCData()V

    .line 436
    iget-boolean v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_cfgCoalescing:Z

    if-eqz v1, :cond_1

    .line 437
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->skipCoalescedText()Z

    .line 438
    iget-boolean v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_entityPending:Z

    if-eqz v1, :cond_1

    .line 439
    iput v3, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_currToken:I

    .line 440
    return v2

    .line 445
    :pswitch_2
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->finishDTD(Z)V

    .line 446
    goto :goto_0

    .line 432
    :pswitch_3
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->skipSpace()V

    .line 433
    goto :goto_0

    .line 429
    :pswitch_4
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->skipComment()V

    .line 430
    goto :goto_0

    .line 416
    :pswitch_5
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->skipCharacters()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 418
    iput v3, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_currToken:I

    .line 419
    return v2

    .line 421
    :cond_0
    iget-boolean v1, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_cfgCoalescing:Z

    if-eqz v1, :cond_1

    .line 422
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->skipCoalescedText()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 423
    iput v3, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_currToken:I

    .line 424
    return v2

    .line 413
    :pswitch_6
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->skipPI()V

    .line 414
    nop

    .line 450
    :cond_1
    :goto_0
    return v0

    :pswitch_data_0
    .packed-switch 0x3
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method protected throwInvalidSpace(I)V
    .locals 4
    .param p1, "i"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1555
    int-to-char v0, p1

    .line 1556
    .local v0, "c":C
    if-nez v0, :cond_0

    .line 1557
    invoke-virtual {p0}, Lcom/fasterxml/aalto/in/XmlScanner;->throwNullChar()V

    .line 1559
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Illegal character ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {v0}, Lcom/fasterxml/aalto/util/XmlChars;->getCharDesc(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1560
    .local v1, "msg":Ljava/lang/String;
    iget-boolean v2, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_xml11:Z

    if-eqz v2, :cond_1

    .line 1561
    const/16 v2, 0x20

    if-ge p1, v2, :cond_1

    .line 1562
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " [note: in XML 1.1, it could be included via entity expansion]"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1565
    :cond_1
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1566
    return-void
.end method

.method protected throwNullChar()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1524
    const-string v0, "Illegal character (NULL, unicode 0) encountered: not valid in any content"

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1525
    return-void
.end method

.method protected throwUnexpectedChar(ILjava/lang/String;)V
    .locals 3
    .param p1, "i"    # I
    .param p2, "msg"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1514
    const/16 v0, 0x20

    if-ge p1, v0, :cond_0

    const/16 v0, 0xd

    if-eq p1, v0, :cond_0

    const/16 v0, 0xa

    if-eq p1, v0, :cond_0

    const/16 v0, 0x9

    if-eq p1, v0, :cond_0

    .line 1515
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;->throwInvalidSpace(I)V

    .line 1517
    :cond_0
    int-to-char v0, p1

    .line 1518
    .local v0, "c":C
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unexpected character "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {v0}, Lcom/fasterxml/aalto/util/XmlChars;->getCharDesc(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 1519
    .local v1, "excMsg":Ljava/lang/String;
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInputProblem(Ljava/lang/String;)V

    .line 1520
    return-void
.end method

.method protected final verifyXmlChar(I)V
    .locals 1
    .param p1, "value"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljavax/xml/stream/XMLStreamException;
        }
    .end annotation

    .line 1304
    const v0, 0xd800

    if-lt p1, v0, :cond_2

    .line 1305
    const v0, 0xe000

    if-ge p1, v0, :cond_0

    .line 1306
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInvalidXmlChar(I)V

    .line 1308
    :cond_0
    const v0, 0xfffe

    if-eq p1, v0, :cond_1

    const v0, 0xffff

    if-ne p1, v0, :cond_4

    .line 1309
    :cond_1
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInvalidXmlChar(I)V

    goto :goto_0

    .line 1311
    :cond_2
    const/16 v0, 0x20

    if-ge p1, v0, :cond_4

    .line 1313
    const/16 v0, 0xa

    if-eq p1, v0, :cond_4

    const/16 v0, 0xd

    if-eq p1, v0, :cond_4

    const/16 v0, 0x9

    if-eq p1, v0, :cond_4

    .line 1314
    iget-boolean v0, p0, Lcom/fasterxml/aalto/in/XmlScanner;->_xml11:Z

    if-eqz v0, :cond_3

    if-nez p1, :cond_4

    .line 1315
    :cond_3
    invoke-virtual {p0, p1}, Lcom/fasterxml/aalto/in/XmlScanner;->reportInvalidXmlChar(I)V

    .line 1319
    :cond_4
    :goto_0
    return-void
.end method
