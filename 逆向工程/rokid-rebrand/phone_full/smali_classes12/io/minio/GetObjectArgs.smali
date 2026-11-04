.class public Lio/minio/GetObjectArgs;
.super Lio/minio/ObjectConditionalReadArgs;
.source "GetObjectArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/GetObjectArgs$Builder;
    }
.end annotation


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 21
    invoke-direct {p0}, Lio/minio/ObjectConditionalReadArgs;-><init>()V

    return-void
.end method

.method public constructor <init>(Lio/minio/DownloadObjectArgs;)V
    .locals 1
    .param p1, "args"    # Lio/minio/DownloadObjectArgs;

    .line 23
    invoke-direct {p0}, Lio/minio/ObjectConditionalReadArgs;-><init>()V

    .line 24
    iget-object v0, p1, Lio/minio/DownloadObjectArgs;->extraHeaders:Lcom/google/common/collect/Multimap;

    iput-object v0, p0, Lio/minio/GetObjectArgs;->extraHeaders:Lcom/google/common/collect/Multimap;

    .line 25
    iget-object v0, p1, Lio/minio/DownloadObjectArgs;->extraQueryParams:Lcom/google/common/collect/Multimap;

    iput-object v0, p0, Lio/minio/GetObjectArgs;->extraQueryParams:Lcom/google/common/collect/Multimap;

    .line 26
    iget-object v0, p1, Lio/minio/DownloadObjectArgs;->bucketName:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/GetObjectArgs;->bucketName:Ljava/lang/String;

    .line 27
    iget-object v0, p1, Lio/minio/DownloadObjectArgs;->region:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/GetObjectArgs;->region:Ljava/lang/String;

    .line 28
    iget-object v0, p1, Lio/minio/DownloadObjectArgs;->objectName:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/GetObjectArgs;->objectName:Ljava/lang/String;

    .line 29
    iget-object v0, p1, Lio/minio/DownloadObjectArgs;->versionId:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/GetObjectArgs;->versionId:Ljava/lang/String;

    .line 30
    iget-object v0, p1, Lio/minio/DownloadObjectArgs;->ssec:Lio/minio/ServerSideEncryptionCustomerKey;

    iput-object v0, p0, Lio/minio/GetObjectArgs;->ssec:Lio/minio/ServerSideEncryptionCustomerKey;

    .line 31
    return-void
.end method

.method public static builder()Lio/minio/GetObjectArgs$Builder;
    .locals 1

    .line 34
    new-instance v0, Lio/minio/GetObjectArgs$Builder;

    invoke-direct {v0}, Lio/minio/GetObjectArgs$Builder;-><init>()V

    return-object v0
.end method
