.class Lio/minio/MinioAsyncClient$1;
.super Ljava/lang/Object;
.source "MinioAsyncClient.java"

# interfaces
.implements Ljava/lang/Iterable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/minio/MinioAsyncClient;->removeObjects(Lio/minio/RemoveObjectsArgs;)Ljava/lang/Iterable;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/lang/Iterable<",
        "Lio/minio/Result<",
        "Lio/minio/messages/DeleteError;",
        ">;>;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lio/minio/MinioAsyncClient;

.field final synthetic val$args:Lio/minio/RemoveObjectsArgs;


# direct methods
.method constructor <init>(Lio/minio/MinioAsyncClient;Lio/minio/RemoveObjectsArgs;)V
    .locals 0
    .param p1, "this$0"    # Lio/minio/MinioAsyncClient;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 1115
    iput-object p1, p0, Lio/minio/MinioAsyncClient$1;->this$0:Lio/minio/MinioAsyncClient;

    iput-object p2, p0, Lio/minio/MinioAsyncClient$1;->val$args:Lio/minio/RemoveObjectsArgs;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public iterator()Ljava/util/Iterator;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Iterator<",
            "Lio/minio/Result<",
            "Lio/minio/messages/DeleteError;",
            ">;>;"
        }
    .end annotation

    .line 1118
    new-instance v0, Lio/minio/MinioAsyncClient$1$1;

    invoke-direct {v0, p0}, Lio/minio/MinioAsyncClient$1$1;-><init>(Lio/minio/MinioAsyncClient$1;)V

    return-object v0
.end method
