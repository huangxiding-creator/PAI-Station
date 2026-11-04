.class public final synthetic Lio/minio/SetObjectTagsArgs$Builder$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Consumer;


# instance fields
.field public final synthetic f$0:Ljava/util/Map;


# direct methods
.method public synthetic constructor <init>(Ljava/util/Map;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/SetObjectTagsArgs$Builder$$ExternalSyntheticLambda1;->f$0:Ljava/util/Map;

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 1

    .line 0
    iget-object v0, p0, Lio/minio/SetObjectTagsArgs$Builder$$ExternalSyntheticLambda1;->f$0:Ljava/util/Map;

    check-cast p1, Lio/minio/SetObjectTagsArgs;

    invoke-static {v0, p1}, Lio/minio/SetObjectTagsArgs$Builder;->lambda$tags$0(Ljava/util/Map;Lio/minio/SetObjectTagsArgs;)V

    return-void
.end method
