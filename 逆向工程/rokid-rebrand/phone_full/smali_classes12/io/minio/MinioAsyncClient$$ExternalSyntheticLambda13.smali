.class public final synthetic Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda13;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Function;


# direct methods
.method public synthetic constructor <init>()V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 0
    check-cast p1, Lio/minio/StatObjectResponse;

    invoke-static {p1}, Lio/minio/MinioAsyncClient;->lambda$copyObject$5(Lio/minio/StatObjectResponse;)Ljava/lang/Long;

    move-result-object p1

    return-object p1
.end method
