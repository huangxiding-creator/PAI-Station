.class public Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;
.super Ljava/lang/Object;
.source "DeleteIdentitiesResult.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private unprocessedIdentityIds:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/amazonaws/services/cognitoidentity/model/UnprocessedIdentityId;",
            ">;"
        }
    .end annotation
.end field


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

    .line 152
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 153
    return v0

    .line 154
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 155
    return v1

    .line 157
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;

    if-nez v2, :cond_2

    .line 158
    return v1

    .line 159
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;

    .line 161
    .local v2, "other":Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;->getUnprocessedIdentityIds()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;->getUnprocessedIdentityIds()Ljava/util/List;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 162
    return v1

    .line 163
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;->getUnprocessedIdentityIds()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 164
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;->getUnprocessedIdentityIds()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;->getUnprocessedIdentityIds()Ljava/util/List;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 165
    return v1

    .line 166
    :cond_6
    return v0
.end method

.method public getUnprocessedIdentityIds()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/cognitoidentity/model/UnprocessedIdentityId;",
            ">;"
        }
    .end annotation

    .line 46
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;->unprocessedIdentityIds:Ljava/util/List;

    return-object v0
.end method

.method public hashCode()I
    .locals 4

    .line 140
    const/16 v0, 0x1f

    .line 141
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 143
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 145
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;->getUnprocessedIdentityIds()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_0

    const/4 v3, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;->getUnprocessedIdentityIds()Ljava/util/List;

    move-result-object v3

    .line 146
    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 147
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    return v2
.end method

.method public setUnprocessedIdentityIds(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/cognitoidentity/model/UnprocessedIdentityId;",
            ">;)V"
        }
    .end annotation

    .line 62
    .local p1, "unprocessedIdentityIds":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/cognitoidentity/model/UnprocessedIdentityId;>;"
    if-nez p1, :cond_0

    .line 63
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;->unprocessedIdentityIds:Ljava/util/List;

    .line 64
    return-void

    .line 67
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;->unprocessedIdentityIds:Ljava/util/List;

    .line 69
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 130
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 131
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 132
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;->getUnprocessedIdentityIds()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 133
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "UnprocessedIdentityIds: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;->getUnprocessedIdentityIds()Ljava/util/List;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 134
    :cond_0
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 135
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withUnprocessedIdentityIds(Ljava/util/Collection;)Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/cognitoidentity/model/UnprocessedIdentityId;",
            ">;)",
            "Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;"
        }
    .end annotation

    .line 117
    .local p1, "unprocessedIdentityIds":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/cognitoidentity/model/UnprocessedIdentityId;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;->setUnprocessedIdentityIds(Ljava/util/Collection;)V

    .line 118
    return-object p0
.end method

.method public varargs withUnprocessedIdentityIds([Lcom/amazonaws/services/cognitoidentity/model/UnprocessedIdentityId;)Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;
    .locals 4
    .param p1, "unprocessedIdentityIds"    # [Lcom/amazonaws/services/cognitoidentity/model/UnprocessedIdentityId;

    .line 89
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;->getUnprocessedIdentityIds()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 90
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;->unprocessedIdentityIds:Ljava/util/List;

    .line 93
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    .line 94
    .local v2, "value":Lcom/amazonaws/services/cognitoidentity/model/UnprocessedIdentityId;
    iget-object v3, p0, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesResult;->unprocessedIdentityIds:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 93
    .end local v2    # "value":Lcom/amazonaws/services/cognitoidentity/model/UnprocessedIdentityId;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 96
    :cond_1
    return-object p0
.end method
