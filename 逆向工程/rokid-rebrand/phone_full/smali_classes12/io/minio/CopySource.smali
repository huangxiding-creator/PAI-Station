.class public Lio/minio/CopySource;
.super Lio/minio/ObjectConditionalReadArgs;
.source "CopySource.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/CopySource$Builder;
    }
.end annotation


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 21
    invoke-direct {p0}, Lio/minio/ObjectConditionalReadArgs;-><init>()V

    return-void
.end method

.method public constructor <init>(Lio/minio/ObjectConditionalReadArgs;)V
    .locals 1
    .param p1, "args"    # Lio/minio/ObjectConditionalReadArgs;

    .line 23
    invoke-direct {p0}, Lio/minio/ObjectConditionalReadArgs;-><init>()V

    .line 24
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->extraHeaders:Lcom/google/common/collect/Multimap;

    iput-object v0, p0, Lio/minio/CopySource;->extraHeaders:Lcom/google/common/collect/Multimap;

    .line 25
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->extraQueryParams:Lcom/google/common/collect/Multimap;

    iput-object v0, p0, Lio/minio/CopySource;->extraQueryParams:Lcom/google/common/collect/Multimap;

    .line 26
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->bucketName:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/CopySource;->bucketName:Ljava/lang/String;

    .line 27
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->region:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/CopySource;->region:Ljava/lang/String;

    .line 28
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->objectName:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/CopySource;->objectName:Ljava/lang/String;

    .line 29
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->versionId:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/CopySource;->versionId:Ljava/lang/String;

    .line 30
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->ssec:Lio/minio/ServerSideEncryptionCustomerKey;

    iput-object v0, p0, Lio/minio/CopySource;->ssec:Lio/minio/ServerSideEncryptionCustomerKey;

    .line 31
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->offset:Ljava/lang/Long;

    iput-object v0, p0, Lio/minio/CopySource;->offset:Ljava/lang/Long;

    .line 32
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->length:Ljava/lang/Long;

    iput-object v0, p0, Lio/minio/CopySource;->length:Ljava/lang/Long;

    .line 33
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->matchETag:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/CopySource;->matchETag:Ljava/lang/String;

    .line 34
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->notMatchETag:Ljava/lang/String;

    iput-object v0, p0, Lio/minio/CopySource;->notMatchETag:Ljava/lang/String;

    .line 35
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->modifiedSince:Ljava/time/ZonedDateTime;

    iput-object v0, p0, Lio/minio/CopySource;->modifiedSince:Ljava/time/ZonedDateTime;

    .line 36
    iget-object v0, p1, Lio/minio/ObjectConditionalReadArgs;->unmodifiedSince:Ljava/time/ZonedDateTime;

    iput-object v0, p0, Lio/minio/CopySource;->unmodifiedSince:Ljava/time/ZonedDateTime;

    .line 37
    return-void
.end method

.method public static builder()Lio/minio/CopySource$Builder;
    .locals 1

    .line 40
    new-instance v0, Lio/minio/CopySource$Builder;

    invoke-direct {v0}, Lio/minio/CopySource$Builder;-><init>()V

    return-object v0
.end method
