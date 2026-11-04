.class public final synthetic Lio/minio/S3Base$$ExternalSyntheticLambda10;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/BiFunction;


# instance fields
.field public final synthetic f$0:Lio/minio/ComposeSource;

.field public final synthetic f$1:Ljava/util/List;

.field public final synthetic f$2:I

.field public final synthetic f$3:[J


# direct methods
.method public synthetic constructor <init>(Lio/minio/ComposeSource;Ljava/util/List;I[J)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/S3Base$$ExternalSyntheticLambda10;->f$0:Lio/minio/ComposeSource;

    iput-object p2, p0, Lio/minio/S3Base$$ExternalSyntheticLambda10;->f$1:Ljava/util/List;

    iput p3, p0, Lio/minio/S3Base$$ExternalSyntheticLambda10;->f$2:I

    iput-object p4, p0, Lio/minio/S3Base$$ExternalSyntheticLambda10;->f$3:[J

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 6

    .line 0
    iget-object v0, p0, Lio/minio/S3Base$$ExternalSyntheticLambda10;->f$0:Lio/minio/ComposeSource;

    iget-object v1, p0, Lio/minio/S3Base$$ExternalSyntheticLambda10;->f$1:Ljava/util/List;

    iget v2, p0, Lio/minio/S3Base$$ExternalSyntheticLambda10;->f$2:I

    iget-object v3, p0, Lio/minio/S3Base$$ExternalSyntheticLambda10;->f$3:[J

    move-object v4, p1

    check-cast v4, Ljava/lang/Integer;

    move-object v5, p2

    check-cast v5, Lio/minio/StatObjectResponse;

    invoke-static/range {v0 .. v5}, Lio/minio/S3Base;->lambda$calculatePartCountAsync$7(Lio/minio/ComposeSource;Ljava/util/List;I[JLjava/lang/Integer;Lio/minio/StatObjectResponse;)Ljava/lang/Integer;

    move-result-object p1

    return-object p1
.end method
