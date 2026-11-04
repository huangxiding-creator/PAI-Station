.class Lio/minio/S3Base$2;
.super Ljava/lang/Object;
.source "S3Base.java"

# interfaces
.implements Ljava/lang/Iterable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lio/minio/S3Base;->listObjectsV2(Lio/minio/ListObjectsArgs;)Ljava/lang/Iterable;
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
        "Lio/minio/messages/Item;",
        ">;>;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lio/minio/S3Base;

.field final synthetic val$args:Lio/minio/ListObjectsArgs;


# direct methods
.method constructor <init>(Lio/minio/S3Base;Lio/minio/ListObjectsArgs;)V
    .locals 0
    .param p1, "this$0"    # Lio/minio/S3Base;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 1368
    iput-object p1, p0, Lio/minio/S3Base$2;->this$0:Lio/minio/S3Base;

    iput-object p2, p0, Lio/minio/S3Base$2;->val$args:Lio/minio/ListObjectsArgs;

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
            "Lio/minio/messages/Item;",
            ">;>;"
        }
    .end annotation

    .line 1371
    new-instance v0, Lio/minio/S3Base$2$1;

    invoke-direct {v0, p0}, Lio/minio/S3Base$2$1;-><init>(Lio/minio/S3Base$2;)V

    return-object v0
.end method
