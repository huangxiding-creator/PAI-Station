.class public Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;
.super Ljava/lang/Object;
.source "ScheduleKeyDeletionResult.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private deletionDate:Ljava/util/Date;

.field private keyId:Ljava/lang/String;


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

    .line 190
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 191
    return v0

    .line 192
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 193
    return v1

    .line 195
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;

    if-nez v2, :cond_2

    .line 196
    return v1

    .line 197
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;

    .line 199
    .local v2, "other":Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->getKeyId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 200
    return v1

    .line 201
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->getKeyId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 202
    return v1

    .line 203
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->getDeletionDate()Ljava/util/Date;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->getDeletionDate()Ljava/util/Date;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 204
    return v1

    .line 205
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->getDeletionDate()Ljava/util/Date;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 206
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->getDeletionDate()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->getDeletionDate()Ljava/util/Date;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/Date;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 207
    return v1

    .line 208
    :cond_a
    return v0
.end method

.method public getDeletionDate()Ljava/util/Date;
    .locals 1

    .line 119
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->deletionDate:Ljava/util/Date;

    return-object v0
.end method

.method public getKeyId()Ljava/lang/String;
    .locals 1

    .line 58
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->keyId:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 179
    const/16 v0, 0x1f

    .line 180
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 182
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 183
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 184
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->getDeletionDate()Ljava/util/Date;

    move-result-object v3

    if-nez v3, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->getDeletionDate()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/Date;->hashCode()I

    move-result v4

    :goto_1
    add-int/2addr v1, v4

    .line 185
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setDeletionDate(Ljava/util/Date;)V
    .locals 0
    .param p1, "deletionDate"    # Ljava/util/Date;

    .line 134
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->deletionDate:Ljava/util/Date;

    .line 135
    return-void
.end method

.method public setKeyId(Ljava/lang/String;)V
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 78
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->keyId:Ljava/lang/String;

    .line 79
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 167
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 168
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 169
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->getKeyId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 170
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "KeyId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->getKeyId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 171
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->getDeletionDate()Ljava/util/Date;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 172
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "DeletionDate: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->getDeletionDate()Ljava/util/Date;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 173
    :cond_1
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 174
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withDeletionDate(Ljava/util/Date;)Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;
    .locals 0
    .param p1, "deletionDate"    # Ljava/util/Date;

    .line 154
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->deletionDate:Ljava/util/Date;

    .line 155
    return-object p0
.end method

.method public withKeyId(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 103
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/ScheduleKeyDeletionResult;->keyId:Ljava/lang/String;

    .line 104
    return-object p0
.end method
