.class public Lcom/amazonaws/services/s3/model/Tag;
.super Ljava/lang/Object;
.source "Tag.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private key:Ljava/lang/String;

.field private value:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/Tag;->key:Ljava/lang/String;

    .line 34
    iput-object p2, p0, Lcom/amazonaws/services/s3/model/Tag;->value:Ljava/lang/String;

    .line 35
    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 93
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 94
    return v0

    .line 96
    :cond_0
    const/4 v1, 0x0

    if-eqz p1, :cond_6

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    if-eq v2, v3, :cond_1

    goto :goto_2

    .line 100
    :cond_1
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/s3/model/Tag;

    .line 102
    .local v2, "tag":Lcom/amazonaws/services/s3/model/Tag;
    iget-object v3, p0, Lcom/amazonaws/services/s3/model/Tag;->key:Ljava/lang/String;

    if-eqz v3, :cond_2

    iget-object v3, p0, Lcom/amazonaws/services/s3/model/Tag;->key:Ljava/lang/String;

    iget-object v4, v2, Lcom/amazonaws/services/s3/model/Tag;->key:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    goto :goto_0

    :cond_2
    iget-object v3, v2, Lcom/amazonaws/services/s3/model/Tag;->key:Ljava/lang/String;

    if-eqz v3, :cond_3

    .line 103
    :goto_0
    return v1

    .line 105
    :cond_3
    iget-object v3, p0, Lcom/amazonaws/services/s3/model/Tag;->value:Ljava/lang/String;

    if-eqz v3, :cond_4

    iget-object v0, p0, Lcom/amazonaws/services/s3/model/Tag;->value:Ljava/lang/String;

    iget-object v1, v2, Lcom/amazonaws/services/s3/model/Tag;->value:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    goto :goto_1

    :cond_4
    iget-object v3, v2, Lcom/amazonaws/services/s3/model/Tag;->value:Ljava/lang/String;

    if-nez v3, :cond_5

    goto :goto_1

    :cond_5
    move v0, v1

    :goto_1
    return v0

    .line 97
    .end local v2    # "tag":Lcom/amazonaws/services/s3/model/Tag;
    :cond_6
    :goto_2
    return v1
.end method

.method public getKey()Ljava/lang/String;
    .locals 1

    .line 41
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/Tag;->key:Ljava/lang/String;

    return-object v0
.end method

.method public getValue()Ljava/lang/String;
    .locals 1

    .line 68
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/Tag;->value:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 4

    .line 111
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/Tag;->key:Ljava/lang/String;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/amazonaws/services/s3/model/Tag;->key:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    goto :goto_0

    :cond_0
    move v0, v1

    .line 112
    .local v0, "result":I
    :goto_0
    mul-int/lit8 v2, v0, 0x1f

    iget-object v3, p0, Lcom/amazonaws/services/s3/model/Tag;->value:Ljava/lang/String;

    if-eqz v3, :cond_1

    iget-object v1, p0, Lcom/amazonaws/services/s3/model/Tag;->value:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    :cond_1
    add-int/2addr v2, v1

    .line 113
    .end local v0    # "result":I
    .local v2, "result":I
    return v2
.end method

.method public setKey(Ljava/lang/String;)V
    .locals 0
    .param p1, "key"    # Ljava/lang/String;

    .line 50
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/Tag;->key:Ljava/lang/String;

    .line 51
    return-void
.end method

.method public setValue(Ljava/lang/String;)V
    .locals 0
    .param p1, "value"    # Ljava/lang/String;

    .line 77
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/Tag;->value:Ljava/lang/String;

    .line 78
    return-void
.end method

.method public withKey(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/Tag;
    .locals 0
    .param p1, "key"    # Ljava/lang/String;

    .line 60
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/Tag;->setKey(Ljava/lang/String;)V

    .line 61
    return-object p0
.end method

.method public withValue(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/Tag;
    .locals 0
    .param p1, "value"    # Ljava/lang/String;

    .line 87
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/Tag;->setValue(Ljava/lang/String;)V

    .line 88
    return-object p0
.end method
