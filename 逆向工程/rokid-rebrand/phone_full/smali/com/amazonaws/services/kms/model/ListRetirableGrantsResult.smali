.class public Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;
.super Ljava/lang/Object;
.source "ListRetirableGrantsResult.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private grants:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/amazonaws/services/kms/model/GrantListEntry;",
            ">;"
        }
    .end annotation
.end field

.field private nextMarker:Ljava/lang/String;

.field private truncated:Ljava/lang/Boolean;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 26
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->grants:Ljava/util/List;

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 314
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 315
    return v0

    .line 316
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 317
    return v1

    .line 319
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;

    if-nez v2, :cond_2

    .line 320
    return v1

    .line 321
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;

    .line 323
    .local v2, "other":Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getGrants()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getGrants()Ljava/util/List;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 324
    return v1

    .line 325
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getGrants()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getGrants()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getGrants()Ljava/util/List;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 326
    return v1

    .line 327
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getNextMarker()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getNextMarker()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 328
    return v1

    .line 329
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getNextMarker()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 330
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getNextMarker()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getNextMarker()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 331
    return v1

    .line 332
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getTruncated()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getTruncated()Ljava/lang/Boolean;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 333
    return v1

    .line 334
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getTruncated()Ljava/lang/Boolean;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 335
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getTruncated()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getTruncated()Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 336
    return v1

    .line 337
    :cond_e
    return v0
.end method

.method public getGrants()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/kms/model/GrantListEntry;",
            ">;"
        }
    .end annotation

    .line 61
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->grants:Ljava/util/List;

    return-object v0
.end method

.method public getNextMarker()Ljava/lang/String;
    .locals 1

    .line 143
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->nextMarker:Ljava/lang/String;

    return-object v0
.end method

.method public getTruncated()Ljava/lang/Boolean;
    .locals 1

    .line 231
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->truncated:Ljava/lang/Boolean;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 303
    const/16 v0, 0x1f

    .line 304
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 306
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getGrants()Ljava/util/List;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getGrants()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 307
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getNextMarker()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getNextMarker()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 308
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getTruncated()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_2

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getTruncated()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Boolean;->hashCode()I

    move-result v4

    :goto_2
    add-int/2addr v2, v4

    .line 309
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public isTruncated()Ljava/lang/Boolean;
    .locals 1

    .line 211
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->truncated:Ljava/lang/Boolean;

    return-object v0
.end method

.method public setGrants(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/kms/model/GrantListEntry;",
            ">;)V"
        }
    .end annotation

    .line 74
    .local p1, "grants":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/kms/model/GrantListEntry;>;"
    if-nez p1, :cond_0

    .line 75
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->grants:Ljava/util/List;

    .line 76
    return-void

    .line 79
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->grants:Ljava/util/List;

    .line 80
    return-void
.end method

.method public setNextMarker(Ljava/lang/String;)V
    .locals 0
    .param p1, "nextMarker"    # Ljava/lang/String;

    .line 164
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->nextMarker:Ljava/lang/String;

    .line 165
    return-void
.end method

.method public setTruncated(Ljava/lang/Boolean;)V
    .locals 0
    .param p1, "truncated"    # Ljava/lang/Boolean;

    .line 251
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->truncated:Ljava/lang/Boolean;

    .line 252
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 289
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 290
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 291
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getGrants()Ljava/util/List;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 292
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Grants: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getGrants()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 293
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getNextMarker()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 294
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "NextMarker: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getNextMarker()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 295
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getTruncated()Ljava/lang/Boolean;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 296
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Truncated: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getTruncated()Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 297
    :cond_2
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 298
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withGrants(Ljava/util/Collection;)Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/kms/model/GrantListEntry;",
            ">;)",
            "Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;"
        }
    .end annotation

    .line 121
    .local p1, "grants":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/kms/model/GrantListEntry;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->setGrants(Ljava/util/Collection;)V

    .line 122
    return-object p0
.end method

.method public varargs withGrants([Lcom/amazonaws/services/kms/model/GrantListEntry;)Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;
    .locals 4
    .param p1, "grants"    # [Lcom/amazonaws/services/kms/model/GrantListEntry;

    .line 97
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->getGrants()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 98
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->grants:Ljava/util/List;

    .line 100
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    .line 101
    .local v2, "value":Lcom/amazonaws/services/kms/model/GrantListEntry;
    iget-object v3, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->grants:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 100
    .end local v2    # "value":Lcom/amazonaws/services/kms/model/GrantListEntry;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 103
    :cond_1
    return-object p0
.end method

.method public withNextMarker(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;
    .locals 0
    .param p1, "nextMarker"    # Ljava/lang/String;

    .line 190
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->nextMarker:Ljava/lang/String;

    .line 191
    return-object p0
.end method

.method public withTruncated(Ljava/lang/Boolean;)Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;
    .locals 0
    .param p1, "truncated"    # Ljava/lang/Boolean;

    .line 276
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsResult;->truncated:Ljava/lang/Boolean;

    .line 277
    return-object p0
.end method
