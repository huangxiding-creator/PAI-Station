.class public Lcom/amazonaws/services/kms/model/GetParametersForImportResult;
.super Ljava/lang/Object;
.source "GetParametersForImportResult.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private importToken:Ljava/nio/ByteBuffer;

.field private keyId:Ljava/lang/String;

.field private parametersValidTo:Ljava/util/Date;

.field private publicKey:Ljava/nio/ByteBuffer;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 20
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
    instance-of v2, p1, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;

    if-nez v2, :cond_2

    .line 373
    return v1

    .line 374
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;

    .line 376
    .local v2, "other":Lcom/amazonaws/services/kms/model/GetParametersForImportResult;
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getKeyId()Ljava/lang/String;

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
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getKeyId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 379
    return v1

    .line 380
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getImportToken()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getImportToken()Ljava/nio/ByteBuffer;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 381
    return v1

    .line 382
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getImportToken()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 383
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getImportToken()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getImportToken()Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 384
    return v1

    .line 385
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 386
    return v1

    .line 387
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 388
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 389
    return v1

    .line 390
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getParametersValidTo()Ljava/util/Date;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getParametersValidTo()Ljava/util/Date;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 391
    return v1

    .line 392
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getParametersValidTo()Ljava/util/Date;

    move-result-object v3

    if-eqz v3, :cond_12

    .line 393
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getParametersValidTo()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getParametersValidTo()Ljava/util/Date;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/Date;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 394
    return v1

    .line 395
    :cond_12
    return v0
.end method

.method public getImportToken()Ljava/nio/ByteBuffer;
    .locals 1

    .line 160
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->importToken:Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method public getKeyId()Ljava/lang/String;
    .locals 1

    .line 88
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->keyId:Ljava/lang/String;

    return-object v0
.end method

.method public getParametersValidTo()Ljava/util/Date;
    .locals 1

    .line 281
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->parametersValidTo:Ljava/util/Date;

    return-object v0
.end method

.method public getPublicKey()Ljava/nio/ByteBuffer;
    .locals 1

    .line 220
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->publicKey:Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 353
    const/16 v0, 0x1f

    .line 354
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 356
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 357
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 358
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getImportToken()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getImportToken()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 359
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 360
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 361
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getParametersValidTo()Ljava/util/Date;

    move-result-object v3

    if-nez v3, :cond_3

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getParametersValidTo()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/Date;->hashCode()I

    move-result v4

    :goto_3
    add-int/2addr v1, v4

    .line 362
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setImportToken(Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p1, "importToken"    # Ljava/nio/ByteBuffer;

    .line 178
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->importToken:Ljava/nio/ByteBuffer;

    .line 179
    return-void
.end method

.method public setKeyId(Ljava/lang/String;)V
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 112
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->keyId:Ljava/lang/String;

    .line 113
    return-void
.end method

.method public setParametersValidTo(Ljava/util/Date;)V
    .locals 0
    .param p1, "parametersValidTo"    # Ljava/util/Date;

    .line 300
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->parametersValidTo:Ljava/util/Date;

    .line 301
    return-void
.end method

.method public setPublicKey(Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p1, "publicKey"    # Ljava/nio/ByteBuffer;

    .line 238
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->publicKey:Ljava/nio/ByteBuffer;

    .line 239
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 337
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 338
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 339
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getKeyId()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 340
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "KeyId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 341
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getImportToken()Ljava/nio/ByteBuffer;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 342
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ImportToken: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getImportToken()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 343
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 344
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "PublicKey: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 345
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getParametersValidTo()Ljava/util/Date;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 346
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ParametersValidTo: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->getParametersValidTo()Ljava/util/Date;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 347
    :cond_3
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 348
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withImportToken(Ljava/nio/ByteBuffer;)Lcom/amazonaws/services/kms/model/GetParametersForImportResult;
    .locals 0
    .param p1, "importToken"    # Ljava/nio/ByteBuffer;

    .line 201
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->importToken:Ljava/nio/ByteBuffer;

    .line 202
    return-object p0
.end method

.method public withKeyId(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/GetParametersForImportResult;
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 141
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->keyId:Ljava/lang/String;

    .line 142
    return-object p0
.end method

.method public withParametersValidTo(Ljava/util/Date;)Lcom/amazonaws/services/kms/model/GetParametersForImportResult;
    .locals 0
    .param p1, "parametersValidTo"    # Ljava/util/Date;

    .line 324
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->parametersValidTo:Ljava/util/Date;

    .line 325
    return-object p0
.end method

.method public withPublicKey(Ljava/nio/ByteBuffer;)Lcom/amazonaws/services/kms/model/GetParametersForImportResult;
    .locals 0
    .param p1, "publicKey"    # Ljava/nio/ByteBuffer;

    .line 261
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetParametersForImportResult;->publicKey:Ljava/nio/ByteBuffer;

    .line 262
    return-object p0
.end method
