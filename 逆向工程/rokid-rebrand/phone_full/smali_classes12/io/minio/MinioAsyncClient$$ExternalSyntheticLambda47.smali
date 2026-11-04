.class public final synthetic Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda47;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Function;


# instance fields
.field public final synthetic f$0:Lio/minio/GetBucketPolicyArgs;


# direct methods
.method public synthetic constructor <init>(Lio/minio/GetBucketPolicyArgs;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda47;->f$0:Lio/minio/GetBucketPolicyArgs;

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .line 0
    iget-object v0, p0, Lio/minio/MinioAsyncClient$$ExternalSyntheticLambda47;->f$0:Lio/minio/GetBucketPolicyArgs;

    check-cast p1, Lokhttp3/Response;

    invoke-static {v0, p1}, Lio/minio/MinioAsyncClient;->lambda$getBucketPolicy$44(Lio/minio/GetBucketPolicyArgs;Lokhttp3/Response;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method
