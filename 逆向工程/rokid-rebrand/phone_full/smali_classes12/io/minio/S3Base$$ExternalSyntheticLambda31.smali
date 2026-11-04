.class public final synthetic Lio/minio/S3Base$$ExternalSyntheticLambda31;
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

.field public final synthetic f$5:I

.field public final synthetic f$6:Ljava/lang/String;

.field public final synthetic f$7:Ljava/lang/Object;

.field public final synthetic f$8:J


# direct methods
.method public synthetic constructor <init>(Lio/minio/S3Base;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;ILjava/lang/String;Ljava/lang/Object;J)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/S3Base$$ExternalSyntheticLambda31;->f$0:Lio/minio/S3Base;

    iput-object p2, p0, Lio/minio/S3Base$$ExternalSyntheticLambda31;->f$1:Ljava/lang/String;

    iput-object p3, p0, Lio/minio/S3Base$$ExternalSyntheticLambda31;->f$2:Ljava/lang/String;

    iput-object p4, p0, Lio/minio/S3Base$$ExternalSyntheticLambda31;->f$3:Lcom/google/common/collect/Multimap;

    iput-object p5, p0, Lio/minio/S3Base$$ExternalSyntheticLambda31;->f$4:Lcom/google/common/collect/Multimap;

    iput p6, p0, Lio/minio/S3Base$$ExternalSyntheticLambda31;->f$5:I

    iput-object p7, p0, Lio/minio/S3Base$$ExternalSyntheticLambda31;->f$6:Ljava/lang/String;

    iput-object p8, p0, Lio/minio/S3Base$$ExternalSyntheticLambda31;->f$7:Ljava/lang/Object;

    iput-wide p9, p0, Lio/minio/S3Base$$ExternalSyntheticLambda31;->f$8:J

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 11

    .line 0
    iget-object v0, p0, Lio/minio/S3Base$$ExternalSyntheticLambda31;->f$0:Lio/minio/S3Base;

    iget-object v1, p0, Lio/minio/S3Base$$ExternalSyntheticLambda31;->f$1:Ljava/lang/String;

    iget-object v2, p0, Lio/minio/S3Base$$ExternalSyntheticLambda31;->f$2:Ljava/lang/String;

    iget-object v3, p0, Lio/minio/S3Base$$ExternalSyntheticLambda31;->f$3:Lcom/google/common/collect/Multimap;

    iget-object v4, p0, Lio/minio/S3Base$$ExternalSyntheticLambda31;->f$4:Lcom/google/common/collect/Multimap;

    iget v5, p0, Lio/minio/S3Base$$ExternalSyntheticLambda31;->f$5:I

    iget-object v6, p0, Lio/minio/S3Base$$ExternalSyntheticLambda31;->f$6:Ljava/lang/String;

    iget-object v7, p0, Lio/minio/S3Base$$ExternalSyntheticLambda31;->f$7:Ljava/lang/Object;

    iget-wide v8, p0, Lio/minio/S3Base$$ExternalSyntheticLambda31;->f$8:J

    move-object v10, p1

    check-cast v10, Ljava/lang/String;

    invoke-virtual/range {v0 .. v10}, Lio/minio/S3Base;->lambda$uploadPartAsync$36$io-minio-S3Base(Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;ILjava/lang/String;Ljava/lang/Object;JLjava/lang/String;)Ljava/util/concurrent/CompletionStage;

    move-result-object p1

    return-object p1
.end method
