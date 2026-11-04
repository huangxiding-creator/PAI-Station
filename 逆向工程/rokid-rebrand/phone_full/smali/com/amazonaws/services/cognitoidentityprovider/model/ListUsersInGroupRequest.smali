.class public Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "ListUsersInGroupRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private groupName:Ljava/lang/String;

.field private limit:Ljava/lang/Integer;

.field private nextToken:Ljava/lang/String;

.field private userPoolId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 30
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 346
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 347
    return v0

    .line 348
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 349
    return v1

    .line 351
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;

    if-nez v2, :cond_2

    .line 352
    return v1

    .line 353
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;

    .line 355
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 356
    return v1

    .line 357
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 358
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 359
    return v1

    .line 360
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getGroupName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getGroupName()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 361
    return v1

    .line 362
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getGroupName()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 363
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getGroupName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getGroupName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 364
    return v1

    .line 365
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getLimit()Ljava/lang/Integer;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getLimit()Ljava/lang/Integer;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 366
    return v1

    .line 367
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getLimit()Ljava/lang/Integer;

    move-result-object v3

    if-eqz v3, :cond_e

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getLimit()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getLimit()Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Integer;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 368
    return v1

    .line 369
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getNextToken()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getNextToken()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 370
    return v1

    .line 371
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getNextToken()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_12

    .line 372
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getNextToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getNextToken()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 373
    return v1

    .line 374
    :cond_12
    return v0
.end method

.method public getGroupName()Ljava/lang/String;
    .locals 1

    .line 146
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->groupName:Ljava/lang/String;

    return-object v0
.end method

.method public getLimit()Ljava/lang/Integer;
    .locals 1

    .line 202
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->limit:Ljava/lang/Integer;

    return-object v0
.end method

.method public getNextToken()Ljava/lang/String;
    .locals 1

    .line 260
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->nextToken:Ljava/lang/String;

    return-object v0
.end method

.method public getUserPoolId()Ljava/lang/String;
    .locals 1

    .line 89
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->userPoolId:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 334
    const/16 v0, 0x1f

    .line 335
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 337
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 338
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getGroupName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getGroupName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 339
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getLimit()Ljava/lang/Integer;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getLimit()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Integer;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 340
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getNextToken()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getNextToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_3
    add-int/2addr v1, v4

    .line 341
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setGroupName(Ljava/lang/String;)V
    .locals 0
    .param p1, "groupName"    # Ljava/lang/String;

    .line 163
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->groupName:Ljava/lang/String;

    .line 164
    return-void
.end method

.method public setLimit(Ljava/lang/Integer;)V
    .locals 0
    .param p1, "limit"    # Ljava/lang/Integer;

    .line 218
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->limit:Ljava/lang/Integer;

    .line 219
    return-void
.end method

.method public setNextToken(Ljava/lang/String;)V
    .locals 0
    .param p1, "nextToken"    # Ljava/lang/String;

    .line 280
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->nextToken:Ljava/lang/String;

    .line 281
    return-void
.end method

.method public setUserPoolId(Ljava/lang/String;)V
    .locals 0
    .param p1, "userPoolId"    # Ljava/lang/String;

    .line 106
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->userPoolId:Ljava/lang/String;

    .line 107
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 318
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 319
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 320
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 321
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "UserPoolId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 322
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getGroupName()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 323
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "GroupName: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getGroupName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 324
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getLimit()Ljava/lang/Integer;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 325
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Limit: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getLimit()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 326
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getNextToken()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 327
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "NextToken: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->getNextToken()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 328
    :cond_3
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 329
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withGroupName(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;
    .locals 0
    .param p1, "groupName"    # Ljava/lang/String;

    .line 185
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->groupName:Ljava/lang/String;

    .line 186
    return-object p0
.end method

.method public withLimit(Ljava/lang/Integer;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;
    .locals 0
    .param p1, "limit"    # Ljava/lang/Integer;

    .line 239
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->limit:Ljava/lang/Integer;

    .line 240
    return-object p0
.end method

.method public withNextToken(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;
    .locals 0
    .param p1, "nextToken"    # Ljava/lang/String;

    .line 305
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->nextToken:Ljava/lang/String;

    .line 306
    return-object p0
.end method

.method public withUserPoolId(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;
    .locals 0
    .param p1, "userPoolId"    # Ljava/lang/String;

    .line 128
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUsersInGroupRequest;->userPoolId:Ljava/lang/String;

    .line 129
    return-object p0
.end method
