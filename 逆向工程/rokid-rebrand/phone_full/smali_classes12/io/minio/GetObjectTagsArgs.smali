.class public Lio/minio/GetObjectTagsArgs;
.super Lio/minio/ObjectVersionArgs;
.source "GetObjectTagsArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/GetObjectTagsArgs$Builder;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 22
    invoke-direct {p0}, Lio/minio/ObjectVersionArgs;-><init>()V

    return-void
.end method

.method public static builder()Lio/minio/GetObjectTagsArgs$Builder;
    .locals 1

    .line 24
    new-instance v0, Lio/minio/GetObjectTagsArgs$Builder;

    invoke-direct {v0}, Lio/minio/GetObjectTagsArgs$Builder;-><init>()V

    return-object v0
.end method
