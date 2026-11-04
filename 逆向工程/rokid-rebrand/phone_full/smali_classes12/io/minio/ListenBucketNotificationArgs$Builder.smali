.class public final Lio/minio/ListenBucketNotificationArgs$Builder;
.super Lio/minio/BucketArgs$Builder;
.source "ListenBucketNotificationArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/ListenBucketNotificationArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/BucketArgs$Builder<",
        "Lio/minio/ListenBucketNotificationArgs$Builder;",
        "Lio/minio/ListenBucketNotificationArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 48
    invoke-direct {p0}, Lio/minio/BucketArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$events$2([Ljava/lang/String;Lio/minio/ListenBucketNotificationArgs;)V
    .locals 0
    .param p0, "eventsCopy"    # [Ljava/lang/String;
    .param p1, "args"    # Lio/minio/ListenBucketNotificationArgs;

    .line 74
    invoke-static {p1, p0}, Lio/minio/ListenBucketNotificationArgs;->access$002(Lio/minio/ListenBucketNotificationArgs;[Ljava/lang/String;)[Ljava/lang/String;

    return-void
.end method

.method static synthetic lambda$prefix$0(Ljava/lang/String;Lio/minio/ListenBucketNotificationArgs;)V
    .locals 0
    .param p0, "prefix"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/ListenBucketNotificationArgs;

    .line 62
    invoke-static {p1, p0}, Lio/minio/ListenBucketNotificationArgs;->access$202(Lio/minio/ListenBucketNotificationArgs;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method

.method static synthetic lambda$suffix$1(Ljava/lang/String;Lio/minio/ListenBucketNotificationArgs;)V
    .locals 0
    .param p0, "suffix"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/ListenBucketNotificationArgs;

    .line 67
    invoke-static {p1, p0}, Lio/minio/ListenBucketNotificationArgs;->access$102(Lio/minio/ListenBucketNotificationArgs;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method

.method private validateEvents([Ljava/lang/String;)V
    .locals 1
    .param p1, "events"    # [Ljava/lang/String;

    .line 51
    const-string v0, "events"

    invoke-virtual {p0, p1, v0}, Lio/minio/ListenBucketNotificationArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 52
    return-void
.end method


# virtual methods
.method public events([Ljava/lang/String;)Lio/minio/ListenBucketNotificationArgs$Builder;
    .locals 3
    .param p1, "events"    # [Ljava/lang/String;

    .line 72
    invoke-direct {p0, p1}, Lio/minio/ListenBucketNotificationArgs$Builder;->validateEvents([Ljava/lang/String;)V

    .line 73
    array-length v0, p1

    invoke-static {p1, v0}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Ljava/lang/String;

    .line 74
    .local v0, "eventsCopy":[Ljava/lang/String;
    iget-object v1, p0, Lio/minio/ListenBucketNotificationArgs$Builder;->operations:Ljava/util/List;

    new-instance v2, Lio/minio/ListenBucketNotificationArgs$Builder$$ExternalSyntheticLambda2;

    invoke-direct {v2, v0}, Lio/minio/ListenBucketNotificationArgs$Builder$$ExternalSyntheticLambda2;-><init>([Ljava/lang/String;)V

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 75
    return-object p0
.end method

.method public prefix(Ljava/lang/String;)Lio/minio/ListenBucketNotificationArgs$Builder;
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;

    .line 62
    iget-object v0, p0, Lio/minio/ListenBucketNotificationArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ListenBucketNotificationArgs$Builder$$ExternalSyntheticLambda1;

    invoke-direct {v1, p1}, Lio/minio/ListenBucketNotificationArgs$Builder$$ExternalSyntheticLambda1;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 63
    return-object p0
.end method

.method public suffix(Ljava/lang/String;)Lio/minio/ListenBucketNotificationArgs$Builder;
    .locals 2
    .param p1, "suffix"    # Ljava/lang/String;

    .line 67
    iget-object v0, p0, Lio/minio/ListenBucketNotificationArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/ListenBucketNotificationArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/ListenBucketNotificationArgs$Builder$$ExternalSyntheticLambda0;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 68
    return-object p0
.end method

.method protected bridge synthetic validate(Lio/minio/BaseArgs;)V
    .locals 0

    .line 48
    check-cast p1, Lio/minio/ListenBucketNotificationArgs;

    invoke-virtual {p0, p1}, Lio/minio/ListenBucketNotificationArgs$Builder;->validate(Lio/minio/ListenBucketNotificationArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/BucketArgs;)V
    .locals 0

    .line 48
    check-cast p1, Lio/minio/ListenBucketNotificationArgs;

    invoke-virtual {p0, p1}, Lio/minio/ListenBucketNotificationArgs$Builder;->validate(Lio/minio/ListenBucketNotificationArgs;)V

    return-void
.end method

.method protected validate(Lio/minio/ListenBucketNotificationArgs;)V
    .locals 1
    .param p1, "args"    # Lio/minio/ListenBucketNotificationArgs;

    .line 55
    iget-object v0, p1, Lio/minio/ListenBucketNotificationArgs;->bucketName:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 56
    invoke-super {p0, p1}, Lio/minio/BucketArgs$Builder;->validate(Lio/minio/BucketArgs;)V

    .line 58
    :cond_0
    invoke-static {p1}, Lio/minio/ListenBucketNotificationArgs;->access$000(Lio/minio/ListenBucketNotificationArgs;)[Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lio/minio/ListenBucketNotificationArgs$Builder;->validateEvents([Ljava/lang/String;)V

    .line 59
    return-void
.end method
