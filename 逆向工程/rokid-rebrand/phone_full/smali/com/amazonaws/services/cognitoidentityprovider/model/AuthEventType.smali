.class public Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;
.super Ljava/lang/Object;
.source "AuthEventType.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private challengeResponses:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;",
            ">;"
        }
    .end annotation
.end field

.field private creationDate:Ljava/util/Date;

.field private eventContextData:Lcom/amazonaws/services/cognitoidentityprovider/model/EventContextDataType;

.field private eventFeedback:Lcom/amazonaws/services/cognitoidentityprovider/model/EventFeedbackType;

.field private eventId:Ljava/lang/String;

.field private eventResponse:Ljava/lang/String;

.field private eventRisk:Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;

.field private eventType:Ljava/lang/String;


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

    .line 658
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 659
    return v0

    .line 660
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 661
    return v1

    .line 663
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;

    if-nez v2, :cond_2

    .line 664
    return v1

    .line 665
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;

    .line 667
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 668
    return v1

    .line 669
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 670
    return v1

    .line 671
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventType()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventType()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 672
    return v1

    .line 673
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventType()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 674
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventType()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventType()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 675
    return v1

    .line 676
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getCreationDate()Ljava/util/Date;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getCreationDate()Ljava/util/Date;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 677
    return v1

    .line 678
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getCreationDate()Ljava/util/Date;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 679
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getCreationDate()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getCreationDate()Ljava/util/Date;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/util/Date;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 680
    return v1

    .line 681
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventResponse()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventResponse()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 682
    return v1

    .line 683
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventResponse()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_12

    .line 684
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventResponse()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventResponse()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 685
    return v1

    .line 686
    :cond_12
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventRisk()Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;

    move-result-object v3

    if-nez v3, :cond_13

    move v3, v0

    goto :goto_8

    :cond_13
    move v3, v1

    :goto_8
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventRisk()Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;

    move-result-object v4

    if-nez v4, :cond_14

    move v4, v0

    goto :goto_9

    :cond_14
    move v4, v1

    :goto_9
    xor-int/2addr v3, v4

    if-eqz v3, :cond_15

    .line 687
    return v1

    .line 688
    :cond_15
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventRisk()Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;

    move-result-object v3

    if-eqz v3, :cond_16

    .line 689
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventRisk()Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventRisk()Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_16

    .line 690
    return v1

    .line 691
    :cond_16
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getChallengeResponses()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_17

    move v3, v0

    goto :goto_a

    :cond_17
    move v3, v1

    :goto_a
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getChallengeResponses()Ljava/util/List;

    move-result-object v4

    if-nez v4, :cond_18

    move v4, v0

    goto :goto_b

    :cond_18
    move v4, v1

    :goto_b
    xor-int/2addr v3, v4

    if-eqz v3, :cond_19

    .line 692
    return v1

    .line 693
    :cond_19
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getChallengeResponses()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_1a

    .line 694
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getChallengeResponses()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getChallengeResponses()Ljava/util/List;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1a

    .line 695
    return v1

    .line 696
    :cond_1a
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventContextData()Lcom/amazonaws/services/cognitoidentityprovider/model/EventContextDataType;

    move-result-object v3

    if-nez v3, :cond_1b

    move v3, v0

    goto :goto_c

    :cond_1b
    move v3, v1

    :goto_c
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventContextData()Lcom/amazonaws/services/cognitoidentityprovider/model/EventContextDataType;

    move-result-object v4

    if-nez v4, :cond_1c

    move v4, v0

    goto :goto_d

    :cond_1c
    move v4, v1

    :goto_d
    xor-int/2addr v3, v4

    if-eqz v3, :cond_1d

    .line 697
    return v1

    .line 698
    :cond_1d
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventContextData()Lcom/amazonaws/services/cognitoidentityprovider/model/EventContextDataType;

    move-result-object v3

    if-eqz v3, :cond_1e

    .line 699
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventContextData()Lcom/amazonaws/services/cognitoidentityprovider/model/EventContextDataType;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventContextData()Lcom/amazonaws/services/cognitoidentityprovider/model/EventContextDataType;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventContextDataType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1e

    .line 700
    return v1

    .line 701
    :cond_1e
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventFeedback()Lcom/amazonaws/services/cognitoidentityprovider/model/EventFeedbackType;

    move-result-object v3

    if-nez v3, :cond_1f

    move v3, v0

    goto :goto_e

    :cond_1f
    move v3, v1

    :goto_e
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventFeedback()Lcom/amazonaws/services/cognitoidentityprovider/model/EventFeedbackType;

    move-result-object v4

    if-nez v4, :cond_20

    move v4, v0

    goto :goto_f

    :cond_20
    move v4, v1

    :goto_f
    xor-int/2addr v3, v4

    if-eqz v3, :cond_21

    .line 702
    return v1

    .line 703
    :cond_21
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventFeedback()Lcom/amazonaws/services/cognitoidentityprovider/model/EventFeedbackType;

    move-result-object v3

    if-eqz v3, :cond_22

    .line 704
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventFeedback()Lcom/amazonaws/services/cognitoidentityprovider/model/EventFeedbackType;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventFeedback()Lcom/amazonaws/services/cognitoidentityprovider/model/EventFeedbackType;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFeedbackType;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_22

    .line 705
    return v1

    .line 706
    :cond_22
    return v0
.end method

.method public getChallengeResponses()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;",
            ">;"
        }
    .end annotation

    .line 430
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->challengeResponses:Ljava/util/List;

    return-object v0
.end method

.method public getCreationDate()Ljava/util/Date;
    .locals 1

    .line 243
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->creationDate:Ljava/util/Date;

    return-object v0
.end method

.method public getEventContextData()Lcom/amazonaws/services/cognitoidentityprovider/model/EventContextDataType;
    .locals 1

    .line 510
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventContextData:Lcom/amazonaws/services/cognitoidentityprovider/model/EventContextDataType;

    return-object v0
.end method

.method public getEventFeedback()Lcom/amazonaws/services/cognitoidentityprovider/model/EventFeedbackType;
    .locals 1

    .line 565
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventFeedback:Lcom/amazonaws/services/cognitoidentityprovider/model/EventFeedbackType;

    return-object v0
.end method

.method public getEventId()Ljava/lang/String;
    .locals 1

    .line 101
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventId:Ljava/lang/String;

    return-object v0
.end method

.method public getEventResponse()Ljava/lang/String;
    .locals 1

    .line 292
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventResponse:Ljava/lang/String;

    return-object v0
.end method

.method public getEventRisk()Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;
    .locals 1

    .line 385
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventRisk:Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;

    return-object v0
.end method

.method public getEventType()Ljava/lang/String;
    .locals 1

    .line 150
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventType:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 637
    const/16 v0, 0x1f

    .line 638
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 640
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 641
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventType()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventType()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 642
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 643
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getCreationDate()Ljava/util/Date;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getCreationDate()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/Date;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 644
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 645
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventResponse()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v4

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventResponse()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_3
    add-int/2addr v1, v3

    .line 646
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventRisk()Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;

    move-result-object v3

    if-nez v3, :cond_4

    move v3, v4

    goto :goto_4

    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventRisk()Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;->hashCode()I

    move-result v3

    :goto_4
    add-int/2addr v2, v3

    .line 647
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 648
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getChallengeResponses()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_5

    move v3, v4

    goto :goto_5

    :cond_5
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getChallengeResponses()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_5
    add-int/2addr v1, v3

    .line 649
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 650
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventContextData()Lcom/amazonaws/services/cognitoidentityprovider/model/EventContextDataType;

    move-result-object v3

    if-nez v3, :cond_6

    move v3, v4

    goto :goto_6

    :cond_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventContextData()Lcom/amazonaws/services/cognitoidentityprovider/model/EventContextDataType;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventContextDataType;->hashCode()I

    move-result v3

    :goto_6
    add-int/2addr v2, v3

    .line 651
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 652
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventFeedback()Lcom/amazonaws/services/cognitoidentityprovider/model/EventFeedbackType;

    move-result-object v3

    if-nez v3, :cond_7

    goto :goto_7

    :cond_7
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventFeedback()Lcom/amazonaws/services/cognitoidentityprovider/model/EventFeedbackType;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventFeedbackType;->hashCode()I

    move-result v4

    :goto_7
    add-int/2addr v1, v4

    .line 653
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public setChallengeResponses(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;",
            ">;)V"
        }
    .end annotation

    .line 443
    .local p1, "challengeResponses":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;>;"
    if-nez p1, :cond_0

    .line 444
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->challengeResponses:Ljava/util/List;

    .line 445
    return-void

    .line 448
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->challengeResponses:Ljava/util/List;

    .line 449
    return-void
.end method

.method public setCreationDate(Ljava/util/Date;)V
    .locals 0
    .param p1, "creationDate"    # Ljava/util/Date;

    .line 256
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->creationDate:Ljava/util/Date;

    .line 257
    return-void
.end method

.method public setEventContextData(Lcom/amazonaws/services/cognitoidentityprovider/model/EventContextDataType;)V
    .locals 0
    .param p1, "eventContextData"    # Lcom/amazonaws/services/cognitoidentityprovider/model/EventContextDataType;

    .line 527
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventContextData:Lcom/amazonaws/services/cognitoidentityprovider/model/EventContextDataType;

    .line 528
    return-void
.end method

.method public setEventFeedback(Lcom/amazonaws/services/cognitoidentityprovider/model/EventFeedbackType;)V
    .locals 0
    .param p1, "eventFeedback"    # Lcom/amazonaws/services/cognitoidentityprovider/model/EventFeedbackType;

    .line 580
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventFeedback:Lcom/amazonaws/services/cognitoidentityprovider/model/EventFeedbackType;

    .line 581
    return-void
.end method

.method public setEventId(Ljava/lang/String;)V
    .locals 0
    .param p1, "eventId"    # Ljava/lang/String;

    .line 114
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventId:Ljava/lang/String;

    .line 115
    return-void
.end method

.method public setEventResponse(Lcom/amazonaws/services/cognitoidentityprovider/model/EventResponseType;)V
    .locals 1
    .param p1, "eventResponse"    # Lcom/amazonaws/services/cognitoidentityprovider/model/EventResponseType;

    .line 349
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventResponseType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventResponse:Ljava/lang/String;

    .line 350
    return-void
.end method

.method public setEventResponse(Ljava/lang/String;)V
    .locals 0
    .param p1, "eventResponse"    # Ljava/lang/String;

    .line 309
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventResponse:Ljava/lang/String;

    .line 310
    return-void
.end method

.method public setEventRisk(Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;)V
    .locals 0
    .param p1, "eventRisk"    # Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;

    .line 398
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventRisk:Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;

    .line 399
    return-void
.end method

.method public setEventType(Lcom/amazonaws/services/cognitoidentityprovider/model/EventType;)V
    .locals 1
    .param p1, "eventType"    # Lcom/amazonaws/services/cognitoidentityprovider/model/EventType;

    .line 207
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventType:Ljava/lang/String;

    .line 208
    return-void
.end method

.method public setEventType(Ljava/lang/String;)V
    .locals 0
    .param p1, "eventType"    # Ljava/lang/String;

    .line 167
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventType:Ljava/lang/String;

    .line 168
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 613
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 614
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 615
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventId()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 616
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "EventId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 617
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventType()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 618
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "EventType: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventType()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 619
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getCreationDate()Ljava/util/Date;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 620
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "CreationDate: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getCreationDate()Ljava/util/Date;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 621
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventResponse()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 622
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "EventResponse: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventResponse()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 623
    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventRisk()Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;

    move-result-object v1

    if-eqz v1, :cond_4

    .line 624
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "EventRisk: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventRisk()Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 625
    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getChallengeResponses()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_5

    .line 626
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ChallengeResponses: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getChallengeResponses()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 627
    :cond_5
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventContextData()Lcom/amazonaws/services/cognitoidentityprovider/model/EventContextDataType;

    move-result-object v1

    if-eqz v1, :cond_6

    .line 628
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "EventContextData: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventContextData()Lcom/amazonaws/services/cognitoidentityprovider/model/EventContextDataType;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 629
    :cond_6
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventFeedback()Lcom/amazonaws/services/cognitoidentityprovider/model/EventFeedbackType;

    move-result-object v1

    if-eqz v1, :cond_7

    .line 630
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "EventFeedback: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getEventFeedback()Lcom/amazonaws/services/cognitoidentityprovider/model/EventFeedbackType;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 631
    :cond_7
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 632
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withChallengeResponses(Ljava/util/Collection;)Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;",
            ">;)",
            "Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;"
        }
    .end annotation

    .line 492
    .local p1, "challengeResponses":Ljava/util/Collection;, "Ljava/util/Collection<Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->setChallengeResponses(Ljava/util/Collection;)V

    .line 493
    return-object p0
.end method

.method public varargs withChallengeResponses([Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;)Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;
    .locals 4
    .param p1, "challengeResponses"    # [Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;

    .line 466
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->getChallengeResponses()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 467
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->challengeResponses:Ljava/util/List;

    .line 470
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    .line 471
    .local v2, "value":Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;
    iget-object v3, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->challengeResponses:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 470
    .end local v2    # "value":Lcom/amazonaws/services/cognitoidentityprovider/model/ChallengeResponseType;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 473
    :cond_1
    return-object p0
.end method

.method public withCreationDate(Ljava/util/Date;)Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;
    .locals 0
    .param p1, "creationDate"    # Ljava/util/Date;

    .line 274
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->creationDate:Ljava/util/Date;

    .line 275
    return-object p0
.end method

.method public withEventContextData(Lcom/amazonaws/services/cognitoidentityprovider/model/EventContextDataType;)Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;
    .locals 0
    .param p1, "eventContextData"    # Lcom/amazonaws/services/cognitoidentityprovider/model/EventContextDataType;

    .line 549
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventContextData:Lcom/amazonaws/services/cognitoidentityprovider/model/EventContextDataType;

    .line 550
    return-object p0
.end method

.method public withEventFeedback(Lcom/amazonaws/services/cognitoidentityprovider/model/EventFeedbackType;)Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;
    .locals 0
    .param p1, "eventFeedback"    # Lcom/amazonaws/services/cognitoidentityprovider/model/EventFeedbackType;

    .line 600
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventFeedback:Lcom/amazonaws/services/cognitoidentityprovider/model/EventFeedbackType;

    .line 601
    return-object p0
.end method

.method public withEventId(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;
    .locals 0
    .param p1, "eventId"    # Ljava/lang/String;

    .line 132
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventId:Ljava/lang/String;

    .line 133
    return-object p0
.end method

.method public withEventResponse(Lcom/amazonaws/services/cognitoidentityprovider/model/EventResponseType;)Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;
    .locals 1
    .param p1, "eventResponse"    # Lcom/amazonaws/services/cognitoidentityprovider/model/EventResponseType;

    .line 371
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventResponseType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventResponse:Ljava/lang/String;

    .line 372
    return-object p0
.end method

.method public withEventResponse(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;
    .locals 0
    .param p1, "eventResponse"    # Ljava/lang/String;

    .line 331
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventResponse:Ljava/lang/String;

    .line 332
    return-object p0
.end method

.method public withEventRisk(Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;)Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;
    .locals 0
    .param p1, "eventRisk"    # Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;

    .line 416
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventRisk:Lcom/amazonaws/services/cognitoidentityprovider/model/EventRiskType;

    .line 417
    return-object p0
.end method

.method public withEventType(Lcom/amazonaws/services/cognitoidentityprovider/model/EventType;)Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;
    .locals 1
    .param p1, "eventType"    # Lcom/amazonaws/services/cognitoidentityprovider/model/EventType;

    .line 229
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/EventType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventType:Ljava/lang/String;

    .line 230
    return-object p0
.end method

.method public withEventType(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;
    .locals 0
    .param p1, "eventType"    # Ljava/lang/String;

    .line 189
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AuthEventType;->eventType:Ljava/lang/String;

    .line 190
    return-object p0
.end method
