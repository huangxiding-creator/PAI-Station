.class public Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;
.super Ljava/lang/Object;
.source "AccountTakeoverActionType.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private eventAction:Ljava/lang/String;

.field private notify:Ljava/lang/Boolean;


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

    .line 498
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 499
    return v0

    .line 500
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 501
    return v1

    .line 503
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    if-nez v2, :cond_2

    .line 504
    return v1

    .line 505
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;

    .line 507
    .local v2, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->getNotify()Ljava/lang/Boolean;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->getNotify()Ljava/lang/Boolean;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 508
    return v1

    .line 509
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->getNotify()Ljava/lang/Boolean;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->getNotify()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->getNotify()Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 510
    return v1

    .line 511
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->getEventAction()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->getEventAction()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 512
    return v1

    .line 513
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->getEventAction()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 514
    invoke-virtual {v2}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->getEventAction()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->getEventAction()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 515
    return v1

    .line 516
    :cond_a
    return v0
.end method

.method public getEventAction()Ljava/lang/String;
    .locals 1

    .line 187
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->eventAction:Ljava/lang/String;

    return-object v0
.end method

.method public getNotify()Ljava/lang/Boolean;
    .locals 1

    .line 90
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->notify:Ljava/lang/Boolean;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 487
    const/16 v0, 0x1f

    .line 488
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 490
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->getNotify()Ljava/lang/Boolean;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->getNotify()Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Boolean;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 491
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 492
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->getEventAction()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->getEventAction()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_1
    add-int/2addr v1, v4

    .line 493
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    return v1
.end method

.method public isNotify()Ljava/lang/Boolean;
    .locals 1

    .line 77
    iget-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->notify:Ljava/lang/Boolean;

    return-object v0
.end method

.method public setEventAction(Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverEventActionType;)V
    .locals 1
    .param p1, "eventAction"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverEventActionType;

    .line 391
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverEventActionType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->eventAction:Ljava/lang/String;

    .line 392
    return-void
.end method

.method public setEventAction(Ljava/lang/String;)V
    .locals 0
    .param p1, "eventAction"    # Ljava/lang/String;

    .line 253
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->eventAction:Ljava/lang/String;

    .line 254
    return-void
.end method

.method public setNotify(Ljava/lang/Boolean;)V
    .locals 0
    .param p1, "notify"    # Ljava/lang/Boolean;

    .line 103
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->notify:Ljava/lang/Boolean;

    .line 104
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 475
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 476
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 477
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->getNotify()Ljava/lang/Boolean;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 478
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Notify: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->getNotify()Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ","

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 479
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->getEventAction()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 480
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "EventAction: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->getEventAction()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 481
    :cond_1
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 482
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withEventAction(Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverEventActionType;)Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;
    .locals 1
    .param p1, "eventAction"    # Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverEventActionType;

    .line 462
    invoke-virtual {p1}, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverEventActionType;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->eventAction:Ljava/lang/String;

    .line 463
    return-object p0
.end method

.method public withEventAction(Ljava/lang/String;)Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;
    .locals 0
    .param p1, "eventAction"    # Ljava/lang/String;

    .line 324
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->eventAction:Ljava/lang/String;

    .line 325
    return-object p0
.end method

.method public withNotify(Ljava/lang/Boolean;)Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;
    .locals 0
    .param p1, "notify"    # Ljava/lang/Boolean;

    .line 121
    iput-object p1, p0, Lcom/amazonaws/services/cognitoidentityprovider/model/AccountTakeoverActionType;->notify:Ljava/lang/Boolean;

    .line 122
    return-object p0
.end method
