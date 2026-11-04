.class public Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "ImportKeyMaterialRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private encryptedKeyMaterial:Ljava/nio/ByteBuffer;

.field private expirationModel:Ljava/lang/String;

.field private importToken:Ljava/nio/ByteBuffer;

.field private keyId:Ljava/lang/String;

.field private validTo:Ljava/util/Date;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 128
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 827
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 828
    return v0

    .line 829
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 830
    return v1

    .line 832
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;

    if-nez v2, :cond_2

    .line 833
    return v1

    .line 834
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;

    .line 836
    .local v2, "other":Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getKeyId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 837
    return v1

    .line 838
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getKeyId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 839
    return v1

    .line 840
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getImportToken()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getImportToken()Ljava/nio/ByteBuffer;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 841
    return v1

    .line 842
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getImportToken()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 843
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getImportToken()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getImportToken()Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 844
    return v1

    .line 845
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getEncryptedKeyMaterial()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getEncryptedKeyMaterial()Ljava/nio/ByteBuffer;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 846
    return v1

    .line 847
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getEncryptedKeyMaterial()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 848
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getEncryptedKeyMaterial()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getEncryptedKeyMaterial()Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 849
    return v1

    .line 850
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getValidTo()Ljava/util/Date;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getValidTo()Ljava/util/Date;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 851
    return v1

    .line 852
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getValidTo()Ljava/util/Date;

    move-result-object v3

    if-eqz v3, :cond_12

    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getValidTo()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getValidTo()Ljava/util/Date;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/Date;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 853
    return v1

    .line 854
    :cond_12
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getExpirationModel()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_13

    move v3, v0

    goto :goto_8

    :cond_13
    move v3, v1

    :goto_8
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getExpirationModel()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_14

    move v4, v0

    goto :goto_9

    :cond_14
    move v4, v1

    :goto_9
    xor-int/2addr v3, v4

    if-eqz v3, :cond_15

    .line 855
    return v1

    .line 856
    :cond_15
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getExpirationModel()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_16

    .line 857
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getExpirationModel()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getExpirationModel()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_16

    .line 858
    return v1

    .line 859
    :cond_16
    return v0
.end method

.method public getEncryptedKeyMaterial()Ljava/nio/ByteBuffer;
    .locals 1

    .line 519
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->encryptedKeyMaterial:Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method public getExpirationModel()Ljava/lang/String;
    .locals 1

    .line 669
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->expirationModel:Ljava/lang/String;

    return-object v0
.end method

.method public getImportToken()Ljava/nio/ByteBuffer;
    .locals 1

    .line 448
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->importToken:Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method public getKeyId()Ljava/lang/String;
    .locals 1

    .line 281
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->keyId:Ljava/lang/String;

    return-object v0
.end method

.method public getValidTo()Ljava/util/Date;
    .locals 1

    .line 594
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->validTo:Ljava/util/Date;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 811
    const/16 v0, 0x1f

    .line 812
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 814
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 815
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 816
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getImportToken()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getImportToken()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 817
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 818
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getEncryptedKeyMaterial()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getEncryptedKeyMaterial()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 819
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getValidTo()Ljava/util/Date;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v4

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getValidTo()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/Date;->hashCode()I

    move-result v3

    :goto_3
    add-int/2addr v1, v3

    .line 820
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 821
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getExpirationModel()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_4

    goto :goto_4

    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getExpirationModel()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_4
    add-int/2addr v2, v4

    .line 822
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public setEncryptedKeyMaterial(Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p1, "encryptedKeyMaterial"    # Ljava/nio/ByteBuffer;

    .line 542
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->encryptedKeyMaterial:Ljava/nio/ByteBuffer;

    .line 543
    return-void
.end method

.method public setExpirationModel(Lcom/amazonaws/services/kms/model/ExpirationModelType;)V
    .locals 1
    .param p1, "expirationModel"    # Lcom/amazonaws/services/kms/model/ExpirationModelType;

    .line 750
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/ExpirationModelType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->expirationModel:Ljava/lang/String;

    .line 751
    return-void
.end method

.method public setExpirationModel(Ljava/lang/String;)V
    .locals 0
    .param p1, "expirationModel"    # Ljava/lang/String;

    .line 694
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->expirationModel:Ljava/lang/String;

    .line 695
    return-void
.end method

.method public setImportToken(Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p1, "importToken"    # Ljava/nio/ByteBuffer;

    .line 469
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->importToken:Ljava/nio/ByteBuffer;

    .line 470
    return-void
.end method

.method public setKeyId(Ljava/lang/String;)V
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 351
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->keyId:Ljava/lang/String;

    .line 352
    return-void
.end method

.method public setValidTo(Ljava/util/Date;)V
    .locals 0
    .param p1, "validTo"    # Ljava/util/Date;

    .line 616
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->validTo:Ljava/util/Date;

    .line 617
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 793
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 794
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 795
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getKeyId()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 796
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "KeyId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 797
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getImportToken()Ljava/nio/ByteBuffer;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 798
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ImportToken: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getImportToken()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 799
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getEncryptedKeyMaterial()Ljava/nio/ByteBuffer;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 800
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "EncryptedKeyMaterial: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getEncryptedKeyMaterial()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 801
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getValidTo()Ljava/util/Date;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 802
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ValidTo: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getValidTo()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 803
    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getExpirationModel()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_4

    .line 804
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ExpirationModel: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->getExpirationModel()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 805
    :cond_4
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 806
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withEncryptedKeyMaterial(Ljava/nio/ByteBuffer;)Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;
    .locals 0
    .param p1, "encryptedKeyMaterial"    # Ljava/nio/ByteBuffer;

    .line 571
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->encryptedKeyMaterial:Ljava/nio/ByteBuffer;

    .line 572
    return-object p0
.end method

.method public withExpirationModel(Lcom/amazonaws/services/kms/model/ExpirationModelType;)Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;
    .locals 1
    .param p1, "expirationModel"    # Lcom/amazonaws/services/kms/model/ExpirationModelType;

    .line 780
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/ExpirationModelType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->expirationModel:Ljava/lang/String;

    .line 781
    return-object p0
.end method

.method public withExpirationModel(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;
    .locals 0
    .param p1, "expirationModel"    # Ljava/lang/String;

    .line 724
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->expirationModel:Ljava/lang/String;

    .line 725
    return-object p0
.end method

.method public withImportToken(Ljava/nio/ByteBuffer;)Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;
    .locals 0
    .param p1, "importToken"    # Ljava/nio/ByteBuffer;

    .line 495
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->importToken:Ljava/nio/ByteBuffer;

    .line 496
    return-object p0
.end method

.method public withKeyId(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 426
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->keyId:Ljava/lang/String;

    .line 427
    return-object p0
.end method

.method public withValidTo(Ljava/util/Date;)Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;
    .locals 0
    .param p1, "validTo"    # Ljava/util/Date;

    .line 643
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ImportKeyMaterialRequest;->validTo:Ljava/util/Date;

    .line 644
    return-object p0
.end method
