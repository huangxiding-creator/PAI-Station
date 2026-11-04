.class public final Lio/minio/MakeBucketArgs$Builder;
.super Lio/minio/BucketArgs$Builder;
.source "MakeBucketArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/MakeBucketArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/BucketArgs$Builder<",
        "Lio/minio/MakeBucketArgs$Builder;",
        "Lio/minio/MakeBucketArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 34
    invoke-direct {p0}, Lio/minio/BucketArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$objectLock$0(ZLio/minio/MakeBucketArgs;)V
    .locals 0
    .param p0, "objectLock"    # Z
    .param p1, "args"    # Lio/minio/MakeBucketArgs;

    .line 36
    invoke-static {p1, p0}, Lio/minio/MakeBucketArgs;->access$002(Lio/minio/MakeBucketArgs;Z)Z

    return-void
.end method


# virtual methods
.method public objectLock(Z)Lio/minio/MakeBucketArgs$Builder;
    .locals 2
    .param p1, "objectLock"    # Z

    .line 36
    iget-object v0, p0, Lio/minio/MakeBucketArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/MakeBucketArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/MakeBucketArgs$Builder$$ExternalSyntheticLambda0;-><init>(Z)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 37
    return-object p0
.end method
