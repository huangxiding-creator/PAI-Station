.class public final Lcom/fasterxml/aalto/out/WriterConfig;
.super Lcom/fasterxml/aalto/impl/CommonConfig;
.source "WriterConfig.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;
    }
.end annotation


# static fields
.field protected static final DEFAULT_AUTOMATIC_NS_PREFIX:Ljava/lang/String; = "ans"

.field static final DEFAULT_FLAGS:I = 0x20

.field static final F_AUTO_CLOSE_OUTPUT:I = 0x10

.field static final F_AUTO_EMPTY_ELEMS:I = 0x40

.field static final F_NS_AWARE:I = 0x20

.field static final F_NS_REPAIRING:I = 0x1

.field static final PROP_AUTO_NS_PREFIX:I = -0x2

.field static final mRecyclerRef:Ljava/lang/ThreadLocal;
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
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field _currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

.field private _encoding:Ljava/lang/String;

.field private final _encodingContext:Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;

.field private _propAutoNsPrefix:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .line 44
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/fasterxml/aalto/out/WriterConfig;->sProperties:Ljava/util/HashMap;

    .line 45
    sget-object v0, Lcom/fasterxml/aalto/out/WriterConfig;->sProperties:Ljava/util/HashMap;

    const/4 v1, 0x1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "javax.xml.stream.isRepairingNamespaces"

    invoke-virtual {v0, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 50
    sget-object v0, Lcom/fasterxml/aalto/out/WriterConfig;->sProperties:Ljava/util/HashMap;

    const/16 v1, 0x20

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "javax.xml.stream.isNamespaceAware"

    invoke-virtual {v0, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 51
    sget-object v0, Lcom/fasterxml/aalto/out/WriterConfig;->sProperties:Ljava/util/HashMap;

    const-string v1, "javax.xml.stream.reporter"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 55
    sget-object v0, Lcom/fasterxml/aalto/out/WriterConfig;->sProperties:Ljava/util/HashMap;

    const/16 v1, 0x10

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v3, "org.codehaus.stax2.autoCloseOutput"

    invoke-virtual {v0, v3, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 57
    sget-object v0, Lcom/fasterxml/aalto/out/WriterConfig;->sProperties:Ljava/util/HashMap;

    const/16 v1, 0x40

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v3, "org.codehaus.stax2.automaticEmptyElements"

    invoke-virtual {v0, v3, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 58
    sget-object v0, Lcom/fasterxml/aalto/out/WriterConfig;->sProperties:Ljava/util/HashMap;

    const/4 v1, -0x2

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v3, "org.codehaus.stax2.automaticNsPrefix"

    invoke-virtual {v0, v3, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 59
    sget-object v0, Lcom/fasterxml/aalto/out/WriterConfig;->sProperties:Ljava/util/HashMap;

    const-string v1, "org.codehaus.stax2.textEscaper"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 60
    sget-object v0, Lcom/fasterxml/aalto/out/WriterConfig;->sProperties:Ljava/util/HashMap;

    const-string v1, "org.codehaus.stax2.attrValueEscaper"

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 101
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Lcom/fasterxml/aalto/out/WriterConfig;->mRecyclerRef:Ljava/lang/ThreadLocal;

    return-void
.end method

.method public constructor <init>()V
    .locals 6

    .line 143
    new-instance v4, Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;

    invoke-direct {v4}, Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;-><init>()V

    const-string v5, "ans"

    const/4 v1, 0x0

    const/16 v2, 0x20

    const/4 v3, 0x0

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/fasterxml/aalto/out/WriterConfig;-><init>(Ljava/lang/String;IILcom/fasterxml/aalto/out/WriterConfig$EncodingContext;Ljava/lang/String;)V

    .line 144
    return-void
.end method

.method private constructor <init>(Ljava/lang/String;IILcom/fasterxml/aalto/out/WriterConfig$EncodingContext;Ljava/lang/String;)V
    .locals 2
    .param p1, "encoding"    # Ljava/lang/String;
    .param p2, "flags"    # I
    .param p3, "flagMods"    # I
    .param p4, "encCtxt"    # Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;
    .param p5, "autoNsPrefix"    # Ljava/lang/String;

    .line 122
    invoke-direct {p0, p2, p3}, Lcom/fasterxml/aalto/impl/CommonConfig;-><init>(II)V

    .line 110
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    .line 123
    iput-object p1, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_encoding:Ljava/lang/String;

    .line 124
    iput-object p4, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_encodingContext:Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;

    .line 132
    sget-object v0, Lcom/fasterxml/aalto/out/WriterConfig;->mRecyclerRef:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ref/SoftReference;

    .line 133
    .local v0, "ref":Ljava/lang/ref/SoftReference;, "Ljava/lang/ref/SoftReference<Lcom/fasterxml/aalto/util/BufferRecycler;>;"
    if-eqz v0, :cond_0

    .line 134
    invoke-virtual {v0}, Ljava/lang/ref/SoftReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/fasterxml/aalto/util/BufferRecycler;

    iput-object v1, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    .line 136
    :cond_0
    iput p2, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_flags:I

    .line 137
    iput p3, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_flagMods:I

    .line 138
    iput-object p5, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_propAutoNsPrefix:Ljava/lang/String;

    .line 139
    return-void
.end method

.method private createRecycler()Lcom/fasterxml/aalto/util/BufferRecycler;
    .locals 3

    .line 455
    new-instance v0, Lcom/fasterxml/aalto/util/BufferRecycler;

    invoke-direct {v0}, Lcom/fasterxml/aalto/util/BufferRecycler;-><init>()V

    .line 457
    .local v0, "recycler":Lcom/fasterxml/aalto/util/BufferRecycler;
    sget-object v1, Lcom/fasterxml/aalto/out/WriterConfig;->mRecyclerRef:Ljava/lang/ThreadLocal;

    new-instance v2, Ljava/lang/ref/SoftReference;

    invoke-direct {v2, v0}, Ljava/lang/ref/SoftReference;-><init>(Ljava/lang/Object;)V

    invoke-virtual {v1, v2}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    .line 458
    return-object v0
.end method


# virtual methods
.method public allocFullBBuffer(I)[B
    .locals 1
    .param p1, "minSize"    # I

    .line 435
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    if-eqz v0, :cond_0

    .line 436
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/util/BufferRecycler;->getFullBBuffer(I)[B

    move-result-object v0

    .line 437
    .local v0, "result":[B
    if-eqz v0, :cond_0

    .line 438
    return-object v0

    .line 441
    .end local v0    # "result":[B
    :cond_0
    new-array v0, p1, [B

    return-object v0
.end method

.method public allocFullCBuffer(I)[C
    .locals 1
    .param p1, "minSize"    # I

    .line 415
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    if-eqz v0, :cond_0

    .line 416
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/util/BufferRecycler;->getFullCBuffer(I)[C

    move-result-object v0

    .line 417
    .local v0, "result":[C
    if-eqz v0, :cond_0

    .line 418
    return-object v0

    .line 421
    .end local v0    # "result":[C
    :cond_0
    new-array v0, p1, [C

    return-object v0
.end method

.method public allocMediumCBuffer(I)[C
    .locals 1
    .param p1, "minSize"    # I

    .line 396
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    if-eqz v0, :cond_0

    .line 397
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/util/BufferRecycler;->getMediumCBuffer(I)[C

    move-result-object v0

    .line 398
    .local v0, "result":[C
    if-eqz v0, :cond_0

    .line 399
    return-object v0

    .line 402
    .end local v0    # "result":[C
    :cond_0
    new-array v0, p1, [C

    return-object v0
.end method

.method public configureForRobustness()V
    .locals 0

    .line 332
    return-void
.end method

.method public configureForSpeed()V
    .locals 0

    .line 350
    return-void
.end method

.method public configureForXmlConformance()V
    .locals 0

    .line 319
    return-void
.end method

.method public createNonShared()Lcom/fasterxml/aalto/out/WriterConfig;
    .locals 7

    .line 170
    new-instance v6, Lcom/fasterxml/aalto/out/WriterConfig;

    iget-object v1, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_encoding:Ljava/lang/String;

    iget v2, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_flags:I

    iget v3, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_flagMods:I

    iget-object v4, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_encodingContext:Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;

    iget-object v5, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_propAutoNsPrefix:Ljava/lang/String;

    move-object v0, v6

    invoke-direct/range {v0 .. v5}, Lcom/fasterxml/aalto/out/WriterConfig;-><init>(Ljava/lang/String;IILcom/fasterxml/aalto/out/WriterConfig$EncodingContext;Ljava/lang/String;)V

    return-object v6
.end method

.method public doAutoCloseOutput(Z)V
    .locals 1
    .param p1, "state"    # Z

    .line 154
    const/16 v0, 0x10

    invoke-virtual {p0, v0, p1}, Lcom/fasterxml/aalto/out/WriterConfig;->setFlag(IZ)V

    .line 155
    return-void
.end method

.method public enableXml11()V
    .locals 0

    .line 160
    return-void
.end method

.method public freeFullBBuffer([B)V
    .locals 1
    .param p1, "buffer"    # [B

    .line 447
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    if-nez v0, :cond_0

    .line 448
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/WriterConfig;->createRecycler()Lcom/fasterxml/aalto/util/BufferRecycler;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    .line 450
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/util/BufferRecycler;->returnFullBBuffer([B)V

    .line 451
    return-void
.end method

.method public freeFullCBuffer([C)V
    .locals 1
    .param p1, "buffer"    # [C

    .line 427
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    if-nez v0, :cond_0

    .line 428
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/WriterConfig;->createRecycler()Lcom/fasterxml/aalto/util/BufferRecycler;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    .line 430
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/util/BufferRecycler;->returnFullCBuffer([C)V

    .line 431
    return-void
.end method

.method public freeMediumCBuffer([C)V
    .locals 1
    .param p1, "buffer"    # [C

    .line 407
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    if-nez v0, :cond_0

    .line 408
    invoke-direct {p0}, Lcom/fasterxml/aalto/out/WriterConfig;->createRecycler()Lcom/fasterxml/aalto/util/BufferRecycler;

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    .line 410
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_currRecycler:Lcom/fasterxml/aalto/util/BufferRecycler;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/util/BufferRecycler;->returnMediumCBuffer([C)V

    .line 411
    return-void
.end method

.method public getActualEncoding()Ljava/lang/String;
    .locals 1

    .line 189
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_encoding:Ljava/lang/String;

    return-object v0
.end method

.method public getAsciiSymbols(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;
    .locals 1
    .param p1, "f"    # Lcom/fasterxml/aalto/out/WNameFactory;

    .line 479
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_encodingContext:Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;->getAsciiSymbols(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;

    move-result-object v0

    return-object v0
.end method

.method public getAutomaticNsPrefix()Ljava/lang/String;
    .locals 1

    .line 301
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_propAutoNsPrefix:Ljava/lang/String;

    return-object v0
.end method

.method public getCharSymbols(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;
    .locals 1
    .param p1, "f"    # Lcom/fasterxml/aalto/out/WNameFactory;

    .line 484
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_encodingContext:Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;->getCharSymbols(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;

    move-result-object v0

    return-object v0
.end method

.method public getExternalEncoding()Ljava/lang/String;
    .locals 1

    .line 185
    invoke-virtual {p0}, Lcom/fasterxml/aalto/out/WriterConfig;->getActualEncoding()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getLatin1Symbols(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;
    .locals 1
    .param p1, "f"    # Lcom/fasterxml/aalto/out/WNameFactory;

    .line 474
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_encodingContext:Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;->getLatin1Symbols(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;

    move-result-object v0

    return-object v0
.end method

.method public getPreferredEncoding()Ljava/lang/String;
    .locals 1

    .line 196
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_encoding:Ljava/lang/String;

    return-object v0
.end method

.method public getProperty(Ljava/lang/String;Z)Ljava/lang/Object;
    .locals 3
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "isMandatory"    # Z

    .line 208
    sget-object v0, Lcom/fasterxml/aalto/out/WriterConfig;->sProperties:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 209
    .local v0, "I":Ljava/lang/Integer;
    const/4 v1, 0x0

    if-nez v0, :cond_1

    .line 211
    sget-object v2, Lcom/fasterxml/aalto/out/WriterConfig;->sProperties:Ljava/util/HashMap;

    invoke-virtual {v2, p1}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 212
    return-object v1

    .line 214
    :cond_0
    invoke-super {p0, p1, p2}, Lcom/fasterxml/aalto/impl/CommonConfig;->getProperty(Ljava/lang/String;Z)Ljava/lang/Object;

    move-result-object v1

    return-object v1

    .line 216
    :cond_1
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v2

    .line 218
    .local v2, "f":I
    if-ltz v2, :cond_2

    .line 219
    invoke-virtual {p0, v2}, Lcom/fasterxml/aalto/out/WriterConfig;->hasFlag(I)Z

    move-result v1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    return-object v1

    .line 221
    :cond_2
    packed-switch v2, :pswitch_data_0

    .line 227
    return-object v1

    .line 223
    :pswitch_0
    iget-object v1, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_propAutoNsPrefix:Ljava/lang/String;

    return-object v1

    nop

    :pswitch_data_0
    .packed-switch -0x2
        :pswitch_0
    .end packed-switch
.end method

.method public getUtf8Symbols(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;
    .locals 1
    .param p1, "f"    # Lcom/fasterxml/aalto/out/WNameFactory;

    .line 469
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_encodingContext:Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;

    invoke-virtual {v0, p1}, Lcom/fasterxml/aalto/out/WriterConfig$EncodingContext;->getUtf8Symbols(Lcom/fasterxml/aalto/out/WNameFactory;)Lcom/fasterxml/aalto/out/WNameTable;

    move-result-object v0

    return-object v0
.end method

.method public isNamespaceAware()Z
    .locals 1

    .line 286
    const/16 v0, 0x20

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/WriterConfig;->hasFlag(I)Z

    move-result v0

    return v0
.end method

.method public isPropertySupported(Ljava/lang/String;)Z
    .locals 1
    .param p1, "propName"    # Ljava/lang/String;

    .line 268
    sget-object v0, Lcom/fasterxml/aalto/out/WriterConfig;->sProperties:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 269
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

    .line 268
    :goto_1
    return v0
.end method

.method public isXml11()Z
    .locals 1

    .line 176
    const/4 v0, 0x0

    return v0
.end method

.method public setActualEncodingIfNotSet(Ljava/lang/String;)V
    .locals 1
    .param p1, "enc"    # Ljava/lang/String;

    .line 148
    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_encoding:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_encoding:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_1

    .line 149
    :cond_0
    iput-object p1, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_encoding:Ljava/lang/String;

    .line 151
    :cond_1
    return-void
.end method

.method public setProperty(Ljava/lang/String;Ljava/lang/Object;)Z
    .locals 6
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 233
    sget-object v0, Lcom/fasterxml/aalto/out/WriterConfig;->sProperties:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 234
    .local v0, "I":Ljava/lang/Integer;
    const/4 v1, 0x0

    if-nez v0, :cond_1

    .line 236
    sget-object v2, Lcom/fasterxml/aalto/out/WriterConfig;->sProperties:Ljava/util/HashMap;

    invoke-virtual {v2, p1}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 237
    return v1

    .line 239
    :cond_0
    invoke-super {p0, p1, p2}, Lcom/fasterxml/aalto/impl/CommonConfig;->setProperty(Ljava/lang/String;Ljava/lang/Object;)Z

    move-result v1

    return v1

    .line 241
    :cond_1
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v2

    .line 243
    .local v2, "f":I
    const/4 v3, 0x1

    if-ltz v2, :cond_3

    .line 244
    move-object v4, p2

    check-cast v4, Ljava/lang/Boolean;

    invoke-virtual {v4}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v4

    .line 246
    .local v4, "state":Z
    const/16 v5, 0x20

    if-ne v2, v5, :cond_2

    .line 247
    if-nez v4, :cond_2

    .line 249
    return v1

    .line 252
    :cond_2
    invoke-virtual {p0, v2, v4}, Lcom/fasterxml/aalto/out/WriterConfig;->setFlag(IZ)V

    .line 253
    return v3

    .line 256
    .end local v4    # "state":Z
    :cond_3
    packed-switch v2, :pswitch_data_0

    .line 262
    return v1

    .line 258
    :pswitch_0
    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/out/WriterConfig;->_propAutoNsPrefix:Ljava/lang/String;

    .line 259
    return v3

    nop

    :pswitch_data_0
    .packed-switch -0x2
        :pswitch_0
    .end packed-switch
.end method

.method public willAutoCloseOutput()Z
    .locals 1

    .line 292
    const/16 v0, 0x10

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/WriterConfig;->hasFlag(I)Z

    move-result v0

    return v0
.end method

.method public willCheckAttributes()Z
    .locals 1

    .line 375
    const/4 v0, 0x0

    return v0
.end method

.method public willCheckContent()Z
    .locals 1

    .line 365
    const/4 v0, 0x1

    return v0
.end method

.method public willCheckNames()Z
    .locals 1

    .line 370
    const/4 v0, 0x0

    return v0
.end method

.method public willCheckStructure()Z
    .locals 1

    .line 360
    const/4 v0, 0x1

    return v0
.end method

.method public willEscapeCR()Z
    .locals 1

    .line 385
    const/4 v0, 0x1

    return v0
.end method

.method public willFixContent()Z
    .locals 1

    .line 380
    const/4 v0, 0x1

    return v0
.end method

.method public willRepairNamespaces()Z
    .locals 1

    .line 281
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/out/WriterConfig;->hasFlag(I)Z

    move-result v0

    return v0
.end method
