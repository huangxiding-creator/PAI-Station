.class public Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "ChangePasswordRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private accessToken:Ljava/lang/String;

.field private previousPassword:Ljava/lang/String;

.field private proposedPassword:Ljava/lang/String;


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

    .line 265
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 266
    return v0

    .line 267
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 268
    return v1

    .line 270
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;

    if-nez v2, :cond_2

    .line 271
    return v1

    .line 272
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;

    .line 274
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getPreviousPassword()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getPreviousPassword()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 275
    return v1

    .line 276
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getPreviousPassword()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 277
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getPreviousPassword()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getPreviousPassword()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 278
    return v1

    .line 279
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getProposedPassword()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getProposedPassword()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 280
    return v1

    .line 281
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getProposedPassword()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 282
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getProposedPassword()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getProposedPassword()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 283
    return v1

    .line 284
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 285
    return v1

    .line 286
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 287
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 288
    return v1

    .line 289
    :cond_e
    return v0
.end method

.method public getAccessToken()Ljava/lang/String;
    .locals 1

    .line 187
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->accessToken:Ljava/lang/String;

    return-object v0
.end method

.method public getPreviousPassword()Ljava/lang/String;
    .locals 1

    .line 74
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->previousPassword:Ljava/lang/String;

    return-object v0
.end method

.method public getProposedPassword()Ljava/lang/String;
    .locals 1

    .line 131
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->proposedPassword:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 251
    const/16 v0, 0x1f

    .line 252
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 254
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 255
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getPreviousPassword()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getPreviousPassword()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 256
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 257
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getProposedPassword()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getProposedPassword()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 258
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 259
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_2
    add-int/2addr v2, v4

    .line 260
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public setAccessToken(Ljava/lang/String;)V
    .locals 0
    .param p1, "accessToken"    # Ljava/lang/String;

    .line 203
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->accessToken:Ljava/lang/String;

    .line 204
    return-void
.end method

.method public setPreviousPassword(Ljava/lang/String;)V
    .locals 0
    .param p1, "previousPassword"    # Ljava/lang/String;

    .line 91
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->previousPassword:Ljava/lang/String;

    .line 92
    return-void
.end method

.method public setProposedPassword(Ljava/lang/String;)V
    .locals 0
    .param p1, "proposedPassword"    # Ljava/lang/String;

    .line 148
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->proposedPassword:Ljava/lang/String;

    .line 149
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 237
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 238
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 239
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getPreviousPassword()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 240
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "PreviousPassword: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getPreviousPassword()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 241
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getProposedPassword()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 242
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ProposedPassword: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getProposedPassword()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 243
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 244
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "AccessToken: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 245
    :cond_2
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 246
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withAccessToken(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;
    .locals 0
    .param p1, "accessToken"    # Ljava/lang/String;

    .line 224
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->accessToken:Ljava/lang/String;

    .line 225
    return-object p0
.end method

.method public withPreviousPassword(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;
    .locals 0
    .param p1, "previousPassword"    # Ljava/lang/String;

    .line 113
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->previousPassword:Ljava/lang/String;

    .line 114
    return-object p0
.end method

.method public withProposedPassword(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;
    .locals 0
    .param p1, "proposedPassword"    # Ljava/lang/String;

    .line 170
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChangePasswordRequest;->proposedPassword:Ljava/lang/String;

    .line 171
    return-object p0
.end method
