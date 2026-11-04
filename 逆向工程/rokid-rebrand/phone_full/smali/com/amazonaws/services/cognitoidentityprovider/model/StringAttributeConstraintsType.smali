.class public Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;
.super Ljava/lang/Object;
.source "StringAttributeConstraintsType.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private maxLength:Ljava/lang/String;

.field private minLength:Ljava/lang/String;


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

    .line 161
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 162
    return v0

    .line 163
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 164
    return v1

    .line 166
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;

    if-nez v2, :cond_2

    .line 167
    return v1

    .line 168
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;

    .line 170
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->getMinLength()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->getMinLength()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 171
    return v1

    .line 172
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->getMinLength()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 173
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->getMinLength()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->getMinLength()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 174
    return v1

    .line 175
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->getMaxLength()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->getMaxLength()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 176
    return v1

    .line 177
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->getMaxLength()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 178
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->getMaxLength()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->getMaxLength()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 179
    return v1

    .line 180
    :cond_a
    return v0
.end method

.method public getMaxLength()Ljava/lang/String;
    .locals 1

    .line 95
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->maxLength:Ljava/lang/String;

    return-object v0
.end method

.method public getMinLength()Ljava/lang/String;
    .locals 1

    .line 50
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->minLength:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 151
    const/16 v0, 0x1f

    .line 152
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 154
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->getMinLength()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->getMinLength()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 155
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->getMaxLength()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->getMaxLength()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_1
    add-int/2addr v1, v4

    .line 156
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setMaxLength(Ljava/lang/String;)V
    .locals 0
    .param p1, "maxLength"    # Ljava/lang/String;

    .line 108
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->maxLength:Ljava/lang/String;

    .line 109
    return-void
.end method

.method public setMinLength(Ljava/lang/String;)V
    .locals 0
    .param p1, "minLength"    # Ljava/lang/String;

    .line 63
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->minLength:Ljava/lang/String;

    .line 64
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 139
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 140
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 141
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->getMinLength()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 142
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "MinLength: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->getMinLength()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 143
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->getMaxLength()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 144
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "MaxLength: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->getMaxLength()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 145
    :cond_1
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 146
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withMaxLength(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;
    .locals 0
    .param p1, "maxLength"    # Ljava/lang/String;

    .line 126
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->maxLength:Ljava/lang/String;

    .line 127
    return-object p0
.end method

.method public withMinLength(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;
    .locals 0
    .param p1, "minLength"    # Ljava/lang/String;

    .line 81
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/StringAttributeConstraintsType;->minLength:Ljava/lang/String;

    .line 82
    return-object p0
.end method
