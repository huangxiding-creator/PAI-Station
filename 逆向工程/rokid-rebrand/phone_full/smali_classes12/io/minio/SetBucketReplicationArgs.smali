.class public Lio/minio/SetBucketReplicationArgs;
.super Lio/minio/BucketArgs;
.source "SetBucketReplicationArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/SetBucketReplicationArgs$Builder;
    }
.end annotation


# instance fields
.field private config:Lio/minio/messages/ReplicationConfiguration;

.field private objectLockToken:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Lio/minio/BucketArgs;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lio/minio/SetBucketReplicationArgs;)Lio/minio/messages/ReplicationConfiguration;
    .locals 1
    .param p0, "x0"    # Lio/minio/SetBucketReplicationArgs;

    .line 26
    iget-object v0, p0, Lio/minio/SetBucketReplicationArgs;->config:Lio/minio/messages/ReplicationConfiguration;

    return-object v0
.end method

.method static synthetic access$002(Lio/minio/SetBucketReplicationArgs;Lio/minio/messages/ReplicationConfiguration;)Lio/minio/messages/ReplicationConfiguration;
    .locals 0
    .param p0, "x0"    # Lio/minio/SetBucketReplicationArgs;
    .param p1, "x1"    # Lio/minio/messages/ReplicationConfiguration;

    .line 26
    iput-object p1, p0, Lio/minio/SetBucketReplicationArgs;->config:Lio/minio/messages/ReplicationConfiguration;

    return-object p1
.end method

.method static synthetic access$100(Lio/minio/SetBucketReplicationArgs;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lio/minio/SetBucketReplicationArgs;

    .line 26
    iget-object v0, p0, Lio/minio/SetBucketReplicationArgs;->objectLockToken:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$102(Lio/minio/SetBucketReplicationArgs;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lio/minio/SetBucketReplicationArgs;
    .param p1, "x1"    # Ljava/lang/String;

    .line 26
    iput-object p1, p0, Lio/minio/SetBucketReplicationArgs;->objectLockToken:Ljava/lang/String;

    return-object p1
.end method

.method public static builder()Lio/minio/SetBucketReplicationArgs$Builder;
    .locals 1

    .line 39
    new-instance v0, Lio/minio/SetBucketReplicationArgs$Builder;

    invoke-direct {v0}, Lio/minio/SetBucketReplicationArgs$Builder;-><init>()V

    return-object v0
.end method


# virtual methods
.method public config()Lio/minio/messages/ReplicationConfiguration;
    .locals 1

    .line 31
    iget-object v0, p0, Lio/minio/SetBucketReplicationArgs;->config:Lio/minio/messages/ReplicationConfiguration;

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "o"    # Ljava/lang/Object;

    .line 74
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 75
    :cond_0
    instance-of v1, p1, Lio/minio/SetBucketReplicationArgs;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    .line 76
    :cond_1
    invoke-super {p0, p1}, Lio/minio/BucketArgs;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    return v2

    .line 77
    :cond_2
    move-object v1, p1

    check-cast v1, Lio/minio/SetBucketReplicationArgs;

    .line 78
    .local v1, "that":Lio/minio/SetBucketReplicationArgs;
    iget-object v3, p0, Lio/minio/SetBucketReplicationArgs;->config:Lio/minio/messages/ReplicationConfiguration;

    iget-object v4, v1, Lio/minio/SetBucketReplicationArgs;->config:Lio/minio/messages/ReplicationConfiguration;

    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    iget-object v3, p0, Lio/minio/SetBucketReplicationArgs;->objectLockToken:Ljava/lang/String;

    iget-object v4, v1, Lio/minio/SetBucketReplicationArgs;->objectLockToken:Ljava/lang/String;

    .line 79
    invoke-static {v3, v4}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    goto :goto_0

    :cond_3
    move v0, v2

    .line 78
    :goto_0
    return v0
.end method

.method public hashCode()I
    .locals 3

    .line 84
    invoke-super {p0}, Lio/minio/BucketArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget-object v1, p0, Lio/minio/SetBucketReplicationArgs;->config:Lio/minio/messages/ReplicationConfiguration;

    iget-object v2, p0, Lio/minio/SetBucketReplicationArgs;->objectLockToken:Ljava/lang/String;

    filled-new-array {v0, v1, v2}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method

.method public objectLockToken()Ljava/lang/String;
    .locals 1

    .line 35
    iget-object v0, p0, Lio/minio/SetBucketReplicationArgs;->objectLockToken:Ljava/lang/String;

    return-object v0
.end method
