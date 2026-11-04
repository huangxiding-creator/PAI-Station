.class public Lcom/amazonaws/services/kms/model/SignResult;
.super Ljava/lang/Object;
.source "SignResult.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private keyId:Ljava/lang/String;

.field private signature:Ljava/nio/ByteBuffer;

.field private signingAlgorithm:Ljava/lang/String;


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

    .line 489
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 490
    return v0

    .line 491
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 492
    return v1

    .line 494
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/kms/model/SignResult;

    if-nez v2, :cond_2

    .line 495
    return v1

    .line 496
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/kms/model/SignResult;

    .line 498
    .local v2, "other":Lcom/amazonaws/services/kms/model/SignResult;
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignResult;->getKeyId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 499
    return v1

    .line 500
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignResult;->getKeyId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 501
    return v1

    .line 502
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignResult;->getSignature()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignResult;->getSignature()Ljava/nio/ByteBuffer;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 503
    return v1

    .line 504
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignResult;->getSignature()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 505
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignResult;->getSignature()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignResult;->getSignature()Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 506
    return v1

    .line 507
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignResult;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignResult;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 508
    return v1

    .line 509
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignResult;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 510
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignResult;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignResult;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 511
    return v1

    .line 512
    :cond_e
    return v0
.end method

.method public getKeyId()Ljava/lang/String;
    .locals 1

    .line 96
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/SignResult;->keyId:Ljava/lang/String;

    return-object v0
.end method

.method public getSignature()Ljava/nio/ByteBuffer;
    .locals 1

    .line 208
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/SignResult;->signature:Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method public getSigningAlgorithm()Ljava/lang/String;
    .locals 1

    .line 363
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/SignResult;->signingAlgorithm:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 477
    const/16 v0, 0x1f

    .line 478
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 480
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 481
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignResult;->getSignature()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignResult;->getSignature()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 482
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 483
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignResult;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignResult;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_2
    add-int/2addr v2, v4

    .line 484
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public setKeyId(Ljava/lang/String;)V
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 117
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/SignResult;->keyId:Ljava/lang/String;

    .line 118
    return-void
.end method

.method public setSignature(Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p1, "signature"    # Ljava/nio/ByteBuffer;

    .line 273
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/SignResult;->signature:Ljava/nio/ByteBuffer;

    .line 274
    return-void
.end method

.method public setSigningAlgorithm(Lcom/amazonaws/services/kms/model/SigningAlgorithmSpec;)V
    .locals 1
    .param p1, "signingAlgorithm"    # Lcom/amazonaws/services/kms/model/SigningAlgorithmSpec;

    .line 426
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/SigningAlgorithmSpec;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/SignResult;->signingAlgorithm:Ljava/lang/String;

    .line 427
    return-void
.end method

.method public setSigningAlgorithm(Ljava/lang/String;)V
    .locals 0
    .param p1, "signingAlgorithm"    # Ljava/lang/String;

    .line 382
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/SignResult;->signingAlgorithm:Ljava/lang/String;

    .line 383
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 463
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 464
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 465
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignResult;->getKeyId()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 466
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "KeyId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 467
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignResult;->getSignature()Ljava/nio/ByteBuffer;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 468
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Signature: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignResult;->getSignature()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 469
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignResult;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 470
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SigningAlgorithm: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignResult;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 471
    :cond_2
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 472
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withKeyId(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/SignResult;
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 143
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/SignResult;->keyId:Ljava/lang/String;

    .line 144
    return-object p0
.end method

.method public withSignature(Ljava/nio/ByteBuffer;)Lcom/amazonaws/services/kms/model/SignResult;
    .locals 0
    .param p1, "signature"    # Ljava/nio/ByteBuffer;

    .line 343
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/SignResult;->signature:Ljava/nio/ByteBuffer;

    .line 344
    return-object p0
.end method

.method public withSigningAlgorithm(Lcom/amazonaws/services/kms/model/SigningAlgorithmSpec;)Lcom/amazonaws/services/kms/model/SignResult;
    .locals 1
    .param p1, "signingAlgorithm"    # Lcom/amazonaws/services/kms/model/SigningAlgorithmSpec;

    .line 450
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/SigningAlgorithmSpec;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/SignResult;->signingAlgorithm:Ljava/lang/String;

    .line 451
    return-object p0
.end method

.method public withSigningAlgorithm(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/SignResult;
    .locals 0
    .param p1, "signingAlgorithm"    # Ljava/lang/String;

    .line 406
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/SignResult;->signingAlgorithm:Ljava/lang/String;

    .line 407
    return-object p0
.end method
