.class public Lcom/amazonaws/auth/policy/resources/S3ObjectResource;
.super Lcom/amazonaws/auth/policy/Resource;
.source "S3ObjectResource.java"


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "keyPattern"    # Ljava/lang/String;

    .line 74
    const-string v0, "aws"

    invoke-direct {p0, v0, p1, p2}, Lcom/amazonaws/auth/policy/resources/S3ObjectResource;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 75
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "partitionName"    # Ljava/lang/String;
    .param p2, "bucketName"    # Ljava/lang/String;
    .param p3, "keyPattern"    # Ljava/lang/String;

    .line 94
    const-string v0, "arn:%s:s3:::%s/%s"

    filled-new-array {p1, p2, p3}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/amazonaws/auth/policy/Resource;-><init>(Ljava/lang/String;)V

    .line 95
    return-void
.end method
