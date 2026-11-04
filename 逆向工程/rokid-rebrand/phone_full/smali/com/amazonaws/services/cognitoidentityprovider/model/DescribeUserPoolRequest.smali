.class public Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "DescribeUserPoolRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private userPoolId:Ljava/lang/String;


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

    .line 125
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 126
    return v0

    .line 127
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 128
    return v1

    .line 130
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;

    if-nez v2, :cond_2

    .line 131
    return v1

    .line 132
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;

    .line 134
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 135
    return v1

    .line 136
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 137
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 138
    return v1

    .line 139
    :cond_6
    return v0
.end method

.method public getUserPoolId()Ljava/lang/String;
    .locals 1

    .line 54
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;->userPoolId:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 4

    .line 116
    const/16 v0, 0x1f

    .line 117
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 119
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_0

    const/4 v3, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 120
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    return v2
.end method

.method public setUserPoolId(Ljava/lang/String;)V
    .locals 0
    .param p1, "userPoolId"    # Ljava/lang/String;

    .line 71
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;->userPoolId:Ljava/lang/String;

    .line 72
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 106
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 107
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 108
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 109
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "UserPoolId: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 110
    :cond_0
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 111
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withUserPoolId(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;
    .locals 0
    .param p1, "userPoolId"    # Ljava/lang/String;

    .line 93
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolRequest;->userPoolId:Ljava/lang/String;

    .line 94
    return-object p0
.end method
