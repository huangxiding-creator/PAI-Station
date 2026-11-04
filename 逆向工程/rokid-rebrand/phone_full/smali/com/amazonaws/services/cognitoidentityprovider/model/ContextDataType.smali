.class public Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;
.super Ljava/lang/Object;
.source "ContextDataType.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private encodedData:Ljava/lang/String;

.field private httpHeaders:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/HttpHeader;",
            ">;"
        }
    .end annotation
.end field

.field private ipAddress:Ljava/lang/String;

.field private serverName:Ljava/lang/String;

.field private serverPath:Ljava/lang/String;


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

    .line 367
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 368
    return v0

    .line 369
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 370
    return v1

    .line 372
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;

    if-nez v2, :cond_2

    .line 373
    return v1

    .line 374
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;

    .line 376
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getIpAddress()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getIpAddress()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 377
    return v1

    .line 378
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getIpAddress()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 379
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getIpAddress()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getIpAddress()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 380
    return v1

    .line 381
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getServerName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getServerName()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 382
    return v1

    .line 383
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getServerName()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 384
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getServerName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getServerName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 385
    return v1

    .line 386
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getServerPath()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getServerPath()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 387
    return v1

    .line 388
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getServerPath()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 389
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getServerPath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getServerPath()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 390
    return v1

    .line 391
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getHttpHeaders()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getHttpHeaders()Ljava/util/List;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 392
    return v1

    .line 393
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getHttpHeaders()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_12

    .line 394
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getHttpHeaders()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getHttpHeaders()Ljava/util/List;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 395
    return v1

    .line 396
    :cond_12
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getEncodedData()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_13

    move v3, v0

    goto :goto_8

    :cond_13
    move v3, v1

    :goto_8
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getEncodedData()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_14

    move v4, v0

    goto :goto_9

    :cond_14
    move v4, v1

    :goto_9
    xor-int/2addr v3, v4

    if-eqz v3, :cond_15

    .line 397
    return v1

    .line 398
    :cond_15
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getEncodedData()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_16

    .line 399
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getEncodedData()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getEncodedData()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_16

    .line 400
    return v1

    .line 401
    :cond_16
    return v0
.end method

.method public getEncodedData()Ljava/lang/String;
    .locals 1

    .line 284
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->encodedData:Ljava/lang/String;

    return-object v0
.end method

.method public getHttpHeaders()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/HttpHeader;",
            ">;"
        }
    .end annotation

    .line 208
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->httpHeaders:Ljava/util/List;

    return-object v0
.end method

.method public getIpAddress()Ljava/lang/String;
    .locals 1

    .line 73
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->ipAddress:Ljava/lang/String;

    return-object v0
.end method

.method public getServerName()Ljava/lang/String;
    .locals 1

    .line 118
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->serverName:Ljava/lang/String;

    return-object v0
.end method

.method public getServerPath()Ljava/lang/String;
    .locals 1

    .line 163
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->serverPath:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 352
    const/16 v0, 0x1f

    .line 353
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 355
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getIpAddress()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getIpAddress()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 356
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getServerName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getServerName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 357
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getServerPath()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getServerPath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 358
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 359
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getHttpHeaders()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v4

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getHttpHeaders()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_3
    add-int/2addr v1, v3

    .line 360
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 361
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getEncodedData()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_4

    goto :goto_4

    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getEncodedData()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_4
    add-int/2addr v2, v4

    .line 362
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public setEncodedData(Ljava/lang/String;)V
    .locals 0
    .param p1, "encodedData"    # Ljava/lang/String;

    .line 300
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->encodedData:Ljava/lang/String;

    .line 301
    return-void
.end method

.method public setHttpHeaders(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/HttpHeader;",
            ">;)V"
        }
    .end annotation

    .line 221
    .local p1, "httpHeaders":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/cognitoidentityprovider/model/HttpHeader;>;"
    if-nez p1, :cond_0

    .line 222
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->httpHeaders:Ljava/util/List;

    .line 223
    return-void

    .line 226
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->httpHeaders:Ljava/util/List;

    .line 227
    return-void
.end method

.method public setIpAddress(Ljava/lang/String;)V
    .locals 0
    .param p1, "ipAddress"    # Ljava/lang/String;

    .line 86
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->ipAddress:Ljava/lang/String;

    .line 87
    return-void
.end method

.method public setServerName(Ljava/lang/String;)V
    .locals 0
    .param p1, "serverName"    # Ljava/lang/String;

    .line 131
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->serverName:Ljava/lang/String;

    .line 132
    return-void
.end method

.method public setServerPath(Ljava/lang/String;)V
    .locals 0
    .param p1, "serverPath"    # Ljava/lang/String;

    .line 176
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->serverPath:Ljava/lang/String;

    .line 177
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 334
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 335
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 336
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getIpAddress()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 337
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "IpAddress: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getIpAddress()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 338
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getServerName()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 339
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ServerName: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getServerName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 340
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getServerPath()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 341
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ServerPath: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getServerPath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 342
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getHttpHeaders()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 343
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "HttpHeaders: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getHttpHeaders()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 344
    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getEncodedData()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_4

    .line 345
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "EncodedData: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getEncodedData()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 346
    :cond_4
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 347
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withEncodedData(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;
    .locals 0
    .param p1, "encodedData"    # Ljava/lang/String;

    .line 321
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->encodedData:Ljava/lang/String;

    .line 322
    return-object p0
.end method

.method public withHttpHeaders(Ljava/util/Collection;)Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/HttpHeader;",
            ">;)",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;"
        }
    .end annotation

    .line 268
    .local p1, "httpHeaders":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/cognitoidentityprovider/model/HttpHeader;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->setHttpHeaders(Ljava/util/Collection;)V

    .line 269
    return-object p0
.end method

.method public varargs withHttpHeaders([Lcom/amazonaws/services/cognitoidentityprovider/model/HttpHeader;)Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;
    .locals 4
    .param p1, "httpHeaders"    # [Lcom/amazonaws/services/cognitoidentityprovider/model/HttpHeader;

    .line 244
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->getHttpHeaders()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 245
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->httpHeaders:Ljava/util/List;

    .line 247
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    .line 248
    .local v2, "value":Lcom/amazonaws/services/cognitoidentityprovider/model/HttpHeader;
    iget-object v3, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->httpHeaders:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 247
    .end local v2    # "value":Lcom/amazonaws/services/cognitoidentityprovider/model/HttpHeader;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 250
    :cond_1
    return-object p0
.end method

.method public withIpAddress(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;
    .locals 0
    .param p1, "ipAddress"    # Ljava/lang/String;

    .line 104
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->ipAddress:Ljava/lang/String;

    .line 105
    return-object p0
.end method

.method public withServerName(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;
    .locals 0
    .param p1, "serverName"    # Ljava/lang/String;

    .line 149
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->serverName:Ljava/lang/String;

    .line 150
    return-object p0
.end method

.method public withServerPath(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;
    .locals 0
    .param p1, "serverPath"    # Ljava/lang/String;

    .line 194
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->serverPath:Ljava/lang/String;

    .line 195
    return-object p0
.end method
