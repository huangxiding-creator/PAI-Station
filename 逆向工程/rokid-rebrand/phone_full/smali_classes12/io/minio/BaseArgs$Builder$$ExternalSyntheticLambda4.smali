.class public final synthetic Lio/minio/BaseArgs$Builder$$ExternalSyntheticLambda4;
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

    iput-object p1, p0, Lio/minio/BaseArgs$Builder$$ExternalSyntheticLambda4;->f$0:Lcom/google/common/collect/Multimap;

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 1

    .line 0
    iget-object v0, p0, Lio/minio/BaseArgs$Builder$$ExternalSyntheticLambda4;->f$0:Lcom/google/common/collect/Multimap;

    check-cast p1, Lio/minio/BaseArgs;

    invoke-static {v0, p1}, Lio/minio/BaseArgs$Builder;->lambda$extraQueryParams$1(Lcom/google/common/collect/Multimap;Lio/minio/BaseArgs;)V

    return-void
.end method
