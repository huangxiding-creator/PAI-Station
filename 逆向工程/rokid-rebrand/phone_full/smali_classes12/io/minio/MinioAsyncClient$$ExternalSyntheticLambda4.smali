.class public final synthetic Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda4;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Supplier;


# instance fields
.field public final synthetic f$0:Lio/minio/UploadSnowballObjectsArgs;


# direct methods
.method public synthetic constructor <init>(Lio/minio/UploadSnowballObjectsArgs;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda4;->f$0:Lio/minio/UploadSnowballObjectsArgs;

    return-void
.end method


# virtual methods
.method public final get()Ljava/lang/Object;
    .locals 1

    .line 0
    iget-object v0, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda4;->f$0:Lio/minio/UploadSnowballObjectsArgs;

    invoke-static {v0}, Lio/minio/MinioAsyncClient;->lambda$uploadSnowballObjects$71(Lio/minio/UploadSnowballObjectsArgs;)Ljava/io/ByteArrayOutputStream;

    move-result-object v0

    return-object v0
.end method
