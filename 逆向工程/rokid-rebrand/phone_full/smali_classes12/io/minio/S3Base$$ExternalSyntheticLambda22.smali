.class public final synthetic Lio/minio/S3Base$$ExternalSyntheticLambda22;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Function;


# instance fields
.field public final synthetic f$0:Lio/minio/S3Base;

.field public final synthetic f$1:Lio/minio/PartReader;

.field public final synthetic f$2:Lio/minio/PutObjectBaseArgs;

.field public final synthetic f$3:Lcom/google/common/collect/Multimap;


# direct methods
.method public synthetic constructor <init>(Lio/minio/S3Base;Lio/minio/PartReader;Lio/minio/PutObjectBaseArgs;Lcom/google/common/collect/Multimap;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/S3Base$$ExternalSyntheticLambda22;->f$0:Lio/minio/S3Base;

    iput-object p2, p0, Lio/minio/S3Base$$ExternalSyntheticLambda22;->f$1:Lio/minio/PartReader;

    iput-object p3, p0, Lio/minio/S3Base$$ExternalSyntheticLambda22;->f$2:Lio/minio/PutObjectBaseArgs;

    iput-object p4, p0, Lio/minio/S3Base$$ExternalSyntheticLambda22;->f$3:Lcom/google/common/collect/Multimap;

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 4

    .line 0
    iget-object v0, p0, Lio/minio/S3Base$$ExternalSyntheticLambda22;->f$0:Lio/minio/S3Base;

    iget-object v1, p0, Lio/minio/S3Base$$ExternalSyntheticLambda22;->f$1:Lio/minio/PartReader;

    iget-object v2, p0, Lio/minio/S3Base$$ExternalSyntheticLambda22;->f$2:Lio/minio/PutObjectBaseArgs;

    iget-object v3, p0, Lio/minio/S3Base$$ExternalSyntheticLambda22;->f$3:Lcom/google/common/collect/Multimap;

    check-cast p1, Lio/minio/PartSource;

    invoke-virtual {v0, v1, v2, v3, p1}, Lio/minio/S3Base;->lambda$putObjectAsync$25$io-minio-S3Base(Lio/minio/PartReader;Lio/minio/PutObjectBaseArgs;Lcom/google/common/collect/Multimap;Lio/minio/PartSource;)Ljava/util/concurrent/CompletionStage;

    move-result-object p1

    return-object p1
.end method
