.class public Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "AdminRespondToAuthChallengeRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private analyticsMetadata:Lcom/amazonaws/services/cognitoidentityprovider/model/AnalyticsMetadataType;

.field private challengeName:Ljava/lang/String;

.field private challengeResponses:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private clientId:Ljava/lang/String;

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

.field private contextData:Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;

.field private session:Ljava/lang/String;

.field private userPoolId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 30
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public addChallengeResponsesEntry(Ljava/lang/String;Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;
    .locals 3
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .line 797
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->challengeResponses:Ljava/util/Map;

    if-nez v0, :cond_0

    .line 798
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->challengeResponses:Ljava/util/Map;

    .line 800
    :cond_0
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->challengeResponses:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 803
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->challengeResponses:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 804
    return-object p0

    .line 801
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

.method public addClientMetadataEntry(Ljava/lang/String;Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;
    .locals 3
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .line 1432
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->clientMetadata:Ljava/util/Map;

    if-nez v0, :cond_0

    .line 1433
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->clientMetadata:Ljava/util/Map;

    .line 1435
    :cond_0
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->clientMetadata:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 1438
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->clientMetadata:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1439
    return-object p0

    .line 1436
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

.method public clearChallengeResponsesEntries()Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;
    .locals 1

    .line 814
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->challengeResponses:Ljava/util/Map;

    .line 815
    return-object p0
.end method

.method public clearClientMetadataEntries()Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;
    .locals 1

    .line 1449
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->clientMetadata:Ljava/util/Map;

    .line 1450
    return-object p0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 1507
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 1508
    return v0

    .line 1509
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 1510
    return v1

    .line 1512
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;

    if-nez v2, :cond_2

    .line 1513
    return v1

    .line 1514
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;

    .line 1516
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 1517
    return v1

    .line 1518
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 1519
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 1520
    return v1

    .line 1521
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getClientId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getClientId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 1522
    return v1

    .line 1523
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getClientId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getClientId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getClientId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 1524
    return v1

    .line 1525
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getChallengeName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getChallengeName()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 1526
    return v1

    .line 1527
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getChallengeName()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 1528
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getChallengeName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getChallengeName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 1529
    return v1

    .line 1530
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getChallengeResponses()Ljava/util/Map;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getChallengeResponses()Ljava/util/Map;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 1531
    return v1

    .line 1532
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getChallengeResponses()Ljava/util/Map;

    move-result-object v3

    if-eqz v3, :cond_12

    .line 1533
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getChallengeResponses()Ljava/util/Map;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getChallengeResponses()Ljava/util/Map;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 1534
    return v1

    .line 1535
    :cond_12
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getSession()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_13

    move v3, v0

    goto :goto_8

    :cond_13
    move v3, v1

    :goto_8
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getSession()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_14

    move v4, v0

    goto :goto_9

    :cond_14
    move v4, v1

    :goto_9
    xor-int/2addr v3, v4

    if-eqz v3, :cond_15

    .line 1536
    return v1

    .line 1537
    :cond_15
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getSession()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_16

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getSession()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getSession()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_16

    .line 1538
    return v1

    .line 1539
    :cond_16
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getAnalyticsMetadata()Lcom/amazonaws/services/cognitoidentityprovider/model/AnalyticsMetadataType;

    move-result-object v3

    if-nez v3, :cond_17

    move v3, v0

    goto :goto_a

    :cond_17
    move v3, v1

    :goto_a
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getAnalyticsMetadata()Lcom/amazonaws/services/cognitoidentityprovider/model/AnalyticsMetadataType;

    move-result-object v4

    if-nez v4, :cond_18

    move v4, v0

    goto :goto_b

    :cond_18
    move v4, v1

    :goto_b
    xor-int/2addr v3, v4

    if-eqz v3, :cond_19

    .line 1540
    return v1

    .line 1541
    :cond_19
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getAnalyticsMetadata()Lcom/amazonaws/services/cognitoidentityprovider/model/AnalyticsMetadataType;

    move-result-object v3

    if-eqz v3, :cond_1a

    .line 1542
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getAnalyticsMetadata()Lcom/amazonaws/services/cognitoidentityprovider/model/AnalyticsMetadataType;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getAnalyticsMetadata()Lcom/amazonaws/services/cognitoidentityprovider/model/AnalyticsMetadataType;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/AnalyticsMetadataType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1a

    .line 1543
    return v1

    .line 1544
    :cond_1a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getContextData()Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;

    move-result-object v3

    if-nez v3, :cond_1b

    move v3, v0

    goto :goto_c

    :cond_1b
    move v3, v1

    :goto_c
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getContextData()Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;

    move-result-object v4

    if-nez v4, :cond_1c

    move v4, v0

    goto :goto_d

    :cond_1c
    move v4, v1

    :goto_d
    xor-int/2addr v3, v4

    if-eqz v3, :cond_1d

    .line 1545
    return v1

    .line 1546
    :cond_1d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getContextData()Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;

    move-result-object v3

    if-eqz v3, :cond_1e

    .line 1547
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getContextData()Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getContextData()Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1e

    .line 1548
    return v1

    .line 1549
    :cond_1e
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v3

    if-nez v3, :cond_1f

    move v3, v0

    goto :goto_e

    :cond_1f
    move v3, v1

    :goto_e
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v4

    if-nez v4, :cond_20

    move v4, v0

    goto :goto_f

    :cond_20
    move v4, v1

    :goto_f
    xor-int/2addr v3, v4

    if-eqz v3, :cond_21

    .line 1550
    return v1

    .line 1551
    :cond_21
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v3

    if-eqz v3, :cond_22

    .line 1552
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_22

    .line 1553
    return v1

    .line 1554
    :cond_22
    return v0
.end method

.method public getAnalyticsMetadata()Lcom/amazonaws/services/cognitoidentityprovider/model/AnalyticsMetadataType;
    .locals 1

    .line 919
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->analyticsMetadata:Lcom/amazonaws/services/cognitoidentityprovider/model/AnalyticsMetadataType;

    return-object v0
.end method

.method public getChallengeName()Ljava/lang/String;
    .locals 1

    .line 337
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->challengeName:Ljava/lang/String;

    return-object v0
.end method

.method public getChallengeResponses()Ljava/util/Map;
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

    .line 537
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->challengeResponses:Ljava/util/Map;

    return-object v0
.end method

.method public getClientId()Ljava/lang/String;
    .locals 1

    .line 274
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->clientId:Ljava/lang/String;

    return-object v0
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

    .line 1127
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->clientMetadata:Ljava/util/Map;

    return-object v0
.end method

.method public getContextData()Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;
    .locals 1

    .line 973
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->contextData:Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;

    return-object v0
.end method

.method public getSession()Ljava/lang/String;
    .locals 1

    .line 842
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->session:Ljava/lang/String;

    return-object v0
.end method

.method public getUserPoolId()Ljava/lang/String;
    .locals 1

    .line 217
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->userPoolId:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 1486
    const/16 v0, 0x1f

    .line 1487
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 1489
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 1490
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getClientId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getClientId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 1491
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 1492
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getChallengeName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getChallengeName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 1493
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 1494
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getChallengeResponses()Ljava/util/Map;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v4

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getChallengeResponses()Ljava/util/Map;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_3
    add-int/2addr v1, v3

    .line 1495
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getSession()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_4

    move v3, v4

    goto :goto_4

    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getSession()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_4
    add-int/2addr v2, v3

    .line 1496
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 1497
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getAnalyticsMetadata()Lcom/amazonaws/services/cognitoidentityprovider/model/AnalyticsMetadataType;

    move-result-object v3

    if-nez v3, :cond_5

    move v3, v4

    goto :goto_5

    :cond_5
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getAnalyticsMetadata()Lcom/amazonaws/services/cognitoidentityprovider/model/AnalyticsMetadataType;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/AnalyticsMetadataType;->hashCode()I

    move-result v3

    :goto_5
    add-int/2addr v1, v3

    .line 1498
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 1499
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getContextData()Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;

    move-result-object v3

    if-nez v3, :cond_6

    move v3, v4

    goto :goto_6

    :cond_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getContextData()Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;->hashCode()I

    move-result v3

    :goto_6
    add-int/2addr v2, v3

    .line 1500
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 1501
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v3

    if-nez v3, :cond_7

    goto :goto_7

    :cond_7
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v4

    :goto_7
    add-int/2addr v1, v4

    .line 1502
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setAnalyticsMetadata(Lcom/amazonaws/services/cognitoidentityprovider/model/AnalyticsMetadataType;)V
    .locals 0
    .param p1, "analyticsMetadata"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AnalyticsMetadataType;

    .line 934
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->analyticsMetadata:Lcom/amazonaws/services/cognitoidentityprovider/model/AnalyticsMetadataType;

    .line 935
    return-void
.end method

.method public setChallengeName(Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;)V
    .locals 1
    .param p1, "challengeName"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    .line 412
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->challengeName:Ljava/lang/String;

    .line 413
    return-void
.end method

.method public setChallengeName(Ljava/lang/String;)V
    .locals 0
    .param p1, "challengeName"    # Ljava/lang/String;

    .line 360
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->challengeName:Ljava/lang/String;

    .line 361
    return-void
.end method

.method public setChallengeResponses(Ljava/util/Map;)V
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

    .line 634
    .local p1, "challengeResponses":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->challengeResponses:Ljava/util/Map;

    .line 635
    return-void
.end method

.method public setClientId(Ljava/lang/String;)V
    .locals 0
    .param p1, "clientId"    # Ljava/lang/String;

    .line 291
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->clientId:Ljava/lang/String;

    .line 292
    return-void
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

    .line 1242
    .local p1, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->clientMetadata:Ljava/util/Map;

    .line 1243
    return-void
.end method

.method public setContextData(Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;)V
    .locals 0
    .param p1, "contextData"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;

    .line 990
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->contextData:Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;

    .line 991
    return-void
.end method

.method public setSession(Ljava/lang/String;)V
    .locals 0
    .param p1, "session"    # Ljava/lang/String;

    .line 870
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->session:Ljava/lang/String;

    .line 871
    return-void
.end method

.method public setUserPoolId(Ljava/lang/String;)V
    .locals 0
    .param p1, "userPoolId"    # Ljava/lang/String;

    .line 234
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->userPoolId:Ljava/lang/String;

    .line 235
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 1462
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 1463
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1464
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 1465
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "UserPoolId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1466
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getClientId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 1467
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ClientId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getClientId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1468
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getChallengeName()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 1469
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ChallengeName: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getChallengeName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1470
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getChallengeResponses()Ljava/util/Map;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 1471
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ChallengeResponses: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getChallengeResponses()Ljava/util/Map;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1472
    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getSession()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_4

    .line 1473
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Session: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getSession()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1474
    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getAnalyticsMetadata()Lcom/amazonaws/services/cognitoidentityprovider/model/AnalyticsMetadataType;

    move-result-object v1

    if-eqz v1, :cond_5

    .line 1475
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "AnalyticsMetadata: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getAnalyticsMetadata()Lcom/amazonaws/services/cognitoidentityprovider/model/AnalyticsMetadataType;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1476
    :cond_5
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getContextData()Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;

    move-result-object v1

    if-eqz v1, :cond_6

    .line 1477
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ContextData: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getContextData()Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1478
    :cond_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v1

    if-eqz v1, :cond_7

    .line 1479
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "ClientMetadata: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->getClientMetadata()Ljava/util/Map;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1480
    :cond_7
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1481
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withAnalyticsMetadata(Lcom/amazonaws/services/cognitoidentityprovider/model/AnalyticsMetadataType;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;
    .locals 0
    .param p1, "analyticsMetadata"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AnalyticsMetadataType;

    .line 955
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->analyticsMetadata:Lcom/amazonaws/services/cognitoidentityprovider/model/AnalyticsMetadataType;

    .line 956
    return-object p0
.end method

.method public withChallengeName(Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;
    .locals 1
    .param p1, "challengeName"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;

    .line 440
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeNameType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->challengeName:Ljava/lang/String;

    .line 441
    return-object p0
.end method

.method public withChallengeName(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;
    .locals 0
    .param p1, "challengeName"    # Ljava/lang/String;

    .line 388
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->challengeName:Ljava/lang/String;

    .line 389
    return-object p0
.end method

.method public withChallengeResponses(Ljava/util/Map;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;"
        }
    .end annotation

    .line 737
    .local p1, "challengeResponses":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->challengeResponses:Ljava/util/Map;

    .line 738
    return-object p0
.end method

.method public withClientId(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;
    .locals 0
    .param p1, "clientId"    # Ljava/lang/String;

    .line 313
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->clientId:Ljava/lang/String;

    .line 314
    return-object p0
.end method

.method public withClientMetadata(Ljava/util/Map;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;"
        }
    .end annotation

    .line 1363
    .local p1, "clientMetadata":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->clientMetadata:Ljava/util/Map;

    .line 1364
    return-object p0
.end method

.method public withContextData(Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;
    .locals 0
    .param p1, "contextData"    # Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;

    .line 1012
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->contextData:Lcom/amazonaws/services/cognitoidentityprovider/model/ContextDataType;

    .line 1013
    return-object p0
.end method

.method public withSession(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;
    .locals 0
    .param p1, "session"    # Ljava/lang/String;

    .line 903
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->session:Ljava/lang/String;

    .line 904
    return-object p0
.end method

.method public withUserPoolId(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;
    .locals 0
    .param p1, "userPoolId"    # Ljava/lang/String;

    .line 256
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AdminRespondToAuthChallengeRequest;->userPoolId:Ljava/lang/String;

    .line 257
    return-object p0
.end method
