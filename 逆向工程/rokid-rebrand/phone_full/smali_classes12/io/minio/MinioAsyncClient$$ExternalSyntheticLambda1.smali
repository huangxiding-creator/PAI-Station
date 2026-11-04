.class public final synthetic Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Consumer;


# instance fields
.field public final synthetic f$0:Lio/minio/MinioAsyncClient;

.field public final synthetic f$1:Lio/minio/MakeBucketArgs;

.field public final synthetic f$2:Ljava/lang/String;


# direct methods
.method public synthetic constructor <init>(Lio/minio/MinioAsyncClient;Lio/minio/MakeBucketArgs;Ljava/lang/String;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda1;->f$0:Lio/minio/MinioAsyncClient;

    iput-object p2, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda1;->f$1:Lio/minio/MakeBucketArgs;

    iput-object p3, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda1;->f$2:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final accept(Ljava/lang/Object;)V
    .locals 3

    .line 0
    iget-object v0, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda1;->f$0:Lio/minio/MinioAsyncClient;

    iget-object v1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda1;->f$1:Lio/minio/MakeBucketArgs;

    iget-object v2, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda1;->f$2:Ljava/lang/String;

    check-cast p1, Lokhttp3/Response;

    invoke-virtual {v0, v1, v2, p1}, Lio/minio/MinioAsyncClient;->lambda$makeBucket$27$io-minio-MinioAsyncClient(Lio/minio/MakeBucketArgs;Ljava/lang/String;Lokhttp3/Response;)V

    return-void
.end method
