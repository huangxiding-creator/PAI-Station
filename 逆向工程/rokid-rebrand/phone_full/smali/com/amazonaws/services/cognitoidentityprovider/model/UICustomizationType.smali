.class public Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;
.super Ljava/lang/Object;
.source "UICustomizationType.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private cSS:Ljava/lang/String;

.field private cSSVersion:Ljava/lang/String;

.field private clientId:Ljava/lang/String;

.field private creationDate:Ljava/util/Date;

.field private imageUrl:Ljava/lang/String;

.field private lastModifiedDate:Ljava/util/Date;

.field private userPoolId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 471
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 472
    return v0

    .line 473
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 474
    return v1

    .line 476
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;

    if-nez v2, :cond_2

    .line 477
    return v1

    .line 478
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;

    .line 480
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getUserPoolId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 481
    return v1

    .line 482
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 483
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getUserPoolId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 484
    return v1

    .line 485
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getClientId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getClientId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 486
    return v1

    .line 487
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getClientId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getClientId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getClientId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 488
    return v1

    .line 489
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getImageUrl()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getImageUrl()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 490
    return v1

    .line 491
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getImageUrl()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getImageUrl()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getImageUrl()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 492
    return v1

    .line 493
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCSS()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCSS()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 494
    return v1

    .line 495
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCSS()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_12

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCSS()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCSS()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 496
    return v1

    .line 497
    :cond_12
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCSSVersion()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_13

    move v3, v0

    goto :goto_8

    :cond_13
    move v3, v1

    :goto_8
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCSSVersion()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_14

    move v4, v0

    goto :goto_9

    :cond_14
    move v4, v1

    :goto_9
    xor-int/2addr v3, v4

    if-eqz v3, :cond_15

    .line 498
    return v1

    .line 499
    :cond_15
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCSSVersion()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_16

    .line 500
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCSSVersion()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCSSVersion()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_16

    .line 501
    return v1

    .line 502
    :cond_16
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getLastModifiedDate()Ljava/util/Date;

    move-result-object v3

    if-nez v3, :cond_17

    move v3, v0

    goto :goto_a

    :cond_17
    move v3, v1

    :goto_a
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getLastModifiedDate()Ljava/util/Date;

    move-result-object v4

    if-nez v4, :cond_18

    move v4, v0

    goto :goto_b

    :cond_18
    move v4, v1

    :goto_b
    xor-int/2addr v3, v4

    if-eqz v3, :cond_19

    .line 503
    return v1

    .line 504
    :cond_19
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getLastModifiedDate()Ljava/util/Date;

    move-result-object v3

    if-eqz v3, :cond_1a

    .line 505
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getLastModifiedDate()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getLastModifiedDate()Ljava/util/Date;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/Date;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1a

    .line 506
    return v1

    .line 507
    :cond_1a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCreationDate()Ljava/util/Date;

    move-result-object v3

    if-nez v3, :cond_1b

    move v3, v0

    goto :goto_c

    :cond_1b
    move v3, v1

    :goto_c
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCreationDate()Ljava/util/Date;

    move-result-object v4

    if-nez v4, :cond_1c

    move v4, v0

    goto :goto_d

    :cond_1c
    move v4, v1

    :goto_d
    xor-int/2addr v3, v4

    if-eqz v3, :cond_1d

    .line 508
    return v1

    .line 509
    :cond_1d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCreationDate()Ljava/util/Date;

    move-result-object v3

    if-eqz v3, :cond_1e

    .line 510
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCreationDate()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCreationDate()Ljava/util/Date;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/Date;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1e

    .line 511
    return v1

    .line 512
    :cond_1e
    return v0
.end method

.method public getCSS()Ljava/lang/String;
    .locals 1

    .line 253
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->cSS:Ljava/lang/String;

    return-object v0
.end method

.method public getCSSVersion()Ljava/lang/String;
    .locals 1

    .line 298
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->cSSVersion:Ljava/lang/String;

    return-object v0
.end method

.method public getClientId()Ljava/lang/String;
    .locals 1

    .line 155
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->clientId:Ljava/lang/String;

    return-object v0
.end method

.method public getCreationDate()Ljava/util/Date;
    .locals 1

    .line 388
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->creationDate:Ljava/util/Date;

    return-object v0
.end method

.method public getImageUrl()Ljava/lang/String;
    .locals 1

    .line 208
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->imageUrl:Ljava/lang/String;

    return-object v0
.end method

.method public getLastModifiedDate()Ljava/util/Date;
    .locals 1

    .line 343
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->lastModifiedDate:Ljava/util/Date;

    return-object v0
.end method

.method public getUserPoolId()Ljava/lang/String;
    .locals 1

    .line 98
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->userPoolId:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 454
    const/16 v0, 0x1f

    .line 455
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 457
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 458
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getClientId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getClientId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 459
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getImageUrl()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getImageUrl()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 460
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCSS()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v4

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCSS()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_3
    add-int/2addr v1, v3

    .line 461
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCSSVersion()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_4

    move v3, v4

    goto :goto_4

    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCSSVersion()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_4
    add-int/2addr v2, v3

    .line 462
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 463
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getLastModifiedDate()Ljava/util/Date;

    move-result-object v3

    if-nez v3, :cond_5

    move v3, v4

    goto :goto_5

    :cond_5
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getLastModifiedDate()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/Date;->hashCode()I

    move-result v3

    :goto_5
    add-int/2addr v1, v3

    .line 464
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 465
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCreationDate()Ljava/util/Date;

    move-result-object v3

    if-nez v3, :cond_6

    goto :goto_6

    :cond_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCreationDate()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/Date;->hashCode()I

    move-result v4

    :goto_6
    add-int/2addr v2, v4

    .line 466
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public setCSS(Ljava/lang/String;)V
    .locals 0
    .param p1, "cSS"    # Ljava/lang/String;

    .line 266
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->cSS:Ljava/lang/String;

    .line 267
    return-void
.end method

.method public setCSSVersion(Ljava/lang/String;)V
    .locals 0
    .param p1, "cSSVersion"    # Ljava/lang/String;

    .line 311
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->cSSVersion:Ljava/lang/String;

    .line 312
    return-void
.end method

.method public setClientId(Ljava/lang/String;)V
    .locals 0
    .param p1, "clientId"    # Ljava/lang/String;

    .line 172
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->clientId:Ljava/lang/String;

    .line 173
    return-void
.end method

.method public setCreationDate(Ljava/util/Date;)V
    .locals 0
    .param p1, "creationDate"    # Ljava/util/Date;

    .line 401
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->creationDate:Ljava/util/Date;

    .line 402
    return-void
.end method

.method public setImageUrl(Ljava/lang/String;)V
    .locals 0
    .param p1, "imageUrl"    # Ljava/lang/String;

    .line 221
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->imageUrl:Ljava/lang/String;

    .line 222
    return-void
.end method

.method public setLastModifiedDate(Ljava/util/Date;)V
    .locals 0
    .param p1, "lastModifiedDate"    # Ljava/util/Date;

    .line 356
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->lastModifiedDate:Ljava/util/Date;

    .line 357
    return-void
.end method

.method public setUserPoolId(Ljava/lang/String;)V
    .locals 0
    .param p1, "userPoolId"    # Ljava/lang/String;

    .line 115
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->userPoolId:Ljava/lang/String;

    .line 116
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 432
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 433
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 434
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getUserPoolId()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 435
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "UserPoolId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 436
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getClientId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 437
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ClientId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getClientId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 438
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getImageUrl()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 439
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ImageUrl: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getImageUrl()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 440
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCSS()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 441
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "CSS: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCSS()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 442
    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCSSVersion()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_4

    .line 443
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "CSSVersion: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCSSVersion()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 444
    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getLastModifiedDate()Ljava/util/Date;

    move-result-object v1

    if-eqz v1, :cond_5

    .line 445
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "LastModifiedDate: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getLastModifiedDate()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 446
    :cond_5
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCreationDate()Ljava/util/Date;

    move-result-object v1

    if-eqz v1, :cond_6

    .line 447
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "CreationDate: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->getCreationDate()Ljava/util/Date;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 448
    :cond_6
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 449
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withCSS(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;
    .locals 0
    .param p1, "cSS"    # Ljava/lang/String;

    .line 284
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->cSS:Ljava/lang/String;

    .line 285
    return-object p0
.end method

.method public withCSSVersion(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;
    .locals 0
    .param p1, "cSSVersion"    # Ljava/lang/String;

    .line 329
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->cSSVersion:Ljava/lang/String;

    .line 330
    return-object p0
.end method

.method public withClientId(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;
    .locals 0
    .param p1, "clientId"    # Ljava/lang/String;

    .line 194
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->clientId:Ljava/lang/String;

    .line 195
    return-object p0
.end method

.method public withCreationDate(Ljava/util/Date;)Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;
    .locals 0
    .param p1, "creationDate"    # Ljava/util/Date;

    .line 419
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->creationDate:Ljava/util/Date;

    .line 420
    return-object p0
.end method

.method public withImageUrl(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;
    .locals 0
    .param p1, "imageUrl"    # Ljava/lang/String;

    .line 239
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->imageUrl:Ljava/lang/String;

    .line 240
    return-object p0
.end method

.method public withLastModifiedDate(Ljava/util/Date;)Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;
    .locals 0
    .param p1, "lastModifiedDate"    # Ljava/util/Date;

    .line 374
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->lastModifiedDate:Ljava/util/Date;

    .line 375
    return-object p0
.end method

.method public withUserPoolId(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;
    .locals 0
    .param p1, "userPoolId"    # Ljava/lang/String;

    .line 137
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UICustomizationType;->userPoolId:Ljava/lang/String;

    .line 138
    return-object p0
.end method
