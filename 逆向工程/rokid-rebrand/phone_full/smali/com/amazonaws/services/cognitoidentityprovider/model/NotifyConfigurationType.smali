.class public Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;
.super Ljava/lang/Object;
.source "NotifyConfigurationType.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private blockEmail:Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

.field private from:Ljava/lang/String;

.field private mfaEmail:Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

.field private noActionEmail:Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

.field private replyTo:Ljava/lang/String;

.field private sourceArn:Ljava/lang/String;


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

    .line 447
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 448
    return v0

    .line 449
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 450
    return v1

    .line 452
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;

    if-nez v2, :cond_2

    .line 453
    return v1

    .line 454
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;

    .line 456
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getFrom()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getFrom()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 457
    return v1

    .line 458
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getFrom()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getFrom()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getFrom()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 459
    return v1

    .line 460
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getReplyTo()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getReplyTo()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 461
    return v1

    .line 462
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getReplyTo()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getReplyTo()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getReplyTo()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 463
    return v1

    .line 464
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getSourceArn()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getSourceArn()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 465
    return v1

    .line 466
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getSourceArn()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 467
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getSourceArn()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getSourceArn()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 468
    return v1

    .line 469
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getBlockEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getBlockEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 470
    return v1

    .line 471
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getBlockEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v3

    if-eqz v3, :cond_12

    .line 472
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getBlockEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getBlockEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 473
    return v1

    .line 474
    :cond_12
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getNoActionEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v3

    if-nez v3, :cond_13

    move v3, v0

    goto :goto_8

    :cond_13
    move v3, v1

    :goto_8
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getNoActionEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v4

    if-nez v4, :cond_14

    move v4, v0

    goto :goto_9

    :cond_14
    move v4, v1

    :goto_9
    xor-int/2addr v3, v4

    if-eqz v3, :cond_15

    .line 475
    return v1

    .line 476
    :cond_15
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getNoActionEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v3

    if-eqz v3, :cond_16

    .line 477
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getNoActionEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getNoActionEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_16

    .line 478
    return v1

    .line 479
    :cond_16
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getMfaEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v3

    if-nez v3, :cond_17

    move v3, v0

    goto :goto_a

    :cond_17
    move v3, v1

    :goto_a
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getMfaEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v4

    if-nez v4, :cond_18

    move v4, v0

    goto :goto_b

    :cond_18
    move v4, v1

    :goto_b
    xor-int/2addr v3, v4

    if-eqz v3, :cond_19

    .line 480
    return v1

    .line 481
    :cond_19
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getMfaEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v3

    if-eqz v3, :cond_1a

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getMfaEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getMfaEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1a

    .line 482
    return v1

    .line 483
    :cond_1a
    return v0
.end method

.method public getBlockEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;
    .locals 1

    .line 272
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->blockEmail:Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    return-object v0
.end method

.method public getFrom()Ljava/lang/String;
    .locals 1

    .line 93
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->from:Ljava/lang/String;

    return-object v0
.end method

.method public getMfaEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;
    .locals 1

    .line 364
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->mfaEmail:Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    return-object v0
.end method

.method public getNoActionEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;
    .locals 1

    .line 317
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->noActionEmail:Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    return-object v0
.end method

.method public getReplyTo()Ljava/lang/String;
    .locals 1

    .line 147
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->replyTo:Ljava/lang/String;

    return-object v0
.end method

.method public getSourceArn()Ljava/lang/String;
    .locals 1

    .line 205
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->sourceArn:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 432
    const/16 v0, 0x1f

    .line 433
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 435
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getFrom()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getFrom()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 436
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getReplyTo()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getReplyTo()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 437
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getSourceArn()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getSourceArn()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 438
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getBlockEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v4

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getBlockEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;->hashCode()I

    move-result v3

    :goto_3
    add-int/2addr v1, v3

    .line 439
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 440
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getNoActionEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v3

    if-nez v3, :cond_4

    move v3, v4

    goto :goto_4

    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getNoActionEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;->hashCode()I

    move-result v3

    :goto_4
    add-int/2addr v2, v3

    .line 441
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getMfaEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v3

    if-nez v3, :cond_5

    goto :goto_5

    :cond_5
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getMfaEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;->hashCode()I

    move-result v4

    :goto_5
    add-int/2addr v1, v4

    .line 442
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setBlockEmail(Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;)V
    .locals 0
    .param p1, "blockEmail"    # Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    .line 285
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->blockEmail:Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    .line 286
    return-void
.end method

.method public setFrom(Ljava/lang/String;)V
    .locals 0
    .param p1, "from"    # Ljava/lang/String;

    .line 110
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->from:Ljava/lang/String;

    .line 111
    return-void
.end method

.method public setMfaEmail(Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;)V
    .locals 0
    .param p1, "mfaEmail"    # Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    .line 379
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->mfaEmail:Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    .line 380
    return-void
.end method

.method public setNoActionEmail(Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;)V
    .locals 0
    .param p1, "noActionEmail"    # Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    .line 330
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->noActionEmail:Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    .line 331
    return-void
.end method

.method public setReplyTo(Ljava/lang/String;)V
    .locals 0
    .param p1, "replyTo"    # Ljava/lang/String;

    .line 161
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->replyTo:Ljava/lang/String;

    .line 162
    return-void
.end method

.method public setSourceArn(Ljava/lang/String;)V
    .locals 0
    .param p1, "sourceArn"    # Ljava/lang/String;

    .line 229
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->sourceArn:Ljava/lang/String;

    .line 230
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 412
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 413
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 414
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getFrom()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 415
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "From: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getFrom()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 416
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getReplyTo()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 417
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ReplyTo: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getReplyTo()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 418
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getSourceArn()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 419
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SourceArn: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getSourceArn()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 420
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getBlockEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 421
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "BlockEmail: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getBlockEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 422
    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getNoActionEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v1

    if-eqz v1, :cond_4

    .line 423
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "NoActionEmail: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getNoActionEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 424
    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getMfaEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v1

    if-eqz v1, :cond_5

    .line 425
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "MfaEmail: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->getMfaEmail()Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 426
    :cond_5
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 427
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withBlockEmail(Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;)Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;
    .locals 0
    .param p1, "blockEmail"    # Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    .line 303
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->blockEmail:Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    .line 304
    return-object p0
.end method

.method public withFrom(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;
    .locals 0
    .param p1, "from"    # Ljava/lang/String;

    .line 132
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->from:Ljava/lang/String;

    .line 133
    return-object p0
.end method

.method public withMfaEmail(Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;)Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;
    .locals 0
    .param p1, "mfaEmail"    # Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    .line 399
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->mfaEmail:Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    .line 400
    return-object p0
.end method

.method public withNoActionEmail(Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;)Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;
    .locals 0
    .param p1, "noActionEmail"    # Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    .line 348
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->noActionEmail:Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyEmailType;

    .line 349
    return-object p0
.end method

.method public withReplyTo(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;
    .locals 0
    .param p1, "replyTo"    # Ljava/lang/String;

    .line 180
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->replyTo:Ljava/lang/String;

    .line 181
    return-object p0
.end method

.method public withSourceArn(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;
    .locals 0
    .param p1, "sourceArn"    # Ljava/lang/String;

    .line 258
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NotifyConfigurationType;->sourceArn:Ljava/lang/String;

    .line 259
    return-object p0
.end method
