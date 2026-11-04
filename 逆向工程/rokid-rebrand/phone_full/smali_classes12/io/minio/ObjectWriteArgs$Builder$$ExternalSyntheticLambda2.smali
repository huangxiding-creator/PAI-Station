.class public final synthetic Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda2;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Consumer;


# instance fields
.field public final synthetic f$0:Lio/minio/ServerSideEncryption;


# direct methods
.method public synthetic constructor <init>(Lio/minio/ServerSideEncryption;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda2;->f$0:Lio/minio/ServerSideEncryption;

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 1

    .line 0
    iget-object v0, p0, Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda2;->f$0:Lio/minio/ServerSideEncryption;

    check-cast p1, Lio/minio/ObjectWriteArgs;

    invoke-static {v0, p1}, Lio/minio/ObjectWriteArgs$Builder;->lambda$sse$3(Lio/minio/ServerSideEncryption;Lio/minio/ObjectWriteArgs;)V

    return-void
.end method
