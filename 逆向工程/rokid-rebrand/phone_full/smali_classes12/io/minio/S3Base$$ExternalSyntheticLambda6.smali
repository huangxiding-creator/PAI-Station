.class public final synthetic Lio/minio/S3Base$$ExternalSyntheticLambda6;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Function;


# instance fields
.field public final synthetic f$0:Lio/minio/S3Base;

.field public final synthetic f$1:Lio/minio/http/Method;

.field public final synthetic f$2:Ljava/lang/String;

.field public final synthetic f$3:Ljava/lang/String;

.field public final synthetic f$4:Lio/minio/BaseArgs;

.field public final synthetic f$5:Lcom/google/common/collect/Multimap;

.field public final synthetic f$6:Lcom/google/common/collect/Multimap;

.field public final synthetic f$7:Ljava/lang/Object;

.field public final synthetic f$8:I


# direct methods
.method public synthetic constructor <init>(Lio/minio/S3Base;Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;I)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/S3Base$$ExternalSyntheticLambda6;->f$0:Lio/minio/S3Base;

    iput-object p2, p0, Lio/minio/S3Base$$ExternalSyntheticLambda6;->f$1:Lio/minio/http/Method;

    iput-object p3, p0, Lio/minio/S3Base$$ExternalSyntheticLambda6;->f$2:Ljava/lang/String;

    iput-object p4, p0, Lio/minio/S3Base$$ExternalSyntheticLambda6;->f$3:Ljava/lang/String;

    iput-object p5, p0, Lio/minio/S3Base$$ExternalSyntheticLambda6;->f$4:Lio/minio/BaseArgs;

    iput-object p6, p0, Lio/minio/S3Base$$ExternalSyntheticLambda6;->f$5:Lcom/google/common/collect/Multimap;

    iput-object p7, p0, Lio/minio/S3Base$$ExternalSyntheticLambda6;->f$6:Lcom/google/common/collect/Multimap;

    iput-object p8, p0, Lio/minio/S3Base$$ExternalSyntheticLambda6;->f$7:Ljava/lang/Object;

    iput p9, p0, Lio/minio/S3Base$$ExternalSyntheticLambda6;->f$8:I

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 10

    .line 0
    iget-object v0, p0, Lio/minio/S3Base$$ExternalSyntheticLambda6;->f$0:Lio/minio/S3Base;

    iget-object v1, p0, Lio/minio/S3Base$$ExternalSyntheticLambda6;->f$1:Lio/minio/http/Method;

    iget-object v2, p0, Lio/minio/S3Base$$ExternalSyntheticLambda6;->f$2:Ljava/lang/String;

    iget-object v3, p0, Lio/minio/S3Base$$ExternalSyntheticLambda6;->f$3:Ljava/lang/String;

    iget-object v4, p0, Lio/minio/S3Base$$ExternalSyntheticLambda6;->f$4:Lio/minio/BaseArgs;

    iget-object v5, p0, Lio/minio/S3Base$$ExternalSyntheticLambda6;->f$5:Lcom/google/common/collect/Multimap;

    iget-object v6, p0, Lio/minio/S3Base$$ExternalSyntheticLambda6;->f$6:Lcom/google/common/collect/Multimap;

    iget-object v7, p0, Lio/minio/S3Base$$ExternalSyntheticLambda6;->f$7:Ljava/lang/Object;

    iget v8, p0, Lio/minio/S3Base$$ExternalSyntheticLambda6;->f$8:I

    move-object v9, p1

    check-cast v9, Ljava/lang/String;

    invoke-virtual/range {v0 .. v9}, Lio/minio/S3Base;->lambda$executeAsync$1$io-minio-S3Base(Lio/minio/http/Method;Ljava/lang/String;Ljava/lang/String;Lio/minio/BaseArgs;Lcom/google/common/collect/Multimap;Lcom/google/common/collect/Multimap;Ljava/lang/Object;ILjava/lang/String;)Ljava/util/concurrent/CompletionStage;

    move-result-object p1

    return-object p1
.end method
