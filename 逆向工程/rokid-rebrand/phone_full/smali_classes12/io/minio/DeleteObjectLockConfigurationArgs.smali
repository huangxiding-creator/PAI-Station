.class public Lio/minio/DeleteObjectLockConfigurationArgs;
.super Lio/minio/BucketArgs;
.source "DeleteObjectLockConfigurationArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/DeleteObjectLockConfigurationArgs$Builder;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Lio/minio/BucketArgs;-><init>()V

    return-void
.end method

.method public static builder()Lio/minio/DeleteObjectLockConfigurationArgs$Builder;
    .locals 1

    .line 25
    new-instance v0, Lio/minio/DeleteObjectLockConfigurationArgs$Builder;

    invoke-direct {v0}, Lio/minio/DeleteObjectLockConfigurationArgs$Builder;-><init>()V

    return-object v0
.end method
