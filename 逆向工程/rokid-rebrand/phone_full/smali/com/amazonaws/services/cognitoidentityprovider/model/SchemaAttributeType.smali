.class public Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;
.super Ljava/lang/Object;
.source "SchemaAttributeType.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private attributeDataType:Ljava/lang/String;

.field private developerOnlyAttribute:Ljava/lang/Boolean;

.field private mutable:Ljava/lang/Boolean;

.field private name:Ljava/lang/String;

.field private numberAttributeConstraints:Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;

.field private required:Ljava/lang/Boolean;

.field private stringAttributeConstraints:Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;


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

    .line 800
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 801
    return v0

    .line 802
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 803
    return v1

    .line 805
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;

    if-nez v2, :cond_2

    .line 806
    return v1

    .line 807
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;

    .line 809
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getName()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 810
    return v1

    .line 811
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getName()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 812
    return v1

    .line 813
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getAttributeDataType()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getAttributeDataType()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 814
    return v1

    .line 815
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getAttributeDataType()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 816
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getAttributeDataType()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getAttributeDataType()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 817
    return v1

    .line 818
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getDeveloperOnlyAttribute()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getDeveloperOnlyAttribute()Ljava/lang/Boolean;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 819
    return v1

    .line 820
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getDeveloperOnlyAttribute()Ljava/lang/Boolean;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 821
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getDeveloperOnlyAttribute()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getDeveloperOnlyAttribute()Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 822
    return v1

    .line 823
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getMutable()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getMutable()Ljava/lang/Boolean;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 824
    return v1

    .line 825
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getMutable()Ljava/lang/Boolean;

    move-result-object v3

    if-eqz v3, :cond_12

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getMutable()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getMutable()Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 826
    return v1

    .line 827
    :cond_12
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getRequired()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_13

    move v3, v0

    goto :goto_8

    :cond_13
    move v3, v1

    :goto_8
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getRequired()Ljava/lang/Boolean;

    move-result-object v4

    if-nez v4, :cond_14

    move v4, v0

    goto :goto_9

    :cond_14
    move v4, v1

    :goto_9
    xor-int/2addr v3, v4

    if-eqz v3, :cond_15

    .line 828
    return v1

    .line 829
    :cond_15
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getRequired()Ljava/lang/Boolean;

    move-result-object v3

    if-eqz v3, :cond_16

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getRequired()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getRequired()Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_16

    .line 830
    return v1

    .line 831
    :cond_16
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getNumberAttributeConstraints()Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;

    move-result-object v3

    if-nez v3, :cond_17

    move v3, v0

    goto :goto_a

    :cond_17
    move v3, v1

    .line 832
    :goto_a
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getNumberAttributeConstraints()Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;

    move-result-object v4

    if-nez v4, :cond_18

    move v4, v0

    goto :goto_b

    :cond_18
    move v4, v1

    :goto_b
    xor-int/2addr v3, v4

    if-eqz v3, :cond_19

    .line 833
    return v1

    .line 834
    :cond_19
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getNumberAttributeConstraints()Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;

    move-result-object v3

    if-eqz v3, :cond_1a

    .line 835
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getNumberAttributeConstraints()Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;

    move-result-object v3

    .line 836
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getNumberAttributeConstraints()Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;

    move-result-object v4

    .line 835
    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1a

    .line 837
    return v1

    .line 838
    :cond_1a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getStringAttributeConstraints()Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;

    move-result-object v3

    if-nez v3, :cond_1b

    move v3, v0

    goto :goto_c

    :cond_1b
    move v3, v1

    .line 839
    :goto_c
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getStringAttributeConstraints()Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;

    move-result-object v4

    if-nez v4, :cond_1c

    move v4, v0

    goto :goto_d

    :cond_1c
    move v4, v1

    :goto_d
    xor-int/2addr v3, v4

    if-eqz v3, :cond_1d

    .line 840
    return v1

    .line 841
    :cond_1d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getStringAttributeConstraints()Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;

    move-result-object v3

    if-eqz v3, :cond_1e

    .line 842
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getStringAttributeConstraints()Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;

    move-result-object v3

    .line 843
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getStringAttributeConstraints()Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;

    move-result-object v4

    .line 842
    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1e

    .line 844
    return v1

    .line 845
    :cond_1e
    return v0
.end method

.method public getAttributeDataType()Ljava/lang/String;
    .locals 1

    .line 179
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->attributeDataType:Ljava/lang/String;

    return-object v0
.end method

.method public getDeveloperOnlyAttribute()Ljava/lang/Boolean;
    .locals 1

    .line 341
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->developerOnlyAttribute:Ljava/lang/Boolean;

    return-object v0
.end method

.method public getMutable()Ljava/lang/Boolean;
    .locals 1

    .line 497
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->mutable:Ljava/lang/Boolean;

    return-object v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    .line 122
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->name:Ljava/lang/String;

    return-object v0
.end method

.method public getNumberAttributeConstraints()Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;
    .locals 1

    .line 660
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->numberAttributeConstraints:Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;

    return-object v0
.end method

.method public getRequired()Ljava/lang/Boolean;
    .locals 1

    .line 607
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->required:Ljava/lang/Boolean;

    return-object v0
.end method

.method public getStringAttributeConstraints()Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;
    .locals 1

    .line 707
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->stringAttributeConstraints:Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 775
    const/16 v0, 0x1f

    .line 776
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 778
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getName()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 779
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 780
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getAttributeDataType()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getAttributeDataType()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 781
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 783
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getDeveloperOnlyAttribute()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getDeveloperOnlyAttribute()Ljava/lang/Boolean;

    move-result-object v3

    .line 784
    invoke-virtual {v3}, Ljava/lang/Boolean;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 785
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getMutable()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v4

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getMutable()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Boolean;->hashCode()I

    move-result v3

    :goto_3
    add-int/2addr v1, v3

    .line 786
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getRequired()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_4

    move v3, v4

    goto :goto_4

    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getRequired()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Boolean;->hashCode()I

    move-result v3

    :goto_4
    add-int/2addr v2, v3

    .line 787
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 789
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getNumberAttributeConstraints()Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;

    move-result-object v3

    if-nez v3, :cond_5

    move v3, v4

    goto :goto_5

    :cond_5
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getNumberAttributeConstraints()Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;

    move-result-object v3

    .line 790
    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->hashCode()I

    move-result v3

    :goto_5
    add-int/2addr v1, v3

    .line 791
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 793
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getStringAttributeConstraints()Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;

    move-result-object v3

    if-nez v3, :cond_6

    goto :goto_6

    :cond_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getStringAttributeConstraints()Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;

    move-result-object v3

    .line 794
    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->hashCode()I

    move-result v4

    :goto_6
    add-int/2addr v2, v4

    .line 795
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public isDeveloperOnlyAttribute()Ljava/lang/Boolean;
    .locals 1

    .line 300
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->developerOnlyAttribute:Ljava/lang/Boolean;

    return-object v0
.end method

.method public isMutable()Ljava/lang/Boolean;
    .locals 1

    .line 463
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->mutable:Ljava/lang/Boolean;

    return-object v0
.end method

.method public isRequired()Ljava/lang/Boolean;
    .locals 1

    .line 590
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->required:Ljava/lang/Boolean;

    return-object v0
.end method

.method public setAttributeDataType(Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeDataType;)V
    .locals 1
    .param p1, "attributeDataType"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeDataType;

    .line 236
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeDataType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->attributeDataType:Ljava/lang/String;

    .line 237
    return-void
.end method

.method public setAttributeDataType(Ljava/lang/String;)V
    .locals 0
    .param p1, "attributeDataType"    # Ljava/lang/String;

    .line 196
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->attributeDataType:Ljava/lang/String;

    .line 197
    return-void
.end method

.method public setDeveloperOnlyAttribute(Ljava/lang/Boolean;)V
    .locals 0
    .param p1, "developerOnlyAttribute"    # Ljava/lang/Boolean;

    .line 382
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->developerOnlyAttribute:Ljava/lang/Boolean;

    .line 383
    return-void
.end method

.method public setMutable(Ljava/lang/Boolean;)V
    .locals 0
    .param p1, "mutable"    # Ljava/lang/Boolean;

    .line 532
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->mutable:Ljava/lang/Boolean;

    .line 533
    return-void
.end method

.method public setName(Ljava/lang/String;)V
    .locals 0
    .param p1, "name"    # Ljava/lang/String;

    .line 139
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->name:Ljava/lang/String;

    .line 140
    return-void
.end method

.method public setNumberAttributeConstraints(Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;)V
    .locals 0
    .param p1, "numberAttributeConstraints"    # Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;

    .line 674
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->numberAttributeConstraints:Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;

    .line 675
    return-void
.end method

.method public setRequired(Ljava/lang/Boolean;)V
    .locals 0
    .param p1, "required"    # Ljava/lang/Boolean;

    .line 624
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->required:Ljava/lang/Boolean;

    .line 625
    return-void
.end method

.method public setStringAttributeConstraints(Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;)V
    .locals 0
    .param p1, "stringAttributeConstraints"    # Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;

    .line 721
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->stringAttributeConstraints:Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;

    .line 722
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 753
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 754
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 755
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getName()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 756
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Name: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 757
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getAttributeDataType()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 758
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AttributeDataType: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getAttributeDataType()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 759
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getDeveloperOnlyAttribute()Ljava/lang/Boolean;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 760
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DeveloperOnlyAttribute: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getDeveloperOnlyAttribute()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 761
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getMutable()Ljava/lang/Boolean;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 762
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Mutable: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getMutable()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 763
    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getRequired()Ljava/lang/Boolean;

    move-result-object v1

    if-eqz v1, :cond_4

    .line 764
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Required: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getRequired()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 765
    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getNumberAttributeConstraints()Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;

    move-result-object v1

    if-eqz v1, :cond_5

    .line 766
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "NumberAttributeConstraints: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getNumberAttributeConstraints()Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 767
    :cond_5
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getStringAttributeConstraints()Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;

    move-result-object v1

    if-eqz v1, :cond_6

    .line 768
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "StringAttributeConstraints: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->getStringAttributeConstraints()Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 769
    :cond_6
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 770
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withAttributeDataType(Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeDataType;)Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;
    .locals 1
    .param p1, "attributeDataType"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeDataType;

    .line 258
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeDataType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->attributeDataType:Ljava/lang/String;

    .line 259
    return-object p0
.end method

.method public withAttributeDataType(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;
    .locals 0
    .param p1, "attributeDataType"    # Ljava/lang/String;

    .line 218
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->attributeDataType:Ljava/lang/String;

    .line 219
    return-object p0
.end method

.method public withDeveloperOnlyAttribute(Ljava/lang/Boolean;)Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;
    .locals 0
    .param p1, "developerOnlyAttribute"    # Ljava/lang/Boolean;

    .line 428
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->developerOnlyAttribute:Ljava/lang/Boolean;

    .line 429
    return-object p0
.end method

.method public withMutable(Ljava/lang/Boolean;)Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;
    .locals 0
    .param p1, "mutable"    # Ljava/lang/Boolean;

    .line 572
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->mutable:Ljava/lang/Boolean;

    .line 573
    return-object p0
.end method

.method public withName(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;
    .locals 0
    .param p1, "name"    # Ljava/lang/String;

    .line 161
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->name:Ljava/lang/String;

    .line 162
    return-object p0
.end method

.method public withNumberAttributeConstraints(Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;)Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;
    .locals 0
    .param p1, "numberAttributeConstraints"    # Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;

    .line 693
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->numberAttributeConstraints:Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;

    .line 694
    return-object p0
.end method

.method public withRequired(Ljava/lang/Boolean;)Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;
    .locals 0
    .param p1, "required"    # Ljava/lang/Boolean;

    .line 646
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->required:Ljava/lang/Boolean;

    .line 647
    return-object p0
.end method

.method public withStringAttributeConstraints(Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;)Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;
    .locals 0
    .param p1, "stringAttributeConstraints"    # Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;

    .line 740
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SchemaAttributeType;->stringAttributeConstraints:Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;

    .line 741
    return-object p0
.end method
