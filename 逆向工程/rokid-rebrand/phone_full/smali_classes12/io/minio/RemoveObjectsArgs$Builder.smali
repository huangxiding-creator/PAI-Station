.class public final Lio/minio/RemoveObjectsArgs$Builder;
.super Lio/minio/BucketArgs$Builder;
.source "RemoveObjectsArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/RemoveObjectsArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/BucketArgs$Builder<",
        "Lio/minio/RemoveObjectsArgs$Builder;",
        "Lio/minio/RemoveObjectsArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 44
    invoke-direct {p0}, Lio/minio/BucketArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$bypassGovernanceMode$0(ZLio/minio/RemoveObjectsArgs;)V
    .locals 0
    .param p0, "flag"    # Z
    .param p1, "args"    # Lio/minio/RemoveObjectsArgs;

    .line 46
    invoke-static {p1, p0}, Lio/minio/RemoveObjectsArgs;->access$102(Lio/minio/RemoveObjectsArgs;Z)Z

    return-void
.end method

.method static synthetic lambda$objects$1(Ljava/lang/Iterable;Lio/minio/RemoveObjectsArgs;)V
    .locals 0
    .param p0, "objects"    # Ljava/lang/Iterable;
    .param p1, "args"    # Lio/minio/RemoveObjectsArgs;

    .line 52
    invoke-static {p1, p0}, Lio/minio/RemoveObjectsArgs;->access$002(Lio/minio/RemoveObjectsArgs;Ljava/lang/Iterable;)Ljava/lang/Iterable;

    return-void
.end method


# virtual methods
.method public bypassGovernanceMode(Z)Lio/minio/RemoveObjectsArgs$Builder;
    .locals 2
    .param p1, "flag"    # Z

    .line 46
    iget-object v0, p0, Lio/minio/RemoveObjectsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/RemoveObjectsArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/RemoveObjectsArgs$Builder$$ExternalSyntheticLambda0;-><init>(Z)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 47
    return-object p0
.end method

.method public objects(Ljava/lang/Iterable;)Lio/minio/RemoveObjectsArgs$Builder;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Iterable<",
            "Lio/minio/messages/DeleteObject;",
            ">;)",
            "Lio/minio/RemoveObjectsArgs$Builder;"
        }
    .end annotation

    .line 51
    .local p1, "objects":Ljava/lang/Iterable;, "Ljava/lang/Iterable<Lio/minio/messages/DeleteObject;>;"
    const-string v0, "objects"

    invoke-virtual {p0, p1, v0}, Lio/minio/RemoveObjectsArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 52
    iget-object v0, p0, Lio/minio/RemoveObjectsArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/RemoveObjectsArgs$Builder$$ExternalSyntheticLambda1;

    invoke-direct {v1, p1}, Lio/minio/RemoveObjectsArgs$Builder$$ExternalSyntheticLambda1;-><init>(Ljava/lang/Iterable;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 53
    return-object p0
.end method
