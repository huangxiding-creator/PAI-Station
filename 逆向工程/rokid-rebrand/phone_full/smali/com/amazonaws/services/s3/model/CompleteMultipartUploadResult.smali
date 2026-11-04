.class public Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;
.super Lcom/amazonaws/services/s3/internal/SSEResultBase;
.source "CompleteMultipartUploadResult.java"

# interfaces
.implements Lcom/amazonaws/services/s3/internal/ObjectExpirationResult;
.implements Lcom/amazonaws/services/s3/internal/S3RequesterChargedResult;
.implements Ljava/io/Serializable;


# instance fields
.field private bucketName:Ljava/lang/String;

.field private eTag:Ljava/lang/String;

.field private expirationTime:Ljava/util/Date;

.field private expirationTimeRuleId:Ljava/lang/String;

.field private isRequesterCharged:Z

.field private key:Ljava/lang/String;

.field private location:Ljava/lang/String;

.field private versionId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 29
    invoke-direct {p0}, Lcom/amazonaws/services/s3/internal/SSEResultBase;-><init>()V

    return-void
.end method


# virtual methods
.method public getBucketName()Ljava/lang/String;
    .locals 1

    .line 89
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;->bucketName:Ljava/lang/String;

    return-object v0
.end method

.method public getETag()Ljava/lang/String;
    .locals 1

    .line 124
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;->eTag:Ljava/lang/String;

    return-object v0
.end method

.method public getExpirationTime()Ljava/util/Date;
    .locals 1

    .line 165
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;->expirationTime:Ljava/util/Date;

    return-object v0
.end method

.method public getExpirationTimeRuleId()Ljava/lang/String;
    .locals 1

    .line 184
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;->expirationTimeRuleId:Ljava/lang/String;

    return-object v0
.end method

.method public getKey()Ljava/lang/String;
    .locals 1

    .line 106
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;->key:Ljava/lang/String;

    return-object v0
.end method

.method public getLocation()Ljava/lang/String;
    .locals 1

    .line 71
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;->location:Ljava/lang/String;

    return-object v0
.end method

.method public getVersionId()Ljava/lang/String;
    .locals 1

    .line 145
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;->versionId:Ljava/lang/String;

    return-object v0
.end method

.method public isRequesterCharged()Z
    .locals 1

    .line 200
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;->isRequesterCharged:Z

    return v0
.end method

.method public setBucketName(Ljava/lang/String;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;

    .line 99
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;->bucketName:Ljava/lang/String;

    .line 100
    return-void
.end method

.method public setETag(Ljava/lang/String;)V
    .locals 0
    .param p1, "etag"    # Ljava/lang/String;

    .line 134
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;->eTag:Ljava/lang/String;

    .line 135
    return-void
.end method

.method public setExpirationTime(Ljava/util/Date;)V
    .locals 0
    .param p1, "expirationTime"    # Ljava/util/Date;

    .line 175
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;->expirationTime:Ljava/util/Date;

    .line 176
    return-void
.end method

.method public setExpirationTimeRuleId(Ljava/lang/String;)V
    .locals 0
    .param p1, "expirationTimeRuleId"    # Ljava/lang/String;

    .line 195
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;->expirationTimeRuleId:Ljava/lang/String;

    .line 196
    return-void
.end method

.method public setKey(Ljava/lang/String;)V
    .locals 0
    .param p1, "key"    # Ljava/lang/String;

    .line 113
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;->key:Ljava/lang/String;

    .line 114
    return-void
.end method

.method public setLocation(Ljava/lang/String;)V
    .locals 0
    .param p1, "location"    # Ljava/lang/String;

    .line 80
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;->location:Ljava/lang/String;

    .line 81
    return-void
.end method

.method public setRequesterCharged(Z)V
    .locals 0
    .param p1, "isRequesterCharged"    # Z

    .line 205
    iput-boolean p1, p0, Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;->isRequesterCharged:Z

    .line 206
    return-void
.end method

.method public setVersionId(Ljava/lang/String;)V
    .locals 0
    .param p1, "versionId"    # Ljava/lang/String;

    .line 156
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/CompleteMultipartUploadResult;->versionId:Ljava/lang/String;

    .line 157
    return-void
.end method
