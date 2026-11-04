.class public Lio/minio/EnableObjectLegalHoldArgs;
.super Lio/minio/ObjectVersionArgs;
.source "EnableObjectLegalHoldArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/EnableObjectLegalHoldArgs$Builder;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Lio/minio/ObjectVersionArgs;-><init>()V

    return-void
.end method

.method public static builder()Lio/minio/EnableObjectLegalHoldArgs$Builder;
    .locals 1

    .line 25
    new-instance v0, Lio/minio/EnableObjectLegalHoldArgs$Builder;

    invoke-direct {v0}, Lio/minio/EnableObjectLegalHoldArgs$Builder;-><init>()V

    return-object v0
.end method
