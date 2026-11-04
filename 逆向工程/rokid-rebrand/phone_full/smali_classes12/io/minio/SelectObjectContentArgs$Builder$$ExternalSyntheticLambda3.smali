.class public final synthetic Lio/minio/SelectObjectContentArgs$Builder$$ExternalSyntheticLambda3;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Consumer;


# instance fields
.field public final synthetic f$0:Ljava/lang/Boolean;


# direct methods
.method public synthetic constructor <init>(Ljava/lang/Boolean;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/SelectObjectContentArgs$Builder$$ExternalSyntheticLambda3;->f$0:Ljava/lang/Boolean;

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 1

    .line 0
    iget-object v0, p0, Lio/minio/SelectObjectContentArgs$Builder$$ExternalSyntheticLambda3;->f$0:Ljava/lang/Boolean;

    check-cast p1, Lio/minio/SelectObjectContentArgs;

    invoke-static {v0, p1}, Lio/minio/SelectObjectContentArgs$Builder;->lambda$requestProgress$3(Ljava/lang/Boolean;Lio/minio/SelectObjectContentArgs;)V

    return-void
.end method
