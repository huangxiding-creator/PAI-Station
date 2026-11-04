.class public Lcom/amazonaws/services/kms/model/ListResourceTagsResult;
.super Ljava/lang/Object;
.source "ListResourceTagsResult.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private nextMarker:Ljava/lang/String;

.field private tags:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/amazonaws/services/kms/model/Tag;",
            ">;"
        }
    .end annotation
.end field

.field private truncated:Ljava/lang/Boolean;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 26
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->tags:Ljava/util/List;

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 338
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 339
    return v0

    .line 340
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 341
    return v1

    .line 343
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;

    if-nez v2, :cond_2

    .line 344
    return v1

    .line 345
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;

    .line 347
    .local v2, "other":Lcom/amazonaws/services/kms/model/ListResourceTagsResult;
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getTags()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getTags()Ljava/util/List;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 348
    return v1

    .line 349
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getTags()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getTags()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getTags()Ljava/util/List;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 350
    return v1

    .line 351
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getNextMarker()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getNextMarker()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 352
    return v1

    .line 353
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getNextMarker()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 354
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getNextMarker()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getNextMarker()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 355
    return v1

    .line 356
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getTruncated()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getTruncated()Ljava/lang/Boolean;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 357
    return v1

    .line 358
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getTruncated()Ljava/lang/Boolean;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 359
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getTruncated()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getTruncated()Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 360
    return v1

    .line 361
    :cond_e
    return v0
.end method

.method public getNextMarker()Ljava/lang/String;
    .locals 1

    .line 155
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->nextMarker:Ljava/lang/String;

    return-object v0
.end method

.method public getTags()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/kms/model/Tag;",
            ">;"
        }
    .end annotation

    .line 64
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->tags:Ljava/util/List;

    return-object v0
.end method

.method public getTruncated()Ljava/lang/Boolean;
    .locals 1

    .line 255
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->truncated:Ljava/lang/Boolean;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 327
    const/16 v0, 0x1f

    .line 328
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 330
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getTags()Ljava/util/List;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getTags()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 331
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getNextMarker()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getNextMarker()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 332
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getTruncated()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_2

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getTruncated()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Boolean;->hashCode()I

    move-result v4

    :goto_2
    add-int/2addr v2, v4

    .line 333
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public isTruncated()Ljava/lang/Boolean;
    .locals 1

    .line 235
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->truncated:Ljava/lang/Boolean;

    return-object v0
.end method

.method public setNextMarker(Ljava/lang/String;)V
    .locals 0
    .param p1, "nextMarker"    # Ljava/lang/String;

    .line 182
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->nextMarker:Ljava/lang/String;

    .line 183
    return-void
.end method

.method public setTags(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/kms/model/Tag;",
            ">;)V"
        }
    .end annotation

    .line 78
    .local p1, "tags":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/kms/model/Tag;>;"
    if-nez p1, :cond_0

    .line 79
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->tags:Ljava/util/List;

    .line 80
    return-void

    .line 83
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->tags:Ljava/util/List;

    .line 84
    return-void
.end method

.method public setTruncated(Ljava/lang/Boolean;)V
    .locals 0
    .param p1, "truncated"    # Ljava/lang/Boolean;

    .line 275
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->truncated:Ljava/lang/Boolean;

    .line 276
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 313
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 314
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 315
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getTags()Ljava/util/List;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 316
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Tags: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getTags()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 317
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getNextMarker()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 318
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "NextMarker: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getNextMarker()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 319
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getTruncated()Ljava/lang/Boolean;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 320
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Truncated: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getTruncated()Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 321
    :cond_2
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 322
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withNextMarker(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/ListResourceTagsResult;
    .locals 0
    .param p1, "nextMarker"    # Ljava/lang/String;

    .line 214
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->nextMarker:Ljava/lang/String;

    .line 215
    return-object p0
.end method

.method public withTags(Ljava/util/Collection;)Lcom/amazonaws/services/kms/model/ListResourceTagsResult;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/kms/model/Tag;",
            ">;)",
            "Lcom/amazonaws/services/kms/model/ListResourceTagsResult;"
        }
    .end annotation

    .line 127
    .local p1, "tags":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/kms/model/Tag;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->setTags(Ljava/util/Collection;)V

    .line 128
    return-object p0
.end method

.method public varargs withTags([Lcom/amazonaws/services/kms/model/Tag;)Lcom/amazonaws/services/kms/model/ListResourceTagsResult;
    .locals 4
    .param p1, "tags"    # [Lcom/amazonaws/services/kms/model/Tag;

    .line 102
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->getTags()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 103
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->tags:Ljava/util/List;

    .line 105
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    .line 106
    .local v2, "value":Lcom/amazonaws/services/kms/model/Tag;
    iget-object v3, p0, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->tags:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 105
    .end local v2    # "value":Lcom/amazonaws/services/kms/model/Tag;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 108
    :cond_1
    return-object p0
.end method

.method public withTruncated(Ljava/lang/Boolean;)Lcom/amazonaws/services/kms/model/ListResourceTagsResult;
    .locals 0
    .param p1, "truncated"    # Ljava/lang/Boolean;

    .line 300
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ListResourceTagsResult;->truncated:Ljava/lang/Boolean;

    .line 301
    return-object p0
.end method
