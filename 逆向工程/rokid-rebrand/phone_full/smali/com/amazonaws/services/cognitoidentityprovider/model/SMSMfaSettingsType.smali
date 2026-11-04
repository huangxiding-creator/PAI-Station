.class public Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;
.super Ljava/lang/Object;
.source "SMSMfaSettingsType.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private enabled:Ljava/lang/Boolean;

.field private preferredMfa:Ljava/lang/Boolean;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 221
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 222
    return v0

    .line 223
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 224
    return v1

    .line 226
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;

    if-nez v2, :cond_2

    .line 227
    return v1

    .line 228
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;

    .line 230
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->getEnabled()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->getEnabled()Ljava/lang/Boolean;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 231
    return v1

    .line 232
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->getEnabled()Ljava/lang/Boolean;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->getEnabled()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->getEnabled()Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 233
    return v1

    .line 234
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->getPreferredMfa()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->getPreferredMfa()Ljava/lang/Boolean;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 235
    return v1

    .line 236
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->getPreferredMfa()Ljava/lang/Boolean;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 237
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->getPreferredMfa()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->getPreferredMfa()Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 238
    return v1

    .line 239
    :cond_a
    return v0
.end method

.method public getEnabled()Ljava/lang/Boolean;
    .locals 1

    .line 84
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->enabled:Ljava/lang/Boolean;

    return-object v0
.end method

.method public getPreferredMfa()Ljava/lang/Boolean;
    .locals 1

    .line 154
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->preferredMfa:Ljava/lang/Boolean;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 210
    const/16 v0, 0x1f

    .line 211
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 213
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->getEnabled()Ljava/lang/Boolean;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->getEnabled()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Boolean;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 214
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 215
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->getPreferredMfa()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->getPreferredMfa()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Boolean;->hashCode()I

    move-result v4

    :goto_1
    add-int/2addr v1, v4

    .line 216
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public isEnabled()Ljava/lang/Boolean;
    .locals 1

    .line 65
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->enabled:Ljava/lang/Boolean;

    return-object v0
.end method

.method public isPreferredMfa()Ljava/lang/Boolean;
    .locals 1

    .line 141
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->preferredMfa:Ljava/lang/Boolean;

    return-object v0
.end method

.method public setEnabled(Ljava/lang/Boolean;)V
    .locals 0
    .param p1, "enabled"    # Ljava/lang/Boolean;

    .line 103
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->enabled:Ljava/lang/Boolean;

    .line 104
    return-void
.end method

.method public setPreferredMfa(Ljava/lang/Boolean;)V
    .locals 0
    .param p1, "preferredMfa"    # Ljava/lang/Boolean;

    .line 167
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->preferredMfa:Ljava/lang/Boolean;

    .line 168
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 198
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 199
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 200
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->getEnabled()Ljava/lang/Boolean;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 201
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Enabled: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->getEnabled()Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 202
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->getPreferredMfa()Ljava/lang/Boolean;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 203
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "PreferredMfa: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->getPreferredMfa()Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 204
    :cond_1
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 205
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withEnabled(Ljava/lang/Boolean;)Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;
    .locals 0
    .param p1, "enabled"    # Ljava/lang/Boolean;

    .line 127
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->enabled:Ljava/lang/Boolean;

    .line 128
    return-object p0
.end method

.method public withPreferredMfa(Ljava/lang/Boolean;)Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;
    .locals 0
    .param p1, "preferredMfa"    # Ljava/lang/Boolean;

    .line 185
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/SMSMfaSettingsType;->preferredMfa:Ljava/lang/Boolean;

    .line 186
    return-object p0
.end method
