.class public Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "AdminResetUserPasswordRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private clientMetadata:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private userPoolId:Ljava/lang/String;

.field private username:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 42
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public addClientMetadataEntry(Ljava/lang/String;Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;
    .locals 3
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .line 629
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->clientMetadata:Ljava/util/Map;

    if-nez v0, :cond_0

    .line 630
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->clientMetadata:Ljava/util/Map;

    .line 632
    :cond_0
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->clientMetadata:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 635
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->clientMetadata:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 636
    return-object p0

    .line 633
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Duplicated keys ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") are provided."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public clearClientMetadataEntries()Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;
    .locals 1

    .line 646
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->clientMetadata:Ljava/util/Map;

    .line 647
    return-object p0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 685
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 686
    return v0

    .line 687
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 688
    return v1

    .line 690
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;

    if-nez v2, :cond_2

    .line 691
    return v1

    .line 692
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;

    .line 694
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 695
    return v1

    .line 696
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 697
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 698
    return v1

    .line 699
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getUsername()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getUsername()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 700
    return v1

    .line 701
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getUsername()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getUsername()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getUsername()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 702
    return v1

    .line 703
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 704
    return v1

    .line 705
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 706
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 707
    return v1

    .line 708
    :cond_e
    return v0
.end method

.method public getClientMetadata()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 343
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->clientMetadata:Ljava/util/Map;

    return-object v0
.end method

.method public getUserPoolId()Ljava/lang/String;
    .locals 1

    .line 135
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->userPoolId:Ljava/lang/String;

    return-object v0
.end method

.method public getUsername()Ljava/lang/String;
    .locals 1

    .line 196
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->username:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 673
    const/16 v0, 0x1f

    .line 674
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 676
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 677
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getUsername()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getUsername()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 678
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 679
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v3

    if-nez v3, :cond_2

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v4

    :goto_2
    add-int/2addr v2, v4

    .line 680
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public setClientMetadata(Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 450
    .local p1, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->clientMetadata:Ljava/util/Map;

    .line 451
    return-void
.end method

.method public setUserPoolId(Ljava/lang/String;)V
    .locals 0
    .param p1, "userPoolId"    # Ljava/lang/String;

    .line 154
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->userPoolId:Ljava/lang/String;

    .line 155
    return-void
.end method

.method public setUsername(Ljava/lang/String;)V
    .locals 0
    .param p1, "username"    # Ljava/lang/String;

    .line 213
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->username:Ljava/lang/String;

    .line 214
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 659
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 660
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 661
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 662
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "UserPoolId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 663
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getUsername()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 664
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Username: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getUsername()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 665
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 666
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ClientMetadata: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 667
    :cond_2
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 668
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withClientMetadata(Ljava/util/Map;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;"
        }
    .end annotation

    .line 563
    .local p1, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->clientMetadata:Ljava/util/Map;

    .line 564
    return-object p0
.end method

.method public withUserPoolId(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;
    .locals 0
    .param p1, "userPoolId"    # Ljava/lang/String;

    .line 178
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->userPoolId:Ljava/lang/String;

    .line 179
    return-object p0
.end method

.method public withUsername(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;
    .locals 0
    .param p1, "username"    # Ljava/lang/String;

    .line 235
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminResetUserPasswordRequest;->username:Ljava/lang/String;

    .line 236
    return-object p0
.end method
