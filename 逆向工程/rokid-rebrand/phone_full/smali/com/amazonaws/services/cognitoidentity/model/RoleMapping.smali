.class public Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;
.super Ljava/lang/Object;
.source "RoleMapping.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private ambiguousRoleResolution:Ljava/lang/String;

.field private rulesConfiguration:Lcom/amazonaws/services/cognitoidentity/model/RulesConfigurationType;

.field private type:Ljava/lang/String;


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

    .line 478
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 479
    return v0

    .line 480
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 481
    return v1

    .line 483
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;

    if-nez v2, :cond_2

    .line 484
    return v1

    .line 485
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;

    .line 487
    .local v2, "other":Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getType()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getType()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 488
    return v1

    .line 489
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getType()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getType()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getType()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 490
    return v1

    .line 491
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getAmbiguousRoleResolution()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getAmbiguousRoleResolution()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 492
    return v1

    .line 493
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getAmbiguousRoleResolution()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 494
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getAmbiguousRoleResolution()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getAmbiguousRoleResolution()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 495
    return v1

    .line 496
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getRulesConfiguration()Lcom/amazonaws/services/cognitoidentity/model/RulesConfigurationType;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getRulesConfiguration()Lcom/amazonaws/services/cognitoidentity/model/RulesConfigurationType;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 497
    return v1

    .line 498
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getRulesConfiguration()Lcom/amazonaws/services/cognitoidentity/model/RulesConfigurationType;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 499
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getRulesConfiguration()Lcom/amazonaws/services/cognitoidentity/model/RulesConfigurationType;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getRulesConfiguration()Lcom/amazonaws/services/cognitoidentity/model/RulesConfigurationType;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentity/model/RulesConfigurationType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 500
    return v1

    .line 501
    :cond_e
    return v0
.end method

.method public getAmbiguousRoleResolution()Ljava/lang/String;
    .locals 1

    .line 227
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->ambiguousRoleResolution:Ljava/lang/String;

    return-object v0
.end method

.method public getRulesConfiguration()Lcom/amazonaws/services/cognitoidentity/model/RulesConfigurationType;
    .locals 1

    .line 389
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->rulesConfiguration:Lcom/amazonaws/services/cognitoidentity/model/RulesConfigurationType;

    return-object v0
.end method

.method public getType()Ljava/lang/String;
    .locals 1

    .line 87
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->type:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 463
    const/16 v0, 0x1f

    .line 464
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 466
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getType()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getType()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 467
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 469
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getAmbiguousRoleResolution()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getAmbiguousRoleResolution()Ljava/lang/String;

    move-result-object v3

    .line 470
    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 471
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 472
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getRulesConfiguration()Lcom/amazonaws/services/cognitoidentity/model/RulesConfigurationType;

    move-result-object v3

    if-nez v3, :cond_2

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getRulesConfiguration()Lcom/amazonaws/services/cognitoidentity/model/RulesConfigurationType;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentity/model/RulesConfigurationType;->hashCode()I

    move-result v4

    :goto_2
    add-int/2addr v2, v4

    .line 473
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public setAmbiguousRoleResolution(Lcom/amazonaws/services/cognitoidentity/model/AmbiguousRoleResolutionType;)V
    .locals 1
    .param p1, "ambiguousRoleResolution"    # Lcom/amazonaws/services/cognitoidentity/model/AmbiguousRoleResolutionType;

    .line 329
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentity/model/AmbiguousRoleResolutionType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->ambiguousRoleResolution:Ljava/lang/String;

    .line 330
    return-void
.end method

.method public setAmbiguousRoleResolution(Ljava/lang/String;)V
    .locals 0
    .param p1, "ambiguousRoleResolution"    # Ljava/lang/String;

    .line 259
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->ambiguousRoleResolution:Ljava/lang/String;

    .line 260
    return-void
.end method

.method public setRulesConfiguration(Lcom/amazonaws/services/cognitoidentity/model/RulesConfigurationType;)V
    .locals 0
    .param p1, "rulesConfiguration"    # Lcom/amazonaws/services/cognitoidentity/model/RulesConfigurationType;

    .line 410
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->rulesConfiguration:Lcom/amazonaws/services/cognitoidentity/model/RulesConfigurationType;

    .line 411
    return-void
.end method

.method public setType(Lcom/amazonaws/services/cognitoidentity/model/RoleMappingType;)V
    .locals 1
    .param p1, "type"    # Lcom/amazonaws/services/cognitoidentity/model/RoleMappingType;

    .line 165
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentity/model/RoleMappingType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->type:Ljava/lang/String;

    .line 166
    return-void
.end method

.method public setType(Ljava/lang/String;)V
    .locals 0
    .param p1, "type"    # Ljava/lang/String;

    .line 111
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->type:Ljava/lang/String;

    .line 112
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 449
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 450
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 451
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getType()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 452
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Type: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getType()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 453
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getAmbiguousRoleResolution()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 454
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AmbiguousRoleResolution: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getAmbiguousRoleResolution()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 455
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getRulesConfiguration()Lcom/amazonaws/services/cognitoidentity/model/RulesConfigurationType;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 456
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "RulesConfiguration: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->getRulesConfiguration()Lcom/amazonaws/services/cognitoidentity/model/RulesConfigurationType;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 457
    :cond_2
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 458
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withAmbiguousRoleResolution(Lcom/amazonaws/services/cognitoidentity/model/AmbiguousRoleResolutionType;)Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;
    .locals 1
    .param p1, "ambiguousRoleResolution"    # Lcom/amazonaws/services/cognitoidentity/model/AmbiguousRoleResolutionType;

    .line 367
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentity/model/AmbiguousRoleResolutionType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->ambiguousRoleResolution:Ljava/lang/String;

    .line 368
    return-object p0
.end method

.method public withAmbiguousRoleResolution(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;
    .locals 0
    .param p1, "ambiguousRoleResolution"    # Ljava/lang/String;

    .line 296
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->ambiguousRoleResolution:Ljava/lang/String;

    .line 297
    return-object p0
.end method

.method public withRulesConfiguration(Lcom/amazonaws/services/cognitoidentity/model/RulesConfigurationType;)Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;
    .locals 0
    .param p1, "rulesConfiguration"    # Lcom/amazonaws/services/cognitoidentity/model/RulesConfigurationType;

    .line 436
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->rulesConfiguration:Lcom/amazonaws/services/cognitoidentity/model/RulesConfigurationType;

    .line 437
    return-object p0
.end method

.method public withType(Lcom/amazonaws/services/cognitoidentity/model/RoleMappingType;)Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;
    .locals 1
    .param p1, "type"    # Lcom/amazonaws/services/cognitoidentity/model/RoleMappingType;

    .line 194
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentity/model/RoleMappingType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->type:Ljava/lang/String;

    .line 195
    return-object p0
.end method

.method public withType(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;
    .locals 0
    .param p1, "type"    # Ljava/lang/String;

    .line 140
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/RoleMapping;->type:Ljava/lang/String;

    .line 141
    return-object p0
.end method
