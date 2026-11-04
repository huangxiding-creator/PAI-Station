.class public Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;
.super Ljava/lang/Object;
.source "ConfirmDeviceResult.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private userConfirmationNecessary:Ljava/lang/Boolean;


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

    .line 131
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 132
    return v0

    .line 133
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 134
    return v1

    .line 136
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;

    if-nez v2, :cond_2

    .line 137
    return v1

    .line 138
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;

    .line 140
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;->getUserConfirmationNecessary()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    .line 141
    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;->getUserConfirmationNecessary()Ljava/lang/Boolean;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 142
    return v1

    .line 143
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;->getUserConfirmationNecessary()Ljava/lang/Boolean;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 144
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;->getUserConfirmationNecessary()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;->getUserConfirmationNecessary()Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 145
    return v1

    .line 146
    :cond_6
    return v0
.end method

.method public getUserConfirmationNecessary()Ljava/lang/Boolean;
    .locals 1

    .line 61
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;->userConfirmationNecessary:Ljava/lang/Boolean;

    return-object v0
.end method

.method public hashCode()I
    .locals 4

    .line 119
    const/16 v0, 0x1f

    .line 120
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 122
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 124
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;->getUserConfirmationNecessary()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_0

    const/4 v3, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;->getUserConfirmationNecessary()Ljava/lang/Boolean;

    move-result-object v3

    .line 125
    invoke-virtual {v3}, Ljava/lang/Boolean;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 126
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    return v2
.end method

.method public isUserConfirmationNecessary()Ljava/lang/Boolean;
    .locals 1

    .line 46
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;->userConfirmationNecessary:Ljava/lang/Boolean;

    return-object v0
.end method

.method public setUserConfirmationNecessary(Ljava/lang/Boolean;)V
    .locals 0
    .param p1, "userConfirmationNecessary"    # Ljava/lang/Boolean;

    .line 76
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;->userConfirmationNecessary:Ljava/lang/Boolean;

    .line 77
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 109
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 110
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 111
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;->getUserConfirmationNecessary()Ljava/lang/Boolean;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 112
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "UserConfirmationNecessary: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;->getUserConfirmationNecessary()Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 113
    :cond_0
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 114
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withUserConfirmationNecessary(Ljava/lang/Boolean;)Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;
    .locals 0
    .param p1, "userConfirmationNecessary"    # Ljava/lang/Boolean;

    .line 96
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceResult;->userConfirmationNecessary:Ljava/lang/Boolean;

    .line 97
    return-object p0
.end method
