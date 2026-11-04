.class public Lio/minio/SetBucketEncryptionArgs;
.super Lio/minio/BucketArgs;
.source "SetBucketEncryptionArgs.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lio/minio/SetBucketEncryptionArgs$Builder;
    }
.end annotation


# instance fields
.field private config:Lio/minio/messages/SseConfiguration;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 27
    invoke-direct {p0}, Lio/minio/BucketArgs;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lio/minio/SetBucketEncryptionArgs;)Lio/minio/messages/SseConfiguration;
    .locals 1
    .param p0, "x0"    # Lio/minio/SetBucketEncryptionArgs;

    .line 27
    iget-object v0, p0, Lio/minio/SetBucketEncryptionArgs;->config:Lio/minio/messages/SseConfiguration;

    return-object v0
.end method

.method static synthetic access$002(Lio/minio/SetBucketEncryptionArgs;Lio/minio/messages/SseConfiguration;)Lio/minio/messages/SseConfiguration;
    .locals 0
    .param p0, "x0"    # Lio/minio/SetBucketEncryptionArgs;
    .param p1, "x1"    # Lio/minio/messages/SseConfiguration;

    .line 27
    iput-object p1, p0, Lio/minio/SetBucketEncryptionArgs;->config:Lio/minio/messages/SseConfiguration;

    return-object p1
.end method

.method public static builder()Lio/minio/SetBucketEncryptionArgs$Builder;
    .locals 1

    .line 35
    new-instance v0, Lio/minio/SetBucketEncryptionArgs$Builder;

    invoke-direct {v0}, Lio/minio/SetBucketEncryptionArgs$Builder;-><init>()V

    return-object v0
.end method


# virtual methods
.method public config()Lio/minio/messages/SseConfiguration;
    .locals 1

    .line 31
    iget-object v0, p0, Lio/minio/SetBucketEncryptionArgs;->config:Lio/minio/messages/SseConfiguration;

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 3
    .param p1, "o"    # Ljava/lang/Object;

    .line 58
    if-ne p0, p1, :cond_0

    const/4 v0, 0x1

    return v0

    .line 59
    :cond_0
    instance-of v0, p1, Lio/minio/SetBucketEncryptionArgs;

    const/4 v1, 0x0

    if-nez v0, :cond_1

    return v1

    .line 60
    :cond_1
    invoke-super {p0, p1}, Lio/minio/BucketArgs;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    return v1

    .line 61
    :cond_2
    move-object v0, p1

    check-cast v0, Lio/minio/SetBucketEncryptionArgs;

    .line 62
    .local v0, "that":Lio/minio/SetBucketEncryptionArgs;
    iget-object v1, p0, Lio/minio/SetBucketEncryptionArgs;->config:Lio/minio/messages/SseConfiguration;

    iget-object v2, v0, Lio/minio/SetBucketEncryptionArgs;->config:Lio/minio/messages/SseConfiguration;

    invoke-static {v1, v2}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method public hashCode()I
    .locals 2

    .line 67
    invoke-super {p0}, Lio/minio/BucketArgs;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iget-object v1, p0, Lio/minio/SetBucketEncryptionArgs;->config:Lio/minio/messages/SseConfiguration;

    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method
