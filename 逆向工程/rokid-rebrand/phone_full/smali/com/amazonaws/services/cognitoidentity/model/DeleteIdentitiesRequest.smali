.class public Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "DeleteIdentitiesRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private identityIdsToDelete:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 31
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 143
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 144
    return v0

    .line 145
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 146
    return v1

    .line 148
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;

    if-nez v2, :cond_2

    .line 149
    return v1

    .line 150
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;

    .line 152
    .local v2, "other":Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;->getIdentityIdsToDelete()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;->getIdentityIdsToDelete()Ljava/util/List;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 153
    return v1

    .line 154
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;->getIdentityIdsToDelete()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 155
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;->getIdentityIdsToDelete()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;->getIdentityIdsToDelete()Ljava/util/List;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 156
    return v1

    .line 157
    :cond_6
    return v0
.end method

.method public getIdentityIdsToDelete()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 49
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;->identityIdsToDelete:Ljava/util/List;

    return-object v0
.end method

.method public hashCode()I
    .locals 4

    .line 133
    const/16 v0, 0x1f

    .line 134
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 136
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 137
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;->getIdentityIdsToDelete()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_0

    const/4 v3, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;->getIdentityIdsToDelete()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 138
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    return v2
.end method

.method public setIdentityIdsToDelete(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 62
    .local p1, "identityIdsToDelete":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    if-nez p1, :cond_0

    .line 63
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;->identityIdsToDelete:Ljava/util/List;

    .line 64
    return-void

    .line 67
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;->identityIdsToDelete:Ljava/util/List;

    .line 68
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 123
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 124
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 125
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;->getIdentityIdsToDelete()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 126
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "IdentityIdsToDelete: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;->getIdentityIdsToDelete()Ljava/util/List;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 127
    :cond_0
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 128
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withIdentityIdsToDelete(Ljava/util/Collection;)Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;"
        }
    .end annotation

    .line 110
    .local p1, "identityIdsToDelete":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;->setIdentityIdsToDelete(Ljava/util/Collection;)V

    .line 111
    return-object p0
.end method

.method public varargs withIdentityIdsToDelete([Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;
    .locals 4
    .param p1, "identityIdsToDelete"    # [Ljava/lang/String;

    .line 85
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;->getIdentityIdsToDelete()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 86
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;->identityIdsToDelete:Ljava/util/List;

    .line 88
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    .line 89
    .local v2, "value":Ljava/lang/String;
    iget-object v3, p0, Lcom/amazonaws/services/cognitoidentity/model/DeleteIdentitiesRequest;->identityIdsToDelete:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 88
    .end local v2    # "value":Ljava/lang/String;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 91
    :cond_1
    return-object p0
.end method
