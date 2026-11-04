.class public final Lio/minio/SetBucketLifecycleArgs$Builder;
.super Lio/minio/BucketArgs$Builder;
.source "SetBucketLifecycleArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/SetBucketLifecycleArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/BucketArgs$Builder<",
        "Lio/minio/SetBucketLifecycleArgs$Builder;",
        "Lio/minio/SetBucketLifecycleArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 39
    invoke-direct {p0}, Lio/minio/BucketArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$config$0(Lio/minio/messages/LifecycleConfiguration;Lio/minio/SetBucketLifecycleArgs;)V
    .locals 0
    .param p0, "config"    # Lio/minio/messages/LifecycleConfiguration;
    .param p1, "args"    # Lio/minio/SetBucketLifecycleArgs;

    .line 51
    invoke-static {p1, p0}, Lio/minio/SetBucketLifecycleArgs;->access$002(Lio/minio/SetBucketLifecycleArgs;Lio/minio/messages/LifecycleConfiguration;)Lio/minio/messages/LifecycleConfiguration;

    return-void
.end method

.method private validateConfig(Lio/minio/messages/LifecycleConfiguration;)V
    .locals 1
    .param p1, "config"    # Lio/minio/messages/LifecycleConfiguration;

    .line 41
    const-string v0, "lifecycle configuration"

    invoke-virtual {p0, p1, v0}, Lio/minio/SetBucketLifecycleArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 42
    return-void
.end method


# virtual methods
.method public config(Lio/minio/messages/LifecycleConfiguration;)Lio/minio/SetBucketLifecycleArgs$Builder;
    .locals 2
    .param p1, "config"    # Lio/minio/messages/LifecycleConfiguration;

    .line 50
    invoke-direct {p0, p1}, Lio/minio/SetBucketLifecycleArgs$Builder;->validateConfig(Lio/minio/messages/LifecycleConfiguration;)V

    .line 51
    iget-object v0, p0, Lio/minio/SetBucketLifecycleArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/SetBucketLifecycleArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/SetBucketLifecycleArgs$Builder$$ExternalSyntheticLambda0;-><init>(Lio/minio/messages/LifecycleConfiguration;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 52
    return-object p0
.end method

.method protected bridge synthetic validate(Lio/minio/BaseArgs;)V
    .locals 0

    .line 39
    check-cast p1, Lio/minio/SetBucketLifecycleArgs;

    invoke-virtual {p0, p1}, Lio/minio/SetBucketLifecycleArgs$Builder;->validate(Lio/minio/SetBucketLifecycleArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/BucketArgs;)V
    .locals 0

    .line 39
    check-cast p1, Lio/minio/SetBucketLifecycleArgs;

    invoke-virtual {p0, p1}, Lio/minio/SetBucketLifecycleArgs$Builder;->validate(Lio/minio/SetBucketLifecycleArgs;)V

    return-void
.end method

.method protected validate(Lio/minio/SetBucketLifecycleArgs;)V
    .locals 1
    .param p1, "args"    # Lio/minio/SetBucketLifecycleArgs;

    .line 45
    invoke-super {p0, p1}, Lio/minio/BucketArgs$Builder;->validate(Lio/minio/BucketArgs;)V

    .line 46
    invoke-static {p1}, Lio/minio/SetBucketLifecycleArgs;->access$000(Lio/minio/SetBucketLifecycleArgs;)Lio/minio/messages/LifecycleConfiguration;

    move-result-object v0

    invoke-direct {p0, v0}, Lio/minio/SetBucketLifecycleArgs$Builder;->validateConfig(Lio/minio/messages/LifecycleConfiguration;)V

    .line 47
    return-void
.end method
