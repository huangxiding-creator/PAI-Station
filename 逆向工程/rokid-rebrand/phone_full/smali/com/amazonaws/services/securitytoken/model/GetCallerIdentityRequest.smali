.class public Lcom/amazonaws/services/securitytoken/model/GetCallerIdentityRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "GetCallerIdentityRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 41
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 3
    .param p1, "obj"    # Ljava/lang/Object;

    .line 67
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 68
    return v0

    .line 69
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 70
    return v1

    .line 72
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/securitytoken/model/GetCallerIdentityRequest;

    if-nez v2, :cond_2

    .line 73
    return v1

    .line 74
    :cond_2
    move-object v1, p1

    check-cast v1, Lcom/amazonaws/services/securitytoken/model/GetCallerIdentityRequest;

    .line 76
    .local v1, "other":Lcom/amazonaws/services/securitytoken/model/GetCallerIdentityRequest;
    return v0
.end method

.method public hashCode()I
    .locals 2

    .line 59
    const/16 v0, 0x1f

    .line 60
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 62
    .local v1, "hashCode":I
    return v1
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 51
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 52
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 53
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 54
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method
