.class public Lio/minio/GetBucketTagsArgs;
.super Lio/minio/BucketArgs;
.source "GetBucketTagsArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/GetBucketTagsArgs$Builder;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 22
    invoke-direct {p0}, Lio/minio/BucketArgs;-><init>()V

    return-void
.end method

.method public static builder()Lio/minio/GetBucketTagsArgs$Builder;
    .locals 1

    .line 24
    new-instance v0, Lio/minio/GetBucketTagsArgs$Builder;

    invoke-direct {v0}, Lio/minio/GetBucketTagsArgs$Builder;-><init>()V

    return-object v0
.end method
