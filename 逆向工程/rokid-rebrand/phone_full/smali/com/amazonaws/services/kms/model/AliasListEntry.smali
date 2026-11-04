.class public Lcom/amazonaws/services/kms/model/AliasListEntry;
.super Ljava/lang/Object;
.source "AliasListEntry.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private aliasArn:Ljava/lang/String;

.field private aliasName:Ljava/lang/String;

.field private creationDate:Ljava/util/Date;

.field private lastUpdatedDate:Ljava/util/Date;

.field private targetKeyId:Ljava/lang/String;


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

    .line 354
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 355
    return v0

    .line 356
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 357
    return v1

    .line 359
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/kms/model/AliasListEntry;

    if-nez v2, :cond_2

    .line 360
    return v1

    .line 361
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/kms/model/AliasListEntry;

    .line 363
    .local v2, "other":Lcom/amazonaws/services/kms/model/AliasListEntry;
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getAliasName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getAliasName()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 364
    return v1

    .line 365
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getAliasName()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 366
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getAliasName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getAliasName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 367
    return v1

    .line 368
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getAliasArn()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getAliasArn()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 369
    return v1

    .line 370
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getAliasArn()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getAliasArn()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getAliasArn()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 371
    return v1

    .line 372
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getTargetKeyId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getTargetKeyId()Ljava/lang/String;

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
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getTargetKeyId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 375
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getTargetKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getTargetKeyId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 376
    return v1

    .line 377
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getCreationDate()Ljava/util/Date;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getCreationDate()Ljava/util/Date;

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
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getCreationDate()Ljava/util/Date;

    move-result-object v3

    if-eqz v3, :cond_12

    .line 380
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getCreationDate()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getCreationDate()Ljava/util/Date;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/Date;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 381
    return v1

    .line 382
    :cond_12
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getLastUpdatedDate()Ljava/util/Date;

    move-result-object v3

    if-nez v3, :cond_13

    move v3, v0

    goto :goto_8

    :cond_13
    move v3, v1

    :goto_8
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getLastUpdatedDate()Ljava/util/Date;

    move-result-object v4

    if-nez v4, :cond_14

    move v4, v0

    goto :goto_9

    :cond_14
    move v4, v1

    :goto_9
    xor-int/2addr v3, v4

    if-eqz v3, :cond_15

    .line 383
    return v1

    .line 384
    :cond_15
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getLastUpdatedDate()Ljava/util/Date;

    move-result-object v3

    if-eqz v3, :cond_16

    .line 385
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getLastUpdatedDate()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getLastUpdatedDate()Ljava/util/Date;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/Date;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_16

    .line 386
    return v1

    .line 387
    :cond_16
    return v0
.end method

.method public getAliasArn()Ljava/lang/String;
    .locals 1

    .line 144
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/AliasListEntry;->aliasArn:Ljava/lang/String;

    return-object v0
.end method

.method public getAliasName()Ljava/lang/String;
    .locals 1

    .line 84
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/AliasListEntry;->aliasName:Ljava/lang/String;

    return-object v0
.end method

.method public getCreationDate()Ljava/util/Date;
    .locals 1

    .line 247
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/AliasListEntry;->creationDate:Ljava/util/Date;

    return-object v0
.end method

.method public getLastUpdatedDate()Ljava/util/Date;
    .locals 1

    .line 282
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/AliasListEntry;->lastUpdatedDate:Ljava/util/Date;

    return-object v0
.end method

.method public getTargetKeyId()Ljava/lang/String;
    .locals 1

    .line 198
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/AliasListEntry;->targetKeyId:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 338
    const/16 v0, 0x1f

    .line 339
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 341
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getAliasName()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getAliasName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 342
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getAliasArn()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getAliasArn()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 343
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 344
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getTargetKeyId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getTargetKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 345
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 346
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getCreationDate()Ljava/util/Date;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v4

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getCreationDate()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/Date;->hashCode()I

    move-result v3

    :goto_3
    add-int/2addr v1, v3

    .line 347
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 348
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getLastUpdatedDate()Ljava/util/Date;

    move-result-object v3

    if-nez v3, :cond_4

    goto :goto_4

    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getLastUpdatedDate()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/Date;->hashCode()I

    move-result v4

    :goto_4
    add-int/2addr v2, v4

    .line 349
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public setAliasArn(Ljava/lang/String;)V
    .locals 0
    .param p1, "aliasArn"    # Ljava/lang/String;

    .line 160
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/AliasListEntry;->aliasArn:Ljava/lang/String;

    .line 161
    return-void
.end method

.method public setAliasName(Ljava/lang/String;)V
    .locals 0
    .param p1, "aliasName"    # Ljava/lang/String;

    .line 103
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/AliasListEntry;->aliasName:Ljava/lang/String;

    .line 104
    return-void
.end method

.method public setCreationDate(Ljava/util/Date;)V
    .locals 0
    .param p1, "creationDate"    # Ljava/util/Date;

    .line 257
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/AliasListEntry;->creationDate:Ljava/util/Date;

    .line 258
    return-void
.end method

.method public setLastUpdatedDate(Ljava/util/Date;)V
    .locals 0
    .param p1, "lastUpdatedDate"    # Ljava/util/Date;

    .line 292
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/AliasListEntry;->lastUpdatedDate:Ljava/util/Date;

    .line 293
    return-void
.end method

.method public setTargetKeyId(Ljava/lang/String;)V
    .locals 0
    .param p1, "targetKeyId"    # Ljava/lang/String;

    .line 215
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/AliasListEntry;->targetKeyId:Ljava/lang/String;

    .line 216
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 320
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 321
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 322
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getAliasName()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 323
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AliasName: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getAliasName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 324
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getAliasArn()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 325
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AliasArn: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getAliasArn()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 326
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getTargetKeyId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 327
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "TargetKeyId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getTargetKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 328
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getCreationDate()Ljava/util/Date;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 329
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "CreationDate: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getCreationDate()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 330
    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getLastUpdatedDate()Ljava/util/Date;

    move-result-object v1

    if-eqz v1, :cond_4

    .line 331
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "LastUpdatedDate: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/AliasListEntry;->getLastUpdatedDate()Ljava/util/Date;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 332
    :cond_4
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 333
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withAliasArn(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/AliasListEntry;
    .locals 0
    .param p1, "aliasArn"    # Ljava/lang/String;

    .line 181
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/AliasListEntry;->aliasArn:Ljava/lang/String;

    .line 182
    return-object p0
.end method

.method public withAliasName(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/AliasListEntry;
    .locals 0
    .param p1, "aliasName"    # Ljava/lang/String;

    .line 127
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/AliasListEntry;->aliasName:Ljava/lang/String;

    .line 128
    return-object p0
.end method

.method public withCreationDate(Ljava/util/Date;)Lcom/amazonaws/services/kms/model/AliasListEntry;
    .locals 0
    .param p1, "creationDate"    # Ljava/util/Date;

    .line 272
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/AliasListEntry;->creationDate:Ljava/util/Date;

    .line 273
    return-object p0
.end method

.method public withLastUpdatedDate(Ljava/util/Date;)Lcom/amazonaws/services/kms/model/AliasListEntry;
    .locals 0
    .param p1, "lastUpdatedDate"    # Ljava/util/Date;

    .line 307
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/AliasListEntry;->lastUpdatedDate:Ljava/util/Date;

    .line 308
    return-object p0
.end method

.method public withTargetKeyId(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/AliasListEntry;
    .locals 0
    .param p1, "targetKeyId"    # Ljava/lang/String;

    .line 237
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/AliasListEntry;->targetKeyId:Ljava/lang/String;

    .line 238
    return-object p0
.end method
