.class public Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "ConfirmDeviceRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private accessToken:Ljava/lang/String;

.field private deviceKey:Ljava/lang/String;

.field private deviceName:Ljava/lang/String;

.field private deviceSecretVerifierConfig:Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceSecretVerifierConfigType;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 28
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 320
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 321
    return v0

    .line 322
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 323
    return v1

    .line 325
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;

    if-nez v2, :cond_2

    .line 326
    return v1

    .line 327
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;

    .line 329
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 330
    return v1

    .line 331
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 332
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 333
    return v1

    .line 334
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceKey()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceKey()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 335
    return v1

    .line 336
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceKey()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 337
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceKey()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceKey()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 338
    return v1

    .line 339
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceSecretVerifierConfig()Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceSecretVerifierConfigType;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    .line 340
    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceSecretVerifierConfig()Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceSecretVerifierConfigType;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 341
    return v1

    .line 342
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceSecretVerifierConfig()Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceSecretVerifierConfigType;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 343
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceSecretVerifierConfig()Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceSecretVerifierConfigType;

    move-result-object v3

    .line 344
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceSecretVerifierConfig()Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceSecretVerifierConfigType;

    move-result-object v4

    .line 343
    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceSecretVerifierConfigType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 345
    return v1

    .line 346
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceName()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 347
    return v1

    .line 348
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceName()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_12

    .line 349
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 350
    return v1

    .line 351
    :cond_12
    return v0
.end method

.method public getAccessToken()Ljava/lang/String;
    .locals 1

    .line 80
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->accessToken:Ljava/lang/String;

    return-object v0
.end method

.method public getDeviceKey()Ljava/lang/String;
    .locals 1

    .line 135
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->deviceKey:Ljava/lang/String;

    return-object v0
.end method

.method public getDeviceName()Ljava/lang/String;
    .locals 1

    .line 238
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->deviceName:Ljava/lang/String;

    return-object v0
.end method

.method public getDeviceSecretVerifierConfig()Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceSecretVerifierConfigType;
    .locals 1

    .line 188
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->deviceSecretVerifierConfig:Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceSecretVerifierConfigType;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 304
    const/16 v0, 0x1f

    .line 305
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 307
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 308
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 309
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceKey()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceKey()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 310
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 312
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceSecretVerifierConfig()Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceSecretVerifierConfigType;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceSecretVerifierConfig()Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceSecretVerifierConfigType;

    move-result-object v3

    .line 313
    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceSecretVerifierConfigType;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 314
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_3
    add-int/2addr v1, v4

    .line 315
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setAccessToken(Ljava/lang/String;)V
    .locals 0
    .param p1, "accessToken"    # Ljava/lang/String;

    .line 96
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->accessToken:Ljava/lang/String;

    .line 97
    return-void
.end method

.method public setDeviceKey(Ljava/lang/String;)V
    .locals 0
    .param p1, "deviceKey"    # Ljava/lang/String;

    .line 152
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->deviceKey:Ljava/lang/String;

    .line 153
    return-void
.end method

.method public setDeviceName(Ljava/lang/String;)V
    .locals 0
    .param p1, "deviceName"    # Ljava/lang/String;

    .line 254
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->deviceName:Ljava/lang/String;

    .line 255
    return-void
.end method

.method public setDeviceSecretVerifierConfig(Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceSecretVerifierConfigType;)V
    .locals 0
    .param p1, "deviceSecretVerifierConfig"    # Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceSecretVerifierConfigType;

    .line 202
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->deviceSecretVerifierConfig:Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceSecretVerifierConfigType;

    .line 203
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 288
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 289
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 290
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 291
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AccessToken: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getAccessToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 292
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceKey()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 293
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DeviceKey: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceKey()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 294
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceSecretVerifierConfig()Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceSecretVerifierConfigType;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 295
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DeviceSecretVerifierConfig: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceSecretVerifierConfig()Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceSecretVerifierConfigType;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 296
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceName()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 297
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "DeviceName: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->getDeviceName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 298
    :cond_3
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 299
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withAccessToken(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;
    .locals 0
    .param p1, "accessToken"    # Ljava/lang/String;

    .line 117
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->accessToken:Ljava/lang/String;

    .line 118
    return-object p0
.end method

.method public withDeviceKey(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;
    .locals 0
    .param p1, "deviceKey"    # Ljava/lang/String;

    .line 174
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->deviceKey:Ljava/lang/String;

    .line 175
    return-object p0
.end method

.method public withDeviceName(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;
    .locals 0
    .param p1, "deviceName"    # Ljava/lang/String;

    .line 275
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->deviceName:Ljava/lang/String;

    .line 276
    return-object p0
.end method

.method public withDeviceSecretVerifierConfig(Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceSecretVerifierConfigType;)Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;
    .locals 0
    .param p1, "deviceSecretVerifierConfig"    # Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceSecretVerifierConfigType;

    .line 221
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmDeviceRequest;->deviceSecretVerifierConfig:Lcom/amazonaws/services/cognitoidentityprovider/model/DeviceSecretVerifierConfigType;

    .line 222
    return-object p0
.end method
