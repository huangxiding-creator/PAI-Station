.class public Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;
.super Ljava/lang/Object;
.source "ListUserImportJobsResult.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private paginationToken:Ljava/lang/String;

.field private userImportJobs:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/UserImportJobType;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 217
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 218
    return v0

    .line 219
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 220
    return v1

    .line 222
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;

    if-nez v2, :cond_2

    .line 223
    return v1

    .line 224
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;

    .line 226
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->getUserImportJobs()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->getUserImportJobs()Ljava/util/List;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 227
    return v1

    .line 228
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->getUserImportJobs()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 229
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->getUserImportJobs()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->getUserImportJobs()Ljava/util/List;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 230
    return v1

    .line 231
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->getPaginationToken()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->getPaginationToken()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 232
    return v1

    .line 233
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->getPaginationToken()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 234
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->getPaginationToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->getPaginationToken()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 235
    return v1

    .line 236
    :cond_a
    return v0
.end method

.method public getPaginationToken()Ljava/lang/String;
    .locals 1

    .line 137
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->paginationToken:Ljava/lang/String;

    return-object v0
.end method

.method public getUserImportJobs()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/UserImportJobType;",
            ">;"
        }
    .end annotation

    .line 56
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->userImportJobs:Ljava/util/List;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 205
    const/16 v0, 0x1f

    .line 206
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 208
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 209
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->getUserImportJobs()Ljava/util/List;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->getUserImportJobs()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 210
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 211
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->getPaginationToken()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->getPaginationToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_1
    add-int/2addr v1, v4

    .line 212
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setPaginationToken(Ljava/lang/String;)V
    .locals 0
    .param p1, "paginationToken"    # Ljava/lang/String;

    .line 156
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->paginationToken:Ljava/lang/String;

    .line 157
    return-void
.end method

.method public setUserImportJobs(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/UserImportJobType;",
            ">;)V"
        }
    .end annotation

    .line 69
    .local p1, "userImportJobs":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/cognitoidentityprovider/model/UserImportJobType;>;"
    if-nez p1, :cond_0

    .line 70
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->userImportJobs:Ljava/util/List;

    .line 71
    return-void

    .line 74
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->userImportJobs:Ljava/util/List;

    .line 75
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 193
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 194
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 195
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->getUserImportJobs()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 196
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "UserImportJobs: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->getUserImportJobs()Ljava/util/List;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 197
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->getPaginationToken()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 198
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "PaginationToken: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->getPaginationToken()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 199
    :cond_1
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 200
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withPaginationToken(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;
    .locals 0
    .param p1, "paginationToken"    # Ljava/lang/String;

    .line 180
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->paginationToken:Ljava/lang/String;

    .line 181
    return-object p0
.end method

.method public withUserImportJobs(Ljava/util/Collection;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/UserImportJobType;",
            ">;)",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;"
        }
    .end annotation

    .line 117
    .local p1, "userImportJobs":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/cognitoidentityprovider/model/UserImportJobType;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->setUserImportJobs(Ljava/util/Collection;)V

    .line 118
    return-object p0
.end method

.method public varargs withUserImportJobs([Lcom/amazonaws/services/cognitoidentityprovider/model/UserImportJobType;)Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;
    .locals 4
    .param p1, "userImportJobs"    # [Lcom/amazonaws/services/cognitoidentityprovider/model/UserImportJobType;

    .line 92
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->getUserImportJobs()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 93
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->userImportJobs:Ljava/util/List;

    .line 95
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    .line 96
    .local v2, "value":Lcom/amazonaws/services/cognitoidentityprovider/model/UserImportJobType;
    iget-object v3, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/ListUserImportJobsResult;->userImportJobs:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 95
    .end local v2    # "value":Lcom/amazonaws/services/cognitoidentityprovider/model/UserImportJobType;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 98
    :cond_1
    return-object p0
.end method
