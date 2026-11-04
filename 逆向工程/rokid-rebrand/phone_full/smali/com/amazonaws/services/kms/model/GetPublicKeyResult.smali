.class public Lcom/amazonaws/services/kms/model/GetPublicKeyResult;
.super Ljava/lang/Object;
.source "GetPublicKeyResult.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private customerMasterKeySpec:Ljava/lang/String;

.field private encryptionAlgorithms:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private keyId:Ljava/lang/String;

.field private keyUsage:Ljava/lang/String;

.field private publicKey:Ljava/nio/ByteBuffer;

.field private signingAlgorithms:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 93
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->encryptionAlgorithms:Ljava/util/List;

    .line 104
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->signingAlgorithms:Ljava/util/List;

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 847
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 848
    return v0

    .line 849
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 850
    return v1

    .line 852
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;

    if-nez v2, :cond_2

    .line 853
    return v1

    .line 854
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;

    .line 856
    .local v2, "other":Lcom/amazonaws/services/kms/model/GetPublicKeyResult;
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getKeyId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 857
    return v1

    .line 858
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getKeyId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 859
    return v1

    .line 860
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 861
    return v1

    .line 862
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 863
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 864
    return v1

    .line 865
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getCustomerMasterKeySpec()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getCustomerMasterKeySpec()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 866
    return v1

    .line 867
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getCustomerMasterKeySpec()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 868
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getCustomerMasterKeySpec()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getCustomerMasterKeySpec()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 869
    return v1

    .line 870
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getKeyUsage()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getKeyUsage()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 871
    return v1

    .line 872
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getKeyUsage()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_12

    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getKeyUsage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getKeyUsage()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 873
    return v1

    .line 874
    :cond_12
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getEncryptionAlgorithms()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_13

    move v3, v0

    goto :goto_8

    :cond_13
    move v3, v1

    :goto_8
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getEncryptionAlgorithms()Ljava/util/List;

    move-result-object v4

    if-nez v4, :cond_14

    move v4, v0

    goto :goto_9

    :cond_14
    move v4, v1

    :goto_9
    xor-int/2addr v3, v4

    if-eqz v3, :cond_15

    .line 875
    return v1

    .line 876
    :cond_15
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getEncryptionAlgorithms()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_16

    .line 877
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getEncryptionAlgorithms()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getEncryptionAlgorithms()Ljava/util/List;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_16

    .line 878
    return v1

    .line 879
    :cond_16
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getSigningAlgorithms()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_17

    move v3, v0

    goto :goto_a

    :cond_17
    move v3, v1

    :goto_a
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getSigningAlgorithms()Ljava/util/List;

    move-result-object v4

    if-nez v4, :cond_18

    move v4, v0

    goto :goto_b

    :cond_18
    move v4, v1

    :goto_b
    xor-int/2addr v3, v4

    if-eqz v3, :cond_19

    .line 880
    return v1

    .line 881
    :cond_19
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getSigningAlgorithms()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_1a

    .line 882
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getSigningAlgorithms()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getSigningAlgorithms()Ljava/util/List;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1a

    .line 883
    return v1

    .line 884
    :cond_1a
    return v0
.end method

.method public getCustomerMasterKeySpec()Ljava/lang/String;
    .locals 1

    .line 295
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->customerMasterKeySpec:Ljava/lang/String;

    return-object v0
.end method

.method public getEncryptionAlgorithms()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 568
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->encryptionAlgorithms:Ljava/util/List;

    return-object v0
.end method

.method public getKeyId()Ljava/lang/String;
    .locals 1

    .line 125
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->keyId:Ljava/lang/String;

    return-object v0
.end method

.method public getKeyUsage()Ljava/lang/String;
    .locals 1

    .line 408
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->keyUsage:Ljava/lang/String;

    return-object v0
.end method

.method public getPublicKey()Ljava/nio/ByteBuffer;
    .locals 1

    .line 207
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->publicKey:Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method public getSigningAlgorithms()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 709
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->signingAlgorithms:Ljava/util/List;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 829
    const/16 v0, 0x1f

    .line 830
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 832
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 833
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 834
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 836
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getCustomerMasterKeySpec()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getCustomerMasterKeySpec()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 837
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getKeyUsage()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v4

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getKeyUsage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_3
    add-int/2addr v1, v3

    .line 838
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 839
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getEncryptionAlgorithms()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_4

    move v3, v4

    goto :goto_4

    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getEncryptionAlgorithms()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_4
    add-int/2addr v2, v3

    .line 840
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 841
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getSigningAlgorithms()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_5

    goto :goto_5

    :cond_5
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getSigningAlgorithms()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v4

    :goto_5
    add-int/2addr v1, v4

    .line 842
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setCustomerMasterKeySpec(Lcom/amazonaws/services/kms/model/CustomerMasterKeySpec;)V
    .locals 1
    .param p1, "customerMasterKeySpec"    # Lcom/amazonaws/services/kms/model/CustomerMasterKeySpec;

    .line 355
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/CustomerMasterKeySpec;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->customerMasterKeySpec:Ljava/lang/String;

    .line 356
    return-void
.end method

.method public setCustomerMasterKeySpec(Ljava/lang/String;)V
    .locals 0
    .param p1, "customerMasterKeySpec"    # Ljava/lang/String;

    .line 313
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->customerMasterKeySpec:Ljava/lang/String;

    .line 314
    return-void
.end method

.method public setEncryptionAlgorithms(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 600
    .local p1, "encryptionAlgorithms":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    if-nez p1, :cond_0

    .line 601
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->encryptionAlgorithms:Ljava/util/List;

    .line 602
    return-void

    .line 605
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->encryptionAlgorithms:Ljava/util/List;

    .line 606
    return-void
.end method

.method public setKeyId(Ljava/lang/String;)V
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 147
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->keyId:Ljava/lang/String;

    .line 148
    return-void
.end method

.method public setKeyUsage(Lcom/amazonaws/services/kms/model/KeyUsageType;)V
    .locals 1
    .param p1, "keyUsage"    # Lcom/amazonaws/services/kms/model/KeyUsageType;

    .line 501
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/KeyUsageType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->keyUsage:Ljava/lang/String;

    .line 502
    return-void
.end method

.method public setKeyUsage(Ljava/lang/String;)V
    .locals 0
    .param p1, "keyUsage"    # Ljava/lang/String;

    .line 437
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->keyUsage:Ljava/lang/String;

    .line 438
    return-void
.end method

.method public setPublicKey(Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p1, "publicKey"    # Ljava/nio/ByteBuffer;

    .line 239
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->publicKey:Ljava/nio/ByteBuffer;

    .line 240
    return-void
.end method

.method public setSigningAlgorithms(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 731
    .local p1, "signingAlgorithms":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    if-nez p1, :cond_0

    .line 732
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->signingAlgorithms:Ljava/util/List;

    .line 733
    return-void

    .line 736
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->signingAlgorithms:Ljava/util/List;

    .line 737
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 809
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 810
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 811
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getKeyId()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 812
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "KeyId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 813
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 814
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "PublicKey: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getPublicKey()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 815
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getCustomerMasterKeySpec()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 816
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "CustomerMasterKeySpec: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getCustomerMasterKeySpec()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 817
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getKeyUsage()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 818
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "KeyUsage: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getKeyUsage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 819
    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getEncryptionAlgorithms()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_4

    .line 820
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "EncryptionAlgorithms: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getEncryptionAlgorithms()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 821
    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getSigningAlgorithms()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_5

    .line 822
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SigningAlgorithms: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getSigningAlgorithms()Ljava/util/List;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 823
    :cond_5
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 824
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withCustomerMasterKeySpec(Lcom/amazonaws/services/kms/model/CustomerMasterKeySpec;)Lcom/amazonaws/services/kms/model/GetPublicKeyResult;
    .locals 1
    .param p1, "customerMasterKeySpec"    # Lcom/amazonaws/services/kms/model/CustomerMasterKeySpec;

    .line 378
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/CustomerMasterKeySpec;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->customerMasterKeySpec:Ljava/lang/String;

    .line 379
    return-object p0
.end method

.method public withCustomerMasterKeySpec(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/GetPublicKeyResult;
    .locals 0
    .param p1, "customerMasterKeySpec"    # Ljava/lang/String;

    .line 336
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->customerMasterKeySpec:Ljava/lang/String;

    .line 337
    return-object p0
.end method

.method public withEncryptionAlgorithms(Ljava/util/Collection;)Lcom/amazonaws/services/kms/model/GetPublicKeyResult;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/kms/model/GetPublicKeyResult;"
        }
    .end annotation

    .line 686
    .local p1, "encryptionAlgorithms":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->setEncryptionAlgorithms(Ljava/util/Collection;)V

    .line 687
    return-object p0
.end method

.method public varargs withEncryptionAlgorithms([Ljava/lang/String;)Lcom/amazonaws/services/kms/model/GetPublicKeyResult;
    .locals 4
    .param p1, "encryptionAlgorithms"    # [Ljava/lang/String;

    .line 642
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getEncryptionAlgorithms()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 643
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->encryptionAlgorithms:Ljava/util/List;

    .line 645
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    .line 646
    .local v2, "value":Ljava/lang/String;
    iget-object v3, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->encryptionAlgorithms:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 645
    .end local v2    # "value":Ljava/lang/String;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 648
    :cond_1
    return-object p0
.end method

.method public withKeyId(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/GetPublicKeyResult;
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 174
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->keyId:Ljava/lang/String;

    .line 175
    return-object p0
.end method

.method public withKeyUsage(Lcom/amazonaws/services/kms/model/KeyUsageType;)Lcom/amazonaws/services/kms/model/GetPublicKeyResult;
    .locals 1
    .param p1, "keyUsage"    # Lcom/amazonaws/services/kms/model/KeyUsageType;

    .line 535
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/KeyUsageType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->keyUsage:Ljava/lang/String;

    .line 536
    return-object p0
.end method

.method public withKeyUsage(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/GetPublicKeyResult;
    .locals 0
    .param p1, "keyUsage"    # Ljava/lang/String;

    .line 471
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->keyUsage:Ljava/lang/String;

    .line 472
    return-object p0
.end method

.method public withPublicKey(Ljava/nio/ByteBuffer;)Lcom/amazonaws/services/kms/model/GetPublicKeyResult;
    .locals 0
    .param p1, "publicKey"    # Ljava/nio/ByteBuffer;

    .line 276
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->publicKey:Ljava/nio/ByteBuffer;

    .line 277
    return-object p0
.end method

.method public withSigningAlgorithms(Ljava/util/Collection;)Lcom/amazonaws/services/kms/model/GetPublicKeyResult;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/kms/model/GetPublicKeyResult;"
        }
    .end annotation

    .line 796
    .local p1, "signingAlgorithms":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->setSigningAlgorithms(Ljava/util/Collection;)V

    .line 797
    return-object p0
.end method

.method public varargs withSigningAlgorithms([Ljava/lang/String;)Lcom/amazonaws/services/kms/model/GetPublicKeyResult;
    .locals 4
    .param p1, "signingAlgorithms"    # [Ljava/lang/String;

    .line 763
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->getSigningAlgorithms()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 764
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->signingAlgorithms:Ljava/util/List;

    .line 766
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    .line 767
    .local v2, "value":Ljava/lang/String;
    iget-object v3, p0, Lcom/amazonaws/services/kms/model/GetPublicKeyResult;->signingAlgorithms:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 766
    .end local v2    # "value":Ljava/lang/String;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 769
    :cond_1
    return-object p0
.end method
