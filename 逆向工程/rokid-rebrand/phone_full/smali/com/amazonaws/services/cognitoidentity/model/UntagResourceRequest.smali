.class public Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "UntagResourceRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private resourceArn:Ljava/lang/String;

.field private tagKeys:Ljava/util/List;
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

    .line 28
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
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;

    if-nez v2, :cond_2

    .line 212
    return v1

    .line 213
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;

    .line 215
    .local v2, "other":Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->getResourceArn()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->getResourceArn()Ljava/lang/String;

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
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->getResourceArn()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 218
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->getResourceArn()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->getResourceArn()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 219
    return v1

    .line 220
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->getTagKeys()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->getTagKeys()Ljava/util/List;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 221
    return v1

    .line 222
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->getTagKeys()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_a

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->getTagKeys()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->getTagKeys()Ljava/util/List;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 223
    return v1

    .line 224
    :cond_a
    return v0
.end method

.method public getResourceArn()Ljava/lang/String;
    .locals 1

    .line 59
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->resourceArn:Ljava/lang/String;

    return-object v0
.end method

.method public getTagKeys()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 110
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->tagKeys:Ljava/util/List;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 195
    const/16 v0, 0x1f

    .line 196
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 198
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 199
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->getResourceArn()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->getResourceArn()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 200
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->getTagKeys()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->getTagKeys()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v4

    :goto_1
    add-int/2addr v1, v4

    .line 201
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setResourceArn(Ljava/lang/String;)V
    .locals 0
    .param p1, "resourceArn"    # Ljava/lang/String;

    .line 75
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->resourceArn:Ljava/lang/String;

    .line 76
    return-void
.end method

.method public setTagKeys(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 123
    .local p1, "tagKeys":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    if-nez p1, :cond_0

    .line 124
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->tagKeys:Ljava/util/List;

    .line 125
    return-void

    .line 128
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->tagKeys:Ljava/util/List;

    .line 129
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 183
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 184
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 185
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->getResourceArn()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 186
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ResourceArn: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->getResourceArn()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 187
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->getTagKeys()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 188
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "TagKeys: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->getTagKeys()Ljava/util/List;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 189
    :cond_1
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 190
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withResourceArn(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;
    .locals 0
    .param p1, "resourceArn"    # Ljava/lang/String;

    .line 96
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->resourceArn:Ljava/lang/String;

    .line 97
    return-object p0
.end method

.method public withTagKeys(Ljava/util/Collection;)Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;"
        }
    .end annotation

    .line 170
    .local p1, "tagKeys":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->setTagKeys(Ljava/util/Collection;)V

    .line 171
    return-object p0
.end method

.method public varargs withTagKeys([Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;
    .locals 4
    .param p1, "tagKeys"    # [Ljava/lang/String;

    .line 146
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->getTagKeys()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 147
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->tagKeys:Ljava/util/List;

    .line 149
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    .line 150
    .local v2, "value":Ljava/lang/String;
    iget-object v3, p0, Lcom/amazonaws/services/cognitoidentity/model/UntagResourceRequest;->tagKeys:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 149
    .end local v2    # "value":Ljava/lang/String;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 152
    :cond_1
    return-object p0
.end method
