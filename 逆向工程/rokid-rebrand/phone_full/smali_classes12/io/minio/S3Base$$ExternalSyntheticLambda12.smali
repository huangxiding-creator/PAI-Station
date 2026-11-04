.class public final synthetic Lio/minio/S3Base$$ExternalSyntheticLambda12;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Function;


# instance fields
.field public final synthetic f$0:Lio/minio/StatObjectArgs;


# direct methods
.method public synthetic constructor <init>(Lio/minio/StatObjectArgs;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/S3Base$$ExternalSyntheticLambda12;->f$0:Lio/minio/StatObjectArgs;

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .line 0
    iget-object v0, p0, Lio/minio/S3Base$$ExternalSyntheticLambda12;->f$0:Lio/minio/StatObjectArgs;

    check-cast p1, Lokhttp3/Response;

    invoke-static {v0, p1}, Lio/minio/S3Base;->lambda$statObjectAsync$8(Lio/minio/StatObjectArgs;Lokhttp3/Response;)Lio/minio/StatObjectResponse;

    move-result-object p1

    return-object p1
.end method
