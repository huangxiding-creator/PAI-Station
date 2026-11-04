.class public Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "SetPrincipalTagAttributeMapRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private identityPoolId:Ljava/lang/String;

.field private identityProviderName:Ljava/lang/String;

.field private principalTags:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private useDefaults:Ljava/lang/Boolean;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 28
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public addPrincipalTagsEntry(Ljava/lang/String;Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;
    .locals 3
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .line 308
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->principalTags:Ljava/util/Map;

    if-nez v0, :cond_0

    .line 309
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->principalTags:Ljava/util/Map;

    .line 311
    :cond_0
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->principalTags:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 314
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->principalTags:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 315
    return-object p0

    .line 312
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

.method public clearPrincipalTagsEntries()Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;
    .locals 1

    .line 325
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->principalTags:Ljava/util/Map;

    .line 326
    return-object p0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 370
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 371
    return v0

    .line 372
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 373
    return v1

    .line 375
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;

    if-nez v2, :cond_2

    .line 376
    return v1

    .line 377
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;

    .line 379
    .local v2, "other":Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 380
    return v1

    .line 381
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 382
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 383
    return v1

    .line 384
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getIdentityProviderName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getIdentityProviderName()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 385
    return v1

    .line 386
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getIdentityProviderName()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 387
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getIdentityProviderName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getIdentityProviderName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 388
    return v1

    .line 389
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getUseDefaults()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getUseDefaults()Ljava/lang/Boolean;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 390
    return v1

    .line 391
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getUseDefaults()Ljava/lang/Boolean;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 392
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getUseDefaults()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getUseDefaults()Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 393
    return v1

    .line 394
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getPrincipalTags()Ljava/util/Map;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getPrincipalTags()Ljava/util/Map;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 395
    return v1

    .line 396
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getPrincipalTags()Ljava/util/Map;

    move-result-object v3

    if-eqz v3, :cond_12

    .line 397
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getPrincipalTags()Ljava/util/Map;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getPrincipalTags()Ljava/util/Map;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 398
    return v1

    .line 399
    :cond_12
    return v0
.end method

.method public getIdentityPoolId()Ljava/lang/String;
    .locals 1

    .line 81
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->identityPoolId:Ljava/lang/String;

    return-object v0
.end method

.method public getIdentityProviderName()Ljava/lang/String;
    .locals 1

    .line 139
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->identityProviderName:Ljava/lang/String;

    return-object v0
.end method

.method public getPrincipalTags()Ljava/util/Map;
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

    .line 256
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->principalTags:Ljava/util/Map;

    return-object v0
.end method

.method public getUseDefaults()Ljava/lang/Boolean;
    .locals 1

    .line 207
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->useDefaults:Ljava/lang/Boolean;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 354
    const/16 v0, 0x1f

    .line 355
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 357
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 358
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 359
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 360
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getIdentityProviderName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getIdentityProviderName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 361
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 362
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getUseDefaults()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getUseDefaults()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Boolean;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 363
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 364
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getPrincipalTags()Ljava/util/Map;

    move-result-object v3

    if-nez v3, :cond_3

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getPrincipalTags()Ljava/util/Map;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v4

    :goto_3
    add-int/2addr v1, v4

    .line 365
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public isUseDefaults()Ljava/lang/Boolean;
    .locals 1

    .line 192
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->useDefaults:Ljava/lang/Boolean;

    return-object v0
.end method

.method public setIdentityPoolId(Ljava/lang/String;)V
    .locals 0
    .param p1, "identityPoolId"    # Ljava/lang/String;

    .line 99
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->identityPoolId:Ljava/lang/String;

    .line 100
    return-void
.end method

.method public setIdentityProviderName(Ljava/lang/String;)V
    .locals 0
    .param p1, "identityProviderName"    # Ljava/lang/String;

    .line 155
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->identityProviderName:Ljava/lang/String;

    .line 156
    return-void
.end method

.method public setPrincipalTags(Ljava/util/Map;)V
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

    .line 269
    .local p1, "principalTags":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->principalTags:Ljava/util/Map;

    .line 270
    return-void
.end method

.method public setUseDefaults(Ljava/lang/Boolean;)V
    .locals 0
    .param p1, "useDefaults"    # Ljava/lang/Boolean;

    .line 222
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->useDefaults:Ljava/lang/Boolean;

    .line 223
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 338
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 339
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 340
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 341
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "IdentityPoolId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 342
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getIdentityProviderName()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 343
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "IdentityProviderName: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getIdentityProviderName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 344
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getUseDefaults()Ljava/lang/Boolean;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 345
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "UseDefaults: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getUseDefaults()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 346
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getPrincipalTags()Ljava/util/Map;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 347
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "PrincipalTags: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->getPrincipalTags()Ljava/util/Map;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 348
    :cond_3
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 349
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withIdentityPoolId(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;
    .locals 0
    .param p1, "identityPoolId"    # Ljava/lang/String;

    .line 122
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->identityPoolId:Ljava/lang/String;

    .line 123
    return-object p0
.end method

.method public withIdentityProviderName(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;
    .locals 0
    .param p1, "identityProviderName"    # Ljava/lang/String;

    .line 176
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->identityProviderName:Ljava/lang/String;

    .line 177
    return-object p0
.end method

.method public withPrincipalTags(Ljava/util/Map;)Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;"
        }
    .end annotation

    .line 288
    .local p1, "principalTags":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->principalTags:Ljava/util/Map;

    .line 289
    return-object p0
.end method

.method public withUseDefaults(Ljava/lang/Boolean;)Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;
    .locals 0
    .param p1, "useDefaults"    # Ljava/lang/Boolean;

    .line 242
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/SetPrincipalTagAttributeMapRequest;->useDefaults:Ljava/lang/Boolean;

    .line 243
    return-object p0
.end method
