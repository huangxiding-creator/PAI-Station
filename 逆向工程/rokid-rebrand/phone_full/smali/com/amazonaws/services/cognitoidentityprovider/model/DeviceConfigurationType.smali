.class public Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;
.super Ljava/lang/Object;
.source "DeviceConfigurationType.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private challengeRequiredOnNewDevice:Ljava/lang/Boolean;

.field private deviceOnlyRememberedOnUserPrompt:Ljava/lang/Boolean;


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

    .line 204
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 205
    return v0

    .line 206
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 207
    return v1

    .line 209
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;

    if-nez v2, :cond_2

    .line 210
    return v1

    .line 211
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;

    .line 213
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->getChallengeRequiredOnNewDevice()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    .line 214
    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->getChallengeRequiredOnNewDevice()Ljava/lang/Boolean;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 215
    return v1

    .line 216
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->getChallengeRequiredOnNewDevice()Ljava/lang/Boolean;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 217
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->getChallengeRequiredOnNewDevice()Ljava/lang/Boolean;

    move-result-object v3

    .line 218
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->getChallengeRequiredOnNewDevice()Ljava/lang/Boolean;

    move-result-object v4

    .line 217
    invoke-virtual {v3, v4}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 219
    return v1

    .line 220
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->getDeviceOnlyRememberedOnUserPrompt()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    .line 221
    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->getDeviceOnlyRememberedOnUserPrompt()Ljava/lang/Boolean;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 222
    return v1

    .line 223
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->getDeviceOnlyRememberedOnUserPrompt()Ljava/lang/Boolean;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 224
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->getDeviceOnlyRememberedOnUserPrompt()Ljava/lang/Boolean;

    move-result-object v3

    .line 225
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->getDeviceOnlyRememberedOnUserPrompt()Ljava/lang/Boolean;

    move-result-object v4

    .line 224
    invoke-virtual {v3, v4}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 226
    return v1

    .line 227
    :cond_a
    return v0
.end method

.method public getChallengeRequiredOnNewDevice()Ljava/lang/Boolean;
    .locals 1

    .line 68
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->challengeRequiredOnNewDevice:Ljava/lang/Boolean;

    return-object v0
.end method

.method public getDeviceOnlyRememberedOnUserPrompt()Ljava/lang/Boolean;
    .locals 1

    .line 131
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->deviceOnlyRememberedOnUserPrompt:Ljava/lang/Boolean;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 188
    const/16 v0, 0x1f

    .line 189
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 191
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 193
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->getChallengeRequiredOnNewDevice()Ljava/lang/Boolean;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    .line 194
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->getChallengeRequiredOnNewDevice()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Boolean;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 195
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 197
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->getDeviceOnlyRememberedOnUserPrompt()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_1

    goto :goto_1

    .line 198
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->getDeviceOnlyRememberedOnUserPrompt()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Boolean;->hashCode()I

    move-result v4

    :goto_1
    add-int/2addr v1, v4

    .line 199
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public isChallengeRequiredOnNewDevice()Ljava/lang/Boolean;
    .locals 1

    .line 53
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->challengeRequiredOnNewDevice:Ljava/lang/Boolean;

    return-object v0
.end method

.method public isDeviceOnlyRememberedOnUserPrompt()Ljava/lang/Boolean;
    .locals 1

    .line 118
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->deviceOnlyRememberedOnUserPrompt:Ljava/lang/Boolean;

    return-object v0
.end method

.method public setChallengeRequiredOnNewDevice(Ljava/lang/Boolean;)V
    .locals 0
    .param p1, "challengeRequiredOnNewDevice"    # Ljava/lang/Boolean;

    .line 83
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->challengeRequiredOnNewDevice:Ljava/lang/Boolean;

    .line 84
    return-void
.end method

.method public setDeviceOnlyRememberedOnUserPrompt(Ljava/lang/Boolean;)V
    .locals 0
    .param p1, "deviceOnlyRememberedOnUserPrompt"    # Ljava/lang/Boolean;

    .line 144
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->deviceOnlyRememberedOnUserPrompt:Ljava/lang/Boolean;

    .line 145
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 176
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 177
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 178
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->getChallengeRequiredOnNewDevice()Ljava/lang/Boolean;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 179
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ChallengeRequiredOnNewDevice: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->getChallengeRequiredOnNewDevice()Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 180
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->getDeviceOnlyRememberedOnUserPrompt()Ljava/lang/Boolean;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 181
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "DeviceOnlyRememberedOnUserPrompt: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->getDeviceOnlyRememberedOnUserPrompt()Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 182
    :cond_1
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 183
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withChallengeRequiredOnNewDevice(Ljava/lang/Boolean;)Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;
    .locals 0
    .param p1, "challengeRequiredOnNewDevice"    # Ljava/lang/Boolean;

    .line 104
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->challengeRequiredOnNewDevice:Ljava/lang/Boolean;

    .line 105
    return-object p0
.end method

.method public withDeviceOnlyRememberedOnUserPrompt(Ljava/lang/Boolean;)Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;
    .locals 0
    .param p1, "deviceOnlyRememberedOnUserPrompt"    # Ljava/lang/Boolean;

    .line 163
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceConfigurationType;->deviceOnlyRememberedOnUserPrompt:Ljava/lang/Boolean;

    .line 164
    return-object p0
.end method
