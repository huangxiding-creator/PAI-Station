.class public Lcom/amazonaws/services/s3/internal/CompleteMultipartUploadRetryCondition;
.super Ljava/lang/Object;
.source "CompleteMultipartUploadRetryCondition.java"

# interfaces
.implements Lcom/amazonaws/retry/RetryPolicy$RetryCondition;


# static fields
.field private static final ERROR_CODE:Ljava/lang/String; = "InternalError"

.field private static final MAX_RETRY_ATTEMPTS:I = 0x3

.field private static final RETYABLE_ERROR_MESSAGE:Ljava/lang/String; = "Please try again."


# instance fields
.field private final maxCompleteMultipartUploadRetries:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 38
    const/4 v0, 0x3

    invoke-direct {p0, v0}, Lcom/amazonaws/services/s3/internal/CompleteMultipartUploadRetryCondition;-><init>(I)V

    .line 39
    return-void
.end method

.method constructor <init>(I)V
    .locals 0
    .param p1, "maxRetryAttempts"    # I

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 46
    iput p1, p0, Lcom/amazonaws/services/s3/internal/CompleteMultipartUploadRetryCondition;->maxCompleteMultipartUploadRetries:I

    .line 47
    return-void
.end method


# virtual methods
.method public shouldRetry(Lcom/amazonaws/AmazonWebServiceRequest;Lcom/amazonaws/AmazonClientException;I)Z
    .locals 2
    .param p1, "originalRequest"    # Lcom/amazonaws/AmazonWebServiceRequest;
    .param p2, "exception"    # Lcom/amazonaws/AmazonClientException;
    .param p3, "retriesAttempted"    # I

    .line 53
    instance-of v0, p2, Lcom/amazonaws/services/s3/model/AmazonS3Exception;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    .line 54
    move-object v0, p2

    check-cast v0, Lcom/amazonaws/services/s3/model/AmazonS3Exception;

    invoke-virtual {p0, v0}, Lcom/amazonaws/services/s3/internal/CompleteMultipartUploadRetryCondition;->test(Lcom/amazonaws/services/s3/model/AmazonS3Exception;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/amazonaws/services/s3/internal/CompleteMultipartUploadRetryCondition;->maxCompleteMultipartUploadRetries:I

    if-ge p3, v0, :cond_0

    const/4 v1, 0x1

    :cond_0
    return v1

    .line 57
    :cond_1
    return v1
.end method

.method test(Lcom/amazonaws/services/s3/model/AmazonS3Exception;)Z
    .locals 3
    .param p1, "exception"    # Lcom/amazonaws/services/s3/model/AmazonS3Exception;

    .line 61
    const/4 v0, 0x0

    if-eqz p1, :cond_2

    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/AmazonS3Exception;->getErrorCode()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 62
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/AmazonS3Exception;->getErrorMessage()Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_0

    goto :goto_1

    .line 65
    :cond_0
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/AmazonS3Exception;->getErrorCode()Ljava/lang/String;

    move-result-object v1

    const-string v2, "InternalError"

    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 66
    invoke-virtual {p1}, Lcom/amazonaws/services/s3/model/AmazonS3Exception;->getErrorMessage()Ljava/lang/String;

    move-result-object v1

    const-string v2, "Please try again."

    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    nop

    .line 65
    :goto_0
    return v0

    .line 63
    :cond_2
    :goto_1
    return v0
.end method
