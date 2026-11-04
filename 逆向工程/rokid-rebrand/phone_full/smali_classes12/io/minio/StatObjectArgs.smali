.class public Lio/minio/StatObjectArgs;
.super Lio/minio/ObjectConditionalReadArgs;
.source "StatObjectArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/StatObjectArgs$Builder;
    }
.end annotation


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 21
    invoke-direct {p0}, Lio/minio/ObjectConditionalReadArgs;-><init>()V

    return-void
.end method

.method public constructor <init>(Lio/minio/ObjectReadArgs;)V
    .locals 1
    .param p1, "args"    # Lio/minio/ObjectReadArgs;

    .line 23
    invoke-direct {p0}, Lio/minio/ObjectConditionalReadArgs;-><init>()V

    .line 24
    iget-object v0, p1, Lio/minio/ObjectReadArgs;->extraHeaders:Lcom/google/common/collect/Multimap;

    iput-object v0, p0, Lio/minio/StatObjectArgs;->extraHeaders:Lcom/google/common/collect/Multimap;

    .line 25
    iget-object v0, p1, Lio/minio/ObjectReadArgs;->extraQueryParams:Lcom/google/common/collect/Multimap;

    iput-object v0, p0, Lio/minio/StatObjectArgs;->extraQueryParams:Lcom/google/common/collect/Multimap;

    .line 26
    iget-object v0, p1, Lio/minio/ObjectReadArgs;->bucketName:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/StatObjectArgs;->bucketName:Ljava/lang/String;

    .line 27
    iget-object v0, p1, Lio/minio/ObjectReadArgs;->region:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/StatObjectArgs;->region:Ljava/lang/String;

    .line 28
    iget-object v0, p1, Lio/minio/ObjectReadArgs;->objectName:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/StatObjectArgs;->objectName:Ljava/lang/String;

    .line 29
    iget-object v0, p1, Lio/minio/ObjectReadArgs;->versionId:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/StatObjectArgs;->versionId:Ljava/lang/String;

    .line 30
    iget-object v0, p1, Lio/minio/ObjectReadArgs;->ssec:Lio/minio/ServerSideEncryptionCustomerKey;

    iput-object v0, p0, Lio/minio/StatObjectArgs;->ssec:Lio/minio/ServerSideEncryptionCustomerKey;

    .line 31
    return-void
.end method

.method public static builder()Lio/minio/StatObjectArgs$Builder;
    .locals 1

    .line 34
    new-instance v0, Lio/minio/StatObjectArgs$Builder;

    invoke-direct {v0}, Lio/minio/StatObjectArgs$Builder;-><init>()V

    return-object v0
.end method
