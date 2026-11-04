.class public Lcom/amazonaws/services/kms/model/SignRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "SignRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private grantTokens:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private keyId:Ljava/lang/String;

.field private message:Ljava/nio/ByteBuffer;

.field private messageType:Ljava/lang/String;

.field private signingAlgorithm:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 100
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    .line 190
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/SignRequest;->grantTokens:Ljava/util/List;

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 1036
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 1037
    return v0

    .line 1038
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 1039
    return v1

    .line 1041
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/kms/model/SignRequest;

    if-nez v2, :cond_2

    .line 1042
    return v1

    .line 1043
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/kms/model/SignRequest;

    .line 1045
    .local v2, "other":Lcom/amazonaws/services/kms/model/SignRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getKeyId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 1046
    return v1

    .line 1047
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getKeyId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 1048
    return v1

    .line 1049
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignRequest;->getMessage()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getMessage()Ljava/nio/ByteBuffer;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 1050
    return v1

    .line 1051
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignRequest;->getMessage()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-eqz v3, :cond_a

    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignRequest;->getMessage()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getMessage()Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 1052
    return v1

    .line 1053
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignRequest;->getMessageType()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getMessageType()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 1054
    return v1

    .line 1055
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignRequest;->getMessageType()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 1056
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignRequest;->getMessageType()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getMessageType()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 1057
    return v1

    .line 1058
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 1059
    return v1

    .line 1060
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_12

    .line 1061
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 1062
    return v1

    .line 1063
    :cond_12
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignRequest;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_13

    move v3, v0

    goto :goto_8

    :cond_13
    move v3, v1

    :goto_8
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_14

    move v4, v0

    goto :goto_9

    :cond_14
    move v4, v1

    :goto_9
    xor-int/2addr v3, v4

    if-eqz v3, :cond_15

    .line 1064
    return v1

    .line 1065
    :cond_15
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignRequest;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_16

    .line 1066
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/SignRequest;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_16

    .line 1067
    return v1

    .line 1068
    :cond_16
    return v0
.end method

.method public getGrantTokens()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 742
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/SignRequest;->grantTokens:Ljava/util/List;

    return-object v0
.end method

.method public getKeyId()Ljava/lang/String;
    .locals 1

    .line 304
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/SignRequest;->keyId:Ljava/lang/String;

    return-object v0
.end method

.method public getMessage()Ljava/nio/ByteBuffer;
    .locals 1

    .line 535
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/SignRequest;->message:Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method public getMessageType()Ljava/lang/String;
    .locals 1

    .line 617
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/SignRequest;->messageType:Ljava/lang/String;

    return-object v0
.end method

.method public getSigningAlgorithm()Ljava/lang/String;
    .locals 1

    .line 866
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/SignRequest;->signingAlgorithm:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 1020
    const/16 v0, 0x1f

    .line 1021
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 1023
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 1024
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getMessage()Ljava/nio/ByteBuffer;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getMessage()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 1025
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 1026
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getMessageType()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getMessageType()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 1027
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 1028
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v4

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_3
    add-int/2addr v1, v3

    .line 1029
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 1030
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_4

    goto :goto_4

    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_4
    add-int/2addr v2, v4

    .line 1031
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public setGrantTokens(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 767
    .local p1, "grantTokens":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    if-nez p1, :cond_0

    .line 768
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/SignRequest;->grantTokens:Ljava/util/List;

    .line 769
    return-void

    .line 772
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/SignRequest;->grantTokens:Ljava/util/List;

    .line 773
    return-void
.end method

.method public setKeyId(Ljava/lang/String;)V
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 403
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/SignRequest;->keyId:Ljava/lang/String;

    .line 404
    return-void
.end method

.method public setMessage(Ljava/nio/ByteBuffer;)V
    .locals 0
    .param p1, "message"    # Ljava/nio/ByteBuffer;

    .line 562
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/SignRequest;->message:Ljava/nio/ByteBuffer;

    .line 563
    return-void
.end method

.method public setMessageType(Lcom/amazonaws/services/kms/model/MessageType;)V
    .locals 1
    .param p1, "messageType"    # Lcom/amazonaws/services/kms/model/MessageType;

    .line 689
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/MessageType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/SignRequest;->messageType:Ljava/lang/String;

    .line 690
    return-void
.end method

.method public setMessageType(Ljava/lang/String;)V
    .locals 0
    .param p1, "messageType"    # Ljava/lang/String;

    .line 639
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/SignRequest;->messageType:Ljava/lang/String;

    .line 640
    return-void
.end method

.method public setSigningAlgorithm(Lcom/amazonaws/services/kms/model/SigningAlgorithmSpec;)V
    .locals 1
    .param p1, "signingAlgorithm"    # Lcom/amazonaws/services/kms/model/SigningAlgorithmSpec;

    .line 956
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/SigningAlgorithmSpec;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/SignRequest;->signingAlgorithm:Ljava/lang/String;

    .line 957
    return-void
.end method

.method public setSigningAlgorithm(Ljava/lang/String;)V
    .locals 0
    .param p1, "signingAlgorithm"    # Ljava/lang/String;

    .line 894
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/SignRequest;->signingAlgorithm:Ljava/lang/String;

    .line 895
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 1002
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 1003
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1004
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getKeyId()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 1005
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "KeyId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1006
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getMessage()Ljava/nio/ByteBuffer;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 1007
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Message: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getMessage()Ljava/nio/ByteBuffer;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1008
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getMessageType()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 1009
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "MessageType: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getMessageType()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1010
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 1011
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "GrantTokens: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1012
    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_4

    .line 1013
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SigningAlgorithm: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getSigningAlgorithm()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1014
    :cond_4
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1015
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withGrantTokens(Ljava/util/Collection;)Lcom/amazonaws/services/kms/model/SignRequest;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/kms/model/SignRequest;"
        }
    .end annotation

    .line 838
    .local p1, "grantTokens":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/model/SignRequest;->setGrantTokens(Ljava/util/Collection;)V

    .line 839
    return-object p0
.end method

.method public varargs withGrantTokens([Ljava/lang/String;)Lcom/amazonaws/services/kms/model/SignRequest;
    .locals 4
    .param p1, "grantTokens"    # [Ljava/lang/String;

    .line 802
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/SignRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 803
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/SignRequest;->grantTokens:Ljava/util/List;

    .line 805
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    .line 806
    .local v2, "value":Ljava/lang/String;
    iget-object v3, p0, Lcom/amazonaws/services/kms/model/SignRequest;->grantTokens:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 805
    .end local v2    # "value":Ljava/lang/String;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 808
    :cond_1
    return-object p0
.end method

.method public withKeyId(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/SignRequest;
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 507
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/SignRequest;->keyId:Ljava/lang/String;

    .line 508
    return-object p0
.end method

.method public withMessage(Ljava/nio/ByteBuffer;)Lcom/amazonaws/services/kms/model/SignRequest;
    .locals 0
    .param p1, "message"    # Ljava/nio/ByteBuffer;

    .line 594
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/SignRequest;->message:Ljava/nio/ByteBuffer;

    .line 595
    return-object p0
.end method

.method public withMessageType(Lcom/amazonaws/services/kms/model/MessageType;)Lcom/amazonaws/services/kms/model/SignRequest;
    .locals 1
    .param p1, "messageType"    # Lcom/amazonaws/services/kms/model/MessageType;

    .line 716
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/MessageType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/SignRequest;->messageType:Ljava/lang/String;

    .line 717
    return-object p0
.end method

.method public withMessageType(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/SignRequest;
    .locals 0
    .param p1, "messageType"    # Ljava/lang/String;

    .line 666
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/SignRequest;->messageType:Ljava/lang/String;

    .line 667
    return-object p0
.end method

.method public withSigningAlgorithm(Lcom/amazonaws/services/kms/model/SigningAlgorithmSpec;)Lcom/amazonaws/services/kms/model/SignRequest;
    .locals 1
    .param p1, "signingAlgorithm"    # Lcom/amazonaws/services/kms/model/SigningAlgorithmSpec;

    .line 989
    invoke-virtual {p1}, Lcom/amazonaws/services/kms/model/SigningAlgorithmSpec;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/SignRequest;->signingAlgorithm:Ljava/lang/String;

    .line 990
    return-object p0
.end method

.method public withSigningAlgorithm(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/SignRequest;
    .locals 0
    .param p1, "signingAlgorithm"    # Ljava/lang/String;

    .line 927
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/SignRequest;->signingAlgorithm:Ljava/lang/String;

    .line 928
    return-object p0
.end method
