.class public final synthetic Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda7;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Consumer;


# instance fields
.field public final synthetic f$0:Lcom/google/common/collect/Multimap;


# direct methods
.method public synthetic constructor <init>(Lcom/google/common/collect/Multimap;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda7;->f$0:Lcom/google/common/collect/Multimap;

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 1

    .line 0
    iget-object v0, p0, Lio/minio/ObjectWriteArgs$Builder$$ExternalSyntheticLambda7;->f$0:Lcom/google/common/collect/Multimap;

    check-cast p1, Lio/minio/ObjectWriteArgs;

    invoke-static {v0, p1}, Lio/minio/ObjectWriteArgs$Builder;->lambda$userMetadata$2(Lcom/google/common/collect/Multimap;Lio/minio/ObjectWriteArgs;)V

    return-void
.end method
