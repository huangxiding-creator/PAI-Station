.class abstract Lcom/amazonaws/services/s3/model/transform/AbstractSSEHandler;
.super Lcom/amazonaws/services/s3/model/transform/AbstractHandler;
.source "AbstractSSEHandler.java"

# interfaces
.implements Lcom/amazonaws/services/s3/internal/ServerSideEncryptionResult;


# direct methods
.method constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Lcom/amazonaws/services/s3/model/transform/AbstractHandler;-><init>()V

    return-void
.end method


# virtual methods
.method public final getSSEAlgorithm()Ljava/lang/String;
    .locals 2

    .line 33
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/transform/AbstractSSEHandler;->sseResult()Lcom/amazonaws/services/s3/internal/ServerSideEncryptionResult;

    move-result-object v0

    .line 34
    .local v0, "result":Lcom/amazonaws/services/s3/internal/ServerSideEncryptionResult;
    if-nez v0, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    invoke-interface {v0}, Lcom/amazonaws/services/s3/internal/ServerSideEncryptionResult;->getSSEAlgorithm()Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1
.end method

.method public final getSSECustomerAlgorithm()Ljava/lang/String;
    .locals 2

    .line 47
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/transform/AbstractSSEHandler;->sseResult()Lcom/amazonaws/services/s3/internal/ServerSideEncryptionResult;

    move-result-object v0

    .line 48
    .local v0, "result":Lcom/amazonaws/services/s3/internal/ServerSideEncryptionResult;
    if-nez v0, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    invoke-interface {v0}, Lcom/amazonaws/services/s3/internal/ServerSideEncryptionResult;->getSSECustomerAlgorithm()Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1
.end method

.method public final getSSECustomerKeyMd5()Ljava/lang/String;
    .locals 2

    .line 61
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/transform/AbstractSSEHandler;->sseResult()Lcom/amazonaws/services/s3/internal/ServerSideEncryptionResult;

    move-result-object v0

    .line 62
    .local v0, "result":Lcom/amazonaws/services/s3/internal/ServerSideEncryptionResult;
    if-nez v0, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    invoke-interface {v0}, Lcom/amazonaws/services/s3/internal/ServerSideEncryptionResult;->getSSECustomerKeyMd5()Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1
.end method

.method public final setSSEAlgorithm(Ljava/lang/String;)V
    .locals 1
    .param p1, "serverSideEncryption"    # Ljava/lang/String;

    .line 39
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/transform/AbstractSSEHandler;->sseResult()Lcom/amazonaws/services/s3/internal/ServerSideEncryptionResult;

    move-result-object v0

    .line 40
    .local v0, "result":Lcom/amazonaws/services/s3/internal/ServerSideEncryptionResult;
    if-eqz v0, :cond_0

    .line 41
    invoke-interface {v0, p1}, Lcom/amazonaws/services/s3/internal/ServerSideEncryptionResult;->setSSEAlgorithm(Ljava/lang/String;)V

    .line 43
    :cond_0
    return-void
.end method

.method public final setSSECustomerAlgorithm(Ljava/lang/String;)V
    .locals 1
    .param p1, "algorithm"    # Ljava/lang/String;

    .line 53
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/transform/AbstractSSEHandler;->sseResult()Lcom/amazonaws/services/s3/internal/ServerSideEncryptionResult;

    move-result-object v0

    .line 54
    .local v0, "result":Lcom/amazonaws/services/s3/internal/ServerSideEncryptionResult;
    if-eqz v0, :cond_0

    .line 55
    invoke-interface {v0, p1}, Lcom/amazonaws/services/s3/internal/ServerSideEncryptionResult;->setSSECustomerAlgorithm(Ljava/lang/String;)V

    .line 57
    :cond_0
    return-void
.end method

.method public final setSSECustomerKeyMd5(Ljava/lang/String;)V
    .locals 1
    .param p1, "md5Digest"    # Ljava/lang/String;

    .line 67
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/model/transform/AbstractSSEHandler;->sseResult()Lcom/amazonaws/services/s3/internal/ServerSideEncryptionResult;

    move-result-object v0

    .line 68
    .local v0, "result":Lcom/amazonaws/services/s3/internal/ServerSideEncryptionResult;
    if-eqz v0, :cond_0

    .line 69
    invoke-interface {v0, p1}, Lcom/amazonaws/services/s3/internal/ServerSideEncryptionResult;->setSSECustomerKeyMd5(Ljava/lang/String;)V

    .line 71
    :cond_0
    return-void
.end method

.method protected abstract sseResult()Lcom/amazonaws/services/s3/internal/ServerSideEncryptionResult;
.end method
