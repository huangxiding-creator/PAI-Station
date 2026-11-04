.class public Lio/minio/DeleteBucketReplicationArgs;
.super Lio/minio/BucketArgs;
.source "DeleteBucketReplicationArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/DeleteBucketReplicationArgs$Builder;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Lio/minio/BucketArgs;-><init>()V

    return-void
.end method

.method public static builder()Lio/minio/DeleteBucketReplicationArgs$Builder;
    .locals 1

    .line 25
    new-instance v0, Lio/minio/DeleteBucketReplicationArgs$Builder;

    invoke-direct {v0}, Lio/minio/DeleteBucketReplicationArgs$Builder;-><init>()V

    return-object v0
.end method
