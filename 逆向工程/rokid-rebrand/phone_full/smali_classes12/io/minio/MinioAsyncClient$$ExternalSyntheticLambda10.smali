.class public final synthetic Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda10;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Supplier;


# instance fields
.field public final synthetic f$0:Lio/minio/CopyObjectArgs;


# direct methods
.method public synthetic constructor <init>(Lio/minio/CopyObjectArgs;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda10;->f$0:Lio/minio/CopyObjectArgs;

    return-void
.end method


# virtual methods
.method public final get()Ljava/lang/Object;
    .locals 1

    .line 0
    iget-object v0, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda10;->f$0:Lio/minio/CopyObjectArgs;

    invoke-static {v0}, Lio/minio/MinioAsyncClient;->lambda$copyObject$3(Lio/minio/CopyObjectArgs;)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0
.end method
