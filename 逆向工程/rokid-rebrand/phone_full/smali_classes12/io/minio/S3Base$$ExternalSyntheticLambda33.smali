.class public final synthetic Lio/minio/S3Base$$ExternalSyntheticLambda33;
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

.field public final synthetic f$5:[Lio/minio/messages/Part;


# direct methods
.method public synthetic constructor <init>(Lio/minio/S3Base;Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;[Lio/minio/messages/Part;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/S3Base$$ExternalSyntheticLambda33;->f$0:Lio/minio/S3Base;

    iput-object p2, p0, Lio/minio/S3Base$$ExternalSyntheticLambda33;->f$1:Ljava/lang/String;

    iput-object p3, p0, Lio/minio/S3Base$$ExternalSyntheticLambda33;->f$2:Ljava/lang/String;

    iput-object p4, p0, Lio/minio/S3Base$$ExternalSyntheticLambda33;->f$3:Lcom/google/common/collect/Multimap;

    iput-object p5, p0, Lio/minio/S3Base$$ExternalSyntheticLambda33;->f$4:Lcom/google/common/collect/Multimap;

    iput-object p6, p0, Lio/minio/S3Base$$ExternalSyntheticLambda33;->f$5:[Lio/minio/messages/Part;

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 7

    .line 0
    iget-object v0, p0, Lio/minio/S3Base$$ExternalSyntheticLambda33;->f$0:Lio/minio/S3Base;

    iget-object v1, p0, Lio/minio/S3Base$$ExternalSyntheticLambda33;->f$1:Ljava/lang/String;

    iget-object v2, p0, Lio/minio/S3Base$$ExternalSyntheticLambda33;->f$2:Ljava/lang/String;

    iget-object v3, p0, Lio/minio/S3Base$$ExternalSyntheticLambda33;->f$3:Lcom/google/common/collect/Multimap;

    iget-object v4, p0, Lio/minio/S3Base$$ExternalSyntheticLambda33;->f$4:Lcom/google/common/collect/Multimap;

    iget-object v5, p0, Lio/minio/S3Base$$ExternalSyntheticLambda33;->f$5:[Lio/minio/messages/Part;

    move-object v6, p1

    check-cast v6, Ljava/lang/String;

    invoke-virtual/range {v0 .. v6}, Lio/minio/S3Base;->lambda$completeMultipartUploadAsync$11$io-minio-S3Base(Ljava/lang/String;Ljava/lang/String;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;[Lio/minio/messages/Part;Ljava/lang/String;)Ljava/util/concurrent/CompletionStage;

    move-result-object p1

    return-object p1
.end method
