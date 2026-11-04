.class public Lcom/amazonaws/services/kms/model/UpdateAliasRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "UpdateAliasRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private aliasName:Ljava/lang/String;

.field private targetKeyId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 112
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 562
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 563
    return v0

    .line 564
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 565
    return v1

    .line 567
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;

    if-nez v2, :cond_2

    .line 568
    return v1

    .line 569
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;

    .line 571
    .local v2, "other":Lcom/amazonaws/services/kms/model/UpdateAliasRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->getAliasName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->getAliasName()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 572
    return v1

    .line 573
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->getAliasName()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 574
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->getAliasName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->getAliasName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 575
    return v1

    .line 576
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->getTargetKeyId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->getTargetKeyId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 577
    return v1

    .line 578
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->getTargetKeyId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 579
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->getTargetKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->getTargetKeyId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 580
    return v1

    .line 581
    :cond_a
    return v0
.end method

.method public getAliasName()Ljava/lang/String;
    .locals 1

    .line 194
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->aliasName:Ljava/lang/String;

    return-object v0
.end method

.method public getTargetKeyId()Ljava/lang/String;
    .locals 1

    .line 337
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->targetKeyId:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 551
    const/16 v0, 0x1f

    .line 552
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 554
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->getAliasName()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->getAliasName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 555
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 556
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->getTargetKeyId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->getTargetKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_1
    add-int/2addr v1, v4

    .line 557
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setAliasName(Ljava/lang/String;)V
    .locals 0
    .param p1, "aliasName"    # Ljava/lang/String;

    .line 217
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->aliasName:Ljava/lang/String;

    .line 218
    return-void
.end method

.method public setTargetKeyId(Ljava/lang/String;)V
    .locals 0
    .param p1, "targetKeyId"    # Ljava/lang/String;

    .line 429
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->targetKeyId:Ljava/lang/String;

    .line 430
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 539
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 540
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 541
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->getAliasName()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 542
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "AliasName: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->getAliasName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 543
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->getTargetKeyId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 544
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "TargetKeyId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->getTargetKeyId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 545
    :cond_1
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 546
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withAliasName(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/UpdateAliasRequest;
    .locals 0
    .param p1, "aliasName"    # Ljava/lang/String;

    .line 245
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->aliasName:Ljava/lang/String;

    .line 246
    return-object p0
.end method

.method public withTargetKeyId(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/UpdateAliasRequest;
    .locals 0
    .param p1, "targetKeyId"    # Ljava/lang/String;

    .line 526
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/UpdateAliasRequest;->targetKeyId:Ljava/lang/String;

    .line 527
    return-object p0
.end method
