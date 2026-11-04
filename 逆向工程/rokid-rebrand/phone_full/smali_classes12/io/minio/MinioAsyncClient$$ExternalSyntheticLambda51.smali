.class public final synthetic Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda51;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Function;


# instance fields
.field public final synthetic f$0:Lio/minio/MinioAsyncClient;

.field public final synthetic f$1:Lio/minio/ComposeObjectArgs;

.field public final synthetic f$2:[I

.field public final synthetic f$3:Ljava/util/List;


# direct methods
.method public synthetic constructor <init>(Lio/minio/MinioAsyncClient;Lio/minio/ComposeObjectArgs;[ILjava/util/List;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda51;->f$0:Lio/minio/MinioAsyncClient;

    iput-object p2, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda51;->f$1:Lio/minio/ComposeObjectArgs;

    iput-object p3, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda51;->f$2:[I

    iput-object p4, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda51;->f$3:Ljava/util/List;

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 4

    .line 0
    iget-object v0, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda51;->f$0:Lio/minio/MinioAsyncClient;

    iget-object v1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda51;->f$1:Lio/minio/ComposeObjectArgs;

    iget-object v2, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda51;->f$2:[I

    iget-object v3, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda51;->f$3:Ljava/util/List;

    check-cast p1, Ljava/lang/String;

    invoke-virtual {v0, v1, v2, v3, p1}, Lio/minio/MinioAsyncClient;->lambda$composeObject$18$io-minio-MinioAsyncClient(Lio/minio/ComposeObjectArgs;[ILjava/util/List;Ljava/lang/String;)Ljava/util/concurrent/CompletionStage;

    move-result-object p1

    return-object p1
.end method
