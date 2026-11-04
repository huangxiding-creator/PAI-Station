.class public Lio/minio/errors/BucketPolicyTooLargeException;
.super Lio/minio/errors/MinioException;
.source "BucketPolicyTooLargeException.java"


# static fields
.field private static final serialVersionUID:J = -0x3fb11cd9761fa5a1L


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 2
    .param p1, "bucketName"    # Ljava/lang/String;

    .line 25
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Bucket policy is larger than 20KiB size for bucket "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lio/minio/errors/MinioException;-><init>(Ljava/lang/String;)V

    .line 26
    return-void
.end method
