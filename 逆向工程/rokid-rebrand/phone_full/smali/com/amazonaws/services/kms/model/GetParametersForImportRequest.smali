.class public Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "GetParametersForImportRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private keyId:Ljava/lang/String;

.field private wrappingAlgorithm:Ljava/lang/String;

.field private wrappingKeySpec:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 82
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 640
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 641
    return v0

    .line 642
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 643
    return v1

    .line 645
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;

    if-nez v2, :cond_2

    .line 646
    return v1

    .line 647
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;

    .line 649
    .local v2, "other":Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getKeyId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 650
    return v1

    .line 651
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getKeyId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 652
    return v1

    .line 653
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getWrappingAlgorithm()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getWrappingAlgorithm()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 654
    return v1

    .line 655
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getWrappingAlgorithm()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 656
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getWrappingAlgorithm()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getWrappingAlgorithm()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 657
    return v1

    .line 658
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getWrappingKeySpec()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getWrappingKeySpec()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 659
    return v1

    .line 660
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getWrappingKeySpec()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 661
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getWrappingKeySpec()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getWrappingKeySpec()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 662
    return v1

    .line 663
    :cond_e
    return v0
.end method

.method public getKeyId()Ljava/lang/String;
    .locals 1

    .line 207
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->keyId:Ljava/lang/String;

    return-object v0
.end method

.method public getWrappingAlgorithm()Ljava/lang/String;
    .locals 1

    .line 374
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->wrappingAlgorithm:Ljava/lang/String;

    return-object v0
.end method

.method public getWrappingKeySpec()Ljava/lang/String;
    .locals 1

    .line 513
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->wrappingKeySpec:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 627
    const/16 v0, 0x1f

    .line 628
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 630
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 631
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 632
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getWrappingAlgorithm()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getWrappingAlgorithm()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 633
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 634
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getWrappingKeySpec()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getWrappingKeySpec()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_2
    add-int/2addr v2, v4

    .line 635
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public setKeyId(Ljava/lang/String;)V
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 274
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->keyId:Ljava/lang/String;

    .line 275
    return-void
.end method

.method public setWrappingAlgorithm(Lcom/amazonaws/services/kms/model/AlgorithmSpec;)V
    .locals 1
    .param p1, "wrappingAlgorithm"    # Lcom/amazonaws/services/kms/model/AlgorithmSpec;

    .line 461
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/AlgorithmSpec;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->wrappingAlgorithm:Ljava/lang/String;

    .line 462
    return-void
.end method

.method public setWrappingAlgorithm(Ljava/lang/String;)V
    .locals 0
    .param p1, "wrappingAlgorithm"    # Ljava/lang/String;

    .line 401
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->wrappingAlgorithm:Ljava/lang/String;

    .line 402
    return-void
.end method

.method public setWrappingKeySpec(Lcom/amazonaws/services/kms/model/WrappingKeySpec;)V
    .locals 1
    .param p1, "wrappingKeySpec"    # Lcom/amazonaws/services/kms/model/WrappingKeySpec;

    .line 576
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/WrappingKeySpec;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->wrappingKeySpec:Ljava/lang/String;

    .line 577
    return-void
.end method

.method public setWrappingKeySpec(Ljava/lang/String;)V
    .locals 0
    .param p1, "wrappingKeySpec"    # Ljava/lang/String;

    .line 532
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->wrappingKeySpec:Ljava/lang/String;

    .line 533
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 613
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 614
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 615
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getKeyId()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 616
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "KeyId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 617
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getWrappingAlgorithm()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 618
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "WrappingAlgorithm: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getWrappingAlgorithm()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 619
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getWrappingKeySpec()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 620
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "WrappingKeySpec: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->getWrappingKeySpec()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 621
    :cond_2
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 622
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withKeyId(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 346
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->keyId:Ljava/lang/String;

    .line 347
    return-object p0
.end method

.method public withWrappingAlgorithm(Lcom/amazonaws/services/kms/model/AlgorithmSpec;)Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;
    .locals 1
    .param p1, "wrappingAlgorithm"    # Lcom/amazonaws/services/kms/model/AlgorithmSpec;

    .line 493
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/AlgorithmSpec;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->wrappingAlgorithm:Ljava/lang/String;

    .line 494
    return-object p0
.end method

.method public withWrappingAlgorithm(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;
    .locals 0
    .param p1, "wrappingAlgorithm"    # Ljava/lang/String;

    .line 433
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->wrappingAlgorithm:Ljava/lang/String;

    .line 434
    return-object p0
.end method

.method public withWrappingKeySpec(Lcom/amazonaws/services/kms/model/WrappingKeySpec;)Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;
    .locals 1
    .param p1, "wrappingKeySpec"    # Lcom/amazonaws/services/kms/model/WrappingKeySpec;

    .line 600
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/WrappingKeySpec;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->wrappingKeySpec:Ljava/lang/String;

    .line 601
    return-object p0
.end method

.method public withWrappingKeySpec(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;
    .locals 0
    .param p1, "wrappingKeySpec"    # Ljava/lang/String;

    .line 556
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportRequest;->wrappingKeySpec:Ljava/lang/String;

    .line 557
    return-object p0
.end method
