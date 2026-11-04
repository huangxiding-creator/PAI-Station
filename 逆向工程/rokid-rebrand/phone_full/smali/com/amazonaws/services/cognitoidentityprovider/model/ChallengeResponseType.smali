.class public Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;
.super Ljava/lang/Object;
.source "ChallengeResponseType.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private challengeName:Ljava/lang/String;

.field private challengeResponse:Ljava/lang/String;


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

    .line 273
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 274
    return v0

    .line 275
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 276
    return v1

    .line 278
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;

    if-nez v2, :cond_2

    .line 279
    return v1

    .line 280
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;

    .line 282
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->getChallengeName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->getChallengeName()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 283
    return v1

    .line 284
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->getChallengeName()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 285
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->getChallengeName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->getChallengeName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 286
    return v1

    .line 287
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->getChallengeResponse()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->getChallengeResponse()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 288
    return v1

    .line 289
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->getChallengeResponse()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 290
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->getChallengeResponse()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->getChallengeResponse()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 291
    return v1

    .line 292
    :cond_a
    return v0
.end method

.method public getChallengeName()Ljava/lang/String;
    .locals 1

    .line 60
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->challengeName:Ljava/lang/String;

    return-object v0
.end method

.method public getChallengeResponse()Ljava/lang/String;
    .locals 1

    .line 157
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->challengeResponse:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 261
    const/16 v0, 0x1f

    .line 262
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 264
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 265
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->getChallengeName()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->getChallengeName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 266
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 267
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->getChallengeResponse()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->getChallengeResponse()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_1
    add-int/2addr v1, v4

    .line 268
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setChallengeName(Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeName;)V
    .locals 1
    .param p1, "challengeName"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeName;

    .line 117
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeName;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->challengeName:Ljava/lang/String;

    .line 118
    return-void
.end method

.method public setChallengeName(Ljava/lang/String;)V
    .locals 0
    .param p1, "challengeName"    # Ljava/lang/String;

    .line 77
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->challengeName:Ljava/lang/String;

    .line 78
    return-void
.end method

.method public setChallengeResponse(Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponse;)V
    .locals 1
    .param p1, "challengeResponse"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponse;

    .line 214
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponse;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->challengeResponse:Ljava/lang/String;

    .line 215
    return-void
.end method

.method public setChallengeResponse(Ljava/lang/String;)V
    .locals 0
    .param p1, "challengeResponse"    # Ljava/lang/String;

    .line 174
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->challengeResponse:Ljava/lang/String;

    .line 175
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 249
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 250
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 251
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->getChallengeName()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 252
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ChallengeName: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->getChallengeName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 253
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->getChallengeResponse()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 254
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ChallengeResponse: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->getChallengeResponse()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 255
    :cond_1
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 256
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withChallengeName(Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeName;)Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;
    .locals 1
    .param p1, "challengeName"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeName;

    .line 139
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeName;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->challengeName:Ljava/lang/String;

    .line 140
    return-object p0
.end method

.method public withChallengeName(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;
    .locals 0
    .param p1, "challengeName"    # Ljava/lang/String;

    .line 99
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->challengeName:Ljava/lang/String;

    .line 100
    return-object p0
.end method

.method public withChallengeResponse(Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponse;)Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;
    .locals 1
    .param p1, "challengeResponse"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponse;

    .line 236
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponse;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->challengeResponse:Ljava/lang/String;

    .line 237
    return-object p0
.end method

.method public withChallengeResponse(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;
    .locals 0
    .param p1, "challengeResponse"    # Ljava/lang/String;

    .line 196
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;->challengeResponse:Ljava/lang/String;

    .line 197
    return-object p0
.end method
