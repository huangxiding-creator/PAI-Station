.class public final synthetic Lio/minio/S3Base$$ExternalSyntheticLambda29;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Function;


# instance fields
.field public final synthetic f$0:Lio/minio/S3Base;

.field public final synthetic f$1:Ljava/lang/String;

.field public final synthetic f$2:Ljava/lang/String;

.field public final synthetic f$3:Lcom/google/common/collect/Multimap;

.field public final synthetic f$4:Lcom/google/common/collect/Multimap;

.field public final synthetic f$5:Ljava/lang/Object;

.field public final synthetic f$6:J


# direct methods
.method public synthetic constructor <init>(Lio/minio/S3Base;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;J)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/S3Base$$ExternalSyntheticLambda29;->f$0:Lio/minio/S3Base;

    iput-object p2, p0, Lio/minio/S3Base$$ExternalSyntheticLambda29;->f$1:Ljava/lang/String;

    iput-object p3, p0, Lio/minio/S3Base$$ExternalSyntheticLambda29;->f$2:Ljava/lang/String;

    iput-object p4, p0, Lio/minio/S3Base$$ExternalSyntheticLambda29;->f$3:Lcom/google/common/collect/Multimap;

    iput-object p5, p0, Lio/minio/S3Base$$ExternalSyntheticLambda29;->f$4:Lcom/google/common/collect/Multimap;

    iput-object p6, p0, Lio/minio/S3Base$$ExternalSyntheticLambda29;->f$5:Ljava/lang/Object;

    iput-wide p7, p0, Lio/minio/S3Base$$ExternalSyntheticLambda29;->f$6:J

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 9

    .line 0
    iget-object v0, p0, Lio/minio/S3Base$$ExternalSyntheticLambda29;->f$0:Lio/minio/S3Base;

    iget-object v1, p0, Lio/minio/S3Base$$ExternalSyntheticLambda29;->f$1:Ljava/lang/String;

    iget-object v2, p0, Lio/minio/S3Base$$ExternalSyntheticLambda29;->f$2:Ljava/lang/String;

    iget-object v3, p0, Lio/minio/S3Base$$ExternalSyntheticLambda29;->f$3:Lcom/google/common/collect/Multimap;

    iget-object v4, p0, Lio/minio/S3Base$$ExternalSyntheticLambda29;->f$4:Lcom/google/common/collect/Multimap;

    iget-object v5, p0, Lio/minio/S3Base$$ExternalSyntheticLambda29;->f$5:Ljava/lang/Object;

    iget-wide v6, p0, Lio/minio/S3Base$$ExternalSyntheticLambda29;->f$6:J

    move-object v8, p1

    check-cast v8, Ljava/lang/String;

    invoke-virtual/range {v0 .. v8}, Lio/minio/S3Base;->lambda$putObjectAsync$28$io-minio-S3Base(Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;JLjava/lang/String;)Ljava/util/concurrent/CompletionStage;

    move-result-object p1

    return-object p1
.end method
