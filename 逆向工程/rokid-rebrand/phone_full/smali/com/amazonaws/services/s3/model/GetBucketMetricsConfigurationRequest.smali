.class public Lcom/amazonaws/services/s3/model/GetBucketMetricsConfigurationRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "GetBucketMetricsConfigurationRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private bucketName:Ljava/lang/String;

.field private id:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 28
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    .line 29
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "id"    # Ljava/lang/String;

    .line 31
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    .line 32
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/GetBucketMetricsConfigurationRequest;->bucketName:Ljava/lang/String;

    .line 33
    iput-object p2, p0, Lcom/amazonaws/services/s3/model/GetBucketMetricsConfigurationRequest;->id:Ljava/lang/String;

    .line 34
    return-void
.end method


# virtual methods
.method public getBucketName()Ljava/lang/String;
    .locals 1

    .line 40
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/GetBucketMetricsConfigurationRequest;->bucketName:Ljava/lang/String;

    return-object v0
.end method

.method public getId()Ljava/lang/String;
    .locals 1

    .line 63
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/GetBucketMetricsConfigurationRequest;->id:Ljava/lang/String;

    return-object v0
.end method

.method public setBucketName(Ljava/lang/String;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;

    .line 47
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/GetBucketMetricsConfigurationRequest;->bucketName:Ljava/lang/String;

    .line 48
    return-void
.end method

.method public setId(Ljava/lang/String;)V
    .locals 0
    .param p1, "id"    # Ljava/lang/String;

    .line 70
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/GetBucketMetricsConfigurationRequest;->id:Ljava/lang/String;

    .line 71
    return-void
.end method

.method public withBucketName(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/GetBucketMetricsConfigurationRequest;
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;

    .line 55
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/GetBucketMetricsConfigurationRequest;->setBucketName(Ljava/lang/String;)V

    .line 56
    return-object p0
.end method

.method public withId(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/GetBucketMetricsConfigurationRequest;
    .locals 0
    .param p1, "id"    # Ljava/lang/String;

    .line 78
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/GetBucketMetricsConfigurationRequest;->setId(Ljava/lang/String;)V

    .line 79
    return-object p0
.end method
