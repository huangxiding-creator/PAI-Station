.class public Lio/minio/RemoveBucketArgs;
.super Lio/minio/BucketArgs;
.source "RemoveBucketArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/RemoveBucketArgs$Builder;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Lio/minio/BucketArgs;-><init>()V

    return-void
.end method

.method public static builder()Lio/minio/RemoveBucketArgs$Builder;
    .locals 1

    .line 23
    new-instance v0, Lio/minio/RemoveBucketArgs$Builder;

    invoke-direct {v0}, Lio/minio/RemoveBucketArgs$Builder;-><init>()V

    return-object v0
.end method
