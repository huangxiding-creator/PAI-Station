.class public Lio/minio/DeleteBucketTagsArgs;
.super Lio/minio/BucketArgs;
.source "DeleteBucketTagsArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/DeleteBucketTagsArgs$Builder;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Lio/minio/BucketArgs;-><init>()V

    return-void
.end method

.method public static builder()Lio/minio/DeleteBucketTagsArgs$Builder;
    .locals 1

    .line 25
    new-instance v0, Lio/minio/DeleteBucketTagsArgs$Builder;

    invoke-direct {v0}, Lio/minio/DeleteBucketTagsArgs$Builder;-><init>()V

    return-object v0
.end method
