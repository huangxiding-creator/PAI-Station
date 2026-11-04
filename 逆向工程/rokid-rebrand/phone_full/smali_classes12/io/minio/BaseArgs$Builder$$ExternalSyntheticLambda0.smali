.class public final synthetic Lio/minio/BaseArgs$Builder$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Consumer;


# instance fields
.field public final synthetic f$0:Lio/minio/BaseArgs;


# direct methods
.method public synthetic constructor <init>(Lio/minio/BaseArgs;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/BaseArgs$Builder$$ExternalSyntheticLambda0;->f$0:Lio/minio/BaseArgs;

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 1

    .line 0
    iget-object v0, p0, Lio/minio/BaseArgs$Builder$$ExternalSyntheticLambda0;->f$0:Lio/minio/BaseArgs;

    check-cast p1, Ljava/util/function/Consumer;

    invoke-static {v0, p1}, Lio/minio/BaseArgs$Builder;->lambda$build$4(Lio/minio/BaseArgs;Ljava/util/function/Consumer;)V

    return-void
.end method
