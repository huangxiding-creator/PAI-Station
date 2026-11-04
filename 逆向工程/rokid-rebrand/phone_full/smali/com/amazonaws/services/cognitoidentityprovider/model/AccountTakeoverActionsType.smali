.class public Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;
.super Ljava/lang/Object;
.source "AccountTakeoverActionsType.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private highAction:Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

.field private lowAction:Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

.field private mediumAction:Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;


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

    .line 217
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 218
    return v0

    .line 219
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 220
    return v1

    .line 222
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;

    if-nez v2, :cond_2

    .line 223
    return v1

    .line 224
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;

    .line 226
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getLowAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getLowAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 227
    return v1

    .line 228
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getLowAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 229
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getLowAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getLowAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 230
    return v1

    .line 231
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getMediumAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getMediumAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 232
    return v1

    .line 233
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getMediumAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 234
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getMediumAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getMediumAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 235
    return v1

    .line 236
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getHighAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getHighAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 237
    return v1

    .line 238
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getHighAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 239
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getHighAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getHighAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 240
    return v1

    .line 241
    :cond_e
    return v0
.end method

.method public getHighAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;
    .locals 1

    .line 147
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->highAction:Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    return-object v0
.end method

.method public getLowAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;
    .locals 1

    .line 57
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->lowAction:Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    return-object v0
.end method

.method public getMediumAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;
    .locals 1

    .line 102
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->mediumAction:Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 205
    const/16 v0, 0x1f

    .line 206
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 208
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getLowAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getLowAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 209
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 210
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getMediumAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getMediumAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 211
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getHighAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v3

    if-nez v3, :cond_2

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getHighAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->hashCode()I

    move-result v4

    :goto_2
    add-int/2addr v2, v4

    .line 212
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public setHighAction(Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;)V
    .locals 0
    .param p1, "highAction"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    .line 160
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->highAction:Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    .line 161
    return-void
.end method

.method public setLowAction(Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;)V
    .locals 0
    .param p1, "lowAction"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    .line 70
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->lowAction:Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    .line 71
    return-void
.end method

.method public setMediumAction(Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;)V
    .locals 0
    .param p1, "mediumAction"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    .line 115
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->mediumAction:Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    .line 116
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 191
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 192
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 193
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getLowAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 194
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "LowAction: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getLowAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 195
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getMediumAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 196
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "MediumAction: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getMediumAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 197
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getHighAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 198
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "HighAction: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->getHighAction()Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 199
    :cond_2
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 200
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withHighAction(Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;)Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;
    .locals 0
    .param p1, "highAction"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    .line 178
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->highAction:Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    .line 179
    return-object p0
.end method

.method public withLowAction(Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;)Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;
    .locals 0
    .param p1, "lowAction"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    .line 88
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->lowAction:Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    .line 89
    return-object p0
.end method

.method public withMediumAction(Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;)Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;
    .locals 0
    .param p1, "mediumAction"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    .line 133
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionsType;->mediumAction:Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    .line 134
    return-object p0
.end method
