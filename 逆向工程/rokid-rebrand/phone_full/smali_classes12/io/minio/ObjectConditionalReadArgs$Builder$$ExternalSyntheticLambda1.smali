.class public final synthetic Lio/minio/ObjectConditionalReadArgs$Builder$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Consumer;


# instance fields
.field public final synthetic f$0:Ljava/time/ZonedDateTime;


# direct methods
.method public synthetic constructor <init>(Ljava/time/ZonedDateTime;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/ObjectConditionalReadArgs$Builder$$ExternalSyntheticLambda1;->f$0:Ljava/time/ZonedDateTime;

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 1

    .line 0
    iget-object v0, p0, Lio/minio/ObjectConditionalReadArgs$Builder$$ExternalSyntheticLambda1;->f$0:Ljava/time/ZonedDateTime;

    check-cast p1, Lio/minio/ObjectConditionalReadArgs;

    invoke-static {v0, p1}, Lio/minio/ObjectConditionalReadArgs$Builder;->lambda$unmodifiedSince$5(Ljava/time/ZonedDateTime;Lio/minio/ObjectConditionalReadArgs;)V

    return-void
.end method
