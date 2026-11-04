.class public final synthetic Lio/minio/SetBucketVersioningArgs$Builder$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Consumer;


# instance fields
.field public final synthetic f$0:Lio/minio/messages/VersioningConfiguration;


# direct methods
.method public synthetic constructor <init>(Lio/minio/messages/VersioningConfiguration;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/SetBucketVersioningArgs$Builder$$ExternalSyntheticLambda0;->f$0:Lio/minio/messages/VersioningConfiguration;

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 1

    .line 0
    iget-object v0, p0, Lio/minio/SetBucketVersioningArgs$Builder$$ExternalSyntheticLambda0;->f$0:Lio/minio/messages/VersioningConfiguration;

    check-cast p1, Lio/minio/SetBucketVersioningArgs;

    invoke-static {v0, p1}, Lio/minio/SetBucketVersioningArgs$Builder;->lambda$config$0(Lio/minio/messages/VersioningConfiguration;Lio/minio/SetBucketVersioningArgs;)V

    return-void
.end method
