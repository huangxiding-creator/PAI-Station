.class public Lio/minio/BucketExistsArgs;
.super Lio/minio/BucketArgs;
.source "BucketExistsArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/BucketExistsArgs$Builder;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Lio/minio/BucketArgs;-><init>()V

    return-void
.end method

.method public static builder()Lio/minio/BucketExistsArgs$Builder;
    .locals 1

    .line 22
    new-instance v0, Lio/minio/BucketExistsArgs$Builder;

    invoke-direct {v0}, Lio/minio/BucketExistsArgs$Builder;-><init>()V

    return-object v0
.end method
