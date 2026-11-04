.class public Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;
.super Ljava/lang/Object;
.source "ProviderUserIdentifierType.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private providerAttributeName:Ljava/lang/String;

.field private providerAttributeValue:Ljava/lang/String;

.field private providerName:Ljava/lang/String;


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

    .line 259
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 260
    return v0

    .line 261
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 262
    return v1

    .line 264
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    if-nez v2, :cond_2

    .line 265
    return v1

    .line 266
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    .line 268
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderName()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 269
    return v1

    .line 270
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderName()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 271
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 272
    return v1

    .line 273
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderAttributeName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderAttributeName()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 274
    return v1

    .line 275
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderAttributeName()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 276
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderAttributeName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderAttributeName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 277
    return v1

    .line 278
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderAttributeValue()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderAttributeValue()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 279
    return v1

    .line 280
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderAttributeValue()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 281
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderAttributeValue()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderAttributeValue()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 282
    return v1

    .line 283
    :cond_e
    return v0
.end method

.method public getProviderAttributeName()Ljava/lang/String;
    .locals 1

    .line 129
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->providerAttributeName:Ljava/lang/String;

    return-object v0
.end method

.method public getProviderAttributeValue()Ljava/lang/String;
    .locals 1

    .line 180
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->providerAttributeValue:Ljava/lang/String;

    return-object v0
.end method

.method public getProviderName()Ljava/lang/String;
    .locals 1

    .line 70
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->providerName:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 242
    const/16 v0, 0x1f

    .line 243
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 245
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 246
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderName()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 247
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 249
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderAttributeName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderAttributeName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 250
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 252
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderAttributeValue()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderAttributeValue()Ljava/lang/String;

    move-result-object v3

    .line 253
    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_2
    add-int/2addr v2, v4

    .line 254
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public setProviderAttributeName(Ljava/lang/String;)V
    .locals 0
    .param p1, "providerAttributeName"    # Ljava/lang/String;

    .line 144
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->providerAttributeName:Ljava/lang/String;

    .line 145
    return-void
.end method

.method public setProviderAttributeValue(Ljava/lang/String;)V
    .locals 0
    .param p1, "providerAttributeValue"    # Ljava/lang/String;

    .line 195
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->providerAttributeValue:Ljava/lang/String;

    .line 196
    return-void
.end method

.method public setProviderName(Ljava/lang/String;)V
    .locals 0
    .param p1, "providerName"    # Ljava/lang/String;

    .line 89
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->providerName:Ljava/lang/String;

    .line 90
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 228
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 229
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 230
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderName()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 231
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ProviderName: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 232
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderAttributeName()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 233
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ProviderAttributeName: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderAttributeName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 234
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderAttributeValue()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 235
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ProviderAttributeValue: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->getProviderAttributeValue()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 236
    :cond_2
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 237
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withProviderAttributeName(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;
    .locals 0
    .param p1, "providerAttributeName"    # Ljava/lang/String;

    .line 164
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->providerAttributeName:Ljava/lang/String;

    .line 165
    return-object p0
.end method

.method public withProviderAttributeValue(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;
    .locals 0
    .param p1, "providerAttributeValue"    # Ljava/lang/String;

    .line 215
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->providerAttributeValue:Ljava/lang/String;

    .line 216
    return-object p0
.end method

.method public withProviderName(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;
    .locals 0
    .param p1, "providerName"    # Ljava/lang/String;

    .line 113
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->providerName:Ljava/lang/String;

    .line 114
    return-object p0
.end method
