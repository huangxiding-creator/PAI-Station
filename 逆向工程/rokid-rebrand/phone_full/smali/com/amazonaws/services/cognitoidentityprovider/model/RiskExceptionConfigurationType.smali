.class public Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;
.super Ljava/lang/Object;
.source "RiskExceptionConfigurationType.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private blockedIPRangeList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private skippedIPRangeList:Ljava/util/List;
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

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 254
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 255
    return v0

    .line 256
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 257
    return v1

    .line 259
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;

    if-nez v2, :cond_2

    .line 260
    return v1

    .line 261
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;

    .line 263
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->getBlockedIPRangeList()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->getBlockedIPRangeList()Ljava/util/List;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 264
    return v1

    .line 265
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->getBlockedIPRangeList()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 266
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->getBlockedIPRangeList()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->getBlockedIPRangeList()Ljava/util/List;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 267
    return v1

    .line 268
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->getSkippedIPRangeList()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->getSkippedIPRangeList()Ljava/util/List;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 269
    return v1

    .line 270
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->getSkippedIPRangeList()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 271
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->getSkippedIPRangeList()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->getSkippedIPRangeList()Ljava/util/List;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 272
    return v1

    .line 273
    :cond_a
    return v0
.end method

.method public getBlockedIPRangeList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 58
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->blockedIPRangeList:Ljava/util/List;

    return-object v0
.end method

.method public getSkippedIPRangeList()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 150
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->skippedIPRangeList:Ljava/util/List;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 242
    const/16 v0, 0x1f

    .line 243
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 245
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 246
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->getBlockedIPRangeList()Ljava/util/List;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->getBlockedIPRangeList()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 247
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 248
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->getSkippedIPRangeList()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->getSkippedIPRangeList()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v4

    :goto_1
    add-int/2addr v1, v4

    .line 249
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setBlockedIPRangeList(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 76
    .local p1, "blockedIPRangeList":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    if-nez p1, :cond_0

    .line 77
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->blockedIPRangeList:Ljava/util/List;

    .line 78
    return-void

    .line 81
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->blockedIPRangeList:Ljava/util/List;

    .line 82
    return-void
.end method

.method public setSkippedIPRangeList(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 165
    .local p1, "skippedIPRangeList":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    if-nez p1, :cond_0

    .line 166
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->skippedIPRangeList:Ljava/util/List;

    .line 167
    return-void

    .line 170
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->skippedIPRangeList:Ljava/util/List;

    .line 171
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 230
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 231
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 232
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->getBlockedIPRangeList()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 233
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "BlockedIPRangeList: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->getBlockedIPRangeList()Ljava/util/List;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 234
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->getSkippedIPRangeList()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 235
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "SkippedIPRangeList: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->getSkippedIPRangeList()Ljava/util/List;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 236
    :cond_1
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 237
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withBlockedIPRangeList(Ljava/util/Collection;)Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;"
        }
    .end annotation

    .line 134
    .local p1, "blockedIPRangeList":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->setBlockedIPRangeList(Ljava/util/Collection;)V

    .line 135
    return-object p0
.end method

.method public varargs withBlockedIPRangeList([Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;
    .locals 4
    .param p1, "blockedIPRangeList"    # [Ljava/lang/String;

    .line 104
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->getBlockedIPRangeList()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 105
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->blockedIPRangeList:Ljava/util/List;

    .line 107
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    .line 108
    .local v2, "value":Ljava/lang/String;
    iget-object v3, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->blockedIPRangeList:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 107
    .end local v2    # "value":Ljava/lang/String;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 110
    :cond_1
    return-object p0
.end method

.method public withSkippedIPRangeList(Ljava/util/Collection;)Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;"
        }
    .end annotation

    .line 217
    .local p1, "skippedIPRangeList":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->setSkippedIPRangeList(Ljava/util/Collection;)V

    .line 218
    return-object p0
.end method

.method public varargs withSkippedIPRangeList([Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;
    .locals 4
    .param p1, "skippedIPRangeList"    # [Ljava/lang/String;

    .line 190
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->getSkippedIPRangeList()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 191
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->skippedIPRangeList:Ljava/util/List;

    .line 193
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    .line 194
    .local v2, "value":Ljava/lang/String;
    iget-object v3, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/RiskExceptionConfigurationType;->skippedIPRangeList:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 193
    .end local v2    # "value":Ljava/lang/String;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 196
    :cond_1
    return-object p0
.end method
