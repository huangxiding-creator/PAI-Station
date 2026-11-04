.class public Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;
.super Ljava/lang/Object;
.source "VerificationMessageTemplateType.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private defaultEmailOption:Ljava/lang/String;

.field private emailMessage:Ljava/lang/String;

.field private emailMessageByLink:Ljava/lang/String;

.field private emailSubject:Ljava/lang/String;

.field private emailSubjectByLink:Ljava/lang/String;

.field private smsMessage:Ljava/lang/String;


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

    .line 625
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 626
    return v0

    .line 627
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 628
    return v1

    .line 630
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;

    if-nez v2, :cond_2

    .line 631
    return v1

    .line 632
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;

    .line 634
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getSmsMessage()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getSmsMessage()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 635
    return v1

    .line 636
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getSmsMessage()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 637
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getSmsMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getSmsMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 638
    return v1

    .line 639
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailMessage()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailMessage()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 640
    return v1

    .line 641
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailMessage()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 642
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailMessage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 643
    return v1

    .line 644
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailSubject()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailSubject()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 645
    return v1

    .line 646
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailSubject()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 647
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailSubject()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailSubject()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 648
    return v1

    .line 649
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailMessageByLink()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailMessageByLink()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 650
    return v1

    .line 651
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailMessageByLink()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_12

    .line 652
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailMessageByLink()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailMessageByLink()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 653
    return v1

    .line 654
    :cond_12
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailSubjectByLink()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_13

    move v3, v0

    goto :goto_8

    :cond_13
    move v3, v1

    :goto_8
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailSubjectByLink()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_14

    move v4, v0

    goto :goto_9

    :cond_14
    move v4, v1

    :goto_9
    xor-int/2addr v3, v4

    if-eqz v3, :cond_15

    .line 655
    return v1

    .line 656
    :cond_15
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailSubjectByLink()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_16

    .line 657
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailSubjectByLink()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailSubjectByLink()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_16

    .line 658
    return v1

    .line 659
    :cond_16
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getDefaultEmailOption()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_17

    move v3, v0

    goto :goto_a

    :cond_17
    move v3, v1

    :goto_a
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getDefaultEmailOption()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_18

    move v4, v0

    goto :goto_b

    :cond_18
    move v4, v1

    :goto_b
    xor-int/2addr v3, v4

    if-eqz v3, :cond_19

    .line 660
    return v1

    .line 661
    :cond_19
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getDefaultEmailOption()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_1a

    .line 662
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getDefaultEmailOption()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getDefaultEmailOption()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1a

    .line 663
    return v1

    .line 664
    :cond_1a
    return v0
.end method

.method public getDefaultEmailOption()Ljava/lang/String;
    .locals 1

    .line 493
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->defaultEmailOption:Ljava/lang/String;

    return-object v0
.end method

.method public getEmailMessage()Ljava/lang/String;
    .locals 1

    .line 185
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->emailMessage:Ljava/lang/String;

    return-object v0
.end method

.method public getEmailMessageByLink()Ljava/lang/String;
    .locals 1

    .line 339
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->emailMessageByLink:Ljava/lang/String;

    return-object v0
.end method

.method public getEmailSubject()Ljava/lang/String;
    .locals 1

    .line 262
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->emailSubject:Ljava/lang/String;

    return-object v0
.end method

.method public getEmailSubjectByLink()Ljava/lang/String;
    .locals 1

    .line 420
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->emailSubjectByLink:Ljava/lang/String;

    return-object v0
.end method

.method public getSmsMessage()Ljava/lang/String;
    .locals 1

    .line 121
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->smsMessage:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 606
    const/16 v0, 0x1f

    .line 607
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 609
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getSmsMessage()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getSmsMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 610
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 611
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailMessage()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 612
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 613
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailSubject()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailSubject()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 614
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 615
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailMessageByLink()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v4

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailMessageByLink()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_3
    add-int/2addr v1, v3

    .line 616
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 617
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailSubjectByLink()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_4

    move v3, v4

    goto :goto_4

    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailSubjectByLink()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_4
    add-int/2addr v2, v3

    .line 618
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 619
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getDefaultEmailOption()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_5

    goto :goto_5

    :cond_5
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getDefaultEmailOption()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_5
    add-int/2addr v1, v4

    .line 620
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setDefaultEmailOption(Lcom/amazonaws/services/cognitoidentityprovider/model/DefaultEmailOptionType;)V
    .locals 1
    .param p1, "defaultEmailOption"    # Lcom/amazonaws/services/cognitoidentityprovider/model/DefaultEmailOptionType;

    .line 550
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/DefaultEmailOptionType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->defaultEmailOption:Ljava/lang/String;

    .line 551
    return-void
.end method

.method public setDefaultEmailOption(Ljava/lang/String;)V
    .locals 0
    .param p1, "defaultEmailOption"    # Ljava/lang/String;

    .line 510
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->defaultEmailOption:Ljava/lang/String;

    .line 511
    return-void
.end method

.method public setEmailMessage(Ljava/lang/String;)V
    .locals 0
    .param p1, "emailMessage"    # Ljava/lang/String;

    .line 209
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->emailMessage:Ljava/lang/String;

    .line 210
    return-void
.end method

.method public setEmailMessageByLink(Ljava/lang/String;)V
    .locals 0
    .param p1, "emailMessageByLink"    # Ljava/lang/String;

    .line 364
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->emailMessageByLink:Ljava/lang/String;

    .line 365
    return-void
.end method

.method public setEmailSubject(Ljava/lang/String;)V
    .locals 0
    .param p1, "emailSubject"    # Ljava/lang/String;

    .line 285
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->emailSubject:Ljava/lang/String;

    .line 286
    return-void
.end method

.method public setEmailSubjectByLink(Ljava/lang/String;)V
    .locals 0
    .param p1, "emailSubjectByLink"    # Ljava/lang/String;

    .line 445
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->emailSubjectByLink:Ljava/lang/String;

    .line 446
    return-void
.end method

.method public setSmsMessage(Ljava/lang/String;)V
    .locals 0
    .param p1, "smsMessage"    # Ljava/lang/String;

    .line 138
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->smsMessage:Ljava/lang/String;

    .line 139
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 586
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 587
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 588
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getSmsMessage()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 589
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SmsMessage: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getSmsMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 590
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailMessage()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 591
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "EmailMessage: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 592
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailSubject()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 593
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "EmailSubject: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailSubject()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 594
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailMessageByLink()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 595
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "EmailMessageByLink: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailMessageByLink()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 596
    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailSubjectByLink()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_4

    .line 597
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "EmailSubjectByLink: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getEmailSubjectByLink()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 598
    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getDefaultEmailOption()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_5

    .line 599
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "DefaultEmailOption: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->getDefaultEmailOption()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 600
    :cond_5
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 601
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withDefaultEmailOption(Lcom/amazonaws/services/cognitoidentityprovider/model/DefaultEmailOptionType;)Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;
    .locals 1
    .param p1, "defaultEmailOption"    # Lcom/amazonaws/services/cognitoidentityprovider/model/DefaultEmailOptionType;

    .line 573
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/DefaultEmailOptionType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->defaultEmailOption:Ljava/lang/String;

    .line 574
    return-object p0
.end method

.method public withDefaultEmailOption(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;
    .locals 0
    .param p1, "defaultEmailOption"    # Ljava/lang/String;

    .line 532
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->defaultEmailOption:Ljava/lang/String;

    .line 533
    return-object p0
.end method

.method public withEmailMessage(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;
    .locals 0
    .param p1, "emailMessage"    # Ljava/lang/String;

    .line 238
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->emailMessage:Ljava/lang/String;

    .line 239
    return-object p0
.end method

.method public withEmailMessageByLink(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;
    .locals 0
    .param p1, "emailMessageByLink"    # Ljava/lang/String;

    .line 394
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->emailMessageByLink:Ljava/lang/String;

    .line 395
    return-object p0
.end method

.method public withEmailSubject(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;
    .locals 0
    .param p1, "emailSubject"    # Ljava/lang/String;

    .line 313
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->emailSubject:Ljava/lang/String;

    .line 314
    return-object p0
.end method

.method public withEmailSubjectByLink(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;
    .locals 0
    .param p1, "emailSubjectByLink"    # Ljava/lang/String;

    .line 475
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->emailSubjectByLink:Ljava/lang/String;

    .line 476
    return-object p0
.end method

.method public withSmsMessage(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;
    .locals 0
    .param p1, "smsMessage"    # Ljava/lang/String;

    .line 160
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerificationMessageTemplateType;->smsMessage:Ljava/lang/String;

    .line 161
    return-object p0
.end method
