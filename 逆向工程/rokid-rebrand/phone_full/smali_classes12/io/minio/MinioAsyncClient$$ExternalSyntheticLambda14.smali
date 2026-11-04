.class public final synthetic Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda14;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Function;


# instance fields
.field public final synthetic f$0:Lio/minio/MinioAsyncClient;

.field public final synthetic f$1:Lio/minio/CopyObjectArgs;


# direct methods
.method public synthetic constructor <init>(Lio/minio/MinioAsyncClient;Lio/minio/CopyObjectArgs;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda14;->f$0:Lio/minio/MinioAsyncClient;

    iput-object p2, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda14;->f$1:Lio/minio/CopyObjectArgs;

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2

    .line 0
    iget-object v0, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda14;->f$0:Lio/minio/MinioAsyncClient;

    iget-object v1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda14;->f$1:Lio/minio/CopyObjectArgs;

    check-cast p1, Ljava/lang/Long;

    invoke-virtual {v0, v1, p1}, Lio/minio/MinioAsyncClient;->lambda$copyObject$6$io-minio-MinioAsyncClient(Lio/minio/CopyObjectArgs;Ljava/lang/Long;)Ljava/util/concurrent/CompletionStage;

    move-result-object p1

    return-object p1
.end method
