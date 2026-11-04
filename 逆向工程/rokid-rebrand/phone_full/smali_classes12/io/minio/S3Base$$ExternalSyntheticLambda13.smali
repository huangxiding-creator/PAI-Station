.class public final synthetic Lio/minio/S3Base$$ExternalSyntheticLambda13;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Function;


# instance fields
.field public final synthetic f$0:Lio/minio/S3Base;

.field public final synthetic f$1:Ljava/lang/String;


# direct methods
.method public synthetic constructor <init>(Lio/minio/S3Base;Ljava/lang/String;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/S3Base$$ExternalSyntheticLambda13;->f$0:Lio/minio/S3Base;

    iput-object p2, p0, Lio/minio/S3Base$$ExternalSyntheticLambda13;->f$1:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2

    .line 0
    iget-object v0, p0, Lio/minio/S3Base$$ExternalSyntheticLambda13;->f$0:Lio/minio/S3Base;

    iget-object v1, p0, Lio/minio/S3Base$$ExternalSyntheticLambda13;->f$1:Ljava/lang/String;

    check-cast p1, Lokhttp3/Response;

    invoke-virtual {v0, v1, p1}, Lio/minio/S3Base;->lambda$getRegionAsync$2$io-minio-S3Base(Ljava/lang/String;Lokhttp3/Response;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method
