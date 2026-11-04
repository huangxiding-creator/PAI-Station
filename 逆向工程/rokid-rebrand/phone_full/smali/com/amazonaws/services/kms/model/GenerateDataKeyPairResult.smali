.class public Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;
.super Ljava/lang/Object;
.source "GenerateDataKeyPairResult.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private keyId:Ljava/lang/String;

.field private keyPairSpec:Ljava/lang/String;

.field private privateKeyCiphertextBlob:Ljava/nio/ByteBuffer;

.field private privateKeyPlaintext:Ljava/nio/ByteBuffer;

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

    .line 478
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 479
    return v0

    .line 480
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 481
    return v1

    .line 483
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;

    if-nez v2, :cond_2

    .line 484
    return v1

    .line 485
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;

    .line 487
    .local v2, "other":Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPrivateKeyCiphertextBlob()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    .line 488
    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPrivateKeyCiphertextBlob()Ljava/nio/ByteBuffer;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 489
    return v1

    .line 490
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPrivateKeyCiphertextBlob()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 491
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPrivateKeyCiphertextBlob()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPrivateKeyCiphertextBlob()Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 492
    return v1

    .line 493
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPrivateKeyPlaintext()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPrivateKeyPlaintext()Ljava/nio/ByteBuffer;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 494
    return v1

    .line 495
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPrivateKeyPlaintext()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 496
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPrivateKeyPlaintext()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPrivateKeyPlaintext()Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 497
    return v1

    .line 498
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 499
    return v1

    .line 500
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 501
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 502
    return v1

    .line 503
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getKeyId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 504
    return v1

    .line 505
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_12

    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getKeyId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 506
    return v1

    .line 507
    :cond_12
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getKeyPairSpec()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_13

    move v3, v0

    goto :goto_8

    :cond_13
    move v3, v1

    :goto_8
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getKeyPairSpec()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_14

    move v4, v0

    goto :goto_9

    :cond_14
    move v4, v1

    :goto_9
    xor-int/2addr v3, v4

    if-eqz v3, :cond_15

    .line 508
    return v1

    .line 509
    :cond_15
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getKeyPairSpec()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_16

    .line 510
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getKeyPairSpec()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getKeyPairSpec()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_16

    .line 511
    return v1

    .line 512
    :cond_16
    return v0
.end method

.method public getKeyId()Ljava/lang/String;
    .locals 1

    .line 282
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->keyId:Ljava/lang/String;

    return-object v0
.end method

.method public getKeyPairSpec()Ljava/lang/String;
    .locals 1

    .line 346
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->keyPairSpec:Ljava/lang/String;

    return-object v0
.end method

.method public getPrivateKeyCiphertextBlob()Ljava/nio/ByteBuffer;
    .locals 1

    .line 95
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->privateKeyCiphertextBlob:Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method public getPrivateKeyPlaintext()Ljava/nio/ByteBuffer;
    .locals 1

    .line 162
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->privateKeyPlaintext:Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method public getPublicKey()Ljava/nio/ByteBuffer;
    .locals 1

    .line 224
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->publicKey:Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 460
    const/16 v0, 0x1f

    .line 461
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 463
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 465
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPrivateKeyCiphertextBlob()Ljava/nio/ByteBuffer;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPrivateKeyCiphertextBlob()Ljava/nio/ByteBuffer;

    move-result-object v3

    .line 466
    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 467
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 468
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPrivateKeyPlaintext()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPrivateKeyPlaintext()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 469
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 470
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v4

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_3
    add-int/2addr v1, v3

    .line 471
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 472
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getKeyPairSpec()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_4

    goto :goto_4

    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getKeyPairSpec()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_4
    add-int/2addr v2, v4

    .line 473
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public setKeyId(Ljava/lang/String;)V
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 302
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->keyId:Ljava/lang/String;

    .line 303
    return-void
.end method

.method public setKeyPairSpec(Lcom/amazonaws/services/kms/model/DataKeyPairSpec;)V
    .locals 1
    .param p1, "keyPairSpec"    # Lcom/amazonaws/services/kms/model/DataKeyPairSpec;

    .line 406
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/DataKeyPairSpec;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->keyPairSpec:Ljava/lang/String;

    .line 407
    return-void
.end method

.method public setKeyPairSpec(Ljava/lang/String;)V
    .locals 0
    .param p1, "keyPairSpec"    # Ljava/lang/String;

    .line 364
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->keyPairSpec:Ljava/lang/String;

    .line 365
    return-void
.end method

.method public setPrivateKeyCiphertextBlob(Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p1, "privateKeyCiphertextBlob"    # Ljava/nio/ByteBuffer;

    .line 115
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->privateKeyCiphertextBlob:Ljava/nio/ByteBuffer;

    .line 116
    return-void
.end method

.method public setPrivateKeyPlaintext(Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p1, "privateKeyPlaintext"    # Ljava/nio/ByteBuffer;

    .line 182
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->privateKeyPlaintext:Ljava/nio/ByteBuffer;

    .line 183
    return-void
.end method

.method public setPublicKey(Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p1, "publicKey"    # Ljava/nio/ByteBuffer;

    .line 240
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->publicKey:Ljava/nio/ByteBuffer;

    .line 241
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 442
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 443
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 444
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPrivateKeyCiphertextBlob()Ljava/nio/ByteBuffer;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 445
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "PrivateKeyCiphertextBlob: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPrivateKeyCiphertextBlob()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 446
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPrivateKeyPlaintext()Ljava/nio/ByteBuffer;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 447
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "PrivateKeyPlaintext: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPrivateKeyPlaintext()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 448
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 449
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "PublicKey: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 450
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getKeyId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 451
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "KeyId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 452
    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getKeyPairSpec()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_4

    .line 453
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "KeyPairSpec: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->getKeyPairSpec()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 454
    :cond_4
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 455
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withKeyId(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 327
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->keyId:Ljava/lang/String;

    .line 328
    return-object p0
.end method

.method public withKeyPairSpec(Lcom/amazonaws/services/kms/model/DataKeyPairSpec;)Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;
    .locals 1
    .param p1, "keyPairSpec"    # Lcom/amazonaws/services/kms/model/DataKeyPairSpec;

    .line 429
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/DataKeyPairSpec;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->keyPairSpec:Ljava/lang/String;

    .line 430
    return-object p0
.end method

.method public withKeyPairSpec(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;
    .locals 0
    .param p1, "keyPairSpec"    # Ljava/lang/String;

    .line 387
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->keyPairSpec:Ljava/lang/String;

    .line 388
    return-object p0
.end method

.method public withPrivateKeyCiphertextBlob(Ljava/nio/ByteBuffer;)Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;
    .locals 0
    .param p1, "privateKeyCiphertextBlob"    # Ljava/nio/ByteBuffer;

    .line 141
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->privateKeyCiphertextBlob:Ljava/nio/ByteBuffer;

    .line 142
    return-object p0
.end method

.method public withPrivateKeyPlaintext(Ljava/nio/ByteBuffer;)Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;
    .locals 0
    .param p1, "privateKeyPlaintext"    # Ljava/nio/ByteBuffer;

    .line 207
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->privateKeyPlaintext:Ljava/nio/ByteBuffer;

    .line 208
    return-object p0
.end method

.method public withPublicKey(Ljava/nio/ByteBuffer;)Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;
    .locals 0
    .param p1, "publicKey"    # Ljava/nio/ByteBuffer;

    .line 261
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyPairResult;->publicKey:Ljava/nio/ByteBuffer;

    .line 262
    return-object p0
.end method
