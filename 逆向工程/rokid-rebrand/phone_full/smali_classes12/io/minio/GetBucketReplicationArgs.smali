.class public Lio/minio/GetBucketReplicationArgs;
.super Lio/minio/BucketArgs;
.source "GetBucketReplicationArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/GetBucketReplicationArgs$Builder;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Lio/minio/BucketArgs;-><init>()V

    return-void
.end method

.method public static builder()Lio/minio/GetBucketReplicationArgs$Builder;
    .locals 1

    .line 25
    new-instance v0, Lio/minio/GetBucketReplicationArgs$Builder;

    invoke-direct {v0}, Lio/minio/GetBucketReplicationArgs$Builder;-><init>()V

    return-object v0
.end method
