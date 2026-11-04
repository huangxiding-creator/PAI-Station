.class public Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "UpdateAuthEventFeedbackRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private eventId:Ljava/lang/String;

.field private feedbackToken:Ljava/lang/String;

.field private feedbackValue:Ljava/lang/String;

.field private userPoolId:Ljava/lang/String;

.field private username:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 29
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 447
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 448
    return v0

    .line 449
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 450
    return v1

    .line 452
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;

    if-nez v2, :cond_2

    .line 453
    return v1

    .line 454
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;

    .line 456
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 457
    return v1

    .line 458
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    .line 459
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 460
    return v1

    .line 461
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getUsername()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getUsername()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 462
    return v1

    .line 463
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getUsername()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getUsername()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getUsername()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 464
    return v1

    .line 465
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getEventId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getEventId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 466
    return v1

    .line 467
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getEventId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getEventId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getEventId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 468
    return v1

    .line 469
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getFeedbackToken()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getFeedbackToken()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 470
    return v1

    .line 471
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getFeedbackToken()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_12

    .line 472
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getFeedbackToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getFeedbackToken()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 473
    return v1

    .line 474
    :cond_12
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getFeedbackValue()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_13

    move v3, v0

    goto :goto_8

    :cond_13
    move v3, v1

    :goto_8
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getFeedbackValue()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_14

    move v4, v0

    goto :goto_9

    :cond_14
    move v4, v1

    :goto_9
    xor-int/2addr v3, v4

    if-eqz v3, :cond_15

    .line 475
    return v1

    .line 476
    :cond_15
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getFeedbackValue()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_16

    .line 477
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getFeedbackValue()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getFeedbackValue()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_16

    .line 478
    return v1

    .line 479
    :cond_16
    return v0
.end method

.method public getEventId()Ljava/lang/String;
    .locals 1

    .line 211
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->eventId:Ljava/lang/String;

    return-object v0
.end method

.method public getFeedbackToken()Ljava/lang/String;
    .locals 1

    .line 267
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->feedbackToken:Ljava/lang/String;

    return-object v0
.end method

.method public getFeedbackValue()Ljava/lang/String;
    .locals 1

    .line 322
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->feedbackValue:Ljava/lang/String;

    return-object v0
.end method

.method public getUserPoolId()Ljava/lang/String;
    .locals 1

    .line 97
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->userPoolId:Ljava/lang/String;

    return-object v0
.end method

.method public getUsername()Ljava/lang/String;
    .locals 1

    .line 154
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->username:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 432
    const/16 v0, 0x1f

    .line 433
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 435
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 436
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getUsername()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getUsername()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 437
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getEventId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getEventId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 438
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 439
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getFeedbackToken()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v4

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getFeedbackToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_3
    add-int/2addr v1, v3

    .line 440
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 441
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getFeedbackValue()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_4

    goto :goto_4

    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getFeedbackValue()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_4
    add-int/2addr v2, v4

    .line 442
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public setEventId(Ljava/lang/String;)V
    .locals 0
    .param p1, "eventId"    # Ljava/lang/String;

    .line 228
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->eventId:Ljava/lang/String;

    .line 229
    return-void
.end method

.method public setFeedbackToken(Ljava/lang/String;)V
    .locals 0
    .param p1, "feedbackToken"    # Ljava/lang/String;

    .line 283
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->feedbackToken:Ljava/lang/String;

    .line 284
    return-void
.end method

.method public setFeedbackValue(Lcom/amazonaws/services/cognitoidentityprovider/model/FeedbackValueType;)V
    .locals 1
    .param p1, "feedbackValue"    # Lcom/amazonaws/services/cognitoidentityprovider/model/FeedbackValueType;

    .line 379
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/FeedbackValueType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->feedbackValue:Ljava/lang/String;

    .line 380
    return-void
.end method

.method public setFeedbackValue(Ljava/lang/String;)V
    .locals 0
    .param p1, "feedbackValue"    # Ljava/lang/String;

    .line 339
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->feedbackValue:Ljava/lang/String;

    .line 340
    return-void
.end method

.method public setUserPoolId(Ljava/lang/String;)V
    .locals 0
    .param p1, "userPoolId"    # Ljava/lang/String;

    .line 114
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->userPoolId:Ljava/lang/String;

    .line 115
    return-void
.end method

.method public setUsername(Ljava/lang/String;)V
    .locals 0
    .param p1, "username"    # Ljava/lang/String;

    .line 171
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->username:Ljava/lang/String;

    .line 172
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 414
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 415
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 416
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 417
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "UserPoolId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getUserPoolId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 418
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getUsername()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 419
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Username: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getUsername()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 420
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getEventId()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 421
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "EventId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getEventId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 422
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getFeedbackToken()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 423
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "FeedbackToken: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getFeedbackToken()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 424
    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getFeedbackValue()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_4

    .line 425
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "FeedbackValue: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->getFeedbackValue()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 426
    :cond_4
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 427
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withEventId(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;
    .locals 0
    .param p1, "eventId"    # Ljava/lang/String;

    .line 250
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->eventId:Ljava/lang/String;

    .line 251
    return-object p0
.end method

.method public withFeedbackToken(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;
    .locals 0
    .param p1, "feedbackToken"    # Ljava/lang/String;

    .line 304
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->feedbackToken:Ljava/lang/String;

    .line 305
    return-object p0
.end method

.method public withFeedbackValue(Lcom/amazonaws/services/cognitoidentityprovider/model/FeedbackValueType;)Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;
    .locals 1
    .param p1, "feedbackValue"    # Lcom/amazonaws/services/cognitoidentityprovider/model/FeedbackValueType;

    .line 401
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/FeedbackValueType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->feedbackValue:Ljava/lang/String;

    .line 402
    return-object p0
.end method

.method public withFeedbackValue(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;
    .locals 0
    .param p1, "feedbackValue"    # Ljava/lang/String;

    .line 361
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->feedbackValue:Ljava/lang/String;

    .line 362
    return-object p0
.end method

.method public withUserPoolId(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;
    .locals 0
    .param p1, "userPoolId"    # Ljava/lang/String;

    .line 136
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->userPoolId:Ljava/lang/String;

    .line 137
    return-object p0
.end method

.method public withUsername(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;
    .locals 0
    .param p1, "username"    # Ljava/lang/String;

    .line 193
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/UpdateAuthEventFeedbackRequest;->username:Ljava/lang/String;

    .line 194
    return-object p0
.end method
