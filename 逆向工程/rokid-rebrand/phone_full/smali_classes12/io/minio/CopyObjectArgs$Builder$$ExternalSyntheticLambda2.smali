.class public final synthetic Lio/minio/CopyObjectArgs$Builder$$ExternalSyntheticLambda2;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Consumer;


# instance fields
.field public final synthetic f$0:Lio/minio/Directive;


# direct methods
.method public synthetic constructor <init>(Lio/minio/Directive;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/CopyObjectArgs$Builder$$ExternalSyntheticLambda2;->f$0:Lio/minio/Directive;

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 1

    .line 0
    iget-object v0, p0, Lio/minio/CopyObjectArgs$Builder$$ExternalSyntheticLambda2;->f$0:Lio/minio/Directive;

    check-cast p1, Lio/minio/CopyObjectArgs;

    invoke-static {v0, p1}, Lio/minio/CopyObjectArgs$Builder;->lambda$taggingDirective$2(Lio/minio/Directive;Lio/minio/CopyObjectArgs;)V

    return-void
.end method
