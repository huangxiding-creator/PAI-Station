.class public Lio/minio/IsObjectLegalHoldEnabledArgs;
.super Lio/minio/ObjectVersionArgs;
.source "IsObjectLegalHoldEnabledArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/IsObjectLegalHoldEnabledArgs$Builder;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Lio/minio/ObjectVersionArgs;-><init>()V

    return-void
.end method

.method public static builder()Lio/minio/IsObjectLegalHoldEnabledArgs$Builder;
    .locals 1

    .line 25
    new-instance v0, Lio/minio/IsObjectLegalHoldEnabledArgs$Builder;

    invoke-direct {v0}, Lio/minio/IsObjectLegalHoldEnabledArgs$Builder;-><init>()V

    return-object v0
.end method
