.class public Lcom/amazonaws/services/s3/model/SetBucketReplicationConfigurationRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "SetBucketReplicationConfigurationRequest.java"


# instance fields
.field private bucketName:Ljava/lang/String;

.field private replicationConfiguration:Lcom/amazonaws/services/s3/model/BucketReplicationConfiguration;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 36
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    .line 37
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Lcom/amazonaws/services/s3/model/BucketReplicationConfiguration;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "replicationConfiguration"    # Lcom/amazonaws/services/s3/model/BucketReplicationConfiguration;

    .line 48
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    .line 49
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/SetBucketReplicationConfigurationRequest;->bucketName:Ljava/lang/String;

    .line 50
    iput-object p2, p0, Lcom/amazonaws/services/s3/model/SetBucketReplicationConfigurationRequest;->replicationConfiguration:Lcom/amazonaws/services/s3/model/BucketReplicationConfiguration;

    .line 51
    return-void
.end method


# virtual methods
.method public getBucketName()Ljava/lang/String;
    .locals 1

    .line 57
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/SetBucketReplicationConfigurationRequest;->bucketName:Ljava/lang/String;

    return-object v0
.end method

.method public getReplicationConfiguration()Lcom/amazonaws/services/s3/model/BucketReplicationConfiguration;
    .locals 1

    .line 91
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/SetBucketReplicationConfigurationRequest;->replicationConfiguration:Lcom/amazonaws/services/s3/model/BucketReplicationConfiguration;

    return-object v0
.end method

.method public setBucketName(Ljava/lang/String;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;

    .line 67
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/SetBucketReplicationConfigurationRequest;->bucketName:Ljava/lang/String;

    .line 68
    return-void
.end method

.method public setReplicationConfiguration(Lcom/amazonaws/services/s3/model/BucketReplicationConfiguration;)V
    .locals 0
    .param p1, "replicationConfiguration"    # Lcom/amazonaws/services/s3/model/BucketReplicationConfiguration;

    .line 102
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/SetBucketReplicationConfigurationRequest;->replicationConfiguration:Lcom/amazonaws/services/s3/model/BucketReplicationConfiguration;

    .line 103
    return-void
.end method

.method public withBucketName(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/SetBucketReplicationConfigurationRequest;
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;

    .line 81
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/SetBucketReplicationConfigurationRequest;->setBucketName(Ljava/lang/String;)V

    .line 82
    return-object p0
.end method

.method public withReplicationConfiguration(Lcom/amazonaws/services/s3/model/BucketReplicationConfiguration;)Lcom/amazonaws/services/s3/model/SetBucketReplicationConfigurationRequest;
    .locals 0
    .param p1, "replicationConfiguration"    # Lcom/amazonaws/services/s3/model/BucketReplicationConfiguration;

    .line 116
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/SetBucketReplicationConfigurationRequest;->setReplicationConfiguration(Lcom/amazonaws/services/s3/model/BucketReplicationConfiguration;)V

    .line 117
    return-object p0
.end method
