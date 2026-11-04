.class public Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;
.super Ljava/lang/Object;
.source "GenerateDataKeyWithoutPlaintextResult.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private ciphertextBlob:Ljava/nio/ByteBuffer;

.field private keyId:Ljava/lang/String;


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

    .line 205
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 206
    return v0

    .line 207
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 208
    return v1

    .line 210
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;

    if-nez v2, :cond_2

    .line 211
    return v1

    .line 212
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;

    .line 214
    .local v2, "other":Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->getCiphertextBlob()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->getCiphertextBlob()Ljava/nio/ByteBuffer;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 215
    return v1

    .line 216
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->getCiphertextBlob()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 217
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->getCiphertextBlob()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->getCiphertextBlob()Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 218
    return v1

    .line 219
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->getKeyId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 220
    return v1

    .line 221
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->getKeyId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 222
    return v1

    .line 223
    :cond_a
    return v0
.end method

.method public getCiphertextBlob()Ljava/nio/ByteBuffer;
    .locals 1

    .line 59
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->ciphertextBlob:Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method public getKeyId()Ljava/lang/String;
    .locals 1

    .line 124
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->keyId:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 194
    const/16 v0, 0x1f

    .line 195
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 197
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 198
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->getCiphertextBlob()Ljava/nio/ByteBuffer;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->getCiphertextBlob()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 199
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_1
    add-int/2addr v1, v4

    .line 200
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setCiphertextBlob(Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p1, "ciphertextBlob"    # Ljava/nio/ByteBuffer;

    .line 78
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->ciphertextBlob:Ljava/nio/ByteBuffer;

    .line 79
    return-void
.end method

.method public setKeyId(Ljava/lang/String;)V
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 144
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->keyId:Ljava/lang/String;

    .line 145
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 182
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 183
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 184
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->getCiphertextBlob()Ljava/nio/ByteBuffer;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 185
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "CiphertextBlob: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->getCiphertextBlob()Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 186
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->getKeyId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 187
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "KeyId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->getKeyId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 188
    :cond_1
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 189
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withCiphertextBlob(Ljava/nio/ByteBuffer;)Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;
    .locals 0
    .param p1, "ciphertextBlob"    # Ljava/nio/ByteBuffer;

    .line 103
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->ciphertextBlob:Ljava/nio/ByteBuffer;

    .line 104
    return-object p0
.end method

.method public withKeyId(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 169
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GenerateDataKeyWithoutPlaintextResult;->keyId:Ljava/lang/String;

    .line 170
    return-object p0
.end method
