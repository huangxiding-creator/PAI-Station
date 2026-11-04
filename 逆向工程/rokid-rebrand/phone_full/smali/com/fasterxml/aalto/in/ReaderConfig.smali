.class public final Lcom/fasterxml/aalto/in/ReaderConfig;
.super Lcom/fasterxml/aalto/impl/CommonConfig;
.source "ReaderConfig.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;
    }
.end annotation


# static fields
.field public static final DEFAULT_CHAR_BUFFER_LEN:I = 0xfa0

.field protected static final DEFAULT_FLAGS:I = 0x1f15

.field public static final DEFAULT_SMALL_BUFFER_LEN:I = 0x3c

.field protected static final F_AUTO_CLOSE_INPUT:I = 0x2000

.field protected static final F_COALESCING:I = 0x2

.field protected static final F_DTD_AWARE:I = 0x4

.field protected static final F_DTD_VALIDATING:I = 0x8

.field protected static final F_EXPAND_ENTITIES:I = 0x10

.field protected static final F_INTERN_NAMES:I = 0x200

.field protected static final F_INTERN_NS_URIS:I = 0x400

.field protected static final F_LAZY_PARSING:I = 0x100

.field protected static final F_NS_AWARE:I = 0x1

.field protected static final F_PRESERVE_LOCATION:I = 0x1000

.field protected static final F_REPORT_CDATA:I = 0x800

.field protected static final F_RETAIN_ATTRIBUTE_GENERAL_ENTITIES:I = 0x4000

.field public static final STANDALONE_NO:I = 0x2

.field public static final STANDALONE_UNKNOWN:I = 0x0

.field public static final STANDALONE_YES:I = 0x1

.field static final _recyclerRef:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/lang/ref/SoftReference<",
            "Lcom/fasterxml/aalto/util/BufferRecycler;",
            ">;>;"
        }
    .end annotation
.end field

.field private static final sProperties:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field protected _currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

.field private illegalCharHandler:Lcom/fasterxml/aalto/util/IllegalCharHandler;

.field private mActualEncoding:Ljava/lang/String;

.field private final mCanonicalizer:Lcom/fasterxml/aalto/util/UriCanonicalizer;

.field private final mEncCtxt:Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;

.field private final mExtEncoding:Ljava/lang/String;

.field private final mPublicId:Ljava/lang/String;

.field private mReporter:Ljavax/xml/stream/XMLReporter;

.field private mResolver:Ljavax/xml/stream/XMLResolver;

.field private final mSystemId:Ljava/lang/String;

.field private mXmlDeclEncoding:Ljava/lang/String;

.field private mXmlDeclStandalone:I

.field private mXmlDeclVersion:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .line 65
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    .line 69
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    const-string v1, "javax.xml.stream.isNamespaceAware"

    sget-object v2, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 71
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    .line 73
    const/16 v1, 0x8

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    .line 71
    const-string v2, "javax.xml.stream.isValidating"

    invoke-virtual {v0, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 74
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    const/4 v1, 0x2

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "javax.xml.stream.isCoalescing"

    invoke-virtual {v0, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 75
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    const/16 v1, 0x10

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "javax.xml.stream.isReplacingEntityReferences"

    invoke-virtual {v0, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 76
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    const-string v1, "javax.xml.stream.isSupportingExternalEntities"

    sget-object v2, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 77
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    const/4 v1, 0x4

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "javax.xml.stream.supportDTD"

    invoke-virtual {v0, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 78
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    const-string v1, "javax.xml.stream.reporter"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 79
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    const-string v1, "javax.xml.stream.resolver"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 80
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    const-string v1, "javax.xml.stream.allocator"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 83
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    const/16 v1, 0x100

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v3, "com.ctc.wstx.lazyParsing"

    invoke-virtual {v0, v3, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 84
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    const/16 v1, 0x200

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v3, "org.codehaus.stax2.internNames"

    invoke-virtual {v0, v3, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 85
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    const/16 v1, 0x400

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v3, "org.codehaus.stax2.internNsUris"

    invoke-virtual {v0, v3, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 86
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    const/16 v1, 0x2000

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v3, "org.codehaus.stax2.closeInputSource"

    invoke-virtual {v0, v3, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 87
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    const/16 v1, 0x1000

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v3, "org.codehaus.stax2.preserveLocation"

    invoke-virtual {v0, v3, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 95
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    const-string v1, "org.codehaus.stax2.reportPrologWhitespace"

    sget-object v4, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-virtual {v0, v1, v4}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 96
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    const/16 v1, 0x800

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v4, "http://java.sun.com/xml/stream/properties/report-cdata-event"

    invoke-virtual {v0, v4, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 98
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {v0, v3, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 101
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    const-string v1, "org.codehaus.stax2.propDtdOverride"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 106
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    .line 107
    const/16 v1, 0x4000

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    .line 106
    const-string v2, "com.fasterxml.aalto.retainAttributeGeneralEntities"

    invoke-virtual {v0, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 159
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->_recyclerRef:Ljava/lang/ThreadLocal;

    return-void
.end method

.method public constructor <init>()V
    .locals 10

    .line 205
    new-instance v4, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;

    invoke-direct {v4}, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;-><init>()V

    new-instance v9, Lcom/fasterxml/aalto/util/UriCanonicalizer;

    invoke-direct {v9}, Lcom/fasterxml/aalto/util/UriCanonicalizer;-><init>()V

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/16 v5, 0x1f15

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    invoke-direct/range {v0 .. v9}, Lcom/fasterxml/aalto/in/ReaderConfig;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;IILjavax/xml/stream/XMLReporter;Ljavax/xml/stream/XMLResolver;Lcom/fasterxml/aalto/util/UriCanonicalizer;)V

    .line 208
    return-void
.end method

.method private constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;IILjavax/xml/stream/XMLReporter;Ljavax/xml/stream/XMLResolver;Lcom/fasterxml/aalto/util/UriCanonicalizer;)V
    .locals 2
    .param p1, "publicId"    # Ljava/lang/String;
    .param p2, "systemId"    # Ljava/lang/String;
    .param p3, "extEnc"    # Ljava/lang/String;
    .param p4, "encCtxt"    # Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;
    .param p5, "flags"    # I
    .param p6, "flagMods"    # I
    .param p7, "rep"    # Ljavax/xml/stream/XMLReporter;
    .param p8, "res"    # Ljavax/xml/stream/XMLResolver;
    .param p9, "canonicalizer"    # Lcom/fasterxml/aalto/util/UriCanonicalizer;

    .line 180
    invoke-direct {p0, p5, p6}, Lcom/fasterxml/aalto/impl/CommonConfig;-><init>(II)V

    .line 137
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mActualEncoding:Ljava/lang/String;

    .line 139
    iput-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mXmlDeclVersion:Ljava/lang/String;

    .line 140
    iput-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mXmlDeclEncoding:Ljava/lang/String;

    .line 141
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mXmlDeclStandalone:I

    .line 167
    iput-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    .line 181
    iput-object p1, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mPublicId:Ljava/lang/String;

    .line 182
    iput-object p2, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mSystemId:Ljava/lang/String;

    .line 183
    iput-object p3, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mExtEncoding:Ljava/lang/String;

    .line 191
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->_recyclerRef:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ref/SoftReference;

    .line 192
    .local v0, "ref":Ljava/lang/ref/SoftReference;, "Ljava/lang/ref/SoftReference<Lcom/fasterxml/aalto/util/BufferRecycler;>;"
    if-eqz v0, :cond_0

    .line 193
    invoke-virtual {v0}, Ljava/lang/ref/SoftReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/fasterxml/aalto/util/BufferRecycler;

    iput-object v1, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    .line 195
    :cond_0
    iput-object p4, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mEncCtxt:Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;

    .line 196
    iput p5, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_flags:I

    .line 197
    iput p6, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_flagMods:I

    .line 198
    iput-object p7, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mReporter:Ljavax/xml/stream/XMLReporter;

    .line 199
    iput-object p8, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mResolver:Ljavax/xml/stream/XMLResolver;

    .line 200
    iput-object p9, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mCanonicalizer:Lcom/fasterxml/aalto/util/UriCanonicalizer;

    .line 201
    return-void
.end method

.method private createRecycler()Lcom/fasterxml/aalto/util/BufferRecycler;
    .locals 3

    .line 674
    new-instance v0, Lcom/fasterxml/aalto/util/BufferRecycler;

    invoke-direct {v0}, Lcom/fasterxml/aalto/util/BufferRecycler;-><init>()V

    .line 676
    .local v0, "recycler":Lcom/fasterxml/aalto/util/BufferRecycler;
    sget-object v1, Lcom/fasterxml/aalto/in/ReaderConfig;->_recyclerRef:Ljava/lang/ThreadLocal;

    new-instance v2, Ljava/lang/ref/SoftReference;

    invoke-direct {v2, v0}, Ljava/lang/ref/SoftReference;-><init>(Ljava/lang/Object;)V

    invoke-virtual {v1, v2}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    .line 677
    return-object v0
.end method


# virtual methods
.method public allocFullBBuffer(I)[B
    .locals 1
    .param p1, "minSize"    # I

    .line 654
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    if-eqz v0, :cond_0

    .line 655
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/util/BufferRecycler;->getFullBBuffer(I)[B

    move-result-object v0

    .line 656
    .local v0, "result":[B
    if-eqz v0, :cond_0

    .line 657
    return-object v0

    .line 660
    .end local v0    # "result":[B
    :cond_0
    new-array v0, p1, [B

    return-object v0
.end method

.method public allocFullCBuffer(I)[C
    .locals 1
    .param p1, "minSize"    # I

    .line 634
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    if-eqz v0, :cond_0

    .line 635
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/util/BufferRecycler;->getFullCBuffer(I)[C

    move-result-object v0

    .line 636
    .local v0, "result":[C
    if-eqz v0, :cond_0

    .line 637
    return-object v0

    .line 640
    .end local v0    # "result":[C
    :cond_0
    new-array v0, p1, [C

    return-object v0
.end method

.method public allocMediumCBuffer(I)[C
    .locals 1
    .param p1, "minSize"    # I

    .line 615
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    if-eqz v0, :cond_0

    .line 616
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/util/BufferRecycler;->getMediumCBuffer(I)[C

    move-result-object v0

    .line 617
    .local v0, "result":[C
    if-eqz v0, :cond_0

    .line 618
    return-object v0

    .line 621
    .end local v0    # "result":[C
    :cond_0
    new-array v0, p1, [C

    return-object v0
.end method

.method public allocSmallCBuffer(I)[C
    .locals 1
    .param p1, "minSize"    # I

    .line 594
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    if-eqz v0, :cond_0

    .line 595
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/util/BufferRecycler;->getSmallCBuffer(I)[C

    move-result-object v0

    .line 596
    .local v0, "result":[C
    if-eqz v0, :cond_0

    .line 597
    return-object v0

    .line 601
    .end local v0    # "result":[C
    :cond_0
    new-array v0, p1, [C

    return-object v0
.end method

.method public canonicalizeURI([CI)Ljava/lang/String;
    .locals 1
    .param p1, "buf"    # [C
    .param p2, "uriLen"    # I

    .line 583
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mCanonicalizer:Lcom/fasterxml/aalto/util/UriCanonicalizer;

    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/aalto/util/UriCanonicalizer;->canonicalizeURI([CI)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public configureForConvenience()V
    .locals 1

    .line 503
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->doCoalesceText(Z)V

    .line 513
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->doPreserveLocation(Z)V

    .line 514
    return-void
.end method

.method public configureForLowMemUsage()V
    .locals 1

    .line 550
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->doCoalesceText(Z)V

    .line 553
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->doPreserveLocation(Z)V

    .line 554
    return-void
.end method

.method public configureForRoundTripping()V
    .locals 1

    .line 567
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->doCoalesceText(Z)V

    .line 573
    return-void
.end method

.method public configureForSpeed()V
    .locals 1

    .line 527
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->doCoalesceText(Z)V

    .line 530
    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->doPreserveLocation(Z)V

    .line 535
    return-void
.end method

.method public configureForXmlConformance()V
    .locals 0

    .line 490
    return-void
.end method

.method public createNonShared(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/fasterxml/aalto/in/ReaderConfig;
    .locals 11
    .param p1, "publicId"    # Ljava/lang/String;
    .param p2, "systemId"    # Ljava/lang/String;
    .param p3, "extEnc"    # Ljava/lang/String;

    .line 310
    new-instance v10, Lcom/fasterxml/aalto/in/ReaderConfig;

    iget-object v4, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mEncCtxt:Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;

    iget v5, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_flags:I

    iget v6, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_flagMods:I

    iget-object v7, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mReporter:Ljavax/xml/stream/XMLReporter;

    iget-object v8, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mResolver:Ljavax/xml/stream/XMLResolver;

    iget-object v9, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mCanonicalizer:Lcom/fasterxml/aalto/util/UriCanonicalizer;

    move-object v0, v10

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    invoke-direct/range {v0 .. v9}, Lcom/fasterxml/aalto/in/ReaderConfig;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;IILjavax/xml/stream/XMLReporter;Ljavax/xml/stream/XMLResolver;Lcom/fasterxml/aalto/util/UriCanonicalizer;)V

    return-object v10
.end method

.method public doAutoCloseInput(Z)V
    .locals 1
    .param p1, "state"    # Z

    .line 275
    const/16 v0, 0x2000

    invoke-virtual {p0, v0, p1}, Lcom/fasterxml/aalto/in/ReaderConfig;->setFlag(IZ)V

    .line 276
    return-void
.end method

.method public doCoalesceText(Z)V
    .locals 1
    .param p1, "state"    # Z

    .line 269
    const/4 v0, 0x2

    invoke-virtual {p0, v0, p1}, Lcom/fasterxml/aalto/in/ReaderConfig;->setFlag(IZ)V

    .line 270
    return-void
.end method

.method public doParseLazily(Z)V
    .locals 1
    .param p1, "state"    # Z

    .line 283
    const/16 v0, 0x100

    invoke-virtual {p0, v0, p1}, Lcom/fasterxml/aalto/in/ReaderConfig;->setFlag(IZ)V

    .line 284
    return-void
.end method

.method public doPreserveLocation(Z)V
    .locals 1
    .param p1, "state"    # Z

    .line 279
    const/16 v0, 0x1000

    invoke-virtual {p0, v0, p1}, Lcom/fasterxml/aalto/in/ReaderConfig;->setFlag(IZ)V

    .line 280
    return-void
.end method

.method public doReportCData(Z)V
    .locals 1
    .param p1, "state"    # Z

    .line 287
    const/16 v0, 0x800

    invoke-virtual {p0, v0, p1}, Lcom/fasterxml/aalto/in/ReaderConfig;->setFlag(IZ)V

    .line 288
    return-void
.end method

.method public doRetainAttributeGeneralEntities(Z)V
    .locals 1
    .param p1, "state"    # Z

    .line 299
    const/16 v0, 0x4000

    invoke-virtual {p0, v0, p1}, Lcom/fasterxml/aalto/in/ReaderConfig;->setFlag(IZ)V

    .line 300
    return-void
.end method

.method protected findPropertyId(Ljava/lang/String;)I
    .locals 2
    .param p1, "propName"    # Ljava/lang/String;

    .line 333
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 334
    .local v0, "I":Ljava/lang/Integer;
    if-nez v0, :cond_0

    const/4 v1, -0x1

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v1

    :goto_0
    return v1
.end method

.method public freeFullBBuffer([B)V
    .locals 1
    .param p1, "buffer"    # [B

    .line 666
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    if-nez v0, :cond_0

    .line 667
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/ReaderConfig;->createRecycler()Lcom/fasterxml/aalto/util/BufferRecycler;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    .line 669
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/util/BufferRecycler;->returnFullBBuffer([B)V

    .line 670
    return-void
.end method

.method public freeFullCBuffer([C)V
    .locals 1
    .param p1, "buffer"    # [C

    .line 646
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    if-nez v0, :cond_0

    .line 647
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/ReaderConfig;->createRecycler()Lcom/fasterxml/aalto/util/BufferRecycler;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    .line 649
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/util/BufferRecycler;->returnFullCBuffer([C)V

    .line 650
    return-void
.end method

.method public freeMediumCBuffer([C)V
    .locals 1
    .param p1, "buffer"    # [C

    .line 626
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    if-nez v0, :cond_0

    .line 627
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/ReaderConfig;->createRecycler()Lcom/fasterxml/aalto/util/BufferRecycler;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    .line 629
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/util/BufferRecycler;->returnMediumCBuffer([C)V

    .line 630
    return-void
.end method

.method public freeSmallCBuffer([C)V
    .locals 1
    .param p1, "buffer"    # [C

    .line 607
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    if-nez v0, :cond_0

    .line 608
    invoke-direct {p0}, Lcom/fasterxml/aalto/in/ReaderConfig;->createRecycler()Lcom/fasterxml/aalto/util/BufferRecycler;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    .line 610
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/util/BufferRecycler;->returnSmallCBuffer([C)V

    .line 611
    return-void
.end method

.method public getActualEncoding()Ljava/lang/String;
    .locals 1

    .line 318
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mActualEncoding:Ljava/lang/String;

    return-object v0
.end method

.method public getBBSymbols()Lcom/fasterxml/aalto/in/ByteBasedPNameTable;
    .locals 3

    .line 688
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mActualEncoding:Ljava/lang/String;

    const-string v1, "UTF-8"

    if-ne v0, v1, :cond_0

    .line 689
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mEncCtxt:Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->getUtf8Symbols()Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    move-result-object v0

    return-object v0

    .line 691
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mActualEncoding:Ljava/lang/String;

    const-string v1, "ISO-8859-1"

    if-ne v0, v1, :cond_1

    .line 692
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mEncCtxt:Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->getLatin1Symbols()Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    move-result-object v0

    return-object v0

    .line 694
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mActualEncoding:Ljava/lang/String;

    const-string v1, "US-ASCII"

    if-ne v0, v1, :cond_2

    .line 695
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mEncCtxt:Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->getAsciiSymbols()Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    move-result-object v0

    return-object v0

    .line 697
    :cond_2
    new-instance v0, Ljava/lang/Error;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Internal error, unknown encoding \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mActualEncoding:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/Error;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public getCBSymbols()Lcom/fasterxml/aalto/in/CharBasedPNameTable;
    .locals 1

    .line 702
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mEncCtxt:Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->getSymbols()Lcom/fasterxml/aalto/in/CharBasedPNameTable;

    move-result-object v0

    return-object v0
.end method

.method public getCharTypes()Lcom/fasterxml/aalto/util/XmlCharTypes;
    .locals 3

    .line 725
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mActualEncoding:Ljava/lang/String;

    const-string v1, "UTF-8"

    if-ne v0, v1, :cond_0

    .line 726
    invoke-static {}, Lcom/fasterxml/aalto/in/InputCharTypes;->getUtf8CharTypes()Lcom/fasterxml/aalto/util/XmlCharTypes;

    move-result-object v0

    return-object v0

    .line 728
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mActualEncoding:Ljava/lang/String;

    const-string v1, "ISO-8859-1"

    if-ne v0, v1, :cond_1

    .line 729
    invoke-static {}, Lcom/fasterxml/aalto/in/InputCharTypes;->getLatin1CharTypes()Lcom/fasterxml/aalto/util/XmlCharTypes;

    move-result-object v0

    return-object v0

    .line 731
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mActualEncoding:Ljava/lang/String;

    const-string v1, "US-ASCII"

    if-ne v0, v1, :cond_2

    .line 732
    invoke-static {}, Lcom/fasterxml/aalto/in/InputCharTypes;->getAsciiCharTypes()Lcom/fasterxml/aalto/util/XmlCharTypes;

    move-result-object v0

    return-object v0

    .line 734
    :cond_2
    new-instance v0, Ljava/lang/Error;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Internal error, unknown encoding \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mActualEncoding:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/Error;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public getExternalEncoding()Ljava/lang/String;
    .locals 1

    .line 316
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mExtEncoding:Ljava/lang/String;

    return-object v0
.end method

.method public getIllegalCharHandler()Lcom/fasterxml/aalto/util/IllegalCharHandler;
    .locals 1

    .line 819
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->illegalCharHandler:Lcom/fasterxml/aalto/util/IllegalCharHandler;

    return-object v0
.end method

.method public final getProperty(Ljava/lang/String;Z)Ljava/lang/Object;
    .locals 4
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "isMandatory"    # Z

    .line 346
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 347
    .local v0, "ob":Ljava/lang/Object;
    if-nez v0, :cond_1

    .line 349
    sget-object v1, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    invoke-virtual {v1, p1}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 350
    const/4 v1, 0x0

    return-object v1

    .line 352
    :cond_0
    invoke-super {p0, p1, p2}, Lcom/fasterxml/aalto/impl/CommonConfig;->getProperty(Ljava/lang/String;Z)Ljava/lang/Object;

    move-result-object v1

    return-object v1

    .line 354
    :cond_1
    instance-of v1, v0, Ljava/lang/Boolean;

    if-eqz v1, :cond_2

    .line 355
    move-object v1, v0

    check-cast v1, Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    return-object v1

    .line 357
    :cond_2
    instance-of v1, v0, Ljava/lang/Integer;

    if-eqz v1, :cond_3

    .line 360
    move-object v1, v0

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    .line 361
    .local v1, "f":I
    invoke-virtual {p0, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->hasFlag(I)Z

    move-result v2

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    return-object v2

    .line 358
    .end local v1    # "f":I
    :cond_3
    new-instance v1, Ljava/lang/RuntimeException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Internal error: unrecognized property value type: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public getPublicId()Ljava/lang/String;
    .locals 1

    .line 454
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mPublicId:Ljava/lang/String;

    return-object v0
.end method

.method public getSystemId()Ljava/lang/String;
    .locals 1

    .line 455
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mSystemId:Ljava/lang/String;

    return-object v0
.end method

.method public getXMLReporter()Ljavax/xml/stream/XMLReporter;
    .locals 1

    .line 394
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mReporter:Ljavax/xml/stream/XMLReporter;

    return-object v0
.end method

.method public getXMLResolver()Ljavax/xml/stream/XMLResolver;
    .locals 1

    .line 395
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mResolver:Ljavax/xml/stream/XMLResolver;

    return-object v0
.end method

.method public getXmlDeclEncoding()Ljava/lang/String;
    .locals 1

    .line 460
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mXmlDeclEncoding:Ljava/lang/String;

    return-object v0
.end method

.method public getXmlDeclStandalone()I
    .locals 1

    .line 461
    iget v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mXmlDeclStandalone:I

    return v0
.end method

.method public getXmlDeclVersion()Ljava/lang/String;
    .locals 1

    .line 459
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mXmlDeclVersion:Ljava/lang/String;

    return-object v0
.end method

.method public hasInternNamesBeenEnabled()Z
    .locals 1

    .line 430
    const/16 v0, 0x200

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->hasExplicitFlag(I)Z

    move-result v0

    return v0
.end method

.method public hasInternNsURIsBeenEnabled()Z
    .locals 1

    .line 432
    const/16 v0, 0x400

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->hasExplicitFlag(I)Z

    move-result v0

    return v0
.end method

.method public isPropertySupported(Ljava/lang/String;)Z
    .locals 1
    .param p1, "propName"    # Ljava/lang/String;

    .line 390
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 391
    invoke-super {p0, p1}, Lcom/fasterxml/aalto/impl/CommonConfig;->isPropertySupported(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    .line 390
    :goto_1
    return v0
.end method

.method public isXml11()Z
    .locals 1

    .line 322
    const/4 v0, 0x0

    return v0
.end method

.method public setActualEncoding(Ljava/lang/String;)V
    .locals 0
    .param p1, "actualEnc"    # Ljava/lang/String;

    .line 212
    iput-object p1, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mActualEncoding:Ljava/lang/String;

    .line 213
    return-void
.end method

.method public setIllegalCharHandler(Lcom/fasterxml/aalto/util/IllegalCharHandler;)V
    .locals 0
    .param p1, "illegalCharHandler"    # Lcom/fasterxml/aalto/util/IllegalCharHandler;

    .line 815
    iput-object p1, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->illegalCharHandler:Lcom/fasterxml/aalto/util/IllegalCharHandler;

    .line 816
    return-void
.end method

.method public setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
    .locals 4
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 367
    sget-object v0, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 368
    .local v0, "ob":Ljava/lang/Object;
    const/4 v1, 0x0

    if-nez v0, :cond_1

    .line 370
    sget-object v2, Lcom/fasterxml/aalto/in/ReaderConfig;->sProperties:Ljava/util/HashMap;

    invoke-virtual {v2, p1}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 371
    return v1

    .line 373
    :cond_0
    invoke-super {p0, p1, p2}, Lcom/fasterxml/aalto/impl/CommonConfig;->setProperty(Ljava/lang/String;Ljava/lang/Object;)Z

    move-result v1

    return v1

    .line 375
    :cond_1
    instance-of v2, v0, Ljava/lang/Boolean;

    if-eqz v2, :cond_2

    .line 376
    return v1

    .line 378
    :cond_2
    instance-of v1, v0, Ljava/lang/Integer;

    if-eqz v1, :cond_3

    .line 381
    move-object v1, v0

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    .line 382
    .local v1, "f":I
    move-object v2, p2

    check-cast v2, Ljava/lang/Boolean;

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    .line 383
    .local v2, "state":Z
    invoke-virtual {p0, v1, v2}, Lcom/fasterxml/aalto/in/ReaderConfig;->setFlag(IZ)V

    .line 384
    const/4 v3, 0x1

    return v3

    .line 379
    .end local v1    # "f":I
    .end local v2    # "state":Z
    :cond_3
    new-instance v1, Ljava/lang/RuntimeException;

    const-string v2, "Internal error"

    invoke-direct {v1, v2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public setXMLReporter(Ljavax/xml/stream/XMLReporter;)V
    .locals 0
    .param p1, "r"    # Ljavax/xml/stream/XMLReporter;

    .line 259
    iput-object p1, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mReporter:Ljavax/xml/stream/XMLReporter;

    .line 260
    return-void
.end method

.method public setXMLResolver(Ljavax/xml/stream/XMLResolver;)V
    .locals 0
    .param p1, "r"    # Ljavax/xml/stream/XMLResolver;

    .line 263
    iput-object p1, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mResolver:Ljavax/xml/stream/XMLResolver;

    .line 264
    return-void
.end method

.method public setXmlDeclInfo(ILjava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "version"    # I
    .param p2, "xmlDeclEnc"    # Ljava/lang/String;
    .param p3, "standalone"    # Ljava/lang/String;

    .line 217
    const/16 v0, 0x100

    if-ne p1, v0, :cond_0

    .line 218
    const-string v0, "1.0"

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mXmlDeclVersion:Ljava/lang/String;

    goto :goto_0

    .line 219
    :cond_0
    const/16 v0, 0x110

    if-ne p1, v0, :cond_1

    .line 220
    const-string v0, "1.1"

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mXmlDeclVersion:Ljava/lang/String;

    goto :goto_0

    .line 222
    :cond_1
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mXmlDeclVersion:Ljava/lang/String;

    .line 224
    :goto_0
    iput-object p2, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mXmlDeclEncoding:Ljava/lang/String;

    .line 225
    const-string/jumbo v0, "yes"

    if-ne p3, v0, :cond_2

    .line 226
    const/4 v0, 0x1

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mXmlDeclStandalone:I

    goto :goto_1

    .line 227
    :cond_2
    const-string v0, "no"

    if-ne p3, v0, :cond_3

    .line 228
    const/4 v0, 0x2

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mXmlDeclStandalone:I

    goto :goto_1

    .line 230
    :cond_3
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mXmlDeclStandalone:I

    .line 232
    :goto_1
    return-void
.end method

.method public final setXmlEncoding(Ljava/lang/String;)V
    .locals 0
    .param p1, "enc"    # Ljava/lang/String;

    .line 239
    iput-object p1, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mXmlDeclEncoding:Ljava/lang/String;

    .line 240
    return-void
.end method

.method public final setXmlStandalone(Ljava/lang/Boolean;)V
    .locals 1
    .param p1, "b"    # Ljava/lang/Boolean;

    .line 243
    if-nez p1, :cond_0

    .line 244
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mXmlDeclStandalone:I

    goto :goto_1

    .line 246
    :cond_0
    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x2

    :goto_0
    iput v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mXmlDeclStandalone:I

    .line 248
    :goto_1
    return-void
.end method

.method public final setXmlVersion(Ljava/lang/String;)V
    .locals 0
    .param p1, "version"    # Ljava/lang/String;

    .line 235
    iput-object p1, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mXmlDeclVersion:Ljava/lang/String;

    .line 236
    return-void
.end method

.method public updateBBSymbols(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;)V
    .locals 3
    .param p1, "sym"    # Lcom/fasterxml/aalto/in/ByteBasedPNameTable;

    .line 707
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mActualEncoding:Ljava/lang/String;

    const-string v1, "UTF-8"

    if-ne v0, v1, :cond_0

    .line 708
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mEncCtxt:Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->updateUtf8Symbols(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;)V

    goto :goto_0

    .line 709
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mActualEncoding:Ljava/lang/String;

    const-string v1, "ISO-8859-1"

    if-ne v0, v1, :cond_1

    .line 710
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mEncCtxt:Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->updateLatin1Symbols(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;)V

    goto :goto_0

    .line 711
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mActualEncoding:Ljava/lang/String;

    const-string v1, "US-ASCII"

    if-ne v0, v1, :cond_2

    .line 712
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mEncCtxt:Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->updateAsciiSymbols(Lcom/fasterxml/aalto/in/ByteBasedPNameTable;)V

    .line 716
    :goto_0
    return-void

    .line 714
    :cond_2
    new-instance v0, Ljava/lang/Error;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Internal error, unknown encoding \'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mActualEncoding:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\'"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/Error;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public updateCBSymbols(Lcom/fasterxml/aalto/in/CharBasedPNameTable;)V
    .locals 1
    .param p1, "sym"    # Lcom/fasterxml/aalto/in/CharBasedPNameTable;

    .line 720
    iget-object v0, p0, Lcom/fasterxml/aalto/in/ReaderConfig;->mEncCtxt:Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/in/ReaderConfig$EncodingContext;->updateSymbols(Lcom/fasterxml/aalto/in/CharBasedPNameTable;)V

    .line 721
    return-void
.end method

.method public willAutoCloseInput()Z
    .locals 1

    .line 426
    const/16 v0, 0x2000

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->hasFlag(I)Z

    move-result v0

    return v0
.end method

.method public willCoalesceText()Z
    .locals 1

    .line 405
    const/4 v0, 0x2

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->hasFlag(I)Z

    move-result v0

    return v0
.end method

.method public willExpandEntities()Z
    .locals 1

    .line 401
    const/16 v0, 0x10

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->hasFlag(I)Z

    move-result v0

    return v0
.end method

.method public willInternNames()Z
    .locals 1

    .line 418
    const/16 v0, 0x200

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->hasFlag(I)Z

    move-result v0

    return v0
.end method

.method public willInternNsURIs()Z
    .locals 1

    .line 420
    const/16 v0, 0x400

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->hasFlag(I)Z

    move-result v0

    return v0
.end method

.method public willParseLazily()Z
    .locals 1

    .line 415
    const/16 v0, 0x100

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->hasFlag(I)Z

    move-result v0

    return v0
.end method

.method public willPreserveLocation()Z
    .locals 1

    .line 424
    const/16 v0, 0x1000

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->hasFlag(I)Z

    move-result v0

    return v0
.end method

.method public willReportCData()Z
    .locals 1

    .line 422
    const/16 v0, 0x800

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->hasFlag(I)Z

    move-result v0

    return v0
.end method

.method public willRetainAttributeGeneralEntities()Z
    .locals 1

    .line 444
    const/16 v0, 0x4000

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->hasFlag(I)Z

    move-result v0

    return v0
.end method

.method public willSupportNamespaces()Z
    .locals 1

    .line 409
    const/4 v0, 0x1

    return v0
.end method
