.class public Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;
.super Ljava/lang/Object;
.source "ListIdentitiesResult.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private identities:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/amazonaws/services/cognitoidentity/model/IdentityDescription;",
            ">;"
        }
    .end annotation
.end field

.field private identityPoolId:Ljava/lang/String;

.field private nextToken:Ljava/lang/String;


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

    .line 281
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 282
    return v0

    .line 283
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 284
    return v1

    .line 286
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;

    if-nez v2, :cond_2

    .line 287
    return v1

    .line 288
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;

    .line 290
    .local v2, "other":Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 291
    return v1

    .line 292
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 293
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 294
    return v1

    .line 295
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getIdentities()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getIdentities()Ljava/util/List;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 296
    return v1

    .line 297
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getIdentities()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 298
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getIdentities()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getIdentities()Ljava/util/List;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 299
    return v1

    .line 300
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getNextToken()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getNextToken()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 301
    return v1

    .line 302
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getNextToken()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 303
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getNextToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getNextToken()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 304
    return v1

    .line 305
    :cond_e
    return v0
.end method

.method public getIdentities()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/cognitoidentity/model/IdentityDescription;",
            ">;"
        }
    .end annotation

    .line 122
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->identities:Ljava/util/List;

    return-object v0
.end method

.method public getIdentityPoolId()Ljava/lang/String;
    .locals 1

    .line 69
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->identityPoolId:Ljava/lang/String;

    return-object v0
.end method

.method public getNextToken()Ljava/lang/String;
    .locals 1

    .line 203
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->nextToken:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 269
    const/16 v0, 0x1f

    .line 270
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 272
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 273
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 274
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getIdentities()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getIdentities()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 275
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getNextToken()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getNextToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_2
    add-int/2addr v2, v4

    .line 276
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public setIdentities(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/cognitoidentity/model/IdentityDescription;",
            ">;)V"
        }
    .end annotation

    .line 136
    .local p1, "identities":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/cognitoidentity/model/IdentityDescription;>;"
    if-nez p1, :cond_0

    .line 137
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->identities:Ljava/util/List;

    .line 138
    return-void

    .line 141
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->identities:Ljava/util/List;

    .line 142
    return-void
.end method

.method public setIdentityPoolId(Ljava/lang/String;)V
    .locals 0
    .param p1, "identityPoolId"    # Ljava/lang/String;

    .line 86
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->identityPoolId:Ljava/lang/String;

    .line 87
    return-void
.end method

.method public setNextToken(Ljava/lang/String;)V
    .locals 0
    .param p1, "nextToken"    # Ljava/lang/String;

    .line 220
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->nextToken:Ljava/lang/String;

    .line 221
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 255
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 256
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 257
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 258
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "IdentityPoolId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getIdentityPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 259
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getIdentities()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 260
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Identities: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getIdentities()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 261
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getNextToken()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 262
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "NextToken: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getNextToken()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 263
    :cond_2
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 264
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withIdentities(Ljava/util/Collection;)Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/cognitoidentity/model/IdentityDescription;",
            ">;)",
            "Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;"
        }
    .end annotation

    .line 185
    .local p1, "identities":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/cognitoidentity/model/IdentityDescription;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->setIdentities(Ljava/util/Collection;)V

    .line 186
    return-object p0
.end method

.method public varargs withIdentities([Lcom/amazonaws/services/cognitoidentity/model/IdentityDescription;)Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;
    .locals 4
    .param p1, "identities"    # [Lcom/amazonaws/services/cognitoidentity/model/IdentityDescription;

    .line 160
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->getIdentities()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 161
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->identities:Ljava/util/List;

    .line 163
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    .line 164
    .local v2, "value":Lcom/amazonaws/services/cognitoidentity/model/IdentityDescription;
    iget-object v3, p0, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->identities:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 163
    .end local v2    # "value":Lcom/amazonaws/services/cognitoidentity/model/IdentityDescription;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 166
    :cond_1
    return-object p0
.end method

.method public withIdentityPoolId(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;
    .locals 0
    .param p1, "identityPoolId"    # Ljava/lang/String;

    .line 108
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->identityPoolId:Ljava/lang/String;

    .line 109
    return-object p0
.end method

.method public withNextToken(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;
    .locals 0
    .param p1, "nextToken"    # Ljava/lang/String;

    .line 242
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/ListIdentitiesResult;->nextToken:Ljava/lang/String;

    .line 243
    return-object p0
.end method
