.class public Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;
.super Ljava/lang/Object;
.source "EventRiskType.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private compromisedCredentialsDetected:Ljava/lang/Boolean;

.field private riskDecision:Ljava/lang/String;

.field private riskLevel:Ljava/lang/String;


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

    .line 352
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 353
    return v0

    .line 354
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 355
    return v1

    .line 357
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;

    if-nez v2, :cond_2

    .line 358
    return v1

    .line 359
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;

    .line 361
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getRiskDecision()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getRiskDecision()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 362
    return v1

    .line 363
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getRiskDecision()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 364
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getRiskDecision()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getRiskDecision()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 365
    return v1

    .line 366
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getRiskLevel()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getRiskLevel()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 367
    return v1

    .line 368
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getRiskLevel()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 369
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getRiskLevel()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getRiskLevel()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 370
    return v1

    .line 371
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getCompromisedCredentialsDetected()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    .line 372
    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getCompromisedCredentialsDetected()Ljava/lang/Boolean;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 373
    return v1

    .line 374
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getCompromisedCredentialsDetected()Ljava/lang/Boolean;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 375
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getCompromisedCredentialsDetected()Ljava/lang/Boolean;

    move-result-object v3

    .line 376
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getCompromisedCredentialsDetected()Ljava/lang/Boolean;

    move-result-object v4

    .line 375
    invoke-virtual {v3, v4}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 377
    return v1

    .line 378
    :cond_e
    return v0
.end method

.method public getCompromisedCredentialsDetected()Ljava/lang/Boolean;
    .locals 1

    .line 275
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->compromisedCredentialsDetected:Ljava/lang/Boolean;

    return-object v0
.end method

.method public getRiskDecision()Ljava/lang/String;
    .locals 1

    .line 68
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->riskDecision:Ljava/lang/String;

    return-object v0
.end method

.method public getRiskLevel()Ljava/lang/String;
    .locals 1

    .line 165
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->riskLevel:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 337
    const/16 v0, 0x1f

    .line 338
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 340
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 341
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getRiskDecision()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getRiskDecision()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 342
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getRiskLevel()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getRiskLevel()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 343
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 345
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getCompromisedCredentialsDetected()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_2

    goto :goto_2

    .line 346
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getCompromisedCredentialsDetected()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Boolean;->hashCode()I

    move-result v4

    :goto_2
    add-int/2addr v2, v4

    .line 347
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public isCompromisedCredentialsDetected()Ljava/lang/Boolean;
    .locals 1

    .line 260
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->compromisedCredentialsDetected:Ljava/lang/Boolean;

    return-object v0
.end method

.method public setCompromisedCredentialsDetected(Ljava/lang/Boolean;)V
    .locals 0
    .param p1, "compromisedCredentialsDetected"    # Ljava/lang/Boolean;

    .line 290
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->compromisedCredentialsDetected:Ljava/lang/Boolean;

    .line 291
    return-void
.end method

.method public setRiskDecision(Lcom/amazonaws/services/cognitoidentityprovider/model/RiskDecisionType;)V
    .locals 1
    .param p1, "riskDecision"    # Lcom/amazonaws/services/cognitoidentityprovider/model/RiskDecisionType;

    .line 125
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskDecisionType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->riskDecision:Ljava/lang/String;

    .line 126
    return-void
.end method

.method public setRiskDecision(Ljava/lang/String;)V
    .locals 0
    .param p1, "riskDecision"    # Ljava/lang/String;

    .line 85
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->riskDecision:Ljava/lang/String;

    .line 86
    return-void
.end method

.method public setRiskLevel(Lcom/amazonaws/services/cognitoidentityprovider/model/RiskLevelType;)V
    .locals 1
    .param p1, "riskLevel"    # Lcom/amazonaws/services/cognitoidentityprovider/model/RiskLevelType;

    .line 222
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskLevelType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->riskLevel:Ljava/lang/String;

    .line 223
    return-void
.end method

.method public setRiskLevel(Ljava/lang/String;)V
    .locals 0
    .param p1, "riskLevel"    # Ljava/lang/String;

    .line 182
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->riskLevel:Ljava/lang/String;

    .line 183
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 323
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 324
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 325
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getRiskDecision()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 326
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "RiskDecision: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getRiskDecision()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 327
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getRiskLevel()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 328
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "RiskLevel: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getRiskLevel()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 329
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getCompromisedCredentialsDetected()Ljava/lang/Boolean;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 330
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "CompromisedCredentialsDetected: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->getCompromisedCredentialsDetected()Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 331
    :cond_2
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 332
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withCompromisedCredentialsDetected(Ljava/lang/Boolean;)Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;
    .locals 0
    .param p1, "compromisedCredentialsDetected"    # Ljava/lang/Boolean;

    .line 310
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->compromisedCredentialsDetected:Ljava/lang/Boolean;

    .line 311
    return-object p0
.end method

.method public withRiskDecision(Lcom/amazonaws/services/cognitoidentityprovider/model/RiskDecisionType;)Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;
    .locals 1
    .param p1, "riskDecision"    # Lcom/amazonaws/services/cognitoidentityprovider/model/RiskDecisionType;

    .line 147
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskDecisionType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->riskDecision:Ljava/lang/String;

    .line 148
    return-object p0
.end method

.method public withRiskDecision(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;
    .locals 0
    .param p1, "riskDecision"    # Ljava/lang/String;

    .line 107
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->riskDecision:Ljava/lang/String;

    .line 108
    return-object p0
.end method

.method public withRiskLevel(Lcom/amazonaws/services/cognitoidentityprovider/model/RiskLevelType;)Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;
    .locals 1
    .param p1, "riskLevel"    # Lcom/amazonaws/services/cognitoidentityprovider/model/RiskLevelType;

    .line 244
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskLevelType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->riskLevel:Ljava/lang/String;

    .line 245
    return-object p0
.end method

.method public withRiskLevel(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;
    .locals 0
    .param p1, "riskLevel"    # Ljava/lang/String;

    .line 204
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->riskLevel:Ljava/lang/String;

    .line 205
    return-object p0
.end method
