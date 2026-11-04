.class public Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "UpdateCustomKeyStoreRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private cloudHsmClusterId:Ljava/lang/String;

.field private customKeyStoreId:Ljava/lang/String;

.field private keyStorePassword:Ljava/lang/String;

.field private newCustomKeyStoreName:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 122
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 583
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 584
    return v0

    .line 585
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 586
    return v1

    .line 588
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;

    if-nez v2, :cond_2

    .line 589
    return v1

    .line 590
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;

    .line 592
    .local v2, "other":Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getCustomKeyStoreId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getCustomKeyStoreId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 593
    return v1

    .line 594
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getCustomKeyStoreId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 595
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getCustomKeyStoreId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getCustomKeyStoreId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 596
    return v1

    .line 597
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getNewCustomKeyStoreName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getNewCustomKeyStoreName()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 598
    return v1

    .line 599
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getNewCustomKeyStoreName()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 600
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getNewCustomKeyStoreName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getNewCustomKeyStoreName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 601
    return v1

    .line 602
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getKeyStorePassword()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getKeyStorePassword()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 603
    return v1

    .line 604
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getKeyStorePassword()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 605
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getKeyStorePassword()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getKeyStorePassword()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 606
    return v1

    .line 607
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getCloudHsmClusterId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getCloudHsmClusterId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 608
    return v1

    .line 609
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getCloudHsmClusterId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_12

    .line 610
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getCloudHsmClusterId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getCloudHsmClusterId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 611
    return v1

    .line 612
    :cond_12
    return v0
.end method

.method public getCloudHsmClusterId()Ljava/lang/String;
    .locals 1

    .line 446
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->cloudHsmClusterId:Ljava/lang/String;

    return-object v0
.end method

.method public getCustomKeyStoreId()Ljava/lang/String;
    .locals 1

    .line 201
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->customKeyStoreId:Ljava/lang/String;

    return-object v0
.end method

.method public getKeyStorePassword()Ljava/lang/String;
    .locals 1

    .line 339
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->keyStorePassword:Ljava/lang/String;

    return-object v0
.end method

.method public getNewCustomKeyStoreName()Ljava/lang/String;
    .locals 1

    .line 266
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->newCustomKeyStoreName:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 566
    const/16 v0, 0x1f

    .line 567
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 569
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 570
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getCustomKeyStoreId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getCustomKeyStoreId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 571
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 573
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getNewCustomKeyStoreName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getNewCustomKeyStoreName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 574
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 575
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getKeyStorePassword()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getKeyStorePassword()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 576
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 577
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getCloudHsmClusterId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getCloudHsmClusterId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_3
    add-int/2addr v1, v4

    .line 578
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setCloudHsmClusterId(Ljava/lang/String;)V
    .locals 0
    .param p1, "cloudHsmClusterId"    # Ljava/lang/String;

    .line 489
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->cloudHsmClusterId:Ljava/lang/String;

    .line 490
    return-void
.end method

.method public setCustomKeyStoreId(Ljava/lang/String;)V
    .locals 0
    .param p1, "customKeyStoreId"    # Ljava/lang/String;

    .line 221
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->customKeyStoreId:Ljava/lang/String;

    .line 222
    return-void
.end method

.method public setKeyStorePassword(Ljava/lang/String;)V
    .locals 0
    .param p1, "keyStorePassword"    # Ljava/lang/String;

    .line 368
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->keyStorePassword:Ljava/lang/String;

    .line 369
    return-void
.end method

.method public setNewCustomKeyStoreName(Ljava/lang/String;)V
    .locals 0
    .param p1, "newCustomKeyStoreName"    # Ljava/lang/String;

    .line 285
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->newCustomKeyStoreName:Ljava/lang/String;

    .line 286
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 550
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 551
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 552
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getCustomKeyStoreId()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 553
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "CustomKeyStoreId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getCustomKeyStoreId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 554
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getNewCustomKeyStoreName()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 555
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "NewCustomKeyStoreName: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getNewCustomKeyStoreName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 556
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getKeyStorePassword()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 557
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "KeyStorePassword: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getKeyStorePassword()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 558
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getCloudHsmClusterId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 559
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "CloudHsmClusterId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->getCloudHsmClusterId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 560
    :cond_3
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 561
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withCloudHsmClusterId(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;
    .locals 0
    .param p1, "cloudHsmClusterId"    # Ljava/lang/String;

    .line 537
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->cloudHsmClusterId:Ljava/lang/String;

    .line 538
    return-object p0
.end method

.method public withCustomKeyStoreId(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;
    .locals 0
    .param p1, "customKeyStoreId"    # Ljava/lang/String;

    .line 246
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->customKeyStoreId:Ljava/lang/String;

    .line 247
    return-object p0
.end method

.method public withKeyStorePassword(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;
    .locals 0
    .param p1, "keyStorePassword"    # Ljava/lang/String;

    .line 402
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->keyStorePassword:Ljava/lang/String;

    .line 403
    return-object p0
.end method

.method public withNewCustomKeyStoreName(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;
    .locals 0
    .param p1, "newCustomKeyStoreName"    # Ljava/lang/String;

    .line 309
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/UpdateCustomKeyStoreRequest;->newCustomKeyStoreName:Ljava/lang/String;

    .line 310
    return-object p0
.end method
