.class public Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "AdminDisableProviderForUserRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private user:Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

.field private userPoolId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 70
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 207
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 208
    return v0

    .line 209
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 210
    return v1

    .line 212
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;

    if-nez v2, :cond_2

    .line 213
    return v1

    .line 214
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;

    .line 216
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 217
    return v1

    .line 218
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 219
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 220
    return v1

    .line 221
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->getUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->getUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

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
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->getUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v3

    if-eqz v3, :cond_a

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->getUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->getUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 224
    return v1

    .line 225
    :cond_a
    return v0
.end method

.method public getUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;
    .locals 1

    .line 141
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->user:Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    return-object v0
.end method

.method public getUserPoolId()Ljava/lang/String;
    .locals 1

    .line 96
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->userPoolId:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 197
    const/16 v0, 0x1f

    .line 198
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 200
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 201
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->getUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v3

    if-nez v3, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->getUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;->hashCode()I

    move-result v4

    :goto_1
    add-int/2addr v1, v4

    .line 202
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setUser(Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;)V
    .locals 0
    .param p1, "user"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    .line 154
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->user:Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    .line 155
    return-void
.end method

.method public setUserPoolId(Ljava/lang/String;)V
    .locals 0
    .param p1, "userPoolId"    # Ljava/lang/String;

    .line 109
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->userPoolId:Ljava/lang/String;

    .line 110
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 185
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 186
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 187
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 188
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "UserPoolId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 189
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->getUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 190
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "User: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->getUser()Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 191
    :cond_1
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 192
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withUser(Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;
    .locals 0
    .param p1, "user"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    .line 172
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->user:Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderUserIdentifierType;

    .line 173
    return-object p0
.end method

.method public withUserPoolId(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;
    .locals 0
    .param p1, "userPoolId"    # Ljava/lang/String;

    .line 127
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminDisableProviderForUserRequest;->userPoolId:Ljava/lang/String;

    .line 128
    return-object p0
.end method
