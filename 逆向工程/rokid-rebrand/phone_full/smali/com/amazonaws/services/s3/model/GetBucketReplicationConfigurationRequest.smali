.class public Lcom/amazonaws/services/s3/model/GetBucketReplicationConfigurationRequest;
.super Lcom/amazonaws/services/s3/model/GenericBucketRequest;
.source "GetBucketReplicationConfigurationRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;

    .line 39
    invoke-direct {p0, p1}, Lcom/amazonaws/services/s3/model/GenericBucketRequest;-><init>(Ljava/lang/String;)V

    .line 40
    return-void
.end method
