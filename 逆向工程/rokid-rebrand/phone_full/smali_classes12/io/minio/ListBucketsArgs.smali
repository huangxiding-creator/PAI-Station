.class public Lio/minio/ListBucketsArgs;
.super Lio/minio/BaseArgs;
.source "ListBucketsArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/ListBucketsArgs$Builder;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Lio/minio/BaseArgs;-><init>()V

    return-void
.end method

.method public static builder()Lio/minio/ListBucketsArgs$Builder;
    .locals 1

    .line 22
    new-instance v0, Lio/minio/ListBucketsArgs$Builder;

    invoke-direct {v0}, Lio/minio/ListBucketsArgs$Builder;-><init>()V

    return-object v0
.end method
