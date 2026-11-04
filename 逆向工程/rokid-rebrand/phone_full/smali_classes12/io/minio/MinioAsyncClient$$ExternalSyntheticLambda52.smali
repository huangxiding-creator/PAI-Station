.class public final synthetic Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda52;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Function;


# instance fields
.field public final synthetic f$0:Lio/minio/MinioAsyncClient;

.field public final synthetic f$1:Lio/minio/ComposeObjectArgs;

.field public final synthetic f$2:[Ljava/lang/String;


# direct methods
.method public synthetic constructor <init>(Lio/minio/MinioAsyncClient;Lio/minio/ComposeObjectArgs;[Ljava/lang/String;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda52;->f$0:Lio/minio/MinioAsyncClient;

    iput-object p2, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda52;->f$1:Lio/minio/ComposeObjectArgs;

    iput-object p3, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda52;->f$2:[Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 3

    .line 0
    iget-object v0, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda52;->f$0:Lio/minio/MinioAsyncClient;

    iget-object v1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda52;->f$1:Lio/minio/ComposeObjectArgs;

    iget-object v2, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda52;->f$2:[Ljava/lang/String;

    check-cast p1, [Lio/minio/messages/Part;

    invoke-virtual {v0, v1, v2, p1}, Lio/minio/MinioAsyncClient;->lambda$composeObject$19$io-minio-MinioAsyncClient(Lio/minio/ComposeObjectArgs;[Ljava/lang/String;[Lio/minio/messages/Part;)Ljava/util/concurrent/CompletionStage;

    move-result-object p1

    return-object p1
.end method
