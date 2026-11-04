.class public Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;
.super Ljava/lang/Object;
.source "ListGroupsResult.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private groups:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/GroupType;",
            ">;"
        }
    .end annotation
.end field

.field private nextToken:Ljava/lang/String;


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

    .line 211
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 212
    return v0

    .line 213
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 214
    return v1

    .line 216
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;

    if-nez v2, :cond_2

    .line 217
    return v1

    .line 218
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;

    .line 220
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->getGroups()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->getGroups()Ljava/util/List;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 221
    return v1

    .line 222
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->getGroups()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->getGroups()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->getGroups()Ljava/util/List;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 223
    return v1

    .line 224
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->getNextToken()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->getNextToken()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 225
    return v1

    .line 226
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->getNextToken()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 227
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->getNextToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->getNextToken()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 228
    return v1

    .line 229
    :cond_a
    return v0
.end method

.method public getGroups()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/GroupType;",
            ">;"
        }
    .end annotation

    .line 50
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->groups:Ljava/util/List;

    return-object v0
.end method

.method public getNextToken()Ljava/lang/String;
    .locals 1

    .line 131
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->nextToken:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 201
    const/16 v0, 0x1f

    .line 202
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 204
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->getGroups()Ljava/util/List;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->getGroups()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 205
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->getNextToken()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->getNextToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_1
    add-int/2addr v1, v4

    .line 206
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setGroups(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/GroupType;",
            ">;)V"
        }
    .end annotation

    .line 63
    .local p1, "groups":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/cognitoidentityprovider/model/GroupType;>;"
    if-nez p1, :cond_0

    .line 64
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->groups:Ljava/util/List;

    .line 65
    return-void

    .line 68
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->groups:Ljava/util/List;

    .line 69
    return-void
.end method

.method public setNextToken(Ljava/lang/String;)V
    .locals 0
    .param p1, "nextToken"    # Ljava/lang/String;

    .line 151
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->nextToken:Ljava/lang/String;

    .line 152
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 189
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 190
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 191
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->getGroups()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 192
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Groups: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->getGroups()Ljava/util/List;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 193
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->getNextToken()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 194
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "NextToken: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->getNextToken()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 195
    :cond_1
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 196
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withGroups(Ljava/util/Collection;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/GroupType;",
            ">;)",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;"
        }
    .end annotation

    .line 110
    .local p1, "groups":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/cognitoidentityprovider/model/GroupType;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->setGroups(Ljava/util/Collection;)V

    .line 111
    return-object p0
.end method

.method public varargs withGroups([Lcom/amazonaws/services/cognitoidentityprovider/model/GroupType;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;
    .locals 4
    .param p1, "groups"    # [Lcom/amazonaws/services/cognitoidentityprovider/model/GroupType;

    .line 86
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->getGroups()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 87
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->groups:Ljava/util/List;

    .line 89
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    .line 90
    .local v2, "value":Lcom/amazonaws/services/cognitoidentityprovider/model/GroupType;
    iget-object v3, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->groups:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 89
    .end local v2    # "value":Lcom/amazonaws/services/cognitoidentityprovider/model/GroupType;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 92
    :cond_1
    return-object p0
.end method

.method public withNextToken(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;
    .locals 0
    .param p1, "nextToken"    # Ljava/lang/String;

    .line 176
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListGroupsResult;->nextToken:Ljava/lang/String;

    .line 177
    return-object p0
.end method
