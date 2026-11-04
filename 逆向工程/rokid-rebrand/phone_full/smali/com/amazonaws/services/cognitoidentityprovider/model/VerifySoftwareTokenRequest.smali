.class public Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "VerifySoftwareTokenRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private accessToken:Ljava/lang/String;

.field private friendlyDeviceName:Ljava/lang/String;

.field private session:Ljava/lang/String;

.field private userCode:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 29
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 341
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 342
    return v0

    .line 343
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 344
    return v1

    .line 346
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;

    if-nez v2, :cond_2

    .line 347
    return v1

    .line 348
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;

    .line 350
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 351
    return v1

    .line 352
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 353
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 354
    return v1

    .line 355
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getSession()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getSession()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 356
    return v1

    .line 357
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getSession()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getSession()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getSession()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 358
    return v1

    .line 359
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getUserCode()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getUserCode()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 360
    return v1

    .line 361
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getUserCode()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getUserCode()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getUserCode()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 362
    return v1

    .line 363
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getFriendlyDeviceName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getFriendlyDeviceName()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 364
    return v1

    .line 365
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getFriendlyDeviceName()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_12

    .line 366
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getFriendlyDeviceName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getFriendlyDeviceName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 367
    return v1

    .line 368
    :cond_12
    return v0
.end method

.method public getAccessToken()Ljava/lang/String;
    .locals 1

    .line 84
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->accessToken:Ljava/lang/String;

    return-object v0
.end method

.method public getFriendlyDeviceName()Ljava/lang/String;
    .locals 1

    .line 267
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->friendlyDeviceName:Ljava/lang/String;

    return-object v0
.end method

.method public getSession()Ljava/lang/String;
    .locals 1

    .line 140
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->session:Ljava/lang/String;

    return-object v0
.end method

.method public getUserCode()Ljava/lang/String;
    .locals 1

    .line 204
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->userCode:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 327
    const/16 v0, 0x1f

    .line 328
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 330
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 331
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 332
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getSession()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getSession()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 333
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getUserCode()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getUserCode()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 334
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 335
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getFriendlyDeviceName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getFriendlyDeviceName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_3
    add-int/2addr v1, v4

    .line 336
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setAccessToken(Ljava/lang/String;)V
    .locals 0
    .param p1, "accessToken"    # Ljava/lang/String;

    .line 100
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->accessToken:Ljava/lang/String;

    .line 101
    return-void
.end method

.method public setFriendlyDeviceName(Ljava/lang/String;)V
    .locals 0
    .param p1, "friendlyDeviceName"    # Ljava/lang/String;

    .line 280
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->friendlyDeviceName:Ljava/lang/String;

    .line 281
    return-void
.end method

.method public setSession(Ljava/lang/String;)V
    .locals 0
    .param p1, "session"    # Ljava/lang/String;

    .line 158
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->session:Ljava/lang/String;

    .line 159
    return-void
.end method

.method public setUserCode(Ljava/lang/String;)V
    .locals 0
    .param p1, "userCode"    # Ljava/lang/String;

    .line 226
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->userCode:Ljava/lang/String;

    .line 227
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 311
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 312
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 313
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 314
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AccessToken: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 315
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getSession()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 316
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Session: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getSession()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 317
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getUserCode()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 318
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "UserCode: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getUserCode()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 319
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getFriendlyDeviceName()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 320
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "FriendlyDeviceName: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->getFriendlyDeviceName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 321
    :cond_3
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 322
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withAccessToken(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;
    .locals 0
    .param p1, "accessToken"    # Ljava/lang/String;

    .line 121
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->accessToken:Ljava/lang/String;

    .line 122
    return-object p0
.end method

.method public withFriendlyDeviceName(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;
    .locals 0
    .param p1, "friendlyDeviceName"    # Ljava/lang/String;

    .line 298
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->friendlyDeviceName:Ljava/lang/String;

    .line 299
    return-object p0
.end method

.method public withSession(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;
    .locals 0
    .param p1, "session"    # Ljava/lang/String;

    .line 181
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->session:Ljava/lang/String;

    .line 182
    return-object p0
.end method

.method public withUserCode(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;
    .locals 0
    .param p1, "userCode"    # Ljava/lang/String;

    .line 253
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/VerifySoftwareTokenRequest;->userCode:Ljava/lang/String;

    .line 254
    return-object p0
.end method
