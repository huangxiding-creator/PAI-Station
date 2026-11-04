.class public Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "ScheduleKeyDeletionRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private keyId:Ljava/lang/String;

.field private pendingWindowInDays:Ljava/lang/Integer;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 88
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 455
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 456
    return v0

    .line 457
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 458
    return v1

    .line 460
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;

    if-nez v2, :cond_2

    .line 461
    return v1

    .line 462
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;

    .line 464
    .local v2, "other":Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->getKeyId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 465
    return v1

    .line 466
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->getKeyId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 467
    return v1

    .line 468
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->getPendingWindowInDays()Ljava/lang/Integer;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->getPendingWindowInDays()Ljava/lang/Integer;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 469
    return v1

    .line 470
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->getPendingWindowInDays()Ljava/lang/Integer;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 471
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->getPendingWindowInDays()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->getPendingWindowInDays()Ljava/lang/Integer;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Integer;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 472
    return v1

    .line 473
    :cond_a
    return v0
.end method

.method public getKeyId()Ljava/lang/String;
    .locals 1

    .line 196
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->keyId:Ljava/lang/String;

    return-object v0
.end method

.method public getPendingWindowInDays()Ljava/lang/Integer;
    .locals 1

    .line 358
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->pendingWindowInDays:Ljava/lang/Integer;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 444
    const/16 v0, 0x1f

    .line 445
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 447
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 448
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 449
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->getPendingWindowInDays()Ljava/lang/Integer;

    move-result-object v3

    if-nez v3, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->getPendingWindowInDays()Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Integer;->hashCode()I

    move-result v4

    :goto_1
    add-int/2addr v1, v4

    .line 450
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setKeyId(Ljava/lang/String;)V
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 260
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->keyId:Ljava/lang/String;

    .line 261
    return-void
.end method

.method public setPendingWindowInDays(Ljava/lang/Integer;)V
    .locals 0
    .param p1, "pendingWindowInDays"    # Ljava/lang/Integer;

    .line 386
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->pendingWindowInDays:Ljava/lang/Integer;

    .line 387
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 432
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 433
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 434
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->getKeyId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 435
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "KeyId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->getKeyId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 436
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->getPendingWindowInDays()Ljava/lang/Integer;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 437
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "PendingWindowInDays: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->getPendingWindowInDays()Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 438
    :cond_1
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 439
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withKeyId(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 329
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->keyId:Ljava/lang/String;

    .line 330
    return-object p0
.end method

.method public withPendingWindowInDays(Ljava/lang/Integer;)Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;
    .locals 0
    .param p1, "pendingWindowInDays"    # Ljava/lang/Integer;

    .line 419
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionRequest;->pendingWindowInDays:Ljava/lang/Integer;

    .line 420
    return-object p0
.end method
