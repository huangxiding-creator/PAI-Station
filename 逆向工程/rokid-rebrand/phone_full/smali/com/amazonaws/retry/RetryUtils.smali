.class public Lcom/amazonaws/retry/RetryUtils;
.super Ljava/lang/Object;
.source "RetryUtils.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static isClockSkewError(Lcom/amazonaws/AmazonServiceException;)Z
    .locals 3
    .param p0, "ase"    # Lcom/amazonaws/AmazonServiceException;

    .line 66
    const/4 v0, 0x0

    if-nez p0, :cond_0

    .line 67
    return v0

    .line 69
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/AmazonServiceException;->getErrorCode()Ljava/lang/String;

    move-result-object v1

    .line 70
    .local v1, "errorCode":Ljava/lang/String;
    const-string v2, "RequestTimeTooSkewed"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 71
    const-string v2, "RequestExpired"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 72
    const-string v2, "InvalidSignatureException"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 73
    const-string v2, "SignatureDoesNotMatch"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    :cond_1
    const/4 v0, 0x1

    .line 70
    :cond_2
    return v0
.end method

.method public static isInterrupted(Ljava/lang/Throwable;)Z
    .locals 3
    .param p0, "error"    # Ljava/lang/Throwable;

    .line 83
    instance-of v0, p0, Lcom/amazonaws/AbortedException;

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    .line 84
    return v1

    .line 86
    :cond_0
    invoke-virtual {p0}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 87
    invoke-virtual {p0}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    .line 94
    .local v0, "cause":Ljava/lang/Throwable;
    instance-of v2, v0, Ljava/lang/InterruptedException;

    if-nez v2, :cond_1

    instance-of v2, v0, Ljava/io/InterruptedIOException;

    if-eqz v2, :cond_2

    instance-of v2, v0, Ljava/net/SocketTimeoutException;

    if-nez v2, :cond_2

    .line 97
    :cond_1
    return v1

    .line 100
    .end local v0    # "cause":Ljava/lang/Throwable;
    :cond_2
    const/4 v0, 0x0

    return v0
.end method

.method public static isRequestEntityTooLargeException(Lcom/amazonaws/AmazonServiceException;)Z
    .locals 2
    .param p0, "ase"    # Lcom/amazonaws/AmazonServiceException;

    .line 53
    if-nez p0, :cond_0

    .line 54
    const/4 v0, 0x0

    return v0

    .line 55
    :cond_0
    const-string v0, "Request entity too large"

    invoke-virtual {p0}, Lcom/amazonaws/AmazonServiceException;->getErrorCode()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static isThrottlingException(Lcom/amazonaws/AmazonServiceException;)Z
    .locals 3
    .param p0, "ase"    # Lcom/amazonaws/AmazonServiceException;

    .line 35
    const/4 v0, 0x0

    if-nez p0, :cond_0

    .line 36
    return v0

    .line 38
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/AmazonServiceException;->getErrorCode()Ljava/lang/String;

    move-result-object v1

    .line 39
    .local v1, "errorCode":Ljava/lang/String;
    const-string v2, "Throttling"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 40
    const-string v2, "ThrottlingException"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 41
    const-string v2, "ProvisionedThroughputExceededException"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    :cond_1
    const/4 v0, 0x1

    .line 39
    :cond_2
    return v0
.end method
