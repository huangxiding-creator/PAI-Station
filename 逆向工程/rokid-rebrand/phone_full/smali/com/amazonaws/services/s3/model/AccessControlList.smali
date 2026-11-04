.class public Lcom/amazonaws/services/s3/model/AccessControlList;
.super Ljava/lang/Object;
.source "AccessControlList.java"

# interfaces
.implements Ljava/io/Serializable;
.implements Lcom/amazonaws/services/s3/internal/S3RequesterChargedResult;


# static fields
.field private static final serialVersionUID:J = 0x70575c947c762418L


# instance fields
.field private grantList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/Grant;",
            ">;"
        }
    .end annotation
.end field

.field private grantSet:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Lcom/amazonaws/services/s3/model/Grant;",
            ">;"
        }
    .end annotation
.end field

.field private isRequesterCharged:Z

.field private owner:Lcom/amazonaws/services/s3/model/Owner;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 67
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 74
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->owner:Lcom/amazonaws/services/s3/model/Owner;

    return-void
.end method

.method private checkState()V
    .locals 2

    .line 196
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantSet:Ljava/util/Set;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantList:Ljava/util/List;

    if-nez v0, :cond_0

    goto :goto_0

    .line 197
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Both grant set and grant list cannot be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 200
    :cond_1
    :goto_0
    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 240
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 241
    return v0

    .line 242
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 243
    return v1

    .line 244
    :cond_1
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    if-eq v2, v3, :cond_2

    .line 245
    return v1

    .line 247
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/s3/model/AccessControlList;

    .line 249
    .local v2, "other":Lcom/amazonaws/services/s3/model/AccessControlList;
    iget-object v3, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->owner:Lcom/amazonaws/services/s3/model/Owner;

    if-nez v3, :cond_3

    .line 250
    iget-object v3, v2, Lcom/amazonaws/services/s3/model/AccessControlList;->owner:Lcom/amazonaws/services/s3/model/Owner;

    if-eqz v3, :cond_4

    .line 251
    return v1

    .line 253
    :cond_3
    iget-object v3, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->owner:Lcom/amazonaws/services/s3/model/Owner;

    iget-object v4, v2, Lcom/amazonaws/services/s3/model/AccessControlList;->owner:Lcom/amazonaws/services/s3/model/Owner;

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/s3/model/Owner;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_4

    .line 254
    return v1

    .line 257
    :cond_4
    iget-object v3, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantSet:Ljava/util/Set;

    if-nez v3, :cond_5

    .line 258
    iget-object v3, v2, Lcom/amazonaws/services/s3/model/AccessControlList;->grantSet:Ljava/util/Set;

    if-eqz v3, :cond_6

    .line 259
    return v1

    .line 261
    :cond_5
    iget-object v3, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantSet:Ljava/util/Set;

    iget-object v4, v2, Lcom/amazonaws/services/s3/model/AccessControlList;->grantSet:Ljava/util/Set;

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 262
    return v1

    .line 265
    :cond_6
    iget-object v3, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantList:Ljava/util/List;

    if-nez v3, :cond_7

    .line 266
    iget-object v3, v2, Lcom/amazonaws/services/s3/model/AccessControlList;->grantList:Ljava/util/List;

    if-eqz v3, :cond_8

    .line 267
    return v1

    .line 269
    :cond_7
    iget-object v3, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantList:Ljava/util/List;

    iget-object v4, v2, Lcom/amazonaws/services/s3/model/AccessControlList;->grantList:Ljava/util/List;

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_8

    .line 270
    return v1

    .line 273
    :cond_8
    return v0
.end method

.method public getGrants()Ljava/util/Set;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Set<",
            "Lcom/amazonaws/services/s3/model/Grant;",
            ">;"
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 180
    invoke-direct {p0}, Lcom/amazonaws/services/s3/model/AccessControlList;->checkState()V

    .line 181
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantSet:Ljava/util/Set;

    if-nez v0, :cond_1

    .line 182
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantList:Ljava/util/List;

    if-nez v0, :cond_0

    .line 183
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantSet:Ljava/util/Set;

    goto :goto_0

    .line 185
    :cond_0
    new-instance v0, Ljava/util/HashSet;

    iget-object v1, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantList:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantSet:Ljava/util/Set;

    .line 186
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantList:Ljava/util/List;

    .line 189
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantSet:Ljava/util/Set;

    return-object v0
.end method

.method public getGrantsAsList()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/Grant;",
            ">;"
        }
    .end annotation

    .line 209
    invoke-direct {p0}, Lcom/amazonaws/services/s3/model/AccessControlList;->checkState()V

    .line 210
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantList:Ljava/util/List;

    if-nez v0, :cond_1

    .line 211
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantSet:Ljava/util/Set;

    if-nez v0, :cond_0

    .line 212
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantList:Ljava/util/List;

    goto :goto_0

    .line 214
    :cond_0
    new-instance v0, Ljava/util/LinkedList;

    iget-object v1, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantSet:Ljava/util/Set;

    invoke-direct {v0, v1}, Ljava/util/LinkedList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantList:Ljava/util/List;

    .line 215
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantSet:Ljava/util/Set;

    .line 219
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantList:Ljava/util/List;

    return-object v0
.end method

.method public getOwner()Lcom/amazonaws/services/s3/model/Owner;
    .locals 1

    .line 101
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->owner:Lcom/amazonaws/services/s3/model/Owner;

    return-object v0
.end method

.method public varargs grantAllPermissions([Lcom/amazonaws/services/s3/model/Grant;)V
    .locals 5
    .param p1, "grantsVarArg"    # [Lcom/amazonaws/services/s3/model/Grant;

    .line 148
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    aget-object v2, p1, v1

    .line 149
    .local v2, "gap":Lcom/amazonaws/services/s3/model/Grant;
    invoke-virtual {v2}, Lcom/amazonaws/services/s3/model/Grant;->getGrantee()Lcom/amazonaws/services/s3/model/Grantee;

    move-result-object v3

    invoke-virtual {v2}, Lcom/amazonaws/services/s3/model/Grant;->getPermission()Lcom/amazonaws/services/s3/model/Permission;

    move-result-object v4

    invoke-virtual {p0, v3, v4}, Lcom/amazonaws/services/s3/model/AccessControlList;->grantPermission(Lcom/amazonaws/services/s3/model/Grantee;Lcom/amazonaws/services/s3/model/Permission;)V

    .line 148
    .end local v2    # "gap":Lcom/amazonaws/services/s3/model/Grant;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 151
    :cond_0
    return-void
.end method

.method public grantPermission(Lcom/amazonaws/services/s3/model/Grantee;Lcom/amazonaws/services/s3/model/Permission;)V
    .locals 2
    .param p1, "grantee"    # Lcom/amazonaws/services/s3/model/Grantee;
    .param p2, "permission"    # Lcom/amazonaws/services/s3/model/Permission;

    .line 138
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/AccessControlList;->getGrantsAsList()Ljava/util/List;

    move-result-object v0

    new-instance v1, Lcom/amazonaws/services/s3/model/Grant;

    invoke-direct {v1, p1, p2}, Lcom/amazonaws/services/s3/model/Grant;-><init>(Lcom/amazonaws/services/s3/model/Grantee;Lcom/amazonaws/services/s3/model/Permission;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 139
    return-void
.end method

.method public hashCode()I
    .locals 5

    .line 227
    const/16 v0, 0x1f

    .line 228
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 229
    .local v1, "result":I
    mul-int/lit8 v2, v1, 0x1f

    iget-object v3, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->owner:Lcom/amazonaws/services/s3/model/Owner;

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    iget-object v3, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->owner:Lcom/amazonaws/services/s3/model/Owner;

    invoke-virtual {v3}, Lcom/amazonaws/services/s3/model/Owner;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 230
    .end local v1    # "result":I
    .local v2, "result":I
    mul-int/lit8 v1, v2, 0x1f

    iget-object v3, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantSet:Ljava/util/Set;

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    iget-object v3, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantSet:Ljava/util/Set;

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 231
    .end local v2    # "result":I
    .restart local v1    # "result":I
    mul-int/lit8 v2, v1, 0x1f

    iget-object v3, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantList:Ljava/util/List;

    if-nez v3, :cond_2

    goto :goto_2

    :cond_2
    iget-object v3, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantList:Ljava/util/List;

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v4

    :goto_2
    add-int/2addr v2, v4

    .line 232
    .end local v1    # "result":I
    .restart local v2    # "result":I
    return v2
.end method

.method public isRequesterCharged()Z
    .locals 1

    .line 286
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->isRequesterCharged:Z

    return v0
.end method

.method public revokeAllPermissions(Lcom/amazonaws/services/s3/model/Grantee;)V
    .locals 5
    .param p1, "grantee"    # Lcom/amazonaws/services/s3/model/Grantee;

    .line 160
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 161
    .local v0, "grantsToRemove":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lcom/amazonaws/services/s3/model/Grant;>;"
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/AccessControlList;->getGrantsAsList()Ljava/util/List;

    move-result-object v1

    .line 162
    .local v1, "existingGrants":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/Grant;>;"
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/amazonaws/services/s3/model/Grant;

    .line 163
    .local v3, "gap":Lcom/amazonaws/services/s3/model/Grant;
    invoke-virtual {v3}, Lcom/amazonaws/services/s3/model/Grant;->getGrantee()Lcom/amazonaws/services/s3/model/Grantee;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 164
    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 166
    .end local v3    # "gap":Lcom/amazonaws/services/s3/model/Grant;
    :cond_0
    goto :goto_0

    .line 167
    :cond_1
    iget-object v2, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->grantList:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->removeAll(Ljava/util/Collection;)Z

    .line 168
    return-void
.end method

.method public setOwner(Lcom/amazonaws/services/s3/model/Owner;)V
    .locals 0
    .param p1, "owner"    # Lcom/amazonaws/services/s3/model/Owner;

    .line 125
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->owner:Lcom/amazonaws/services/s3/model/Owner;

    .line 126
    return-void
.end method

.method public setRequesterCharged(Z)V
    .locals 0
    .param p1, "isRequesterCharged"    # Z

    .line 291
    iput-boolean p1, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->isRequesterCharged:Z

    .line 292
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 281
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "AccessControlList [owner="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/amazonaws/services/s3/model/AccessControlList;->owner:Lcom/amazonaws/services/s3/model/Owner;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", grants="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/AccessControlList;->getGrantsAsList()Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
