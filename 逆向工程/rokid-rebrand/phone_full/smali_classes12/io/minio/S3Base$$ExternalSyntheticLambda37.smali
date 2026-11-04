.class public final synthetic Lio/minio/S3Base$$ExternalSyntheticLambda37;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Supplier;


# instance fields
.field public final synthetic f$0:Lio/minio/S3Base;

.field public final synthetic f$1:Lio/minio/PutObjectBaseArgs;

.field public final synthetic f$2:Lcom/google/common/collect/Multimap;

.field public final synthetic f$3:Lio/minio/PartReader;

.field public final synthetic f$4:Lio/minio/PartSource;


# direct methods
.method public synthetic constructor <init>(Lio/minio/S3Base;Lio/minio/PutObjectBaseArgs;Lcom/google/common/collect/Multimap;Lio/minio/PartReader;Lio/minio/PartSource;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/S3Base$$ExternalSyntheticLambda37;->f$0:Lio/minio/S3Base;

    iput-object p2, p0, Lio/minio/S3Base$$ExternalSyntheticLambda37;->f$1:Lio/minio/PutObjectBaseArgs;

    iput-object p3, p0, Lio/minio/S3Base$$ExternalSyntheticLambda37;->f$2:Lcom/google/common/collect/Multimap;

    iput-object p4, p0, Lio/minio/S3Base$$ExternalSyntheticLambda37;->f$3:Lio/minio/PartReader;

    iput-object p5, p0, Lio/minio/S3Base$$ExternalSyntheticLambda37;->f$4:Lio/minio/PartSource;

    return-void
.end method


# virtual methods
.method public final get()Ljava/lang/Object;
    .locals 5

    .line 0
    iget-object v0, p0, Lio/minio/S3Base$$ExternalSyntheticLambda37;->f$0:Lio/minio/S3Base;

    iget-object v1, p0, Lio/minio/S3Base$$ExternalSyntheticLambda37;->f$1:Lio/minio/PutObjectBaseArgs;

    iget-object v2, p0, Lio/minio/S3Base$$ExternalSyntheticLambda37;->f$2:Lcom/google/common/collect/Multimap;

    iget-object v3, p0, Lio/minio/S3Base$$ExternalSyntheticLambda37;->f$3:Lio/minio/PartReader;

    iget-object v4, p0, Lio/minio/S3Base$$ExternalSyntheticLambda37;->f$4:Lio/minio/PartSource;

    invoke-virtual {v0, v1, v2, v3, v4}, Lio/minio/S3Base;->lambda$putMultipartObjectAsync$23$io-minio-S3Base(Lio/minio/PutObjectBaseArgs;Lcom/google/common/collect/Multimap;Lio/minio/PartReader;Lio/minio/PartSource;)Lio/minio/ObjectWriteResponse;

    move-result-object v0

    return-object v0
.end method
