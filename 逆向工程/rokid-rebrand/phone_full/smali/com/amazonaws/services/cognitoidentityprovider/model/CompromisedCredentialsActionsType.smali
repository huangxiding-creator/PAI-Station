.class public Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsActionsType;
.super Ljava/lang/Object;
.source "CompromisedCredentialsActionsType.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private eventAction:Ljava/lang/String;


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

    .line 163
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 164
    return v0

    .line 165
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 166
    return v1

    .line 168
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsActionsType;

    if-nez v2, :cond_2

    .line 169
    return v1

    .line 170
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsActionsType;

    .line 172
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsActionsType;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsActionsType;->getEventAction()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsActionsType;->getEventAction()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 173
    return v1

    .line 174
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsActionsType;->getEventAction()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 175
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsActionsType;->getEventAction()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsActionsType;->getEventAction()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 176
    return v1

    .line 177
    :cond_6
    return v0
.end method

.method public getEventAction()Ljava/lang/String;
    .locals 1

    .line 50
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsActionsType;->eventAction:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 4

    .line 153
    const/16 v0, 0x1f

    .line 154
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 156
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 157
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsActionsType;->getEventAction()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_0

    const/4 v3, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsActionsType;->getEventAction()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 158
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    return v2
.end method

.method public setEventAction(Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsEventActionType;)V
    .locals 1
    .param p1, "eventAction"    # Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsEventActionType;

    .line 107
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsEventActionType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsActionsType;->eventAction:Ljava/lang/String;

    .line 108
    return-void
.end method

.method public setEventAction(Ljava/lang/String;)V
    .locals 0
    .param p1, "eventAction"    # Ljava/lang/String;

    .line 67
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsActionsType;->eventAction:Ljava/lang/String;

    .line 68
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 143
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 144
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 145
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsActionsType;->getEventAction()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 146
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "EventAction: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsActionsType;->getEventAction()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 147
    :cond_0
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 148
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withEventAction(Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsEventActionType;)Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsActionsType;
    .locals 1
    .param p1, "eventAction"    # Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsEventActionType;

    .line 130
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsEventActionType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsActionsType;->eventAction:Ljava/lang/String;

    .line 131
    return-object p0
.end method

.method public withEventAction(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsActionsType;
    .locals 0
    .param p1, "eventAction"    # Ljava/lang/String;

    .line 89
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/CompromisedCredentialsActionsType;->eventAction:Ljava/lang/String;

    .line 90
    return-object p0
.end method
