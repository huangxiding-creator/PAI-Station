.class public final synthetic Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda53;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Function;


# instance fields
.field public final synthetic f$0:Lio/minio/MinioAsyncClient;

.field public final synthetic f$1:[Ljava/lang/String;

.field public final synthetic f$2:Lio/minio/ComposeObjectArgs;


# direct methods
.method public synthetic constructor <init>(Lio/minio/MinioAsyncClient;[Ljava/lang/String;Lio/minio/ComposeObjectArgs;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda53;->f$0:Lio/minio/MinioAsyncClient;

    iput-object p2, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda53;->f$1:[Ljava/lang/String;

    iput-object p3, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda53;->f$2:Lio/minio/ComposeObjectArgs;

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 3

    .line 0
    iget-object v0, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda53;->f$0:Lio/minio/MinioAsyncClient;

    iget-object v1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda53;->f$1:[Ljava/lang/String;

    iget-object v2, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda53;->f$2:Lio/minio/ComposeObjectArgs;

    check-cast p1, Ljava/lang/Throwable;

    invoke-virtual {v0, v1, v2, p1}, Lio/minio/MinioAsyncClient;->lambda$composeObject$20$io-minio-MinioAsyncClient([Ljava/lang/String;Lio/minio/ComposeObjectArgs;Ljava/lang/Throwable;)Lio/minio/ObjectWriteResponse;

    move-result-object p1

    return-object p1
.end method
