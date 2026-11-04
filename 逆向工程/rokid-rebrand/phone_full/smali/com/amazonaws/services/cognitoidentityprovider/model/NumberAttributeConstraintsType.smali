.class public Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;
.super Ljava/lang/Object;
.source "NumberAttributeConstraintsType.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private maxValue:Ljava/lang/String;

.field private minValue:Ljava/lang/String;


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

    .line 168
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 169
    return v0

    .line 170
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 171
    return v1

    .line 173
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;

    if-nez v2, :cond_2

    .line 174
    return v1

    .line 175
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;

    .line 177
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->getMinValue()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->getMinValue()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 178
    return v1

    .line 179
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->getMinValue()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->getMinValue()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->getMinValue()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 180
    return v1

    .line 181
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->getMaxValue()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->getMaxValue()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 182
    return v1

    .line 183
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->getMaxValue()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->getMaxValue()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->getMaxValue()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 184
    return v1

    .line 185
    :cond_a
    return v0
.end method

.method public getMaxValue()Ljava/lang/String;
    .locals 1

    .line 100
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->maxValue:Ljava/lang/String;

    return-object v0
.end method

.method public getMinValue()Ljava/lang/String;
    .locals 1

    .line 52
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->minValue:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 158
    const/16 v0, 0x1f

    .line 159
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 161
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->getMinValue()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->getMinValue()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 162
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->getMaxValue()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->getMaxValue()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_1
    add-int/2addr v1, v4

    .line 163
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setMaxValue(Ljava/lang/String;)V
    .locals 0
    .param p1, "maxValue"    # Ljava/lang/String;

    .line 114
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->maxValue:Ljava/lang/String;

    .line 115
    return-void
.end method

.method public setMinValue(Ljava/lang/String;)V
    .locals 0
    .param p1, "minValue"    # Ljava/lang/String;

    .line 66
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->minValue:Ljava/lang/String;

    .line 67
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 146
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 147
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 148
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->getMinValue()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 149
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "MinValue: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->getMinValue()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 150
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->getMaxValue()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 151
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "MaxValue: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->getMaxValue()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 152
    :cond_1
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 153
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withMaxValue(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;
    .locals 0
    .param p1, "maxValue"    # Ljava/lang/String;

    .line 133
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->maxValue:Ljava/lang/String;

    .line 134
    return-object p0
.end method

.method public withMinValue(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;
    .locals 0
    .param p1, "minValue"    # Ljava/lang/String;

    .line 85
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/NumberAttributeConstraintsType;->minValue:Ljava/lang/String;

    .line 86
    return-object p0
.end method
