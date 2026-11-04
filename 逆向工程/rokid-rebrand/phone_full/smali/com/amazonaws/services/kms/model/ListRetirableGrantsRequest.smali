.class public Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "ListRetirableGrantsRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private limit:Ljava/lang/Integer;

.field private marker:Ljava/lang/String;

.field private retiringPrincipal:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 72
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 458
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 459
    return v0

    .line 460
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 461
    return v1

    .line 463
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;

    if-nez v2, :cond_2

    .line 464
    return v1

    .line 465
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;

    .line 467
    .local v2, "other":Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getLimit()Ljava/lang/Integer;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getLimit()Ljava/lang/Integer;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 468
    return v1

    .line 469
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getLimit()Ljava/lang/Integer;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getLimit()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getLimit()Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Integer;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 470
    return v1

    .line 471
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getMarker()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getMarker()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 472
    return v1

    .line 473
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getMarker()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getMarker()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getMarker()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 474
    return v1

    .line 475
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getRetiringPrincipal()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getRetiringPrincipal()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 476
    return v1

    .line 477
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getRetiringPrincipal()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 478
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getRetiringPrincipal()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getRetiringPrincipal()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 479
    return v1

    .line 480
    :cond_e
    return v0
.end method

.method public getLimit()Ljava/lang/Integer;
    .locals 1

    .line 151
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->limit:Ljava/lang/Integer;

    return-object v0
.end method

.method public getMarker()Ljava/lang/String;
    .locals 1

    .line 239
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->marker:Ljava/lang/String;

    return-object v0
.end method

.method public getRetiringPrincipal()Ljava/lang/String;
    .locals 1

    .line 330
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->retiringPrincipal:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 446
    const/16 v0, 0x1f

    .line 447
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 449
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getLimit()Ljava/lang/Integer;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getLimit()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Integer;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 450
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getMarker()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getMarker()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 451
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 452
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getRetiringPrincipal()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getRetiringPrincipal()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_2
    add-int/2addr v2, v4

    .line 453
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public setLimit(Ljava/lang/Integer;)V
    .locals 0
    .param p1, "limit"    # Ljava/lang/Integer;

    .line 181
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->limit:Ljava/lang/Integer;

    .line 182
    return-void
.end method

.method public setMarker(Ljava/lang/String;)V
    .locals 0
    .param p1, "marker"    # Ljava/lang/String;

    .line 261
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->marker:Ljava/lang/String;

    .line 262
    return-void
.end method

.method public setRetiringPrincipal(Ljava/lang/String;)V
    .locals 0
    .param p1, "retiringPrincipal"    # Ljava/lang/String;

    .line 372
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->retiringPrincipal:Ljava/lang/String;

    .line 373
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 432
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 433
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 434
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getLimit()Ljava/lang/Integer;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 435
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Limit: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getLimit()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 436
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getMarker()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 437
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Marker: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getMarker()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 438
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getRetiringPrincipal()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 439
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "RetiringPrincipal: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->getRetiringPrincipal()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 440
    :cond_2
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 441
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withLimit(Ljava/lang/Integer;)Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;
    .locals 0
    .param p1, "limit"    # Ljava/lang/Integer;

    .line 216
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->limit:Ljava/lang/Integer;

    .line 217
    return-object p0
.end method

.method public withMarker(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;
    .locals 0
    .param p1, "marker"    # Ljava/lang/String;

    .line 288
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->marker:Ljava/lang/String;

    .line 289
    return-object p0
.end method

.method public withRetiringPrincipal(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;
    .locals 0
    .param p1, "retiringPrincipal"    # Ljava/lang/String;

    .line 419
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ListRetirableGrantsRequest;->retiringPrincipal:Ljava/lang/String;

    .line 420
    return-object p0
.end method
