.class public final synthetic Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda27;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Function;


# instance fields
.field public final synthetic f$0:Lio/minio/MinioAsyncClient;

.field public final synthetic f$1:Lio/minio/ComposeObjectArgs;

.field public final synthetic f$2:Ljava/lang/String;

.field public final synthetic f$3:I

.field public final synthetic f$4:Lcom/google/common/collect/Multimap;


# direct methods
.method public synthetic constructor <init>(Lio/minio/MinioAsyncClient;Lio/minio/ComposeObjectArgs;Ljava/lang/String;ILcom/google/common/collect/Multimap;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda27;->f$0:Lio/minio/MinioAsyncClient;

    iput-object p2, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda27;->f$1:Lio/minio/ComposeObjectArgs;

    iput-object p3, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda27;->f$2:Ljava/lang/String;

    iput p4, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda27;->f$3:I

    iput-object p5, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda27;->f$4:Lcom/google/common/collect/Multimap;

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 6

    .line 0
    iget-object v0, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda27;->f$0:Lio/minio/MinioAsyncClient;

    iget-object v1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda27;->f$1:Lio/minio/ComposeObjectArgs;

    iget-object v2, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda27;->f$2:Ljava/lang/String;

    iget v3, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda27;->f$3:I

    iget-object v4, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda27;->f$4:Lcom/google/common/collect/Multimap;

    move-object v5, p1

    check-cast v5, [Lio/minio/messages/Part;

    invoke-virtual/range {v0 .. v5}, Lio/minio/MinioAsyncClient;->lambda$composeObject$17$io-minio-MinioAsyncClient(Lio/minio/ComposeObjectArgs;Ljava/lang/String;ILcom/google/common/collect/Multimap;[Lio/minio/messages/Part;)Ljava/util/concurrent/CompletionStage;

    move-result-object p1

    return-object p1
.end method
