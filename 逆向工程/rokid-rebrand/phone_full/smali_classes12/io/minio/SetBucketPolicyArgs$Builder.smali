.class public final Lio/minio/SetBucketPolicyArgs$Builder;
.super Lio/minio/BucketArgs$Builder;
.source "SetBucketPolicyArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/SetBucketPolicyArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/BucketArgs$Builder<",
        "Lio/minio/SetBucketPolicyArgs$Builder;",
        "Lio/minio/SetBucketPolicyArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 37
    invoke-direct {p0}, Lio/minio/BucketArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$config$0(Ljava/lang/String;Lio/minio/SetBucketPolicyArgs;)V
    .locals 0
    .param p0, "config"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/SetBucketPolicyArgs;

    .line 50
    invoke-static {p1, p0}, Lio/minio/SetBucketPolicyArgs;->access$002(Lio/minio/SetBucketPolicyArgs;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method

.method private validateConfig(Ljava/lang/String;)V
    .locals 1
    .param p1, "config"    # Ljava/lang/String;

    .line 39
    const-string v0, "policy configuration"

    invoke-virtual {p0, p1, v0}, Lio/minio/SetBucketPolicyArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 40
    return-void
.end method


# virtual methods
.method public config(Ljava/lang/String;)Lio/minio/SetBucketPolicyArgs$Builder;
    .locals 2
    .param p1, "config"    # Ljava/lang/String;

    .line 49
    invoke-direct {p0, p1}, Lio/minio/SetBucketPolicyArgs$Builder;->validateConfig(Ljava/lang/String;)V

    .line 50
    iget-object v0, p0, Lio/minio/SetBucketPolicyArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/SetBucketPolicyArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/SetBucketPolicyArgs$Builder$$ExternalSyntheticLambda0;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 51
    return-object p0
.end method

.method protected bridge synthetic validate(Lio/minio/BaseArgs;)V
    .locals 0

    .line 37
    check-cast p1, Lio/minio/SetBucketPolicyArgs;

    invoke-virtual {p0, p1}, Lio/minio/SetBucketPolicyArgs$Builder;->validate(Lio/minio/SetBucketPolicyArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/BucketArgs;)V
    .locals 0

    .line 37
    check-cast p1, Lio/minio/SetBucketPolicyArgs;

    invoke-virtual {p0, p1}, Lio/minio/SetBucketPolicyArgs$Builder;->validate(Lio/minio/SetBucketPolicyArgs;)V

    return-void
.end method

.method protected validate(Lio/minio/SetBucketPolicyArgs;)V
    .locals 1
    .param p1, "args"    # Lio/minio/SetBucketPolicyArgs;

    .line 44
    invoke-super {p0, p1}, Lio/minio/BucketArgs$Builder;->validate(Lio/minio/BucketArgs;)V

    .line 45
    invoke-static {p1}, Lio/minio/SetBucketPolicyArgs;->access$000(Lio/minio/SetBucketPolicyArgs;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lio/minio/SetBucketPolicyArgs$Builder;->validateConfig(Ljava/lang/String;)V

    .line 46
    return-void
.end method
