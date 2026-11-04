.class public Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;
.super Ljava/lang/Object;
.source "ListIdentityProvidersResult.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private nextToken:Ljava/lang/String;

.field private providers:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderDescription;",
            ">;"
        }
    .end annotation
.end field


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

    .line 202
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 203
    return v0

    .line 204
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 205
    return v1

    .line 207
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;

    if-nez v2, :cond_2

    .line 208
    return v1

    .line 209
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;

    .line 211
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->getProviders()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->getProviders()Ljava/util/List;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 212
    return v1

    .line 213
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->getProviders()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 214
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->getProviders()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->getProviders()Ljava/util/List;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 215
    return v1

    .line 216
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->getNextToken()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->getNextToken()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 217
    return v1

    .line 218
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->getNextToken()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 219
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->getNextToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->getNextToken()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 220
    return v1

    .line 221
    :cond_a
    return v0
.end method

.method public getNextToken()Ljava/lang/String;
    .locals 1

    .line 128
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->nextToken:Ljava/lang/String;

    return-object v0
.end method

.method public getProviders()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderDescription;",
            ">;"
        }
    .end annotation

    .line 49
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->providers:Ljava/util/List;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 192
    const/16 v0, 0x1f

    .line 193
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 195
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->getProviders()Ljava/util/List;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->getProviders()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 196
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->getNextToken()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->getNextToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_1
    add-int/2addr v1, v4

    .line 197
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setNextToken(Ljava/lang/String;)V
    .locals 0
    .param p1, "nextToken"    # Ljava/lang/String;

    .line 145
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->nextToken:Ljava/lang/String;

    .line 146
    return-void
.end method

.method public setProviders(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderDescription;",
            ">;)V"
        }
    .end annotation

    .line 62
    .local p1, "providers":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderDescription;>;"
    if-nez p1, :cond_0

    .line 63
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->providers:Ljava/util/List;

    .line 64
    return-void

    .line 67
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->providers:Ljava/util/List;

    .line 68
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 180
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 181
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 182
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->getProviders()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 183
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Providers: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->getProviders()Ljava/util/List;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 184
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->getNextToken()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 185
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "NextToken: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->getNextToken()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 186
    :cond_1
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 187
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withNextToken(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;
    .locals 0
    .param p1, "nextToken"    # Ljava/lang/String;

    .line 167
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->nextToken:Ljava/lang/String;

    .line 168
    return-object p0
.end method

.method public withProviders(Ljava/util/Collection;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderDescription;",
            ">;)",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;"
        }
    .end annotation

    .line 110
    .local p1, "providers":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderDescription;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->setProviders(Ljava/util/Collection;)V

    .line 111
    return-object p0
.end method

.method public varargs withProviders([Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderDescription;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;
    .locals 4
    .param p1, "providers"    # [Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderDescription;

    .line 85
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->getProviders()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 86
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->providers:Ljava/util/List;

    .line 88
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    .line 89
    .local v2, "value":Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderDescription;
    iget-object v3, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListIdentityProvidersResult;->providers:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 88
    .end local v2    # "value":Lcom/amazonaws/services/cognitoidentityprovider/model/ProviderDescription;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 91
    :cond_1
    return-object p0
.end method
