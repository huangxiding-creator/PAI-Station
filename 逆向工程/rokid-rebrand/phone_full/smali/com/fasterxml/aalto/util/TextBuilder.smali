.class public final Lcom/fasterxml/aalto/util/TextBuilder;
.super Ljava/lang/Object;
.source "TextBuilder.java"


# static fields
.field static final DEF_INITIAL_BUFFER_SIZE:I = 0x1f4

.field static final INT_SPACE:I = 0x20

.field public static final MAX_INDENT_SPACES:I = 0x20

.field public static final MAX_INDENT_TABS:I = 0x8

.field static final MAX_SEGMENT_LENGTH:I = 0x40000

.field private static final sIndSpaces:Ljava/lang/String; = "\n                                 "

.field private static final sIndSpacesArray:[C

.field private static final sIndSpacesStrings:[Ljava/lang/String;

.field private static final sIndTabs:Ljava/lang/String; = "\n\t\t\t\t\t\t\t\t\t"

.field private static final sIndTabsArray:[C

.field private static final sIndTabsStrings:[Ljava/lang/String;

.field static final sNoChars:[C


# instance fields
.field private final _config:Lcom/fasterxml/aalto/in/ReaderConfig;

.field private _currentSegment:[C

.field private _currentSize:I

.field private _decodeBuffer:[C

.field private _decodeEnd:I

.field private _decodePtr:I

.field private _isIndentation:Z

.field private _resultArray:[C

.field private _resultLen:I

.field private _resultString:Ljava/lang/String;

.field private _segmentSize:I

.field private _segments:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "[C>;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 26
    const/4 v0, 0x0

    new-array v0, v0, [C

    sput-object v0, Lcom/fasterxml/aalto/util/TextBuilder;->sNoChars:[C

    .line 115
    const-string v0, "\n                                 "

    invoke-virtual {v0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v0

    sput-object v0, Lcom/fasterxml/aalto/util/TextBuilder;->sIndSpacesArray:[C

    .line 116
    sget-object v0, Lcom/fasterxml/aalto/util/TextBuilder;->sIndSpacesArray:[C

    array-length v0, v0

    new-array v0, v0, [Ljava/lang/String;

    sput-object v0, Lcom/fasterxml/aalto/util/TextBuilder;->sIndSpacesStrings:[Ljava/lang/String;

    .line 121
    const-string v0, "\n\t\t\t\t\t\t\t\t\t"

    invoke-virtual {v0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v0

    sput-object v0, Lcom/fasterxml/aalto/util/TextBuilder;->sIndTabsArray:[C

    .line 122
    sget-object v0, Lcom/fasterxml/aalto/util/TextBuilder;->sIndTabsArray:[C

    array-length v0, v0

    new-array v0, v0, [Ljava/lang/String;

    sput-object v0, Lcom/fasterxml/aalto/util/TextBuilder;->sIndTabsStrings:[Ljava/lang/String;

    return-void
.end method

.method private constructor <init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V
    .locals 1
    .param p1, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;

    .line 131
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 104
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_isIndentation:Z

    .line 132
    iput-object p1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    .line 133
    return-void
.end method

.method private final allocBuffer(I)[C
    .locals 3
    .param p1, "minNeeded"    # I

    .line 848
    const/16 v0, 0x1f4

    invoke-static {v0, p1}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 849
    .local v0, "size":I
    const/4 v1, 0x0

    .line 850
    .local v1, "buf":[C
    iget-object v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    if-eqz v2, :cond_0

    .line 851
    iget-object v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v2, v0}, Lcom/fasterxml/aalto/in/ReaderConfig;->allocMediumCBuffer(I)[C

    move-result-object v1

    .line 852
    if-eqz v1, :cond_0

    .line 853
    return-object v1

    .line 856
    :cond_0
    new-array v2, v0, [C

    return-object v2
.end method

.method private buildResultArray()[C
    .locals 8

    .line 881
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultString:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 882
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultString:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v0

    return-object v0

    .line 885
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/util/TextBuilder;->size()I

    move-result v0

    .line 886
    .local v0, "size":I
    const/4 v1, 0x1

    if-ge v0, v1, :cond_1

    .line 887
    sget-object v1, Lcom/fasterxml/aalto/util/TextBuilder;->sNoChars:[C

    return-object v1

    .line 889
    :cond_1
    const/4 v1, 0x0

    .line 890
    .local v1, "offset":I
    new-array v2, v0, [C

    .line 891
    .local v2, "result":[C
    iget-object v3, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    const/4 v4, 0x0

    if-eqz v3, :cond_2

    .line 892
    const/4 v3, 0x0

    .local v3, "i":I
    iget-object v5, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    .local v5, "len":I
    :goto_0
    if-ge v3, v5, :cond_2

    .line 893
    iget-object v6, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v6, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, [C

    .line 894
    .local v6, "curr":[C
    array-length v7, v6

    .line 895
    .local v7, "currLen":I
    invoke-static {v6, v4, v2, v1, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 896
    add-int/2addr v1, v7

    .line 892
    .end local v6    # "curr":[C
    .end local v7    # "currLen":I
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 899
    .end local v3    # "i":I
    .end local v5    # "len":I
    :cond_2
    iget-object v3, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    iget v5, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    invoke-static {v3, v4, v2, v1, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 900
    return-object v2
.end method

.method private calcNewSize(I)I
    .locals 3
    .param p1, "latestSize"    # I

    .line 717
    const/16 v0, 0x1f40

    if-ge p1, v0, :cond_0

    move v0, p1

    goto :goto_0

    :cond_0
    shr-int/lit8 v0, p1, 0x1

    .line 718
    .local v0, "incr":I
    :goto_0
    add-int v1, p1, v0

    .line 720
    .local v1, "size":I
    const/high16 v2, 0x40000

    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v2

    return v2
.end method

.method public static createRecyclableBuffer(Lcom/fasterxml/aalto/in/ReaderConfig;)Lcom/fasterxml/aalto/util/TextBuilder;
    .locals 1
    .param p0, "cfg"    # Lcom/fasterxml/aalto/in/ReaderConfig;

    .line 137
    new-instance v0, Lcom/fasterxml/aalto/util/TextBuilder;

    invoke-direct {v0, p0}, Lcom/fasterxml/aalto/util/TextBuilder;-><init>(Lcom/fasterxml/aalto/in/ReaderConfig;)V

    return-object v0
.end method

.method private expand(I)V
    .locals 4
    .param p1, "roomNeeded"    # I

    .line 866
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    if-nez v0, :cond_0

    .line 867
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    .line 869
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    .line 870
    .local v0, "curr":[C
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 871
    array-length v1, v0

    .line 872
    .local v1, "oldLen":I
    iget v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segmentSize:I

    add-int/2addr v2, v1

    iput v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segmentSize:I

    .line 873
    invoke-direct {p0, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->calcNewSize(I)I

    move-result v2

    invoke-static {p1, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    .line 874
    .local v2, "newSize":I
    new-array v0, v2, [C

    .line 875
    const/4 v3, 0x0

    iput v3, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    .line 876
    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    .line 877
    return-void
.end method

.method private final resetForDecode()V
    .locals 1

    .line 806
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_decodePtr:I

    .line 807
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 817
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/util/TextBuilder;->contentsAsArray()[C

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_decodeBuffer:[C

    .line 818
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_decodeBuffer:[C

    array-length v0, v0

    iput v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_decodeEnd:I

    goto :goto_1

    .line 808
    :cond_1
    :goto_0
    iget-boolean v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_isIndentation:Z

    if-eqz v0, :cond_2

    .line 809
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_decodeBuffer:[C

    .line 810
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    array-length v0, v0

    iput v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_decodeEnd:I

    goto :goto_1

    .line 812
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_decodeBuffer:[C

    .line 813
    iget v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    iput v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_decodeEnd:I

    .line 820
    :goto_1
    return-void
.end method


# virtual methods
.method public append(C)V
    .locals 3
    .param p1, "c"    # C

    .line 615
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultString:Ljava/lang/String;

    .line 616
    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    .line 618
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    .line 619
    .local v0, "curr":[C
    iget v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    array-length v2, v0

    if-lt v1, v2, :cond_0

    .line 620
    const/4 v1, 0x1

    invoke-direct {p0, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->expand(I)V

    .line 622
    :cond_0
    iget v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    aput-char p1, v0, v1

    .line 623
    return-void
.end method

.method public append(Ljava/lang/String;)V
    .locals 6
    .param p1, "str"    # Ljava/lang/String;

    .line 661
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultString:Ljava/lang/String;

    .line 662
    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    .line 664
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 666
    .local v0, "len":I
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    .line 667
    .local v1, "curr":[C
    array-length v2, v1

    iget v3, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    sub-int/2addr v2, v3

    .line 668
    .local v2, "max":I
    const/4 v3, 0x0

    if-lt v2, v0, :cond_0

    .line 669
    iget v4, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    invoke-virtual {p1, v3, v0, v1, v4}, Ljava/lang/String;->getChars(II[CI)V

    .line 670
    iget v3, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    add-int/2addr v3, v0

    iput v3, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    goto :goto_0

    .line 673
    :cond_0
    if-lez v2, :cond_1

    .line 674
    iget v4, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    invoke-virtual {p1, v3, v2, v1, v4}, Ljava/lang/String;->getChars(II[CI)V

    .line 675
    sub-int/2addr v0, v2

    .line 680
    :cond_1
    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/util/TextBuilder;->expand(I)V

    .line 681
    add-int v4, v2, v0

    iget-object v5, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    invoke-virtual {p1, v2, v4, v5, v3}, Ljava/lang/String;->getChars(II[CI)V

    .line 682
    iput v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    .line 684
    :goto_0
    return-void
.end method

.method public append([CII)V
    .locals 4
    .param p1, "c"    # [C
    .param p2, "start"    # I
    .param p3, "len"    # I

    .line 633
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultString:Ljava/lang/String;

    .line 634
    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    .line 637
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    .line 638
    .local v0, "curr":[C
    array-length v1, v0

    iget v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    sub-int/2addr v1, v2

    .line 640
    .local v1, "max":I
    if-lt v1, p3, :cond_0

    .line 641
    iget v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    invoke-static {p1, p2, v0, v2, p3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 642
    iget v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    add-int/2addr v2, p3

    iput v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    goto :goto_0

    .line 645
    :cond_0
    if-lez v1, :cond_1

    .line 646
    iget v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    invoke-static {p1, p2, v0, v2, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 647
    add-int/2addr p2, v1

    .line 648
    sub-int/2addr p3, v1

    .line 653
    :cond_1
    invoke-direct {p0, p3}, Lcom/fasterxml/aalto/util/TextBuilder;->expand(I)V

    .line 654
    iget-object v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    const/4 v3, 0x0

    invoke-static {p1, p2, v2, v3, p3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 655
    iput p3, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    .line 657
    :goto_0
    return-void
.end method

.method public appendSurrogate(I)V
    .locals 2
    .param p1, "surr"    # I

    .line 627
    shr-int/lit8 v0, p1, 0xa

    const v1, 0xd800

    or-int/2addr v0, v1

    int-to-char v0, v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/util/TextBuilder;->append(C)V

    .line 628
    and-int/lit16 v0, p1, 0x3ff

    const v1, 0xdc00

    or-int/2addr v0, v1

    int-to-char v0, v0

    invoke-virtual {p0, v0}, Lcom/fasterxml/aalto/util/TextBuilder;->append(C)V

    .line 629
    return-void
.end method

.method public contentsAsArray()[C
    .locals 2

    .line 352
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    .line 353
    .local v0, "result":[C
    if-nez v0, :cond_0

    .line 354
    invoke-direct {p0}, Lcom/fasterxml/aalto/util/TextBuilder;->buildResultArray()[C

    move-result-object v1

    move-object v0, v1

    iput-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    .line 356
    :cond_0
    return-object v0
.end method

.method public contentsAsString()Ljava/lang/String;
    .locals 8

    .line 319
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultString:Ljava/lang/String;

    if-nez v0, :cond_4

    .line 321
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    if-eqz v0, :cond_0

    .line 322
    new-instance v0, Ljava/lang/String;

    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    invoke-direct {v0, v1}, Ljava/lang/String;-><init>([C)V

    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultString:Ljava/lang/String;

    goto :goto_2

    .line 325
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segmentSize:I

    .line 326
    .local v0, "segLen":I
    iget v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    .line 328
    .local v1, "currLen":I
    const/4 v2, 0x0

    if-nez v0, :cond_2

    .line 329
    if-nez v1, :cond_1

    const-string v2, ""

    goto :goto_0

    :cond_1
    new-instance v3, Ljava/lang/String;

    iget-object v4, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    invoke-direct {v3, v4, v2, v1}, Ljava/lang/String;-><init>([CII)V

    move-object v2, v3

    :goto_0
    iput-object v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultString:Ljava/lang/String;

    .line 330
    iget-object v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultString:Ljava/lang/String;

    return-object v2

    .line 334
    :cond_2
    new-instance v3, Ljava/lang/StringBuilder;

    add-int v4, v0, v1

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 336
    .local v3, "sb":Ljava/lang/StringBuilder;
    iget-object v4, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    if-eqz v4, :cond_3

    .line 337
    const/4 v4, 0x0

    .local v4, "i":I
    iget-object v5, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    .local v5, "len":I
    :goto_1
    if-ge v4, v5, :cond_3

    .line 338
    iget-object v6, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v6, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, [C

    check-cast v6, [C

    .line 339
    .local v6, "curr":[C
    array-length v7, v6

    invoke-virtual {v3, v6, v2, v7}, Ljava/lang/StringBuilder;->append([CII)Ljava/lang/StringBuilder;

    .line 337
    .end local v6    # "curr":[C
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 343
    .end local v4    # "i":I
    .end local v5    # "len":I
    :cond_3
    iget-object v4, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    invoke-virtual {v3, v4, v2, v1}, Ljava/lang/StringBuilder;->append([CII)Ljava/lang/StringBuilder;

    .line 344
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultString:Ljava/lang/String;

    .line 347
    .end local v0    # "segLen":I
    .end local v1    # "currLen":I
    .end local v3    # "sb":Ljava/lang/StringBuilder;
    :cond_4
    :goto_2
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultString:Ljava/lang/String;

    return-object v0
.end method

.method public contentsToArray(I[CII)I
    .locals 7
    .param p1, "srcStart"    # I
    .param p2, "dst"    # [C
    .param p3, "dstStart"    # I
    .param p4, "len"    # I

    .line 365
    const/4 v0, 0x0

    .line 366
    .local v0, "totalAmount":I
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    if-eqz v1, :cond_2

    .line 367
    const/4 v1, 0x0

    .local v1, "i":I
    iget-object v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    .local v2, "segc":I
    :goto_0
    if-ge v1, v2, :cond_2

    .line 368
    iget-object v3, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [C

    check-cast v3, [C

    .line 369
    .local v3, "segment":[C
    array-length v4, v3

    .line 370
    .local v4, "segLen":I
    sub-int v5, v4, p1

    .line 371
    .local v5, "amount":I
    const/4 v6, 0x1

    if-ge v5, v6, :cond_0

    .line 372
    sub-int/2addr p1, v4

    .line 373
    goto :goto_1

    .line 375
    :cond_0
    if-lt v5, p4, :cond_1

    .line 376
    invoke-static {v3, p1, p2, p3, p4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 377
    add-int v6, v0, p4

    return v6

    .line 380
    :cond_1
    invoke-static {v3, p1, p2, p3, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 381
    add-int/2addr v0, v5

    .line 382
    add-int/2addr p3, v5

    .line 383
    sub-int/2addr p4, v5

    .line 384
    const/4 p1, 0x0

    .line 367
    .end local v3    # "segment":[C
    .end local v4    # "segLen":I
    .end local v5    # "amount":I
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 389
    .end local v1    # "i":I
    .end local v2    # "segc":I
    :cond_2
    if-lez p4, :cond_4

    .line 390
    iget v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    sub-int/2addr v1, p1

    .line 391
    .local v1, "maxAmount":I
    if-le p4, v1, :cond_3

    .line 392
    move p4, v1

    .line 394
    :cond_3
    if-lez p4, :cond_4

    .line 395
    iget-object v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    invoke-static {v2, p1, p2, p3, p4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 396
    add-int/2addr v0, p4

    .line 400
    .end local v1    # "maxAmount":I
    :cond_4
    return v0
.end method

.method public decodeElements(Lorg/codehaus/stax2/typed/TypedArrayDecoder;Z)I
    .locals 8
    .param p1, "tad"    # Lorg/codehaus/stax2/typed/TypedArrayDecoder;
    .param p2, "reset"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/codehaus/stax2/typed/TypedXMLStreamException;
        }
    .end annotation

    .line 737
    if-eqz p2, :cond_0

    .line 738
    invoke-direct {p0}, Lcom/fasterxml/aalto/util/TextBuilder;->resetForDecode()V

    .line 741
    :cond_0
    iget v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_decodePtr:I

    .line 742
    .local v0, "ptr":I
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_decodeBuffer:[C

    .line 744
    .local v1, "buf":[C
    const/4 v2, 0x0

    .line 747
    .local v2, "count":I
    move v3, v0

    .line 750
    .local v3, "start":I
    :try_start_0
    iget v4, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_decodeEnd:I

    .line 753
    .local v4, "end":I
    :goto_0
    if-ge v0, v4, :cond_5

    .line 755
    :cond_1
    aget-char v5, v1, v0

    const/16 v6, 0x20

    if-gt v5, v6, :cond_2

    .line 756
    add-int/lit8 v0, v0, 0x1

    if-lt v0, v4, :cond_1

    .line 757
    goto :goto_2

    .line 761
    :cond_2
    move v3, v0

    .line 762
    add-int/lit8 v0, v0, 0x1

    .line 763
    :goto_1
    if-ge v0, v4, :cond_3

    aget-char v5, v1, v0

    if-le v5, v6, :cond_3

    .line 764
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 766
    :cond_3
    add-int/lit8 v2, v2, 0x1

    .line 767
    move v5, v0

    .line 768
    .local v5, "tokenEnd":I
    add-int/lit8 v0, v0, 0x1

    .line 770
    invoke-virtual {p1, v1, v3, v5}, Lorg/codehaus/stax2/typed/TypedArrayDecoder;->decodeValue([CII)Z

    move-result v6

    if-eqz v6, :cond_4

    .line 771
    goto :goto_2

    .line 773
    :cond_4
    iput v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_decodePtr:I

    .line 774
    .end local v5    # "tokenEnd":I
    goto :goto_0

    .line 775
    :cond_5
    :goto_2
    iput v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_decodePtr:I
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 781
    .end local v4    # "end":I
    nop

    .line 782
    return v2

    .line 776
    :catch_0
    move-exception v4

    .line 779
    .local v4, "iae":Ljava/lang/IllegalArgumentException;
    new-instance v5, Ljava/lang/String;

    sub-int v6, v0, v3

    add-int/lit8 v6, v6, -0x1

    invoke-direct {v5, v1, v3, v6}, Ljava/lang/String;-><init>([CII)V

    .line 780
    .local v5, "lexical":Ljava/lang/String;
    new-instance v6, Lorg/codehaus/stax2/typed/TypedXMLStreamException;

    invoke-virtual {v4}, Ljava/lang/IllegalArgumentException;->getMessage()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v5, v7, v4}, Lorg/codehaus/stax2/typed/TypedXMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/IllegalArgumentException;)V

    throw v6
.end method

.method public equalsString(Ljava/lang/String;)Z
    .locals 6
    .param p1, "str"    # Ljava/lang/String;

    .line 502
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 505
    .local v0, "expLen":I
    invoke-virtual {p0}, Lcom/fasterxml/aalto/util/TextBuilder;->size()I

    move-result v1

    const/4 v2, 0x0

    if-eq v0, v1, :cond_0

    .line 506
    return v2

    .line 509
    :cond_0
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-nez v1, :cond_1

    goto :goto_0

    .line 517
    :cond_1
    invoke-virtual {p0}, Lcom/fasterxml/aalto/util/TextBuilder;->contentsAsArray()[C

    move-result-object v1

    .local v1, "seg":[C
    goto :goto_1

    .line 511
    .end local v1    # "seg":[C
    :cond_2
    :goto_0
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    .line 520
    .restart local v1    # "seg":[C
    :goto_1
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_2
    if-ge v3, v0, :cond_4

    .line 521
    aget-char v4, v1, v3

    invoke-virtual {p1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v5

    if-eq v4, v5, :cond_3

    .line 522
    return v2

    .line 520
    :cond_3
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 525
    .end local v3    # "i":I
    :cond_4
    const/4 v2, 0x1

    return v2
.end method

.method public finishCurrentSegment()[C
    .locals 3

    .line 702
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    if-nez v0, :cond_0

    .line 703
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    .line 705
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 706
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    array-length v0, v0

    .line 707
    .local v0, "oldLen":I
    iget v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segmentSize:I

    add-int/2addr v1, v0

    iput v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segmentSize:I

    .line 708
    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/util/TextBuilder;->calcNewSize(I)I

    move-result v1

    new-array v1, v1, [C

    .line 709
    .local v1, "curr":[C
    const/4 v2, 0x0

    iput v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    .line 710
    iput-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    .line 711
    return-object v1
.end method

.method public fireSaxCharacterEvents(Lorg/xml/sax/ContentHandler;)V
    .locals 5
    .param p1, "h"    # Lorg/xml/sax/ContentHandler;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 542
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 543
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    iget v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultLen:I

    invoke-interface {p1, v0, v1, v2}, Lorg/xml/sax/ContentHandler;->characters([CII)V

    goto :goto_1

    .line 545
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    if-eqz v0, :cond_1

    .line 546
    const/4 v0, 0x0

    .local v0, "i":I
    iget-object v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    .local v2, "len":I
    :goto_0
    if-ge v0, v2, :cond_1

    .line 547
    iget-object v3, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [C

    check-cast v3, [C

    .line 548
    .local v3, "ch":[C
    array-length v4, v3

    invoke-interface {p1, v3, v1, v4}, Lorg/xml/sax/ContentHandler;->characters([CII)V

    .line 546
    .end local v3    # "ch":[C
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 551
    .end local v0    # "i":I
    .end local v2    # "len":I
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    if-lez v0, :cond_2

    .line 552
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    iget v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    invoke-interface {p1, v0, v1, v2}, Lorg/xml/sax/ContentHandler;->characters([CII)V

    .line 555
    :cond_2
    :goto_1
    return-void
.end method

.method public fireSaxCommentEvent(Lorg/xml/sax/ext/LexicalHandler;)V
    .locals 3
    .param p1, "h"    # Lorg/xml/sax/ext/LexicalHandler;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 579
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 580
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    iget v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultLen:I

    invoke-interface {p1, v0, v1, v2}, Lorg/xml/sax/ext/LexicalHandler;->comment([CII)V

    goto :goto_0

    .line 581
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lez v0, :cond_1

    .line 582
    invoke-virtual {p0}, Lcom/fasterxml/aalto/util/TextBuilder;->contentsAsArray()[C

    move-result-object v0

    .line 583
    .local v0, "ch":[C
    array-length v2, v0

    invoke-interface {p1, v0, v1, v2}, Lorg/xml/sax/ext/LexicalHandler;->comment([CII)V

    .line 584
    .end local v0    # "ch":[C
    goto :goto_0

    .line 585
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    iget v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    invoke-interface {p1, v0, v1, v2}, Lorg/xml/sax/ext/LexicalHandler;->comment([CII)V

    .line 587
    :goto_0
    return-void
.end method

.method public fireSaxSpaceEvents(Lorg/xml/sax/ContentHandler;)V
    .locals 5
    .param p1, "h"    # Lorg/xml/sax/ContentHandler;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/xml/sax/SAXException;
        }
    .end annotation

    .line 560
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 561
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    iget v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultLen:I

    invoke-interface {p1, v0, v1, v2}, Lorg/xml/sax/ContentHandler;->ignorableWhitespace([CII)V

    goto :goto_1

    .line 563
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    if-eqz v0, :cond_1

    .line 564
    const/4 v0, 0x0

    .local v0, "i":I
    iget-object v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    .local v2, "len":I
    :goto_0
    if-ge v0, v2, :cond_1

    .line 565
    iget-object v3, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [C

    check-cast v3, [C

    .line 566
    .local v3, "ch":[C
    array-length v4, v3

    invoke-interface {p1, v3, v1, v4}, Lorg/xml/sax/ContentHandler;->ignorableWhitespace([CII)V

    .line 564
    .end local v3    # "ch":[C
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 569
    .end local v0    # "i":I
    .end local v2    # "len":I
    :cond_1
    iget v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    if-lez v0, :cond_2

    .line 570
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    iget v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    invoke-interface {p1, v0, v1, v2}, Lorg/xml/sax/ContentHandler;->ignorableWhitespace([CII)V

    .line 573
    :cond_2
    :goto_1
    return-void
.end method

.method public getBufferWithoutReset()[C
    .locals 1

    .line 274
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    return-object v0
.end method

.method public getCurrentLength()I
    .locals 1

    .line 693
    iget v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    return v0
.end method

.method public getTextBuffer()[C
    .locals 1

    .line 300
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 308
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/util/TextBuilder;->contentsAsArray()[C

    move-result-object v0

    return-object v0

    .line 302
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    if-eqz v0, :cond_2

    .line 303
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    return-object v0

    .line 305
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    return-object v0
.end method

.method public isAllWhitespace()Z
    .locals 9

    .line 438
    iget-boolean v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_isIndentation:Z

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    .line 439
    return v1

    .line 442
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    const/4 v2, 0x0

    const/16 v3, 0x20

    if-eqz v0, :cond_3

    .line 443
    const/4 v0, 0x0

    .local v0, "i":I
    iget-object v4, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    .local v4, "len":I
    :goto_0
    if-ge v0, v4, :cond_3

    .line 444
    iget-object v5, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, [C

    check-cast v5, [C

    .line 445
    .local v5, "buf":[C
    const/4 v6, 0x0

    .local v6, "j":I
    array-length v7, v5

    .local v7, "len2":I
    :goto_1
    if-ge v6, v7, :cond_2

    .line 446
    aget-char v8, v5, v6

    if-le v8, v3, :cond_1

    .line 447
    return v2

    .line 445
    :cond_1
    add-int/lit8 v6, v6, 0x1

    goto :goto_1

    .line 443
    .end local v5    # "buf":[C
    .end local v6    # "j":I
    .end local v7    # "len2":I
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 453
    .end local v0    # "i":I
    .end local v4    # "len":I
    :cond_3
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    .line 454
    .local v0, "buf":[C
    const/4 v4, 0x0

    .local v4, "i":I
    iget v5, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    .local v5, "len":I
    :goto_2
    if-ge v4, v5, :cond_5

    .line 455
    aget-char v6, v0, v4

    if-le v6, v3, :cond_4

    .line 456
    return v2

    .line 454
    :cond_4
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 459
    .end local v4    # "i":I
    .end local v5    # "len":I
    :cond_5
    return v1
.end method

.method public rawContentsTo(Ljava/io/Writer;)I
    .locals 5
    .param p1, "w"    # Ljava/io/Writer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 411
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    if-eqz v0, :cond_0

    .line 412
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write([C)V

    .line 413
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    array-length v0, v0

    return v0

    .line 415
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultString:Ljava/lang/String;

    if-eqz v0, :cond_1

    .line 416
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultString:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/io/Writer;->write(Ljava/lang/String;)V

    .line 417
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultString:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    return v0

    .line 421
    :cond_1
    const/4 v0, 0x0

    .line 422
    .local v0, "rlen":I
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    if-eqz v1, :cond_2

    .line 423
    const/4 v1, 0x0

    .local v1, "i":I
    iget-object v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    .local v2, "len":I
    :goto_0
    if-ge v1, v2, :cond_2

    .line 424
    iget-object v3, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, [C

    check-cast v3, [C

    .line 425
    .local v3, "ch":[C
    invoke-virtual {p1, v3}, Ljava/io/Writer;->write([C)V

    .line 426
    array-length v4, v3

    add-int/2addr v0, v4

    .line 423
    .end local v3    # "ch":[C
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 429
    .end local v1    # "i":I
    .end local v2    # "len":I
    :cond_2
    iget v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    if-lez v1, :cond_3

    .line 430
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    const/4 v2, 0x0

    iget v3, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    invoke-virtual {p1, v1, v2, v3}, Ljava/io/Writer;->write([CII)V

    .line 431
    iget v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    add-int/2addr v0, v1

    .line 433
    :cond_3
    return v0
.end method

.method public recycle(Z)V
    .locals 3
    .param p1, "force"    # Z

    .line 151
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    if-eqz v0, :cond_3

    .line 152
    const/4 v0, 0x0

    if-eqz p1, :cond_0

    .line 156
    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultString:Ljava/lang/String;

    .line 157
    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    goto :goto_0

    .line 162
    :cond_0
    iget v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segmentSize:I

    iget v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    add-int/2addr v1, v2

    if-lez v1, :cond_1

    .line 163
    return-void

    .line 167
    :cond_1
    :goto_0
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lez v1, :cond_2

    .line 169
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->clear()V

    .line 170
    const/4 v1, 0x0

    iput v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segmentSize:I

    .line 172
    :cond_2
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    .line 173
    .local v1, "buf":[C
    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    .line 174
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_config:Lcom/fasterxml/aalto/in/ReaderConfig;

    invoke-virtual {v0, v1}, Lcom/fasterxml/aalto/in/ReaderConfig;->freeMediumCBuffer([C)V

    .line 176
    .end local v1    # "buf":[C
    :cond_3
    return-void
.end method

.method public resetForBinaryDecode(Lorg/codehaus/stax2/typed/Base64Variant;Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;Z)V
    .locals 16
    .param p1, "v"    # Lorg/codehaus/stax2/typed/Base64Variant;
    .param p2, "dec"    # Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;
    .param p3, "firstChunk"    # Z

    .line 792
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    if-eqz v1, :cond_0

    iget-object v1, v0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-nez v1, :cond_1

    .line 793
    :cond_0
    iget-boolean v1, v0, Lcom/fasterxml/aalto/util/TextBuilder;->_isIndentation:Z

    if-eqz v1, :cond_1

    .line 794
    iget-object v5, v0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    iget-object v1, v0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    array-length v7, v1

    const/4 v8, 0x0

    const/4 v6, 0x0

    move-object/from16 v2, p2

    move-object/from16 v3, p1

    move/from16 v4, p3

    invoke-virtual/range {v2 .. v8}, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->init(Lorg/codehaus/stax2/typed/Base64Variant;Z[CIILjava/util/List;)V

    .line 795
    return-void

    .line 798
    :cond_1
    iget-object v12, v0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    iget v14, v0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    iget-object v15, v0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    const/4 v13, 0x0

    move-object/from16 v9, p2

    move-object/from16 v10, p1

    move/from16 v11, p3

    invoke-virtual/range {v9 .. v15}, Lorg/codehaus/stax2/ri/typed/CharArrayBase64Decoder;->init(Lorg/codehaus/stax2/typed/Base64Variant;Z[CIILjava/util/List;)V

    .line 799
    return-void
.end method

.method public resetWithChar(C)V
    .locals 3
    .param p1, "c"    # C

    .line 237
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultString:Ljava/lang/String;

    .line 238
    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    .line 239
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_isIndentation:Z

    .line 242
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lez v1, :cond_0

    .line 243
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->clear()V

    .line 244
    iput v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segmentSize:I

    .line 246
    :cond_0
    const/4 v1, 0x1

    iput v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    .line 247
    iget-object v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    if-nez v2, :cond_1

    .line 248
    invoke-direct {p0, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->allocBuffer(I)[C

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    .line 250
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    aput-char p1, v1, v0

    .line 251
    return-void
.end method

.method public resetWithEmpty()[C
    .locals 2

    .line 183
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultString:Ljava/lang/String;

    .line 184
    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    .line 185
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_isIndentation:Z

    .line 188
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lez v1, :cond_0

    .line 193
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->clear()V

    .line 194
    iput v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segmentSize:I

    .line 196
    :cond_0
    iput v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    .line 197
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    if-nez v1, :cond_1

    .line 198
    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/util/TextBuilder;->allocBuffer(I)[C

    move-result-object v0

    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    .line 200
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    return-object v0
.end method

.method public resetWithIndentation(IC)V
    .locals 5
    .param p1, "indCharCount"    # I
    .param p2, "indChar"    # C

    .line 206
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lez v0, :cond_0

    .line 207
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 208
    iput v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segmentSize:I

    .line 210
    :cond_0
    const/4 v0, -0x1

    iput v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    .line 211
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_isIndentation:Z

    .line 214
    add-int/lit8 v0, p1, 0x1

    .line 215
    .local v0, "strlen":I
    iput v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultLen:I

    .line 216
    const/16 v2, 0x9

    if-ne p2, v2, :cond_1

    .line 217
    sget-object v2, Lcom/fasterxml/aalto/util/TextBuilder;->sIndTabsArray:[C

    iput-object v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    .line 218
    sget-object v2, Lcom/fasterxml/aalto/util/TextBuilder;->sIndTabsStrings:[Ljava/lang/String;

    aget-object v2, v2, p1

    .line 219
    .local v2, "text":Ljava/lang/String;
    if-nez v2, :cond_2

    .line 220
    sget-object v3, Lcom/fasterxml/aalto/util/TextBuilder;->sIndTabsStrings:[Ljava/lang/String;

    const-string v4, "\n\t\t\t\t\t\t\t\t\t"

    invoke-virtual {v4, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    move-object v2, v1

    aput-object v1, v3, p1

    goto :goto_0

    .line 223
    .end local v2    # "text":Ljava/lang/String;
    :cond_1
    sget-object v2, Lcom/fasterxml/aalto/util/TextBuilder;->sIndSpacesArray:[C

    iput-object v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    .line 224
    sget-object v2, Lcom/fasterxml/aalto/util/TextBuilder;->sIndSpacesStrings:[Ljava/lang/String;

    aget-object v2, v2, p1

    .line 225
    .restart local v2    # "text":Ljava/lang/String;
    if-nez v2, :cond_2

    .line 226
    sget-object v3, Lcom/fasterxml/aalto/util/TextBuilder;->sIndSpacesStrings:[Ljava/lang/String;

    const-string v4, "\n                                 "

    invoke-virtual {v4, v1, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    move-object v2, v1

    aput-object v1, v3, p1

    .line 229
    :cond_2
    :goto_0
    iput-object v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultString:Ljava/lang/String;

    .line 230
    return-void
.end method

.method public resetWithSurrogate(I)V
    .locals 4
    .param p1, "c"    # I

    .line 255
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultString:Ljava/lang/String;

    .line 256
    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    .line 257
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_isIndentation:Z

    .line 260
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lez v1, :cond_0

    .line 261
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segments:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->clear()V

    .line 262
    iput v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segmentSize:I

    .line 264
    :cond_0
    const/4 v1, 0x2

    iput v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    .line 265
    iget-object v2, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    if-nez v2, :cond_1

    .line 266
    invoke-direct {p0, v1}, Lcom/fasterxml/aalto/util/TextBuilder;->allocBuffer(I)[C

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    .line 268
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    shr-int/lit8 v2, p1, 0xa

    const v3, 0xd800

    or-int/2addr v2, v3

    int-to-char v2, v2

    aput-char v2, v1, v0

    .line 269
    iget-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSegment:[C

    and-int/lit16 v1, p1, 0x3ff

    const v2, 0xdc00

    or-int/2addr v1, v2

    int-to-char v1, v1

    const/4 v2, 0x1

    aput-char v1, v0, v2

    .line 270
    return-void
.end method

.method public setCurrentLength(I)V
    .locals 0
    .param p1, "len"    # I

    .line 697
    iput p1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    .line 698
    return-void
.end method

.method public size()I
    .locals 2

    .line 288
    iget v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_currentSize:I

    .line 291
    .local v0, "size":I
    if-gez v0, :cond_0

    .line 292
    iget v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultLen:I

    return v1

    .line 294
    :cond_0
    iget v1, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_segmentSize:I

    add-int/2addr v1, v0

    return v1
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .line 835
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultString:Ljava/lang/String;

    .line 836
    iput-object v0, p0, Lcom/fasterxml/aalto/util/TextBuilder;->_resultArray:[C

    .line 837
    invoke-virtual {p0}, Lcom/fasterxml/aalto/util/TextBuilder;->contentsAsString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
