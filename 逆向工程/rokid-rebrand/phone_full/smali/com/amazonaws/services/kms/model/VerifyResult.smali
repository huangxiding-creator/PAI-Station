.class public Lcom/amazonaws/services/kms/model/VerifyResult;
.super Ljava/lang/Object;
.source "VerifyResult.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private keyId:Ljava/lang/String;

.field private signatureValid:Ljava/lang/Boolean;

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

    .line 375
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 376
    return v0

    .line 377
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 378
    return v1

    .line 380
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/kms/model/VerifyResult;

    if-nez v2, :cond_2

    .line 381
    return v1

    .line 382
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/kms/model/VerifyResult;

    .line 384
    .local v2, "other":Lcom/amazonaws/services/kms/model/VerifyResult;
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/VerifyResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/VerifyResult;->getKeyId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 385
    return v1

    .line 386
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/VerifyResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/VerifyResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/VerifyResult;->getKeyId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 387
    return v1

    .line 388
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/VerifyResult;->getSignatureValid()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/VerifyResult;->getSignatureValid()Ljava/lang/Boolean;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 389
    return v1

    .line 390
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/VerifyResult;->getSignatureValid()Ljava/lang/Boolean;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 391
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/VerifyResult;->getSignatureValid()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/VerifyResult;->getSignatureValid()Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 392
    return v1

    .line 393
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/VerifyResult;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/VerifyResult;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 394
    return v1

    .line 395
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/VerifyResult;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 396
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/VerifyResult;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/VerifyResult;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 397
    return v1

    .line 398
    :cond_e
    return v0
.end method

.method public getKeyId()Ljava/lang/String;
    .locals 1

    .line 77
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/VerifyResult;->keyId:Ljava/lang/String;

    return-object v0
.end method

.method public getSignatureValid()Ljava/lang/Boolean;
    .locals 1

    .line 175
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/VerifyResult;->signatureValid:Ljava/lang/Boolean;

    return-object v0
.end method

.method public getSigningAlgorithm()Ljava/lang/String;
    .locals 1

    .line 248
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/VerifyResult;->signingAlgorithm:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 362
    const/16 v0, 0x1f

    .line 363
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 365
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/VerifyResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/VerifyResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 366
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 367
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/VerifyResult;->getSignatureValid()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/VerifyResult;->getSignatureValid()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Boolean;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 368
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 369
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/VerifyResult;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/VerifyResult;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_2
    add-int/2addr v2, v4

    .line 370
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public isSignatureValid()Ljava/lang/Boolean;
    .locals 1

    .line 151
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/VerifyResult;->signatureValid:Ljava/lang/Boolean;

    return-object v0
.end method

.method public setKeyId(Ljava/lang/String;)V
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 99
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/VerifyResult;->keyId:Ljava/lang/String;

    .line 100
    return-void
.end method

.method public setSignatureValid(Ljava/lang/Boolean;)V
    .locals 0
    .param p1, "signatureValid"    # Ljava/lang/Boolean;

    .line 199
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/VerifyResult;->signatureValid:Ljava/lang/Boolean;

    .line 200
    return-void
.end method

.method public setSigningAlgorithm(Lcom/amazonaws/services/kms/model/SigningAlgorithmSpec;)V
    .locals 1
    .param p1, "signingAlgorithm"    # Lcom/amazonaws/services/kms/model/SigningAlgorithmSpec;

    .line 311
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/SigningAlgorithmSpec;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/VerifyResult;->signingAlgorithm:Ljava/lang/String;

    .line 312
    return-void
.end method

.method public setSigningAlgorithm(Ljava/lang/String;)V
    .locals 0
    .param p1, "signingAlgorithm"    # Ljava/lang/String;

    .line 267
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/VerifyResult;->signingAlgorithm:Ljava/lang/String;

    .line 268
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 348
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 349
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 350
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/VerifyResult;->getKeyId()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 351
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "KeyId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/VerifyResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 352
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/VerifyResult;->getSignatureValid()Ljava/lang/Boolean;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 353
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SignatureValid: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/VerifyResult;->getSignatureValid()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 354
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/VerifyResult;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 355
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SigningAlgorithm: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/VerifyResult;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 356
    :cond_2
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 357
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withKeyId(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/VerifyResult;
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 126
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/VerifyResult;->keyId:Ljava/lang/String;

    .line 127
    return-object p0
.end method

.method public withSignatureValid(Ljava/lang/Boolean;)Lcom/amazonaws/services/kms/model/VerifyResult;
    .locals 0
    .param p1, "signatureValid"    # Ljava/lang/Boolean;

    .line 228
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/VerifyResult;->signatureValid:Ljava/lang/Boolean;

    .line 229
    return-object p0
.end method

.method public withSigningAlgorithm(Lcom/amazonaws/services/kms/model/SigningAlgorithmSpec;)Lcom/amazonaws/services/kms/model/VerifyResult;
    .locals 1
    .param p1, "signingAlgorithm"    # Lcom/amazonaws/services/kms/model/SigningAlgorithmSpec;

    .line 335
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/SigningAlgorithmSpec;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/VerifyResult;->signingAlgorithm:Ljava/lang/String;

    .line 336
    return-object p0
.end method

.method public withSigningAlgorithm(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/VerifyResult;
    .locals 0
    .param p1, "signingAlgorithm"    # Ljava/lang/String;

    .line 291
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/VerifyResult;->signingAlgorithm:Ljava/lang/String;

    .line 292
    return-object p0
.end method
