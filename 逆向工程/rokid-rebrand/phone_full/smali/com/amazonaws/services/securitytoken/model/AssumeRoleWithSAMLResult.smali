.class public Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;
.super Ljava/lang/Object;
.source "AssumeRoleWithSAMLResult.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private assumedRoleUser:Lcom/amazonaws/services/securitytoken/model/AssumedRoleUser;

.field private audience:Ljava/lang/String;

.field private credentials:Lcom/amazonaws/services/securitytoken/model/Credentials;

.field private issuer:Ljava/lang/String;

.field private nameQualifier:Ljava/lang/String;

.field private packedPolicySize:Ljava/lang/Integer;

.field private subject:Ljava/lang/String;

.field private subjectType:Ljava/lang/String;


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

    .line 771
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 772
    return v0

    .line 773
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 774
    return v1

    .line 776
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;

    if-nez v2, :cond_2

    .line 777
    return v1

    .line 778
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;

    .line 780
    .local v2, "other":Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;
    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getCredentials()Lcom/amazonaws/services/securitytoken/model/Credentials;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getCredentials()Lcom/amazonaws/services/securitytoken/model/Credentials;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 781
    return v1

    .line 782
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getCredentials()Lcom/amazonaws/services/securitytoken/model/Credentials;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 783
    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getCredentials()Lcom/amazonaws/services/securitytoken/model/Credentials;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getCredentials()Lcom/amazonaws/services/securitytoken/model/Credentials;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/securitytoken/model/Credentials;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 784
    return v1

    .line 785
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getAssumedRoleUser()Lcom/amazonaws/services/securitytoken/model/AssumedRoleUser;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getAssumedRoleUser()Lcom/amazonaws/services/securitytoken/model/AssumedRoleUser;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 786
    return v1

    .line 787
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getAssumedRoleUser()Lcom/amazonaws/services/securitytoken/model/AssumedRoleUser;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 788
    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getAssumedRoleUser()Lcom/amazonaws/services/securitytoken/model/AssumedRoleUser;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getAssumedRoleUser()Lcom/amazonaws/services/securitytoken/model/AssumedRoleUser;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/securitytoken/model/AssumedRoleUser;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 789
    return v1

    .line 790
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getPackedPolicySize()Ljava/lang/Integer;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getPackedPolicySize()Ljava/lang/Integer;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 791
    return v1

    .line 792
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getPackedPolicySize()Ljava/lang/Integer;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 793
    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getPackedPolicySize()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getPackedPolicySize()Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Integer;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 794
    return v1

    .line 795
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getSubject()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getSubject()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 796
    return v1

    .line 797
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getSubject()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_12

    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getSubject()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getSubject()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 798
    return v1

    .line 799
    :cond_12
    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getSubjectType()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_13

    move v3, v0

    goto :goto_8

    :cond_13
    move v3, v1

    :goto_8
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getSubjectType()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_14

    move v4, v0

    goto :goto_9

    :cond_14
    move v4, v1

    :goto_9
    xor-int/2addr v3, v4

    if-eqz v3, :cond_15

    .line 800
    return v1

    .line 801
    :cond_15
    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getSubjectType()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_16

    .line 802
    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getSubjectType()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getSubjectType()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_16

    .line 803
    return v1

    .line 804
    :cond_16
    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getIssuer()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_17

    move v3, v0

    goto :goto_a

    :cond_17
    move v3, v1

    :goto_a
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getIssuer()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_18

    move v4, v0

    goto :goto_b

    :cond_18
    move v4, v1

    :goto_b
    xor-int/2addr v3, v4

    if-eqz v3, :cond_19

    .line 805
    return v1

    .line 806
    :cond_19
    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getIssuer()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_1a

    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getIssuer()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getIssuer()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1a

    .line 807
    return v1

    .line 808
    :cond_1a
    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getAudience()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1b

    move v3, v0

    goto :goto_c

    :cond_1b
    move v3, v1

    :goto_c
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getAudience()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_1c

    move v4, v0

    goto :goto_d

    :cond_1c
    move v4, v1

    :goto_d
    xor-int/2addr v3, v4

    if-eqz v3, :cond_1d

    .line 809
    return v1

    .line 810
    :cond_1d
    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getAudience()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_1e

    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getAudience()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getAudience()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1e

    .line 811
    return v1

    .line 812
    :cond_1e
    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getNameQualifier()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1f

    move v3, v0

    goto :goto_e

    :cond_1f
    move v3, v1

    :goto_e
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getNameQualifier()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_20

    move v4, v0

    goto :goto_f

    :cond_20
    move v4, v1

    :goto_f
    xor-int/2addr v3, v4

    if-eqz v3, :cond_21

    .line 813
    return v1

    .line 814
    :cond_21
    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getNameQualifier()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_22

    .line 815
    invoke-virtual {v2}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getNameQualifier()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getNameQualifier()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_22

    .line 816
    return v1

    .line 817
    :cond_22
    return v0
.end method

.method public getAssumedRoleUser()Lcom/amazonaws/services/securitytoken/model/AssumedRoleUser;
    .locals 1

    .line 228
    iget-object v0, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->assumedRoleUser:Lcom/amazonaws/services/securitytoken/model/AssumedRoleUser;

    return-object v0
.end method

.method public getAudience()Ljava/lang/String;
    .locals 1

    .line 566
    iget-object v0, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->audience:Ljava/lang/String;

    return-object v0
.end method

.method public getCredentials()Lcom/amazonaws/services/securitytoken/model/Credentials;
    .locals 1

    .line 147
    iget-object v0, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->credentials:Lcom/amazonaws/services/securitytoken/model/Credentials;

    return-object v0
.end method

.method public getIssuer()Ljava/lang/String;
    .locals 1

    .line 516
    iget-object v0, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->issuer:Ljava/lang/String;

    return-object v0
.end method

.method public getNameQualifier()Ljava/lang/String;
    .locals 1

    .line 638
    iget-object v0, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->nameQualifier:Ljava/lang/String;

    return-object v0
.end method

.method public getPackedPolicySize()Ljava/lang/Integer;
    .locals 1

    .line 286
    iget-object v0, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->packedPolicySize:Ljava/lang/Integer;

    return-object v0
.end method

.method public getSubject()Ljava/lang/String;
    .locals 1

    .line 353
    iget-object v0, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->subject:Ljava/lang/String;

    return-object v0
.end method

.method public getSubjectType()Ljava/lang/String;
    .locals 1

    .line 424
    iget-object v0, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->subjectType:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 750
    const/16 v0, 0x1f

    .line 751
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 753
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 754
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getCredentials()Lcom/amazonaws/services/securitytoken/model/Credentials;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getCredentials()Lcom/amazonaws/services/securitytoken/model/Credentials;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/securitytoken/model/Credentials;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 755
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 756
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getAssumedRoleUser()Lcom/amazonaws/services/securitytoken/model/AssumedRoleUser;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getAssumedRoleUser()Lcom/amazonaws/services/securitytoken/model/AssumedRoleUser;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/securitytoken/model/AssumedRoleUser;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 757
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 758
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getPackedPolicySize()Ljava/lang/Integer;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getPackedPolicySize()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Integer;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 759
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getSubject()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v4

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getSubject()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_3
    add-int/2addr v1, v3

    .line 760
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 761
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getSubjectType()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_4

    move v3, v4

    goto :goto_4

    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getSubjectType()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_4
    add-int/2addr v2, v3

    .line 762
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getIssuer()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_5

    move v3, v4

    goto :goto_5

    :cond_5
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getIssuer()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_5
    add-int/2addr v1, v3

    .line 763
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getAudience()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_6

    move v3, v4

    goto :goto_6

    :cond_6
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getAudience()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_6
    add-int/2addr v2, v3

    .line 764
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 765
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getNameQualifier()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    goto :goto_7

    :cond_7
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getNameQualifier()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_7
    add-int/2addr v1, v4

    .line 766
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setAssumedRoleUser(Lcom/amazonaws/services/securitytoken/model/AssumedRoleUser;)V
    .locals 0
    .param p1, "assumedRoleUser"    # Lcom/amazonaws/services/securitytoken/model/AssumedRoleUser;

    .line 243
    iput-object p1, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->assumedRoleUser:Lcom/amazonaws/services/securitytoken/model/AssumedRoleUser;

    .line 244
    return-void
.end method

.method public setAudience(Ljava/lang/String;)V
    .locals 0
    .param p1, "audience"    # Ljava/lang/String;

    .line 582
    iput-object p1, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->audience:Ljava/lang/String;

    .line 583
    return-void
.end method

.method public setCredentials(Lcom/amazonaws/services/securitytoken/model/Credentials;)V
    .locals 0
    .param p1, "credentials"    # Lcom/amazonaws/services/securitytoken/model/Credentials;

    .line 177
    iput-object p1, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->credentials:Lcom/amazonaws/services/securitytoken/model/Credentials;

    .line 178
    return-void
.end method

.method public setIssuer(Ljava/lang/String;)V
    .locals 0
    .param p1, "issuer"    # Ljava/lang/String;

    .line 530
    iput-object p1, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->issuer:Ljava/lang/String;

    .line 531
    return-void
.end method

.method public setNameQualifier(Ljava/lang/String;)V
    .locals 0
    .param p1, "nameQualifier"    # Ljava/lang/String;

    .line 673
    iput-object p1, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->nameQualifier:Ljava/lang/String;

    .line 674
    return-void
.end method

.method public setPackedPolicySize(Ljava/lang/Integer;)V
    .locals 0
    .param p1, "packedPolicySize"    # Ljava/lang/Integer;

    .line 309
    iput-object p1, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->packedPolicySize:Ljava/lang/Integer;

    .line 310
    return-void
.end method

.method public setSubject(Ljava/lang/String;)V
    .locals 0
    .param p1, "subject"    # Ljava/lang/String;

    .line 368
    iput-object p1, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->subject:Ljava/lang/String;

    .line 369
    return-void
.end method

.method public setSubjectType(Ljava/lang/String;)V
    .locals 0
    .param p1, "subjectType"    # Ljava/lang/String;

    .line 460
    iput-object p1, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->subjectType:Ljava/lang/String;

    .line 461
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 726
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 727
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 728
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getCredentials()Lcom/amazonaws/services/securitytoken/model/Credentials;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 729
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Credentials: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getCredentials()Lcom/amazonaws/services/securitytoken/model/Credentials;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 730
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getAssumedRoleUser()Lcom/amazonaws/services/securitytoken/model/AssumedRoleUser;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 731
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AssumedRoleUser: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getAssumedRoleUser()Lcom/amazonaws/services/securitytoken/model/AssumedRoleUser;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 732
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getPackedPolicySize()Ljava/lang/Integer;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 733
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "PackedPolicySize: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getPackedPolicySize()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 734
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getSubject()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 735
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Subject: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getSubject()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 736
    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getSubjectType()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_4

    .line 737
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "SubjectType: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getSubjectType()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 738
    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getIssuer()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_5

    .line 739
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Issuer: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getIssuer()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 740
    :cond_5
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getAudience()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_6

    .line 741
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Audience: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getAudience()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 742
    :cond_6
    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getNameQualifier()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_7

    .line 743
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "NameQualifier: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->getNameQualifier()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 744
    :cond_7
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 745
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withAssumedRoleUser(Lcom/amazonaws/services/securitytoken/model/AssumedRoleUser;)Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;
    .locals 0
    .param p1, "assumedRoleUser"    # Lcom/amazonaws/services/securitytoken/model/AssumedRoleUser;

    .line 263
    iput-object p1, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->assumedRoleUser:Lcom/amazonaws/services/securitytoken/model/AssumedRoleUser;

    .line 264
    return-object p0
.end method

.method public withAudience(Ljava/lang/String;)Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;
    .locals 0
    .param p1, "audience"    # Ljava/lang/String;

    .line 603
    iput-object p1, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->audience:Ljava/lang/String;

    .line 604
    return-object p0
.end method

.method public withCredentials(Lcom/amazonaws/services/securitytoken/model/Credentials;)Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;
    .locals 0
    .param p1, "credentials"    # Lcom/amazonaws/services/securitytoken/model/Credentials;

    .line 212
    iput-object p1, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->credentials:Lcom/amazonaws/services/securitytoken/model/Credentials;

    .line 213
    return-object p0
.end method

.method public withIssuer(Ljava/lang/String;)Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;
    .locals 0
    .param p1, "issuer"    # Ljava/lang/String;

    .line 549
    iput-object p1, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->issuer:Ljava/lang/String;

    .line 550
    return-object p0
.end method

.method public withNameQualifier(Ljava/lang/String;)Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;
    .locals 0
    .param p1, "nameQualifier"    # Ljava/lang/String;

    .line 713
    iput-object p1, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->nameQualifier:Ljava/lang/String;

    .line 714
    return-object p0
.end method

.method public withPackedPolicySize(Ljava/lang/Integer;)Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;
    .locals 0
    .param p1, "packedPolicySize"    # Ljava/lang/Integer;

    .line 337
    iput-object p1, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->packedPolicySize:Ljava/lang/Integer;

    .line 338
    return-object p0
.end method

.method public withSubject(Ljava/lang/String;)Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;
    .locals 0
    .param p1, "subject"    # Ljava/lang/String;

    .line 388
    iput-object p1, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->subject:Ljava/lang/String;

    .line 389
    return-object p0
.end method

.method public withSubjectType(Ljava/lang/String;)Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;
    .locals 0
    .param p1, "subjectType"    # Ljava/lang/String;

    .line 501
    iput-object p1, p0, Lcom/amazonaws/services/securitytoken/model/AssumeRoleWithSAMLResult;->subjectType:Ljava/lang/String;

    .line 502
    return-object p0
.end method
