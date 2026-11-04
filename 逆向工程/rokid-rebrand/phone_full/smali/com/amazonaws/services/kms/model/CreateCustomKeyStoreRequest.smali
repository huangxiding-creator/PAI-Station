.class public Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "CreateCustomKeyStoreRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private cloudHsmClusterId:Ljava/lang/String;

.field private customKeyStoreName:Ljava/lang/String;

.field private keyStorePassword:Ljava/lang/String;

.field private trustAnchorCertificate:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 99
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 558
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 559
    return v0

    .line 560
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 561
    return v1

    .line 563
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;

    if-nez v2, :cond_2

    .line 564
    return v1

    .line 565
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;

    .line 567
    .local v2, "other":Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getCustomKeyStoreName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getCustomKeyStoreName()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 568
    return v1

    .line 569
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getCustomKeyStoreName()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 570
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getCustomKeyStoreName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getCustomKeyStoreName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 571
    return v1

    .line 572
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getCloudHsmClusterId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getCloudHsmClusterId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 573
    return v1

    .line 574
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getCloudHsmClusterId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 575
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getCloudHsmClusterId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getCloudHsmClusterId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 576
    return v1

    .line 577
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getTrustAnchorCertificate()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getTrustAnchorCertificate()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 578
    return v1

    .line 579
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getTrustAnchorCertificate()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 580
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getTrustAnchorCertificate()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getTrustAnchorCertificate()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 581
    return v1

    .line 582
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getKeyStorePassword()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getKeyStorePassword()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 583
    return v1

    .line 584
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getKeyStorePassword()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_12

    .line 585
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getKeyStorePassword()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getKeyStorePassword()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 586
    return v1

    .line 587
    :cond_12
    return v0
.end method

.method public getCloudHsmClusterId()Ljava/lang/String;
    .locals 1

    .line 245
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->cloudHsmClusterId:Ljava/lang/String;

    return-object v0
.end method

.method public getCustomKeyStoreName()Ljava/lang/String;
    .locals 1

    .line 177
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->customKeyStoreName:Ljava/lang/String;

    return-object v0
.end method

.method public getKeyStorePassword()Ljava/lang/String;
    .locals 1

    .line 424
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->keyStorePassword:Ljava/lang/String;

    return-object v0
.end method

.method public getTrustAnchorCertificate()Ljava/lang/String;
    .locals 1

    .line 327
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->trustAnchorCertificate:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 540
    const/16 v0, 0x1f

    .line 541
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 543
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 544
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getCustomKeyStoreName()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getCustomKeyStoreName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 545
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 546
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getCloudHsmClusterId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getCloudHsmClusterId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 547
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 549
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getTrustAnchorCertificate()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getTrustAnchorCertificate()Ljava/lang/String;

    move-result-object v3

    .line 550
    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 551
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 552
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getKeyStorePassword()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getKeyStorePassword()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_3
    add-int/2addr v1, v4

    .line 553
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setCloudHsmClusterId(Ljava/lang/String;)V
    .locals 0
    .param p1, "cloudHsmClusterId"    # Ljava/lang/String;

    .line 271
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->cloudHsmClusterId:Ljava/lang/String;

    .line 272
    return-void
.end method

.method public setCustomKeyStoreName(Ljava/lang/String;)V
    .locals 0
    .param p1, "customKeyStoreName"    # Ljava/lang/String;

    .line 195
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->customKeyStoreName:Ljava/lang/String;

    .line 196
    return-void
.end method

.method public setKeyStorePassword(Ljava/lang/String;)V
    .locals 0
    .param p1, "keyStorePassword"    # Ljava/lang/String;

    .line 465
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->keyStorePassword:Ljava/lang/String;

    .line 466
    return-void
.end method

.method public setTrustAnchorCertificate(Ljava/lang/String;)V
    .locals 0
    .param p1, "trustAnchorCertificate"    # Ljava/lang/String;

    .line 352
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->trustAnchorCertificate:Ljava/lang/String;

    .line 353
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 524
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 525
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 526
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getCustomKeyStoreName()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 527
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "CustomKeyStoreName: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getCustomKeyStoreName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 528
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getCloudHsmClusterId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 529
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "CloudHsmClusterId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getCloudHsmClusterId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 530
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getTrustAnchorCertificate()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 531
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "TrustAnchorCertificate: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getTrustAnchorCertificate()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 532
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getKeyStorePassword()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 533
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "KeyStorePassword: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->getKeyStorePassword()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 534
    :cond_3
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 535
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withCloudHsmClusterId(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;
    .locals 0
    .param p1, "cloudHsmClusterId"    # Ljava/lang/String;

    .line 302
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->cloudHsmClusterId:Ljava/lang/String;

    .line 303
    return-object p0
.end method

.method public withCustomKeyStoreName(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;
    .locals 0
    .param p1, "customKeyStoreName"    # Ljava/lang/String;

    .line 218
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->customKeyStoreName:Ljava/lang/String;

    .line 219
    return-object p0
.end method

.method public withKeyStorePassword(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;
    .locals 0
    .param p1, "keyStorePassword"    # Ljava/lang/String;

    .line 511
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->keyStorePassword:Ljava/lang/String;

    .line 512
    return-object p0
.end method

.method public withTrustAnchorCertificate(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;
    .locals 0
    .param p1, "trustAnchorCertificate"    # Ljava/lang/String;

    .line 382
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/CreateCustomKeyStoreRequest;->trustAnchorCertificate:Ljava/lang/String;

    .line 383
    return-object p0
.end method
