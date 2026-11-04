.class public Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;
.super Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$LayoutElement;
.source "NewAttributeBands.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "Union"
.end annotation


# instance fields
.field private caseCounts:[I

.field private final defaultCaseBody:Ljava/util/List;

.field private defaultCount:I

.field final synthetic this$0:Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;

.field private final unionCases:Ljava/util/List;

.field private final unionTag:Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Integral;


# direct methods
.method public constructor <init>(Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;Ljava/lang/String;Ljava/util/List;Ljava/util/List;)V
    .locals 1
    .param p1, "this$0"    # Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;
    .param p2, "tag"    # Ljava/lang/String;
    .param p3, "unionCases"    # Ljava/util/List;
    .param p4, "body"    # Ljava/util/List;

    .line 512
    iput-object p1, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->this$0:Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$LayoutElement;-><init>(Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$1;)V

    .line 513
    new-instance v0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Integral;

    invoke-direct {v0, p1, p2}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Integral;-><init>(Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;Ljava/lang/String;)V

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->unionTag:Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Integral;

    .line 514
    iput-object p3, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->unionCases:Ljava/util/List;

    .line 515
    iput-object p4, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->defaultCaseBody:Ljava/util/List;

    .line 516
    return-void
.end method


# virtual methods
.method public addToAttribute(ILorg/apache/commons/compress/harmony/unpack200/bytecode/NewAttribute;)V
    .locals 12
    .param p1, "n"    # I
    .param p2, "attribute"    # Lorg/apache/commons/compress/harmony/unpack200/bytecode/NewAttribute;

    .line 556
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->unionTag:Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Integral;

    invoke-virtual {v0, p1, p2}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Integral;->addToAttribute(ILorg/apache/commons/compress/harmony/unpack200/bytecode/NewAttribute;)V

    .line 557
    const/4 v0, 0x0

    .line 558
    .local v0, "offset":I
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->unionTag:Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Integral;

    invoke-static {v1}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Integral;->access$600(Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Integral;)[I

    move-result-object v1

    .line 559
    .local v1, "tagBand":[I
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->unionTag:Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Integral;

    invoke-virtual {v2, p1}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Integral;->getValue(I)J

    move-result-wide v2

    .line 560
    .local v2, "tag":J
    const/4 v4, 0x1

    .line 561
    .local v4, "defaultCase":Z
    const/4 v5, 0x0

    .local v5, "i":I
    :goto_0
    iget-object v6, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->unionCases:Ljava/util/List;

    invoke-interface {v6}, Ljava/util/List;->size()I

    move-result v6

    if-ge v5, v6, :cond_3

    .line 562
    iget-object v6, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->unionCases:Ljava/util/List;

    invoke-interface {v6, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$UnionCase;

    .line 563
    .local v6, "element":Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$UnionCase;
    invoke-virtual {v6, v2, v3}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$UnionCase;->hasTag(J)Z

    move-result v7

    if-eqz v7, :cond_2

    .line 564
    const/4 v4, 0x0

    .line 565
    const/4 v7, 0x0

    .local v7, "j":I
    :goto_1
    if-ge v7, p1, :cond_1

    .line 566
    aget v8, v1, v7

    int-to-long v8, v8

    invoke-virtual {v6, v8, v9}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$UnionCase;->hasTag(J)Z

    move-result v8

    if-eqz v8, :cond_0

    .line 567
    add-int/lit8 v0, v0, 0x1

    .line 565
    :cond_0
    add-int/lit8 v7, v7, 0x1

    goto :goto_1

    .line 570
    .end local v7    # "j":I
    :cond_1
    invoke-virtual {v6, v0, p2}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$UnionCase;->addToAttribute(ILorg/apache/commons/compress/harmony/unpack200/bytecode/NewAttribute;)V

    .line 561
    .end local v6    # "element":Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$UnionCase;
    :cond_2
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 573
    .end local v5    # "i":I
    :cond_3
    if-eqz v4, :cond_8

    .line 575
    const/4 v5, 0x0

    .line 576
    .local v5, "defaultOffset":I
    const/4 v6, 0x0

    .local v6, "j":I
    :goto_2
    if-ge v6, p1, :cond_7

    .line 577
    const/4 v7, 0x0

    .line 578
    .local v7, "found":Z
    const/4 v8, 0x0

    .local v8, "i":I
    :goto_3
    iget-object v9, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->unionCases:Ljava/util/List;

    invoke-interface {v9}, Ljava/util/List;->size()I

    move-result v9

    if-ge v8, v9, :cond_5

    .line 579
    iget-object v9, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->unionCases:Ljava/util/List;

    invoke-interface {v9, v8}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$UnionCase;

    .line 580
    .local v9, "element":Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$UnionCase;
    aget v10, v1, v6

    int-to-long v10, v10

    invoke-virtual {v9, v10, v11}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$UnionCase;->hasTag(J)Z

    move-result v10

    if-eqz v10, :cond_4

    .line 581
    const/4 v7, 0x1

    .line 578
    .end local v9    # "element":Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$UnionCase;
    :cond_4
    add-int/lit8 v8, v8, 0x1

    goto :goto_3

    .line 584
    .end local v8    # "i":I
    :cond_5
    if-nez v7, :cond_6

    .line 585
    add-int/lit8 v5, v5, 0x1

    .line 576
    .end local v7    # "found":Z
    :cond_6
    add-int/lit8 v6, v6, 0x1

    goto :goto_2

    .line 588
    .end local v6    # "j":I
    :cond_7
    iget-object v6, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->defaultCaseBody:Ljava/util/List;

    if-eqz v6, :cond_8

    .line 589
    const/4 v6, 0x0

    .local v6, "i":I
    :goto_4
    iget-object v7, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->defaultCaseBody:Ljava/util/List;

    invoke-interface {v7}, Ljava/util/List;->size()I

    move-result v7

    if-ge v6, v7, :cond_8

    .line 590
    iget-object v7, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->defaultCaseBody:Ljava/util/List;

    invoke-interface {v7, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$LayoutElement;

    .line 591
    .local v7, "element":Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$LayoutElement;
    invoke-virtual {v7, v5, p2}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$LayoutElement;->addToAttribute(ILorg/apache/commons/compress/harmony/unpack200/bytecode/NewAttribute;)V

    .line 589
    .end local v7    # "element":Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$LayoutElement;
    add-int/lit8 v6, v6, 0x1

    goto :goto_4

    .line 595
    .end local v5    # "defaultOffset":I
    .end local v6    # "i":I
    :cond_8
    return-void
.end method

.method public getDefaultCaseBody()Ljava/util/List;
    .locals 1

    .line 606
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->defaultCaseBody:Ljava/util/List;

    return-object v0
.end method

.method public getUnionCases()Ljava/util/List;
    .locals 1

    .line 602
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->unionCases:Ljava/util/List;

    return-object v0
.end method

.method public getUnionTag()Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Integral;
    .locals 1

    .line 598
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->unionTag:Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Integral;

    return-object v0
.end method

.method public readBands(Ljava/io/InputStream;I)V
    .locals 7
    .param p1, "in"    # Ljava/io/InputStream;
    .param p2, "count"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 520
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->unionTag:Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Integral;

    invoke-virtual {v0, p1, p2}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Integral;->readBands(Ljava/io/InputStream;I)V

    .line 521
    iget-object v0, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->unionTag:Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Integral;

    invoke-static {v0}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Integral;->access$600(Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Integral;)[I

    move-result-object v0

    .line 523
    .local v0, "values":[I
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->unionCases:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    new-array v1, v1, [I

    iput-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->caseCounts:[I

    .line 524
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->caseCounts:[I

    array-length v2, v2

    if-ge v1, v2, :cond_2

    .line 525
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->unionCases:Ljava/util/List;

    invoke-interface {v2, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$UnionCase;

    .line 526
    .local v2, "unionCase":Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$UnionCase;
    const/4 v3, 0x0

    .local v3, "j":I
    :goto_1
    array-length v4, v0

    if-ge v3, v4, :cond_1

    .line 527
    aget v4, v0, v3

    int-to-long v4, v4

    invoke-virtual {v2, v4, v5}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$UnionCase;->hasTag(J)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 528
    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->caseCounts:[I

    aget v5, v4, v1

    add-int/lit8 v5, v5, 0x1

    aput v5, v4, v1

    .line 526
    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 531
    .end local v3    # "j":I
    :cond_1
    iget-object v3, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->caseCounts:[I

    aget v3, v3, v1

    invoke-virtual {v2, p1, v3}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$UnionCase;->readBands(Ljava/io/InputStream;I)V

    .line 524
    .end local v2    # "unionCase":Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$UnionCase;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 534
    .end local v1    # "i":I
    :cond_2
    const/4 v1, 0x0

    .restart local v1    # "i":I
    :goto_2
    array-length v2, v0

    if-ge v1, v2, :cond_6

    .line 535
    const/4 v2, 0x0

    .line 536
    .local v2, "found":Z
    const/4 v3, 0x0

    .local v3, "it":I
    :goto_3
    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->unionCases:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    if-ge v3, v4, :cond_4

    .line 537
    iget-object v4, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->unionCases:Ljava/util/List;

    invoke-interface {v4, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$UnionCase;

    .line 538
    .local v4, "unionCase":Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$UnionCase;
    aget v5, v0, v1

    int-to-long v5, v5

    invoke-virtual {v4, v5, v6}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$UnionCase;->hasTag(J)Z

    move-result v5

    if-eqz v5, :cond_3

    .line 539
    const/4 v2, 0x1

    .line 536
    .end local v4    # "unionCase":Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$UnionCase;
    :cond_3
    add-int/lit8 v3, v3, 0x1

    goto :goto_3

    .line 542
    .end local v3    # "it":I
    :cond_4
    if-nez v2, :cond_5

    .line 543
    iget v3, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->defaultCount:I

    add-int/lit8 v3, v3, 0x1

    iput v3, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->defaultCount:I

    .line 534
    .end local v2    # "found":Z
    :cond_5
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 546
    .end local v1    # "i":I
    :cond_6
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->defaultCaseBody:Ljava/util/List;

    if-eqz v1, :cond_7

    .line 547
    const/4 v1, 0x0

    .restart local v1    # "i":I
    :goto_4
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->defaultCaseBody:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    if-ge v1, v2, :cond_7

    .line 548
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->defaultCaseBody:Ljava/util/List;

    invoke-interface {v2, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$LayoutElement;

    .line 549
    .local v2, "element":Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$LayoutElement;
    iget v3, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$Union;->defaultCount:I

    invoke-virtual {v2, p1, v3}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$LayoutElement;->readBands(Ljava/io/InputStream;I)V

    .line 547
    .end local v2    # "element":Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$LayoutElement;
    add-int/lit8 v1, v1, 0x1

    goto :goto_4

    .line 552
    .end local v1    # "i":I
    :cond_7
    return-void
.end method
