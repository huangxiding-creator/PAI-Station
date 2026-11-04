.class public Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;
.super Ljava/lang/Object;
.source "DescribeUserPoolDomainResult.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private domainDescription:Lcom/amazonaws/services/cognitoidentityprovider/model/DomainDescriptionType;


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

    .line 106
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 107
    return v0

    .line 108
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 109
    return v1

    .line 111
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;

    if-nez v2, :cond_2

    .line 112
    return v1

    .line 113
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;

    .line 115
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;->getDomainDescription()Lcom/amazonaws/services/cognitoidentityprovider/model/DomainDescriptionType;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;->getDomainDescription()Lcom/amazonaws/services/cognitoidentityprovider/model/DomainDescriptionType;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 116
    return v1

    .line 117
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;->getDomainDescription()Lcom/amazonaws/services/cognitoidentityprovider/model/DomainDescriptionType;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 118
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;->getDomainDescription()Lcom/amazonaws/services/cognitoidentityprovider/model/DomainDescriptionType;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;->getDomainDescription()Lcom/amazonaws/services/cognitoidentityprovider/model/DomainDescriptionType;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/DomainDescriptionType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 119
    return v1

    .line 120
    :cond_6
    return v0
.end method

.method public getDomainDescription()Lcom/amazonaws/services/cognitoidentityprovider/model/DomainDescriptionType;
    .locals 1

    .line 39
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;->domainDescription:Lcom/amazonaws/services/cognitoidentityprovider/model/DomainDescriptionType;

    return-object v0
.end method

.method public hashCode()I
    .locals 4

    .line 96
    const/16 v0, 0x1f

    .line 97
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 99
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 100
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;->getDomainDescription()Lcom/amazonaws/services/cognitoidentityprovider/model/DomainDescriptionType;

    move-result-object v3

    if-nez v3, :cond_0

    const/4 v3, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;->getDomainDescription()Lcom/amazonaws/services/cognitoidentityprovider/model/DomainDescriptionType;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/DomainDescriptionType;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 101
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    return v2
.end method

.method public setDomainDescription(Lcom/amazonaws/services/cognitoidentityprovider/model/DomainDescriptionType;)V
    .locals 0
    .param p1, "domainDescription"    # Lcom/amazonaws/services/cognitoidentityprovider/model/DomainDescriptionType;

    .line 53
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;->domainDescription:Lcom/amazonaws/services/cognitoidentityprovider/model/DomainDescriptionType;

    .line 54
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 86
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 87
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 88
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;->getDomainDescription()Lcom/amazonaws/services/cognitoidentityprovider/model/DomainDescriptionType;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 89
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "DomainDescription: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;->getDomainDescription()Lcom/amazonaws/services/cognitoidentityprovider/model/DomainDescriptionType;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 90
    :cond_0
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 91
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withDomainDescription(Lcom/amazonaws/services/cognitoidentityprovider/model/DomainDescriptionType;)Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;
    .locals 0
    .param p1, "domainDescription"    # Lcom/amazonaws/services/cognitoidentityprovider/model/DomainDescriptionType;

    .line 73
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/DescribeUserPoolDomainResult;->domainDescription:Lcom/amazonaws/services/cognitoidentityprovider/model/DomainDescriptionType;

    .line 74
    return-object p0
.end method
