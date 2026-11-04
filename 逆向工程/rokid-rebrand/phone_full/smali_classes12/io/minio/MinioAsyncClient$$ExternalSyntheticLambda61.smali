.class public final synthetic Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda61;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Function;


# instance fields
.field public final synthetic f$0:Lio/minio/CopyObjectArgs;


# direct methods
.method public synthetic constructor <init>(Lio/minio/CopyObjectArgs;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda61;->f$0:Lio/minio/CopyObjectArgs;

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .line 0
    iget-object v0, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda61;->f$0:Lio/minio/CopyObjectArgs;

    check-cast p1, Lokhttp3/Response;

    invoke-static {v0, p1}, Lio/minio/MinioAsyncClient;->lambda$copyObject$7(Lio/minio/CopyObjectArgs;Lokhttp3/Response;)Lio/minio/ObjectWriteResponse;

    move-result-object p1

    return-object p1
.end method
