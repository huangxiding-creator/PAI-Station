.class public final Lio/minio/RemoveObjectArgs$Builder;
.super Lio/minio/ObjectVersionArgs$Builder;
.source "RemoveObjectArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/RemoveObjectArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/ObjectVersionArgs$Builder<",
        "Lio/minio/RemoveObjectArgs$Builder;",
        "Lio/minio/RemoveObjectArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 34
    invoke-direct {p0}, Lio/minio/ObjectVersionArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$bypassGovernanceMode$0(ZLio/minio/RemoveObjectArgs;)V
    .locals 0
    .param p0, "flag"    # Z
    .param p1, "args"    # Lio/minio/RemoveObjectArgs;

    .line 36
    invoke-static {p1, p0}, Lio/minio/RemoveObjectArgs;->access$002(Lio/minio/RemoveObjectArgs;Z)Z

    return-void
.end method


# virtual methods
.method public bypassGovernanceMode(Z)Lio/minio/RemoveObjectArgs$Builder;
    .locals 2
    .param p1, "flag"    # Z

    .line 36
    iget-object v0, p0, Lio/minio/RemoveObjectArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/RemoveObjectArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/RemoveObjectArgs$Builder$$ExternalSyntheticLambda0;-><init>(Z)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 37
    return-object p0
.end method
