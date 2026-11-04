.class public final Lio/minio/SetBucketReplicationArgs$Builder;
.super Lio/minio/BucketArgs$Builder;
.source "SetBucketReplicationArgs.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lio/minio/SetBucketReplicationArgs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lio/minio/BucketArgs$Builder<",
        "Lio/minio/SetBucketReplicationArgs$Builder;",
        "Lio/minio/SetBucketReplicationArgs;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 43
    invoke-direct {p0}, Lio/minio/BucketArgs$Builder;-><init>()V

    return-void
.end method

.method static synthetic lambda$config$0(Lio/minio/messages/ReplicationConfiguration;Lio/minio/SetBucketReplicationArgs;)V
    .locals 0
    .param p0, "config"    # Lio/minio/messages/ReplicationConfiguration;
    .param p1, "args"    # Lio/minio/SetBucketReplicationArgs;

    .line 61
    invoke-static {p1, p0}, Lio/minio/SetBucketReplicationArgs;->access$002(Lio/minio/SetBucketReplicationArgs;Lio/minio/messages/ReplicationConfiguration;)Lio/minio/messages/ReplicationConfiguration;

    return-void
.end method

.method static synthetic lambda$objectLockToken$1(Ljava/lang/String;Lio/minio/SetBucketReplicationArgs;)V
    .locals 0
    .param p0, "token"    # Ljava/lang/String;
    .param p1, "args"    # Lio/minio/SetBucketReplicationArgs;

    .line 67
    invoke-static {p1, p0}, Lio/minio/SetBucketReplicationArgs;->access$102(Lio/minio/SetBucketReplicationArgs;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method

.method private validateConfig(Lio/minio/messages/ReplicationConfiguration;)V
    .locals 1
    .param p1, "config"    # Lio/minio/messages/ReplicationConfiguration;

    .line 45
    const-string v0, "replication configuration"

    invoke-virtual {p0, p1, v0}, Lio/minio/SetBucketReplicationArgs$Builder;->validateNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 46
    return-void
.end method

.method private validateObjectLockToken(Ljava/lang/String;)V
    .locals 1
    .param p1, "token"    # Ljava/lang/String;

    .line 49
    const-string v0, "object lock token"

    invoke-virtual {p0, p1, v0}, Lio/minio/SetBucketReplicationArgs$Builder;->validateNullOrNotEmptyString(Ljava/lang/String;Ljava/lang/String;)V

    .line 50
    return-void
.end method


# virtual methods
.method public config(Lio/minio/messages/ReplicationConfiguration;)Lio/minio/SetBucketReplicationArgs$Builder;
    .locals 2
    .param p1, "config"    # Lio/minio/messages/ReplicationConfiguration;

    .line 60
    invoke-direct {p0, p1}, Lio/minio/SetBucketReplicationArgs$Builder;->validateConfig(Lio/minio/messages/ReplicationConfiguration;)V

    .line 61
    iget-object v0, p0, Lio/minio/SetBucketReplicationArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/SetBucketReplicationArgs$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lio/minio/SetBucketReplicationArgs$Builder$$ExternalSyntheticLambda0;-><init>(Lio/minio/messages/ReplicationConfiguration;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 62
    return-object p0
.end method

.method public objectLockToken(Ljava/lang/String;)Lio/minio/SetBucketReplicationArgs$Builder;
    .locals 2
    .param p1, "token"    # Ljava/lang/String;

    .line 66
    invoke-direct {p0, p1}, Lio/minio/SetBucketReplicationArgs$Builder;->validateObjectLockToken(Ljava/lang/String;)V

    .line 67
    iget-object v0, p0, Lio/minio/SetBucketReplicationArgs$Builder;->operations:Ljava/util/List;

    new-instance v1, Lio/minio/SetBucketReplicationArgs$Builder$$ExternalSyntheticLambda1;

    invoke-direct {v1, p1}, Lio/minio/SetBucketReplicationArgs$Builder$$ExternalSyntheticLambda1;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 68
    return-object p0
.end method

.method protected bridge synthetic validate(Lio/minio/BaseArgs;)V
    .locals 0

    .line 43
    check-cast p1, Lio/minio/SetBucketReplicationArgs;

    invoke-virtual {p0, p1}, Lio/minio/SetBucketReplicationArgs$Builder;->validate(Lio/minio/SetBucketReplicationArgs;)V

    return-void
.end method

.method protected bridge synthetic validate(Lio/minio/BucketArgs;)V
    .locals 0

    .line 43
    check-cast p1, Lio/minio/SetBucketReplicationArgs;

    invoke-virtual {p0, p1}, Lio/minio/SetBucketReplicationArgs$Builder;->validate(Lio/minio/SetBucketReplicationArgs;)V

    return-void
.end method

.method protected validate(Lio/minio/SetBucketReplicationArgs;)V
    .locals 1
    .param p1, "args"    # Lio/minio/SetBucketReplicationArgs;

    .line 54
    invoke-super {p0, p1}, Lio/minio/BucketArgs$Builder;->validate(Lio/minio/BucketArgs;)V

    .line 55
    invoke-static {p1}, Lio/minio/SetBucketReplicationArgs;->access$000(Lio/minio/SetBucketReplicationArgs;)Lio/minio/messages/ReplicationConfiguration;

    move-result-object v0

    invoke-direct {p0, v0}, Lio/minio/SetBucketReplicationArgs$Builder;->validateConfig(Lio/minio/messages/ReplicationConfiguration;)V

    .line 56
    invoke-static {p1}, Lio/minio/SetBucketReplicationArgs;->access$100(Lio/minio/SetBucketReplicationArgs;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lio/minio/SetBucketReplicationArgs$Builder;->validateObjectLockToken(Ljava/lang/String;)V

    .line 57
    return-void
.end method
