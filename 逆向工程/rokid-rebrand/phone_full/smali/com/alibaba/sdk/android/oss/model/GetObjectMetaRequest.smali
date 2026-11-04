.class public Lcom/alibaba/sdk/android/oss/model/GetObjectMetaRequest;
.super Lcom/alibaba/sdk/android/oss/model/OSSRequest;
.source "GetObjectMetaRequest.java"


# instance fields
.field private bucketName:Ljava/lang/String;

.field private objectKey:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "objectKey"    # Ljava/lang/String;

    .line 9
    invoke-direct {p0}, Lcom/alibaba/sdk/android/oss/model/OSSRequest;-><init>()V

    .line 10
    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/oss/model/GetObjectMetaRequest;->setBucketName(Ljava/lang/String;)V

    .line 11
    invoke-virtual {p0, p2}, Lcom/alibaba/sdk/android/oss/model/GetObjectMetaRequest;->setObjectKey(Ljava/lang/String;)V

    .line 12
    return-void
.end method


# virtual methods
.method public getBucketName()Ljava/lang/String;
    .locals 1

    .line 15
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/model/GetObjectMetaRequest;->bucketName:Ljava/lang/String;

    return-object v0
.end method

.method public getObjectKey()Ljava/lang/String;
    .locals 1

    .line 23
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/model/GetObjectMetaRequest;->objectKey:Ljava/lang/String;

    return-object v0
.end method

.method public setBucketName(Ljava/lang/String;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;

    .line 19
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/model/GetObjectMetaRequest;->bucketName:Ljava/lang/String;

    .line 20
    return-void
.end method

.method public setObjectKey(Ljava/lang/String;)V
    .locals 0
    .param p1, "objectKey"    # Ljava/lang/String;

    .line 27
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/model/GetObjectMetaRequest;->objectKey:Ljava/lang/String;

    .line 28
    return-void
.end method
