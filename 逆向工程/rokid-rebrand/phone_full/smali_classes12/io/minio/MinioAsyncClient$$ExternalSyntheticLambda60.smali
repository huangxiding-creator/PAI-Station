.class public final synthetic Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda60;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Function;


# instance fields
.field public final synthetic f$0:Ljava/io/RandomAccessFile;


# direct methods
.method public synthetic constructor <init>(Ljava/io/RandomAccessFile;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda60;->f$0:Ljava/io/RandomAccessFile;

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .line 0
    iget-object v0, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda60;->f$0:Ljava/io/RandomAccessFile;

    check-cast p1, Lio/minio/ObjectWriteResponse;

    invoke-static {v0, p1}, Lio/minio/MinioAsyncClient;->lambda$uploadObject$42(Ljava/io/RandomAccessFile;Lio/minio/ObjectWriteResponse;)Lio/minio/ObjectWriteResponse;

    move-result-object p1

    return-object p1
.end method
