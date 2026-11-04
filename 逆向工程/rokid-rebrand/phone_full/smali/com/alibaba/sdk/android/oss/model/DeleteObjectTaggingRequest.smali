.class public Lcom/alibaba/sdk/android/oss/model/DeleteObjectTaggingRequest;
.super Lcom/alibaba/sdk/android/oss/model/OSSRequest;
.source "DeleteObjectTaggingRequest.java"


# instance fields
.field private bucketName:Ljava/lang/String;

.field private objectKey:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "objectKey"    # Ljava/lang/String;

    .line 23
    invoke-direct {p0}, Lcom/alibaba/sdk/android/oss/model/OSSRequest;-><init>()V

    .line 24
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/model/DeleteObjectTaggingRequest;->bucketName:Ljava/lang/String;

    .line 25
    iput-object p2, p0, Lcom/alibaba/sdk/android/oss/model/DeleteObjectTaggingRequest;->objectKey:Ljava/lang/String;

    .line 26
    return-void
.end method


# virtual methods
.method public getBucketName()Ljava/lang/String;
    .locals 1

    .line 8
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/model/DeleteObjectTaggingRequest;->bucketName:Ljava/lang/String;

    return-object v0
.end method

.method public getObjectKey()Ljava/lang/String;
    .locals 1

    .line 16
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/model/DeleteObjectTaggingRequest;->objectKey:Ljava/lang/String;

    return-object v0
.end method

.method public setBucketName(Ljava/lang/String;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;

    .line 12
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/model/DeleteObjectTaggingRequest;->bucketName:Ljava/lang/String;

    .line 13
    return-void
.end method

.method public setObjectKey(Ljava/lang/String;)V
    .locals 0
    .param p1, "objectKey"    # Ljava/lang/String;

    .line 20
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/model/DeleteObjectTaggingRequest;->objectKey:Ljava/lang/String;

    .line 21
    return-void
.end method
