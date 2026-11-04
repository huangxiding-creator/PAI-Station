.class public Lcom/amazonaws/services/s3/model/SetBucketNotificationConfigurationRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "SetBucketNotificationConfigurationRequest.java"


# instance fields
.field private bucketName:Ljava/lang/String;

.field private notificationConfiguration:Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;


# direct methods
.method public constructor <init>(Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;Ljava/lang/String;)V
    .locals 0
    .param p1, "bucketNotificationConfiguration"    # Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;
    .param p2, "bucket"    # Ljava/lang/String;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 39
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    .line 40
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/SetBucketNotificationConfigurationRequest;->notificationConfiguration:Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;

    .line 41
    iput-object p2, p0, Lcom/amazonaws/services/s3/model/SetBucketNotificationConfigurationRequest;->bucketName:Ljava/lang/String;

    .line 42
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "notificationConfiguration"    # Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;

    .line 55
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    .line 56
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/SetBucketNotificationConfigurationRequest;->bucketName:Ljava/lang/String;

    .line 57
    iput-object p2, p0, Lcom/amazonaws/services/s3/model/SetBucketNotificationConfigurationRequest;->notificationConfiguration:Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;

    .line 58
    return-void
.end method


# virtual methods
.method public getBucket()Ljava/lang/String;
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 123
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/SetBucketNotificationConfigurationRequest;->bucketName:Ljava/lang/String;

    return-object v0
.end method

.method public getBucketName()Ljava/lang/String;
    .locals 1

    .line 135
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/SetBucketNotificationConfigurationRequest;->bucketName:Ljava/lang/String;

    return-object v0
.end method

.method public getBucketNotificationConfiguration()Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 65
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/SetBucketNotificationConfigurationRequest;->notificationConfiguration:Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;

    return-object v0
.end method

.method public getNotificationConfiguration()Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;
    .locals 1

    .line 75
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/SetBucketNotificationConfigurationRequest;->notificationConfiguration:Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;

    return-object v0
.end method

.method public setBucket(Ljava/lang/String;)V
    .locals 0
    .param p1, "bucket"    # Ljava/lang/String;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 143
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/SetBucketNotificationConfigurationRequest;->bucketName:Ljava/lang/String;

    .line 144
    return-void
.end method

.method public setBucketName(Ljava/lang/String;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;

    .line 155
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/SetBucketNotificationConfigurationRequest;->bucketName:Ljava/lang/String;

    .line 156
    return-void
.end method

.method public setBucketNotificationConfiguration(Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;)V
    .locals 0
    .param p1, "bucketNotificationConfiguration"    # Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 86
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/SetBucketNotificationConfigurationRequest;->notificationConfiguration:Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;

    .line 87
    return-void
.end method

.method public setNotificationConfiguration(Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;)V
    .locals 0
    .param p1, "notificationConfiguration"    # Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;

    .line 98
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/SetBucketNotificationConfigurationRequest;->notificationConfiguration:Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;

    .line 99
    return-void
.end method

.method public withBucketName(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/SetBucketNotificationConfigurationRequest;
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;

    .line 171
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/SetBucketNotificationConfigurationRequest;->setBucketName(Ljava/lang/String;)V

    .line 172
    return-object p0
.end method

.method public withNotificationConfiguration(Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;)Lcom/amazonaws/services/s3/model/SetBucketNotificationConfigurationRequest;
    .locals 0
    .param p1, "notificationConfiguration"    # Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;

    .line 114
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/SetBucketNotificationConfigurationRequest;->setNotificationConfiguration(Lcom/amazonaws/services/s3/model/BucketNotificationConfiguration;)V

    .line 115
    return-object p0
.end method
