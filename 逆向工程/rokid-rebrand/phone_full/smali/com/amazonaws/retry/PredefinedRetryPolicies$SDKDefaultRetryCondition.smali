.class public Lcom/amazonaws/retry/PredefinedRetryPolicies$SDKDefaultRetryCondition;
.super Ljava/lang/Object;
.source "PredefinedRetryPolicies.java"

# interfaces
.implements Lcom/amazonaws/retry/RetryPolicy$RetryCondition;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/amazonaws/retry/PredefinedRetryPolicies;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "SDKDefaultRetryCondition"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 151
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public shouldRetry(Lcom/amazonaws/AmazonWebServiceRequest;Lcom/amazonaws/AmazonClientException;I)Z
    .locals 4
    .param p1, "originalRequest"    # Lcom/amazonaws/AmazonWebServiceRequest;
    .param p2, "exception"    # Lcom/amazonaws/AmazonClientException;
    .param p3, "retriesAttempted"    # I

    .line 160
    invoke-virtual {p2}, Lcom/amazonaws/AmazonClientException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    instance-of v0, v0, Ljava/io/IOException;

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    .line 161
    invoke-virtual {p2}, Lcom/amazonaws/AmazonClientException;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    instance-of v0, v0, Ljava/io/InterruptedIOException;

    if-nez v0, :cond_0

    .line 162
    return v1

    .line 165
    :cond_0
    instance-of v0, p2, Lcom/amazonaws/AmazonServiceException;

    if-eqz v0, :cond_4

    .line 166
    move-object v0, p2

    check-cast v0, Lcom/amazonaws/AmazonServiceException;

    .line 174
    .local v0, "ase":Lcom/amazonaws/AmazonServiceException;
    invoke-virtual {v0}, Lcom/amazonaws/AmazonServiceException;->getStatusCode()I

    move-result v2

    .line 175
    .local v2, "statusCode":I
    const/16 v3, 0x1f4

    if-eq v2, v3, :cond_3

    const/16 v3, 0x1f7

    if-eq v2, v3, :cond_3

    const/16 v3, 0x1f6

    if-eq v2, v3, :cond_3

    const/16 v3, 0x1f8

    if-ne v2, v3, :cond_1

    goto :goto_0

    .line 188
    :cond_1
    invoke-static {v0}, Lcom/amazonaws/retry/RetryUtils;->isThrottlingException(Lcom/amazonaws/AmazonServiceException;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 189
    return v1

    .line 196
    :cond_2
    invoke-static {v0}, Lcom/amazonaws/retry/RetryUtils;->isClockSkewError(Lcom/amazonaws/AmazonServiceException;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 197
    return v1

    .line 179
    :cond_3
    :goto_0
    return v1

    .line 200
    .end local v0    # "ase":Lcom/amazonaws/AmazonServiceException;
    .end local v2    # "statusCode":I
    :cond_4
    const/4 v0, 0x0

    return v0
.end method
