.class public Lcom/fasterxml/jackson/core/JsonPointer;
.super Ljava/lang/Object;
.source "JsonPointer.java"

# interfaces
.implements Ljava/io/Serializable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/fasterxml/jackson/core/JsonPointer$Serialization;,
        Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;,
        Lcom/fasterxml/jackson/core/JsonPointer$PointerParent;
    }
.end annotation


# static fields
.field protected static final EMPTY:Lcom/fasterxml/jackson/core/JsonPointer;

.field public static final SEPARATOR:C = '/'

.field private static final serialVersionUID:J = 0x1L


# instance fields
.field protected final _asString:Ljava/lang/String;

.field protected final _asStringOffset:I

.field protected _hashCode:I

.field protected volatile _head:Lcom/fasterxml/jackson/core/JsonPointer;

.field protected final _matchingElementIndex:I

.field protected final _matchingPropertyName:Ljava/lang/String;

.field protected final _nextSegment:Lcom/fasterxml/jackson/core/JsonPointer;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 42
    new-instance v0, Lcom/fasterxml/jackson/core/JsonPointer;

    invoke-direct {v0}, Lcom/fasterxml/jackson/core/JsonPointer;-><init>()V

    sput-object v0, Lcom/fasterxml/jackson/core/JsonPointer;->EMPTY:Lcom/fasterxml/jackson/core/JsonPointer;

    return-void
.end method

.method protected constructor <init>()V
    .locals 1

    .line 104
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 105
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_nextSegment:Lcom/fasterxml/jackson/core/JsonPointer;

    .line 107
    iput-object v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_matchingPropertyName:Ljava/lang/String;

    .line 108
    const/4 v0, -0x1

    iput v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_matchingElementIndex:I

    .line 109
    const-string v0, ""

    iput-object v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_asString:Ljava/lang/String;

    .line 110
    const/4 v0, 0x0

    iput v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_asStringOffset:I

    .line 111
    return-void
.end method

.method protected constructor <init>(Ljava/lang/String;ILjava/lang/String;ILcom/fasterxml/jackson/core/JsonPointer;)V
    .locals 0
    .param p1, "fullString"    # Ljava/lang/String;
    .param p2, "fullStringOffset"    # I
    .param p3, "segment"    # Ljava/lang/String;
    .param p4, "matchIndex"    # I
    .param p5, "next"    # Lcom/fasterxml/jackson/core/JsonPointer;

    .line 127
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 128
    iput-object p1, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_asString:Ljava/lang/String;

    .line 129
    iput p2, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_asStringOffset:I

    .line 130
    iput-object p5, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_nextSegment:Lcom/fasterxml/jackson/core/JsonPointer;

    .line 131
    iput-object p3, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_matchingPropertyName:Ljava/lang/String;

    .line 132
    iput p4, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_matchingElementIndex:I

    .line 133
    return-void
.end method

.method protected constructor <init>(Ljava/lang/String;ILjava/lang/String;Lcom/fasterxml/jackson/core/JsonPointer;)V
    .locals 1
    .param p1, "fullString"    # Ljava/lang/String;
    .param p2, "fullStringOffset"    # I
    .param p3, "segment"    # Ljava/lang/String;
    .param p4, "next"    # Lcom/fasterxml/jackson/core/JsonPointer;

    .line 116
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 117
    iput-object p1, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_asString:Ljava/lang/String;

    .line 118
    iput p2, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_asStringOffset:I

    .line 119
    iput-object p4, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_nextSegment:Lcom/fasterxml/jackson/core/JsonPointer;

    .line 121
    iput-object p3, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_matchingPropertyName:Ljava/lang/String;

    .line 123
    invoke-static {p3}, Lcom/fasterxml/jackson/core/JsonPointer;->_parseIndex(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_matchingElementIndex:I

    .line 124
    return-void
.end method

.method private static _appendEscape(Ljava/lang/StringBuilder;C)V
    .locals 1
    .param p0, "sb"    # Ljava/lang/StringBuilder;
    .param p1, "c"    # C

    .line 735
    const/16 v0, 0x30

    if-ne p1, v0, :cond_0

    .line 736
    const/16 p1, 0x7e

    goto :goto_0

    .line 737
    :cond_0
    const/16 v0, 0x31

    if-ne p1, v0, :cond_1

    .line 738
    const/16 p1, 0x2f

    goto :goto_0

    .line 740
    :cond_1
    const/16 v0, 0x7e

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 742
    :goto_0
    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 743
    return-void
.end method

.method private static _appendEscaped(Ljava/lang/StringBuilder;Ljava/lang/String;)V
    .locals 4
    .param p0, "sb"    # Ljava/lang/StringBuilder;
    .param p1, "segment"    # Ljava/lang/String;

    .line 282
    const/4 v0, 0x0

    .local v0, "i":I
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    .local v1, "end":I
    :goto_0
    if-ge v0, v1, :cond_2

    .line 283
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 284
    .local v2, "c":C
    const/16 v3, 0x2f

    if-ne v2, v3, :cond_0

    .line 285
    const-string v3, "~1"

    invoke-virtual {p0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 286
    goto :goto_1

    .line 288
    :cond_0
    const/16 v3, 0x7e

    if-ne v2, v3, :cond_1

    .line 289
    const-string v3, "~0"

    invoke-virtual {p0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 290
    goto :goto_1

    .line 292
    :cond_1
    invoke-virtual {p0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 282
    .end local v2    # "c":C
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 294
    .end local v0    # "i":I
    .end local v1    # "end":I
    :cond_2
    return-void
.end method

.method private static _buildPath(Ljava/lang/String;ILjava/lang/String;Lcom/fasterxml/jackson/core/JsonPointer$PointerParent;)Lcom/fasterxml/jackson/core/JsonPointer;
    .locals 4
    .param p0, "fullPath"    # Ljava/lang/String;
    .param p1, "fullPathOffset"    # I
    .param p2, "segment"    # Ljava/lang/String;
    .param p3, "parent"    # Lcom/fasterxml/jackson/core/JsonPointer$PointerParent;

    .line 687
    new-instance v0, Lcom/fasterxml/jackson/core/JsonPointer;

    sget-object v1, Lcom/fasterxml/jackson/core/JsonPointer;->EMPTY:Lcom/fasterxml/jackson/core/JsonPointer;

    invoke-direct {v0, p0, p1, p2, v1}, Lcom/fasterxml/jackson/core/JsonPointer;-><init>(Ljava/lang/String;ILjava/lang/String;Lcom/fasterxml/jackson/core/JsonPointer;)V

    .line 688
    .local v0, "curr":Lcom/fasterxml/jackson/core/JsonPointer;
    :goto_0
    if-eqz p3, :cond_0

    .line 689
    new-instance v1, Lcom/fasterxml/jackson/core/JsonPointer;

    iget v2, p3, Lcom/fasterxml/jackson/core/JsonPointer$PointerParent;->fullPathOffset:I

    iget-object v3, p3, Lcom/fasterxml/jackson/core/JsonPointer$PointerParent;->segment:Ljava/lang/String;

    invoke-direct {v1, p0, v2, v3, v0}, Lcom/fasterxml/jackson/core/JsonPointer;-><init>(Ljava/lang/String;ILjava/lang/String;Lcom/fasterxml/jackson/core/JsonPointer;)V

    move-object v0, v1

    .line 688
    iget-object p3, p3, Lcom/fasterxml/jackson/core/JsonPointer$PointerParent;->parent:Lcom/fasterxml/jackson/core/JsonPointer$PointerParent;

    goto :goto_0

    .line 691
    :cond_0
    return-object v0
.end method

.method private final _compare(Ljava/lang/String;ILjava/lang/String;I)Z
    .locals 4
    .param p1, "str1"    # Ljava/lang/String;
    .param p2, "offset1"    # I
    .param p3, "str2"    # Ljava/lang/String;
    .param p4, "offset2"    # I

    .line 593
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    .line 596
    .local v0, "end1":I
    sub-int v1, v0, p2

    invoke-virtual {p3}, Ljava/lang/String;->length()I

    move-result v2

    sub-int/2addr v2, p4

    const/4 v3, 0x0

    if-eq v1, v2, :cond_0

    .line 597
    return v3

    .line 600
    :cond_0
    :goto_0
    if-ge p2, v0, :cond_2

    .line 601
    add-int/lit8 v1, p2, 0x1

    .end local p2    # "offset1":I
    .local v1, "offset1":I
    invoke-virtual {p1, p2}, Ljava/lang/String;->charAt(I)C

    move-result p2

    add-int/lit8 v2, p4, 0x1

    .end local p4    # "offset2":I
    .local v2, "offset2":I
    invoke-virtual {p3, p4}, Ljava/lang/String;->charAt(I)C

    move-result p4

    if-eq p2, p4, :cond_1

    .line 602
    return v3

    .line 601
    :cond_1
    move p2, v1

    move p4, v2

    goto :goto_0

    .line 606
    .end local v1    # "offset1":I
    .end local v2    # "offset2":I
    .restart local p2    # "offset1":I
    .restart local p4    # "offset2":I
    :cond_2
    const/4 v1, 0x1

    return v1
.end method

.method protected static _extractEscapedSegment(Ljava/lang/String;IILjava/lang/StringBuilder;)I
    .locals 4
    .param p0, "input"    # Ljava/lang/String;
    .param p1, "firstCharOffset"    # I
    .param p2, "i"    # I
    .param p3, "sb"    # Ljava/lang/StringBuilder;

    .line 712
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 713
    .local v0, "end":I
    add-int/lit8 v1, p2, -0x1

    sub-int/2addr v1, p1

    .line 714
    .local v1, "toCopy":I
    if-lez v1, :cond_0

    .line 715
    add-int/lit8 v2, p2, -0x1

    invoke-virtual {p3, p0, p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/CharSequence;II)Ljava/lang/StringBuilder;

    .line 717
    :cond_0
    add-int/lit8 v2, p2, 0x1

    .end local p2    # "i":I
    .local v2, "i":I
    invoke-virtual {p0, p2}, Ljava/lang/String;->charAt(I)C

    move-result p2

    invoke-static {p3, p2}, Lcom/fasterxml/jackson/core/JsonPointer;->_appendEscape(Ljava/lang/StringBuilder;C)V

    .line 718
    :goto_0
    if-ge v2, v0, :cond_3

    .line 719
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result p2

    .line 720
    .local p2, "c":C
    const/16 v3, 0x2f

    if-ne p2, v3, :cond_1

    .line 721
    return v2

    .line 723
    :cond_1
    add-int/lit8 v2, v2, 0x1

    .line 724
    const/16 v3, 0x7e

    if-ne p2, v3, :cond_2

    if-ge v2, v0, :cond_2

    .line 725
    add-int/lit8 v3, v2, 0x1

    .end local v2    # "i":I
    .local v3, "i":I
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {p3, v2}, Lcom/fasterxml/jackson/core/JsonPointer;->_appendEscape(Ljava/lang/StringBuilder;C)V

    .line 726
    move v2, v3

    goto :goto_0

    .line 728
    .end local v3    # "i":I
    .restart local v2    # "i":I
    :cond_2
    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 729
    .end local p2    # "c":C
    goto :goto_0

    .line 731
    :cond_3
    const/4 p2, -0x1

    return p2
.end method

.method private static final _parseIndex(Ljava/lang/String;)I
    .locals 7
    .param p0, "str"    # Ljava/lang/String;

    .line 616
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 619
    .local v0, "len":I
    const/4 v1, -0x1

    if-eqz v0, :cond_8

    const/16 v2, 0xa

    if-le v0, v2, :cond_0

    goto :goto_2

    .line 623
    :cond_0
    const/4 v3, 0x0

    invoke-virtual {p0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 624
    .local v4, "c":C
    const/16 v5, 0x30

    if-gt v4, v5, :cond_2

    .line 625
    const/4 v2, 0x1

    if-ne v0, v2, :cond_1

    if-ne v4, v5, :cond_1

    move v1, v3

    :cond_1
    return v1

    .line 627
    :cond_2
    const/16 v3, 0x39

    if-le v4, v3, :cond_3

    .line 628
    return v1

    .line 630
    :cond_3
    const/4 v6, 0x1

    .local v6, "i":I
    :goto_0
    if-ge v6, v0, :cond_6

    .line 631
    invoke-virtual {p0, v6}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 632
    if-gt v4, v3, :cond_5

    if-ge v4, v5, :cond_4

    goto :goto_1

    .line 630
    :cond_4
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 633
    :cond_5
    :goto_1
    return v1

    .line 636
    .end local v6    # "i":I
    :cond_6
    if-ne v0, v2, :cond_7

    .line 637
    invoke-static {p0}, Lcom/fasterxml/jackson/core/io/NumberInput;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    .line 638
    .local v2, "l":J
    const-wide/32 v5, 0x7fffffff

    cmp-long v5, v2, v5

    if-lez v5, :cond_7

    .line 639
    return v1

    .line 642
    .end local v2    # "l":J
    :cond_7
    invoke-static {p0}, Lcom/fasterxml/jackson/core/io/NumberInput;->parseInt(Ljava/lang/String;)I

    move-result v1

    return v1

    .line 620
    .end local v4    # "c":C
    :cond_8
    :goto_2
    return v1
.end method

.method protected static _parseTail(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonPointer;
    .locals 8
    .param p0, "fullPath"    # Ljava/lang/String;

    .line 647
    const/4 v0, 0x0

    .line 650
    .local v0, "parent":Lcom/fasterxml/jackson/core/JsonPointer$PointerParent;
    const/4 v1, 0x1

    .line 651
    .local v1, "i":I
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    .line 652
    .local v2, "end":I
    const/4 v3, 0x0

    .line 654
    .local v3, "startOffset":I
    :goto_0
    if-ge v1, v2, :cond_3

    .line 655
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 656
    .local v4, "c":C
    const/16 v5, 0x2f

    if-ne v4, v5, :cond_0

    .line 657
    new-instance v5, Lcom/fasterxml/jackson/core/JsonPointer$PointerParent;

    add-int/lit8 v6, v3, 0x1

    .line 658
    invoke-virtual {p0, v6, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v0, v3, v6}, Lcom/fasterxml/jackson/core/JsonPointer$PointerParent;-><init>(Lcom/fasterxml/jackson/core/JsonPointer$PointerParent;ILjava/lang/String;)V

    move-object v0, v5

    .line 659
    move v3, v1

    .line 660
    add-int/lit8 v1, v1, 0x1

    .line 661
    goto :goto_0

    .line 663
    :cond_0
    add-int/lit8 v1, v1, 0x1

    .line 665
    const/16 v5, 0x7e

    if-ne v4, v5, :cond_2

    if-ge v1, v2, :cond_2

    .line 668
    new-instance v5, Ljava/lang/StringBuilder;

    const/16 v6, 0x20

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 669
    .local v5, "sb":Ljava/lang/StringBuilder;
    add-int/lit8 v6, v3, 0x1

    invoke-static {p0, v6, v1, v5}, Lcom/fasterxml/jackson/core/JsonPointer;->_extractEscapedSegment(Ljava/lang/String;IILjava/lang/StringBuilder;)I

    move-result v1

    .line 670
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 671
    .local v6, "segment":Ljava/lang/String;
    if-gez v1, :cond_1

    .line 672
    invoke-static {p0, v3, v6, v0}, Lcom/fasterxml/jackson/core/JsonPointer;->_buildPath(Ljava/lang/String;ILjava/lang/String;Lcom/fasterxml/jackson/core/JsonPointer$PointerParent;)Lcom/fasterxml/jackson/core/JsonPointer;

    move-result-object v7

    return-object v7

    .line 674
    :cond_1
    new-instance v7, Lcom/fasterxml/jackson/core/JsonPointer$PointerParent;

    invoke-direct {v7, v0, v3, v6}, Lcom/fasterxml/jackson/core/JsonPointer$PointerParent;-><init>(Lcom/fasterxml/jackson/core/JsonPointer$PointerParent;ILjava/lang/String;)V

    move-object v0, v7

    .line 675
    move v3, v1

    .line 676
    add-int/lit8 v1, v1, 0x1

    .line 677
    goto :goto_0

    .line 680
    .end local v4    # "c":C
    .end local v5    # "sb":Ljava/lang/StringBuilder;
    .end local v6    # "segment":Ljava/lang/String;
    :cond_2
    goto :goto_0

    .line 682
    :cond_3
    add-int/lit8 v4, v3, 0x1

    invoke-virtual {p0, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {p0, v3, v4, v0}, Lcom/fasterxml/jackson/core/JsonPointer;->_buildPath(Ljava/lang/String;ILjava/lang/String;Lcom/fasterxml/jackson/core/JsonPointer$PointerParent;)Lcom/fasterxml/jackson/core/JsonPointer;

    move-result-object v4

    return-object v4
.end method

.method public static compile(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonPointer;
    .locals 3
    .param p0, "expr"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .line 157
    if-eqz p0, :cond_2

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 161
    :cond_0
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/16 v1, 0x2f

    if-ne v0, v1, :cond_1

    .line 164
    invoke-static {p0}, Lcom/fasterxml/jackson/core/JsonPointer;->_parseTail(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonPointer;

    move-result-object v0

    return-object v0

    .line 162
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid input: JSON Pointer expression must start with \'/\': \""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 158
    :cond_2
    :goto_0
    sget-object v0, Lcom/fasterxml/jackson/core/JsonPointer;->EMPTY:Lcom/fasterxml/jackson/core/JsonPointer;

    return-object v0
.end method

.method public static empty()Lcom/fasterxml/jackson/core/JsonPointer;
    .locals 1

    .line 188
    sget-object v0, Lcom/fasterxml/jackson/core/JsonPointer;->EMPTY:Lcom/fasterxml/jackson/core/JsonPointer;

    return-object v0
.end method

.method public static forPath(Lcom/fasterxml/jackson/core/JsonStreamContext;Z)Lcom/fasterxml/jackson/core/JsonPointer;
    .locals 16
    .param p0, "context"    # Lcom/fasterxml/jackson/core/JsonStreamContext;
    .param p1, "includeRoot"    # Z

    .line 207
    if-nez p0, :cond_0

    .line 208
    sget-object v0, Lcom/fasterxml/jackson/core/JsonPointer;->EMPTY:Lcom/fasterxml/jackson/core/JsonPointer;

    return-object v0

    .line 212
    :cond_0
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/jackson/core/JsonStreamContext;->hasPathSegment()Z

    move-result v0

    if-nez v0, :cond_2

    .line 214
    if-eqz p1, :cond_1

    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/jackson/core/JsonStreamContext;->inRoot()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/jackson/core/JsonStreamContext;->hasCurrentIndex()Z

    move-result v0

    if-nez v0, :cond_2

    .line 215
    :cond_1
    invoke-virtual/range {p0 .. p0}, Lcom/fasterxml/jackson/core/JsonStreamContext;->getParent()Lcom/fasterxml/jackson/core/JsonStreamContext;

    move-result-object v0

    .end local p0    # "context":Lcom/fasterxml/jackson/core/JsonStreamContext;
    .local v0, "context":Lcom/fasterxml/jackson/core/JsonStreamContext;
    goto :goto_0

    .line 219
    .end local v0    # "context":Lcom/fasterxml/jackson/core/JsonStreamContext;
    .restart local p0    # "context":Lcom/fasterxml/jackson/core/JsonStreamContext;
    :cond_2
    move-object/from16 v0, p0

    .end local p0    # "context":Lcom/fasterxml/jackson/core/JsonStreamContext;
    .restart local v0    # "context":Lcom/fasterxml/jackson/core/JsonStreamContext;
    :goto_0
    const/4 v1, 0x0

    .line 220
    .local v1, "next":Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;
    const/4 v2, 0x0

    .line 222
    .local v2, "approxLength":I
    :goto_1
    if-eqz v0, :cond_7

    .line 223
    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/JsonStreamContext;->inObject()Z

    move-result v3

    if-eqz v3, :cond_4

    .line 224
    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/JsonStreamContext;->getCurrentName()Ljava/lang/String;

    move-result-object v3

    .line 225
    .local v3, "propName":Ljava/lang/String;
    if-nez v3, :cond_3

    .line 226
    const-string v3, ""

    .line 228
    :cond_3
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    add-int/lit8 v4, v4, 0x2

    add-int/2addr v2, v4

    .line 229
    new-instance v4, Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;

    const/4 v5, -0x1

    invoke-direct {v4, v1, v3, v5}, Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;-><init>(Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;Ljava/lang/String;I)V

    move-object v1, v4

    .end local v3    # "propName":Ljava/lang/String;
    goto :goto_2

    .line 230
    :cond_4
    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/JsonStreamContext;->inArray()Z

    move-result v3

    if-nez v3, :cond_6

    if-eqz p1, :cond_5

    goto :goto_3

    :cond_5
    :goto_2
    goto :goto_4

    .line 231
    :cond_6
    :goto_3
    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/JsonStreamContext;->getCurrentIndex()I

    move-result v3

    .line 232
    .local v3, "ix":I
    add-int/lit8 v2, v2, 0x6

    .line 233
    new-instance v4, Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;

    const/4 v5, 0x0

    invoke-direct {v4, v1, v5, v3}, Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;-><init>(Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;Ljava/lang/String;I)V

    move-object v1, v4

    .line 222
    .end local v3    # "ix":I
    :goto_4
    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/JsonStreamContext;->getParent()Lcom/fasterxml/jackson/core/JsonStreamContext;

    move-result-object v0

    goto :goto_1

    .line 239
    :cond_7
    if-nez v1, :cond_8

    .line 240
    sget-object v3, Lcom/fasterxml/jackson/core/JsonPointer;->EMPTY:Lcom/fasterxml/jackson/core/JsonPointer;

    return-object v3

    .line 245
    :cond_8
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v2}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 246
    .local v3, "pathBuilder":Ljava/lang/StringBuilder;
    const/4 v4, 0x0

    .line 248
    .local v4, "last":Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;
    :goto_5
    if-eqz v1, :cond_a

    .line 250
    move-object v4, v1

    .line 251
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->length()I

    move-result v5

    iput v5, v1, Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;->pathOffset:I

    .line 252
    const/16 v5, 0x2f

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 253
    iget-object v5, v1, Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;->property:Ljava/lang/String;

    if-eqz v5, :cond_9

    .line 254
    iget-object v5, v1, Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;->property:Ljava/lang/String;

    invoke-static {v3, v5}, Lcom/fasterxml/jackson/core/JsonPointer;->_appendEscaped(Ljava/lang/StringBuilder;Ljava/lang/String;)V

    goto :goto_6

    .line 256
    :cond_9
    iget v5, v1, Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;->index:I

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 248
    :goto_6
    iget-object v1, v1, Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;->next:Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;

    goto :goto_5

    .line 259
    :cond_a
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    .line 263
    .local v11, "fullPath":Ljava/lang/String;
    move-object v5, v4

    .line 264
    .local v5, "currSegment":Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;
    sget-object v6, Lcom/fasterxml/jackson/core/JsonPointer;->EMPTY:Lcom/fasterxml/jackson/core/JsonPointer;

    move-object v12, v5

    move-object v13, v6

    .line 266
    .end local v5    # "currSegment":Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;
    .local v12, "currSegment":Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;
    .local v13, "currPtr":Lcom/fasterxml/jackson/core/JsonPointer;
    :goto_7
    if-eqz v12, :cond_c

    .line 267
    iget-object v5, v12, Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;->property:Ljava/lang/String;

    if-eqz v5, :cond_b

    .line 268
    new-instance v5, Lcom/fasterxml/jackson/core/JsonPointer;

    iget v6, v12, Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;->pathOffset:I

    iget-object v7, v12, Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;->property:Ljava/lang/String;

    invoke-direct {v5, v11, v6, v7, v13}, Lcom/fasterxml/jackson/core/JsonPointer;-><init>(Ljava/lang/String;ILjava/lang/String;Lcom/fasterxml/jackson/core/JsonPointer;)V

    move-object v13, v5

    .end local v13    # "currPtr":Lcom/fasterxml/jackson/core/JsonPointer;
    .local v5, "currPtr":Lcom/fasterxml/jackson/core/JsonPointer;
    goto :goto_8

    .line 271
    .end local v5    # "currPtr":Lcom/fasterxml/jackson/core/JsonPointer;
    .restart local v13    # "currPtr":Lcom/fasterxml/jackson/core/JsonPointer;
    :cond_b
    iget v14, v12, Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;->index:I

    .line 272
    .local v14, "index":I
    new-instance v15, Lcom/fasterxml/jackson/core/JsonPointer;

    iget v7, v12, Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;->pathOffset:I

    .line 273
    invoke-static {v14}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v8

    move-object v5, v15

    move-object v6, v11

    move v9, v14

    move-object v10, v13

    invoke-direct/range {v5 .. v10}, Lcom/fasterxml/jackson/core/JsonPointer;-><init>(Ljava/lang/String;ILjava/lang/String;ILcom/fasterxml/jackson/core/JsonPointer;)V

    move-object v13, v5

    .line 266
    .end local v14    # "index":I
    :goto_8
    iget-object v12, v12, Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;->prev:Lcom/fasterxml/jackson/core/JsonPointer$PointerSegment;

    goto :goto_7

    .line 277
    :cond_c
    return-object v13
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonPointer;
    .locals 1
    .param p0, "expr"    # Ljava/lang/String;

    .line 175
    invoke-static {p0}, Lcom/fasterxml/jackson/core/JsonPointer;->compile(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonPointer;

    move-result-object v0

    return-object v0
.end method

.method private writeReplace()Ljava/lang/Object;
    .locals 2

    .line 832
    new-instance v0, Lcom/fasterxml/jackson/core/JsonPointer$Serialization;

    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/JsonPointer;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/fasterxml/jackson/core/JsonPointer$Serialization;-><init>(Ljava/lang/String;)V

    return-object v0
.end method


# virtual methods
.method protected _constructHead()Lcom/fasterxml/jackson/core/JsonPointer;
    .locals 11

    .line 748
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/JsonPointer;->last()Lcom/fasterxml/jackson/core/JsonPointer;

    move-result-object v0

    .line 749
    .local v0, "last":Lcom/fasterxml/jackson/core/JsonPointer;
    if-ne v0, p0, :cond_0

    .line 750
    sget-object v1, Lcom/fasterxml/jackson/core/JsonPointer;->EMPTY:Lcom/fasterxml/jackson/core/JsonPointer;

    return-object v1

    .line 753
    :cond_0
    invoke-virtual {v0}, Lcom/fasterxml/jackson/core/JsonPointer;->length()I

    move-result v1

    .line 754
    .local v1, "suffixLength":I
    iget-object v2, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_nextSegment:Lcom/fasterxml/jackson/core/JsonPointer;

    .line 756
    .local v2, "next":Lcom/fasterxml/jackson/core/JsonPointer;
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/JsonPointer;->toString()Ljava/lang/String;

    move-result-object v3

    .line 757
    .local v3, "fullString":Ljava/lang/String;
    new-instance v10, Lcom/fasterxml/jackson/core/JsonPointer;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    sub-int/2addr v4, v1

    const/4 v5, 0x0

    invoke-virtual {v3, v5, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    iget-object v7, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_matchingPropertyName:Ljava/lang/String;

    iget v8, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_matchingElementIndex:I

    .line 759
    invoke-virtual {v2, v1, v0}, Lcom/fasterxml/jackson/core/JsonPointer;->_constructHead(ILcom/fasterxml/jackson/core/JsonPointer;)Lcom/fasterxml/jackson/core/JsonPointer;

    move-result-object v9

    const/4 v6, 0x0

    move-object v4, v10

    invoke-direct/range {v4 .. v9}, Lcom/fasterxml/jackson/core/JsonPointer;-><init>(Ljava/lang/String;ILjava/lang/String;ILcom/fasterxml/jackson/core/JsonPointer;)V

    .line 757
    return-object v10
.end method

.method protected _constructHead(ILcom/fasterxml/jackson/core/JsonPointer;)Lcom/fasterxml/jackson/core/JsonPointer;
    .locals 9
    .param p1, "suffixLength"    # I
    .param p2, "last"    # Lcom/fasterxml/jackson/core/JsonPointer;

    .line 764
    if-ne p0, p2, :cond_0

    .line 765
    sget-object v0, Lcom/fasterxml/jackson/core/JsonPointer;->EMPTY:Lcom/fasterxml/jackson/core/JsonPointer;

    return-object v0

    .line 767
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_nextSegment:Lcom/fasterxml/jackson/core/JsonPointer;

    .line 768
    .local v0, "next":Lcom/fasterxml/jackson/core/JsonPointer;
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/JsonPointer;->toString()Ljava/lang/String;

    move-result-object v1

    .line 770
    .local v1, "str":Ljava/lang/String;
    new-instance v8, Lcom/fasterxml/jackson/core/JsonPointer;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    sub-int/2addr v2, p1

    const/4 v3, 0x0

    invoke-virtual {v1, v3, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    iget-object v5, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_matchingPropertyName:Ljava/lang/String;

    iget v6, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_matchingElementIndex:I

    .line 772
    invoke-virtual {v0, p1, p2}, Lcom/fasterxml/jackson/core/JsonPointer;->_constructHead(ILcom/fasterxml/jackson/core/JsonPointer;)Lcom/fasterxml/jackson/core/JsonPointer;

    move-result-object v7

    const/4 v4, 0x0

    move-object v2, v8

    invoke-direct/range {v2 .. v7}, Lcom/fasterxml/jackson/core/JsonPointer;-><init>(Ljava/lang/String;ILjava/lang/String;ILcom/fasterxml/jackson/core/JsonPointer;)V

    .line 770
    return-object v8
.end method

.method public append(Lcom/fasterxml/jackson/core/JsonPointer;)Lcom/fasterxml/jackson/core/JsonPointer;
    .locals 3
    .param p1, "tail"    # Lcom/fasterxml/jackson/core/JsonPointer;

    .line 366
    sget-object v0, Lcom/fasterxml/jackson/core/JsonPointer;->EMPTY:Lcom/fasterxml/jackson/core/JsonPointer;

    if-ne p0, v0, :cond_0

    .line 367
    return-object p1

    .line 369
    :cond_0
    sget-object v0, Lcom/fasterxml/jackson/core/JsonPointer;->EMPTY:Lcom/fasterxml/jackson/core/JsonPointer;

    if-ne p1, v0, :cond_1

    .line 370
    return-object p0

    .line 375
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_asString:Ljava/lang/String;

    .line 376
    .local v0, "currentJsonPointer":Ljava/lang/String;
    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 378
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    const/4 v2, 0x0

    invoke-virtual {v0, v2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 380
    :cond_2
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p1, Lcom/fasterxml/jackson/core/JsonPointer;->_asString:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/fasterxml/jackson/core/JsonPointer;->compile(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonPointer;

    move-result-object v1

    return-object v1
.end method

.method public appendIndex(I)Lcom/fasterxml/jackson/core/JsonPointer;
    .locals 3
    .param p1, "index"    # I

    .line 430
    if-ltz p1, :cond_1

    .line 433
    iget-object v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_asString:Ljava/lang/String;

    .line 434
    .local v0, "currentJsonPointer":Ljava/lang/String;
    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 436
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    const/4 v2, 0x0

    invoke-virtual {v0, v2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 438
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0x2f

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/fasterxml/jackson/core/JsonPointer;->compile(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonPointer;

    move-result-object v1

    return-object v1

    .line 431
    .end local v0    # "currentJsonPointer":Ljava/lang/String;
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Negative index cannot be appended"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public appendProperty(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonPointer;
    .locals 3
    .param p1, "property"    # Ljava/lang/String;

    .line 403
    if-eqz p1, :cond_3

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 406
    :cond_0
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v1

    const/16 v2, 0x2f

    if-eq v1, v2, :cond_1

    .line 407
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 409
    :cond_1
    iget-object v1, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_asString:Ljava/lang/String;

    .line 410
    .local v1, "currentJsonPointer":Ljava/lang/String;
    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 412
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {v1, v0, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    .line 414
    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/fasterxml/jackson/core/JsonPointer;->compile(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonPointer;

    move-result-object v0

    return-object v0

    .line 404
    .end local v1    # "currentJsonPointer":Ljava/lang/String;
    :cond_3
    :goto_0
    return-object p0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 580
    if-ne p1, p0, :cond_0

    const/4 v0, 0x1

    return v0

    .line 581
    :cond_0
    const/4 v0, 0x0

    if-nez p1, :cond_1

    return v0

    .line 582
    :cond_1
    instance-of v1, p1, Lcom/fasterxml/jackson/core/JsonPointer;

    if-nez v1, :cond_2

    return v0

    .line 583
    :cond_2
    move-object v0, p1

    check-cast v0, Lcom/fasterxml/jackson/core/JsonPointer;

    .line 587
    .local v0, "other":Lcom/fasterxml/jackson/core/JsonPointer;
    iget-object v1, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_asString:Ljava/lang/String;

    iget v2, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_asStringOffset:I

    iget-object v3, v0, Lcom/fasterxml/jackson/core/JsonPointer;->_asString:Ljava/lang/String;

    iget v4, v0, Lcom/fasterxml/jackson/core/JsonPointer;->_asStringOffset:I

    invoke-direct {p0, v1, v2, v3, v4}, Lcom/fasterxml/jackson/core/JsonPointer;->_compare(Ljava/lang/String;ILjava/lang/String;I)Z

    move-result v1

    return v1
.end method

.method public getMatchingIndex()I
    .locals 1

    .line 317
    iget v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_matchingElementIndex:I

    return v0
.end method

.method public getMatchingProperty()Ljava/lang/String;
    .locals 1

    .line 316
    iget-object v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_matchingPropertyName:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 2

    .line 565
    iget v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_hashCode:I

    .line 566
    .local v0, "h":I
    if-nez v0, :cond_1

    .line 570
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/JsonPointer;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v0

    .line 571
    if-nez v0, :cond_0

    .line 572
    const/4 v0, -0x1

    .line 574
    :cond_0
    iput v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_hashCode:I

    .line 576
    :cond_1
    return v0
.end method

.method public head()Lcom/fasterxml/jackson/core/JsonPointer;
    .locals 2

    .line 541
    iget-object v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_head:Lcom/fasterxml/jackson/core/JsonPointer;

    .line 542
    .local v0, "h":Lcom/fasterxml/jackson/core/JsonPointer;
    if-nez v0, :cond_1

    .line 543
    sget-object v1, Lcom/fasterxml/jackson/core/JsonPointer;->EMPTY:Lcom/fasterxml/jackson/core/JsonPointer;

    if-eq p0, v1, :cond_0

    .line 544
    invoke-virtual {p0}, Lcom/fasterxml/jackson/core/JsonPointer;->_constructHead()Lcom/fasterxml/jackson/core/JsonPointer;

    move-result-object v0

    .line 546
    :cond_0
    iput-object v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_head:Lcom/fasterxml/jackson/core/JsonPointer;

    .line 548
    :cond_1
    return-object v0
.end method

.method public last()Lcom/fasterxml/jackson/core/JsonPointer;
    .locals 4

    .line 338
    move-object v0, p0

    .line 339
    .local v0, "current":Lcom/fasterxml/jackson/core/JsonPointer;
    sget-object v1, Lcom/fasterxml/jackson/core/JsonPointer;->EMPTY:Lcom/fasterxml/jackson/core/JsonPointer;

    if-ne v0, v1, :cond_0

    .line 340
    const/4 v1, 0x0

    return-object v1

    .line 343
    :cond_0
    :goto_0
    iget-object v1, v0, Lcom/fasterxml/jackson/core/JsonPointer;->_nextSegment:Lcom/fasterxml/jackson/core/JsonPointer;

    move-object v2, v1

    .local v2, "next":Lcom/fasterxml/jackson/core/JsonPointer;
    sget-object v3, Lcom/fasterxml/jackson/core/JsonPointer;->EMPTY:Lcom/fasterxml/jackson/core/JsonPointer;

    if-eq v1, v3, :cond_1

    .line 344
    move-object v0, v2

    goto :goto_0

    .line 346
    :cond_1
    return-object v0
.end method

.method public length()I
    .locals 2

    .line 312
    iget-object v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_asString:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    iget v1, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_asStringOffset:I

    sub-int/2addr v0, v1

    return v0
.end method

.method public matchElement(I)Lcom/fasterxml/jackson/core/JsonPointer;
    .locals 1
    .param p1, "index"    # I

    .line 501
    iget v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_matchingElementIndex:I

    if-ne p1, v0, :cond_1

    if-gez p1, :cond_0

    goto :goto_0

    .line 504
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_nextSegment:Lcom/fasterxml/jackson/core/JsonPointer;

    return-object v0

    .line 502
    :cond_1
    :goto_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public matchProperty(Ljava/lang/String;)Lcom/fasterxml/jackson/core/JsonPointer;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 467
    iget-object v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_nextSegment:Lcom/fasterxml/jackson/core/JsonPointer;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_matchingPropertyName:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 468
    iget-object v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_nextSegment:Lcom/fasterxml/jackson/core/JsonPointer;

    return-object v0

    .line 470
    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public matches()Z
    .locals 1

    .line 315
    iget-object v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_nextSegment:Lcom/fasterxml/jackson/core/JsonPointer;

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public matchesElement(I)Z
    .locals 1
    .param p1, "index"    # I

    .line 484
    iget v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_matchingElementIndex:I

    if-ne p1, v0, :cond_0

    if-ltz p1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public matchesProperty(Ljava/lang/String;)Z
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 452
    iget-object v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_nextSegment:Lcom/fasterxml/jackson/core/JsonPointer;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_matchingPropertyName:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public mayMatchElement()Z
    .locals 1

    .line 329
    iget v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_matchingElementIndex:I

    if-ltz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public mayMatchProperty()Z
    .locals 1

    .line 323
    iget-object v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_matchingPropertyName:Ljava/lang/String;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public tail()Lcom/fasterxml/jackson/core/JsonPointer;
    .locals 1

    .line 521
    iget-object v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_nextSegment:Lcom/fasterxml/jackson/core/JsonPointer;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 558
    iget v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_asStringOffset:I

    if-gtz v0, :cond_0

    .line 559
    iget-object v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_asString:Ljava/lang/String;

    return-object v0

    .line 561
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_asString:Ljava/lang/String;

    iget v1, p0, Lcom/fasterxml/jackson/core/JsonPointer;->_asStringOffset:I

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
