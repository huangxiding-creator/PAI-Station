.class public Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmSignUpResult;
.super Ljava/lang/Object;
.source "ConfirmSignUpResult.java"

# interfaces
.implements Ljava/io/Serializable;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 3
    .param p1, "obj"    # Ljava/lang/Object;

    .line 51
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 52
    return v0

    .line 53
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 54
    return v1

    .line 56
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmSignUpResult;

    if-nez v2, :cond_2

    .line 57
    return v1

    .line 58
    :cond_2
    move-object v1, p1

    check-cast v1, Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmSignUpResult;

    .line 60
    .local v1, "other":Lcom/amazonaws/services/cognitoidentityprovider/model/ConfirmSignUpResult;
    return v0
.end method

.method public hashCode()I
    .locals 2

    .line 43
    const/16 v0, 0x1f

    .line 44
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 46
    .local v1, "hashCode":I
    return v1
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 35
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 36
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 37
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 38
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method
