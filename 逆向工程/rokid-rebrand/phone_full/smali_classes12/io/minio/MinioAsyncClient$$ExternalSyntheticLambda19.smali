.class public final synthetic Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda19;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Function;


# instance fields
.field public final synthetic f$0:[Lio/minio/messages/Part;

.field public final synthetic f$1:I


# direct methods
.method public synthetic constructor <init>([Lio/minio/messages/Part;I)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda19;->f$0:[Lio/minio/messages/Part;

    iput p2, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda19;->f$1:I

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2

    .line 0
    iget-object v0, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda19;->f$0:[Lio/minio/messages/Part;

    iget v1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda19;->f$1:I

    check-cast p1, Lio/minio/UploadPartCopyResponse;

    invoke-static {v0, v1, p1}, Lio/minio/MinioAsyncClient;->lambda$uploadPartCopy$9([Lio/minio/messages/Part;ILio/minio/UploadPartCopyResponse;)[Lio/minio/messages/Part;

    move-result-object p1

    return-object p1
.end method
