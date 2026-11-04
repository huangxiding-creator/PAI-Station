.class public Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "SetUserPoolMfaConfigRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private mfaConfiguration:Ljava/lang/String;

.field private smsMfaConfiguration:Lcom/amazonaws/services/cognitoidentityprovider/model/SmsMfaConfigType;

.field private softwareTokenMfaConfiguration:Lcom/amazonaws/services/cognitoidentityprovider/model/SoftwareTokenMfaConfigType;

.field private userPoolId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 27
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 549
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 550
    return v0

    .line 551
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 552
    return v1

    .line 554
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;

    if-nez v2, :cond_2

    .line 555
    return v1

    .line 556
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;

    .line 558
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 559
    return v1

    .line 560
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 561
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 562
    return v1

    .line 563
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getSmsMfaConfiguration()Lcom/amazonaws/services/cognitoidentityprovider/model/SmsMfaConfigType;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getSmsMfaConfiguration()Lcom/amazonaws/services/cognitoidentityprovider/model/SmsMfaConfigType;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 564
    return v1

    .line 565
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getSmsMfaConfiguration()Lcom/amazonaws/services/cognitoidentityprovider/model/SmsMfaConfigType;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 566
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getSmsMfaConfiguration()Lcom/amazonaws/services/cognitoidentityprovider/model/SmsMfaConfigType;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getSmsMfaConfiguration()Lcom/amazonaws/services/cognitoidentityprovider/model/SmsMfaConfigType;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/SmsMfaConfigType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 567
    return v1

    .line 568
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getSoftwareTokenMfaConfiguration()Lcom/amazonaws/services/cognitoidentityprovider/model/SoftwareTokenMfaConfigType;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    .line 569
    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getSoftwareTokenMfaConfiguration()Lcom/amazonaws/services/cognitoidentityprovider/model/SoftwareTokenMfaConfigType;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 570
    return v1

    .line 571
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getSoftwareTokenMfaConfiguration()Lcom/amazonaws/services/cognitoidentityprovider/model/SoftwareTokenMfaConfigType;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 572
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getSoftwareTokenMfaConfiguration()Lcom/amazonaws/services/cognitoidentityprovider/model/SoftwareTokenMfaConfigType;

    move-result-object v3

    .line 573
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getSoftwareTokenMfaConfiguration()Lcom/amazonaws/services/cognitoidentityprovider/model/SoftwareTokenMfaConfigType;

    move-result-object v4

    .line 572
    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/SoftwareTokenMfaConfigType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 574
    return v1

    .line 575
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getMfaConfiguration()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getMfaConfiguration()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 576
    return v1

    .line 577
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getMfaConfiguration()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_12

    .line 578
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getMfaConfiguration()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getMfaConfiguration()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 579
    return v1

    .line 580
    :cond_12
    return v0
.end method

.method public getMfaConfiguration()Ljava/lang/String;
    .locals 1

    .line 280
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->mfaConfiguration:Ljava/lang/String;

    return-object v0
.end method

.method public getSmsMfaConfiguration()Lcom/amazonaws/services/cognitoidentityprovider/model/SmsMfaConfigType;
    .locals 1

    .line 148
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->smsMfaConfiguration:Lcom/amazonaws/services/cognitoidentityprovider/model/SmsMfaConfigType;

    return-object v0
.end method

.method public getSoftwareTokenMfaConfiguration()Lcom/amazonaws/services/cognitoidentityprovider/model/SoftwareTokenMfaConfigType;
    .locals 1

    .line 193
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->softwareTokenMfaConfiguration:Lcom/amazonaws/services/cognitoidentityprovider/model/SoftwareTokenMfaConfigType;

    return-object v0
.end method

.method public getUserPoolId()Ljava/lang/String;
    .locals 1

    .line 95
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->userPoolId:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 532
    const/16 v0, 0x1f

    .line 533
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 535
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 536
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 537
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getSmsMfaConfiguration()Lcom/amazonaws/services/cognitoidentityprovider/model/SmsMfaConfigType;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getSmsMfaConfiguration()Lcom/amazonaws/services/cognitoidentityprovider/model/SmsMfaConfigType;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/SmsMfaConfigType;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 538
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 540
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getSoftwareTokenMfaConfiguration()Lcom/amazonaws/services/cognitoidentityprovider/model/SoftwareTokenMfaConfigType;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    .line 541
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getSoftwareTokenMfaConfiguration()Lcom/amazonaws/services/cognitoidentityprovider/model/SoftwareTokenMfaConfigType;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/SoftwareTokenMfaConfigType;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 542
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 543
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getMfaConfiguration()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getMfaConfiguration()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_3
    add-int/2addr v1, v4

    .line 544
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setMfaConfiguration(Lcom/amazonaws/services/cognitoidentityprovider/model/UserPoolMfaType;)V
    .locals 1
    .param p1, "mfaConfiguration"    # Lcom/amazonaws/services/cognitoidentityprovider/model/UserPoolMfaType;

    .line 445
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/UserPoolMfaType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->mfaConfiguration:Ljava/lang/String;

    .line 446
    return-void
.end method

.method public setMfaConfiguration(Ljava/lang/String;)V
    .locals 0
    .param p1, "mfaConfiguration"    # Ljava/lang/String;

    .line 333
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->mfaConfiguration:Ljava/lang/String;

    .line 334
    return-void
.end method

.method public setSmsMfaConfiguration(Lcom/amazonaws/services/cognitoidentityprovider/model/SmsMfaConfigType;)V
    .locals 0
    .param p1, "smsMfaConfiguration"    # Lcom/amazonaws/services/cognitoidentityprovider/model/SmsMfaConfigType;

    .line 161
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->smsMfaConfiguration:Lcom/amazonaws/services/cognitoidentityprovider/model/SmsMfaConfigType;

    .line 162
    return-void
.end method

.method public setSoftwareTokenMfaConfiguration(Lcom/amazonaws/services/cognitoidentityprovider/model/SoftwareTokenMfaConfigType;)V
    .locals 0
    .param p1, "softwareTokenMfaConfiguration"    # Lcom/amazonaws/services/cognitoidentityprovider/model/SoftwareTokenMfaConfigType;

    .line 207
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->softwareTokenMfaConfiguration:Lcom/amazonaws/services/cognitoidentityprovider/model/SoftwareTokenMfaConfigType;

    .line 208
    return-void
.end method

.method public setUserPoolId(Ljava/lang/String;)V
    .locals 0
    .param p1, "userPoolId"    # Ljava/lang/String;

    .line 112
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->userPoolId:Ljava/lang/String;

    .line 113
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 516
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 517
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 518
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 519
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "UserPoolId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 520
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getSmsMfaConfiguration()Lcom/amazonaws/services/cognitoidentityprovider/model/SmsMfaConfigType;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 521
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SmsMfaConfiguration: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getSmsMfaConfiguration()Lcom/amazonaws/services/cognitoidentityprovider/model/SmsMfaConfigType;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 522
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getSoftwareTokenMfaConfiguration()Lcom/amazonaws/services/cognitoidentityprovider/model/SoftwareTokenMfaConfigType;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 523
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SoftwareTokenMfaConfiguration: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getSoftwareTokenMfaConfiguration()Lcom/amazonaws/services/cognitoidentityprovider/model/SoftwareTokenMfaConfigType;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 524
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getMfaConfiguration()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 525
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "MfaConfiguration: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->getMfaConfiguration()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 526
    :cond_3
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 527
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withMfaConfiguration(Lcom/amazonaws/services/cognitoidentityprovider/model/UserPoolMfaType;)Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;
    .locals 1
    .param p1, "mfaConfiguration"    # Lcom/amazonaws/services/cognitoidentityprovider/model/UserPoolMfaType;

    .line 503
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/UserPoolMfaType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->mfaConfiguration:Ljava/lang/String;

    .line 504
    return-object p0
.end method

.method public withMfaConfiguration(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;
    .locals 0
    .param p1, "mfaConfiguration"    # Ljava/lang/String;

    .line 391
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->mfaConfiguration:Ljava/lang/String;

    .line 392
    return-object p0
.end method

.method public withSmsMfaConfiguration(Lcom/amazonaws/services/cognitoidentityprovider/model/SmsMfaConfigType;)Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;
    .locals 0
    .param p1, "smsMfaConfiguration"    # Lcom/amazonaws/services/cognitoidentityprovider/model/SmsMfaConfigType;

    .line 179
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->smsMfaConfiguration:Lcom/amazonaws/services/cognitoidentityprovider/model/SmsMfaConfigType;

    .line 180
    return-object p0
.end method

.method public withSoftwareTokenMfaConfiguration(Lcom/amazonaws/services/cognitoidentityprovider/model/SoftwareTokenMfaConfigType;)Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;
    .locals 0
    .param p1, "softwareTokenMfaConfiguration"    # Lcom/amazonaws/services/cognitoidentityprovider/model/SoftwareTokenMfaConfigType;

    .line 226
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->softwareTokenMfaConfiguration:Lcom/amazonaws/services/cognitoidentityprovider/model/SoftwareTokenMfaConfigType;

    .line 227
    return-object p0
.end method

.method public withUserPoolId(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;
    .locals 0
    .param p1, "userPoolId"    # Ljava/lang/String;

    .line 134
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SetUserPoolMfaConfigRequest;->userPoolId:Ljava/lang/String;

    .line 135
    return-object p0
.end method
