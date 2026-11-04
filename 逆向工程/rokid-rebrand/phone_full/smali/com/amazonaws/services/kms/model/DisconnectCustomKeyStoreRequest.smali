.class public Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "DisconnectCustomKeyStoreRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private customKeyStoreId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 97
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 206
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 207
    return v0

    .line 208
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 209
    return v1

    .line 211
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;

    if-nez v2, :cond_2

    .line 212
    return v1

    .line 213
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;

    .line 215
    .local v2, "other":Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;->getCustomKeyStoreId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;->getCustomKeyStoreId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 216
    return v1

    .line 217
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;->getCustomKeyStoreId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 218
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;->getCustomKeyStoreId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;->getCustomKeyStoreId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 219
    return v1

    .line 220
    :cond_6
    return v0
.end method

.method public getCustomKeyStoreId()Ljava/lang/String;
    .locals 1

    .line 128
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;->customKeyStoreId:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 4

    .line 196
    const/16 v0, 0x1f

    .line 197
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 199
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 200
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;->getCustomKeyStoreId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_0

    const/4 v3, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;->getCustomKeyStoreId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 201
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    return v2
.end method

.method public setCustomKeyStoreId(Ljava/lang/String;)V
    .locals 0
    .param p1, "customKeyStoreId"    # Ljava/lang/String;

    .line 148
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;->customKeyStoreId:Ljava/lang/String;

    .line 149
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 186
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 187
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 188
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;->getCustomKeyStoreId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 189
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "CustomKeyStoreId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;->getCustomKeyStoreId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 190
    :cond_0
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 191
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withCustomKeyStoreId(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;
    .locals 0
    .param p1, "customKeyStoreId"    # Ljava/lang/String;

    .line 173
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/DisconnectCustomKeyStoreRequest;->customKeyStoreId:Ljava/lang/String;

    .line 174
    return-object p0
.end method
