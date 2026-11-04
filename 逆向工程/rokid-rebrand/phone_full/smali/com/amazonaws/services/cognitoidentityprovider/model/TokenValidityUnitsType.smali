.class public Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;
.super Ljava/lang/Object;
.source "TokenValidityUnitsType.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private accessToken:Ljava/lang/String;

.field private idToken:Ljava/lang/String;

.field private refreshToken:Ljava/lang/String;


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

    .line 417
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 418
    return v0

    .line 419
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 420
    return v1

    .line 422
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;

    if-nez v2, :cond_2

    .line 423
    return v1

    .line 424
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;

    .line 426
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getAccessToken()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 427
    return v1

    .line 428
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 429
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getAccessToken()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 430
    return v1

    .line 431
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getIdToken()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getIdToken()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 432
    return v1

    .line 433
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getIdToken()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getIdToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getIdToken()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 434
    return v1

    .line 435
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getRefreshToken()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getRefreshToken()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 436
    return v1

    .line 437
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getRefreshToken()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 438
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getRefreshToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getRefreshToken()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 439
    return v1

    .line 440
    :cond_e
    return v0
.end method

.method public getAccessToken()Ljava/lang/String;
    .locals 1

    .line 76
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->accessToken:Ljava/lang/String;

    return-object v0
.end method

.method public getIdToken()Ljava/lang/String;
    .locals 1

    .line 183
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->idToken:Ljava/lang/String;

    return-object v0
.end method

.method public getRefreshToken()Ljava/lang/String;
    .locals 1

    .line 290
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->refreshToken:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 404
    const/16 v0, 0x1f

    .line 405
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 407
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 408
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 409
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getIdToken()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getIdToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 410
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 411
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getRefreshToken()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getRefreshToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_2
    add-int/2addr v2, v4

    .line 412
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public setAccessToken(Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;)V
    .locals 1
    .param p1, "accessToken"    # Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    .line 139
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->accessToken:Ljava/lang/String;

    .line 140
    return-void
.end method

.method public setAccessToken(Ljava/lang/String;)V
    .locals 0
    .param p1, "accessToken"    # Ljava/lang/String;

    .line 95
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->accessToken:Ljava/lang/String;

    .line 96
    return-void
.end method

.method public setIdToken(Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;)V
    .locals 1
    .param p1, "idToken"    # Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    .line 246
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->idToken:Ljava/lang/String;

    .line 247
    return-void
.end method

.method public setIdToken(Ljava/lang/String;)V
    .locals 0
    .param p1, "idToken"    # Ljava/lang/String;

    .line 202
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->idToken:Ljava/lang/String;

    .line 203
    return-void
.end method

.method public setRefreshToken(Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;)V
    .locals 1
    .param p1, "refreshToken"    # Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    .line 353
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->refreshToken:Ljava/lang/String;

    .line 354
    return-void
.end method

.method public setRefreshToken(Ljava/lang/String;)V
    .locals 0
    .param p1, "refreshToken"    # Ljava/lang/String;

    .line 309
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->refreshToken:Ljava/lang/String;

    .line 310
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 390
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 391
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 392
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getAccessToken()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 393
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AccessToken: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 394
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getIdToken()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 395
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "IdToken: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getIdToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 396
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getRefreshToken()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 397
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "RefreshToken: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->getRefreshToken()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 398
    :cond_2
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 399
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withAccessToken(Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;)Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;
    .locals 1
    .param p1, "accessToken"    # Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    .line 163
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->accessToken:Ljava/lang/String;

    .line 164
    return-object p0
.end method

.method public withAccessToken(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;
    .locals 0
    .param p1, "accessToken"    # Ljava/lang/String;

    .line 119
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->accessToken:Ljava/lang/String;

    .line 120
    return-object p0
.end method

.method public withIdToken(Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;)Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;
    .locals 1
    .param p1, "idToken"    # Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    .line 270
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->idToken:Ljava/lang/String;

    .line 271
    return-object p0
.end method

.method public withIdToken(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;
    .locals 0
    .param p1, "idToken"    # Ljava/lang/String;

    .line 226
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->idToken:Ljava/lang/String;

    .line 227
    return-object p0
.end method

.method public withRefreshToken(Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;)Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;
    .locals 1
    .param p1, "refreshToken"    # Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;

    .line 377
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/TimeUnitsType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->refreshToken:Ljava/lang/String;

    .line 378
    return-object p0
.end method

.method public withRefreshToken(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;
    .locals 0
    .param p1, "refreshToken"    # Ljava/lang/String;

    .line 333
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/TokenValidityUnitsType;->refreshToken:Ljava/lang/String;

    .line 334
    return-object p0
.end method
