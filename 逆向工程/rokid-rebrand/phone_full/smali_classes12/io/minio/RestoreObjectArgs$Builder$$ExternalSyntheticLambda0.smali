.class public final synthetic Lio/minio/RestoreObjectArgs$Builder$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Consumer;


# instance fields
.field public final synthetic f$0:Lio/minio/messages/RestoreRequest;


# direct methods
.method public synthetic constructor <init>(Lio/minio/messages/RestoreRequest;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/RestoreObjectArgs$Builder$$ExternalSyntheticLambda0;->f$0:Lio/minio/messages/RestoreRequest;

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 1

    .line 0
    iget-object v0, p0, Lio/minio/RestoreObjectArgs$Builder$$ExternalSyntheticLambda0;->f$0:Lio/minio/messages/RestoreRequest;

    check-cast p1, Lio/minio/RestoreObjectArgs;

    invoke-static {v0, p1}, Lio/minio/RestoreObjectArgs$Builder;->lambda$request$0(Lio/minio/messages/RestoreRequest;Lio/minio/RestoreObjectArgs;)V

    return-void
.end method
