.class public Lcom/alibaba/sdk/android/oss/model/GetObjectACLRequest;
.super Lcom/alibaba/sdk/android/oss/model/OSSRequest;
.source "GetObjectACLRequest.java"


# instance fields
.field private bucketName:Ljava/lang/String;

.field private objectKey:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "objectKey"    # Ljava/lang/String;

    .line 17
    invoke-direct {p0}, Lcom/alibaba/sdk/android/oss/model/OSSRequest;-><init>()V

    .line 18
    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/oss/model/GetObjectACLRequest;->setBucketName(Ljava/lang/String;)V

    .line 19
    invoke-virtual {p0, p2}, Lcom/alibaba/sdk/android/oss/model/GetObjectACLRequest;->setObjectKey(Ljava/lang/String;)V

    .line 20
    return-void
.end method


# virtual methods
.method public getBucketName()Ljava/lang/String;
    .locals 1

    .line 28
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/model/GetObjectACLRequest;->bucketName:Ljava/lang/String;

    return-object v0
.end method

.method public getObjectKey()Ljava/lang/String;
    .locals 1

    .line 46
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/model/GetObjectACLRequest;->objectKey:Ljava/lang/String;

    return-object v0
.end method

.method public setBucketName(Ljava/lang/String;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;

    .line 37
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/model/GetObjectACLRequest;->bucketName:Ljava/lang/String;

    .line 38
    return-void
.end method

.method public setObjectKey(Ljava/lang/String;)V
    .locals 0
    .param p1, "objectKey"    # Ljava/lang/String;

    .line 55
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/model/GetObjectACLRequest;->objectKey:Ljava/lang/String;

    .line 56
    return-void
.end method
