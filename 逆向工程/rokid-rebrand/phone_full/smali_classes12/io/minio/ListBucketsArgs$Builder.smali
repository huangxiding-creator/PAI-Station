.class public final Lio/minio/ListBucketsArgs$Builder;
.super Lio/minio/BaseArgs$Builder;
.source "ListBucketsArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/ListBucketsArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/BaseArgs$Builder<",
        "Lio/minio/ListBucketsArgs$Builder;",
        "Lio/minio/ListBucketsArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Lio/minio/BaseArgs$Builder;-><init>()V

    return-void
.end method


# virtual methods
.method protected bridge synthetic validate(Lio/minio/BaseArgs;)V
    .locals 0

    .line 26
    check-cast p1, Lio/minio/ListBucketsArgs;

    invoke-virtual {p0, p1}, Lio/minio/ListBucketsArgs$Builder;->validate(Lio/minio/ListBucketsArgs;)V

    return-void
.end method

.method protected validate(Lio/minio/ListBucketsArgs;)V
    .locals 0
    .param p1, "args"    # Lio/minio/ListBucketsArgs;

    .line 28
    return-void
.end method
