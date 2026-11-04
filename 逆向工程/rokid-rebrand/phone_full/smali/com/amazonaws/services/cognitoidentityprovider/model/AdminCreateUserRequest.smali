.class public Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "AdminCreateUserRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private clientMetadata:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private desiredDeliveryMediums:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private forceAliasCreation:Ljava/lang/Boolean;

.field private messageAction:Ljava/lang/String;

.field private temporaryPassword:Ljava/lang/String;

.field private userAttributes:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeType;",
            ">;"
        }
    .end annotation
.end field

.field private userPoolId:Ljava/lang/String;

.field private username:Ljava/lang/String;

.field private validationData:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeType;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 48
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public addClientMetadataEntry(Ljava/lang/String;Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;
    .locals 3
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .line 1988
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->clientMetadata:Ljava/util/Map;

    if-nez v0, :cond_0

    .line 1989
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->clientMetadata:Ljava/util/Map;

    .line 1991
    :cond_0
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->clientMetadata:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 1994
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->clientMetadata:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1995
    return-object p0

    .line 1992
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Duplicated keys ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p1}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") are provided."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public clearClientMetadataEntries()Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;
    .locals 1

    .line 2005
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->clientMetadata:Ljava/util/Map;

    .line 2006
    return-object p0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 2070
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 2071
    return v0

    .line 2072
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 2073
    return v1

    .line 2075
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;

    if-nez v2, :cond_2

    .line 2076
    return v1

    .line 2077
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;

    .line 2079
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 2080
    return v1

    .line 2081
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 2082
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 2083
    return v1

    .line 2084
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUsername()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUsername()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 2085
    return v1

    .line 2086
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUsername()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUsername()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUsername()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 2087
    return v1

    .line 2088
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUserAttributes()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUserAttributes()Ljava/util/List;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 2089
    return v1

    .line 2090
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUserAttributes()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 2091
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUserAttributes()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUserAttributes()Ljava/util/List;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 2092
    return v1

    .line 2093
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getValidationData()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getValidationData()Ljava/util/List;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 2094
    return v1

    .line 2095
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getValidationData()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_12

    .line 2096
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getValidationData()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getValidationData()Ljava/util/List;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 2097
    return v1

    .line 2098
    :cond_12
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getTemporaryPassword()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_13

    move v3, v0

    goto :goto_8

    :cond_13
    move v3, v1

    :goto_8
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getTemporaryPassword()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_14

    move v4, v0

    goto :goto_9

    :cond_14
    move v4, v1

    :goto_9
    xor-int/2addr v3, v4

    if-eqz v3, :cond_15

    .line 2099
    return v1

    .line 2100
    :cond_15
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getTemporaryPassword()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_16

    .line 2101
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getTemporaryPassword()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getTemporaryPassword()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_16

    .line 2102
    return v1

    .line 2103
    :cond_16
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getForceAliasCreation()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_17

    move v3, v0

    goto :goto_a

    :cond_17
    move v3, v1

    :goto_a
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getForceAliasCreation()Ljava/lang/Boolean;

    move-result-object v4

    if-nez v4, :cond_18

    move v4, v0

    goto :goto_b

    :cond_18
    move v4, v1

    :goto_b
    xor-int/2addr v3, v4

    if-eqz v3, :cond_19

    .line 2104
    return v1

    .line 2105
    :cond_19
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getForceAliasCreation()Ljava/lang/Boolean;

    move-result-object v3

    if-eqz v3, :cond_1a

    .line 2106
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getForceAliasCreation()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getForceAliasCreation()Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1a

    .line 2107
    return v1

    .line 2108
    :cond_1a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getMessageAction()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1b

    move v3, v0

    goto :goto_c

    :cond_1b
    move v3, v1

    :goto_c
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getMessageAction()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_1c

    move v4, v0

    goto :goto_d

    :cond_1c
    move v4, v1

    :goto_d
    xor-int/2addr v3, v4

    if-eqz v3, :cond_1d

    .line 2109
    return v1

    .line 2110
    :cond_1d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getMessageAction()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_1e

    .line 2111
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getMessageAction()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getMessageAction()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1e

    .line 2112
    return v1

    .line 2113
    :cond_1e
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getDesiredDeliveryMediums()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_1f

    move v3, v0

    goto :goto_e

    :cond_1f
    move v3, v1

    :goto_e
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getDesiredDeliveryMediums()Ljava/util/List;

    move-result-object v4

    if-nez v4, :cond_20

    move v4, v0

    goto :goto_f

    :cond_20
    move v4, v1

    :goto_f
    xor-int/2addr v3, v4

    if-eqz v3, :cond_21

    .line 2114
    return v1

    .line 2115
    :cond_21
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getDesiredDeliveryMediums()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_22

    .line 2116
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getDesiredDeliveryMediums()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getDesiredDeliveryMediums()Ljava/util/List;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_22

    .line 2117
    return v1

    .line 2118
    :cond_22
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v3

    if-nez v3, :cond_23

    move v3, v0

    goto :goto_10

    :cond_23
    move v3, v1

    :goto_10
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v4

    if-nez v4, :cond_24

    move v4, v0

    goto :goto_11

    :cond_24
    move v4, v1

    :goto_11
    xor-int/2addr v3, v4

    if-eqz v3, :cond_25

    .line 2119
    return v1

    .line 2120
    :cond_25
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v3

    if-eqz v3, :cond_26

    .line 2121
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_26

    .line 2122
    return v1

    .line 2123
    :cond_26
    return v0
.end method

.method public getClientMetadata()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 1703
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->clientMetadata:Ljava/util/Map;

    return-object v0
.end method

.method public getDesiredDeliveryMediums()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 1515
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->desiredDeliveryMediums:Ljava/util/List;

    return-object v0
.end method

.method public getForceAliasCreation()Ljava/lang/Boolean;
    .locals 1

    .line 1277
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->forceAliasCreation:Ljava/lang/Boolean;

    return-object v0
.end method

.method public getMessageAction()Ljava/lang/String;
    .locals 1

    .line 1392
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->messageAction:Ljava/lang/String;

    return-object v0
.end method

.method public getTemporaryPassword()Ljava/lang/String;
    .locals 1

    .line 1079
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->temporaryPassword:Ljava/lang/String;

    return-object v0
.end method

.method public getUserAttributes()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeType;",
            ">;"
        }
    .end annotation

    .line 499
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->userAttributes:Ljava/util/List;

    return-object v0
.end method

.method public getUserPoolId()Ljava/lang/String;
    .locals 1

    .line 285
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->userPoolId:Ljava/lang/String;

    return-object v0
.end method

.method public getUsername()Ljava/lang/String;
    .locals 1

    .line 348
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->username:Ljava/lang/String;

    return-object v0
.end method

.method public getValidationData()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeType;",
            ">;"
        }
    .end annotation

    .line 882
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->validationData:Ljava/util/List;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 2044
    const/16 v0, 0x1f

    .line 2045
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 2047
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 2048
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUsername()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUsername()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 2049
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 2050
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUserAttributes()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUserAttributes()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 2051
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 2052
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getValidationData()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v4

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getValidationData()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_3
    add-int/2addr v1, v3

    .line 2053
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 2054
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getTemporaryPassword()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_4

    move v3, v4

    goto :goto_4

    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getTemporaryPassword()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_4
    add-int/2addr v2, v3

    .line 2055
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 2056
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getForceAliasCreation()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_5

    move v3, v4

    goto :goto_5

    :cond_5
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getForceAliasCreation()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Boolean;->hashCode()I

    move-result v3

    :goto_5
    add-int/2addr v1, v3

    .line 2057
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 2058
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getMessageAction()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_6

    move v3, v4

    goto :goto_6

    :cond_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getMessageAction()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_6
    add-int/2addr v2, v3

    .line 2059
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 2061
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getDesiredDeliveryMediums()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v4

    goto :goto_7

    :cond_7
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getDesiredDeliveryMediums()Ljava/util/List;

    move-result-object v3

    .line 2062
    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_7
    add-int/2addr v1, v3

    .line 2063
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 2064
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v3

    if-nez v3, :cond_8

    goto :goto_8

    :cond_8
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v4

    :goto_8
    add-int/2addr v2, v4

    .line 2065
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public isForceAliasCreation()Ljava/lang/Boolean;
    .locals 1

    .line 1235
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->forceAliasCreation:Ljava/lang/Boolean;

    return-object v0
.end method

.method public setClientMetadata(Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 1810
    .local p1, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->clientMetadata:Ljava/util/Map;

    .line 1811
    return-void
.end method

.method public setDesiredDeliveryMediums(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 1534
    .local p1, "desiredDeliveryMediums":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    if-nez p1, :cond_0

    .line 1535
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->desiredDeliveryMediums:Ljava/util/List;

    .line 1536
    return-void

    .line 1539
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->desiredDeliveryMediums:Ljava/util/List;

    .line 1540
    return-void
.end method

.method public setForceAliasCreation(Ljava/lang/Boolean;)V
    .locals 0
    .param p1, "forceAliasCreation"    # Ljava/lang/Boolean;

    .line 1320
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->forceAliasCreation:Ljava/lang/Boolean;

    .line 1321
    return-void
.end method

.method public setMessageAction(Lcom/amazonaws/services/cognitoidentityprovider/model/MessageActionType;)V
    .locals 1
    .param p1, "messageAction"    # Lcom/amazonaws/services/cognitoidentityprovider/model/MessageActionType;

    .line 1467
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/MessageActionType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->messageAction:Ljava/lang/String;

    .line 1468
    return-void
.end method

.method public setMessageAction(Ljava/lang/String;)V
    .locals 0
    .param p1, "messageAction"    # Ljava/lang/String;

    .line 1415
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->messageAction:Ljava/lang/String;

    .line 1416
    return-void
.end method

.method public setTemporaryPassword(Ljava/lang/String;)V
    .locals 0
    .param p1, "temporaryPassword"    # Ljava/lang/String;

    .line 1133
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->temporaryPassword:Ljava/lang/String;

    .line 1134
    return-void
.end method

.method public setUserAttributes(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeType;",
            ">;)V"
        }
    .end annotation

    .line 606
    .local p1, "userAttributes":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeType;>;"
    if-nez p1, :cond_0

    .line 607
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->userAttributes:Ljava/util/List;

    .line 608
    return-void

    .line 611
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->userAttributes:Ljava/util/List;

    .line 612
    return-void
.end method

.method public setUserPoolId(Ljava/lang/String;)V
    .locals 0
    .param p1, "userPoolId"    # Ljava/lang/String;

    .line 303
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->userPoolId:Ljava/lang/String;

    .line 304
    return-void
.end method

.method public setUsername(Ljava/lang/String;)V
    .locals 0
    .param p1, "username"    # Ljava/lang/String;

    .line 369
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->username:Ljava/lang/String;

    .line 370
    return-void
.end method

.method public setValidationData(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeType;",
            ">;)V"
        }
    .end annotation

    .line 922
    .local p1, "validationData":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeType;>;"
    if-nez p1, :cond_0

    .line 923
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->validationData:Ljava/util/List;

    .line 924
    return-void

    .line 927
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->validationData:Ljava/util/List;

    .line 928
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 2018
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 2019
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 2020
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 2021
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "UserPoolId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 2022
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUsername()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 2023
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Username: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUsername()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 2024
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUserAttributes()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 2025
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "UserAttributes: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUserAttributes()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 2026
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getValidationData()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 2027
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ValidationData: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getValidationData()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 2028
    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getTemporaryPassword()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_4

    .line 2029
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "TemporaryPassword: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getTemporaryPassword()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 2030
    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getForceAliasCreation()Ljava/lang/Boolean;

    move-result-object v1

    if-eqz v1, :cond_5

    .line 2031
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ForceAliasCreation: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getForceAliasCreation()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 2032
    :cond_5
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getMessageAction()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_6

    .line 2033
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "MessageAction: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getMessageAction()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 2034
    :cond_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getDesiredDeliveryMediums()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_7

    .line 2035
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "DesiredDeliveryMediums: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getDesiredDeliveryMediums()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 2036
    :cond_7
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v1

    if-eqz v1, :cond_8

    .line 2037
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ClientMetadata: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 2038
    :cond_8
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 2039
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withClientMetadata(Ljava/util/Map;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;"
        }
    .end annotation

    .line 1922
    .local p1, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->clientMetadata:Ljava/util/Map;

    .line 1923
    return-object p0
.end method

.method public withDesiredDeliveryMediums(Ljava/util/Collection;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;"
        }
    .end annotation

    .line 1595
    .local p1, "desiredDeliveryMediums":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->setDesiredDeliveryMediums(Ljava/util/Collection;)V

    .line 1596
    return-object p0
.end method

.method public varargs withDesiredDeliveryMediums([Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;
    .locals 4
    .param p1, "desiredDeliveryMediums"    # [Ljava/lang/String;

    .line 1563
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getDesiredDeliveryMediums()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 1564
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->desiredDeliveryMediums:Ljava/util/List;

    .line 1567
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    .line 1568
    .local v2, "value":Ljava/lang/String;
    iget-object v3, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->desiredDeliveryMediums:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1567
    .end local v2    # "value":Ljava/lang/String;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1570
    :cond_1
    return-object p0
.end method

.method public withForceAliasCreation(Ljava/lang/Boolean;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;
    .locals 0
    .param p1, "forceAliasCreation"    # Ljava/lang/Boolean;

    .line 1368
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->forceAliasCreation:Ljava/lang/Boolean;

    .line 1369
    return-object p0
.end method

.method public withMessageAction(Lcom/amazonaws/services/cognitoidentityprovider/model/MessageActionType;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;
    .locals 1
    .param p1, "messageAction"    # Lcom/amazonaws/services/cognitoidentityprovider/model/MessageActionType;

    .line 1495
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/MessageActionType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->messageAction:Ljava/lang/String;

    .line 1496
    return-object p0
.end method

.method public withMessageAction(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;
    .locals 0
    .param p1, "messageAction"    # Ljava/lang/String;

    .line 1443
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->messageAction:Ljava/lang/String;

    .line 1444
    return-object p0
.end method

.method public withTemporaryPassword(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;
    .locals 0
    .param p1, "temporaryPassword"    # Ljava/lang/String;

    .line 1192
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->temporaryPassword:Ljava/lang/String;

    .line 1193
    return-object p0
.end method

.method public withUserAttributes(Ljava/util/Collection;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeType;",
            ">;)",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;"
        }
    .end annotation

    .line 842
    .local p1, "userAttributes":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeType;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->setUserAttributes(Ljava/util/Collection;)V

    .line 843
    return-object p0
.end method

.method public varargs withUserAttributes([Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeType;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;
    .locals 4
    .param p1, "userAttributes"    # [Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeType;

    .line 723
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getUserAttributes()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 724
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->userAttributes:Ljava/util/List;

    .line 726
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    .line 727
    .local v2, "value":Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeType;
    iget-object v3, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->userAttributes:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 726
    .end local v2    # "value":Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeType;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 729
    :cond_1
    return-object p0
.end method

.method public withUserPoolId(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;
    .locals 0
    .param p1, "userPoolId"    # Ljava/lang/String;

    .line 326
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->userPoolId:Ljava/lang/String;

    .line 327
    return-object p0
.end method

.method public withUsername(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;
    .locals 0
    .param p1, "username"    # Ljava/lang/String;

    .line 395
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->username:Ljava/lang/String;

    .line 396
    return-object p0
.end method

.method public withValidationData(Ljava/util/Collection;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeType;",
            ">;)",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;"
        }
    .end annotation

    .line 1024
    .local p1, "validationData":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeType;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->setValidationData(Ljava/util/Collection;)V

    .line 1025
    return-object p0
.end method

.method public varargs withValidationData([Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeType;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;
    .locals 4
    .param p1, "validationData"    # [Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeType;

    .line 972
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->getValidationData()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 973
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->validationData:Ljava/util/List;

    .line 975
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    .line 976
    .local v2, "value":Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeType;
    iget-object v3, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminCreateUserRequest;->validationData:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 975
    .end local v2    # "value":Lcom/amazonaws/services/cognitoidentityprovider/model/AttributeType;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 978
    :cond_1
    return-object p0
.end method
