.class public Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "UnlinkDeveloperIdentityRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private developerProviderName:Ljava/lang/String;

.field private developerUserIdentifier:Ljava/lang/String;

.field private identityId:Ljava/lang/String;

.field private identityPoolId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 34
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 353
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 354
    return v0

    .line 355
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 356
    return v1

    .line 358
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;

    if-nez v2, :cond_2

    .line 359
    return v1

    .line 360
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;

    .line 362
    .local v2, "other":Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getIdentityId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getIdentityId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 363
    return v1

    .line 364
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getIdentityId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 365
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getIdentityId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getIdentityId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 366
    return v1

    .line 367
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 368
    return v1

    .line 369
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 370
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 371
    return v1

    .line 372
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getDeveloperProviderName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getDeveloperProviderName()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 373
    return v1

    .line 374
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getDeveloperProviderName()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 375
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getDeveloperProviderName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getDeveloperProviderName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 376
    return v1

    .line 377
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getDeveloperUserIdentifier()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getDeveloperUserIdentifier()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 378
    return v1

    .line 379
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getDeveloperUserIdentifier()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_12

    .line 380
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getDeveloperUserIdentifier()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getDeveloperUserIdentifier()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 381
    return v1

    .line 382
    :cond_12
    return v0
.end method

.method public getDeveloperProviderName()Ljava/lang/String;
    .locals 1

    .line 207
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->developerProviderName:Ljava/lang/String;

    return-object v0
.end method

.method public getDeveloperUserIdentifier()Ljava/lang/String;
    .locals 1

    .line 265
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->developerUserIdentifier:Ljava/lang/String;

    return-object v0
.end method

.method public getIdentityId()Ljava/lang/String;
    .locals 1

    .line 93
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->identityId:Ljava/lang/String;

    return-object v0
.end method

.method public getIdentityPoolId()Ljava/lang/String;
    .locals 1

    .line 150
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->identityPoolId:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 335
    const/16 v0, 0x1f

    .line 336
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 338
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getIdentityId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getIdentityId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 339
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 340
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 341
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 343
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getDeveloperProviderName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getDeveloperProviderName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 344
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 346
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getDeveloperUserIdentifier()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getDeveloperUserIdentifier()Ljava/lang/String;

    move-result-object v3

    .line 347
    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_3
    add-int/2addr v1, v4

    .line 348
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setDeveloperProviderName(Ljava/lang/String;)V
    .locals 0
    .param p1, "developerProviderName"    # Ljava/lang/String;

    .line 224
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->developerProviderName:Ljava/lang/String;

    .line 225
    return-void
.end method

.method public setDeveloperUserIdentifier(Ljava/lang/String;)V
    .locals 0
    .param p1, "developerUserIdentifier"    # Ljava/lang/String;

    .line 283
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->developerUserIdentifier:Ljava/lang/String;

    .line 284
    return-void
.end method

.method public setIdentityId(Ljava/lang/String;)V
    .locals 0
    .param p1, "identityId"    # Ljava/lang/String;

    .line 110
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->identityId:Ljava/lang/String;

    .line 111
    return-void
.end method

.method public setIdentityPoolId(Ljava/lang/String;)V
    .locals 0
    .param p1, "identityPoolId"    # Ljava/lang/String;

    .line 167
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->identityPoolId:Ljava/lang/String;

    .line 168
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 319
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 320
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 321
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getIdentityId()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 322
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "IdentityId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getIdentityId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 323
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 324
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "IdentityPoolId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 325
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getDeveloperProviderName()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 326
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DeveloperProviderName: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getDeveloperProviderName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 327
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getDeveloperUserIdentifier()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 328
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "DeveloperUserIdentifier: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->getDeveloperUserIdentifier()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 329
    :cond_3
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 330
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withDeveloperProviderName(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;
    .locals 0
    .param p1, "developerProviderName"    # Ljava/lang/String;

    .line 246
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->developerProviderName:Ljava/lang/String;

    .line 247
    return-object p0
.end method

.method public withDeveloperUserIdentifier(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;
    .locals 0
    .param p1, "developerUserIdentifier"    # Ljava/lang/String;

    .line 306
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->developerUserIdentifier:Ljava/lang/String;

    .line 307
    return-object p0
.end method

.method public withIdentityId(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;
    .locals 0
    .param p1, "identityId"    # Ljava/lang/String;

    .line 132
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->identityId:Ljava/lang/String;

    .line 133
    return-object p0
.end method

.method public withIdentityPoolId(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;
    .locals 0
    .param p1, "identityPoolId"    # Ljava/lang/String;

    .line 189
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/UnlinkDeveloperIdentityRequest;->identityPoolId:Ljava/lang/String;

    .line 190
    return-object p0
.end method
