.class public Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;
.super Ljava/lang/Object;
.source "PasswordPolicyType.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private minimumLength:Ljava/lang/Integer;

.field private requireLowercase:Ljava/lang/Boolean;

.field private requireNumbers:Ljava/lang/Boolean;

.field private requireSymbols:Ljava/lang/Boolean;

.field private requireUppercase:Ljava/lang/Boolean;

.field private temporaryPasswordValidityDays:Ljava/lang/Integer;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 589
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 590
    return v0

    .line 591
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 592
    return v1

    .line 594
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;

    if-nez v2, :cond_2

    .line 595
    return v1

    .line 596
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;

    .line 598
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getMinimumLength()Ljava/lang/Integer;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getMinimumLength()Ljava/lang/Integer;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 599
    return v1

    .line 600
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getMinimumLength()Ljava/lang/Integer;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 601
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getMinimumLength()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getMinimumLength()Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Integer;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 602
    return v1

    .line 603
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireUppercase()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireUppercase()Ljava/lang/Boolean;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 604
    return v1

    .line 605
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireUppercase()Ljava/lang/Boolean;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 606
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireUppercase()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireUppercase()Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 607
    return v1

    .line 608
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireLowercase()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireLowercase()Ljava/lang/Boolean;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 609
    return v1

    .line 610
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireLowercase()Ljava/lang/Boolean;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 611
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireLowercase()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireLowercase()Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 612
    return v1

    .line 613
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireNumbers()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireNumbers()Ljava/lang/Boolean;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 614
    return v1

    .line 615
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireNumbers()Ljava/lang/Boolean;

    move-result-object v3

    if-eqz v3, :cond_12

    .line 616
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireNumbers()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireNumbers()Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 617
    return v1

    .line 618
    :cond_12
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireSymbols()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_13

    move v3, v0

    goto :goto_8

    :cond_13
    move v3, v1

    :goto_8
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireSymbols()Ljava/lang/Boolean;

    move-result-object v4

    if-nez v4, :cond_14

    move v4, v0

    goto :goto_9

    :cond_14
    move v4, v1

    :goto_9
    xor-int/2addr v3, v4

    if-eqz v3, :cond_15

    .line 619
    return v1

    .line 620
    :cond_15
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireSymbols()Ljava/lang/Boolean;

    move-result-object v3

    if-eqz v3, :cond_16

    .line 621
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireSymbols()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireSymbols()Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_16

    .line 622
    return v1

    .line 623
    :cond_16
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getTemporaryPasswordValidityDays()Ljava/lang/Integer;

    move-result-object v3

    if-nez v3, :cond_17

    move v3, v0

    goto :goto_a

    :cond_17
    move v3, v1

    .line 624
    :goto_a
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getTemporaryPasswordValidityDays()Ljava/lang/Integer;

    move-result-object v4

    if-nez v4, :cond_18

    move v4, v0

    goto :goto_b

    :cond_18
    move v4, v1

    :goto_b
    xor-int/2addr v3, v4

    if-eqz v3, :cond_19

    .line 625
    return v1

    .line 626
    :cond_19
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getTemporaryPasswordValidityDays()Ljava/lang/Integer;

    move-result-object v3

    if-eqz v3, :cond_1a

    .line 627
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getTemporaryPasswordValidityDays()Ljava/lang/Integer;

    move-result-object v3

    .line 628
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getTemporaryPasswordValidityDays()Ljava/lang/Integer;

    move-result-object v4

    .line 627
    invoke-virtual {v3, v4}, Ljava/lang/Integer;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1a

    .line 629
    return v1

    .line 630
    :cond_1a
    return v0
.end method

.method public getMinimumLength()Ljava/lang/Integer;
    .locals 1

    .line 103
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->minimumLength:Ljava/lang/Integer;

    return-object v0
.end method

.method public getRequireLowercase()Ljava/lang/Boolean;
    .locals 1

    .line 247
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->requireLowercase:Ljava/lang/Boolean;

    return-object v0
.end method

.method public getRequireNumbers()Ljava/lang/Boolean;
    .locals 1

    .line 315
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->requireNumbers:Ljava/lang/Boolean;

    return-object v0
.end method

.method public getRequireSymbols()Ljava/lang/Boolean;
    .locals 1

    .line 383
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->requireSymbols:Ljava/lang/Boolean;

    return-object v0
.end method

.method public getRequireUppercase()Ljava/lang/Boolean;
    .locals 1

    .line 177
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->requireUppercase:Ljava/lang/Boolean;

    return-object v0
.end method

.method public getTemporaryPasswordValidityDays()Ljava/lang/Integer;
    .locals 1

    .line 456
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->temporaryPasswordValidityDays:Ljava/lang/Integer;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 567
    const/16 v0, 0x1f

    .line 568
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 570
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 571
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getMinimumLength()Ljava/lang/Integer;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getMinimumLength()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Integer;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 572
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 573
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireUppercase()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireUppercase()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Boolean;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 574
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 575
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireLowercase()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireLowercase()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Boolean;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 576
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 577
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireNumbers()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v4

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireNumbers()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Boolean;->hashCode()I

    move-result v3

    :goto_3
    add-int/2addr v1, v3

    .line 578
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 579
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireSymbols()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_4

    move v3, v4

    goto :goto_4

    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireSymbols()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Boolean;->hashCode()I

    move-result v3

    :goto_4
    add-int/2addr v2, v3

    .line 580
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 582
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getTemporaryPasswordValidityDays()Ljava/lang/Integer;

    move-result-object v3

    if-nez v3, :cond_5

    goto :goto_5

    .line 583
    :cond_5
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getTemporaryPasswordValidityDays()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Integer;->hashCode()I

    move-result v4

    :goto_5
    add-int/2addr v1, v4

    .line 584
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public isRequireLowercase()Ljava/lang/Boolean;
    .locals 1

    .line 231
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->requireLowercase:Ljava/lang/Boolean;

    return-object v0
.end method

.method public isRequireNumbers()Ljava/lang/Boolean;
    .locals 1

    .line 300
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->requireNumbers:Ljava/lang/Boolean;

    return-object v0
.end method

.method public isRequireSymbols()Ljava/lang/Boolean;
    .locals 1

    .line 368
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->requireSymbols:Ljava/lang/Boolean;

    return-object v0
.end method

.method public isRequireUppercase()Ljava/lang/Boolean;
    .locals 1

    .line 161
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->requireUppercase:Ljava/lang/Boolean;

    return-object v0
.end method

.method public setMinimumLength(Ljava/lang/Integer;)V
    .locals 0
    .param p1, "minimumLength"    # Ljava/lang/Integer;

    .line 121
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->minimumLength:Ljava/lang/Integer;

    .line 122
    return-void
.end method

.method public setRequireLowercase(Ljava/lang/Boolean;)V
    .locals 0
    .param p1, "requireLowercase"    # Ljava/lang/Boolean;

    .line 263
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->requireLowercase:Ljava/lang/Boolean;

    .line 264
    return-void
.end method

.method public setRequireNumbers(Ljava/lang/Boolean;)V
    .locals 0
    .param p1, "requireNumbers"    # Ljava/lang/Boolean;

    .line 331
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->requireNumbers:Ljava/lang/Boolean;

    .line 332
    return-void
.end method

.method public setRequireSymbols(Ljava/lang/Boolean;)V
    .locals 0
    .param p1, "requireSymbols"    # Ljava/lang/Boolean;

    .line 399
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->requireSymbols:Ljava/lang/Boolean;

    .line 400
    return-void
.end method

.method public setRequireUppercase(Ljava/lang/Boolean;)V
    .locals 0
    .param p1, "requireUppercase"    # Ljava/lang/Boolean;

    .line 193
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->requireUppercase:Ljava/lang/Boolean;

    .line 194
    return-void
.end method

.method public setTemporaryPasswordValidityDays(Ljava/lang/Integer;)V
    .locals 0
    .param p1, "temporaryPasswordValidityDays"    # Ljava/lang/Integer;

    .line 492
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->temporaryPasswordValidityDays:Ljava/lang/Integer;

    .line 493
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 547
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 548
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 549
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getMinimumLength()Ljava/lang/Integer;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 550
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "MinimumLength: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getMinimumLength()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 551
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireUppercase()Ljava/lang/Boolean;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 552
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "RequireUppercase: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireUppercase()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 553
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireLowercase()Ljava/lang/Boolean;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 554
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "RequireLowercase: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireLowercase()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 555
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireNumbers()Ljava/lang/Boolean;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 556
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "RequireNumbers: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireNumbers()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 557
    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireSymbols()Ljava/lang/Boolean;

    move-result-object v1

    if-eqz v1, :cond_4

    .line 558
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "RequireSymbols: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getRequireSymbols()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 559
    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getTemporaryPasswordValidityDays()Ljava/lang/Integer;

    move-result-object v1

    if-eqz v1, :cond_5

    .line 560
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "TemporaryPasswordValidityDays: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->getTemporaryPasswordValidityDays()Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 561
    :cond_5
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 562
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withMinimumLength(Ljava/lang/Integer;)Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;
    .locals 0
    .param p1, "minimumLength"    # Ljava/lang/Integer;

    .line 144
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->minimumLength:Ljava/lang/Integer;

    .line 145
    return-object p0
.end method

.method public withRequireLowercase(Ljava/lang/Boolean;)Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;
    .locals 0
    .param p1, "requireLowercase"    # Ljava/lang/Boolean;

    .line 284
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->requireLowercase:Ljava/lang/Boolean;

    .line 285
    return-object p0
.end method

.method public withRequireNumbers(Ljava/lang/Boolean;)Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;
    .locals 0
    .param p1, "requireNumbers"    # Ljava/lang/Boolean;

    .line 352
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->requireNumbers:Ljava/lang/Boolean;

    .line 353
    return-object p0
.end method

.method public withRequireSymbols(Ljava/lang/Boolean;)Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;
    .locals 0
    .param p1, "requireSymbols"    # Ljava/lang/Boolean;

    .line 420
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->requireSymbols:Ljava/lang/Boolean;

    .line 421
    return-object p0
.end method

.method public withRequireUppercase(Ljava/lang/Boolean;)Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;
    .locals 0
    .param p1, "requireUppercase"    # Ljava/lang/Boolean;

    .line 214
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->requireUppercase:Ljava/lang/Boolean;

    .line 215
    return-object p0
.end method

.method public withTemporaryPasswordValidityDays(Ljava/lang/Integer;)Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;
    .locals 0
    .param p1, "temporaryPasswordValidityDays"    # Ljava/lang/Integer;

    .line 534
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/PasswordPolicyType;->temporaryPasswordValidityDays:Ljava/lang/Integer;

    .line 535
    return-object p0
.end method
