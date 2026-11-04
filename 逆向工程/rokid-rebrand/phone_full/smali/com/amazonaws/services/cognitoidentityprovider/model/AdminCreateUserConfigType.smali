.class public Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;
.super Ljava/lang/Object;
.source "AdminCreateUserConfigType.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private allowAdminCreateUserOnly:Ljava/lang/Boolean;

.field private inviteMessageTemplate:Lcom/amazonaws/services/cognitoidentityprovider/model/MessageTemplateType;

.field private unusedAccountValidityDays:Ljava/lang/Integer;


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

    .line 395
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 396
    return v0

    .line 397
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 398
    return v1

    .line 400
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;

    if-nez v2, :cond_2

    .line 401
    return v1

    .line 402
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;

    .line 404
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getAllowAdminCreateUserOnly()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    .line 405
    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getAllowAdminCreateUserOnly()Ljava/lang/Boolean;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 406
    return v1

    .line 407
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getAllowAdminCreateUserOnly()Ljava/lang/Boolean;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 408
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getAllowAdminCreateUserOnly()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getAllowAdminCreateUserOnly()Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 409
    return v1

    .line 410
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getUnusedAccountValidityDays()Ljava/lang/Integer;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    .line 411
    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getUnusedAccountValidityDays()Ljava/lang/Integer;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 412
    return v1

    .line 413
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getUnusedAccountValidityDays()Ljava/lang/Integer;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 414
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getUnusedAccountValidityDays()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getUnusedAccountValidityDays()Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Integer;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 415
    return v1

    .line 416
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getInviteMessageTemplate()Lcom/amazonaws/services/cognitoidentityprovider/model/MessageTemplateType;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getInviteMessageTemplate()Lcom/amazonaws/services/cognitoidentityprovider/model/MessageTemplateType;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 417
    return v1

    .line 418
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getInviteMessageTemplate()Lcom/amazonaws/services/cognitoidentityprovider/model/MessageTemplateType;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 419
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getInviteMessageTemplate()Lcom/amazonaws/services/cognitoidentityprovider/model/MessageTemplateType;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getInviteMessageTemplate()Lcom/amazonaws/services/cognitoidentityprovider/model/MessageTemplateType;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/MessageTemplateType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 420
    return v1

    .line 421
    :cond_e
    return v0
.end method

.method public getAllowAdminCreateUserOnly()Ljava/lang/Boolean;
    .locals 1

    .line 100
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->allowAdminCreateUserOnly:Ljava/lang/Boolean;

    return-object v0
.end method

.method public getInviteMessageTemplate()Lcom/amazonaws/services/cognitoidentityprovider/model/MessageTemplateType;
    .locals 1

    .line 295
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->inviteMessageTemplate:Lcom/amazonaws/services/cognitoidentityprovider/model/MessageTemplateType;

    return-object v0
.end method

.method public getUnusedAccountValidityDays()Ljava/lang/Integer;
    .locals 1

    .line 181
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->unusedAccountValidityDays:Ljava/lang/Integer;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 376
    const/16 v0, 0x1f

    .line 377
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 379
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 381
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getAllowAdminCreateUserOnly()Ljava/lang/Boolean;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getAllowAdminCreateUserOnly()Ljava/lang/Boolean;

    move-result-object v3

    .line 382
    invoke-virtual {v3}, Ljava/lang/Boolean;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 383
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 385
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getUnusedAccountValidityDays()Ljava/lang/Integer;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getUnusedAccountValidityDays()Ljava/lang/Integer;

    move-result-object v3

    .line 386
    invoke-virtual {v3}, Ljava/lang/Integer;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 387
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 389
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getInviteMessageTemplate()Lcom/amazonaws/services/cognitoidentityprovider/model/MessageTemplateType;

    move-result-object v3

    if-nez v3, :cond_2

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getInviteMessageTemplate()Lcom/amazonaws/services/cognitoidentityprovider/model/MessageTemplateType;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/MessageTemplateType;->hashCode()I

    move-result v4

    :goto_2
    add-int/2addr v2, v4

    .line 390
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public isAllowAdminCreateUserOnly()Ljava/lang/Boolean;
    .locals 1

    .line 83
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->allowAdminCreateUserOnly:Ljava/lang/Boolean;

    return-object v0
.end method

.method public setAllowAdminCreateUserOnly(Ljava/lang/Boolean;)V
    .locals 0
    .param p1, "allowAdminCreateUserOnly"    # Ljava/lang/Boolean;

    .line 117
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->allowAdminCreateUserOnly:Ljava/lang/Boolean;

    .line 118
    return-void
.end method

.method public setInviteMessageTemplate(Lcom/amazonaws/services/cognitoidentityprovider/model/MessageTemplateType;)V
    .locals 0
    .param p1, "inviteMessageTemplate"    # Lcom/amazonaws/services/cognitoidentityprovider/model/MessageTemplateType;

    .line 319
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->inviteMessageTemplate:Lcom/amazonaws/services/cognitoidentityprovider/model/MessageTemplateType;

    .line 320
    return-void
.end method

.method public setUnusedAccountValidityDays(Ljava/lang/Integer;)V
    .locals 0
    .param p1, "unusedAccountValidityDays"    # Ljava/lang/Integer;

    .line 223
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->unusedAccountValidityDays:Ljava/lang/Integer;

    .line 224
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 362
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 363
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 364
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getAllowAdminCreateUserOnly()Ljava/lang/Boolean;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 365
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AllowAdminCreateUserOnly: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getAllowAdminCreateUserOnly()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 366
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getUnusedAccountValidityDays()Ljava/lang/Integer;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 367
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "UnusedAccountValidityDays: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getUnusedAccountValidityDays()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 368
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getInviteMessageTemplate()Lcom/amazonaws/services/cognitoidentityprovider/model/MessageTemplateType;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 369
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "InviteMessageTemplate: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->getInviteMessageTemplate()Lcom/amazonaws/services/cognitoidentityprovider/model/MessageTemplateType;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 370
    :cond_2
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 371
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withAllowAdminCreateUserOnly(Ljava/lang/Boolean;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;
    .locals 0
    .param p1, "allowAdminCreateUserOnly"    # Ljava/lang/Boolean;

    .line 139
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->allowAdminCreateUserOnly:Ljava/lang/Boolean;

    .line 140
    return-object p0
.end method

.method public withInviteMessageTemplate(Lcom/amazonaws/services/cognitoidentityprovider/model/MessageTemplateType;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;
    .locals 0
    .param p1, "inviteMessageTemplate"    # Lcom/amazonaws/services/cognitoidentityprovider/model/MessageTemplateType;

    .line 349
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->inviteMessageTemplate:Lcom/amazonaws/services/cognitoidentityprovider/model/MessageTemplateType;

    .line 350
    return-object p0
.end method

.method public withUnusedAccountValidityDays(Ljava/lang/Integer;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;
    .locals 0
    .param p1, "unusedAccountValidityDays"    # Ljava/lang/Integer;

    .line 270
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserConfigType;->unusedAccountValidityDays:Ljava/lang/Integer;

    .line 271
    return-object p0
.end method
