.class public Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;
.super Ljava/lang/Object;
.source "UpdateIdentityProviderResult.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private identityProvider:Lcom/amazonaws/services/cognitoidentityprovider/model/IdentityProviderType;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 102
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 103
    return v0

    .line 104
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 105
    return v1

    .line 107
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;

    if-nez v2, :cond_2

    .line 108
    return v1

    .line 109
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;

    .line 111
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;->getIdentityProvider()Lcom/amazonaws/services/cognitoidentityprovider/model/IdentityProviderType;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;->getIdentityProvider()Lcom/amazonaws/services/cognitoidentityprovider/model/IdentityProviderType;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 112
    return v1

    .line 113
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;->getIdentityProvider()Lcom/amazonaws/services/cognitoidentityprovider/model/IdentityProviderType;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 114
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;->getIdentityProvider()Lcom/amazonaws/services/cognitoidentityprovider/model/IdentityProviderType;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;->getIdentityProvider()Lcom/amazonaws/services/cognitoidentityprovider/model/IdentityProviderType;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/IdentityProviderType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 115
    return v1

    .line 116
    :cond_6
    return v0
.end method

.method public getIdentityProvider()Lcom/amazonaws/services/cognitoidentityprovider/model/IdentityProviderType;
    .locals 1

    .line 38
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;->identityProvider:Lcom/amazonaws/services/cognitoidentityprovider/model/IdentityProviderType;

    return-object v0
.end method

.method public hashCode()I
    .locals 4

    .line 92
    const/16 v0, 0x1f

    .line 93
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 95
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 96
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;->getIdentityProvider()Lcom/amazonaws/services/cognitoidentityprovider/model/IdentityProviderType;

    move-result-object v3

    if-nez v3, :cond_0

    const/4 v3, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;->getIdentityProvider()Lcom/amazonaws/services/cognitoidentityprovider/model/IdentityProviderType;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/IdentityProviderType;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 97
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    return v2
.end method

.method public setIdentityProvider(Lcom/amazonaws/services/cognitoidentityprovider/model/IdentityProviderType;)V
    .locals 0
    .param p1, "identityProvider"    # Lcom/amazonaws/services/cognitoidentityprovider/model/IdentityProviderType;

    .line 51
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;->identityProvider:Lcom/amazonaws/services/cognitoidentityprovider/model/IdentityProviderType;

    .line 52
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 82
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 83
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 84
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;->getIdentityProvider()Lcom/amazonaws/services/cognitoidentityprovider/model/IdentityProviderType;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 85
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "IdentityProvider: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;->getIdentityProvider()Lcom/amazonaws/services/cognitoidentityprovider/model/IdentityProviderType;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 86
    :cond_0
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 87
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withIdentityProvider(Lcom/amazonaws/services/cognitoidentityprovider/model/IdentityProviderType;)Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;
    .locals 0
    .param p1, "identityProvider"    # Lcom/amazonaws/services/cognitoidentityprovider/model/IdentityProviderType;

    .line 69
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateIdentityProviderResult;->identityProvider:Lcom/amazonaws/services/cognitoidentityprovider/model/IdentityProviderType;

    .line 70
    return-object p0
.end method
