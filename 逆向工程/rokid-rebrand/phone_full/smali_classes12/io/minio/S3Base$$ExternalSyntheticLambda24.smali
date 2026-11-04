.class public final synthetic Lio/minio/S3Base$$ExternalSyntheticLambda24;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Function;


# instance fields
.field public final synthetic f$0:Lio/minio/S3Base;

.field public final synthetic f$1:Lio/minio/BaseArgs;

.field public final synthetic f$2:Lcom/google/common/collect/Multimap;

.field public final synthetic f$3:Lcom/google/common/collect/Multimap;


# direct methods
.method public synthetic constructor <init>(Lio/minio/S3Base;Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/S3Base$$ExternalSyntheticLambda24;->f$0:Lio/minio/S3Base;

    iput-object p2, p0, Lio/minio/S3Base$$ExternalSyntheticLambda24;->f$1:Lio/minio/BaseArgs;

    iput-object p3, p0, Lio/minio/S3Base$$ExternalSyntheticLambda24;->f$2:Lcom/google/common/collect/Multimap;

    iput-object p4, p0, Lio/minio/S3Base$$ExternalSyntheticLambda24;->f$3:Lcom/google/common/collect/Multimap;

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 4

    .line 0
    iget-object v0, p0, Lio/minio/S3Base$$ExternalSyntheticLambda24;->f$0:Lio/minio/S3Base;

    iget-object v1, p0, Lio/minio/S3Base$$ExternalSyntheticLambda24;->f$1:Lio/minio/BaseArgs;

    iget-object v2, p0, Lio/minio/S3Base$$ExternalSyntheticLambda24;->f$2:Lcom/google/common/collect/Multimap;

    iget-object v3, p0, Lio/minio/S3Base$$ExternalSyntheticLambda24;->f$3:Lcom/google/common/collect/Multimap;

    check-cast p1, Lokhttp3/Response;

    invoke-virtual {v0, v1, v2, v3, p1}, Lio/minio/S3Base;->lambda$executeHeadAsync$4$io-minio-S3Base(Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Lokhttp3/Response;)Ljava/util/concurrent/CompletionStage;

    move-result-object p1

    return-object p1
.end method
