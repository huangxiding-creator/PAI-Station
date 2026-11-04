.class public Lcom/amazonaws/services/s3/model/SetBucketLoggingConfigurationRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "SetBucketLoggingConfigurationRequest.java"


# instance fields
.field private bucketName:Ljava/lang/String;

.field private loggingConfiguration:Lcom/amazonaws/services/s3/model/BucketLoggingConfiguration;


# direct methods
.method public constructor <init>(Ljava/lang/String;Lcom/amazonaws/services/s3/model/BucketLoggingConfiguration;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "loggingConfiguration"    # Lcom/amazonaws/services/s3/model/BucketLoggingConfiguration;

    .line 73
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    .line 74
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/SetBucketLoggingConfigurationRequest;->bucketName:Ljava/lang/String;

    .line 75
    iput-object p2, p0, Lcom/amazonaws/services/s3/model/SetBucketLoggingConfigurationRequest;->loggingConfiguration:Lcom/amazonaws/services/s3/model/BucketLoggingConfiguration;

    .line 76
    return-void
.end method


# virtual methods
.method public getBucketName()Ljava/lang/String;
    .locals 1

    .line 86
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/SetBucketLoggingConfigurationRequest;->bucketName:Ljava/lang/String;

    return-object v0
.end method

.method public getLoggingConfiguration()Lcom/amazonaws/services/s3/model/BucketLoggingConfiguration;
    .locals 1

    .line 126
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/SetBucketLoggingConfigurationRequest;->loggingConfiguration:Lcom/amazonaws/services/s3/model/BucketLoggingConfiguration;

    return-object v0
.end method

.method public setBucketName(Ljava/lang/String;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;

    .line 98
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/SetBucketLoggingConfigurationRequest;->bucketName:Ljava/lang/String;

    .line 99
    return-void
.end method

.method public setLoggingConfiguration(Lcom/amazonaws/services/s3/model/BucketLoggingConfiguration;)V
    .locals 0
    .param p1, "loggingConfiguration"    # Lcom/amazonaws/services/s3/model/BucketLoggingConfiguration;

    .line 138
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/SetBucketLoggingConfigurationRequest;->loggingConfiguration:Lcom/amazonaws/services/s3/model/BucketLoggingConfiguration;

    .line 139
    return-void
.end method

.method public withBucketName(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/SetBucketLoggingConfigurationRequest;
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;

    .line 114
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/SetBucketLoggingConfigurationRequest;->setBucketName(Ljava/lang/String;)V

    .line 115
    return-object p0
.end method

.method public withLoggingConfiguration(Lcom/amazonaws/services/s3/model/BucketLoggingConfiguration;)Lcom/amazonaws/services/s3/model/SetBucketLoggingConfigurationRequest;
    .locals 0
    .param p1, "loggingConfiguration"    # Lcom/amazonaws/services/s3/model/BucketLoggingConfiguration;

    .line 154
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/SetBucketLoggingConfigurationRequest;->setLoggingConfiguration(Lcom/amazonaws/services/s3/model/BucketLoggingConfiguration;)V

    .line 155
    return-object p0
.end method
