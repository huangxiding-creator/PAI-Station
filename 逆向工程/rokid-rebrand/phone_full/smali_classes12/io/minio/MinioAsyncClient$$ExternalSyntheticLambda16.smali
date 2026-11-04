.class public final synthetic Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda16;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Consumer;


# instance fields
.field public final synthetic f$0:Lio/minio/MinioAsyncClient;

.field public final synthetic f$1:Lio/minio/RemoveBucketArgs;


# direct methods
.method public synthetic constructor <init>(Lio/minio/MinioAsyncClient;Lio/minio/RemoveBucketArgs;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda16;->f$0:Lio/minio/MinioAsyncClient;

    iput-object p2, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda16;->f$1:Lio/minio/RemoveBucketArgs;

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 2

    .line 0
    iget-object v0, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda16;->f$0:Lio/minio/MinioAsyncClient;

    iget-object v1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda16;->f$1:Lio/minio/RemoveBucketArgs;

    check-cast p1, Lokhttp3/Response;

    invoke-virtual {v0, v1, p1}, Lio/minio/MinioAsyncClient;->lambda$removeBucket$40$io-minio-MinioAsyncClient(Lio/minio/RemoveBucketArgs;Lokhttp3/Response;)V

    return-void
.end method
