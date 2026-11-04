.class public final synthetic Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda36;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Function;


# instance fields
.field public final synthetic f$0:[I

.field public final synthetic f$1:Lio/minio/ComposeObjectArgs;


# direct methods
.method public synthetic constructor <init>([ILio/minio/ComposeObjectArgs;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda36;->f$0:[I

    iput-object p2, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda36;->f$1:Lio/minio/ComposeObjectArgs;

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2

    .line 0
    iget-object v0, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda36;->f$0:[I

    iget-object v1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda36;->f$1:Lio/minio/ComposeObjectArgs;

    check-cast p1, Ljava/lang/Integer;

    invoke-static {v0, v1, p1}, Lio/minio/MinioAsyncClient;->lambda$composeObject$10([ILio/minio/ComposeObjectArgs;Ljava/lang/Integer;)Ljava/lang/Boolean;

    move-result-object p1

    return-object p1
.end method
