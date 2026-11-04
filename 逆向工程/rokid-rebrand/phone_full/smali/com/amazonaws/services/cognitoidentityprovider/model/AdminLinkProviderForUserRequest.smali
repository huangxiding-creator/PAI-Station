.class public Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "AdminLinkProviderForUserRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private destinationUser:Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

.field private sourceUser:Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

.field private userPoolId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 54
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 582
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 583
    return v0

    .line 584
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 585
    return v1

    .line 587
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;

    if-nez v2, :cond_2

    .line 588
    return v1

    .line 589
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;

    .line 591
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 592
    return v1

    .line 593
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 594
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 595
    return v1

    .line 596
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getDestinationUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getDestinationUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 597
    return v1

    .line 598
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getDestinationUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 599
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getDestinationUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getDestinationUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 600
    return v1

    .line 601
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getSourceUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getSourceUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 602
    return v1

    .line 603
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getSourceUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 604
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getSourceUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getSourceUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 605
    return v1

    .line 606
    :cond_e
    return v0
.end method

.method public getDestinationUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;
    .locals 1

    .line 216
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->destinationUser:Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    return-object v0
.end method

.method public getSourceUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;
    .locals 1

    .line 398
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->sourceUser:Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    return-object v0
.end method

.method public getUserPoolId()Ljava/lang/String;
    .locals 1

    .line 132
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->userPoolId:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 570
    const/16 v0, 0x1f

    .line 571
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 573
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 574
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 575
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getDestinationUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getDestinationUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 576
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getSourceUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v3

    if-nez v3, :cond_2

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getSourceUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->hashCode()I

    move-result v4

    :goto_2
    add-int/2addr v2, v4

    .line 577
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public setDestinationUser(Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;)V
    .locals 0
    .param p1, "destinationUser"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    .line 269
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->destinationUser:Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    .line 270
    return-void
.end method

.method public setSourceUser(Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;)V
    .locals 0
    .param p1, "sourceUser"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    .line 468
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->sourceUser:Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    .line 469
    return-void
.end method

.method public setUserPoolId(Ljava/lang/String;)V
    .locals 0
    .param p1, "userPoolId"    # Ljava/lang/String;

    .line 145
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->userPoolId:Ljava/lang/String;

    .line 146
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 556
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 557
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 558
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 559
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "UserPoolId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 560
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getDestinationUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 561
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DestinationUser: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getDestinationUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 562
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getSourceUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 563
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SourceUser: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->getSourceUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 564
    :cond_2
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 565
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withDestinationUser(Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;
    .locals 0
    .param p1, "destinationUser"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    .line 328
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->destinationUser:Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    .line 329
    return-object p0
.end method

.method public withSourceUser(Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;
    .locals 0
    .param p1, "sourceUser"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    .line 543
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->sourceUser:Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    .line 544
    return-object p0
.end method

.method public withUserPoolId(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;
    .locals 0
    .param p1, "userPoolId"    # Ljava/lang/String;

    .line 163
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminLinkProviderForUserRequest;->userPoolId:Ljava/lang/String;

    .line 164
    return-object p0
.end method
